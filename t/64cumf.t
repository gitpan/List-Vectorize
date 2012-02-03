use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x = [1..10];

my $c = cumf($x);

is($c->[2], 3);

$c = cumf($x, \&sum);
is($c->[2], 6);

$c = cumf($x, sub{max($_[0])/sum($_[0])});
is($c->[2], 0.5);
