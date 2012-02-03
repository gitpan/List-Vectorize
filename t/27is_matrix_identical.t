use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

my $m1 = [[1,2],[3,4]];
my $m2 = [[1,2],[3,4]];

my $is = is_matrix_identical($m1, $m2);
is($is, 1);
