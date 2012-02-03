use strict;
use warnings;
use Test::More tests => 4;

BEGIN { use_ok('List::Rfunc') }

my $x = [1..10];
ok(sample($x, 5));
ok(sample($x, 10, "replace" => 0));
ok(sample($x, 10, "p"=>rep(1, 10)));
