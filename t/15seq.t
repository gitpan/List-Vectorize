use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $s1 = seq(1, 10);
my $s2 = seq(1, 10, 2);
my $s3 = seq(5, -5, 3);

is($s1->[2], 3);
is($s2->[2], 5);
is($s3->[2], -1);
