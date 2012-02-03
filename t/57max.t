use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

is(max([1..10]), 10);
