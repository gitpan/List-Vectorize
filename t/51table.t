use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $a = ["a", "a", "a", "b", "b", "b", "c", "c"];
my $t = table($a);

is($t->{a}, 3);

my $b = [1, 1, 2, 2, 1, 1, 2, 2];
$t = table($a, $b);

is($t->{'a|1'}, 2);
