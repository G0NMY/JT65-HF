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
unit civobject;

{$mode objfpc}{$H+}

interface

uses
  Classes , SysUtils, ddeobject;

Type
  TCIVCommander = Class
   private
      prRXQRG     : string;
      prTXQRG     : string;
      prMode      : string;
      prRigType   : string;
      prRigName   : string;
      prRigOnline : Boolean;
      prTXOn      : Boolean;
      prState     : string;
      prCommand   : string;

   public
      Constructor create();

      // Call this to populate the variables
      procedure pollRig();
      // Call this to write properties to rig
      procedure setRig(msg : String);

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
      property command  : String
         write setRig;
end;

var
     dde1        : ddeobject.TDDEConversation;

implementation

constructor TCIVCommander.Create();
begin
     prRXQRG      := '';
     prTXQRG      := '';
     prMode       := '';
     prRigType    := '';
     prRigName    := '';
     prState      := '';
     prCommand    := '';
     prRigOnline  := false;
     prTXOn       := false;
     dde1         := ddeobject.TDDEConversation.create();
end;

procedure TCIVCommander.pollRig();
begin
     try
     // DDE Object at long last completed.  Below is example of its use.  I've used it to
     // (so far) interface with CI-V Commander and HRD.
     dde1.ddeService := 'CI-V Commander';
     dde1.ddeTopic   := 'DDESERVER';
     dde1.ddeItem    := 'RcvFreq';
     prRXQRG := dde1.ddeGetItem;
     dde1.ddeItem := 'XmitFreq';
     prTXQRG := dde1.ddeGetItem;
     dde1.ddeItem := 'Mode';
     prMode := dde1.ddeGetItem;
     dde1.ddeItem := 'RadioState';
     prState := dde1.ddeGetItem;
     dde1.ddeItem := 'RadioModel';
     prRigType := dde1.ddeGetItem;
     dde1.ddeItem := 'RadioName';
     prRigName := dde1.ddeGetItem;
     except
       halt;
     end;
end;

procedure TCIVCommander.setRig(msg : String);
begin
     dde1.ddeService := 'CI-V Commander';
     dde1.ddeTopic   := 'DDESERVER';
     dde1.ddeCommand := msg;
     dde1.doDDEWrTransaction();
end;

end.

