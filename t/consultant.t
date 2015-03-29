use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Company;
use ChickPea::Consultant;

my $pkg = 'ChickPea::Consultant';

dies_ok { $pkg->new() } "dies with no arguments";

ok my $consultant = $pkg->new(
    name    => 'Freddie Findajob',
    email   => 'freddie@jobfinders.com',
    company => ChickPea::Company->new( name => 'Jobfinders' )
    ),
    "created consultant";

done_testing;

