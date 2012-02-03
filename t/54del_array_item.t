use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $x = [1..10];

del_array_item($x, 2);
is($x->[2], 4);

del_array_item($x, [0, 1]);
is($x->[2], 6);
