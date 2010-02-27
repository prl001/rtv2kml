#!/usr/bin/perl -w

=pod

=head1 NAME

rtv2kml.pl - Create a Google Earth .kml file for Australian Ratio and TV Transmitters

=head1 SYNOPSIS

    rtv2kml.pl [--help|-h] [--towers|-t] [--bytype|b]
               [--icon=iconname|-i iconname]
               [--state=state|-s state] csv_files...

=head1 DESCRIPTION

Takes the Excel spreadsheets from the
ACMA Radio and Television Broadcasting Book
(L<http://acma.gov.au/WEB/STANDARD/pc=PC_9150>)
in CSV (Comma Separated Variable) format, and produces placemarks
for all the licensed TV and radio broadcasting stations listed
in the spreadsheets on its standard output.
Standard output would normally be redirected to a file.

At each placemark a simple representation of the tower is drawn,
and the antennas at each site are represented by a horizontal cross.
The orientation of the cross is arbitrary, it does not indicate the
orientation of directional antennas.

The B<--towers> option further simplifies the display of the tower to
be a single line drawn from the ground to 3 metres above the top antenna.

Each placemark has a I<LookAt> attribute that sets the viewpoint to
1km south of the antenna and 20 degrees above it when you doubleclick on
the placemark.

The placemark popup lists the stations broadcasting from the site:

    ABC9A Canberra 205.625MHz (9A) 50.0kW (V, OD, h: 177m)

fields are: callsign/channel (C<ABC9A>), area served (C<Canberra>),
frequency (C<205.625MHz>), channel (C<9A>), power (C<50.0kW>),
polarisation (C<V>), antenna directionality (C<OD>)
and antenna height (C<177m>).

Power is the effective radiated power, in the direction of maximum
radiation for directional antennas. For mixed polarisation, it
is the maximum power for each polariation plane.

Polarisation is C<V> for vertical, C<H> for horizontal and C<M> for mixed.
To recieve horizontal polarisation, the antenna elements should be horizontal
and vertical for vertical polarisation.
In some locations VHF (longer antenna elements) broadcasts are on a
different polarisation from UHF (short antenna elements).

Antennas may be omnidirectional (C<OD>) or directional (C<D>).
The Radio and Television Broadcasting Book does not indicate the direction
(or directions)
of maximum radiated power for directional antennas.

The popup also gives the site name at the bottom of the panel:

    Telecom Tower BLACK MOUNTAIN

=head1 ARGUMENTS

I<Rtv2kml> takes the following options:

=over 4

=item help

  --help
  -h

Print a help message and exit.

=item towers

  --towers
  -t

Draw a simpler representation of the towers
that results in a smaller file (about 50% smaller).

=item bytype

  --bytype
  -t

Split radio and TV services into separate folders at the top level.

=item state

  --state=state
  -s state

Only include transmitters in the given state in the output.
I<State> may be one of 
B<ACT>, B<NSW>, B<NT>, B<QLD>, B<SA>, B<TAS>, B<VIC> or B<WA>.
Case is not distinguished.
The full state names may also be used; if they have spaces
they must be quoted (and B<Western Australia> not B<West Australia>)
but there probably isn't much reason to do that.
Repeated B<--state> options may be used to include more than one state
(e.g. B<--state act --state NSW>).

Using a state specifier to only select the state you are interested
in can also produce a significantly smaller C<.kml> file.

=item icon

  --icon=iconname
  -i iconname

Set the icon to be used on the transmitter placemarks. By default,
I<iconname> is C<electronics>, which is an icon of a TV set.
Another distinctive icon, which looks like an old-fashioned
oscilloscope display,
is C<earthquake>.

The default yellow pushpin used by Google Earth is
C<ylw-pushpin>. Other coloured pushpins have prefixes
C<blu->, C<grn->, C<ltblu->, C<pink->, C<purple-> and C<red->.

You can get a pallet of other icons to use by right-clicking on a placemark
in Google Earth and selecting C<Properties>.
Click on the icon button next to the Name type-in box to bring up the icon
pallet, and click on the icons to display their URLs.
You can just use the last part of the URL as the icon name, with
or without the C<.png> extension.

Alternatively, you can use any 64x64 icon you like by giving
is complete C<http:> or C<file:> URL as the I<iconname>.

=back

=head1 PREREQUSITES

I<Google Earth 4.x>
(L<http://earth.google.com/download-earth.html>)
installed for viewing the C<.kml> file in context.

I<Microsoft Excel> to convert the ACMA spreadsheets to C<.csv> format.
This may also be possible using Open Office (L<http://www.openoffice.org/>).

I<Perl> scripting language.
Installed by default in most Linux configurations,
installed by default in Mac OS X,
but is not installed in Windows XP or Vista.

I<Perl> is not needed if a pre-compiled version of I<rtv2kml> is used.

I<Active Perl> is a free I<perl> implementation for Windows.
It can be obtained from L<http://www.activestate.com/downloads/>.
Simply follow the prompts during installation.
This will also allow Windows to recognise a Perl script when
it's run via Command Line.

Module C<Text::CSV::Simple>. See the C<REAXME.txt> file in the distribution
for details on how to install it if necessary.
Not required for the pre-compiled version of I<rtv2kml>

=head1 DATA PREPARATION

The data in the Radio and Television Broadcasting Book Excel
spreadsheet must be converted into Excel CSV (Comma Separated Variable)
format to use in this program.

You need only convert those sheets from the Book whose data you are
interested in, for example you may only want to use the DTV (Digital
TV) sheet.

To convert, load the spreadsheet into Excel or OpenOffice Calc,
click on the tab for the sheet you want to convert, and then select
C<< File>Save As... >>.  In the file browser, select C<CSV (Comma
Delimited) *.csv> in C<Save as type:>, set the file name, then click
C<Save>.

Click C<OK> in the warning box saying thet "the selected file type
does not support workbooks", and click C<Yes> in the warning box that says that
the spreadsheet may contain features not supported by the CSV file format.

Repeat this procedure, using different file names,
for each sheet of the spreadsheet you want to convert.

B<NB:> There is nothing in the TV, Digital TV and Digital Radio
CSV files that allows
I<rtv2kml> to distinguish the data of the analog and digital TV
or digital Radio transmitters.
However, if the TV, DTV and DR data is saved into files
whose names contain the strings C<Analog> or C<Digital> and C<TV>,
or C<Digital> and C<Radio>,
then the C<.kml> files will hold the
placemarks for analog and digital TV, and digital radio in separate folders
(C<Analog TV>, C<Digital TV> and C<Digital Radio>).
For example, you might call the files something like
C<Digital_TV_Transmitters.csv> or
C<Radio-Digital.csv>.
Otherwise, all TV and Digital Radio transmitters that
can't be recognised from the file name
are placed in a C<TV> folder.


=head1 RUNNING RTV2KML ON WINDOWS SYSTEMS

=over 4

=item Download

the I<rtv2kml> package from
L<http://openwiz.org/wiki/Rtv2kml_Release>
to a convenient location in your home folder.

=item Unzip

and note the directory location of the files.
This is important as in order to run a Command Line in Windows,
you must point it towards the unzipped files.
Tick the C<Use Folder Names> option in the C<Extract> dialog
to keep things tidy.

=item Copy

the compiled version of I<rtv2kml> to a convenient location, say, C<C:>.

	mkdir C:\rtv2kml
	copy rtv2kml\Compiled\Windows\rtv2knm.exe c:\rtv2kml

=item Create the C<.csv> file(s)

you want to use from Excel
(as L<above|/DATA PREPARATION>).
It is simplest to place C<.csv> files in same location as
the installed program.

=item Open

the Windows Command Line,
found in the 'Start' menu under 'Accessories'.

=item Change to the directory

to where the program was installed. For example,
if you installed the program in C<C:\rtv2kml>,
type

        cd C:\rtv2kml

=item To run the script,

type

        rtv2kml filenameyouselected.csv > filenameyouselected.kml

If that doesn't work, use

        .\rtv2kml filenameyouselected.csv > filenameyouselected.kml

Any options go before the C<.csv> filename. For example:

        rtv2kml --towers filenameyouselected.csv > filenameyouselected.kml

This assumes that the C<.csv> files are in the same directory as
C<rtv2kml.pl>.
If they are somewhere else, you need to specify the path to them,
and to where the C<.kml> file should go.

You can use filename wildcard characters to process multiple C<.csv> files:

	rtv2kml --towers *.csv > filenameyouselected.kml

To process all the C<.csv> files in the current directory.

=item It's worked

if nothing more than a command prompt appears.

=item To use the new KML file

either double click on the KML file in
Windows Explorer, or you can load it from withing Google Earth
as explained L<below|/USING THE PLACEMARKS IN GOOGLE EARTH>. 

=back

Thanks to NPR on the Beyonwiz Forum
(L<http://www.beyonwiz.com.au/phpbb2/index.php>)
for most of this section, and for being a Windows beta tester.

=head1 INSTALLING & RUNNING RTV2KML ON UNIX-LIKE SYSTEMS

This section briefly describes how to use rtv2kml on Unix-like systems,
such as Linux, Mac OSX, Cygwin (L<http://www.cygwin.com/>) or
manufacturer's versions of Unix.

If you're reading this, you've managed to download and unzip
I<rtv2kml>.

You can either simply run I<rtv2kml> from its unzipped directory,
or you can install it in some suitable directory in your C<$PATH>.

If you want to run it from its unzipped directory, it's simplest
to download and convert the ACMA data in the same directory.

Once you've done that, simply run:

    ./rtv2kml *.csv > rtv.kml

Add in whatever options you'd like.

If you want to install I<rtv2kml>, just run C<make install> in
its unzipped directory. That will install by default in C</usr/local>,
and it creates a C<bin> subdirectory if one doesn't yet exist there.
You may not have permission to do this as a normal user, so you
may need to use C<su> or C<sudo> to do the installation there.

Alternatively, you can install in C<$HOME/bin> (the C<bin> directory
will be created if it doesn't already exist) using

    make "PREFIX=$HOME" install

I<Make> will tell you if you need to install C<Text::CSV::Simple>,
and won't proceed until

You can install a pre-compiled version (only available for
MacOS and Cygwin), which doesn't need C<Text::CSV::Simple> to be installed,
by using

	make install_bin

You can set C<PREFIX> as with C<install>.

To uninstall, run C<make uninstall> in the same way that you ran the install.

If C<Text::CSV::Simple> is needed, it can be installed using

	cpan C<Text::CSV::Simple>

There are more details about installation in the C<README.txt> file included
in the C<.zip> package.

=head1 USING THE PLACEMARKS IN GOOGLE EARTH

Once you've made the C<.kml> file containing the transmitters,
you can run Google Earth and use C<< File>Open... >>, navigate to
where the C<.kml> file is, and open it.
Move the top level folder containing the transmitter placemarks from
C<Temporary Places> into C<My Places> if you want to keep them in Google Earth
permanently.

You can save a lot of space by zipping the C<.kml> file and making
a C<.kmz> file.

Windows systems:

    zip rtv.kmz rtv.kml
    del rtv.kml

Unix-like systems:

    zip rtv.kmz rtv.kml
    rm rtv.kml

You can make the placemarks file smaller when you build it by only
selecting the states you are interested in (B<--L<state>> option) or by
simplifying the drawing of the transmitter tower (B<--L<towers>> option).

=head1 BUGS

The Radio and Television Broadcasting Book only specifies locations
of transmitters to the nearest second of arc.
While that sounds accurate, it actually allows for an error
of about 50 metres.

The Abridged Molodenskiy transformation used to transform the
AGD66 latitudes & longitudes of the ACMA data to the WGS84
latitudes and longitudes used by Google Earth adds about
another 10m uncertainty.

The transformation accuracy varies across Australia,
and can be more inaccurate outside the mainland and Tasmania.

The location errors for the Lord Howe Island sites are about 130m.
The Lord Howe Island South site is shown I<in the water>
which is unlikely to be correct!
It's not clear how much of the location error is in the coordinate
transformation and the lack of precision in the lat/long, and how much
is actual location inaccuracy.

AM transmitters are typically not a single transmitter tower, they are
more usually two towers with a horizontal antenna wire between them
(and consequently horizontal polarisation),
and the antenna wire is about 100-150m long.
The "tower" shown by I<rtv2kml> is usually located near the midpoint of the
antenna wire, between its two physical towers.
AM transmitter towers are often much narrower than TV broadcast towers,
and can often be best seen by their shadow.

The ACMA issues new broadcaster data every month.
If you want to keep up to date,
you need to download and convert the data every month.

=cut

use strict;
use warnings;

use Getopt::Long;
use Text::CSV::Simple;

sub usage {
    die "Usage: $0 [--help|-h] [--towers|-t] [--icon=iconname|-i iconname]\n",
        "                [--bytype|-b] [--state=state|-s state] csv_files...\n";
}

my %state_names = (
    ACT => 'Australian Capital Territory',
    NSW => 'New South Wales',
    NT => 'Northern Territory',
    QLD => 'Queensland',
    SA => 'South Australia',
    TAS => 'Tasmania',
    VIC => 'Victoria',
    WA => 'Western Australia',
);

my %state_folders;
my %latlong;

my ($help, $simple_towers, $by_type, $icon_name) = ((0) x 3, 'electronics');
my (@only_states, %only_states);

use constant PI      => 3.14159265358979323846;
use constant DEG2RAD => PI / 180;

# Sine of 1 second of degree
use constant SIN1SEC => 0.4848136811e-5;

# Earth semi-major axis, AGD67
use constant AGD67_a => 6378160.0;

# Earth equatorial circumference, AGD67
use constant AGD67_c => AGD67_a * 2 * PI;

# Earth polar flattening, AGD67
use constant AGD67_f => 1.0 / 298.25;
 

# Molodenskiy transform parameters to transform AGD66 lat/long (ACMA database)
# into WGS84 lat/long (Google).

my %agd67_to_wgs84 = (
    dx => -133.0,
    dy => -48.0,
    dz => 148.0,
    da => -23.000,
    df => -0.00081204e-4,
);

# Abridged Molodenskiy Formulae
# "Department of Defense World Geodetic System 1984: Its definition and
# its relationship with local geodetic systems"
#  DMA Technical Report 8350.2, 30 Sept 1978

sub molodenskiy($$$$$$)
{
    my ($in_lat, $in_lng, $a, $f, $local_datum, $dir) = @_;
    my $sinPhi = sin($in_lat * DEG2RAD);
    my $cosPhi = cos($in_lat * DEG2RAD);
    my $sinLambda = sin($in_lng * DEG2RAD);
    my $cosLambda = cos($in_lng * DEG2RAD);
    my $sin2Phi = $sinPhi * $sinPhi;
    my $sinPhi2 = sin($in_lat * 2.0 * DEG2RAD);
    my ($f_in, $a_in, $e2, $dx, $dy, $dz, $da, $df, $m1e2sin2Phi, $Rm, $Rn);

    if($dir >= 0) {
	# Input ellipsoid is the local datum
	$f_in = $f + $local_datum->{df};
	$a_in = $a + $local_datum->{da};
	$dx = $local_datum->{dx};
	$dy = $local_datum->{dy};
	$dz = $local_datum->{dz};
	$da = $local_datum->{da};
	$df = $local_datum->{df};
    } else {
	# Input ellipsoid is the base datum
	$f_in = $f;
	$a_in = $a;
	$dx = -$local_datum->{dx};
	$dy = -$local_datum->{dy};
	$dz = -$local_datum->{dz};
	$da = -$local_datum->{da};
	$df = -$local_datum->{df};
    }
    $e2 = 2.0 * $f_in - $f_in * $f_in;
    $m1e2sin2Phi = 1.0 - $e2 * $sin2Phi;

    $Rm = $a_in * (1 - $e2) / sqrt($m1e2sin2Phi * $m1e2sin2Phi * $m1e2sin2Phi);
    $Rn = $a_in/sqrt($m1e2sin2Phi);
    
    return (
	    $in_lat +
		(- $dx * $sinPhi * $cosLambda
		 - $dy * $sinPhi * $sinLambda
		 + $dz * $cosPhi
		 + ($a * $df + $f * $da)*$sinPhi2)
		    / ($Rm * SIN1SEC * 3600.),
	    $in_lng +
		(- $dx * $sinLambda + $dy * $cosLambda )
		    / ($Rn * $cosPhi * SIN1SEC * 3600.)
	);
}

sub m2deglat($) {
    my ($m) = @_;
    return $m / AGD67_c * 360;
}

sub m2deglon($$) {
    my ($m, $lat) = @_;
    return $m / AGD67_c * 360 / cos($lat * DEG2RAD);
}

sub dms2deg($) {
    my ($d, $m, $s) = split(' ', $_[0]);
    my $nsew = substr($s, -1, 1);
    $s = substr($s, 0, -1);
    return (index('NE', $nsew) >= 0)
	? ( $s / 60 + $m) / 60 + $d
	: (-$s / 60 - $m) / 60 - $d;
}

sub sitelocid($$) {
    my ($lat, $lon) = @_;
    my $id = 'loc'.$lat.$lon;
    $id =~ s/ +//g;
    return $id;
}

sub watts($) {
    my ($pow) = @_;
    return $pow > 1000
	?   ($pow / 1000) . 'kW'
	:   $pow . 'W';
}

sub mk_station($@) {
	my ($band, $place, $state, $callsign,
	    $freq, $type, $pol, $height, $pattern,
	    $power, $siteid, $sitename, $lat, $lon, $chan) = @_;

    my $sitelocid = sitelocid($lat, $lon);
    if(exists $latlong{$sitelocid}) {
	($lat, $lon) = @{$latlong{$sitelocid}};
    } else {
	($lat, $lon) = molodenskiy(dms2deg($lat), dms2deg($lon),
				    AGD67_a, AGD67_f, \%agd67_to_wgs84, 1);

    }
    return {
	band     => $band,
	place    => $place,
	state    => $state,
	callsign => $callsign,
	freq     => $freq,
	type     => $type,
	pol      => $pol,
	height   => $height,
	pattern  => $pattern,
	power    => $power,
	sitelocid=> $sitelocid,
	siteid   => $siteid,
	sitename => $sitename,
	lat      => $lat,
	lon      => $lon,
	chan     => $chan,
    };
}

sub entities($) {
    my ($str) = @_;
    $str =~ s/&/\&amp;/g;
    $str =~ s/</\&lt;/g;
    $str =~ s/>/\&gt;/g;
    $str =~ s/'/\&apos;/g;
    $str =~ s/"/\&quot;/g;
    return $str;
}

sub start_kml($) {
    my ($indent) = @_;
    print $indent.'<kml xmlns="http://earth.google.com/kml/2.0">', "\n";
}

sub end_kml($) {
    my ($indent) = @_;
    print "$indent</kml>\n";
}

sub textnode($$$) {
    my ($indent, $type, $val) = @_;
    print "$indent<$type>", entities($val), "</$type>\n";
}

sub description($$) {
    my ($indent, $desc) = @_;
    $desc =~ s/^/$indent  /gm;
    print "$indent<description>\n";
    print entities($desc);
    print "$indent</description>\n";
}

sub icon_style($$$) {
    my ($name, $scale, $url) = @_;
    printf '    <Style id="%s">
      <IconStyle>%s
        <Icon>
          <href>%s</href>
        </Icon>
        <hotSpot x="0.5" y="0" xunits="fraction" yunits="fraction"/>
      </IconStyle>
      <ListStyle>
      </ListStyle>
    </Style>
',	$name, ($scale != 1.0 ? "\n      <scale>$scale</scale>" : ''), $url;
}

sub icon_map($$$$) {
    my ($name, $nname, $hname, $url) = @_;
    printf '    <StyleMap id="%s">
      <Pair>
        <key>normal</key>
        <styleUrl>#%s</styleUrl>
      </Pair>
      <Pair>
        <key>highlight</key>
        <styleUrl>#%s</styleUrl>
      </Pair>
    </StyleMap>
',	$name, $nname, $hname;
}

sub set_icon($$) {
    my ($name, $url) = @_;
    my $normal = 'sn_' . $name;
    my $highlight = 'sh_' . $name;
    my $map = 'msn_' . $name;
    icon_style($normal, 1.0, $url);
    icon_style($highlight, 1.18182, $url);
    icon_map($map, $normal, $highlight, $url);
    return $map;
}

my @square_offsets = (
    [ -1, -1 ],
    [  1, -1 ],
    [  1,  1 ],
    [ -1,  1 ],
    [ -1, -1 ],
);

sub style_url($$) {
    my ($indent, $refname) = @_;
    textnode($indent, 'styleUrl', '#' . $refname);
}

sub lookat($$$$$$$$) {
    my ($indent, $altMode, $lon, $lat, $alt, $heading, $tilt, $range) = @_;
    print "$indent<LookAt>\n";
    textnode($indent.'  ', 'altitudeMode', $altMode);
    textnode($indent.'  ', 'longitude', "$lon");
    textnode($indent.'  ', 'latitude', "$lat");
    textnode($indent.'  ', 'altitude', "$alt");
    textnode($indent.'  ', 'heading', "$heading");
    textnode($indent.'  ', 'tilt', "$tilt");
    textnode($indent.'  ', 'range', "$range");
    print "$indent</LookAt>\n";
}

sub point($$$$$$) {
    my ($indent, $altMode, $lon, $lat, $alt, $extrude) = @_;
    print "$indent<Point>\n";
    textnode($indent.'  ', 'extrude', $extrude);
    textnode($indent.'  ', 'altitudeMode', $altMode);
    textnode($indent.'  ', 'coordinates', "$lon,$lat,$alt");
    print "$indent</Point>\n";
}

sub linestring($$$$) {
    my ($indent, $altMode, $coords, $extrude) = @_;
    print "$indent<LineString>\n";
    textnode($indent.'  ', 'extrude', $extrude);
    textnode($indent.'  ', 'altitudeMode', $altMode);
    my $coordstr = "\n";
    foreach my $c (@$coords) {
	$coordstr .= $indent."    $c->[0],$c->[1],$c->[2]\n";
    }
    $coordstr .= $indent.'  ';
    textnode($indent.'  ', 'coordinates', $coordstr);
    print "$indent</LineString>\n";
}

sub square($$$$$$$) {
    my ($indent, $altMode, $lon, $lat, $alt, $size, $extrude) = @_;
    print "$indent<Polygon>\n";
    textnode($indent.'  ', 'extrude', $extrude);
    textnode($indent.'  ', 'altitudeMode', $altMode);
    print "$indent  <outerBoundaryIs>\n";
    print "$indent    <LinearRing>\n";
    my $coords = "\n";
    my $fmt = "%s%f,%f,%f\n";
    $size /= 2;
    my($lonsize, $latsize) = (m2deglon($size, $lat), m2deglat($size));
    foreach my $off (@square_offsets) {
	$coords .= sprintf $fmt, $indent.'        ',
			    $lon+($off->[0] * $lonsize),
			    $lat+($off->[1] * $latsize),
			    $alt;
    }
    $coords .= $indent.'      ';
    textnode($indent.'      ', 'coordinates', $coords);
    print "$indent    </LinearRing>\n";
    print "$indent  </outerBoundaryIs>\n";
    print "$indent</Polygon>\n";
}

sub pillar($$$$$) {
    my ($indent, $lon, $lat, $alt, $size) = @_;
    square($indent, 'relativeToGround', $lon, $lat, $alt, $size, 1);
}

sub pyramid($$$$$) {
    my ($indent, $lon, $lat, $alt, $size) = @_;
    my $fmt = "%s%f,%f,%f\n";
    $size /= 2;
    
    my($lonsize, $latsize) = (m2deglon($size, $lat), m2deglat($size));
    foreach my $i (0..$#square_offsets - 1) {
	print "$indent<Polygon>\n";
	textnode($indent.'  ', 'altitudeMode', 'relativeToGround');
	print "$indent  <outerBoundaryIs>\n";
	print "$indent    <LinearRing>\n";
	my $coords = "\n";
	$coords .= sprintf $fmt, $indent.'        ',
				$lon+($square_offsets[$i][0] * $lonsize),
				$lat+($square_offsets[$i][1] * $latsize),
				0;
	$coords .= sprintf $fmt, $indent.'        ',
				$lon+($square_offsets[$i+1][0] * $lonsize),
				$lat+($square_offsets[$i+1][1] * $latsize),
				0;
	$coords .= sprintf $fmt, $indent.'        ',
				$lon
				, $lat
				, $alt;
	$coords .= sprintf $fmt, $indent.'        ',
				$lon+($square_offsets[$i][0] * $lonsize),
				$lat+($square_offsets[$i][1] * $latsize),
				0;
	$coords .= $indent.'      ';
        textnode($indent.'      ', 'coordinates', $coords);
	print "$indent    </LinearRing>\n";
	print "$indent  </outerBoundaryIs>\n";
	print "$indent</Polygon>\n";
    }
}

sub cross($$$$$) {
    my ($indent, $lon, $lat, $alt, $size) = @_;
    $size /= 2;
    my($lonsize, $latsize) = (m2deglon($size, $lat), m2deglat($size));
    linestring($indent, 'relativeToGround',
		    [
			[$lon-$lonsize, $lat-$latsize, $alt],
			[$lon+$lonsize, $lat+$latsize, $alt],
		    ],
		    0);
    linestring($indent, 'relativeToGround',
		    [
			[$lon+$lonsize, $lat-$latsize, $alt],
			[$lon-$lonsize, $lat+$latsize, $alt],
		    ],
		    0);
}

sub start_folder($$$$) {
    my ($indent, $name, $desc, $open) = @_;
    print "$indent<Folder>\n";
    textnode($indent.'  ','name',  $name);
    description($indent.'  ', $desc);
    textnode($indent.'  ', 'open', $open);
}

sub end_folder($) {
    my ($indent) = @_;
    print "$indent</Folder>\n";
}

sub start_document($$$$) {
    my ($indent, $name, $desc, $open) = @_;
    print "$indent<Document>\n";
    textnode($indent.'  ','name',  $name);
    description($indent.'  ', $desc);
    textnode($indent.'  ', 'open', $open);
}

sub end_document($) {
    my ($indent) = @_;
    print "$indent</Document>\n";
}

sub placemark($$$$) {
    my ($indent, $site, $vis, $icon_ref) = @_;
    return if(!@$site);
    my @stns = sort { $a->{callsign} cmp $b->{callsign} } @$site;
    print "$indent<Placemark>\n";
    textnode($indent.'  ', 'name', $stns[0]->{place});
    textnode($indent.'  ', 'visibility', $vis);
    textnode($indent.'  ', 'address', $stns[0]->{sitename});
    my $desc;
    my ($maxh, $minh) = ($stns[0]->{height}) x 2;
    foreach my $stn (@stns) {
	my $pow = $stn->{power};
	if($pow >= 1000000) {
	    $pow = sprintf '%.1fMW', $pow / 1000000;
	} elsif($pow > 1000) {
	    $pow = sprintf '%.1fkW', $pow / 1000;
	} else {
	    $pow .= 'W';
	}
	$desc .=  ($stn->{callsign} ? "<b>$stn->{callsign}</b> " : "")
	      . "$stn->{place} $stn->{freq}"
	      . ($stn->{band} ne 'AM Radio' ? 'MHz' : 'kHz')
	      . (defined($stn->{chan}) && $stn->{chan} ne ''
			? " ($stn->{chan}) "
			: "")
	      . " $pow ($stn->{pol}, $stn->{pattern}, h: $stn->{height}m)"
	      . "<br>\n";
	$maxh = $stn->{height} if($stn->{height} > $maxh);
	$minh = $stn->{height} if($stn->{height} < $minh);
    }
    description($indent.'  ', $desc);
    lookat($indent.'  ', 'relativeToGround',
		$stns[0]->{lon}, $stns[0]->{lat}, ($maxh+$minh)/2,
		0, 30, 1000);
    style_url($indent.'  ', $icon_ref);
    print "$indent  <MultiGeometry>\n";
    pyramid($indent.'    ',
		$stns[0]->{lon}, $stns[0]->{lat},
		$minh-3, ($maxh+$minh)/(2*20))
	unless($simple_towers);
    my %hascross;
    foreach my $stn (@stns) {
	if(!$hascross{$stn->{height}}) {
	    cross($indent.'    ',
			$stn->{lon}, $stn->{lat},
			 $stn->{height}, 5);
	    $hascross{$stn->{height}} = 1;
	}
    }
    point($indent.'    ', 'relativeToGround',
		$stns[0]->{lon}, $stns[0]->{lat},
		$maxh + 3, 1);
    print "$indent  </MultiGeometry>\n";
    print "$indent</Placemark>\n";
}

sub print_stations($$$$) {
    my ($indent, $band, $state, $icon_ref) = @_;
    if(keys %{$state->{$band}}) {
	start_folder($indent, "$band",
		     "$band broadcast transmitters\n", 0);
	foreach my $site (sort { $a->[0]->{place} cmp $b->[0]->{place} }
					values %{$state->{$band}}) {
	    placemark($indent.'  ', $site, 0, $icon_ref);
	}
	end_folder($indent);
    }
}

sub add_station($) {
    my ($stn) = @_;
    push @{$state_folders{$stn->{state}}->{$stn->{band}}->{$stn->{sitelocid}}},
	$stn;
}

sub include_state($) {
    my ($state_name) = @_;
    return !%only_states || $only_states{uc $state_name};
}

Getopt::Long::Configure qw/no_ignore_case bundling/;

GetOptions(
	'help|h'	=> \$help,
	'towers|t'	=> \$simple_towers,
	'bytype|b'	=> \$by_type,
	'state|s=s'	=> \@only_states,
	'icon|i=s'	=> \$icon_name,
    ) or usage;

$help and usage;

@ARGV = map { glob $_ } @ARGV if($^O eq 'MSWin32');

my $tv = 'Unknown TV';

my $icon_url = 'http://maps.google.com/mapfiles/kml/shapes/';

if(substr($icon_name, 0, 5) eq 'http:'
|| substr($icon_name, 0, 5) eq 'file:') {
    $icon_url = $icon_name;
} else {
    $icon_url .= $icon_name;
    $icon_url .= '.png' if(substr($icon_name, -5, 5) ne '.png');
}

foreach my $state_name (@only_states) {
    my $ucsn = uc $state_name;
    if($state_names{$ucsn}) {
	$only_states{uc $state_names{$ucsn}} = 1;
    } else {
	$only_states{$ucsn} = 1;
    }
}

my $csv_parser = Text::CSV::Simple->new;

foreach my $ARGV (@ARGV) {
    my @csv_data = $csv_parser->read_file($ARGV);
    foreach my $F (@csv_data) {
	my @F = @$F;
	if($F[0] =~ /Area Served/) {
	    $tv = 'TV';
	    if($ARGV =~ /TV/) {
		if($ARGV =~ /Analog/) {
		    $tv = 'Analog TV';
		} elsif($ARGV =~ /Digital/) {
		    $tv = 'Digital TV';
		}
	    } elsif($ARGV =~ /Radio/) {
		$tv = 'Radio';
		if($ARGV =~ /DigitalRadio/) {
		    $tv = 'Digital Radio';
		}
	    }
	    next;
	}

#		mkstation($band, $place, $state, $callsign,
#		    $freq, $type, $pol, $height, $pattern,
#		    $power, $siteid, $sitename, $lat, $lon, $chan)

	if(@F == 24) {
	    $F[18] = $state_names{$F[18]} if(exists($state_names{$F[18]}));
	    add_station(mk_station('AM Radio', @F[0,18,1,2,3,4,5,6,8,11,12,16,17]))
		if(include_state($F[18]));
	} elsif(@F == 22) {
	    $F[17] = $state_names{$F[17]} if(exists($state_names{$F[17]}));
	    add_station(mk_station('FM Radio', @F[0,17,1,2,3,4,5,6,7,10,11,15,16]))
		if(include_state($F[17]));
	} elsif(@F == 23) {
	    $F[17] = $state_names{$F[17]} if(exists($state_names{$F[17]}));
	    add_station(mk_station($tv, @F[0,17,1,2,3,4,5,6,7,10,11,15,16,18]))
		if(include_state($F[17]));
	} elsif(@F == 28) {
	    $F[19] = $state_names{$F[19]} if(exists($state_names{$F[19]}));
	    if($F[27] eq 'AM Radio') {
		add_station(mk_station($F[27], @F[0,19,1,2,3,4,5,6],
					       @F[9,12,13,17,18,20]))
		    if(include_state($F[19]));
	    } elsif($F[27] eq 'FM Radio'
		 || $F[27] eq 'Digital TV'
		 || $F[27] eq 'Analog TV') {
		$F[2] /= 1000;
		add_station(mk_station($F[27], @F[0,19], ($F[1] ? $F[1] : $F[3]),
					       @F[2,3,4,5,6,7,12,13,17,18,20]))
		    if(include_state($F[19]));
	    }
	} else {
	    warn "Unrecognised line: $_\n";
	}
	my $len = 13;
    }
}

sub state_has_stations($@) {
    my ($state_name, @bands) = @_;
    my $has_stations;
    my $state = $state_folders{$state_name};
    foreach my $band (@bands) {
	$has_stations |= keys %{$state->{$band}} if($state->{$band});
    }
    return $has_stations;
}

sub has_stations(@) {
    my (@bands) = @_;
    foreach my $state_name (sort keys %state_folders) {
	return 1 if(state_has_stations($state_name, @bands));
    }
    return 0;
}

sub print_transmitters($$$@) {
    my ($indent, $is_document, $icon_ref, @bands) = @_;
    my ($rtv, $Rtv) = ('', '');
    if(has_stations(grep /radio/i, @bands)) {
	$rtv = 'radio';
	$Rtv = 'Radio';
    }
    if(has_stations(grep /tv/i, @bands)) {
	if($rtv) {
	    $rtv .= ' & ';
	    $Rtv .= ' & ';
	}
	$rtv .= 'TV';
	$Rtv .= 'TV';
    }
    my $show_folder;
    foreach my $state_name (sort keys %state_folders) {
	my $state = $state_folders{$state_name};
	foreach my $band (@bands) {
	    $show_folder |= keys %{$state->{$band}} if($state->{$band});
	}
    }

    if($show_folder) {
	if($is_document) {
	    start_document($indent, "Australian $Rtv",
			 "Australian $rtv broadcast transmitters\n", 0);
	    $icon_ref = set_icon('rtv_tower', $icon_url);
	} else {
	    start_folder($indent, "Australian $Rtv",
			 "Australian $rtv broadcast transmitters\n", 0);
	}

	foreach my $state_name (sort keys %state_folders) {
	    if(include_state($state_name)
	    && state_has_stations($state_name, @bands)) {
		my $state = $state_folders{$state_name};
		start_folder($indent.'  ', $state_name,
			     "$state_name $rtv broadcast transmitters\n", 0);
		foreach my $band (@bands) {
		    print_stations($indent.'      ', $band, $state, $icon_ref)
			if($state->{$band});
		}
		end_folder($indent.'  ');
	    }
	}

	if($is_document) {
	    end_document($indent);
	} else {
	    end_folder($indent);
	}
    }
}

start_kml('');

if($by_type) {
    start_document('  ', "Australian Broadcasters",
		 "Australian Broadcast transmitters\n", 1);

    my $icon_ref = set_icon('rtv_tower', $icon_url);

    print_transmitters('    ', 0, $icon_ref,
			    'Digital TV', 'Analog TV', 'TV');
    print_transmitters('    ', 0, $icon_ref,
			    'Digital Radio', 'FM Radio', 'AM Radio');

    end_document('  ');
} else {
    print_transmitters('  ', 1, undef,
		'Digital TV', 'Analog TV', 'TV',
		'Digital Radio', 'FM Radio', 'AM Radio');
}
end_kml('');
