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

#test k_reversal
#my @ktest=0..15;
#@ktest=reverse(0..15);

#print Dumper \@ktest;
#@ktest=k_reversal(\@ktest,2);
#print Dumper \@ktest;

sub greedy_sort {
	my $ref_p=shift;
	my $d=0;	
	for(my $i=0;$i<0+@{$ref_p};$i++) {
		my $k=@{$ref_p}[$i];
		print "k sort (i,k,d)\t$i\t$k\t$d\n";
		if(abs($k)!=$i+1) {
			my @temp=k_reversal($ref_p,$i);
			$ref_p=\@temp;
			$d+=1;	
			print_rev( $ref_p);
		}
		elsif(abs($k)!=$k) {
			@{$ref_p}[$i]=@{$ref_p}[$i]*-1;
			$d+=1;
			print_rev($ref_p);
		}
	}
	return $d;
}


sub k_reversal {
	my $ref_p=shift;
	my $s=shift;#search
	my $l=0+@{$ref_p};#len
	for(my $i=$s;$i<0+$l;$i++) {
		my $k=@{$ref_p}[$i];
		print "k_reversal (k,s) $k\t$s\n";
		if(abs($k)==$s+1) {
			print "$s,$i,$l\n";
			my @temp=reverse(@{$ref_p}[$s..$i]);
			foreach my $x (@temp) { $x = $x * -1; }	
			return @{$ref_p}[0..$s-1],@temp,@{$ref_p}[$i+1..$l-1];

		} 
	}
}


sub print_rev {
	my $ref_p=shift;
	print "(";
	for (my $i=0;$i<0+@{$ref_p};$i++) {
		print @{$ref_p}[$i]." ";
	}
	print ")\n";
}
