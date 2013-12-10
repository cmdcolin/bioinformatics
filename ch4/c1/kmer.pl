use strict;
use Data::Dumper;

my $k=<>;
my $dna=<>;
chomp($dna);
my %hash;
for(my $i;$i<length($dna)-($k-1);$i++) {
	my $kmer=substr($dna,$i,$k);
	$hash{$kmer}="hi";

}
print join("\n",sort(keys %hash))."\n";
