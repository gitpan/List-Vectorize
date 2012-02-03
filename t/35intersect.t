use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

my $s1 = ["a", "b", "c", "d"];
my $s2 = ["b", "c", "d", "e"];
my $intersect = intersect($s1, $s2);

is($intersect->[0], "b");
