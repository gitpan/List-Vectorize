use strict;
use warnings;
use Test::More tests => 2;

BEGIN { use_ok('List::Rfunc') }

my $s1 = ["a", "b", "c", "d"];
my $s2 = ["b", "c", "d", "e"];
my $u = union($s1, $s2);

is(len($u), 5);
