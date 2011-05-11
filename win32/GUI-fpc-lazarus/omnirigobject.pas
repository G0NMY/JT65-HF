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
unit omnirigobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Variants, Comobj;

Const ST_NOTCONFIGURED = '0';
Const ST_DISABLED      = '1';
Const ST_PORTBUSY      = '2';
Const ST_NOTRESPONDING = '3';
Const ST_ONLINE        = '4';

Type
  TOmniRig = Class
   private
      prOmniRig            : variant;
      prQRG1               : string;
      prQRG1a              : string;
      prQRG2a              : string;
      prQRG2               : string;
      prQRG1b              : string;
      prQRG2b              : string;
      prRigType1           : string;
      prRigType2           : string;
      prRig1Online         : Boolean;
      prRig2Online         : Boolean;

   public
      Constructor create();

      // Call this to populate the variables
      procedure pollRig();

      property qrg1 : String
         read  prQRG1
         write prQRG1;
      property qrg1a : String
         read  prQRG1a
         write prQRG1a;
      property qrg1b : String
         read  prQRG1b
         write prQRG1b;
      property qrg2  : String
         read  prQRG2
         write prQRG2;
      property qrg2a : String
         read  prQRG2a
         write prQRG2a;
      property qrg2b : String
         read  prQRG2b
         write prQRG2b;
      property rig1  : String
         read  prRigType1;
      property rig2  : String
         read  prRigType2;
      property rigReady1 : Boolean
         read  prRig1Online;
      property rigReady2 : Boolean
         read  prRig2Online;

end;

implementation

constructor TOmniRig.Create();
begin
     prOmniRig    := nil;
     prQRG1       := '';
     prQRG1a      := '';
     prQRG2       := '';
     prQRG1b      := '';
     prQRG2b      := '';
     prRigType1   := '';
     prRigType2   := '';
     prRig1Online := false;
     prRig2Online := false;
end;

procedure TOmniRig.pollRig();
var
     foo : String;
Begin
     Try
        prOmniRig := CreateOleObject('OmniRig.OmniRigX');
        foo := prOmniRig.Rig1.Status;
        If foo <> ST_ONLINE Then prRig1Online := false else prRig1Online := true;
        foo := prOmniRig.Rig2.Status;
        If foo <> ST_ONLINE Then prRig2Online := false else prRig2Online := true;
        if prRig1Online then
        begin
             prRigType1 := prOmniRig.Rig1.RigType;
             prQRG1a    := prOmniRig.Rig1.FreqA;
             prQRG1b    := prOmniRig.Rig1.FreqB;
             prQRG1     := prOmniRig.Rig1.Freq;
        end
        else
        begin
             prRigType1 := 'No Rig';
             prQRG1a    := '0';
             prQRG1b    := '0';
             prQRG1     := '0';
        end;

        if prRig2Online then
        begin
             prRigType2 := prOmniRig.Rig2.RigType;
             prQRG2a    := prOmniRig.Rig2.FreqA;
             prQRG2b    := prOmniRig.Rig2.FreqB;
             prQRG2     := prOmniRig.Rig2.Freq;
        end
        else
        begin
             prRigType2 := 'No Rig';
             prQRG2a    := '0';
             prQRG2b    := '0';
             prQRG2     := '0';
        end;
     except
           //On EOleSysError do
           //begin
             prRig1Online := false;
             prRig2Online := false;
             prRigType1 := 'No OmniRig';
             prQRG1a    := '0';
             prQRG1b    := '0';
             prQRG1     := '0';
             prRigType2 := 'No OmniRig';
             prQRG2a    := '0';
             prQRG2b    := '0';
             prQRG2     := '0';
           //end;
     end;
end;

end.

