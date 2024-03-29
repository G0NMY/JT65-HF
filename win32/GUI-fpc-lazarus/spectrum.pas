unit spectrum;
//
// Copyright (c) 2008,2009, 2010, 2011 J C Large - W6CQZ
//
//
// JT65-HF is the legal property of its developer.
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; see the file COPYING. If not, write to
// the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
// Boston, MA 02110-1301, USA.
//
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CTypes, cmaps, fftw_jl, globalData, samplerate, graphics, Math, dlog;

Type
    RGBPixel = Packed Record
             r : Byte;
             g : Byte;
             b : Byte;
    End;

    BMP_Header = Packed Record
               bfType1 : Char ; (* "B" *)
               bfType2 : Char ; (* "M" *)
               bfSize : LongInt ; (* Size of File *)
               bfReserved1 : Word ; (* Zero *)
               bfReserved2 : Word ; (* Zero *)
               bfOffBits : LongInt ; (* Offset to beginning of BitMap *)
               biSize : LongInt ; (* Number of Bytes in Structure *)
               biWidth : LongInt ; (* Width of BitMap in Pixels *)
               biHeight : LongInt ; (* Height of BitMap in Pixels *)
               biPlanes : Word ; (* Planes in target device = 1 *)
               biBitCount : Word ; (* Bits per Pixel 1, 4, 8, or 24 *)
               biCompression : LongInt ; (* BI_RGB = 0, BI_RLE8, BI_RLE4 *)
               biSizeImage : LongInt ; (* Size of Image Part (often ignored) *)
               biXPelsPerMeter : LongInt ; (* Always Zero *)
               biYPelsPerMeter : LongInt ; (* Always Zero *)
               biClrUsed : LongInt ; (* # of Colors used in Palette *)
               biClrImportant : LongInt ; (* # of Colors that are Important *)
    End;

    RGBArray = Array[0..749] of RGBPixel;

const
  {$IFDEF WIN32}
          JT_DLL = 'jt65.dll';
  {$ENDIF}
  {$IFDEF LINUX}
          JT_DLL = 'JT65';
  {$ENDIF}
  {$IFDEF DARWIN}
          JT_DLL = 'JT65';
  {$ENDIF}

procedure computeSpectrum(Const dBuffer : Array of CTypes.cint16);

function colorMap(Const integerArray : Array of LongInt; Var rgbArray : RGBArray): Boolean;

function computeAudio(Const Buffer : Array of CTypes.cint16): Integer;

procedure flat(ss,n,nsum : Pointer); cdecl;

Var
   specDisplayData : Packed Array[0..179]    Of RGBArray;
   specTempSpec1   : Packed Array[0..179]    Of RGBArray;
   bmpD            : Packed Array[0..405359] Of Byte;
   specFirstRun    : Boolean;
   specColorMap    : Integer;
   specSpeed2      : Integer;
   specGain        : Integer;
   specVGain       : Integer;
   specContrast    : Integer;
   specfftCount    : Integer;
   specSmooth      : Boolean;

implementation

procedure flat(ss,n,nsum : Pointer); cdecl; external JT_DLL name 'flat2_';

function colorMap(Const integerArray : Array of LongInt; Var rgbArray : RGBArray ): Boolean;
Var
   floatvar : Single;
   i        : Integer;
   intvar   : LongInt;
Begin
     // This routine maps integerArray[0..749] to rgbArray[0..749] in RGB pixel format.
     If specColorMap = 0 Then
     Begin
          for i := 0 to 749 do
          Begin
               floatvar := cmaps.bluecmap1[integerArray[i]];
               floatvar := floatvar * 256; // Red
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].r := intvar;

               floatvar := cmaps.bluecmap2[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].g := intvar;

               floatvar := cmaps.bluecmap3[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].b := intvar;
          End;
     End;
     If specColorMap = 1 Then
     Begin
          for i := 0 to 749 do
          Begin
               floatvar := cmaps.linradcmap1[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].r := intvar;

               floatvar := cmaps.linradcmap2[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].g := intvar;

               floatvar := cmaps.linradcmap3[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].b := intvar;
          End;
     End;
     If specColorMap = 2 Then
     Begin
          for i := 0 to 749 do
          Begin
               floatvar := cmaps.gray0cmap1[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].r := intvar;

               floatvar := cmaps.gray0cmap2[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].g := intvar;

               floatvar := cmaps.gray0cmap3[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].b := intvar;
          End;
     End;
     If specColorMap = 3 Then
     Begin
          for i := 0 to 749 do
          Begin
               floatvar := cmaps.gray1cmap1[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].r := intvar;

               floatvar := cmaps.gray1cmap2[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].g := intvar;

               floatvar := cmaps.gray1cmap3[integerArray[i]];
               floatvar := floatvar * 256;
               intvar := trunc(floatvar);
               if intvar > 255 then intvar := 255;
               rgbArray[i].b := intvar;
          End;
     End;
     Result := True;
End;

function computeAudio(Const Buffer : Array of CTypes.cint16) : Integer;
Var
   lrealArray                 : Array[0..2047] Of CTypes.cfloat;
   fac, rms1, decibel, flevel : CTypes.cfloat;
   dgain, sum, ave, sq, d     : CTypes.cfloat;
   i                          : Integer;
   specLrms                   : CTypes.cfloat;
Begin
     globalData.audioComputing := True;
     Try
        Result := 0;
        for i := 0 to 2047 do lrealArray[i] := 0.0;
        fac := 0.0;
        rms1 := 0.0;
        decibel := 0.0;
        flevel := 0.0;
        dgain := 2.0;
        sum := 0.0;
        ave := 0.0;
        sq := 0.0;
        d := 0.0;
        fac := 2.0/10000.0;  // No Idea why... comes from WSJT code and must be so to yield equal result to WSJT audio level computations.
        // Compute S-Meter Level.  Scale = 0-100, steps = .4db
        // Expects 2048 samples in dBuffer[bStart]..dBuffer[bEnd]
        for i := 0 to 2047 do lrealArray[i] := 0.5 * dgain * buffer[i];
        sum := 0;
        for i := 0 to 2047 do
        Begin
             sum := sum + lrealArray[i];
        End;
        ave := sum/2048;
        sq := 0;
        for i := 0 to 2047 do
        Begin
             d := lrealArray[i]-ave;
             sq := sq + d * d;
             lrealArray[i] := fac*d;
        End;
        rms1 := sqrt(sq/2048);
        specLrms := 0;
        if specLrms = 0 Then specLrms := rms1;
        specLrms := 0.25 * rms1 + 0.75 * specLrms;
        if specLrms > 0 Then
        Begin
             decibel := 20 * log10(specLrms/800);
             flevel := 50 + 2.5 * decibel;
             flevel := min(100.0,max(0.0,flevel));
        End;
        Result := trunc(flevel);
     Except
        dlog.fileDebug('Exception raised in audio level computation');
        Result := 0;
     End;
     globalData.audioComputing := False;
End;

procedure computeSpectrum(Const dBuffer : Array of CTypes.cint16);
Var
   i, x, y, z, intVar, nh, nfmid, iadj : CTypes.cint;
   gamma, offset, fac, fsum, d         : CTypes.cfloat;
   ave, df, fvar, pw1, pw2             : CTypes.cfloat;
   rgbSpectra                          : RGBArray;
   doSpec                              : Boolean;
   bmpH                                : BMP_Header;
   Bytes_Per_Raster                    : LongInt;
   Raster_Pad, nfrange                 : Integer;
   auBuff65                            : Packed Array[0..4095] Of smallint;
   fftOut65                            : Array[0..2047] of fftw_jl.complex_single;
   fftIn65                             : Array[0..4095] of Single;
   srealArray165                       : Array[0..4095] of Single;
   pfftIn65                            : PSingle;
   pfftOut65                           : fftw_jl.Pcomplex_single;
   p                                   : fftw_plan_single;
   ss65                                : Array[0..2047] of CTypes.cfloat;
   floatSpectra                        : Array[0..749] of CTypes.cfloat;
   integerSpectra                      : Array[0..749] of CTypes.cint32;
   samratio                            : CTypes.cdouble;
   sampconv                            : samplerate.SRC_DATA;
Begin
     // Compute spectrum display.  Expects 4096 samples in dBuffer
     globalData.spectrumComputing65 := True;
     nh := 2048;
     nfmid := 1270;
     df := 11025.0/4096;
     nfrange := 2000;
     If specFirstRun Then
     Begin
          // clear ss65
          for i := 0 to 2047 do
          Begin
               ss65[i] := 0;
          End;
          // clear rgbSpectra
          for i := 0 to 749 do
          Begin
               rgbSpectra[i].r := 0;
               rgbSpectra[i].g := 0;
               rgbSpectra[i].b := 0;
          End;
          cmaps.buildCMaps();
     End;
     Try
        if specspeed2 > -1 then
        begin
             //specspeed2 < 0 = spectrum display off.
             doSpec := False;
             globalData.specNewSpec65 := False;
             // Copy input
             for i := 0 to 4095 do auBuff65[i] := min(32766,max(-32766,dBuffer[i]));
             // Convert integer16 input buffer to floating point for fft use.
             fac := 2.0/10000;
             fsum := 0.0;
             ave := 0.0;
             d := 0.0;
             for i := 0 to 4095 do srealArray165[i] := 0.5 * 2.0 * auBuff65[i];
             for i := 0 to 4095 do fsum := fsum + srealArray165[i];
             ave := fsum/4096.0;
             for i := 0 to 4095 do
             begin
                  d := srealArray165[i]-ave;
                  srealArray165[i] := fac * d;
             end;

             // Clear FFT Input array
             for i := 0 to length(fftIn65)-1 do fftIn65[i] := 0.0;

             // Apply the resampler here so the spectrum display is a
             // touch more accurate if SR correction enabled.
             if globalData.d65samfacin <> 1.0 Then
             Begin
                  samratio := 1.0/globalData.d65samfacin;
                  sampconv.data_in  := srealArray165;
                  sampconv.data_out := fftIn65;
                  sampconv.input_frames  := 4096;
                  sampconv.output_frames := 4096;
                  sampconv.src_ratio     := samratio;
                  samplerate.src_simple(@sampconv,2,1);
             End
             Else
             Begin
                  for i := 0 to 4095 do fftIn65[i] := srealArray165[i];
             End;

             // Clear FFT output array
             for i := 0 to 2047 do
             begin
                  fftOut65[i].re := 0.0;
                  fftOut65[i].im := 0.0;
             end;

             // Compute FFT 4096 FFT
             pfftIn65  := @fftIn65;
             pfftOut65 := @fftOut65;
             p := fftw_plan_dft_1d(4096,pfftIn65,pfftOut65,[fftw_estimate]);
             fftw_execute(p);
             // Accumulate power spectrum
             for i := 0 to 2047 do ss65[i] := ss65[i] + (power(fftOut65[i].re,2) + power(fftOut65[i].im,2));
             fftw_destroy_plan(p);
             // FFT Completed.
             // ss[0..2047] now contains an fft of the power spectrum of the last 4096 samples.
             //
             // Compute spectral display line.
             // ss[0..2047] contains the power density in ~2.7 hz steps.
             inc(specfftCount);
             if specfftCount >= (5-specSpeed2) Then
             Begin
                  inc(specfftCount);
                  if specSmooth Then flat(@ss65[0],@nh,@specfftCount);
                     // Create spectra line
                     if nfrange = 2000 Then iadj := 182 + round((nfmid-1500)/df);
                     if nfrange = 4000 Then iadj := round(nfmid/df - 752.0);
                     For i := 0 to 749 do floatSpectra[i] := (specVGain*ss65[i+iadj])/specfftCount;
                     //Clear ss[]
                     for i := 0 to 2047 do ss65[i] := 0;
                     specfftCount := 0;
                     gamma := 1.3 + 0.01*specContrast;
                     offset := (specGain+64.0)/2;
                     // Map float specta pixels to integer
                     For i := 0 to 749 do
                     Begin
                          intVar := 0;
                          fvar := floatSpectra[i];
                          if fvar <> 0 Then
                          Begin
                               pw1 := 0.01*fvar;
                               pw2 := gamma;
                               fvar := 0.0;
                               fvar := power(pw1,pw2);
                               fvar := fvar+offset;
                          End
                          Else
                          Begin
                               fvar := 0.0;
                          End;
                          if fvar <> 0 then intVar := trunc(fvar) else intVar := 0;
                          intVar := min(252,max(0,intVar));
                          integerSpectra[i] := intVar;
                     End;
                     doSpec := True;
                     for i := 0 to 749 do floatSpectra[i] := 0.0;
             End
             Else
             Begin
                  doSpec := False;
             End;
             // integerSpectra[0..749] now contains the values ready to convert to rgbSpectra via colorMap()
             If doSpec Then
             Begin
                  // Spectrum types 0..3 need conversion via colorMap()
                  If specColorMap < 4 Then colorMap(integerSpectra, rgbSpectra);
                  // Spectrum types 4 is simple single color mapping.
                  If specColorMap = 4 Then
                  Begin
                       // GREEN
                       for i := 0 to 749 do
                       Begin
                            rgbSpectra[i].g := integerSpectra[i];
                            rgbSpectra[i].r := 0;
                            rgbSpectra[i].b := 0;
                       End;
                  End;
                  // Now prepend the new spectra to the spectrum rolling off the former
                  // oldest element.  This is held in specDisplayData :
                  // Array[0..109][0..749] Of CTypes.cint32  Will use tempSpec1 as
                  // a copy buffer.
                  //
                  // Shift specDisplayData 1 line into tempSpec1 remembering that a
                  // full spectrum display has 180 lines.  See that I'm copying the
                  // newest 179 lines (0 to 178) to temp as lines 1 to 179 then
                  // adding the new line as element 0 yielding again 180 lines.
                  for i := 0 to 178 do specTempSpec1[i+1] := specDisplayData[i];
                  // Prepend new spectra to copy buffer
                  specTempSpec1[0] := rgbSpectra;
                  // Move copy buffer to real buffer
                  for i := 0 to 179 do specDisplayData[i] := specTempSpec1[i];
                  // Setup BMP Header
                  bmpH.bfType1         := 'B';
                  bmpH.bfType2         := 'M';
                  bmpH.bfSize          := 0;
                  bmpH.bfReserved1     := 0;
                  bmpH.bfReserved2     := 0;
                  bmpH.bfOffBits       := 0;
                  bmpH.biSize          := 40;
                  bmpH.biWidth         := 750;
                  bmpH.biHeight        := 180;
                  bmpH.biPlanes        := 1;
                  bmpH.biBitCount      := 24;
                  bmpH.biCompression   := 0;
                  bmpH.biSizeImage     := 0;
                  bmpH.biXPelsPerMeter := 0;
                  bmpH.biYPelsPerMeter := 0;
                  bmpH.biClrUsed       := 0;
                  bmpH.biClrImportant  := 0;
                  Bytes_Per_Raster := bmpH.biWidth * 3;
                  If Bytes_Per_Raster Mod 4 = 0 Then Raster_Pad := 0 Else Raster_Pad := 4 - (Bytes_Per_Raster Mod 4);
                  Bytes_Per_Raster := Bytes_Per_Raster + Raster_Pad;
                  bmpH.biSizeImage := Bytes_Per_Raster * bmpH.biHeight;
                  bmpH.bfSize := SizeOf(bmpH) + bmpH.biSizeImage;
                  bmpH.bfOffbits := SizeOf(bmpH);
                  // Clear BMP data
                  for i := 0 to 405359 do bmpD[i] := 0;
                  // Build BMP data
                  z := 0;
                  for y := 180 downto 1 do
                  Begin
                       for x := 0 to 749 do
                       begin
                            // BLUE
                            if (y=180) Or (x=0) Or (x=749) Then
                            Begin
                                 bmpD[z] := 0;
                                 inc(z);
                                 // GREEN
                                 bmpD[z] := 0;
                                 inc(z);
                                 // RED
                                 bmpD[z] := 0;
                                 inc(z);
                            End
                            Else
                            Begin
                                 bmpD[z] := specDisplayData[y-1][x].b;
                                 inc(z);
                                 // GREEN
                                 bmpD[z] := specDisplayData[y-1][x].g;
                                 inc(z);
                                 // RED
                                 bmpD[z] := specDisplayData[y-1][x].r;
                                 inc(z);
                            End;
                       end;
                       inc(z); // This is correct (re double inc of z)
                       inc(z);
                  end;
                  // Write BMP to memory stream
                  globalData.specMs65.Position := 0;
                  z := SizeOf(bmpH);
                  globalData.specMs65.Write(bmpH,SizeOf(bmpH));
                  z := SizeOf(bmpD);
                  globalData.specMs65.Write(bmpD,SizeOf(bmpd));
                  globalData.specNewSpec65 := True;
             End
             Else
             Begin
                  globalData.specNewSpec65 := False;
             End;
        end;
     Except
        dlog.fileDebug('Exception raised in spectrum computation');
        globalData.specNewSpec65 := False;
     End;
     globalData.spectrumComputing65 := False;
     specFirstRun := False;
End;
end.
