use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $a = ["a", "b", "c", "d"];
my $b = [1, 2, 3, 4];

my $p1 = paste($a, $b);
my $p2 = paste($a, 1, "");
my $p3 = paste($a, $b, "-");

is($p1->[0], "a|1");
is($p2->[0], "a1");
is($p3->[0], "a-1");
