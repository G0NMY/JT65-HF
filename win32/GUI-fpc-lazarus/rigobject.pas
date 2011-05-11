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
unit rigobject ;

{$mode objfpc}{$H+}

interface

uses
  Classes , SysUtils, StrUtils, omnirigobject, civobject, ddehrdobject;

type
  // This class encapsulates all the things related to rig control be it manual
  // or via computer control.  No matter the actual controller method all things
  // involving the radio is handled through the properties here.
  //
  // In the case of manual control (method = none) nothing is actually controlled
  // and this is nothing more than a set of variables.  For 'real' rig control
  // the variables are read from the rig and, in some cases, written to the rig
  // when a write method is called on a property.
  //
  // This allows a common interface to all the (very) different ways rig controllers
  // work and dispatches the correct code for a given property access depending
  // upon the rig control method type.
  TRadio = Class
     private
        // Features available
        sthasAFGain   : Boolean;
        sthasRFGain   : Boolean;
        sthasMicGain  : Boolean;
        sthasPAGain   : Boolean;
        sthasPTT      : Boolean;
        sthasSMeter   : Boolean;
        sthasAutoTune : Boolean;
        // Control values
        stRig         : String;  // Rig's name
        stControl     : String;  // Rig's controller
        stQRG         : Integer; // Current frequency in Hz
        stSMeter      : Integer; // Current S Meter value [0 ... 255]
        stAUOut       : Integer; // Rig's volume control
        stAUIn        : Integer; // Rig's input level control
        stPALevel     : Integer; // Rig's PA level control
        stRFGain      : Integer; // Rig's RF Gain setting
        stPTT         : Boolean; // Rig's PTT State
        stCommand     : String;  // Command string to send

     public
        Constructor create();
        // Set the rig control method [none, hrd, commander, omni, hamlib, si570]
        procedure setRigController(msg : String);
        // Set the rig's QRG
        // Call validate to return an overall status of configuration object.
        // Anything critical that is incorrect will lead to a false result.
        function  validate() : Boolean;
        // Feed this a QRG (string) and it will return a value in hertz (integer)
        function  testQRG(qrg : String) : Integer;
        // Sets QRG, returns false if bad value input
        function  setQRG(qrg : Integer) : Boolean;
        // Once all is setup use pollRig to populate the properties.
        procedure pollRig();
        // Passes a command to rig
        procedure writeRig(msg : String);

        property hasAFGain : Boolean
           read  sthasAFGain;
        property hasRFGain : Boolean
           read  sthasRFGain;
        property hasMicGain : Boolean
           read  sthasMicGain;
        property hasPAGain : Boolean
           read  sthasPAGain;
        property hasPTT : Boolean
           read  sthasPTT;
        property hasSMeter : Boolean
           read  sthasSMeter;
        property hasAutoTune : Boolean
           read  sthasAutoTune;
        property rig : String
           read  stRig;
        property rigcontroller : String
           read  stControl
           write setRigController;
        property qrg : Integer
           read  stQRG;
        property smeter : Integer
           read stSMeter;
        property volumeOut : Integer
           read  stAUOut
           write stAUOut;
        property volumeIn : Integer
           read  stAUIn
           write stAUIn;
        property rfoutput : Integer
           read  stPALevel
           write stPALevel;
        property rfgain : Integer
           read  stRFGain
           write stRFGain;
        property pttstate : Boolean
           read  stPTT
           write stPTT;
        property configurationValid : Boolean
           read validate;
        property command : String
           write writeRig;
  end;

var
   civ1   : civobject.TCIVCommander;
   omni1  : omnirigobject.TOmniRig;
   dhrd1  : ddehrdobject.THrdDdeRig;

