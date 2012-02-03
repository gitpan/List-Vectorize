use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Rfunc') }

ok(rbinom(10));
ok(rbinom(10, 0.1));
