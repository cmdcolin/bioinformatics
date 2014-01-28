use strict;
use Data::Dumper;
my $line=<>;
print $line;
$line=~s/\((.*)\)/$1/;
print $line;
my @p=split(' ',$line);
print Dumper \@p;
my $d=greedy_sort(\@p);
print "$d\n";

my $ktest=rev([0..15]);
sub greedy_sort {
	my $ref_p=shift;
	my $approxReversalDistance=0;	
	for(my $i=0;$i<0+@{$ref_p};$i++) {
		my $k=@{$ref_p}[$i];
		if(abs($k)!=$i) {
		}		
		print "$i\t$r\n";
	}
	return 0;
}


sub k_reversal {
	my $ref_p=shift;
	my $s=shift;#search
	my $l=0+@{$ref_p};#len
	for(my $i=$s;$i<0+$l;$i++) {
		my $k=@{$ref_p}[$i];
		if($k==$s) {
			return @{$ref_p}[0..$s].rev(@{$ref_p}[$s..$k}).@{$ref_p}[$k..$l];
		} 
	}
}
