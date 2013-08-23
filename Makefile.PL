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
    'meta-spec' => { version => 2 },
    dynamic_config => 0,

    resources => {
      # r/w: p5sagit@git.shadowcat.co.uk:Package-Variant.git
      repository => {
        url => 'git://git.shadowcat.co.uk/p5sagit/Package-Variant.git',
        web => 'http://git.shadowcat.co.uk/gitweb/gitweb.cgi?p=p5sagit/Package-Variant.git',
        type => 'git',
      },
      bugtracker => {
          mailto => 'bug-Package-Variant@rt.cpan.org',
          web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Package-Variant',
      },
    },
    no_index => { package => [ 'string' ] },
  },
);
