use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x = [1,1,2,2,2,3,3,3,3,4];

my $o1 = rank($x);

is($o1->[0], 1.5);
is($o1->[2], 4);
is($o1->[6], 7.5);
