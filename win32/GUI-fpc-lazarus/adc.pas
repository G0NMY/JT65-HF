//
// Copyright (c) 2008...2011 J C Large - W6CQZ
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
unit adc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PortAudio, globalData, DateUtils, spectrum, math, CTypes, dlog;

Type
  inptr = ^CTypes.cint16;
  outptr = ^CTypes.cint16;

  function sadcCallback(input: inptr; output: outptr; frameCount: Longword;
                       timeInfo: PPaStreamCallbackTimeInfo;
                       statusFlags: TPaStreamCallbackFlags;
                       inputDevice: Pointer): Integer; cdecl;

  function madcCallback(input: inptr; output: Pointer; frameCount: Longword;
                        timeInfo: PPaStreamCallbackTimeInfo;
                        statusFlags: TPaStreamCallbackFlags;
                        inputDevice: Pointer): Integer; cdecl;

Var
   d65rxBuffer     : Packed Array[0..661503] of CTypes.cint16;   // This is slightly more than 60*11025 to make it evenly divided by 2048
   d65rxBufferPtr  : ^CTypes.cint16;
   d65rxBufferIdx  : Integer;
   adcChan         : Integer;  // 1 = Left, 2 = Right
   adcSpecCount    : Integer;
   adcErr          : CTypes.cdouble;
   adcRunning      : Boolean;
   adcLDgain       : Integer;
   adcRDgain       : Integer;
   adcTimeStamp    : Integer;
   adcLTimeStamp   : Integer;
   adcSTimeStamp   : TTimeStamp;
   adcErate        : Double;
   adcE, adcT      : LongInt;
   specLevel1      : Integer;
   specLevel2      : Integer;
   adcECount       : Integer;
   adcCount        : Integer;
   specDataBuffer  : Packed Array[0..4095] Of CTypes.cint16;
   specDataBuffer1 : Packed Array[0..2047] Of smallint;
   specDataBuffer2 : Packed Array[0..2047] Of smallint;
   adcOverrun      : Integer;

implementation

function computeAudio(Const Buffer : Array of CTypes.cint16) : Integer;
Var
   lrealArray                  : Array[0..2047] of CTypes.cfloat;
   fac, rms1, decibel, flevel : CTypes.cfloat;
   dgain, sum, ave, sq, d     : CTypes.cfloat;
   j, i, level                : Integer;
   specLrms                   : CTypes.cfloat;
Begin
     Try
        Result := 0;
        for i := 0 to 2047 do
        Begin
             lrealArray[i] := 0.0;
        End;
        fac := 0.0;
        rms1 := 0.0;
        decibel := 0.0;
        flevel := 0.0;
        dgain := 2.0;
        sum := 0.0;
        ave := 0.0;
        sq := 0.0;
        d := 0.0;
        level := 0;
        // Compute S-Meter Level.  Scale = 0-100, steps = .4db
        // Expects 2048 samples in dBuffer[bStart]..dBuffer[bEnd]
        fac := 2.0/10000.0;
        j := 0;
        for i := 0 to 2047 do
        Begin
             lrealArray[j] := 0.5 * dgain * buffer[i];
             inc(j);
        End;
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
        level := 0;
        if specLrms > 0 Then
        Begin
             decibel := 20 * log10(specLrms/800);
             flevel := 50 + 2.5 * decibel;
             flevel := min(100.0,max(0.0,flevel));
        End;
        level := trunc(flevel);
        Result := level;
     Except
        Result := 0;
     End;
End;

function sadcCallback(input: inptr; output: outptr; frameCount: Longword;
                       timeInfo: PPaStreamCallbackTimeInfo;
                       statusFlags: TPaStreamCallbackFlags;
                       inputDevice: Pointer): Integer; cdecl;
Var
   i               : Integer;
   tempInt1        : smallint;
   tempInt2        : smallint;
   tmpFloat        : single;
   dLGain, dRGain  : single;
   localIdx        : Integer;
