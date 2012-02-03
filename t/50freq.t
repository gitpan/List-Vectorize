use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $a = ["a", "a", "a", "b", "b", "b", "c", "c"];
my $t = freq($a);

is($t->{a}, 3);

my $b = [1, 1, 2, 2, 1, 1, 2, 2];
$t = freq($a, $b);

is($t->{'a|1'}, 2);
