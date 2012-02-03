
# usage: intersect( [ARRAY REF], [ARRAY REF], ... )
# return: ARRAY REF
sub intersect {
	
	if(scalar(@_) < 2) {
		return $_[0];
	}
	
    my $set1 = shift;
    my $set2 = shift;
	my @remain_set = @_;
	
	# if set1 or set2 is empty
	if(!$set1 or !$set2) {
		return [];
	}
	
    my $hash2;
    foreach (@$set2) {
        $hash2->{$_} = 1;
    }
    
    my $intersect;
    foreach (@$set1) {
        push(@$intersect, $_) if($hash2->{$_});
    }
	
	if($intersect) {
		$intersect = intersect($intersect, @remain_set);
	}
	else {
		return [];
	}
	
	return $intersect;
}

# usage: union( [ARRAY REF], [ARRAY REF] )
# return: ARRAY REF
sub union {
	
	if(scalar(@_) < 2) {
		return $_[0];
	}
	
    my $set1 = shift;
    my $set2 = shift;
	my @remain_set = @_;
    
    my $hash;
    foreach (@$set1) {
        $hash->{$_} = 1;
    }
    foreach (@$set2) {
        $hash->{$_} = 1;
    }
	
	my $union = [keys %$hash];
	
	$union = union($union, @remain_set);
	
	return $union;
}

# usage: complement( [ARRAY REF], [ARRAY REF] )
# return: ARRAY REF
# set1 - set2
sub setdiff {
    my $set1 = shift;
    my $set2 = shift;
    
    my $hash2;
    foreach (@$set2) {
        $hash2->{$_} = 1;
    }
    
    my $diff;
    foreach (@$set1) {
        push(@$diff, $_) unless($hash2->{$_});
    }
    return $diff;
}

# usage: setequal( [ARRAY REF], [ARRAY REF] )
# return: 1|0
sub setequal {
	my $set1 = shift;
	my $set2 = shift;
	
	my $unique_set1 = unique($set1);
	my $unique_set2 = unique($set2);
	my $union = union($set1, $set2);
	
	if(len($unique_set1) == len($unique_set2)
	   and len($unique_set1) == len($union)) {
		return 1;
	}
	else {
		return 0;
	}
}

# usage: is_element( [SCALAR], [ARRAY REF])
# return 0|1
sub is_element {
	my $item = shift;
	my $set = shift;
	
	for(my $i = 0; $i < len($set); $i ++) {
		if(is_numberic($set->[$i]) and is_numberic($item)
		   and $set->[$i] == $item) {
			return 1;
		}
		elsif($set->[$i] eq $item) {
			return 1;
		}
	}
	return 0;
}

1;
