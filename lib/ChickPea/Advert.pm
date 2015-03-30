package ChickPea::Advert;

use Moose; # gives strict and warnings by default

has id         => ( is => 'ro', isa => 'Num',                  required => 1 );
has consultant => ( is => 'ro', isa => 'ChickPea::Consultant', required => 1 );
has title      => ( is => 'rw', isa => 'Str',                  required => 1 );
has body       => ( is => 'rw', isa => 'Str',                  required => 1 );
has html_body =>
    ( is => 'rw', isa => 'Str', lazy => 1, builder => '_build_html_body' );

sub cost {1}

sub new_deluxe {
    my $class = shift;
    require ChickPea::Advert::Deluxe;
    return ChickPea::Advert::Deluxe->new(@_);
}


sub company {
    my $self = shift;
    return $self->consultant->company;
}

sub _build_html_body {
    my $self = shift;

    my $body = $self->body;
    my @lines = split /\n/, $body;

    my $html = '<h2>' . $self->title . "</h2>\n";
    foreach my $line (@lines) {
        $html .= $line ? "<p>$line</p>\n" : "<br>\n";
    }

    return $html;
}

__PACKAGE__->meta->make_immutable();

1; # all Perl modules should return a true value

