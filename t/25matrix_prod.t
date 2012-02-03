use strict;
use warnings;
use Test::More tests => 9;

BEGIN { use_ok('List::Rfunc') }

my $m = [[1,2],[3,4]];
my $m2 = matrix_prod($m, $m);

is($m2->[0][0], 7);
is($m2->[0][1], 10);
is($m2->[1][0], 15);
is($m2->[1][1], 22);

$m2 = matrix_prod($m, $m, $m);

is($m2->[0][0], 37);
is($m2->[0][1], 54);
is($m2->[1][0], 81);
is($m2->[1][1], 118);
