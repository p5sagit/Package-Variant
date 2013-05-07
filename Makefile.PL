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

  META_MERGE => {
    dynamic_config => 0,

    resources => {
      # r/w: p5sagit@git.shadowcat.co.uk:Package-Variant.git
      repository => 'git://git.shadowcat.co.uk/p5sagit/Package-Variant.git',
      homepage => 'http://git.shadowcat.co.uk/gitweb/gitweb.cgi?p=p5sagit/Package-Variant.git',
    },

    no_index => { package => [ 'string' ] },
  },
);
