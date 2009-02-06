use Test::Simple tests => 74;
use Statistics::Descriptive::Weighted;
use Statistics::Descriptive;

$Tolerance = 1e-10;

$weighted = Statistics::Descriptive::Weighted::Sparse->new();
$weighted->add_data( [1, 3, 5, 7],[1, 1, 1, 1] );
$unweighted = Statistics::Descriptive::Sparse->new();
$unweighted->add_data( [1, 3, 5, 7]);
ok( $weighted->mean() == 4, 'Sparse dataset 1 mean');
ok( $unweighted->variance() == ( $weighted->biased_variance() * $weighted->count/ ($weighted->count - 1)), 'Sparse dataset 1 biased variance'); 
ok( $weighted->max() == 7, 'Sparse dataset 1 max');
ok( $weighted->min() == 1, 'Sparse dataset 1 min');
ok( $weighted->weight() == 4, 'Sparse dataset 1 weight');
ok( $weighted->count() == 4, 'Sparse dataset 1 count');

$stat3 = Statistics::Descriptive::Weighted::Sparse->new();
$stat3->add_data( [1, 3, 5, 7],[2, 2, 2, 2] ); 
ok( $stat3->mean() == $weighted->mean(), 'Sparse dataset 2 mean');
ok( $stat3->variance() == $weighted->variance(), 'Sparse dataset 2 variance'); 
ok( $stat3->max() == $weighted->max(), 'Sparse dataset 2 max');
ok( $stat3->min() == $weighted->min(), 'Sparse dataset 2 min');
ok( $stat3->weight() == 8, 'Sparse dataset 2 weight');
ok( $stat3->count() == 4, 'Sparse dataset 2 count');

ok( $stat3->weight(1) == $stat3->weight(), join ' ','Sparse dataset 2 weight of defined value');
ok( $stat3->weight(2) == $stat3->weight(), join ' ','Sparse dataset 2 weight of undefined value');


$stat4 = Statistics::Descriptive::Weighted::Sparse->new();
$stat4->add_data( [1, 3, 5, 7],[0.1, 0.1, 0.1, 0.1] ); 
ok( $stat4->mean() == $weighted->mean(), 'Sparse dataset 3 mean');
ok( abs($stat4->variance() - $weighted->variance()) < $Tolerance, 'Sparse dataset 3 variance'); 
ok( $stat4->max() == $weighted->max(), 'Sparse dataset 3 max');
ok( $stat4->min() == $weighted->min(), 'Sparse dataset 3 min');
ok( $stat4->weight() == 0.4, 'Sparse dataset 3 weight');
ok( $stat4->count() == 4, 'Sparse dataset 3 count');

$twoadd = Statistics::Descriptive::Weighted::Sparse->new();
$twoadd->add_data( [1, 3],[0.1, 0.1]);
$twoadd->add_data( [5, 7],[0.1, 0.1]);
ok( $stat4->mean() == $twoadd->mean(), 'Sparse dataset 4 (two adds) mean');
ok( abs($stat4->variance() - $twoadd->variance()) < $Tolerance, 'Sparse dataset 4 (two adds) variance'); 
ok( $stat4->max() == $twoadd->max(), 'Sparse dataset 4 (two adds) max');
ok( $stat4->min() == $twoadd->min(), 'Sparse dataset 4 (two adds) min');
ok( $stat4->weight() == $twoadd->weight(), 'Sparse dataset 4 (two adds) weight');
ok( $stat4->count() == $twoadd->count(), 'Sparse dataset 4 (two adds) count');


$zero = Statistics::Descriptive::Weighted::Sparse->new();
$zero->add_data( [7, 3],[0.1, 0]);
ok( $zero->mean() == 7, 'Sparse dataset 5 (size 1) mean');
ok( $zero->variance() == 0, 'Sparse dataset 5 (size 1) 0 variance'); 
ok( $zero->max() == 7, 'Sparse dataset 5 (size 1) max');
ok( $zero->min() == 7, 'Sparse dataset 5 (size 1) min');
ok( $zero->weight() == 0.1, 'Sparse dataset 5 (size 1) weight');
ok( $zero->count() ==1, 'Sparse dataset 5 (size 1) count');


$stat = Statistics::Descriptive::Sparse->new();
$stat->add_data(1,1,1,1,2,2,2,3,3,4);
$weighted = Statistics::Descriptive::Weighted::Sparse->new();
$weighted->add_data(1,1,1,1,2,2,2,3,3,4);
$weighted->add_data(1,1);
$weighted->add_data([1,1,1,1,2,2,2,3,3,4],[]);
$weighted->add_data([],[]);
$weighted->add_data([1,2,3,4],[1]);
$weighted->add_data([1,2,3,4],[4,3,2,1]);
ok( $stat->mean() == $weighted->mean(), 'Sparse dataset 6 (counts vs weights) mean');
#ok( $stat->variance() < $weighted->variance(), 'Sparse dataset 6 (counts vs weights) variance');
#ok( $stat->standard_deviation() < $weighted->standard_deviation(), 'Sparse dataset 6 (counts vs weights) standard deviation');
ok( $stat->max() == $weighted->max(), 'Sparse dataset 6 (counts vs weights) max');
ok( $stat->min() == $weighted->min(), 'Sparse dataset 6 (counts vs weights) min');
ok( $stat->count() > $weighted->count(), 'Sparse dataset 6 (counts vs weights) counts are different');
ok( $stat->sample_range() == $weighted->sample_range(), 'Sparse dataset 6 (counts vs weights) sample range');


