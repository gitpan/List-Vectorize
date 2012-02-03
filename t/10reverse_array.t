use strict;
use warnings;
use Test::More  tests => 2;

BEGIN { use_ok('List::Rfunc') }

my $x = [2, 5, 1, 3, 4, 7, 10];
my $o = reverse_array($x);

is($o->[2], 4)
