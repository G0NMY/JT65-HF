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
  Classes , SysUtils, StrUtils, omnirigobject, civobject, hrdobject;

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
        // Control values
        stRig         : String;  // Rig's name
        stControl     : String;  // Rig's controller
        stQRG         : Integer; // Current frequency in Hz
        stPTT         : Boolean; // Rig's PTT State

     public
        Constructor create();
        // Set the rig control method [none, hrd, commander, omni]
        procedure setRigController(msg : String);
        // Call validate to return an overall status of configuration object.
        // Anything critical that is incorrect will lead to a false result.
        //function  validate() : Boolean;
        // Feed this a QRG (string) and it will return a value in hertz (integer)
        function  testQRG(qrg : String; mode : String) : Integer;
        // Sets QRG, returns false if bad value input
        function  setQRG(qrg : Integer) : Boolean;
        // Once all is setup use pollRig to populate the properties.
        procedure pollRig();
        // Toggle PTT
        procedure togglePTT();

        property rig : String
           read  stRig;
        property rigcontroller : String
           read  stControl
           write setRigController;
        property qrg : Integer
           read  stQRG;
        property pttstate : Boolean
           read  stPTT
           write stPTT;
  end;

var
   civ1   : civobject.TCIVCommander;
   omni1  : omnirigobject.TOmniRig;
   hrd1   : hrdobject.THrdRig;