Begin
     dlGain := 1.0;
     drGain := 1.0;
     if statusFlags = 2 Then inc(adcOverrun);
     inc(adccount);
     // Set ADC entry timestamp
     adcSTimeStamp := DateTimeToTimeStamp(Now);
     if adcRunning Then inc(adcECount);
     if adcRunning Then dlog.fileDebug('ADC overlap. ECount = ' + IntToStr(adcECount));
     adcRunning := True;
     // Setup dGain
     If (adcLDgain = 1) Or (adcLDgain = -1) Then dLGain := 1.26;
     If (adcLDgain = 2) Or (adcLDgain = -2) Then dLGain := 1.5876;
     If (adcLDgain = 3) Or (adcLDgain = -3) Then dLGain := 2;
     If (adcLDgain = 4) Or (adcLDgain = -4) Then dLGain := 2.52047376;
     If (adcLDgain = 5) Or (adcLDgain = -5) Then dLGain := 3.1757969376;
     If (adcLDgain = 6) Or (adcLDgain = -6) Then dLGain := 4;
     If (adcRDgain = 1) Or (adcRDgain = -1) Then dRGain := 1.26;
     If (adcRDgain = 2) Or (adcRDgain = -2) Then dRGain := 1.5876;
     If (adcRDgain = 3) Or (adcRDgain = -3) Then dRGain := 2;
     If (adcRDgain = 4) Or (adcRDgain = -4) Then dRGain := 2.52047376;
     If (adcRDgain = 5) Or (adcRDgain = -5) Then dRGain := 3.1757969376;
     If (adcRDgain = 6) Or (adcRDgain = -6) Then dRGain := 4;
     // Track/compute SR Error
     if adcT = 0 Then
     Begin
          adcE := 0;
          adcErr := 0;
          adcErate := 0;
          adcLTimeStamp := adcSTimeStamp.Time;
          adcTimeStamp  := adcSTimeStamp.Time;
     End
     Else
     Begin
          adcTimeStamp := adcSTimeStamp.Time;
          if adcTimeStamp > adcLTimeStamp Then
          Begin
               adcE := adcE+(adcTimeStamp - adcLTimeStamp);
               adcLTimeStamp := adcTimeStamp;
          End
          Else
          Begin
               adcT := -1;
          End;
     End;
     Try
        if adcT > 0 Then adcErr := adcE / adcT;
        if adcErr <> 0 Then adcErate := 185.75963718820861678004535147392/adcErr;
        inc(adcT);
        if adcT > 100000 Then adcT := 0;
     except
        adcT := 0;
        adcE := 0;
        adcErr := 0;
        adcErate := 0;
     end;
     // Move paAudio Buffer to d65rxBuffer (d65rxBufferIdx ranges 0..661503)
     //inptr := input;
     If d65rxBufferIdx > 661503 Then d65rxBufferIdx := 0;
     localIdx := d65rxBufferIdx;
     // Now I need to copy the frames to real rx buffer
     if not globalData.txInProgress Then
     Begin
          For i := 1 to frameCount do
          Begin
               //tempInt1 := inptr^;  // inptr is a pointer ^ indicates read value at pointer address NOT the pointer's value. :)
               tempInt1 := input^;  // inptr is a pointer ^ indicates read value at pointer address NOT the pointer's value. :)
               if adcLDgain <> 0 Then
               begin
                    try
                       if adcLDgain > 0 Then tmpFloat := tempInt1*dLGain;
                       if adcLDgain < 0 Then tmpFloat := tempInt1/dLGain;
                       tmpFloat := min(32766.0,max(-32766.0,tmpFloat));
                       tempInt1 := trunc(tmpFloat);
                    except
                       tempInt1 := 0;
                    end;
                    specDataBuffer1[i-1] := min(32766,max(-32766,tempInt1));
               end
               else
               begin
                    specDataBuffer1[i-1] := min(32766,max(-32766,tempInt1));
               end;
               //inc(inptr);
               inc(input);
               //tempInt2 := inptr^;
               tempInt2 := input^;
               if adcRDGain <> 0 Then
               Begin
                    try
                       if adcRDgain > 0 Then tmpFloat := tempInt2*dRGain;
                       if adcRDgain < 0 Then tmpFloat := tempInt2/dRGain;
                       tmpFloat := min(32766.0,max(-32766.0,tmpFloat));
                       tempInt2 := Trunc(tmpFloat);
                    except
                       tempInt2 := 0;
                    end;
                    specDataBuffer2[i-1] := min(32766,max(-32766,tempInt2));
               End
               Else
               Begin
                    specDataBuffer2[i-1] := min(32766,max(-32766,tempInt2));
               End;
               //inc(inptr);
               inc(input);
               if localIdx < 661504 Then
               Begin
                    if adcChan = 1 Then d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt1));
                    if adcChan = 2 Then d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt2));
               End
               Else
               Begin
                    localIdx := 0;
                    d65rxBufferIdx := 0;
                    if adcChan = 1 Then d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt1));
                    if adcChan = 2 Then d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt2));
               End;
               inc(d65rxBufferIdx);
               if d65rxBufferIdx > 661503 Then d65rxBufferIdx := 0;
               localIdx := d65rxBufferIdx;
          End;
          // Compute audio levels
          //If not globalData.audioComputing and not globalData.spectrumComputing65 Then specLevel1 := spectrum.computeAudio(specDataBuffer1);  // Chan 1 (Left)
          //If not globalData.audioComputing and not globalData.spectrumComputing65 Then specLevel2 := spectrum.computeAudio(specDataBuffer2);  // Chan 2 (Right)
          specLevel1 := computeAudio(specDataBuffer1);  // Chan 1 (Left)
          specLevel2 := computeAudio(specDataBuffer2);  // Chan 2 (Right)
          // Spectrum generation handler.
          //If adcSpecCount = 0 Then
          //Begin
          //     // Copy proper 2K buffer to first half of 4K spectrum buffer
          //     inc(adcSpecCount);
          //     for i := 0 to 2047 do
          //     Begin
          //          if adcChan = 1 Then specDataBuffer[i] := specDataBuffer1[i] else specDataBuffer[i] := specDataBuffer2[i];
          //     End;
          //End
          //Else
          //Begin
          //     // Copy proper 2K buffer to second half of 4K spectrum buffer
          //     adcSpecCount := 0;
          //     for i := 0 to 2047 do
          //     Begin
          //          if adcChan = 1 Then specDataBuffer[i+2048] := specDataBuffer1[i] else specDataBuffer[i+2048] := specDataBuffer2[i];
          //     End;
          //     // Also need to generate the spectrum
          //     if not globalData.spectrumComputing65 then spectrum.computeSpectrum(specDataBuffer);
          //End;
     End;
     result := paContinue;
     adcRunning := False;
