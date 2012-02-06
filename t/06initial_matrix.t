use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Vectorize') }

my $a = initial_matrix(10, 10);
my $b = initial_matrix(10, 10, 1);
my $c = initial_matrix(10, 10, sub {2});

is($a->[0][0], undef);
is($b->[0][0], 1);
is($c->[0][0], 2);
