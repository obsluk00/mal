#!/usr/bin/perl
use strict;
use warnings;

use lib 'F:\SICP\Implementation\mal\impls\LukaPerl';
use reader;
use printer;

# READ
sub READ {
    ReaderFunctionality::read_str($_[0]);
}

# EVAL
sub EVAL {
    return @_;
}

# PRINT
sub PRINT {
    return Printer::pr_str(@_);
}

# rep
sub rep {
    return PRINT(EVAL(READ($_[0])));
}

# Main loop
while(1) {
    print "user> ";
    my $input = <STDIN>;
    print rep($input) . "\n";
}
