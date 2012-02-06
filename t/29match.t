use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $x = ["a", "b", "c", "d"];
my $y = ["b", "c", "d", "e"];

my $m = match($x, $y);

is($m->[0], 1);
is($m->[1], 2);
