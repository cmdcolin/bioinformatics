use strict;
use warnings;
use Data::Dumper;
use Text::Levenshtein qw(distance);

my $header=<>;
my ($k,$d)=split(' ',$header);
my @dna;
while(my $line=<>) {
	chomp($line);
	push(@dna,$line);
}

#generate all kmers from input
my %kmers_input;
foreach my $string (@dna) {
	for(my $i=0;$i<length($string)-$k;$i++) {
		my $x=substr $string,$i,$k;
		$kmers_input{$x}++;
	}
}
my @bases = ('A','C','G','T');
my @words = @bases;
for my $i (1..$k-1)
{
	my @newwords;
	undef @newwords;
	foreach my $w (@words)
	{
		foreach $b (@bases)
		{
			push (@newwords,$w.$b);
		}
	}
	undef @words;
	@words = @newwords;
}
foreach my $w (@words)
{
	print "$w\n";
}


sub motif_enum {
	my $kmers_ref=shift;
	foreach my $kmer (keys %{$kmers_ref}) {
		foreach my $kmut (gen_mut($kmer,$d)) {
			
		}
	}	
}



sub gen_mut {
	my ($kmer, $d)=@_;
}



