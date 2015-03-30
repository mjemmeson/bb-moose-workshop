package ChickPea::Advert::Deluxe;

use Moose;

extends 'ChickPea::Advert';

override cost => sub {2};

around _build_html_body => sub {
    my ( $orig, $self, @args ) = @_;

    my $html_body = $self->$orig(@args);

    $html_body =~ s{<(/?)h2>}{<$1h1>}g;

    $html_body .= "<br>\n<p>FREE spoon with every application!</p>";

    return $html_body;
};

__PACKAGE__->meta->make_immutable();

1;

