use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $x = [10..20];
my $a = subset($x, [1, 2, 5]);
my $b = subset($x, sub {$_[0] > 15});

is($a->[0], 11);
is($b->[0], 16);
