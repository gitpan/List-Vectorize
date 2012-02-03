use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $a = initial_array(10);
my $b = initial_array(10, 1);
my $c = initial_array(10, sub {2});

is($a->[0], undef);
is($b->[0], 1);
is($c->[0], 2);
