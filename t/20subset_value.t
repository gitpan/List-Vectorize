use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x = [10..20];
subset_value($x, [1, 2, 5], 0);
is($x->[1], 0);

$x = [10..20];
subset_value($x, [1, 2, 5], [1, 1, 1]);
is($x->[1], 1);

$x = [10..20];
subset_value($x, sub {$_[0] > 15}, 2);
is($x->[10], 2);
