use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x1 = rep(1, 10);
my $x2 = rep([1..10], 10, 0);
$x2->[1][0] = 100;
my $x3 = rep([1..10], 10, 1);
$x3->[1][0] = 100;

is($x1->[0], 1);
is($x2->[0][0], 100);
is($x3->[0][0], 1);
