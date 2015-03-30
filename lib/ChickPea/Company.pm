package ChickPea::Company;

use Moose;

use ChickPea::Board;
use ChickPea::Consultant;

has name => ( is => 'ro', isa => 'Str', required => 1 );

has credits => ( is => 'rw', isa => 'Num', required => 1, default => sub {0} );

has boards =>
    ( is => 'rw', isa => 'HashRef[ChickPea::Board]', default => sub { {} } );

sub add_board {
    my ( $self, $board ) = @_;
    $self->boards->{ $board->name } = $board;
    return $self;
}

sub get_consultant {
    my ( $self, %args ) = @_;

    return ChickPea::Consultant->new( %args, company => $self );
}

__PACKAGE__->meta->make_immutable();

1;

