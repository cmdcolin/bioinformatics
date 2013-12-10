use strict;
use Data::Dumper;

my $k=<>;
my $dna=<>;
chomp($dna);
my %hash;
for(my $i;$i<length($dna)-($k-1);$i++) {
	my $kmer=substr($dna,$i,$k);
	print $kmer."\n";
	$hash{$kmer}="hi";

}
print Dumper sort(keys %hash);

