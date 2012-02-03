use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

is(geometric_mean([2, 4, 8]), 4);
