Linux, Mac OSX, Cygwin & other Unix or Unix-like environments
=============================================================

rtv2kml is written in the scripting language Perl (http://www.perl.org/).
Perl is almost always part of the installation environment in
Unix-like environments. If it's not installed on a Linux system,
use the appropriate package manager to install it. On Cygwin, use
the Cygwin Setup installer and make sure "Interpreters, Perl" is
set for installation.

Installing the pre-compiled rtv2kml
===================================

Installing the pre-compiled (really "pre-packaged") rtv2kml simplifies
installation & use, because the installation includes everything that's
needed to run rtv2kml, so there is no need to install any perl packages.

However, contrary to what you might expect from the name, the
"pre-compiled" version runs slower than the perl script version.
Because rtv2kml isn't normally run very often, the convenience may outweigh
the loss of performance.

The Makefile should make it easy to install the tools on Unix-like
systems.

Install with
	make install_bin

The PREFIX variable in the Makefile determines where the
installed files will go.
Set PREFIX (distributed as /usr/local) to the base directory where
you want to do the installation. Installs in $(PREFIX)/bin.

Either edit PREFIX in the Makefile or use
	make PREFIX=/my/install/directory ...
to install somewhere else.

Uninstall with
	make uninstall

Use the same PREFIX for the uninstall as you used for install.

Run using
	rtv2kml

Installing the rtv2kml.pl perl script
=====================================

The Makefile should make it relatively easy to install the tools
on Unix-like systems.

Install with
	make install

The PREFIX variable in the Makefile determines where the
installed files will go.
Set PREFIX (distributed as /usr/local) to the base directory where
you want to do the installation. Installs in $(PREFIX)/bin.

Either edit PREFIX in the Makefile or use
	make PREFIX=/my/install/directory ...
to install somewhere else.

Uninstall with
	make uninstall

Use the same PREFIX for the uninstall as you used for install.

Build the documentation (pre-built documentation is distributed in
the distribution ZIP file) if you need to with:
	make doc

HTML documentation will be placed in the html subdirectory of the
distribution. An index to the HTML documentation is placed in
html/index.html. Plain text documentation will be placed in the doc
directory.

If you don't have the Perl library path in your Perl includes,
you'll need to add that directory to the PERLLIB environment variable.
You'll also need to put $(PREFIX)/bin in your PATH variable.

If, when you run rtv2kml, you get an error like:

	Can't locate Text/CSV/Simple.pm in @INC...

you'll need to install some Perl modules. The CPAN library allows
you to download and install packages easily. CPAN uses the Perl
programming convention for naming modules. In the module name (such
as Text/CSV/Simple.pm) change all of the '/'s to '::' and drop
the '.pm'. So to download the package that's missing in  that error
message, just run:

	cpan Text::CSV::Simple

The Perl module that you are most likely to need to install is:
	Text::CSV::Simple

Running:
	make install
also checks whether the installation needs any modules that aren't available,
and won't complete the installation unless the modules are installed.

You can just run this check by running
	make check

Run using
	rtv2kml.pl

Windows
=======

There's no installation script for rtv2kml for Windows.

Installing the pre-compiled rtv2kml
===================================

Installing the pre-compiled (really "pre-packaged") rtv2kml simplifies
installation & use, because the installation includes everything that's
needed to run rtv2kml, so there is no need to install any perl packages.

However, contrary to what you might expect from the name, the
"pre-compiled" version runs slower than the perl script version.
Because rtv2kml isn't normally run very often, the convenience may outweigh
the loss of performance.

Unpack rtv2kml.zip into a suitable location in your home folder,
then copy rtv2kml\Windows\rtv2kml.exe into a suitable place to run
it from (say, in C:\Program Files\rtv2kml) and add its directory (C:\Program
Files\rtv2kml if you've installed there) to your PATH environment
variable. You can run rtv2kml\Windows\rtv2kml.exe from that location
if you wish to avoid cluttering up C:\Program Files.

Installing the rtv2kml.pl perl script
=====================================

rtv2kml is written in the scripting language Perl (http://www.perl.org/).
Perl is not part of the Windows standard installation. rtv2kml
is known to work with the free version of ActivePerl
(http://www.activestate.com/).  Use version 5.10.0.1003 or more
recent.

The simplest perl script installation is to unpack rtv2kml into a
suitable location (say, in C:\Program Files) and add its directory
(C:\Program Files\rtv2kml if you've installed there) to your PATH
environment variable.

If, when you run rtv2kml, you get an error like:

	Can't locate Text/CSV/Simple.pm in @INC...

you'll need to install some Perl modules. If you're using ActivePerl,
use the ActivePerl PPM library to get the module. PPM uses the Perl
form for naming modules. In the module name (such as
Text/CSV/Simple.pm) change all of the '/'s to '::' and drop
the '.pm'. So (at least in principal) to download the package that's
missing in that error message, just run:

	ppm install Text::CSV::Simple

The Perl module that you are most likely to need to install is:
	Text::CSV::Simple

Running:
	@checkModules
checks whether the installation needs any modules that aren't available.
