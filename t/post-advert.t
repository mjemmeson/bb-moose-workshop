use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Board;
use ChickPea::Company;

ok my $company = ChickPea::Company->new( name => 'PeoplePlacers' ), "company";

ok $company->add_board( ChickPea::Board->new( name => "Cool Jobs and Stuff" ) ),
    "added board";

ok $company->credits(20), "set credits";

ok my $consultant = $company->get_consultant(
    name  => 'Freddie Findajob',
    email => 'freddie@jobfinders.com',
    ),
    "got consultant";

dies_ok {
    $consultant->post_advert(
        id    => 999,
        title => 'Pearl developer sought',
        body  => 'My client is looking for an oyster',
        board => 'wrong_board'
        )
}
"dies with wrong board";

ok $consultant->post_advert(
    id    => 999,
    title => 'Pearl developer sought',
    body  => 'My client is looking for an oyster',
    board => 'Cool Jobs and Stuff'
    ),
    "post advert ok";

is $company->credits, 19, "company now has 19 credits";

is scalar( @{ $company->boards->{'Cool Jobs and Stuff'}->adverts } ), 1,
    "one advert on board";

ok $company->credits(1), "set credits to 1";

dies_ok {
    $consultant->post_advert(
        id     => 999,
        title  => 'Pearl developer sought',
        body   => 'My client is looking for an oyster',
        board  => 'Cool Jobs and Stuff',
        deluxe => 1,
        )
}
"dies with too few credits";

done_testing();

