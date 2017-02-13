use strict;
use warnings;
use Test;

BEGIN { plan tests => 4 }

my $commonResult = [-1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];

joinOkay($commonResult, IBwWG::Flattener::flatten(-1, 0, 1, 2, [3], [4, [5, 6]], [[7]], 8, 9, [10, 11]));
joinOkay($commonResult, IBwWG::Flattener::flatten([[[-1]]], 0, 1, 2, [3], [4, [5, 6]], [[7], [8, [9]]], 10, 11));
joinOkay($commonResult, IBwWG::Flattener::flatten([[-1, [[[0]]]]], 1, 2, [3], [4, [[5], 6]], [[7], [8, [9]]], 10, [[[11]]]));
joinOkay($commonResult, IBwWG::Flattener::flatten([-1, 0, [1]], [2, [3, [4, [5, [6, [7, [8, [9, 10, [11]]]]]]]]]));

# Compare join results, for clearest debugging messages on failed tests.
sub joinOkay {
	my ($left, @right) = @_;
	ok(join(',', @$left), join(',', @right));
}




package IBwWG::Flattener;

sub flatten {
	my @data = @_;
	my @flattened = ();
	for (@data) {
		if (ref($_)) {
			push @flattened, flatten(@{$_});
		} else {
			push @flattened, $_;
		}
	}
	return @flattened;
}


