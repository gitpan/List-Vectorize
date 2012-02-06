use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Vectorize') }

my $x = [1..10];
my $w = which(test($x, sub {$_[0] > 5}));

is($w->[0], 5);
