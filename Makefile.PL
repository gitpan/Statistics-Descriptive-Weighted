use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	      'NAME'		=> 'Statistics::Descriptive::Weighted',
	      'VERSION_FROM'	=> 'Weighted.pm', # finds $VERSION
	      ($] >= 5.005 ?
	       ('ABSTRACT_FROM'  => 'Weighted.pm',
		'AUTHOR'     	=> 'David H. Ardell')  : ()
	      ),
	      'dist'		=> { COMPRESS => "gzip -9f" },
	      'PREREQ_PM' => {
			     'Statistics::Descriptive' => 2.6,
			    },
	      
	      
	     );
