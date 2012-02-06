use strict;
use warnings;
use Test::More tests => 7;

BEGIN { use_ok('List::Vectorize') }

my $x = [1..4];
my $y = [1..4];
my $z = outer($x, $y);

is($z->[0][0], 1);
is($z->[1][2], 6);
is($z->[3][2], 12);

$z = outer($x, $y, sub {$_[0]**2 + $_[1]});

is($z->[0][0], 2);
is($z->[1][2], 7);
is($z->[3][2], 19);
