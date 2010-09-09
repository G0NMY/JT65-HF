unit d4;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CTypes, globalData, samplerate, math, diagout,
  Types, StrUtils, rawDec; //Process

Const
  JT_DLL = 'jt65.dll';
  WordDelimiter = [' '];
  CsvDelim = [','];

Type
   decodeRec4 = Record
      numSync   : Integer;
      dsigLevel : Integer;
      deltaTime : Single;
      deltaFreq : Single;
      sigW      : Integer;
      cSync     : String;
      bDecoded  : String;
      kDecoded  : String;
      sDecoded  : String;
      timeStamp : String;
   end;

    d4Result = Record
      dtTimeStamp : String;
      dtNumSync   : String;
      dtSigLevel  : String;
      dtDeltaTime : String;
      dtDeltaFreq : String;
      dtSigW      : String;
      dtCharSync  : String;
      dtDecoded   : String;
      dtDisplayed : Boolean;
      dtProcessed : Boolean;
      dtType      : String;
    end;

Var
   gl4myline, gl4wisfile, gl4kvs    : PChar;
   gl4mcall, gl4mline, gl4kvfname   : PChar;
   gl4timestamp                     : String;
   gl4decOut, gl4rawOut, gl4sort1   : TStringList;
   gl4firstrun, gl4inprog           : Boolean;
   gl4HaveDecodes                   : Boolean;
   gl4decoderPass                   : CTypes.cint;
   gl4MouseDF,gl4Nblank             : CTypes.cint;
   gl4Nshift, gl4DFTolerance        : CTypes.cint;
   gl4Nafc, gl4Nzap, gl4mode65      : CTypes.cint;
   gl4stepBW, gl4steps, gl4binspace : CTypes.cint;
   gl4fftFWisdom, gl4fftSWisdom     : CTypes.cint;
   gl4inBuffer                      : Array[0..661503] of CTypes.cint16;
   gl4f1Buffer, gl4f2Buffer         : Array[0..661503] of CTypes.cfloat;
   gl4f3Buffer, gl4lpfM             : Array[0..661503] of CTypes.cfloat;
   gl4decodes                       : Array[0..49] of d4Result;

procedure doDecode4(bStart, bEnd : Integer);

implementation

procedure  msync4(dat,
                  jz,
                  syncount,
                  dtxa,
                  dfxa,
                  snrxa,
                  snrsynca,
                  ical,
                  wisfile : Pointer
                 ); cdecl; external JT_DLL name 'msync4_';

procedure unpack4(dat,
                 msg : Pointer
                ); cdecl; external JT_DLL name 'unpackmsg_';

procedure    cqz4(dat,
                  jz,
                  DFTolerance,
                  MouseDF2,
                  idf,
                  mline,
                  ical,
                  wisfile,
                  kvfile : Pointer
                 ); cdecl; external JT_DLL name 'cqz4_';

procedure   lpf14(dat,
                  jz,
                  nz,
                  mousedf,
                  mousedf2,
                  ical,
                  wisfile : Pointer
                 ); cdecl; external JT_DLL name 'lpf1_';

function      db4(x : CTypes.cfloat) : CTypes.cfloat;
Begin
     Result := -99.0;
     if x > 1.259e-10 Then Result := 10.0 * log10(x);
end;

function  evalBM4(s : String) : Boolean;
Var
   wcount : Integer;
   w      : String;
Begin
     Result := False;
     // Looking for a BM decode
     wcount := WordCount(s,CsvDelim);
     if wcount < 7 Then
     Begin
          Result := False;
     End
     Else
     Begin
          w := ExtractWord(7,s,CsvDelim);
          if Length(TrimLeft(TrimRight(w))) > 0 Then
          Begin
               if TrimLeft(TrimRight(w)) = '***WRONG MODE?***' Then Result := False else Result := True;
          End
          Else
          Begin
               Result := False;
          End;
     End;
end;

Function  evalKV4(Var kdec : String) : Boolean;
//Var
   //kvSec2, kvCount, ierr, i : CTypes.cint;
   //kvProc                   : TProcess;
   //kvDat                    : Array[0..11] of CTypes.cint;
   //kvFile                   : File Of CTypes.cint;
Begin
     // Looking for a KV decode
     Result := false;
     //kdec := '';
     //gl4kvs := '                      ';
     //for i := 0 to 11 do
     //Begin
          //kvDat[i] := 0;
     //End;
     //ierr := 0;
     //kvProc := TProcess.Create(nil);
     //kvProc.CommandLine := 'kvasd_g95.exe -q';
     //kvProc.Options := kvProc.Options + [poWaitOnExit];
     //kvProc.Options := kvProc.Options + [poNoConsole];
     //kvProc.Execute;
     //ierr := kvProc.ExitStatus;
     //if ierr = 0 Then
     //Begin
          //Try
             //// read kvasd.dat
             //AssignFile(kvFile, 'KVASD.DAT');
             //Reset(kvFile);
             //If FileSize(kvfile) > 256 Then
             //Begin
                  //// Seek to nsec2 (256)
                  //Seek(kvFile,256);
                  //Read(kvFile, kvsec2);
                  //Seek(kvFile,257);
                  //Read(kvFile, kvcount);
                  //For i := 258 to 269 do
                  //Begin
                       //Seek(kvFile, i);
                       //Read(kvFile, kvDat[i-258]);
                  //End;
                  //CloseFile(kvFile);
                  //if kvCount > -1 Then
                  //Begin
                       //unpack4(@kvDat[0],gl4kvs);
                  //End
                  //Else
                  //Begin
                       //// No decode, kvasd failed to reconstruct message.
                       //Result := False;
                       //kdec := '';
                  //End;
             //End
             //Else
             //Begin
                  //CloseFile(kvFile);
                  //Result := False;
                  //kdec := '';
             //End;
          //except
             //Result := False;
             //kdec := '';
          //end;
     //End
     //Else
     //Begin
          //// No decode, error status returned from kvasd.exe
          //Result := False;
          //kdec := '';
     //End;
     //kvProc.Destroy;
     //if FileExists('KVASD.DAT') Then DeleteFile('KVASD.DAT');
     //kdec := TrimLeft(TrimRight(StrPas(gl4kvs)));
     //if (Length(kdec) > 0) And (kvCount > -1) Then
     //Begin
          //Result := True;
     //End
     //Else
     //Begin
          //// No decode, kvasd messge too short or SNR too low.
          //Result := False;
          //kdec := '';
     //End;
end;

procedure doDecode4(bStart, bEnd : Integer);

