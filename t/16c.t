use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $a = c(1, 2, 3);
my $b = c([1..5], [6..8]);
my $c = c(4, [3..7], 7);

is($a->[0], 1);
is($b->[6], 7);
is($c->[2], 4); 
