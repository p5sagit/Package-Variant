use strictures 1;
use Test::More eval { require namespace::clean } ? ()
  : (skip_all => 'namespace::clean needed for test');
{
  package CleanVariant;
  use Package::Variant
    importing => [
      'Carp' => ['croak'],
      'namespace::clean',
    ],
  ;

  sub make_variant {
    my ($class, $target_package, %arguments) = @_;
    my $croak = $target_package->can('croak');
    ::is $croak, \&Carp::croak, 'sub exists while building';
  }
}
my $variant = CleanVariant->build_variant;
is $variant->can('croak'), undef, 'sub cleaned after building';
done_testing;
