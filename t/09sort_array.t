use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x = [2, 5, 1, 3, 4, 7, 10];

my $o1 = sort_array($x);
my $o2 = sort_array($x, sub {$_[1] <=> $_[0]});
my $o3 = sort_array($x, sub {$_[0] cmp $_[1]});

is($o1->[0], 1);
is($o2->[0], 10);
is($o3->[1], 10);
