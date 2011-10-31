Status of Linux code as of 31/October/2011

It works.  Sort of.  :)

Spectrum display is currently not functional.

KV Decoder is not implemented so it's BM only.

Decoder output list box doesn't act exactly as expected.
First, it doesn't scroll to keep newest item in view as
it does under Win32 and secondly it doesn't show an item
as selected when clicked.

libJT65.so must be manually place in library search path,
should be /usr/local/lib then you must run ldconfig to
update library cache.

Requires fftw3, libsamplerate, portaudio19 (or portaudio2
depending on what you want to call it) and libgfortran3 to
be present.

Depends upon PulseAudio being present and operational as
I have relied upon PulseAudio to do most of the work for
sound device selection.

Probably will only work reasonably as expected with Ubuntu
10.04.  Ubuntu 11.xx is a nightmare, buttons don't work --
menu items work one second and not the next.  Seriously --
don't even think of playing with this on anything other than
Ubuntu 10.04 (using 10.04 LTS here).
