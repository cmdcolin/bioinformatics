use Data::Dumper;
use strict;
use Algorithm::Loops qw/ NestedLoops NextPermute /;


open(my $file, $ARGV[0]) or die "Did not receive file from command line";
my $header=<$file>;
my @arr=split(' ', $header);
my $d=$arr[1];
my $k=$arr[0];
my @dna;
while(my $line=<$file>) {
	chomp($line);
	print $line."\n";
	push(@dna,$line);	
}

motif_enumeration(\@dna,$k,$d);

sub motif_enumeration {
	my $dna=shift;
	my $k=shift;
	my $d=shift;

	my %dna_kmers;
	print "size dna array: ".0+@dna."\n";
	for(my $i=0; $i<0+@{$dna}; $i++) {
		for(my $j=0;$j<length($dna[$i])-$k;$j++) {
			my $kmer=substr($dna[$i],$j,$k);
			$dna_kmers{$kmer}+=1;
		}
	}
	print Dumper \%dna_kmers;
	my %dna_kmer_mut;
	foreach my $key (keys %dna_kmers) {
		$dna_kmer_mut{$key}+=1;
		for(my $i=0;$i<length($key);$i++) {
			$|= 1;
			my $len= 3;
			my $verbose= 1;
			my $iter= NestedLoops(
				[   [0..9],
				( sub { [$_+1..9] } ) x ($len-1),
				],
			);

			my $count= 0;
			my @list;
			while(  @list= $iter->()  ) {
				do {
					++$count;
					print "@list\n"   if  $verbose;
					
				} while( NextPermute(@list) );
			}
			print "$count non-repeating $len-digit sequences.\n";
		}	
	}
}
 
