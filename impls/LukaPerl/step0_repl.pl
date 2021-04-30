# READ
sub READ {
    return @_[0];
}

# EVAL
sub EVAL {
    return @_[0];
}

# PRINT
sub PRINT {
    return @_[0];
}

# rep
sub rep {
    return PRINT(EVAL(READ(@_[0])));
}

# Main loop
while(1) {
    print "user> ";
    $input = <STDIN>;
    print rep($input);
}