$full = Statistics::Descriptive::Weighted::Full->new();
$full->add_data([1,2,3,4],[4,3,2,1]);
ok( $full->mean() == $weighted->mean(), 'Full dataset 1 (vs sparse) mean');
ok( $full->variance() == $weighted->variance(), 'Full dataset 1 (vs sparse) variance');
ok( $full->standard_deviation() == $weighted->standard_deviation(), 'Full dataset 1 (vs sparse) standard deviation');
ok( $full->max() == $weighted->max(), 'Full dataset 1 (vs sparse) max');
ok( $full->min() == $weighted->min(), 'Full dataset 1 (vs sparse) min');
ok( $full->count() == $weighted->count(), 'Full dataset 1 (vs sparse) counts');
ok( $full->sample_range() == $weighted->sample_range(), 'Full dataset 1 (vs sparse) range');
ok( $full->weight() == $weighted->weight(), 'Full dataset 1 (vs sparse) weight');
ok( $full->mode() == 1, 'Full dataset 1 mode');

$full = Statistics::Descriptive::Weighted::Full->new();
$full->add_data([-2, 7, 4, 18, -5],[1,2,1,1,1]);
ok( $full->sum() == 29, 'Full dataset 2 - sum');
ok( $full->quantile(0.25) == -2, 'Full dataset 2 - 0.25 quantile');
ok( $full->quantile(0.50) == 4, 'Full dataset 2 - 0.50 quantile');
ok( $full->median == $full->percentile(50), 'Full dataset 2 - 50% percentile equals median');
ok( $full->quantile(0) == -5, join " ",'Full dataset 2 - quantile of 0 equals minimum');
ok( $full->quantile(0.02) == -5, join " ",'Full dataset 2 - quantile below cdf of min variate equals minimum');
$full->add_data([7],[6]);
ok( $full->weight(7) == 8, 'Full dataset 2 weight of a datum, after additional weight added');
ok( $full->weight(5) == undef, join ' ','Full dataset 2 weight of undefined value');
ok( abs($full->variance() - 40.91) < $Tolerance, join ' ','Full dataset 2 variance:',$full->variance());

$full->print();

$full = Statistics::Descriptive::Weighted::Full->new();
$th = [1..200];
$tho = [split '', '1' x 200];
$full->add_data($th,$tho);
ok( $full->quantile(0.99) == 198, join " ",'Full dataset 3 - 0.99 quantile');
ok( abs($full->cdf(198) - 0.99) < $Tolerance, join " ",'Full dataset 3 - cdf of 198 is 0.99 ',$full->cdf(198));

ok($full->cdf(0) == 0, "Full dataset 3 - cdf of value below minimum is 0");
ok($full->cdf(1000) == 1, "Full dataset 3 - cdf of value above maximum is 1");

$full = Statistics::Descriptive::Weighted::Full->new();
$full->add_data([1,10],[90,10]);
ok( $full->quantile(0.90) == 1, join " ",'Full dataset 4 - 0.9 quantile', $full->quantile(0.9) );
ok( $full->quantile(1) == 10, join " ",'Full dataset 4 - 1.0 quantile', $full->quantile(1));
ok( $full->quantile(0.01) == 1, join " ",'Full dataset 4 - 0.01 quantile equals minimum', $full->quantile(0.01));
ok( abs($full->cdf(1) - 0.9) < $Tolerance, join " ",'Full dataset 4 - cdf of 1 is 0.9 ',$full->cdf(1));
ok( abs($full->cdf(2) - 0.9) < $Tolerance, join " ",'Full dataset 4 - cdf of 2 is 0.9 ',$full->cdf(2));
ok( $full->cdf(11) == 1, join " ",'Full dataset 4 - cdf of value greater than maximum observed', $full->cdf(11) );
ok( abs($full->rtp(10) - 0.1) < $Tolerance, join " ",'Full dataset 4 - right tail prob of 10 is 0.1 ',$full->rtp(10));
ok( $full->rtp(11) == 0, join " ",'Full dataset 4 - tail prob of value g.t. maximum ',$full->rtp(11));
ok( abs($full->survival(2) - (1 - ($full->cdf(2) ))) < $Tolerance, join " ",'Full dataset 4 - survival function of 2 is (1 - cdf) of 2 ',$full->survival(2));

ok($full->survival(0) == 1, "Full dataset 4 - survival function of value below minimum is 1");
ok($full->survival(1000) == 0, "Full dataset 4 - survival of value above maximum is 0");


ok($full->rtp(0) == 1, "Full dataset 4 - rt tail prob function of value below minimum is 1");
ok($full->rtp(1000) == 0, "Full dataset 4 - rt tail prob of value above maximum is 0");


## NEED TO WRITE TESTS FOR:
$full = Statistics::Descriptive::Weighted::Full->new();
$full->add_data([1,3,5,7,9],[3,1,1,3,0]);
ok($full->median() == 4, "Full dataset 5 - median is based on linear interpolation in percentile.");
ok( abs($full->variance() - 10.1818181818) < $Tolerance, join ' ','Full dataset 5 -  variance with 0 weight variate:',$full->variance());


## sum
## min, max, sample_range
## add range alias to sample_range
## confess on disqualified inherited functions


