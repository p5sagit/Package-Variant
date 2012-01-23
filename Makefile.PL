use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Package-Variant',
  VERSION_FROM => 'lib/Package/Variant.pm',
  PREREQ_PM => {
    strictures => 1,
    Carp => 0,
  },
);
