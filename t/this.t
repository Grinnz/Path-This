use strict;
use warnings;
use Cwd ();
use File::Basename ();
use Test::More;

my $thisfile = Cwd::abs_path __FILE__;
my $thisdir = File::Basename::dirname($thisfile);
my $fakefile = eval { Cwd::abs_path 'fake-test-file.t' };
my $fakedir = File::Basename::dirname($fakefile);

use Path::This qw($THISDIR $THISFILE);

package My::Test::Package1;
use Path::This qw(THISDIR THISFILE);

package My::Test::Package2;
use Path::This qw(&THISDIR &THISFILE);

package main;

is $THISFILE, $thisfile, '$THISFILE';
is $THISDIR, $thisdir, '$THISDIR';
is My::Test::Package1::THISFILE, $thisfile, 'THISFILE';
is My::Test::Package1::THISDIR, $thisdir, 'THISDIR';
is My::Test::Package2::THISFILE, $thisfile, '&THISFILE';
is My::Test::Package2::THISDIR, $thisdir, '&THISDIR';

# line 30 "fake-test-file.t"
SKIP: { skip 'Failed to resolve nonexistent file', 6 unless length $fakefile;
  is $THISFILE, $thisfile, '$THISFILE';
  is $THISDIR, $thisdir, '$THISDIR';
  is My::Test::Package1::THISFILE, $thisfile, 'THISFILE';
  is My::Test::Package1::THISDIR, $thisdir, 'THISDIR';
  is My::Test::Package2::THISFILE, $fakefile, '&THISFILE';
  is My::Test::Package2::THISDIR, $fakedir, '&THISDIR';
}

done_testing;