implementation
   constructor TRadio.Create();
   begin
        sthasAFGain   := False;
        sthasRFGain   := False;
        sthasMicGain  := False;
        sthasPAGain   := False;
        sthasPTT      := False;
        sthasSMeter   := False;
        sthasAutoTune := False;
        // Control values
        stRig         := '';
        stControl     := 'none';
        stQRG         := 0;
        stSMeter      := 0;
        stAUOut       := 0;
        stAUIn        := 0;
        stPALevel     := 0;
        stRFGain      := 0;
        stPTT         := False;
        stCommand     := '';
        civ1          := civobject.TCIVCommander.create();
        omni1         := omnirigobject.TOmniRig.create();
        dhrd1         := ddehrdobject.THrdDdeRig.create();
        //si570         := si570object.TSi570Rig.create();
   end;

   function TRadio.validate() : Boolean;
   Begin
        result := true;
   end;

   procedure TRadio.setRigController(msg : String);
   var
        valid : Boolean;
   begin
        valid := False;
        // Set the rig control method [none, hrd, commander, omni, hamlib, si570]
        if msg = 'none' then valid := True;
        if msg = 'hrd' then valid := True;
        if msg = 'commander' then valid := True;
        if msg = 'omni' then valid := True;
        if msg = 'hamlib' then valid := True;
        if msg = 'si570' then valid := True;
        if valid then stControl := msg else stControl := 'none';
   end;

   function TRadio.setQRG(qrg : Integer) : Boolean;
   var
        foo   : String;
        valid : Boolean;
        vqrg  : Integer;
   begin
        foo := IntToStr(qrg);
        vqrg := testQRG(foo);
        if vqrg > 0 then valid := true else valid := false;
        if valid then
        begin
             if stControl = 'none' then
             begin
                  stQRG := qrg;
                  result := true;
             end
             else
             begin
                  // Not manual so here we go with rig control
                  result := true;
             end;
        end
        else
        begin
             stQRG := 0;
             result := false;
        end;
   end;

   function TRadio.testQRG(qrg : String) : Integer;
   var
        i, j     : Integer;
        tstint   : Integer;
        tstflt   : Double;
        valid    : Boolean;
        foo      : String;
   begin
        // Test for , in value and replace with .
        foo := trimleft(trimright(qrg));
        j := length(foo);
        for i := 1 to j do
        begin
             if foo[i] = ',' then foo[i] := '.';
        end;
        // Test for non-numerics
        valid := true;
        for i := 1 to j do
        begin
             if valid then
             begin
                  case foo[i] of '0'..'9': valid := True else valid := False; end;
                  if not valid then
                  begin
                       case foo[i] of '.': valid := True else valid := False; end;
                  end;
             end;
        end;
        if valid then
        begin
             tstint := 0;
             tstflt := 0.0;
             // Now it's time to attempt a conversion of what I've been given
             // to hertz.  I may get Hz, KHz or MHz input.
             // Test to see if it's an integer or float first.
             If not AnsiContainsText(foo,'.') then
             begin
                  // It's an integer
                  If TryStrToInt(qrg, tstint) Then tstflt := tstint * 1.0 else tstflt := 0.0;
             end
             else
             begin
                  // It's a floater
                  If TryStrToFloat(qrg,tstflt) Then tstflt := tstflt * 1.0 else tstflt := 0.0;
             end;
             // tstflt now contains a floating point value of the submitted string
             // parse it and convert to Hz
             // Ranges:
             // 1.8 ... 450 MHz
             // 1800 ... 450000 KHz
             // 1,800,000 ... 450,000,000 Hz
             If tstflt < 1800 then
             begin
                  // Seems to be MHz
                  result := trunc(tstflt * 1000000);
             end;
             if (tstflt > 1799.9) and (tstflt < 450000.1) then
             begin
                  // Seems to be KHz
                  result := trunc(tstflt * 1000);
             end;
             if (tstflt > 1799999.0) and (tstflt < 450000000.1) then
             begin
                  // Seems to be Hz
                  result := trunc(tstflt);
             end;
        end
        else
        begin
             result := 0;
        end;
   end;

   procedure TRadio.pollRig();
   var
        foo  : string;
        foo2 : string;
        i    : integer;
   begin
        if stControl = 'commander' Then
        begin
             // Commander returns QRG In KHz with damnable , plus .
             // Now the question becomes what happens when the user
             // has a number format set that uses , as decimal pont?
             // Do I get 28.076,00 or 28,076,00 or 28,076.00?  And is it
             // always .## or does it do .### in some cases?  If it's always
             // .00 then I can simply add a 0 to the string, stip all the . or ,
             // and it'll be Hz
             // So...
             //   1,838.00 =   1838 KHz =   1838000 Hz
             //  10,139.00 =  10139 KHz =  10139000 Hz
             // 144,200.00 = 144200 KHz = 144200000 Hz
             civ1.pollRig();
             foo := trimleft(trimright(civ1.rxqrg));
             if AnsiContainsText(foo,',') Then
             Begin
                  // Looking for a case where I have a , and a . indicating
                  // something like 28,076.00
                  if AnsiContainsText(foo,'.') Then
                  begin
                       // This seems to be something like #,###.##
                       // Strip , and leave . yielding something I can
                       // convert from KHz to Hz (I hope)
                       foo2 := '';
                       for i := 1 to length(foo) do
                       begin
                            if foo[i] = ',' then
                            begin
                                 // Do all of nothing
                            end
                            else
                            begin
                                 foo2 := foo2 + foo[i];
                            end;
                       end;
                  end
                  else
                  begin
                       // Now I have a string with a , but no .
                       // What is it?  #####,## or ##,###,##?
                  end;
             end;
             stQRG         := testQRG(foo2);
             stRig         := civ1.rigname;
             stSMeter      := 0;
             stAUOut       := 0;
             stAUIn        := 0;
             stPALevel     := 0;
             stRFGain      := 0;
             stPTT         := false;
        end;
        if stControl = 'omni' Then
        begin
             omni1.pollRig();
             stRig         := omni1.rig1;
             stQRG         := testQRG(omni1.qrg1);
             stSMeter      := 0;
             stAUOut       := 0;
             stAUIn        := 0;
             stPALevel     := 0;
             stRFGain      := 0;
             stPTT         := False;
        end;
        if stControl = 'hrd' Then
        begin
             dhrd1.pollRig();
             stQRG         := testQRG(dhrd1.rxqrg);
             stRig         := dhrd1.rigname;
             stSMeter      := 0;
             stAUOut       := 0;
             stAUIn        := 0;
             stPALevel     := 0;
             stRFGain      := 0;
             stPTT         := dhrd1.txOn;
        end;
        if stControl = 'hamlib' Then
        begin
             // Not implemented (yet) do nothing
        end;
        if stControl = 'none' Then
        begin
             // Do nothing
        end;
   end;

   procedure TRadio.writeRig(msg : String);
   begin
        if stControl = 'commander' Then
        begin
             civ1.command := '';
             civ1.setRig(msg);
        end;

        if stControl = 'omni' Then
        begin
        end;

        if stControl = 'hrd' Then
        begin
        end;

        if stControl = 'hamlib' Then
        begin
             // Not implemented (yet) do nothing
        end;

        if stControl = 'si570' Then
        begin
        end;

        if stControl = 'none' Then
        begin
             // Do nothing
        end;
   end;
end.

