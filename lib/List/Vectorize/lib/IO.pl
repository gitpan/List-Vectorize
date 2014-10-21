
# ============================= IO subroutine ==============================================
# usage: print_ref( [TYPEGLOB], [SCALAR] )
# description: ��ӡ�����������ݽṹ
sub print_ref {
	my $handle = *STDOUT;
	if(is_glob_ref($_[0])) {
		$handle = shift(@_);
	}
	my $ref = shift;
    
    if(is_array_ref($ref)) {
        print $handle "Reference of ARRAY.\n";
		for (0..$#$ref) {
			print $handle "[$_] $ref->[$_]\n";
		}
        print $handle "\n";
    } elsif(is_hash_ref($ref)) {
        print $handle "Reference of HASH.\n";
        foreach (keys %$ref) {
            print $handle "$_\t$ref->{$_}\n";
        }
        print $handle "\n";
    } elsif(is_scalar_ref($ref)) {
        print $handle "Reference of SCALAR.\n";
        print $handle $$ref;
        print $handle "\n";
    } elsif(is_ref_ref($ref)) {
        print $handle "Reference of REF.\n";
        print $handle $$ref;
        print $handle "\n";
    } elsif(is_code_ref($ref)) {
        print $handle "Reference of CODE.\n";
    } else {
        print $handle "@_\n";
    }
    return $ref;
}

# usage: print_matrix( [TYPEGLOB], [SCALAR] )
# description: ��ӡ����
sub print_matrix {
	my $handle = *STDOUT;
	if(is_glob_ref($_[0])) {
		$handle = shift(@_);
	}
	my $mat = $_[0];
	my $sep = "\t";
	
	my ($nrow, $ncol) = dim($mat);
	print "$nrow x $ncol matrix:\n\n";
	
	for(my $i = 0; $i < len($mat); $i ++) {
		print $handle join $sep, @{$mat->[$i]};
		print $handle "\n";
	}
	print "\n";
}

# usage: read_table( [SCALAR], %setup )
# description: ��ȡ�����ʽ���ı�����
#              quote: ��ÿ��ֵ�������ķ��ţ�Ĭ����
#              sep: �ָ�����Ĭ���Ʊ��
#              col_skip: ������ȡ���кţ���1��ʼ
#              row_skip: ������ȡ���кţ���1��ʼ
#              rownames: �Ƿ��������
#              colnames: �Ƿ��������
sub read_table {
	my $file = shift;
	
	my %setup = @_;
	my $quote = $setup{"quote"} || "";
	my $sep = $setup{"sep"} || "\t";
	my $col_skip = $setup{"col.skip"} || [0];   # columns being skipped, array ref, start with 1
	my $row_skip = $setup{"row.skip"} || [0];   # rows being skipped, array ref, start with 1
	my $whether_rownames = $setup{"row.names"} || 0;       # if set true, first item will be key
	my $whether_colnames = $setup{"col.names"} || 0;       # if set true, first item will be key
	
	if(type_of($col_skip) eq "SCALAR") {
		$col_skip = [$col_skip];
	}
	if(type_of($row_skip) eq "SCALAR") {
		$row_skip = [$row_skip];
	}
	
	my $col_skip_h;
	%$col_skip_h = map {$_ => 1} @$col_skip;
	my $row_skip_h;
	%$row_skip_h = map {$_ => 1} @$row_skip;
	
	open F, $file or die "cannot open $file.\n";
	my $data;
	my $rownames;
	my $colnames;
	my $i_line = 0;
	my $i_array = 0;
	my $flag = 0;
	while( my $line = <F>) {
		$i_line ++;
		
		# check rows that are skipped
		if($row_skip_h->{$i_line}) {
			next;
		}
		
		# read the column names
		if($flag == 0 and $whether_colnames) {
			chomp $line;
			$line =~s/^$quote|$quote$//g;
			@$colnames = split "$quote$sep$quote", $line; 
			$flag = 1;
			next;
		}
		
		$i_array ++;
		
		chomp $line;
		$line =~s/^$quote|$quote$//g;
		my @tmp = split "$quote$sep$quote", $line; 
		
		# columns that are skipped
		my @r_ind = grep {!$col_skip_h->{$_+1}} (0..$#tmp);
		@tmp = @{subset(\@tmp, \@r_ind)};
		
		# read rownames
		if($whether_rownames) {
			push(@$rownames, shift(@tmp));
		}
		
		push(@{$data->[$i_array - 1]}, @tmp);
		
	}
	return ($data, $colnames, $rownames);
}

# usage: write_table( [MATRIX], %setup )
# description: �Ѿ���������ļ���
#              quote: ��ÿ��ֵ�������ķ��ţ�Ĭ����
#              sep: �ָ�����Ĭ���Ʊ��
#              colnames: ��������������
#              rownames: ��������������
#              file: �洢���ļ���
sub write_table {
	my $matrix = shift;
	
	my %setup = @_;
	my $quote = $setup{"quote"} || "";
	my $sep = $setup{"sep"} || "\t";
	my $colnames = $setup{"col.names"};   # column names
	my $rownames = $setup{"row.names"};   # row names
	my $file = $setup{"file"};
	
	my ($nrow, $ncol) = dim($matrix);
	if($rownames and $nrow != len($rownames)) {
		die "Length of rownames should be equal to the length of rows in matrix\n";
	}
	if($colnames and $ncol != len($colnames)) {
		die "Length of colnames should be equal to the length of columns in matrix\n";
	}
	
	open OUT, ">$file" or die "cannot create file:$file\n";
	if($rownames) {
		if($colnames) {
			# print colnames
			print OUT "$quote$quote$sep";
			print OUT join $sep, @{sapply($colnames, sub{"$quote$_$quote"})};
			print OUT "\n";
		}
		for(my $i = 0; $i < len($matrix); $i ++) {
			print OUT "$quote$rownames->[$i]$quote$sep";
			print OUT join $sep, @{sapply($matrix->[$i], sub{"$quote$_$quote"})};
			print OUT "\n";
		}
	}
	else {
		if($colnames) {
			print OUT join $sep, @{sapply($colnames, sub{"$quote$_$quote"})};
			print OUT "\n";
		}
		for(my $i = 0; $i < len($matrix); $i ++) {
			print OUT join $sep, @{sapply($matrix->[$i], sub{"$quote$_$quote"})};
			print OUT "\n";
		}
	}
	close OUT;
}



=head1 NAME
Convinient::IO - subroutines to input and output

=head1 SYNOPSIS
  use Convinient;
  use strict;
  
  my $a = ["a", "b", "c", "d", "e", "f"];
  
  print_ref $a;
  
  my $h = {"a" => 1, "b" => 2};
  print_ref $h;
  
  my $mat = [[1,2],[3,4]];
  my $rownames = ["r1", "r2"];
  my $colnames = ["c1", "c2"];
  # write as csv format
  write_table($mat, "quote" => "\"",
                    "sep" => ",",
					"rownames" => $rownames,
					"colnames" => $colnames,
					"file" => "data.csv");
  
=head1 DESCRIPTION

=head2 Subroutines
=over 4
=items C<print_ref( [TYPEGLOB], [SCALAR] )>
print data structure of a scalar
=back

=items C<print_matrix( [TYPEGLOB], [SCALAR] )>
print tw-dimensional matrix
=back

=items C<read_table( [SCALAR], %setup )>
read data from file
=back

=items C<write_table( [MATRIX], %setup )>
write data to files
=back

=head1 AUTHORS
Zuguang Gu

=head1 COPYRIGHT
Zuguang Gu (c) 2011
=cut

1;
