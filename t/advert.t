use strict;
use warnings;

use Test::More;
use Test::Exception;

use ChickPea::Advert;
use ChickPea::Company;
use ChickPea::Consultant;

my $pkg = 'ChickPea::Advert';

dies_ok { $pkg->new() } "dies with no arguments";

ok my $consultant = ChickPea::Consultant->new(
    name    => 'Ralph Recruiter',
    email   => 'ralph@recruitco.com',
    company => ChickPea::Company->new( name => 'RecruitCo' ),
    ),
    "create consultant";

subtest basic => sub {

    ok my $advert = $pkg->new(
        id         => 123,
        consultant => $consultant,
        title      => "Astronaut Required (Part Time)",
        body =>
            qq{Astronaut required for exciting new missions from Croydon Space Centre.

Must be available weekends.
},
        ),
        "created advert";

    ok my $html_body = $advert->html_body, "got HTML body";

    is $html_body, q{<h2>Astronaut Required (Part Time)</h2>
<p>Astronaut required for exciting new missions from Croydon Space Centre.</p>
<br>
<p>Must be available weekends.</p>
}, "HTML ok";

};

subtest deluxe => sub {

    ok my $deluxe_advert = ChickPea::Advert->new_deluxe(
        id         => 2500,
        consultant => $consultant,
        title      => "Alpaca wanted",
        body       => q{Alpaca wanted for friendly farm.

NO LLAMAS!!!!!!
}
        ),
        "new deluxe ad";

    isa_ok $deluxe_advert, "ChickPea::Advert::Deluxe";

    ok my $html_body = $deluxe_advert->html_body, "got HTML body";

    is $html_body, q{<h1>Alpaca wanted</h1>
<p>Alpaca wanted for friendly farm.</p>
<br>
<p>NO LLAMAS!!!!!!</p>
<br>
<p>FREE spoon with every application!</p>}, "html body ok";

};

done_testing();

