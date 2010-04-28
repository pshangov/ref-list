#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Ref::List' );
}

diag( "Testing Ref::List $Ref::List::VERSION, Perl $], $^X" );

