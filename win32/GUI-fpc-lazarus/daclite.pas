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
unit daclite;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, PortAudio, globalData, DateUtils, CTypes;

Type
  outptr = ^CTypes.cint16;
  inptr = ^CTypes.cint16;

function sdacCallback(input: inptr; output: outptr; frameCount: Longword;
                       timeInfo: PPaStreamCallbackTimeInfo;
                       statusFlags: TPaStreamCallbackFlags;
                       inputDevice: Pointer): Integer; cdecl;

function mdacCallback(input: inptr; output: outptr; frameCount: Longword;
                       timeInfo: PPaStreamCallbackTimeInfo;
                       statusFlags: TPaStreamCallbackFlags;
                       inputDevice: Pointer): Integer; cdecl;

Var
   d65txBuffer    : Packed Array[0..661503] of CTypes.cint16;
   d65txBufferPtr : ^CTypes.cint16;
   d65txBufferIdx : Integer;
   dacE, dacT     : LongInt;
   dacErate       : Double;
   dacEavg        : Double;
   dacErr         : CTypes.cdouble;
   dacTimeStamp   : Integer;
   dacLTimeStamp  : Integer;
   dacSTimeStamp  : TTimeStamp;
   dacUnderrun    : Integer;
   dacCount       : Integer;
   dacEnTX        : Boolean;

implementation
// the adclite and daclite callback units are for use in the configuration system for
// testing sound devices.  This allows things to be done on the fly that would be
// dangerous if the main adc/dac routines were attempted to be used concurrently.
function sdacCallback(input: inptr; output: outptr; frameCount: Longword;
                     timeInfo: PPaStreamCallbackTimeInfo;
                     statusFlags: TPaStreamCallbackFlags;
                     inputDevice: Pointer): Integer; cdecl;
Var
   i             : Integer;
   optr          : ^smallint;
Begin
     if statusFlags = 8 Then inc(dacUnderrun);
     inc(dacCount);
     // Set DAC entry timestamp
     dacSTimeStamp := DateTimeToTimeStamp(Now);
     if dacT = 0 Then
     Begin
          dacE := 0;
          dacErr := 0;
          dacErate := 0;
          dacEavg := 0;
          dacLTimeStamp := dacSTimeStamp.Time;
          dacTimeStamp  := dacSTimeStamp.Time;
     End
     Else
     Begin
          dacTimeStamp := dacSTimeStamp.Time;
          if dacTimeStamp > dacLTimeStamp Then
          Begin
               dacE := dacE+(dacTimeStamp - dacLTimeStamp);
               dacLTimeStamp := dacTimeStamp;
          End
          Else
          Begin
               dacT := -1;
          End;
     End;
     if dacT > 0 Then dacErr := dacE / dacT;
     dacErate := 185.75963718820861678004535147392/dacErr;
     inc(dacT);
     if dacT > 100000 Then dacT := 0;
     optr := output;
     for i := 0 to frameCount-1 do
     Begin
          optr^ := 0;
          inc(optr);
          optr^ := 0;
          inc(optr);
     End;
     result := paContinue;
End;

function mdacCallback(input: inptr; output: outptr; frameCount: Longword;
                     timeInfo: PPaStreamCallbackTimeInfo;
                     statusFlags: TPaStreamCallbackFlags;
                     inputDevice: Pointer): Integer; cdecl;
Var
   i             : Integer;
   optr          : ^smallint;
Begin
     if statusFlags = 8 Then inc(dacUnderrun);
     inc(dacCount);
     // Set DAC entry timestamp
     dacSTimeStamp := DateTimeToTimeStamp(Now);
     if dacT = 0 Then
     Begin
          dacE := 0;
          dacErr := 0;
          dacErate := 0;
          dacEavg := 0;
          dacLTimeStamp := dacSTimeStamp.Time;
          dacTimeStamp  := dacSTimeStamp.Time;
     End
     Else
     Begin
          dacTimeStamp := dacSTimeStamp.Time;
          if dacTimeStamp > dacLTimeStamp Then
          Begin
               dacE := dacE+(dacTimeStamp - dacLTimeStamp);
               dacLTimeStamp := dacTimeStamp;
          End
          Else
          Begin
               dacT := -1;
          End;
     End;
     if dacT > 0 Then dacErr := dacE / dacT;
     dacErate := 185.75963718820861678004535147392/dacErr;
     inc(dacT);
     if dacT > 100000 Then dacT := 0;
     optr := output;
     for i := 0 to frameCount-1 do
     Begin
          optr^ := 0;
          inc(optr);
     End;
     result := paContinue;
End;
end.

