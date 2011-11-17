package Package::Variant;

use strictures 1;

our %Variable;

sub import {
  my $target = caller;
  my $me = shift;
  my $last = (split '::', $target)[-1];
  my $anon = 'A000';
  my $variable = $target;
  my %args = @_;
  no strict 'refs';
  $Variable{$variable} = {
    anon => $anon,
    args => \%args,
    subs => {
      map +($_ => sub {}), @{$args{subs}||[]},
    },
  };
  *{"${target}::import"} = sub {
    my $target = caller;
    no strict 'refs';
    *{"${target}::${last}"} = sub {
      $me->build_variant_of($variable, @_);
    };
  };
  my $subs = $Variable{$variable}{subs};
  foreach my $name (keys %$subs) {
    *{"${target}::${name}"} = sub {
      goto &{$subs->{$name}}
    };
  }
  *{"${target}::install"} = sub {
    goto &{$Variable{$variable}{install}};
  }
}

sub build_variant_of {
  my ($me, $variable, @args) = @_;
  my $variant_name = "${variable}::_Variant_".++$Variable{$variable}{anon};
  my @to_import = keys %{$Variable{$variable}{args}{importing}||{}};
  my $setup = join("\n", "package ${variant_name};", (map "use $_;", @to_import), "1;");
  eval $setup
    or die "evaling ${setup} failed: $@";
  my $subs = $Variable{$variable}{subs};
  local @{$subs}{keys %$subs} = map $variant_name->can($_), keys %$subs;
  local $Variable{$variable}{install} = sub {
    my ($name, $ref) = @_;
    no strict 'refs';
    *{"${variant_name}::${name}"} = $ref;
  };
  $variable->make_variant($variant_name, @args);
  return $variant_name;
}

1;
