JT65-HF (c) 2009...2011 J C Large - W6CQZ
GPL Open Source

Files

setup-JT65-HF1082.exe     Latest version, released October 8th, 2011. Scroll down for change log.

jt65repair.exe

     Configuration repair utility.  In case of invalid and/or corrupted configuration this
     program will either repair the error or remove configuration so JT65-HF can be started
     again.

jt65-hf-setup.pdf

     Documentation for JT65-HF. [Outdated]

readme.txt

     What you are reading now.

setup-JT65-HF1070.exe     Previous version.

You only need the latest setup file to install or update.  The setup/documentation guide
is included with the installer.  Version 1080 and beyond also include the repair utility.

For questions see the JT65-HF support group at: https://groups.google.com/forum/?hl=en#!forum/jt65-hf


Change Log

Version 1.0.8.2

Corrected issue with QRG value being (like) 28.076,30 or 28,076.30
Previous versions correctly handled 28,076.30 but not 28.076,30.

Changed internal order of program startup such that configuration
and audio device startup is verfied and set before starting decoder,
RB and rig control threads.  Attempting to avoid a double malfunction
where both audio startup and rig control have issue.  Won't fix that,
but, at least, should isolate the two events making debug easier.

Modified message generator to once again handle case of exchange like
CQ W6cqz [No grid sent and callsign not slashed].

Version 1.0.8.1

Corrected issue with local settings using , as decimal point leading to
failure of message parser.

Enabled searching internal heard callsign database list via Station Heard
menu option.


Version 1.0.8

Corrected issue with phantom decodes due to KVASD.DAT being left from
previous passes.

Corrected issue with invalid callsigns and grids leading to unexpected
transmission results.

Corrected issue with some logging programs having trouble with ADIF file
generated.  Added header and insured all fields match recent ADIF specs.

Added ability to set a DT (Delta Time) offset.

Added ability to disable Waterfall display by setting speed value to
-1.  Waterfall will be enabled again if TX is enabled (or speed set
> -1).

Added ability to set a smaller search resolution for multiple decoder.
Now supports 20, 50, 100 and 200 Hz bin resolutions.  100 Hz is default
as seein in 1.0.7.  Smaller resolutions can result in more decodes at
cost of (potentially far longer) decode time.

Revised RB code.  Should be little if any impact on user side, mainly
an attempt to modernize the server side RB code and lessen its impact
on my server hardware.

Added internal database holding all callsigns heard, bands heard upon
and first/last heard dates.

Added validation routines to input fields such that characters not in
the JT65 character set are excluded from entry.

Reworked frequency entry validation to better cope with values entered
as MHz, KHz or even Hz and usage of , or . as decimal point.

Removed WARC band frequencies from hard coded QRG listing.  Too little
agreement on what works globally to have these things hard coded.

Added additional user defined frequency and message fields.

