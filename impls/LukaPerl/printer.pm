use strict;
use warnings;

package Printer {
    sub pr_str {
        # TODO: assigning argument array is wonky af. adds another layer
        my $form = $_[0];
        my $res = '';
        # check if theres more than 1 element (do we need to set parentheses?)
        if (ref($form)) {
            $res = '(';
            foreach my $i (@$form){
                my $substring = pr_str($i);
                $res = $res . "$substring ";
            }
            chop($res);
            return $res . ')';
        } else {
            return $form;
        }
    }
}
1;