implementation
   constructor TRadio.Create();
   begin
        // Control values
        stRig         := '';
        stControl     := 'none';
        stQRG         := 0;
        stPTT         := False;
        civ1          := civobject.TCIVCommander.create();
        omni1         := omnirigobject.TOmniRig.create();
        hrd1          := hrdobject.THrdRig.create();

   end;

   procedure TRadio.setRigController(msg : String);
   var
        valid : Boolean;
   begin
        valid := False;
        // Set the rig control method [none, hrd, commander, omni]
        msg := upcase(msg);
        if msg = 'NONE' then valid := True;
        if msg = 'HRD' then valid := True;
        if msg = 'COMMANDER' then valid := True;
        if msg = 'OMNI' then valid := True;
        if valid then stControl := msg else stControl := 'none';
   end;

   function TRadio.setQRG(qrg : Integer) : Boolean;
   var
        foo, foo1 : String;
        valid     : Boolean;
        vqrg      : Integer;
   begin
        foo := IntToStr(qrg);
        vqrg := testQRG(foo,'lax');
        if vqrg > 0 then valid := true else valid := false;
        if valid then
        begin
             if stControl = 'NONE' then
             begin
                  stQRG := qrg;
                  result := true;
             end;
             if stControl = 'COMMANDER' Then
             begin
                  stQRG := qrg;
                  // Commander wants QRG in KHz as string
                  foo1 := floatToStr(qrg/1000);
                  foo := '000xcvrfreqmode<xcvrfreq:' + intToStr(length(foo1)) + '>' + foo1 + '<xcvrmode:3>USB';
                  civ1.setRig(foo);
                  result := true;
             end;

             if stControl = 'OMNI' Then
             begin
             end;

             if stControl = 'HRD' Then
             begin
                  stQRG := qrg;
                  // HRD wants QRG in Hz as string
                  hrd1.setQRG(qrg);
                  result := true;
             end;

             if stControl = 'HAMLIB' Then
             begin
                  // Not implemented (yet) do nothing
             end;

             if stControl = 'NONE' Then
             begin
                  stQRG := qrg;
                  result := true;
             end;
        end
        else
        begin
             stQRG := 0;
             result := false;
        end;
   end;

   function TRadio.testQRG(qrg : String; mode : string) : Integer;
   var
        i        : Integer;
        i1,i2,i3 : Integer;
        found    : Boolean;
        resolved : Boolean;
        foo, s1  : String;
        s2       : String;
   begin
        // Returns an integer value in Hz for an input string that may be
        // in MHz, KHz or Hz.  Mode parameter can be lax or strict.  If
        // strict then QRG must resolve to a valid amateur band in range
        // of 160M to 33cm excluding 60M.  If lax then anything that can
        // be converted from a string to integer will do.

        // OK, this is a nightmare.  Conversion of the string to floating point
        // representation then to integer for Hz value leads to a plethora of FP
        // rounding/imprecision errors.  Feed the routine the string 28076.04 and
        // you get the FP value 28076.0391 which is not good enough.  So.  Since
        // I know the format expected if it's KHz or MHz I must, for better or
        // worse, do a string to FP conversion of my own making.  This will be
        // less than fun.

        // Look for the following characters , . and attempt to determine if
        // I have a single , representing a decimal seperator as in some Euro
        // conventions or a , and a . indicating a thousands demarcation and a
        // decimal demarcation.
        result := 0;
        // The following works, temporary comment out
        resolved := false;
        foo := '';
        // Testing for something like 28,076.1 or 14,076.05 or 1,838.155
        if (ansiContainsText(qrg,',')) and (ansiContainsText(qrg,'.')) Then
        begin
             // This seems to be something like ##,###.##
             // Strip the , and leave the .
             s1 := '';
             for i := 1 to length(qrg) do
             begin
                  if not (qrg[i]=',') then
                  begin
                       s1 := s1+qrg[i];
                  end;
                  foo := s1;
             end;
             // Pesky thousands mark removed
             // Now to attempt a conversion to a pair of integers
             // with one representing the left of . portion (whole) and the
             // second representing the right of . portion (fraction)
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(foo) do
             begin
                  if foo[i] = '.' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+foo[i];
                       end
                       else
                       begin
                            s2 := s2+foo[i];
                       end;
                  end;
             end;
             If not TrystrToInt(s1,i1) then i1 := 0;
             i1 := i1 * 1000;
             If not TrystrToInt(s2,i2) then i2 := 0;
             if length(s2) = 2 then i2 := i2*10;
             if length(s2) = 1 then i2 := i2*100;
             i3 := i1+i2;
             resolved := true;
        end;
        // Testing for something like  28076,1 or 14076,05 or 1838,155 or 28,076 or 14,076 or 1,838
        // This is more complex as I could have a case with , demarking thousands or decimal point. <sigh>
        if not resolved and (ansiContainsText(qrg,',')) and  not (ansiContainsText(qrg,'.')) Then
        begin
             // Lets try to figure out what we have.  First look for , as a decimal mark rather than a thousands mark
             // This works for something like 28076,010 or 1838,1 or 7076,05
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = ',' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             if not trystrToInt(s1,i1) then i1 := 0;
             i1 := i1 * 1000;
             if not trystrToInt(s2,i2) then i2 := 0;
             if length(s2) = 1 then i2 := i2*1;
             if length(s2) = 2 then i2 := i2*10;
             if length(s2) = 1 then i2 := i2*100;
             i3 := i1+i2;
             resolved := true;
        end;
        // Testing for something like  28076,1 or 14076,05 or 1838,155 or 28,076 or 14,076 or 1,838
        // This is more complex as I could have a case with , demarking thousands or decimal point. <sigh>
        if not resolved and (ansiContainsText(qrg,',')) and  not (ansiContainsText(qrg,'.')) Then
        begin
             // Lets try to figure out what we have.  First look for , as a decimal mark rather than a thousands mark
             // This works for something like 1,838 or 28,076 or 14,075 BUT It yields KHz :)
             // Now.. if you pass it something like 14,075151 as in 14 Million 75 thousand 151 Hertz it breaks
             // returning 14000 + 89151 Hz so I need to look a little harder.
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = ',' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             if not trystrToInt(s1,i1) then i1 := 0;
             if not trystrToInt(s2,i2) then i2 := 0;
             // OK... if this is a value such as 14,076 that would be either 14.076 MHz or 14,076 KHz which is the same thing :)
             // If this is a value such as 14,07615 I'd have 14.07615 MHz or 14,07615 KHz which is most certainly not the same thing.
             // It looks like I could test length of S2 and if = 3 then it would seem to be a KHz value.  If > 3 then it's probably
             // a MHz value using , as decimal point.
             resolved := false;
             if length(s2) = 3 then
             begin
                  // Looks like it'll be KHz as in 14,076 or 28,077 or 1,835
                  // s2(i2) will be thousands and s1(i1) millions
                  i1 := i1*1000000;
                  i2 := i2*1000;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=4) then
             begin
                  //14,0761 would likely be 14,076,100 Hz
                  //s1(i1) will be millions as in 14M
                  //s2(will be hundreds) as in 76100 in the example 14,0761
                  i1 := i1*1000000;
                  i2 := i2*100;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=5) then
             begin
                  //14,07615 would likely be 14,076,150 Hz
                  //s1(i1) will be millions as in 14M
                  //s2(i2) will be 10 as in 76150
                  i1 := i1*1000000;
                  i2 := i2*10;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=6) then
             begin
                  //14,076155 would likely be 14,076,155 Hz
                  //s1(i1) will be millions
                  //s2(i2) will be ones as in 76155
                  i1:=i1*1000000;
                  i3:=i1+i2;
                  resolved := true;
             end;
             if not resolved then result := 0;
        end;
        // OK, I've handled the cases of strings like 14,076.150 or 14,076 (like
        // KHz with , as thousands mark) or 14,076515 (like MHz with , as thousands
        // mark)  Now I need to deal with a nice simple 14.076515 or 14076.515
        if not resolved and (ansiContainsText(qrg,'.')) and not (ansiContainsText(qrg,',')) then
        begin
             // Now only dealing with a string having ####.#### with . as decimal point
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = '.' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             // It will most likely be a KHz value if length(s1) >= 4 with s2 being 3 or less
             if length(s1) > 3 then
             begin
                  //s1(i1) will be thousands as in 1838 for 1838000 or 7076 for 7076000
                  //s2(i2) will be 1s 10s or 100s depending upon length length=3 = 1s length = 2 = 10s length = 1 = 100s
                  if not trystrToInt(s1,i1) then i1 := 0;
                  if not trystrToInt(s2,i2) then i2 := 0;
                  i1 := i1*1000;
                  if length(s2)=3 then i2 := i2*1; // Redundant, but necessary for the logic
                  if length(s2)=2 then i2 := i2*10;
                  if length(s2)=1 then i2 := i2*100;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if length(s1) < 4 then
             begin
                  //This will likely be MHz in s1 and fractional MHz in s2
                  // 1.838    Would be 1 million 838 thousand
                  // 1.8381   Would be 1 million 838 thousand 100
                  // 1.83812  Would be 1 million 838 thousand 120
                  // 1.838123 Would be 1 million 838 thousand 123
                  if not trystrToInt(s1,i1) then i1 := 0;
                  if not trystrToInt(s2,i2) then i2 := 0;
                  i1 := i1*1000000;
                  if length(s2)=6 then i2 := i2*1;
                  if length(s2)=5 then i2 := i2*10;
                  if length(s2)=4 then i2 := i2*100;
                  if length(s2)=3 then i2 := i2*1000;
                  if length(s2)=2 then i2 := i2*10000;
                  if length(s2)=1 then i2 := i2*100000;
                  i3 := i2+i1;
                  resolved := true;
             end;
        end;
        // OK, now I've handled everything I can think of except the case of an
        // integer value being passed.  I would hope that if I do get a value
        // that seems to be an integer it will be Hz, but it could be KHz or Mhz
        // and I'll try to resolve that before finishing this.
        if not resolved and not (ansiContainsText(qrg,',')) and not (ansiContainsText(qrg,'.')) Then
        Begin
             // Seems to have an integer so we'll make it simple
             if not trystrToInt(qrg,i3) then i3 := 0;
             resolved := true;
        end;
        // Now... if resolved = true then i3 will hold an integer value.  Lets
        // see if it seems to make sense.
        if resolved then
        begin
             resolved := false;
             // OK... this is either a hertz value or a value in KHz or MHz.
             // If it's KHz then it needs to be 1838 to 460000.  If it's MHz
             // then I need to see 1 to 460.  Realistically I don't expect
             // to ever see MHz here, but, who knows....
             if not resolved and (i3 < 1838) then
             begin
                  // MHz
                  i3 := i3*1000000;
                  resolved := true;
             end;
             if not resolved and (i3 > 1837) and (i3 < 460000) then
             begin
                  // KHz
                  i3 := i3*1000;
                  resolved := true;
             end;
             if not resolved and (i3 > 1799999) then
             begin
                  // Hz
                  i3 := i3*1;  // Silly, but helps me keep my logic straight.
                  resolved := true;
             end;

             if (mode='lax') and resolved then
             begin
                  result := i3;
             end;

             if (mode='strict') and resolved then
             begin
                  // In strict mode QRG must be in the following ranges
                  resolved := false;
                  if (i3 >    1799999) and (i3 <    2000001) then resolved := true;  // 160M
                  if (i3 >    3499999) and (i3 <    4000001) then resolved := true;  //  80M
                  if (i3 >    6999999) and (i3 <    7300001) then resolved := true;  //  40M
                  if (i3 >   10099999) and (i3 <   10150001) then resolved := true;  //  30M
                  if (i3 >   13999999) and (i3 <   14350001) then resolved := true;  //  20M
                  if (i3 >   18067999) and (i3 <   18168001) then resolved := true;  //  17M
                  if (i3 >   20999999) and (i3 <   21450001) then resolved := true;  //  15M
                  if (i3 >   24889999) and (i3 <   24990001) then resolved := true;  //  12M
                  if (i3 >   27999999) and (i3 <   29700001) then resolved := true;  //  10M
                  if (i3 >   49999999) and (i3 <   54000001) then resolved := true;  //   6M
                  if (i3 >  143999999) and (i3 <  148000001) then resolved := true;  //   2M
                  if (i3 >  221999999) and (i3 <  225000001) then resolved := true;  //   1.25M
                  if (i3 >  419999999) and (i3 <  450000001) then resolved := true;  //   70cm
                  if (i3 >  901999999) and (i3 <  928000001) then resolved := true;  //   33cm
                  if (i3 > 1269999999) and (i3 < 1300000001) then resolved := true;  //   23cm
                  if resolved then result := i3;
             end;

             if not resolved then result := 0;
        end
        else
        begin
             result := 0;
        end;
   end;

   procedure TRadio.pollRig();
   var
        foo  : string;
        //foo2 : string;
        //i    : integer;
        //tstf : single;
   begin
        if stControl = 'COMMANDER' Then
        begin
             // Commander returns QRG In KHz with damnable , plus .
             civ1.pollRig();
             foo := trimleft(trimright(civ1.rxqrg));
             stQRG         := testQRG(foo,'lax');
             stRig         := civ1.rigname;
             stPTT         := civ1.txOn;
        end;
        if stControl = 'OMNI' Then
        begin
             omni1.pollRig();
             stRig         := omni1.rig1;
             stQRG         := testQRG(omni1.qrg1,'lax');
             //stPTT         := False;
        end;
        if stControl = 'HRD' Then
        begin
             hrd1.pollRig();
             stQRG         := testQRG(hrd1.rxqrg,'lax');
             stRig         := hrd1.rigname;
             stPTT         := hrd1.pttState;
        end;
        if stControl = 'HAMLIB' Then
        begin
             // Not implemented (yet) do nothing
        end;
        if stControl = 'NONE' Then
        begin
             // Do nothing
             stQRG         := 0;
             stRig         := 'None';
             stPTT         := false;
        end;
   end;

   procedure TRadio.togglePTT();
   Begin
        // Toggles PTT State
        if stControl = 'COMMANDER' Then
        begin
             if stPTT then
             begin
                  civ1.setRig('000receive');
                  stPTT := false;
             end
             else
             begin
                  civ1.setRig('000transmit');
                  stPTT := true;
             end;
        end;

        if stControl = 'HRD' Then
        begin
             if stPTT then
             begin
                  hrd1.togglePTT();
                  stPTT := false;
             end
             else
             begin
                  hrd1.togglePTT();
                  stPTT := true;
             end;
        end;

        if stControl = 'OMNI' Then
        begin
        end;

        if stControl = 'HAMLIB' Then
        begin
             // Not implemented (yet) do nothing
        end;

        if stControl = 'NONE' Then
        begin
             // Do nothing
        end;
   end;

end.

