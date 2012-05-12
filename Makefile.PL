use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
  NAME => 'Package-Variant',
  VERSION_FROM => 'lib/Package/Variant.pm',
  PREREQ_PM => {
    strictures => 1,
    Carp => 0,
    'Import::Into' => 1,
    'Module::Runtime' => '0.013',
  },
);
