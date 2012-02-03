use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $x = [1..10];
my $t1 = ["a", "a", "a", "a", "a", "b", "b", "b", "b", "b"];
my $t2 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0];

my $a = tapply($x, $t1, sub {max(\@_)});
my $b = tapply($x, $t1, $t2, sub{sum(\@_)});

is($a->{"a"}, 5);
is($b->{"a|1"}, 9);
