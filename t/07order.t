use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Vectorize') }

my $x = [2, 5, 1, 3, 4, 7, 10];

my $o1 = order($x);
my $o2 = order($x, sub {$_[1] <=> $_[0]});
my $o3 = order($x, sub {$_[0] cmp $_[1]});

is($o1->[0], 2);
is($o2->[0], 6);
is($o3->[1], 6);
