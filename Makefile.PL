use ExtUtils::MakeMaker;

WriteMakefile(
	NAME          => 'List::Vectorize',
	VERSION_FROM  => 'lib/List/Vectorize.pm',
	PREREQ_PM     => {
		'Data::Dumper' => 0,
		'Test::More'   => 0,
		'Carp'         => 0,
	},
	EXE_FILES     => ["bin/l.intersect", "bin/l.sapply", "bin/l.setdiff", "bin/l.sort", "bin/l.subset", "bin/l.union", "bin/l.unique"], 
	AUTHOR        => 'Zuguang Gu <jokergoo@gmail.com>',
	ABSTRACT      => 'functions to make vectorized calculation easy',
	LICENSE       => 'perl',
);
