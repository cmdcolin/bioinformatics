use strict;
use warnings;

use constant { true => 1, false => 0 };

open(my $file, $ARGV[0]);#"RNA_codon_translation_table_1.txt");
my %transcription_table;
while(my $line=<$file>) {
	my ($f1,$f2)=split(' ',$line);
	$transcription_table{$f1}=$f2;
}

open(my $input, $ARGV[1]);
my $input_dna=<$input>;
my $input_peptide=<$input>;
chomp($input_dna);
chomp($input_peptide);

#translate rna

sub check_peptides {
	my $peptide=shift;
	my $rna=shift;
	
       	for(my $j=0;$j<length($peptide)-1;$j++) {
               	my $codon=substr($rna,$j*3,3);
               	my $letter=$transcription_table{$codon};
		my $pverify=substr($peptide,$j,1);

		#print $pverify, " ", $letter, "\n";
		if(!defined($letter) or ($pverify ne $letter)) {
			return false;
		}
       	}
	return true;
}

sub get_rna {
	my $temp=shift;
	$temp=~tr/T/U/;
	return $temp;
}

sub get_reverse_dna {
	my $dna=shift;
	my $reverse_dna="";
	for(my $i=0;$i<length($dna);$i++) {
		my $letter=substr $dna,$i,1;
        	if($letter =~ "A"){$reverse_dna.='T';}
        	if($letter =~ "G"){$reverse_dna.='C';}
        	if($letter =~ "C"){$reverse_dna.='G';}
        	if($letter =~ "T"){$reverse_dna.='A';}
	}
	my $output=reverse $reverse_dna;
	return $output;
}






for(my $i=0;$i<length($input_dna)-3*length($input_peptide);$i++) {
        my $dna_check=substr($input_dna,$i,3*length($input_peptide));
	#print $dna_check, " ", get_rna($dna_check), " ", get_reverse_dna($dna_check), " ",get_rna(get_reverse_dna($dna_check)),"\n";
	
	if(check_peptides($input_peptide,get_rna($dna_check))) {
                print "$dna_check\n";
        }
	if(check_peptides($input_peptide,get_rna(get_reverse_dna($dna_check)))) {
		print "$dna_check\n";
	}
}




