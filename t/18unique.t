use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

my $x = ["a", "a", "b", "b", "c"];
my $y = unique($x);

is($y->[1], "b");
