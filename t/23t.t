use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $m = [[1,2,3],
         [4,5,6]];
		 
my $t = t($m);
is($t->[1][0], 2);
is($t->[0][1], 4);
