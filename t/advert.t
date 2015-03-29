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

is $html_body, q{<h1>Astronaut Required (Part Time)</h1>
<p>Astronaut required for exciting new missions from Croydon Space Centre.</p>
<br>
<p>Must be available weekends.</p>
}, "HTML ok";

done_testing();

