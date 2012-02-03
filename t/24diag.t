use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $m = [[1,2],[3,4]];
my $d = diag($m);

is($d->[0], 1);
is($d->[1], 4);
