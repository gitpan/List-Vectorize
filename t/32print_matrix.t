use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

ok(print_matrix [[1,2],[3,4]])
