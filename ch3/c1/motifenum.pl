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
	my $array=[];
	for(my $i=0;$i<length($string)-$k;$i++) {
		my $x=substr $string,$i,$k;
		if(!exists($kmers_input{$x})) {
			my $newarr=[];
			push(@$newarr,$iter);
			$kmers_input{$x}=$newarr;
		}
		else {
			my $arrref=$kmers_input{$x};
			push(@{$arrref},$iter);
		}
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

print "Processing k:$k, d:$d\n",Dumper \%kmers_input if $verbose;
motif_enum(\%kmers_input);



#motifenumerate as described on website
sub motif_enum {
	my $kmers_ref=shift;
	foreach my $kmer (keys %{$kmers_ref}) {
		my $mut_ref=gen_mut($kmer,$d);
		print "Processing $kmer in motif_enum l1\n" if $verbose;
		foreach my $kmut (@{$mut_ref}) {
			print "Processing $kmut in motif_enum l2\n" if $verbose;
			foreach my $origkmer (keys %{$kmers_ref}) {
				print "Processing $origkmer in motif_enum l3\n" if $verbose;
				if(distance($kmut,$origkmer)<=$d) {
					print "Found distance less than $d $kmut $origkmer l4\n";
					my %listgather;
					my $dnalist=${$kmers_ref}{$origkmer};
					foreach my $dnaitem (@{$dnalist}) {
						print "Found $origkmer in ".$dna[$dnaitem]."\n";
						$listgather{$dnaitem}++;
					}
					my $d1=scalar keys %listgather;
					my $d2=scalar @dna;
					print "Testing sizes d1 $d1 d2 $d2\n";
					if($d1==$d2) {
						print "FOUND: $kmut\n";
					
					}
					if($d1>1) {
						print "Closer\n";
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
		if(distance($key,$kmer)<=$d) {
			push(@ret,$key);
		}
	}
	return \@ret;
}



