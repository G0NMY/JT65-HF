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
unit ddehrdobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ddeobject;

Type
  THrdDdeRig = Class
   private
      prRXQRG     : string;
      prTXQRG     : string;
      prMode      : string;
      prRigType   : string;
      prRigName   : string;
      prRigOnline : Boolean;
      prTXOn      : Boolean;
      prState     : string;

   public
      Constructor create();

      // Call this to populate the variables
      procedure pollRig();
      // Call this to write properties to rig
      procedure setRig();

      property rxqrg : String
         read  prRXQRG
         write prRXQRG;
      property txqrg : String
         read  prTXQRG
         write prTXQRG;
      property mode : String
         read  prMode
         write prMode;
      property rigtype  : String
         read  prRigType;
      property rigname  : String
         read  prRigName;
      property rigState : String
         read  prState;
      property rigReady : Boolean
         read  prRigOnline;
      property txOn : Boolean
         read  prTXOn
         write prTXOn;
end;

var
     dde1        : ddeobject.TDDEConversation;

implementation

constructor THrdDdeRig.Create();
begin
     prRXQRG      := '';
     prTXQRG      := '';
     prMode       := '';
     prRigType    := '';
     prRigName    := '';
     prState      := '';
     prRigOnline  := false;
     prTXOn       := false;
     dde1         := ddeobject.TDDEConversation.create();
end;

procedure THrdDdeRig.pollRig();
begin
     // DDE Object at long last completed.  Below is example of its use.  I've used it to
     // (so far) interface with CI-V Commander and HRD.
     dde1.ddeService := 'HRD_RADIO_000';
     dde1.ddeTopic   := 'HRD_CAT';
     dde1.ddeItem    := 'HRD_HERTZ';
     prRXQRG := dde1.ddeGetItem;
     dde1.ddeItem := 'HRD_HERTZ';
     prTXQRG := dde1.ddeGetItem;
     dde1.ddeItem := 'HRD_MODE';
     prMode := dde1.ddeGetItem;
     //dde1.ddeItem := 'RadioState';
     //prState := dde1.ddeGetItem;
     prState := '';
     //dde1.ddeItem := 'RadioModel';
     //prRigType := dde1.ddeGetItem;
     prRigType := '';
     //dde1.ddeItem := 'RadioName';
     //prRigName := dde1.ddeGetItem;
     prRigName := '';
end;

procedure THrdDdeRig.setRig();
begin
end;

end.
