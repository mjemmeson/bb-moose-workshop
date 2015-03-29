use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Company;

dies_ok { ChickPea::Company->new() } "dies with no arguments";

ok my $company = ChickPea::Company->new( name => 'GettaJob' ),
    "created company";

is $company->credits, 0, "no credits by default";

ok my $consultant = $company->get_consultant(
    name  => 'Peter Placement',
    email => 'peter@gettajob.com'
    ),
    "get_consultant()";

done_testing();

