use strict;
use warnings;

use Data::Dumper;


	

#From Array::Compare
sub array_diff(\@\@) {
    my %e = map { $_ => undef } @{$_[1]};
    return @{[ ( grep { (exists $e{$_}) ? ( delete $e{$_} ) : ( 1 ) } @{ $_[0] } ), keys %e ] };
}


open(my $input, $ARGV[0]);
my %amino_acids;
while(my $line=<$input>) {
	chomp($line);
	my @val=split(' ',$line);
	$amino_acids{$val[0]}=$val[1];
}

sub expand {
	my $cyclo_list=shift;
	my $amino_acids=shift;

	foreach my $key ( keys %{$cyclo_list} ) {
		foreach my $amino (keys %{$amino_acids}) {
			$cyclo_list->{$key.$amino}+=$cyclo_list->{$key}+$amino_acids->{$amino};
		}

	}
}


sub peptide_spectrum {
	my $peptide=shift;
	my $linear=shift;
	#print "cyclo_peptide $peptide\n";
	my $peptide_length=length($peptide);
	if($linear) {
		 $peptide.=$peptide;
	}
	my @cyclo;
	for(my $i=0;$i<$peptide_length+1;$i++) {
		for(my $j=0;$j<$peptide_length;$j++) {
			push(@cyclo,substr($peptide,$j,$i));
		}
	}
	return @cyclo;
}

sub calc_mass {
	my $peptide=shift;
	my $mass=0;
	for(my $i=0;$i<length($peptide);$i++) {
		my $letter=substr $peptide,$i,1;
		$mass+=$amino_acids{$letter};
	}
	return $mass;
}
my %results;
sub print_masses {
	my $peptide=shift;
	my $str="";
	for(my $i=0;$i<length($peptide);$i++) {
		$str.=calc_mass(substr($peptide,$i,1));
		$str.=($i==length($peptide)-1)?"":"-";
	}
	print "$str\n";
	$results{$str}++;
}

sub cyclo_sequence {
	my @spectrum=@_;
	my %cyclo_hashmap;
	$cyclo_hashmap{""}=0;#initialize 0-peptide
	my $deleted=0;
	my $consistent=0;
	my $accepted=0;
	do {
		print "Expanding hashmap. ", keys(%cyclo_hashmap)+0,"\n";
		#print Dumper \%cyclo_hashmap;
		expand(\%cyclo_hashmap,\%amino_acids);
		print "Now has size ", keys(%cyclo_hashmap)+0, "\n";
		print "Deleted $deleted, consistent $consistent, accepted $accepted\n";
		$deleted=0;
		$consistent=0;
		$accepted=0;
		foreach my $peptide (keys %cyclo_hashmap) 
		{
			#print "Analyzing $peptide\n"; 
			my @cyclo_spectrum=peptide_spectrum($peptide,1);
			#print "Spectrum of $peptide is @cyclo_spectrum\n";
			#print "Peptide has cyclo_array @cyclo_spectrum\n";
			my @cyclo_masses=map(calc_mass($_),@cyclo_spectrum);
			#print "Peptide has cyclo_masses @cyclo_masses\n";
			if(!array_diff(@spectrum, @cyclo_masses)) {
				print "Got match $peptide ",calc_mass($peptide),"\n";
				print_masses($peptide);
				$accepted++;
				delete $cyclo_hashmap{$peptide};
				foreach my $key (keys(%results)) {
					print "$key ";
				}print "\n";#print Dumper \%results,"\n";
			} else {
				my @linear_spectrum=peptide_spectrum($peptide,0);
				my @linear_masses=map(calc_mass($_),@linear_spectrum);
				#print "$mass from @linear_masses exists in spectrum? @spectrum\n";
				if(0+@linear_spectrum>0+@spectrum) { 
					$deleted++;
					print "Peptide $peptide with subpeptide is inconsistent with @spectrum\n";
					delete $cyclo_hashmap{$peptide};
					last; 
				} 
				#print "Peptide $peptide is consistent\n";
				$consistent++;
			}
		}
	} while(keys(%cyclo_hashmap)>1);
}


open(my $spectrumfile,$ARGV[1]);
my $line=<$spectrumfile>;
chomp($line);
my @spectrum=split(' ',$line);


#my %cyclo_hashmap;
#$cyclo_hashmap{""}=0;#initialize 0-peptide
#expand(\%cyclo_hashmap,\%amino_acids);#expand
#print Dumper \%cyclo_hashmap,"\n";
#expand(\%cyclo_hashmap,\%amino_acids);
#print Dumper \%cyclo_hashmap,"\n";
#expand(\%cyclo_hashmap,\%amino_acids);
#print Dumper \%cyclo_hashmap,"\n";

cyclo_sequence(@spectrum);


print "\n";