Var
   i, k, n                       : CTypes.cint;
   jz, nave                      : CTypes.cint;
   ifoo, ndec                    : CTypes.cint;
   foo, kdec                     : String;
   allEqual, haveDupe            : Boolean;
   sum, ave, avg, threshold      : CTypes.cfloat;
   xmag, avesq, basevb, sq       : CTypes.cfloat;
   ffoo                          : CTypes.cfloat;
   samratio                      : CTypes.cdouble;
   sampconv                      : samplerate.SRC_DATA;
   lical, idf                    : CTypes.cint;
   bw, afc, ierr                 : CTypes.cint;
   lmousedf, mousedf2, jz2, j    : CTypes.cint;
   wcount, strongest             : CTypes.cint;
   dupeFoo                       : String;
   decode                        : decodeRec4;
   syncount                      : CTypes.cint;
   dfxa                          : Array[0..254] Of CTypes.cfloat;
   snrsynca                      : Array[0..254] Of CTypes.cfloat;
   snrxa                         : Array[0..254] Of CTypes.cfloat;
   dtxa                          : Array[0..254] Of CTypes.cfloat;
   bins                          : Array[0..100] Of CTypes.cint;
   //filtLow, filtHi               : CTypes.cfloat;
   passcount, passtest, binspace : CTypes.cint;
