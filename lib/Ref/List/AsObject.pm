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
	
	if ( ref($ref) eq "Data::AsObject::Array" ) 
	{
		my @array;
		foreach  my $value (@$ref) 
		{
			$Data::AsObject::__check_type->($value) ? push @array, dao $value : push @array, $value;
		}
		return @array;
	}
	elsif ( ref($ref) eq "Data::AsObject::Hash" )
	{
		my %hash;
		while ( my ($key, $value) = each %$ref )
		{
			$Data::AsObject::__check_type->($value) ? $hash{$key} = dao $value : $hash{$key} = $value;
		}
		return %hash;
	}
	else 
	{
		return Ref::List::list($ref);
	}
}

1;

=head1 SYNOPSIS

  use Data::AsObject qw(dao);
  use Ref::List::AsObject qw(list);

  my $data = dao { 
  	countries => [
		{ name => 'Bulgaria', language = 'Bulgarian' },
		{ name => 'Germany', language = 'German' },
	],
  };

  print $_->name for list $data->countries;

=head1 DESCRIPTION

This module provides similar functionality to L<Ref::List>, but if the argument to C<list> is a C<Data::AsObject::Hash> or C<Data::AsObject::Array>, the items in the resulting array will autmatically be blessed into the respective L<Data::AsObject> class (where possible) to preserve the object-oriented access syntax.

=func list (HASHREF|ARRAYREF)

Given a hash or array reference, dereference it and return its contents as a list.



