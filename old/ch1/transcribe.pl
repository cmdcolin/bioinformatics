
open(my $file, $ARGV[0]);#"RNA_codon_translation_table_1.txt");
my %transcription_table;
while(my $line=<$file>) {
	my ($f1,$f2)=split(' ',$line);
	$transcription_table{$f1}=$f2;
}

open(my $input, $ARGV[1]);
$inputline=<$input>;

for(my $i=0;$i<length($inputline);$i+=3) {
	my $letter=substr($inputline,$i,3);
	print $transcription_table{$letter};
}
print "\n";


