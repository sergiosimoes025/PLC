use 5.016002;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'My::PrefixTree',
    VERSION_FROM      => 'lib/My/PrefixTree.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/My/PrefixTree.pm', # retrieve abstract from module
       AUTHOR         => 'Sérgio  Simões <Perez_25@apple.com>') : ()),
);
