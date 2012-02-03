use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

my $x = [-5..5];
my $t = test($x, sub{$_[0] > 0});

is($t->[0], 0);
is($t->[8], 1);
