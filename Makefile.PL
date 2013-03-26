use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

(do 'maint/Makefile.PL.include' or die $@) unless -f 'META.yml';

WriteMakefile(
  NAME => 'Package::Variant',
  VERSION_FROM => 'lib/Package/Variant.pm',
  CONFIGURE_REQUIRES => {
    'ExtUtils::MakeMaker' => '6.55_01', # for BUILD_REQUIRES
  },
  BUILD_REQUIRES => { 'Test::Fatal' => 0 },
  PREREQ_PM => {
    strictures => 1,
    Carp => 0,
    'Import::Into' => 1,
    'Module::Runtime' => '0.013',
  },
);
