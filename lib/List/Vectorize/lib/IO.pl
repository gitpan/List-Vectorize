
# ============================= IO subroutine ==============================================
# usage: print_ref( [TYPEGLOB], [SCALAR] )
# description: 打印出索引的数据结构
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
# description: 打印矩阵
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
# description: 读取表格形式的文本数据
#              quote: 把每个值引起来的符号，默认无
#              sep: 分隔符，默认制表符
#              col_skip: 跳过读取的列号，以1开始
#              row_skip: 跳过读取的行号，以1开始
#              rownames: 是否读入行名
#              colnames: 是否读入列名
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
# description: 把矩阵输出到文件中
#              quote: 把每个值引起来的符号，默认无
#              sep: 分隔符，默认制表符
#              colnames: 列名，数组索引
#              rownames: 行名，数组索引
#              file: 存储的文件名
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



1;
