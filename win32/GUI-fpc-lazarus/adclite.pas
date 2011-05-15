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
unit adclite;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PortAudio, globalData, DateUtils, math, CTypes;

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
// the adclite and daclite callback units are for use in the configuration system for
// testing sound devices.  This allows things to be done on the fly that would be
// dangerous if the main adc/dac routines were attempted to be used concurrently.

function sadcCallback(input: inptr; output: outptr; frameCount: Longword;
                       timeInfo: PPaStreamCallbackTimeInfo;
                       statusFlags: TPaStreamCallbackFlags;
                       inputDevice: Pointer): Integer; cdecl;
Var
   i               : Integer;
   tempInt1        : smallint;
   tempInt2        : smallint;
   localIdx        : Integer;
Begin
     if statusFlags = 2 Then inc(adcOverrun);
     inc(adccount);
     // Set ADC entry timestamp
     adcSTimeStamp := DateTimeToTimeStamp(Now);
     if adcRunning Then inc(adcECount);
     adcRunning := True;
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
               tempInt1 := input^;  // inptr is a pointer ^ indicates read value at pointer address NOT the pointer's value. :)
               inc(input);
               tempInt2 := input^;
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
   localIdx, i     : Integer;
Begin
     if statusFlags = 2 Then inc(adcOverrun);
     inc(adccount);
     // Set ADC entry timestamp
     adcSTimeStamp := DateTimeToTimeStamp(Now);
     if adcRunning Then inc(adcECount);
     adcRunning := True;
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
     End;
     result := paContinue;
     adcRunning := False;
End;

end.

