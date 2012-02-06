use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok('List::Vectorize') }

my $a = {"a" => 1,
         "b" => 2,
		 "c" => 3,
		 "d" => 4,};
		 
my $b = happly($a, sub{sqrt($_[0])});
my $c = happly($a, sub {$_[0] + 2});

is($b->{"d"}, 2);
is($c->{"b"}, 4);
 