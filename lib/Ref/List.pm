package Ref::List;
# ABSTRACT: Punctuation-free dereferencing of arrayrefs and hashrefs

use strict;
use warnings;

use Carp qw(croak);
use Scalar::Util qw(reftype);

use base 'Exporter';

our (@EXPORT, @EXPORT_OK);

@EXPORT = qw(list);
@EXPORT_OK = qw(list);

sub list ($) {
	my $ref = shift;

	if (!defined($ref)) {
		return;
	}
	elsif ( reftype($ref) eq 'ARRAY') {
		return @$ref;
	}
	elsif ( reftype($ref) eq 'HASH') {
		return %$ref;
	}
	else {
		croak "Not a hashref or arrayref";
	}
}

1;

=head1 SYNOPSIS

  my $arrayref = [ qw(foo bar baz) ];
  print join '-', list $arrayref;  # foo-bar-baz

=func list (HASHREF|ARRAYREF)

Given a hash or array reference, dereference it and return its contents as a list.


