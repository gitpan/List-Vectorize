use strict;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $a = [-5..5];
my $b = sapply($a, \&abs);
my $c = sapply($a, sub {$_[0]**2});

is($b->[1], 4);
is($c->[4], 1);
