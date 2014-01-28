use strict;

use Data::Dumper;
my $verbose=0;
my $line=<>;
$line=~s/\((.*)\)/$1/;
my @p=split(' ',$line);
unshift(@p,0);
push(@p,0+@p);
foreach my $x (@p) { $x = int($x); }	
print Dumper \@p;
my $bpp=0;
for(my $i=0;$i<(0+@p)-1;$i++) {
	if(@p[$i]!=@p[$i+1]+1&&@p[$i]!=@p[$i+1]-1) {
		$bpp++;
	}
}
print $bpp."\n";