begin
     gl4inprog := True;
     gl4HaveDecodes := False;
     if gl4FirstRun Then
     Begin
         //
         // ical =  0 = FFTW_ESTIMATE set, no load/no save wisdom.  Use ical = 0 when all else fails.
         // ical =  1 = FFTW_MEASURE set, yes load/no save wisdom.  Use ical = 1 to load saved wisdom.
         // ical = 11 = FFTW_MEASURE set, no load/no save wisdom.  Use ical = 11 when wisdom has been loaded and does not need saving.
         // ical = 21 = FFTW_MEASURE set, no load/yes save wisdom.  Use ical = 21 to save wisdom.
         //
         lical := gl4fftFWisdom;
         gl4mline := StrAlloc(72);
         gl4mcall := StrAlloc(12);
         gl4myline := StrAlloc(43);
         gl4kvs := StrAlloc(22);
         {$IFDEF win32}
           gl4wisfile := StrAlloc(Length(GetAppConfigDir(False)+'\wisdom2.dat')+1);
         {$ENDIF}
         {$IFDEF linux}
           gl4wisfile := StrAlloc(Length(GetAppConfigDir(False)+'wisdom2.dat')+1);
         {$ENDIF}
         gl4kvfname := StrAlloc(Length('KVASD.DAT')+1);
         gl4decOut := TStringList.Create;
         gl4rawOut := TStringList.Create;
         gl4decOut.CaseSensitive := False;
         gl4decOut.Sorted := True;
         gl4decOut.Duplicates := Types.dupIgnore;
         gl4rawOut.CaseSensitive := False;
         gl4rawOut.Sorted := False;
         gl4rawOut.Duplicates := Types.dupIgnore;
         gl4sort1 := TStringList.Create;
         gl4sort1.CaseSensitive := False;
         gl4sort1.Sorted := False;
         gl4sort1.Duplicates := Types.dupIgnore;
         // Clear internal buffers
         for i := 0 to 661503 do
         Begin
              gl4f1Buffer[i] := 0.0;
              gl4f2Buffer[i] := 0.0;
              gl4f3Buffer[i] := 0.0;
              gl4lpfM[i] := 0.0;
         end;
      End
      Else
      Begin
           lical := gl4fftSWisdom;
           // Clear internal buffers
           for i := 0 to 661503 do
           Begin
                gl4f1Buffer[i] := 0.0;
                gl4f2Buffer[i] := 0.0;
                gl4f3Buffer[i] := 0.0;
                gl4lpfM[i] := 0.0;
           end;
      End;
      // General housekeeping for a start of decoder cycle
      diagout.Form3.ListBox1.Clear;
      diagout.Form3.ListBox2.Clear;
      diagout.Form3.ListBox3.Clear;
      strPcopy(gl4kvfname,'KVASD.DAT');
      {$IFDEF win32}
        strPcopy(gl4wisfile,GetAppConfigDir(False)+'\wisdom2.dat');
      {$ENDIF}
      {$IFDEF linux}
        strPcopy(gl4wisfile,GetAppConfigDir(False)+'wisdom2.dat');
      {$ENDIF}
      gl4mline := '                                                                        ';
      gl4mcall := '            ';
      gl4myline := '                                           ';
      // [d4.]inBuffer contains 16 bit signed integer input samples and has
      // been populated from maincode.
      diagout.Form3.ListBox1.Items.Add('D4:  Convert int16 buffer to float.');
      // Convert inBuffer to f3buffer (int16 to float)
      sum := 0.0;
      nave := 0;
      for i := bStart to bEnd do
      Begin
           sum := sum + gl4inBuffer[i];
      End;
      nave := Round(sum/bEnd);
      if nave <> 0 Then
      Begin
           for i := bStart to bEnd do
           Begin
                gl4inBuffer[i] := min(32766,max(-32766,gl4inBuffer[i]-nave));
           End;
      End
      Else
      Begin
           for i := bStart to bEnd do
           Begin
                gl4inBuffer[i] := min(32766,max(-32766,gl4inBuffer[i]));
           End;
      End;
      If gl4Nblank > 0
      Then
      Begin
           diagout.Form3.ListBox1.Items.Add('Apply NB');
           // Noise blanker requested.
           avg       := 700.0;
           threshold := 5.0;
           xmag      := 0.0;
           for i := bStart to bEnd do
           Begin
                xmag := abs(gl4inBuffer[i]);
                avg  := 0.999*avg + 0.001*xmag;
                if xmag > threshold*avg Then gl4inBuffer[i] := 0;
           End;
      End;
      sum := 0.0;
      ave := 0.0;
      for i := bStart to bEnd do
      Begin
           gl4f3Buffer[i] := 0.1 * gl4inBuffer[i];
           sum := sum + gl4f3Buffer[i];
      End;
      ave := sum/bEnd;
      if ave <> 0.0 Then
      Begin
           for i := bStart to bEnd do
           Begin
                gl4f3Buffer[i] := gl4f3Buffer[i]-ave;
           End;
      End;
      // Int16 converted to float, now resample if needed.  If no resample
      // then copy f3Buffer to f1Buffer.
      if globalData.d65samfacin <> 1.0 Then
      Begin
           diagout.Form3.ListBox1.Items.Add('SR Correction being applied.');
           // Resample f3Buffer placing resample into f2Buffer
           samratio := 1.0/globalData.d65samfacin;
           ierr := -1;
           sampconv.data_in  := gl4f3Buffer;
           sampconv.data_out := gl4f2Buffer;
           sampconv.input_frames  := bEnd+1;
           sampconv.output_frames := bEnd+1;
           sampconv.src_ratio     := samratio;
           ierr := samplerate.src_simple(@sampconv,2,1); //(@sampconv,type,channels) type 2 = fastest, type 0 = best quality
           if ierr = 0 Then
           Begin
                diagout.Form3.ListBox1.Items.Add('SR Correction complete.');
                // Conversion success.  f2Buffer now has valid resampled data.
                // Setting new bEnd value as it may have changed due to resample.
                bEnd := sampconv.output_frames_gen+1;
                // Now copy f2Buffer to f1Buffer
                for i := bStart to bEnd do
                Begin
                     gl4f1Buffer[i] := gl4f2Buffer[i];
                end;
           end
           else
           begin
                // Conversion failed.  f3Buffer will need to be copied to f1Buffer
                diagout.Form3.ListBox1.Items.Add('SR Correction error, using uncorrected samples.');
                for i := bStart to bEnd do
                Begin
                     gl4f1Buffer[i] := gl4f3Buffer[i];
                end;
           end;
      End
      Else
      Begin
           // No resample so need to manually copy f3Buffer to f1Buffer
           diagout.Form3.ListBox1.Items.Add('No SR Correction needed, using uncorrected samples.');
           for i := bStart to bEnd do
           Begin
                gl4f1Buffer[i] := gl4f3Buffer[i];
           end;
      end;
      jz := bEnd;
      // From this point on f1Buffer becomes sole sample holder.
      // Figure average level
      sq := 0.0;
      for i := bStart to bEnd do
      begin
           ffoo := gl4f1Buffer[i];
           if ffoo <> 0 Then sq := sq + power(ffoo,2);
      end;
      avesq := sq/jz;
      basevb := db4(avesq) - 44;
      diagout.Form3.ListBox1.Items.Add('avesq = ' + floatToStr(avesq) + ' basevb = ' + floatToStr(basevb));
      if (avesq <> 0.0) And (basevb > -16.0) And (basevb < 21.0) Then
      Begin
           ndec := 0;
           // Run msync
           lmousedf := 0;
           jz2 := 0;
           mousedf2 := 0;
           for i := 0 to jz do
           Begin
                gl4lpfM[i] := gl4f1Buffer[i];
           end;
           lpf14(@gl4lpfM[0], @jz, @jz2, @lmousedf, @mousedf2, @lical, gl4wisfile);
           diagout.Form3.ListBox1.Items.Add('LPF applied.');
           // msync will want a downsampled and lpf version of data.
           // Copy lpfM to f3Buffer
           for j := 0 to jz2 do
           Begin
                gl4f3Buffer[j] := gl4lpfM[j];
           end;
           for j := jz2+1 to 661503 do
           Begin
                gl4f3Buffer[j] := 0.0;
           end;
           for i := 0 to 254 do
           begin
                dtxa[i]     := 0.0;
                dfxa[i]     := 0.0;
                snrxa[i]    := 0.0;
                snrsynca[i] := 0.0;
           end;
           // Clear the bins
           for i := 0 to 100 do
           begin
                bins[i] := 0;
           end;
           syncount := 0;
           msync4(@gl4f3Buffer[0],@jz2,@syncount,@dtxa[0],@dfxa[0],@snrxa[0],@snrsynca[0],@lical,gl4wisfile);
           // Syncount is number of potential sync points.
           if syncount > 0 Then
           Begin
                diagout.Form3.ListBox1.Items.Add('MSync found ' + IntToStr(syncount) + ' probable sync points');
                // Get bin spacing
                if gl4steps = 1 Then
                Begin
                     binspace := gl4binspace;
                     // Now... take the syncount list and place a 'tick' in each
                     // 'bin' where a sync detect has been found.
                     // 2000 Hz / 20 Hz = 100 bins. (101 actually)
                     // JT4A is ~ 17.5Hz wide.  It will make sense to use 20/10 stepping and restrict the
                     // passband from 2K to something more like 500hz or so....  The > 20 binspace makes
                     // little (if any) sense for JT4A.
                     //if binspace = 10 Then diagout.Form3.ListBox1.Items.Add('Using 71 bins [10Hz bin spacing]');
                     if binspace = 20 Then diagout.Form3.ListBox1.Items.Add('Using 101 bins [20Hz bin spacing]');
                     if binspace = 50 Then diagout.Form3.ListBox1.Items.Add('Using 41 bins [50Hz bin spacing]');
                     if binspace = 100 Then diagout.Form3.ListBox1.Items.Add('Using 21 bins [100Hz bin spacing]');
                     if binspace = 200 Then diagout.Form3.ListBox1.Items.Add('Using 11 bins [200Hz bin spacing]');
                     for i := 0 to syncount-1 do
                     begin
                          passtest := trunc(dfxa[i]);
                          If binspace = 20 Then
                          Begin
                               // 20 Hz Bins
                               Case passtest of
                               -1010..-990         : inc(bins[0]);  // -1000 +/- 10
                               -989..-970          : inc(bins[1]);  // -980 +/- 10
                               -969..-950          : inc(bins[2]);  // -960
                               -949..-930          : inc(bins[3]);  // -940
                               -929..-910          : inc(bins[4]);  // -920
                               -909..-890          : inc(bins[5]);  // -900
                               -889..-870          : inc(bins[6]);  // -880
                               -869..-850          : inc(bins[7]);  // -860
                               -849..-830          : inc(bins[8]);  // -840
                               -829..-810          : inc(bins[9]);  // -820
                               -809..-790          : inc(bins[10]); // -800
                               -789..-770          : inc(bins[11]); // -780
                               -769..-750          : inc(bins[12]); // -760
                               -749..-730          : inc(bins[13]); // -740
                               -729..-710          : inc(bins[14]); // -720
                               -709..-690          : inc(bins[15]); // -700
                               -689..-670          : inc(bins[16]); // -680
                               -669..-650          : inc(bins[17]); // -660
                               -649..-630          : inc(bins[18]); // -640
                               -629..-610          : inc(bins[19]); // -620
                               -609..-590          : inc(bins[20]); // -600
                               -589..-570          : inc(bins[21]); // -580
                               -569..-550          : inc(bins[22]); // -560
                               -549..-530          : inc(bins[23]); // -540
                               -529..-510          : inc(bins[24]); // -520
                               -509..-490          : inc(bins[25]); // -500
                               -489..-470          : inc(bins[26]); // -480
                               -469..-450          : inc(bins[27]); // -460
                               -449..-430          : inc(bins[28]); // -440
                               -429..-410          : inc(bins[29]); // -420
                               -409..-390          : inc(bins[30]); // -400
                               -389..-370          : inc(bins[31]); // -380
                               -369..-350          : inc(bins[32]); // -360
                               -349..-330          : inc(bins[33]); // -340
                               -329..-310          : inc(bins[34]); // -320
                               -309..-290          : inc(bins[35]); // -300
                               -289..-270          : inc(bins[36]); // -280
                               -269..-250          : inc(bins[37]); // -260
                               -249..-230          : inc(bins[38]); // -240
                               -229..-210          : inc(bins[39]); // -220
                               -209..-190          : inc(bins[40]); // -200
                               -189..-170          : inc(bins[41]); // -180
                               -169..-150          : inc(bins[42]); // -160
                               -149..-130          : inc(bins[43]); // -140
                               -129..-110          : inc(bins[44]); // -120
                               -109..-90           : inc(bins[45]); // -100
                               -89..-70            : inc(bins[46]); // -80
                               -69..-50            : inc(bins[47]); // -60
                               -49..-30            : inc(bins[48]); // -40
                               -29..-10            : inc(bins[49]); // -20
                               -9..10              : inc(bins[50]); // 0
                               11..30              : inc(bins[51]); // 20
                               31..50              : inc(bins[52]); // 40
                               51..70              : inc(bins[53]); // 60
                               71..90              : inc(bins[54]); // 80
                               91..110             : inc(bins[55]); // 100
                               111..130            : inc(bins[56]); // 120
                               131..150            : inc(bins[57]); // 140
                               151..170            : inc(bins[58]); // 160
                               171..190            : inc(bins[59]); // 180
                               191..210            : inc(bins[60]); // 200
                               211..230            : inc(bins[61]); // 220
                               231..250            : inc(bins[62]); // 240
                               251..270            : inc(bins[63]); // 260
                               271..290            : inc(bins[64]); // 280
                               291..310            : inc(bins[65]); // 300
                               311..330            : inc(bins[66]); // 320
                               331..350            : inc(bins[67]); // 340
                               351..370            : inc(bins[68]); // 360
                               371..390            : inc(bins[69]); // 380
                               391..410            : inc(bins[70]); // 400
                               411..430            : inc(bins[71]); // 420
                               431..450            : inc(bins[72]); // 440
                               451..470            : inc(bins[73]); // 460
                               471..490            : inc(bins[74]); // 480
                               491..510            : inc(bins[75]); // 500
                               511..530            : inc(bins[76]); // 520
                               531..550            : inc(bins[77]); // 540
                               551..570            : inc(bins[78]); // 560
                               571..590            : inc(bins[79]); // 580
                               591..610            : inc(bins[80]); // 600
                               611..630            : inc(bins[81]); // 620
                               631..650            : inc(bins[82]); // 640
                               651..670            : inc(bins[83]); // 660
                               671..690            : inc(bins[84]); // 680
                               691..710            : inc(bins[85]); // 700
                               711..730            : inc(bins[86]); // 720
                               731..750            : inc(bins[87]); // 740
                               751..770            : inc(bins[88]); // 760
                               771..790            : inc(bins[89]); // 780
                               791..810            : inc(bins[90]); // 800
                               811..830            : inc(bins[91]); // 820
                               831..850            : inc(bins[92]); // 840
                               851..870            : inc(bins[93]); // 860
                               871..890            : inc(bins[94]); // 880
                               891..910            : inc(bins[95]); // 900
                               911..930            : inc(bins[96]); // 920
                               931..950            : inc(bins[97]); // 940
                               951..970            : inc(bins[98]); // 960
                               971..990            : inc(bins[99]); // 980
                               991..1010           : inc(bins[100]); // 1000
                               End;
                          End;
                          if binspace = 50 Then
                          Begin
                               // 50 Hz Bins
                               Case passtest of
                               -1025..-975         : inc(bins[0]);  // -1000 +/- 25
                               -974..-925          : inc(bins[1]);  // -950 +/- 25
                               -924..-875          : inc(bins[2]);  // -900
                               -874..-825          : inc(bins[3]);  // -850
                               -824..-775          : inc(bins[4]);  // -800
                               -774..-725          : inc(bins[5]);  // -750
                               -724..-675          : inc(bins[6]);  // -700
                               -674..-625          : inc(bins[7]);  // -650
                               -624..-575          : inc(bins[8]);  // -600
                               -574..-525          : inc(bins[9]);  // -550
                               -524..-475          : inc(bins[10]); // -500
                               -474..-425          : inc(bins[11]); // -450
                               -424..-375          : inc(bins[12]); // -400
                               -374..-325          : inc(bins[13]); // -350
                               -324..-275          : inc(bins[14]); // -300
                               -274..-225          : inc(bins[15]); // -250
                               -224..-175          : inc(bins[16]); // -200
                               -174..-125          : inc(bins[17]); // -150
                               -124..-75           : inc(bins[18]); // -100
                               -74..-25            : inc(bins[19]); // -50
                               -24..25             : inc(bins[20]); // 0
                               26..75              : inc(bins[21]); // 50
                               76..125             : inc(bins[22]); // 100
                               126..175            : inc(bins[23]); // 150
                               176..225            : inc(bins[24]); // 200
                               226..275            : inc(bins[25]); // 250
                               276..325            : inc(bins[26]); // 300
                               326..375            : inc(bins[27]); // 350
                               376..425            : inc(bins[28]); // 400
                               426..475            : inc(bins[29]); // 450
                               476..525            : inc(bins[30]); // 500
                               526..575            : inc(bins[31]); // 550
                               576..625            : inc(bins[32]); // 600
                               626..675            : inc(bins[33]); // 650
                               676..725            : inc(bins[34]); // 700
                               726..775            : inc(bins[35]); // 750
                               776..825            : inc(bins[36]); // 800
                               826..875            : inc(bins[37]); // 850
                               876..925            : inc(bins[38]); // 900
                               926..975            : inc(bins[39]); // 950
                               976..1025           : inc(bins[40]); // 1000
                               End;
                          End;
                          if binspace = 100 Then
                          Begin
                               // 100 Hz Bins
                               Case passtest of
                               -1050..-950         : inc(bins[0]);  // -1000 +/- 50
                               -949..-850          : inc(bins[1]);  // -900 +/- 50
                               -849..-750          : inc(bins[2]);  // -800
                               -749..-650          : inc(bins[3]);  // -700
                               -649..-550          : inc(bins[4]);  // -600
                               -549..-450          : inc(bins[5]);  // -500
                               -449..-350          : inc(bins[6]);  // -400
                               -349..-250          : inc(bins[7]);  // -300
                               -249..-150          : inc(bins[8]);  // -200
                               -149..-50           : inc(bins[9]);  // -100
                               -49..50             : inc(bins[10]); // 0
                               51..150             : inc(bins[11]); // 100
                               151..250            : inc(bins[12]); // 200
                               251..350            : inc(bins[13]); // 300
                               351..450            : inc(bins[14]); // 400
                               451..550            : inc(bins[15]); // 500
                               551..650            : inc(bins[16]); // 600
                               651..750            : inc(bins[17]); // 700
                               751..850            : inc(bins[18]); // 800
                               851..950            : inc(bins[19]); // 900
                               951..1050           : inc(bins[20]); // 1000
                               End;
                          End;
                          if binspace = 200 Then
                          Begin
                               // 200 Hz Bins
                               Case passtest of
                               -1100..-900         : inc(bins[0]);  // -1000 +/- 100
                               -899..-700          : inc(bins[1]);  // -800
                               -699..-500          : inc(bins[2]);  // -600
                               -499..-300          : inc(bins[3]);  // -400
                               -299..-100          : inc(bins[4]);  // -200
                               -99..100            : inc(bins[5]);  // 0
                               101..300            : inc(bins[6]);  // 200
                               301..500            : inc(bins[7]);  // 400
                               501..700            : inc(bins[8]);  // 600
                               701..900            : inc(bins[9]);  // 800
                               901..1100           : inc(bins[10]); // 1000
                               End;
                          End;
                     end;
                     for i := 0 to 100 do
                     begin
                          // Normalize bins to 0 or 1
                          if bins[i] > 0 then bins[i] := 1 else bins[i] := 0;
                     end;
                     passcount := 0;
                     for i := 0 to 100 do
                     begin
                          if bins[i] > 0 then inc(passcount);
                     end;
                     diagout.Form3.ListBox1.Items.Add('Merged ' + IntToStr(syncount) + ' points to ' + IntToStr(passcount) + ' bins.');
                     if (syncount > (2000 div binspace) + 5) And (passcount > 20) Then
                     Begin
                          diagout.Form3.ListBox3.Items.Add('Probable dirty signal detected');
                          diagout.Form3.ListBox3.Items.Add('Too many sync detects. (' + IntToStr(passcount) + ')');
                          diagout.Form3.ListBox3.Items.Add('Decode cycle aborted.');
                          passcount := 0;
                     End;
                     // Now... at this point I have some count of bins to do a 20/40/80Hz bw decode upon.
                End
                Else
                Begin
                     // Single decode cycle @ glMouseDF, glDFTolerance
                     // find bin where glMouseDF might live.
                     passtest := gl4MouseDF;
                     binspace := gl4DFTolerance;
                     // This sets binspace to single decode tolerance.
                          If binspace = 20 Then
                          Begin
                               // 20 Hz Bins
                               Case passtest of
                               -1010..-990         : inc(bins[0]);  // -1000 +/- 10
                               -989..-970          : inc(bins[1]);  // -980 +/- 10
                               -969..-950          : inc(bins[2]);  // -960
                               -949..-930          : inc(bins[3]);  // -940
                               -929..-910          : inc(bins[4]);  // -920
                               -909..-890          : inc(bins[5]);  // -900
                               -889..-870          : inc(bins[6]);  // -880
                               -869..-850          : inc(bins[7]);  // -860
                               -849..-830          : inc(bins[8]);  // -840
                               -829..-810          : inc(bins[9]);  // -820
                               -809..-790          : inc(bins[10]); // -800
                               -789..-770          : inc(bins[11]); // -780
                               -769..-750          : inc(bins[12]); // -760
                               -749..-730          : inc(bins[13]); // -740
                               -729..-710          : inc(bins[14]); // -720
                               -709..-690          : inc(bins[15]); // -700
                               -689..-670          : inc(bins[16]); // -680
                               -669..-650          : inc(bins[17]); // -660
                               -649..-630          : inc(bins[18]); // -640
                               -629..-610          : inc(bins[19]); // -620
                               -609..-590          : inc(bins[20]); // -600
                               -589..-570          : inc(bins[21]); // -580
                               -569..-550          : inc(bins[22]); // -560
                               -549..-530          : inc(bins[23]); // -540
                               -529..-510          : inc(bins[24]); // -520
                               -509..-490          : inc(bins[25]); // -500
                               -489..-470          : inc(bins[26]); // -480
                               -469..-450          : inc(bins[27]); // -460
                               -449..-430          : inc(bins[28]); // -440
                               -429..-410          : inc(bins[29]); // -420
                               -409..-390          : inc(bins[30]); // -400
                               -389..-370          : inc(bins[31]); // -380
                               -369..-350          : inc(bins[32]); // -360
                               -349..-330          : inc(bins[33]); // -340
                               -329..-310          : inc(bins[34]); // -320
                               -309..-290          : inc(bins[35]); // -300
                               -289..-270          : inc(bins[36]); // -280
                               -269..-250          : inc(bins[37]); // -260
                               -249..-230          : inc(bins[38]); // -240
                               -229..-210          : inc(bins[39]); // -220
                               -209..-190          : inc(bins[40]); // -200
                               -189..-170          : inc(bins[41]); // -180
                               -169..-150          : inc(bins[42]); // -160
                               -149..-130          : inc(bins[43]); // -140
                               -129..-110          : inc(bins[44]); // -120
                               -109..-90           : inc(bins[45]); // -100
                               -89..-70            : inc(bins[46]); // -80
                               -69..-50            : inc(bins[47]); // -60
                               -49..-30            : inc(bins[48]); // -40
                               -29..-10            : inc(bins[49]); // -20
                               -9..10              : inc(bins[50]); // 0
                               11..30              : inc(bins[51]); // 20
                               31..50              : inc(bins[52]); // 40
                               51..70              : inc(bins[53]); // 60
                               71..90              : inc(bins[54]); // 80
                               91..110             : inc(bins[55]); // 100
                               111..130            : inc(bins[56]); // 120
                               131..150            : inc(bins[57]); // 140
                               151..170            : inc(bins[58]); // 160
                               171..190            : inc(bins[59]); // 180
                               191..210            : inc(bins[60]); // 200
                               211..230            : inc(bins[61]); // 220
                               231..250            : inc(bins[62]); // 240
                               251..270            : inc(bins[63]); // 260
                               271..290            : inc(bins[64]); // 280
                               291..310            : inc(bins[65]); // 300
                               311..330            : inc(bins[66]); // 320
                               331..350            : inc(bins[67]); // 340
                               351..370            : inc(bins[68]); // 360
                               371..390            : inc(bins[69]); // 380
                               391..410            : inc(bins[70]); // 400
                               411..430            : inc(bins[71]); // 420
                               431..450            : inc(bins[72]); // 440
                               451..470            : inc(bins[73]); // 460
                               471..490            : inc(bins[74]); // 480
                               491..510            : inc(bins[75]); // 500
                               511..530            : inc(bins[76]); // 520
                               531..550            : inc(bins[77]); // 540
                               551..570            : inc(bins[78]); // 560
                               571..590            : inc(bins[79]); // 580
                               591..610            : inc(bins[80]); // 600
                               611..630            : inc(bins[81]); // 620
                               631..650            : inc(bins[82]); // 640
                               651..670            : inc(bins[83]); // 660
                               671..690            : inc(bins[84]); // 680
                               691..710            : inc(bins[85]); // 700
                               711..730            : inc(bins[86]); // 720
                               731..750            : inc(bins[87]); // 740
                               751..770            : inc(bins[88]); // 760
                               771..790            : inc(bins[89]); // 780
                               791..810            : inc(bins[90]); // 800
                               811..830            : inc(bins[91]); // 820
                               831..850            : inc(bins[92]); // 840
                               851..870            : inc(bins[93]); // 860
                               871..890            : inc(bins[94]); // 880
                               891..910            : inc(bins[95]); // 900
                               911..930            : inc(bins[96]); // 920
                               931..950            : inc(bins[97]); // 940
                               951..970            : inc(bins[98]); // 960
                               971..990            : inc(bins[99]); // 980
                               991..1010           : inc(bins[100]); // 1000
                               End;
                          End;
                          if binspace = 50 Then
                          Begin
                               // 50 Hz Bins
                               Case passtest of
                               -1025..-975         : inc(bins[0]);  // -1000 +/- 25
                               -974..-925          : inc(bins[1]);  // -950 +/- 25
                               -924..-875          : inc(bins[2]);  // -900
                               -874..-825          : inc(bins[3]);  // -850
                               -824..-775          : inc(bins[4]);  // -800
                               -774..-725          : inc(bins[5]);  // -750
                               -724..-675          : inc(bins[6]);  // -700
                               -674..-625          : inc(bins[7]);  // -650
                               -624..-575          : inc(bins[8]);  // -600
                               -574..-525          : inc(bins[9]);  // -550
                               -524..-475          : inc(bins[10]); // -500
                               -474..-425          : inc(bins[11]); // -450
                               -424..-375          : inc(bins[12]); // -400
                               -374..-325          : inc(bins[13]); // -350
                               -324..-275          : inc(bins[14]); // -300
                               -274..-225          : inc(bins[15]); // -250
                               -224..-175          : inc(bins[16]); // -200
                               -174..-125          : inc(bins[17]); // -150
                               -124..-75           : inc(bins[18]); // -100
                               -74..-25            : inc(bins[19]); // -50
                               -24..25             : inc(bins[20]); // 0
                               26..75              : inc(bins[21]); // 50
                               76..125             : inc(bins[22]); // 100
                               126..175            : inc(bins[23]); // 150
                               176..225            : inc(bins[24]); // 200
                               226..275            : inc(bins[25]); // 250
                               276..325            : inc(bins[26]); // 300
                               326..375            : inc(bins[27]); // 350
                               376..425            : inc(bins[28]); // 400
                               426..475            : inc(bins[29]); // 450
                               476..525            : inc(bins[30]); // 500
                               526..575            : inc(bins[31]); // 550
                               576..625            : inc(bins[32]); // 600
                               626..675            : inc(bins[33]); // 650
                               676..725            : inc(bins[34]); // 700
                               726..775            : inc(bins[35]); // 750
                               776..825            : inc(bins[36]); // 800
                               826..875            : inc(bins[37]); // 850
                               876..925            : inc(bins[38]); // 900
                               926..975            : inc(bins[39]); // 950
                               976..1025           : inc(bins[40]); // 1000
                               End;
                          End;
                          if binspace = 100 Then
                          Begin
                               // 100 Hz Bins
                               Case passtest of
                               -1050..-950         : inc(bins[0]);  // -1000 +/- 50
                               -949..-850          : inc(bins[1]);  // -900 +/- 50
                               -849..-750          : inc(bins[2]);  // -800
                               -749..-650          : inc(bins[3]);  // -700
                               -649..-550          : inc(bins[4]);  // -600
                               -549..-450          : inc(bins[5]);  // -500
                               -449..-350          : inc(bins[6]);  // -400
                               -349..-250          : inc(bins[7]);  // -300
                               -249..-150          : inc(bins[8]);  // -200
                               -149..-50           : inc(bins[9]);  // -100
                               -49..50             : inc(bins[10]); // 0
                               51..150             : inc(bins[11]); // 100
                               151..250            : inc(bins[12]); // 200
                               251..350            : inc(bins[13]); // 300
                               351..450            : inc(bins[14]); // 400
                               451..550            : inc(bins[15]); // 500
                               551..650            : inc(bins[16]); // 600
                               651..750            : inc(bins[17]); // 700
                               751..850            : inc(bins[18]); // 800
                               851..950            : inc(bins[19]); // 900
                               951..1050           : inc(bins[20]); // 1000
                               End;
                          End;
                          if binspace = 200 Then
                          Begin
                               // 200 Hz Bins
                               Case passtest of
                               -1100..-900         : inc(bins[0]);  // -1000 +/- 100
                               -899..-700          : inc(bins[1]);  // -800
                               -699..-500          : inc(bins[2]);  // -600
                               -499..-300          : inc(bins[3]);  // -400
                               -299..-100          : inc(bins[4]);  // -200
                               -99..100            : inc(bins[5]);  // 0
                               101..300            : inc(bins[6]);  // 200
                               301..500            : inc(bins[7]);  // 400
                               501..700            : inc(bins[8]);  // 600
                               701..900            : inc(bins[9]);  // 800
                               901..1100           : inc(bins[10]); // 1000
                               End;
                          End;
                     // At this point I should have exactly 1 bin populated.
                     passcount := 0;
                     for i := 0 to 100 do
                     begin
                          if bins[i] > 0 then inc(passcount);
                     end;
                     //diagout.Form3.ListBox1.Items.Add('Merged 1 point to ' + IntToStr(passcount) + ' bin.');
                     if (passcount > 1) or (passcount < 1) Then diagout.Form3.ListBox3.Items.Add('PASSCOUNT WRONG.  ' + IntToStr(passcount));
                End;
                ndec := 0;
                gl4rawOut.Clear;
                gl4decOut.Clear;
                gl4sort1.Clear;
                // Process bins
                if passcount > 0 Then
                Begin
                     for i := 0 to 100 do
                     begin
                          if bins[i] > 0 Then
                          Begin
                               //if binspace > 50 then binspace := 50;
                               // This bin needs a decode.
                               if binspace = 10 Then
                               Begin
                                    if i = 0 Then lmousedf := -1000 else lmousedf := -1000 + (i*10);
                               End;
                               if binspace = 20 Then
                               Begin
                                    if i = 0 Then lmousedf := -1000 else lmousedf := -1000 + (i*20);
                               End;
                               if binspace = 50 Then
                               Begin
                                    if i = 0 Then lmousedf := -1000 else lmousedf := -1000 + (i*50);
                               End;
                               if binspace = 100 Then
                               Begin
                                    if i = 0 Then lmousedf := -1000 else lmousedf := -1000 + (i*100);
                               End;
                               if binspace = 200 Then
                               Begin
                                    if i = 0 Then lmousedf := -1000 else lmousedf := -1000 + (i*200);
                               End;
                               mousedf2 := lmousedf;
                               idf := lmousedf-mousedf2;
                               gl4mline := '                                                                        ';
                               bw := binspace;
                               afc := gl4Nafc;
                               diagout.Form3.ListBox1.Items.Add('Running decode at Center DF = ' + IntToStr(lmousedf));
                               // Copy lpfM to f3Buffer
                               for j := 0 to jz2 do
                               Begin
                                    gl4f3Buffer[j] := gl4lpfM[j];
                               end;
                               for j := jz2+1 to 661503 do
                               Begin
                                    gl4f3Buffer[j] := 0.0;
                               end;
                               // Call decoder
                               cqz4(@gl4f3Buffer[4096],@jz2,@bw,@MouseDF2,@idf,gl4mline,@lical,gl4wisfile,gl4kvfname);
                               ifoo := 0;
                               foo := '';
                               foo := StrPas(gl4mline);
                               if i < 10 then foo := '0' + IntToStr(i) + ',' + foo else foo := IntToStr(i) + ',' + foo;
                               gl4rawOut.Add(TrimLeft(TrimRight(foo)));
                               if tryStrToInt(ExtractWord(3,foo,CsvDelim),ifoo) Then
                               Begin
                                    if ifoo > 0 Then
                                    Begin
                                         if evalBM4(foo) Then
                                         Begin
                                              inc(ndec);
                                              gl4decOut.Add(TrimLeft(TrimRight(foo)+',B'));
                                         end
                                         else
                                         begin
                                              // Oh joy.  Time to try for kv.
                                              kdec := '';
                                              if evalKV4(kdec) Then
                                              Begin
                                                   inc(ndec);
                                                   // Seems I found a kv decode.
                                                   foo := TrimLeft(TrimRight(foo)) + TrimLeft(TrimRight(kdec));
                                                   gl4decOut.Add(TrimLeft(TrimRight(foo))+',K');
                                              end;
                                         end;
                                    end;
                               end;
                               if FileExists('KVASD.DAT') Then DeleteFile('KVASD.DAT');
                          End;
                     end;
                end;
                if gl4rawOut.Count > 0 Then
                Begin
                     diagout.Form3.ListBox2.Clear;
                     for i := 0 to gl4rawOut.Count-1 do
                     Begin
                          diagout.Form3.ListBox2.Items.Add(gl4rawOut.Strings[i]);
                     End;
                     gl4rawOut.Clear;
                End;
           End
           else
           begin
                diagout.Form3.ListBox1.Items.Add('MSync found no sync points.');
           end;
      End
      Else
      Begin
           diagout.Form3.ListBox1.Items.Add('Average audio level too low or high.');
           diagout.Form3.ListBox1.Items.Add('Decode cycle aborted.');
           ndec := 0;
      End;
      // Fix up the decodes to display/rbc specs.
      if gl4decOut.Count > 0 Then
      Begin
           diagout.Form3.ListBox1.Items.Add('Potential decodes = '+IntToStr(ndec));
           // Have ndec decodes available in decArray[x]
           // Now.. I plan to do away with the long standing bug of reading a
           // very strong signal as a very weak one due to decoding a harmonic
           // and the 'real' signal.  First I need to remove any actual dupe
           // strings.  But.  Only need to go through all this if ndec > 1 :)
           if ndec > 1 Then
           Begin
                gl4sort1.Clear;
                gl4sort1.Sorted := True;
                gl4sort1.Duplicates := Types.dupIgnore;
                for i := 0 to gl4decOut.Count-1 do
                Begin
                     foo := ExtractWord(7,gl4decOut.Strings[i],CsvDelim);
                     gl4sort1.Add(foo);
                End;
                gl4sort1.sorted := False;
                gl4decOut.Sorted := False;
                While gl4sort1.count > 0 do
                Begin
                     for i := 0 to gl4sort1.count - 1 do
                     Begin
                          dupeFoo := '';
                          foo := gl4sort1.Strings[i];
                          for j := 0 to gl4decOut.Count-1 do
                          begin
                               if ExtractWord(7,gl4decOut.Strings[j],csvDelim) = foo then dupeFoo := dupeFoo + IntToStr(j) + ',';
                          end;
                          if Length(dupeFoo) > 1 Then
                          Begin
                               If dupeFoo[length(dupeFoo)]=',' Then dupeFoo[length(dupeFoo)] := ' ';
                               trimRight(dupeFoo);
                               wcount := WordCount(dupeFoo,csvDelim);
                               allEqual := True;
                               foo := ExtractWord(1,dupeFoo,csvDelim);
                               j := StrToInt(TrimLeft(TrimRight(foo)));
                               strongest := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                               for j := 1 to wcount do
                               Begin
                                    foo := ExtractWord(j,dupeFoo,csvDelim);
                                    k := StrToInt(TrimLeft(TrimRight(foo)));
                                    foo := ExtractWord(4,gl4decOut.Strings[k],csvDelim);
                                    if StrToInt(TrimLeft(TrimRight(foo))) <> strongest Then allEqual := False;
                               End;
                               If allEqual Then
                               Begin
                                    for j := 2 to wcount do
                                    begin
                                         k := StrToInt(TrimLeft(TrimRight(extractWord(j,dupeFoo,csvDelim))));
                                         gl4decOut.Strings[k] := gl4decOut.Strings[k] + ',D';
                                    end;
                               End;
                               If not allEqual Then
                               Begin
                                    // Need to find strongest then delete others.
                                    strongest := -99;
                                    for n := 1 to wcount do
                                    Begin
                                         foo := ExtractWord(n,dupeFoo,csvDelim);
                                         j := StrToInt(TrimLeft(TrimRight(foo)));
                                         k := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                                         if k > strongest then strongest := k;
                                    End;
                                    for n := 1 to wcount do
                                    Begin
                                         foo := ExtractWord(n,dupeFoo,csvDelim);
                                         j := StrToInt(TrimLeft(TrimRight(foo)));
                                         k := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                                         if k < strongest Then gl4decOut.Strings[j] := gl4decOut.Strings[j] + ',D';
                                    End;
                               End;
                          End;
                          gl4sort1.Delete(i);
                          break;
                     End;
                End;
                gl4decOut.Sorted := True;
                gl4sort1.Sorted := False;
           end;
           // Do it all again to really remove the dupes in all cases but first
           // remove any entries labeled as dupes from first pass.
           repeat
                 haveDupe := False;
                 for i := 0 to gl4decOut.Count-1 do
                 Begin
                      if WordCount(gl4decOut.Strings[i],csvDelim)>8 Then
                      Begin
                           gl4decOut.delete(i);
                           haveDupe := True;
                           break;
                      End;
                 End;
           until haveDupe = False;
           // Only need to do the dupe removal second pass if decOut.count > 1
           if gl4decOut.Count>1 Then
           Begin
                gl4sort1.Clear;
                gl4sort1.Sorted := True;
                gl4sort1.Duplicates := Types.dupIgnore;
                for i := 0 to gl4decOut.Count-1 do
                Begin
                     foo := ExtractWord(7,gl4decOut.Strings[i],CsvDelim);
                     gl4sort1.Add(foo);
                End;
                gl4sort1.sorted := False;
                gl4decOut.Sorted := False;
                While gl4sort1.count > 0 do
                Begin
                     for i := 0 to gl4sort1.count - 1 do
                     Begin
                          dupeFoo := '';
                          foo := gl4sort1.Strings[i];
                          for j := 0 to gl4decOut.Count-1 do
                          begin
                               if ExtractWord(7,gl4decOut.Strings[j],csvDelim) = foo then dupeFoo := dupeFoo + IntToStr(j) + ',';
                          end;
                          if Length(dupeFoo) > 1 Then
                          Begin
                               If dupeFoo[length(dupeFoo)]=',' Then dupeFoo[length(dupeFoo)] := ' ';
                               trimRight(dupeFoo);
                               wcount := WordCount(dupeFoo,csvDelim);
                               allEqual := True;
                               foo := ExtractWord(1,dupeFoo,csvDelim);
                               j := StrToInt(TrimLeft(TrimRight(foo)));
                               strongest := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                               for j := 1 to wcount do
                               Begin
                                    foo := ExtractWord(j,dupeFoo,csvDelim);
                                    k := StrToInt(TrimLeft(TrimRight(foo)));
                                    foo := ExtractWord(4,gl4decOut.Strings[k],csvDelim);
                                    if StrToInt(TrimLeft(TrimRight(foo))) <> strongest Then allEqual := False;
                               End;
                               If allEqual Then
                               Begin
                                    for j := 2 to wcount do
                                    begin
                                         k := StrToInt(TrimLeft(TrimRight(extractWord(j,dupeFoo,csvDelim))));
                                         gl4decOut.Strings[k] := gl4decOut.Strings[k] + ',D';
                                    end;
                               End;
                               If not allEqual Then
                               Begin
                                    // Need to find strongest then delete others.
                                    strongest := -99;
                                    for n := 1 to wcount do
                                    Begin
                                         foo := ExtractWord(n,dupeFoo,csvDelim);
                                         j := StrToInt(TrimLeft(TrimRight(foo)));
                                         k := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                                         if k > strongest then strongest := k;
                                    End;
                                    for n := 1 to wcount do
                                    Begin
                                         foo := ExtractWord(n,dupeFoo,csvDelim);
                                         j := StrToInt(TrimLeft(TrimRight(foo)));
                                         k := StrToInt(TrimLeft(TrimRight(ExtractWord(4,gl4decOut.Strings[j],csvDelim))));
                                         if k < strongest Then gl4decOut.Strings[j] := gl4decOut.Strings[j] + ',D';
                                    End;
                               End;
                          End;
                          gl4sort1.Delete(i);
                          break;
                     End;
                End;
           End;
      End;
      gl4decOut.sorted := True;
      // Now break the strings in decOut down to the record format for maincode.
      if gl4decOut.Count > 0 Then
      Begin
           for i := 0 to gl4decOut.count-1 do
           Begin
                // DF,Sync,DB,DT,*/#,Exchange,EC Method
                // 1  2    3  4  5   6        7
                wcount := WordCount(gl4decOut.Strings[i],CsvDelim);
                if (wcount > 2) and (wcount < 9) Then
                Begin
                     decode.deltaFreq := -9999.0;
                     decode.numSync := -99;
                     decode.dsigLevel := -99;
                     decode.deltaTime := -99.0;
                     decode.cSync := ' ';
                     decode.bDecoded := ' ';
                     decode.timeStamp := gl4timestamp;
                     foo := ExtractWord(2,gl4decOut.Strings[i],CsvDelim);
                     If not TryStrToFloat(TrimLeft(TrimRight(foo)), decode.deltaFreq) Then decode.deltaFreq := -9999.0;
                     foo := ExtractWord(3,gl4decOut.Strings[i],CsvDelim);
                     If not TryStrToInt(TrimLeft(TrimRight(foo)), decode.numSync) Then decode.numSync := -99;
                     foo := ExtractWord(4,gl4decOut.Strings[i],CsvDelim);
                     If not TryStrToInt(TrimLeft(TrimRight(foo)), decode.dsigLevel) Then decode.dsigLevel := -99;
                     foo := ExtractWord(5,gl4decOut.Strings[i],CsvDelim);
                     If not TryStrToFloat(TrimLeft(TrimRight(foo)), decode.deltaTime) Then decode.deltaTime := -99.0;
                     foo := ExtractWord(6,gl4decOut.Strings[i],CsvDelim);
                     decode.cSync := TrimLeft(TrimRight(foo));
                     foo := ExtractWord(7,gl4decOut.Strings[i],CsvDelim);
                     decode.bDecoded := TrimLeft(TrimRight(foo));
                     for j := 0 to 49 do
                     begin
                          if gl4decodes[j].dtProcessed Then
                          begin
                               gl4decodes[j].dtTimeStamp := decode.timeStamp;
                               gl4decodes[j].dtSigLevel := IntToStr(decode.dsigLevel);
                               gl4decodes[j].dtNumSync := IntToStr(decode.numSync);
                               gl4decodes[j].dtDeltaTime := FormatFloat('0.0',decode.deltaTime);
                               gl4decodes[j].dtDeltaFreq := FormatFloat('0',decode.deltaFreq);
                               gl4decodes[j].dtSigW := ' ';
                               gl4decodes[j].dtCharSync := decode.cSync;
                               gl4decodes[j].dtDecoded := decode.bDecoded;
                               gl4decodes[j].dtDisplayed := False;
                               gl4decodes[j].dtProcessed := False;
                               gl4decodes[j].dtType := TrimLeft(TrimRight(ExtractWord(8,gl4decOut.Strings[i],CsvDelim)));
                               break;
                          end;
                     end;
                end;
           End;
           gl4HaveDecodes := True;
      end
      else
      begin
           diagout.Form3.ListBox1.Items.Add('No decodes made.');
      end;
      gl4decOut.Clear;
      gl4rawOut.Clear;
      gl4sort1.Clear;
      gl4inprog := False;
      gl4FirstRun := False;
End;
end.

