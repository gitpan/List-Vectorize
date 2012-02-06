use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $a = [1..10];
my $b = [11..20];

my $c = mapply($a, $b, sub{$_[0] + $_[1]});
my $d = mapply($a, $b, sub{scalar(@_)});

is($c->[2], 16);
is($d->[1], 2);
