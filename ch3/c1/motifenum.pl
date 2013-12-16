use strict;
use warnings;
#libs
use Data::Dumper;
use Text::LevenshteinXS qw(distance);

#config
my $verbose=0;

#load input files
my $header=<>;
chomp($header);
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
	for(my $i=0;$i<length($string)-($k-1);$i++) {
	
		my $x=substr $string,$i,$k;
		$kmers_input{$x}++;
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

my %answers;

print "Processing k:$k, d:$d\n",Dumper \%kmers_input if $verbose;
motif_enum(\%kmers_input);

foreach my $key (keys %answers) {
	print $key." ";
}
print "\n";



#motifenumerate as described on website
sub motif_enum {
	my $kmers_ref=shift;
	foreach my $kmer (keys %{$kmers_ref}) {
		my $mut_ref=gen_mut($kmer,$d);
		print "Processing $kmer in motif_enum l1\n" if $verbose>=1;
		foreach my $kmut (@{$mut_ref}) {
			print "Processing kmer:$kmer mut:$kmut in motif_enum l2\n" if $verbose>=1;
			my $setsize=0;
			foreach my $dnastring (@dna) {
				for(my $i=0;$i<length($dnastring)-($k-1);$i++) {
					my $x=substr $dnastring,$i,$k;
					my $distance=distance($kmut,$x);
					print "Processing kmut:$kmut x:$x $distance=?$d\n" if $verbose>=2;
					if($distance<=$d) {
						$setsize++;
						last;
					}
				}
			}
			print "Testing sizes d1:$setsize d2:".scalar @dna." l4\n" if $verbose>=2;
			if($setsize==scalar @dna) {
				print "FOUND ANSWER: $kmut l5\n" if $verbose>=3;
				$answers{$kmut}++;
			
			}

		}
	}	
}



sub gen_mut {
	my ($kmer, $d)=@_;
	my @ret;
	for my $key (@words) {
		my $distance=distance($key,$kmer);
		if($distance=$d) {
			push(@ret,$key);
		}
	}
	return \@ret;
}



