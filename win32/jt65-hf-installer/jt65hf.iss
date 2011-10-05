; -- Example1.iss --
; Demonstrates copying 3 files and creating an icon.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=JT65-HF-1.0.8
AppVerName=JT65-HF 1.0.8
DefaultDirName={pf}\jt65hf108
DefaultGroupName=JT65-HF-V108
UninstallDisplayIcon={app}\jt65-hf.exe
Compression=lzma/Max
SolidCompression=true
LicenseFile=license.txt
OutputDir=.
AppCopyright=(c)2009...2011 J C Large W6CQZ
PrivilegesRequired=none
MinVersion=,5.1.2600
VersionInfoVersion=1.0.8
VersionInfoCompany=W6CQZ
VersionInfoDescription=JT65A for HF
VersionInfoTextVersion=JT65-HF 1.0.8
VersionInfoCopyright=(c)2009...2011 J C Large W6CQZ
VersionInfoProductName=JT65-HF
VersionInfoProductVersion=1.0.8

[InstallDelete]
Type: files; Name: "{app}\gpl-2.0.txt"
Type: files; Name: "{app}\HRDInterface001.dll"
Type: files; Name: "{app}\jl_libfftw3f.dll"
Type: files; Name: "{app}\jl-libportaudio-2.dll"
Type: files; Name: "{app}\jl-libsamplerate.dll"
Type: files; Name: "{app}\jt65.dll"
Type: files; Name: "{app}\jt65-hf.exe"
Type: files; Name: "{app}\libfftw3f-3.dll"
Type: files; Name: "{app}\libfftw3f.dll"
Type: files; Name: "{app}\libusb0.dll"
Type: files; Name: "{app}\PSKReporter.dll"
Type: files; Name: "{app}\HRDInterface0014.dll"
Type: files; Name: "{app}\HRDInterface0015.dll"
Type: files; Name: "{app}\sg-jt65-hf.exe"
Type: files; Name: "{app}\KVASD_g95.exe"
Type: filesandordirs; Name: "{app}\hamlib"
Type: filesandordirs; Name: "{app}\optfft"

[Files]
Source: "jt65-hf.exe"; DestDir: "{app}"
Source: "sg-jt65-hf.exe"; DestDir: "{app}"
Source: "KVASD_g95.EXE"; DestDir: "{app}"
Source: "jl_libfftw3f-3.dll"; DestDir: "{app}"
Source: "libfftw3f-3.dll"; DestDir: "{app}"
Source: "jt65.dll"; DestDir: "{app}"
Source: "jl-libportaudio-2.dll"; DestDir: "{app}"
Source: "jl-libsamplerate.dll"; DestDir: "{app}"
Source: "PSKReporter.dll"; DestDir: "{app}"
Source: "HRDInterface0014.dll"; DestDir: "{app}"
Source: "HRDInterface0015.dll"; DestDir: "{app}"
Source: "libusb0.dll"; DestDir: "{app}"
Source: "gpl-2.0.txt"; DestDir: "{app}"
Source: "jt65-hf-setup.pdf"; DestDir: "{app}"
Source: "hamlib\*.*"; DestDir: "{app}\hamlib"
Source: "hamlib\rig_dde\*.*"; DestDir: "{app}\hamlib\rig_dde"
Source: "optFFT\*.*"; DestDir: "{app}\optFFT"
Source: "placeholder"; DestDir: "{localappdata}\JT65-HF"

[Run]
Filename: "{app}\optFFT\jt65-hf.exe"; Flags: postinstall; Description: "Setup indicates it should update optimal FFT calculations.  This will take from 10 to 20+ minutes.  If you do not wish to do this uncheck the box to left of this text!"; Check: optFFTCheck()

[Icons]
Name: "{group}\JT65-HF"; Filename: "{app}\jt65-hf.exe"
Name: "{group}\JT65-HF Small GUI"; Filename: "{app}\sg-jt65-hf.exe"
Name: "{group}\Uninstall JT65-HF"; Filename: "{uninstallexe}"
Name: "{group}\Documentation"; Filename: "{app}\jt65-hf-setup.pdf"

[CODE]
function optFFTCheck(): Boolean;
Var
  fname : String;
Begin
  fname := ExpandConstant('{localappdata}')+'\JT65-HF\wisdom2.dat';
  // The logic is somewhat reversed from what might seem correct
  // here.  I want to run optfft if the file DOES NOT exist thus
  // the seemingly backward return result.
  If FileExists(fname) Then result := False else result := True;
End;
