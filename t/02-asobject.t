#!perl -T

use strict;
use warnings;

use Data::Dumper qw(Dumper);

use Test::More;
use Test::Exception;
use Ref::List::AsObject qw(list);

SKIP: {
	eval { require Data::AsObject };
	skip "Data::AsObject not installed" if $@;
	
	# repeat Ref::List tests
	my $undef;
	my @undefref = list $undef;
	is ($undefref[0], undef, 'Ref::List::AsObject dereferencing undef');

	# dereferncing an array
	my $arrayref = [ qw(foo bar baz) ];
	my @arrayref = list $arrayref;
	is ($arrayref[0], 'foo', 'Ref::List::AsObject dereferncing an array');

	# dereferncing a hash
	my $hashref = { color => 'green', side => 'other' };
	my %hashref = list $hashref;
	is ($hashref{color}, 'green', 'Ref::List::AsObject dereferncing a hash');

	# dereferencing an invalid argument
	my $subref = sub { return };
	dies_ok { list $subref } 'Ref::List::AsObject dereferencing an invalid argument';
	
	# test compatibility with Data::AsObject
	my $data = Data::AsObject::dao {
		spain => [ 
			{ name => 'spanish', numbers => ["uno", "dos", "tres", "cuatro"] },
			{ name => 'catalan', numbers => ["un", "dos", "tres", "quatre"] },
		],
	};

	# dereferencing Data::AsObject::Array
	my @spanish_catalan = map { $_->name } list $data->spain;
	my $spanish_catalan = join "-", @spanish_catalan;
	is ($spanish_catalan, 'spanish-catalan', 'Ref::List::AsObject dereferencing Data::AsObject::Array');

	# dereferencing Data::AsObject::Hash
	my %spanish = list $data->spain(0);
	my $uno = join "-", $spanish{'numbers'}->get(0);
	is ($uno, 'uno', 'Ref::List::AsObject dereferencing Data::AsObject::Hash');
}


done_testing();
