#!/usr/bin/perl
use strict;
use warnings;

use lib '/home/luka/PycharmProjects/mal/impls/LukaPerl';
use reader;
use printer;
use Switch;

# simple arithmetic environment
my %repl_env = ('+' => sub { return $_[0] + $_[1];},
             '-' => sub { return $_[0] - $_[1];},
             '*' => sub { return $_[0] * $_[1];},
             '/' => sub { return $_[0] / $_[1];},);

# READ
sub READ {
    ReaderFunctionality::read_str($_[0]);
}

# EVAL
sub EVAL {
    my $form = $_[0];
    my %env = $_[1];

    if (ref($form)) {
        return eval_ast($form, %env);
    } else {
        my @evaled = eval_ast($form, %env);
        my $function = shift(@evaled);
        return $env{$function}(@evaled);
    }
}

sub eval_ast {
    my $form = $_[0];
    my %env = $_[1];
    if (ref($form)) {
        my @res;
        foreach my $i (@$form){
            push(@res, eval_ast($i, %env));
        }
        return @res;
    } else {
        return $env{$form};
    }
}

# PRINT
sub PRINT {
    return Printer::pr_str(@_);;
}

# rep
sub rep {
    return PRINT(EVAL(READ($_[0]), %repl_env));
}

# Main loop
while(1) {
    print "user> ";
    my $input = <STDIN>;
    print rep($input) . "\n";
}
