unit globalData;
//
// Copyright (c) 2008,2009 J C Large - W6CQZ
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
  Classes, SysUtils, Graphics, CTypes;

Type
    hrdrigCAP = Record
     hasAFGain         : Boolean;
     hasRFGain         : Boolean;
     hasMicGain        : Boolean;
     hasPAGain         : Boolean;
     hasTX             : Boolean;
     hasSMeter         : Boolean;
     hasAutoTune       : Boolean;
     hasAutoTuneDo     : Boolean;
     hrdAlive          : Boolean;
     afgControl        : WideString;
     rfgControl        : WideString;
     micgControl       : WideString;
     pagControl        : WideString;
     txControl         : WideString;
     smeterControl     : WideString;
     autotuneControl   : WideString;
     autotuneControlDo : WideString;
     radioName         : WideString;
     radioContext      : WideString;
     hrdAddress        : WideString;
     hrdPort           : Word;
     afgMin, afgMax    : Integer;
     rfgMin, rfgMax    : Integer;
     micgMin, micgMax  : Integer;
     pagMin, pagMax    : Integer;
    end;

Var
   // Global Vars
   d65samfacin             : CTypes.cdouble;
   specMs65                : TMemoryStream;
   spectrumComputing65     : Boolean;
   audioComputing          : Boolean;
   specNewSpec65           : Boolean;
   gqrg                    : Double;
   iqrg                    : Integer;
   strqrg                  : String;
   rbLoggedIn              : Boolean;
   rbCacheOnly             : Boolean;
   txInProgress            : Boolean;
   debugOn                 : Boolean;
   fullcall                : String;
   gmode                   : Integer; // 65 or 4
   mtext                   : String;
   hrdcatControlcurrentRig : hrdrigCAP;
   hrdVersion              : Integer;
   canTX                   : Boolean;
   decimalOverride1        : Boolean;
   decimalOverride2        : Boolean;

   // The variable list above comprises those variables used in more than two
   // units (inclusive of maincode).  Addition of variables to this list should
   // be well thought out and NOT done if avoidable.

   // When translating fortran data types Integer*2 means a 16 bit int
   // integer is 32 bit. real is a single precision float and double or
   // real*8 is a double precision. Char*# is a string of # length, PChar
   // is the way to go there.
implementation

end.

