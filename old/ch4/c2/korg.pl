use strict;
use Data::Dumper;

my $g = {};
my @kmers;
my %graph;


while(my $line=<>) {
	chomp($line);
	if($line ne '') {
		push(@kmers,$line);
	}
}

for my $kmer (@kmers) {
	foreach my $test (@kmers) {
		my $s1=substr($kmer, 1, length($kmer)-1);
		my $s2=substr($test,0,length($test)-1);
		if($s1 eq $s2) {
			$graph{$kmer}->{$test}=1;
		}
	}
}


for my $elt (sort(keys %graph)) {
	for my $sub (keys %{$graph{$elt}}) {
		print $elt." -> ". $sub."\n";
	}
}
