use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Company;

ok my $company = ChickPea::Company->new( name => 'PeoplePlacers' ), "company";

ok my $consultant = $company->get_consultant(
    name  => 'Freddie Findajob',
    email => 'freddie@jobfinders.com',
    ),
    "got consultant";

done_testing();

