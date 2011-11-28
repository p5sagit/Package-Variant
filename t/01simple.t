use strictures 1;
use Test::More;
use Test::Fatal;
use Package::Variant ();

my @DECLARED;

BEGIN {
  package TestSugar;
  use Exporter;
  our @EXPORT_OK = qw( declare );
  sub declare { push @DECLARED, [@_] }
  $INC{'TestSugar.pm'} = __FILE__;
}

BEGIN {
  package TestVariable;
  use Package::Variant
    importing => { 'TestSugar' => [qw( declare )] },
    subs      => [qw( declare )];
  sub make_variant {
    my ($class, $target, @args) = @_;
    ::ok(__PACKAGE__->can('install'), 'install() is available')
      or ::BAIL_OUT('install() subroutine was not exported!');
    ::ok(__PACKAGE__->can('declare'), 'declare() import is available')
      or ::BAIL_OUT('proxy declare() subroutine was not exported!');
    declare target => $target;
    declare args   => [@args];
    declare class  => $class->_test_class_method;
    install target => sub { $target };
    install args   => sub { [@args] };
  }
  sub _test_class_method {
    return shift;
  }
  $INC{'TestVariable.pm'} = __FILE__;
}

use TestVariable;

my $variant = TestVariable(3..7);

ok defined($variant), 'new variant is a defined value';
ok length($variant), 'new variant has length';
is $variant->target, $variant, 'target was new variant';
is_deeply $variant->args, [3..7], 'correct arguments received';

is_deeply shift(@DECLARED), [target => $variant],
  'target passed via proxy';
is_deeply shift(@DECLARED), [args => [3..7]],
  'arguments passed via proxy';
is_deeply shift(@DECLARED), [class => $variant],
  'class method resolution';
is scalar(@DECLARED), 0, 'proxy sub called right amount of times';

done_testing;
