use strict;
use Data::Dumper;
my $verbose=0;
my $line=<>;
$line=~s/\((.*)\)/$1/;
my @p=split(' ',$line);
my $d=greedy_sort(\@p);
print "approxReversalDistance\t$d\n";

#test k_reversal
#my @ktest=0..15;
#@ktest=reverse(0..15);

#print Dumper \@ktest;
#@ktest=k_reversal(\@ktest,2);
#print Dumper \@ktest;

sub greedy_sort {
	my $ref_p=shift;
	my $d=0;
	#print_rev($ref_p);
	for(my $i=0;$i<0+@{$ref_p};$i++) {
		my $k=@{$ref_p}[$i];
		print "k sort (i,k,d)\t$i\t$k\t$d\n" if $verbose;
		if(abs($k)!=$i+1) {
			my @temp=k_reversal($ref_p,$i);
			$ref_p=\@temp;
			$d+=1;	
			print_rev($ref_p);
		}
		my $k=@{$ref_p}[$i];
		if(abs($k)!=$k) {
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
		print "k_reversal (k,s) $k\t$s\n" if $verbose;
		if(abs($k)==$s+1) {
			print "$s,$i,$l\n"  if $verbose;
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
		if(@{$ref_p}[$i]>0) {print "+".int(@{$ref_p}[$i]);}
		else{ print @{$ref_p}[$i];}
		if($i!=0+@{$ref_p}-1){print " "};
	}
	print ")\n";
}
