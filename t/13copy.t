use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $x = [1..10];
my $y = copy($x);
$y->[0] = 100;

is($x->[0], 1);
is($y->[1], 2);
