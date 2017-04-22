use strict;
use warnings;




my @matrix;
use Data::Dumper qw(Dumper);
print Dumper \@matrix;


open(my $input, $ARGV[0]);
my $i=0;
while(my $line=<$input>) {
	chomp($line);
	my @val=split(' ',$line);
	$matrix[0][$i]=$val[1];
	$matrix[$i][0]=$val[1];
	$i++;
}

print Dumper \@matrix;

