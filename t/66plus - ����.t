use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $x = [5, 10, 15, 20, 25];
my $y = [1..5];
my $z = 2;

my $r1 = divide($x, $y);
my $r2 = divide($x, $y, $z);

is($r1->[1], 5);
is($r2->[1], 2.5);
