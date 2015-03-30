package ChickPea::Board;

use Moose;

has name => ( is => 'ro', isa => 'Str', required => 1 );

has adverts =>
    ( is => 'rw', isa => 'ArrayRef[ChickPea::Advert]', default => sub { [] } );

__PACKAGE__->meta->make_immutable();

1;

