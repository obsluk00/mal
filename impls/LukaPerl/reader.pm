package ReaderFunctionality;

use strict;
use warnings;
use Switch;

# runs parsing of string
sub read_str {
    my @tokens = tokenize($_[0]);
    my $reader = new Reader(@tokens);
    return read_form($reader);
}

# matches a given string and returns list of tokens
sub tokenize {
    my $string = $_[0];
    my @tokens = $string =~ /[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('"`,;)]*)/g;
    if (@tokens) {
        return @tokens;
    } else {
        print "Syntax error";
    }
}

sub read_form {
    my $reader = $_[0];
    my $firstToken = $reader->next();
    switch(substr($firstToken, 0, 1)){
        case "("        { return read_list($reader) }
        else            { return read_atom($firstToken) }
    }
}

# TODO: add parentheses check
sub read_list {
    my $reader = $_[0];
    my @res = ();
    until ($reader->peek() =~ /\Q)/) {
        push(@res, read_form($reader));
    }
    return [@res];
}

sub read_atom {
    my $token = $_[0];
    return $token;
}

{
    # reader class
    package Reader;

    # constructor taking list of tokens
    sub new {
        my ($class, @args) = @_;
        my $self = {
            _position => 0,
            _tokens   => [@args],
        };
        bless $self, $class;
        return $self;
    }

    # returns current token and increments position
    sub next {
        my ($self) = @_;
        $self->{_position}++;
        return $self->{_tokens}[$self->{_position} - 1];
    }

    # returns current token
    sub peek {
        my ($self) = @_;
        return $self->{_tokens}[$self->{_position}];
    }
}
1;
