use strict;
use warnings;
use PDL;
use PDL::Graphics::Prima::Simple;
use PDL::NiceSlice;

# Create a block with random points set to one:
my $size = 200;
my $values = zeroes($size, $size);

# Set 500 random points to 1
use PDL::NiceSlice;
for (1..500) {
	my ($x, $y) = (int(rand($size)), int(rand($size)));
	$values($x, $y) .= 1;
}

# Smear out the points:
use PDL::Image2D;
my $to_plot = $values->box2d($size/10, $size/10, 1);

# Set some of it to bad
$to_plot(int(rand($size)):int(rand($size)), int(rand($size)):int(rand($size)))
	.= pdl 'bad';
$to_plot->badflag(1);

plot(
	-random => ds::Grid($values,
		bounds => [0,1, 1,2],
		color_map => pal::WhiteToBlack,
	),
	-intensity => ds::Grid($to_plot
		, bounds => [0, 0, 1, 1]
	),
	color_map => pal::Rainbow(label => 'Smear'),
);
