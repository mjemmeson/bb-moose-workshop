package ChickPea::Consultant;

use Moose;

use Carp;
use ChickPea::Advert;
use ChickPea::Company;

has name  => ( is => 'ro', isa => 'Str', required => 1 );
has email => ( is => 'ro', isa => 'Str', required => 1 );

has company => ( is => 'ro', isa => 'ChickPea::Company', required => 1 );

sub post_advert {
    my ( $self, %args ) = @_;

    my $board_name = delete $args{board};

    my $board = $self->company->boards->{$board_name}
        or croak "Not subscribed to '$board_name'";

    my $deluxe = delete $args{deluxe};

    $args{consultant} = $self;

    my $ad
        = $deluxe
        ? ChickPea::Advert->new_deluxe(%args)
        : ChickPea::Advert->new(%args);

    $self->company->credits( $self->company->credits - $ad->cost );

    if ( $self->company->credits < 0 ) {
        croak "Not enough credits";
    }

    push @{ $board->adverts }, $ad;

    return $ad;
}

__PACKAGE__->meta->make_immutable();

1;

