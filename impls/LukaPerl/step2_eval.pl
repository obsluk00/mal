#!/usr/bin/perl
use strict;
use warnings;

use lib 'F:\SICP\Implementation\mal\impls\LukaPerl';
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
    my $form = shift;
    my %env = @_;

    if (ref($form) eq 'ARRAY') {
        if (ref($form)) {
            my @evaled = eval_ast($form, %env);
            my $function = shift(@evaled);
            return $env{$function}(@evaled);
        } else {
            return $form;
        }
    } else {
        return eval_ast($form, %env);
    }

}

sub eval_ast {
    my $form = shift;
    my %env = @_;
    switch (ref($form)) {
        case 'SCALAR' { return $env{$form} }
        case 'ARRAY'  { my @res;
                        foreach my $i (@$form) {
                            push(@res, EVAL($i, %env))
                        }
                        return @res }
        else          { return $form }
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