End;

function madcCallback(input: inptr; output: Pointer; frameCount: Longword;
                      timeInfo: PPaStreamCallbackTimeInfo;
                      statusFlags: TPaStreamCallbackFlags;
                      inputDevice: Pointer): Integer; cdecl;
Var
   tempInt1        : smallint;
   tempInt2        : smallint;
   tmpFloat        : single;
   dLGain, dRGain  : single;
   localIdx, i     : Integer;
Begin
     dlGain := 1.0;
     drGain := 1.0;
     if statusFlags = 2 Then inc(adcOverrun);
     inc(adccount);
     // Set ADC entry timestamp
     adcSTimeStamp := DateTimeToTimeStamp(Now);
     if adcRunning Then inc(adcECount);
     if adcRunning Then dlog.fileDebug('ADC overlap. ECount = ' + IntToStr(adcECount));
     adcRunning := True;
     // Setup dGain
     If (adcLDgain = 1) Or (adcLDgain = -1) Then dLGain := 1.26;
     If (adcLDgain = 2) Or (adcLDgain = -2) Then dLGain := 1.5876;
     If (adcLDgain = 3) Or (adcLDgain = -3) Then dLGain := 2;
     If (adcLDgain = 4) Or (adcLDgain = -4) Then dLGain := 2.52047376;
     If (adcLDgain = 5) Or (adcLDgain = -5) Then dLGain := 3.1757969376;
     If (adcLDgain = 6) Or (adcLDgain = -6) Then dLGain := 4;
     If (adcRDgain = 1) Or (adcRDgain = -1) Then dRGain := 1.26;
     If (adcRDgain = 2) Or (adcRDgain = -2) Then dRGain := 1.5876;
     If (adcRDgain = 3) Or (adcRDgain = -3) Then dRGain := 2;
     If (adcRDgain = 4) Or (adcRDgain = -4) Then dRGain := 2.52047376;
     If (adcRDgain = 5) Or (adcRDgain = -5) Then dRGain := 3.1757969376;
     If (adcRDgain = 6) Or (adcRDgain = -6) Then dRGain := 4;
     // Track/compute SR Error
     if adcT = 0 Then
     Begin
          adcE := 0;
          adcErr := 0;
          adcErate := 0;
          adcLTimeStamp := adcSTimeStamp.Time;
          adcTimeStamp  := adcSTimeStamp.Time;
     End
     Else
     Begin
          adcTimeStamp := adcSTimeStamp.Time;
          if adcTimeStamp > adcLTimeStamp Then
          Begin
               adcE := adcE+(adcTimeStamp - adcLTimeStamp);
               adcLTimeStamp := adcTimeStamp;
          End
          Else
          Begin
               adcT := -1;
          End;
     End;
     Try
        if adcT > 0 Then adcErr := adcE / adcT;
        if adcErr <> 0 Then adcErate := 185.75963718820861678004535147392/adcErr;
        inc(adcT);
        if adcT > 100000 Then adcT := 0;
     except
        adcT := 0;
        adcE := 0;
        adcErr := 0;
        adcErate := 0;
     end;
     // Move paAudio Buffer to d65rxBuffer (d65rxBufferIdx ranges 0..661503)
     If d65rxBufferIdx > 661503 Then d65rxBufferIdx := 0;
     localIdx := d65rxBufferIdx;
     // Now I need to copy the frames to real rx buffer
     if not globalData.txInProgress Then
     Begin
          For i := 1 to frameCount do
          Begin
               tempInt1 := input^;  // input is a pointer ^ indicates read value at pointer address NOT the pointer's value. :)
               if adcLDgain <> 0 Then
               begin
                    try
                       if adcLDgain > 0 Then tmpFloat := tempInt1*dLGain;
                       if adcLDgain < 0 Then tmpFloat := tempInt1/dLGain;
                       tmpFloat := min(32766.0,max(-32766.0,tmpFloat));
                       tempInt1 := trunc(tmpFloat);
                    except
                       tempInt1 := 0;
                    end;
                    specDataBuffer1[i-1] := min(32766,max(-32766,tempInt1));
               end
               else
               begin
                    specDataBuffer1[i-1] := min(32766,max(-32766,tempInt1));
               end;
               inc(input);
               if localIdx < 661504 Then
               Begin
                    d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt1));
               End
               Else
               Begin
                    localIdx := 0;
                    d65rxBufferIdx := 0;
                    d65rxBuffer[localIdx] := min(32766,max(-32766,tempInt1));
               End;
               inc(d65rxBufferIdx);
               if d65rxBufferIdx > 661503 Then d65rxBufferIdx := 0;
               localIdx := d65rxBufferIdx;
          End;
          // Compute audio levels
          //If not globalData.audioComputing and not globalData.spectrumComputing65 Then specLevel1 := spectrum.computeAudio(specDataBuffer1);  // Chan 1 (Left)
          //If not globalData.audioComputing and not globalData.spectrumComputing65 Then specLevel2 := spectrum.computeAudio(specDataBuffer2);  // Chan 2 (Right)
          specLevel1 := computeAudio(specDataBuffer1);  // Chan 1 (Left)
          //specLevel2 := computeAudio(specDataBuffer2);  // Chan 2 (Right)
          specLevel2 := 50;
          // Spectrum generation handler.
          //If adcSpecCount = 0 Then
          //Begin
          //     // Copy proper 2K buffer to first half of 4K spectrum buffer
          //     inc(adcSpecCount);
          //     for i := 0 to 2047 do
          //     Begin
          //          if adcChan = 1 Then specDataBuffer[i] := specDataBuffer1[i] else specDataBuffer[i] := specDataBuffer2[i];
          //     End;
          //End
          //Else
          //Begin
          //     // Copy proper 2K buffer to second half of 4K spectrum buffer
          //     adcSpecCount := 0;
          //     for i := 0 to 2047 do
          //     Begin
          //          if adcChan = 1 Then specDataBuffer[i+2048] := specDataBuffer1[i] else specDataBuffer[i+2048] := specDataBuffer2[i];
          //     End;
          //     // Also need to generate the spectrum
          //     if not globalData.spectrumComputing65 then spectrum.computeSpectrum(specDataBuffer);
          //End;
     End;
     result := paContinue;
     adcRunning := False;
End;

end.

