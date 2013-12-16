use strict;
use warnings;
#libs
use Data::Dumper;
use Text::Levenshtein qw(distance);

#load input files
my $header=<>;
my ($k,$d)=split(' ',$header);
my @dna;
while(my $line=<>) {
	chomp($line);
	push(@dna,$line);
}

#generate all kmers from input
my %kmers_input;
my $iter=0;
for(my $iter=0;$iter<scalar @dna;$iter++) {
	my $string=$dna[$iter];
	for(my $i=0;$i<length($string)-$k;$i++) {
		my $x=substr $string,$i,$k;
		push($kmers_input{$x},$iter);
	}
}

#generate all possible kmers 
#http://www.bioperl.org/wiki/Getting_all_k-mer_combinations_of_residues
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

#motifenumerate as described on website
sub motif_enum {
	my $kmers_ref=shift;
	foreach my $kmer (keys %{$kmers_ref}) {
		my $mut_ref=gen_mut($kmer,$d);
		foreach my $kmut (@{$mut_ref}) {
			foreach $origkmer (keys %{$kmer_ref}) {
				if(distance($kmut,$origkmer)<=$d) {
					my %listgather;
					my @dnalist_t=(${$kmer_ref}){$origkmer};
					foreach my $dnaitem (@dnalist) {
						$listgather{$dnaitem}++;
					}
					if(scalar keys %listgather==scalar @dna) {
						print $kmut;
					}
				}
			}
		}
	}	
}



sub gen_mut {
	my ($kmer, $d)=@_;
	my @ret;
	for my $key (@words) {
		if(distance($key,$kmer)<$d) {
			push(@ret,$key);
		}
	}
	return \@ret;
}



