package Ref::List::AsObject;
# ABSTRACT: Dereference Data::AsObject arrays and hashes

use strict;
use warnings;

use Data::AsObject qw(dao);
use Ref::List qw();

use base 'Exporter';

our @EXPORT    = qw(list);
our @EXPORT_OK = qw(list);

sub list ($) 
{
	my $ref = shift;
	
	if ($ref->isa('Data::AsObject::ARRAY')) 
	{
		return dao @$ref;
	}
	elsif ($ref->isa('Data::AsObject::HASH')) 
	{
		return;
	} 
	else 
	{
		return Ref::List::list($ref);
	}
}

1;

=head1 SYNOPSIS

  my $arrayref = [ qw(foo bar baz) ];
  print join '-', list $arrayref;  # foo-bar-baz

=func list (HASHREF|ARRAYREF)

Given a hash or array reference, dereference it and return its contents as a list.



