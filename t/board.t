use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Board;

my $pkg = 'ChickPea::Board';

dies_ok { $pkg->new() } "dies with no arguments";

ok my $board = $pkg->new( name => 'Cool Jobs and Stuff' ), "new board";

is_deeply $board->adverts, [], "no adverts";

done_testing;

