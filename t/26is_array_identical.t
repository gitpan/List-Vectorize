use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Vectorize') }

my $a1 = [1, 2, 3];
my $a2 = [1, 2, 3];

my $is = is_array_identical($a1, $a2);
is($is, 1);
