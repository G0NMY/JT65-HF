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
unit hrdobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, hrdinterface5, StrUtils;

Const
    hrdDelim = [','];

Type
  THrdRig = Class
   private
      prRXQRG     : string;
      prTXQRG     : string;
      prMode      : string;
      prRigType   : string;
      prRigName   : string;
      prRigOnline : Boolean;
      prPTT       : Boolean;
      prState     : string;

      prhasAFGain         : Boolean;
      prhasRFGain         : Boolean;
      prhasMicGain        : Boolean;
      prhasPAGain         : Boolean;
      prhasTX             : Boolean;
      prhasSMeter         : Boolean;
      prhasAutoTune       : Boolean;
      prhasAutoTuneDo     : Boolean;
      prhrdAlive          : Boolean;
      prafgControl        : WideString;
      prrfgControl        : WideString;
      prmicgControl       : WideString;
      prpagControl        : WideString;
      prtxControl         : WideString;
      prsmeterControl     : WideString;
      prautotuneControl   : WideString;
      prautotuneControlDo : WideString;
      prradioName         : WideString;
      prradioContext      : WideString;
      prhrdAddress        : WideString;
      prhrdPort           : Word;
      prafgMin            : Integer;
      prafgMax            : Integer;
      prrfgMin            : Integer;
      prrfgMax            : Integer;
      prmicgMin           : Integer;
      prmicgMax           : Integer;
      prpagMin            : Integer;
      prpagMax            : Integer;

      procedure hrdrigCAPS();
      procedure readHRDQRG();
      function  readHRD(_para1:WideString): WideString;
      function  hrdConnected(): Boolean;
      procedure hrdDisconnect();
      function  writeHRD(_para1:WideString): Boolean;
      procedure hrdRaisePTT();
      procedure hrdLowerPTT();

   public
      Constructor create();

      // Call this to populate the variables
      procedure pollRig();
      // Call this to write properties to rig
      procedure setRig();
      // Toggle PTT State
      procedure PTT(state : Boolean);
      // Set QRG
      procedure setQRG(qrg : Integer);

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
      property pttState : Boolean
         read  prPTT;
end;

implementation

constructor THrdRig.Create();
begin
     prRXQRG      := '';
     prTXQRG      := '';
     prMode       := '';
     prRigType    := '';
     prRigName    := '';
     prState      := '';
     prRigOnline  := false;
     prPTT        := false;
     prhrdAlive        := False;
     prhasAFGain       := False;
     prhasRFGain       := False;
     prhasMicGain      := False;
     prhasPAGain       := False;
     prhasTX           := False;
     prhasSMeter       := False;
     prhasAutoTune     := False;
     prhasAutoTuneDo   := False;
     prafgControl      := '';
     prrfgControl      := '';
     prmicgControl     := '';
     prpagControl      := '';
     prtxControl       := '';
     prsmeterControl   := '';
     prautotuneControl := '';
     prradioName       := '';
     prradioContext    := '';
     prhrdAddress      := 'localhost';
     prhrdPort         := 7809;
end;

function THrdRig.hrdConnected(): Boolean;
begin
     result := False;
     if hrdinterface5.HRDInterfaceIsConnected() Then result := True else result := False;
end;

procedure THrdRig.hrdDisconnect();
begin
     hrdinterface5.HRDInterfaceDisconnect();
end;

function THrdRig.writeHRD(_para1:WideString): Boolean;
Var
   hrdresult          : PWIDECHAR;
   hrdon              : Boolean;
Begin
     Result := False;
     hrdon := False;
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdRigCAPS();
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if hrdon then
     begin
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(_para1);
          if hrdresult='OK' Then Result := True else Result := False;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
     end
     else
     begin
          Result := False;
     end;
end;

procedure THrdRig.hrdRaisePTT();
var
   hrdon : Boolean;
begin
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdRigCAPS();
     if prhrdAlive Then
     Begin
          prptt := writeHRD('[' + prradioContext + '] set button-select ' + prtxControl + ' 1');
     end;
end;

procedure THrdRig.hrdLowerPTT();
var
   hrdon : Boolean;
begin
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdRigCAPS();
     if prhrdAlive Then
     Begin
          if writeHRD('[' + prradioContext + '] set button-select ' + prtxControl + ' 0') then prptt := False;
     end;
end;


procedure THrdRig.hrdrigCAPS();
Var
   foo                : WideString;
   ifoo               : Integer;
   wcount             : Integer;
   hrdresult          : PWIDECHAR;
   hrdmsg             : WideString;
   hrdon              : Boolean;
Begin
     hrdon             := False;
     prhrdAlive        := False;
     prhasAFGain       := False;
     prhasRFGain       := False;
     prhasMicGain      := False;
     prhasPAGain       := False;
     prhasTX           := False;
     prhasSMeter       := False;
     prhasAutoTune     := False;
     prhasAutoTuneDo   := False;
     prafgControl      := '';
     prrfgControl      := '';
     prmicgControl     := '';
     prpagControl      := '';
     prtxControl       := '';
     prsmeterControl   := '';
     prautotuneControl := '';
     prradioName       := '';
     prradioContext    := '';
     // Using HRD Version 5 support.
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdon := hrdinterface5.HRDInterfaceConnect(prhrdAddress, prhrdPort);
     if hrdon then
     begin
          prhrdAlive := True;
          hrdresult := '';
          hrdmsg := 'Get Radio';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          prradioName := hrdresult;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
          hrdmsg := 'Get Context';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          prradioContext := hrdresult;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
          // This retrieves the buttons available of interest
          hrdmsg := '[' + prradioContext + '] get buttons';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          wcount := WordCount(hrdresult,hrdDelim);
          if wcount > 0 Then
          Begin
               for ifoo := 1 to wcount do
               begin
                    foo := ExtractWord(ifoo,hrdresult,hrdDelim);
                    if foo = 'TX'   then prhasTX := True;
                    if foo = 'ATU'  then prhasAutoTune := True;
                    if foo = 'TUNE' then prhasAutoTuneDo := True;
               end;
          end
          else
          begin
               prhasTX := False;
               prhasAutoTune := False;
               prhasAutoTuneDo := False;
          end;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
          if prhasTX then prtxControl := 'TX' else prtxControl := '';
          if prhasAutoTune then prautotuneControl := 'ATU' else prautotuneControl := '';
          if prhasAutoTune then prautotuneControlDo := 'Tune' else prautotuneControlDo := '';
          // This retrieves the sliders available of interest
          hrdmsg := '[' + prradioContext + '] get sliders';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          wcount := WordCount(hrdresult,hrdDelim);
          if wcount > 0 Then
          Begin
               for ifoo := 1 to wcount do
               begin
                    foo := ExtractWord(ifoo,hrdresult,hrdDelim);
                    if foo = 'AF gain (main)' then
                    Begin
                         prhasAFGain := True;
                         prafgControl := 'AF~gain~(main)';
                    end;
                    if foo = 'AF gain' then
                    Begin
                         prhasAFGain := True;
                         prafgControl := 'AF~gain';
                    end;
                    if foo = 'RF gain' then
                    Begin
                         prhasRFGain := True;
                         prrfgControl := 'RF~gain';
                    end;
                    if foo = 'Mic gain' then
                    Begin
                         prhasMicGain := True;
                         prmicgControl := 'Mic~gain';
                    end;
                    if foo = 'RF power' then
                    Begin
                         prhasPAGain := True;
                         prpagControl := 'RF~power';
                    end;
               end;
          end
          else
          begin
               prhasAFGain       := False;
               prhasRFGain       := False;
               prhasMicGain      := False;
               prhasPAGain       := False;
               prafgControl      := '';
               prrfgControl      := '';
               prmicgControl     := '';
               prpagControl      := '';
          end;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
          prhasSMeter       := True;
          prsmeterControl   := 'SMeter-Main';
          // Get meter element min/max values.
          if prhasAFGain Then
          Begin
               //Get slider-range AF
               hrdmsg := '[' + prradioContext + '] get slider-range ' + prradioName + ' ' + prafgControl;
               hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
               wcount := WordCount(hrdresult,hrdDelim);
               if wcount > 0 Then
               Begin
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(1,hrdresult,hrdDelim), ifoo) Then prafgMin := ifoo;
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(2,hrdresult,hrdDelim), ifoo) Then prafgMax := ifoo;
                    ifoo := -1;
               end
               else
               begin
                    prafgMin := 0;
                    prafgMax := 0;
               end;
               hrdinterface5.HRDInterfaceFreeString(hrdresult);
          end;
          if prhasRFGain Then
          Begin
               //Get slider-range RF
               hrdmsg := '[' + prradioContext + '] get slider-range ' + prradioName + ' ' + prrfgControl;
               hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
               wcount := WordCount(hrdresult,hrdDelim);
               if wcount > 0 Then
               Begin
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(1,hrdresult,hrdDelim), ifoo) Then prrfgMin := ifoo;
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(2,hrdresult,hrdDelim), ifoo) Then prrfgMax := ifoo;
                    ifoo := -1;
               end
               else
               begin
                    prrfgMin := 0;
                    prrfgMax := 0;
               end;
               hrdinterface5.HRDInterfaceFreeString(hrdresult);
          end;
          if prhasMicGain Then
          Begin
               //Get slider-range Mic
               hrdmsg := '[' + prradioContext + '] get slider-range ' + prradioName + ' ' + prmicgControl;
               hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
               wcount := WordCount(hrdresult,hrdDelim);
               if wcount > 0 Then
               Begin
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(1,hrdresult,hrdDelim), ifoo) Then prmicgMin := ifoo;
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(2,hrdresult,hrdDelim), ifoo) Then prmicgMax := ifoo;
                    ifoo := -1;
               end
               else
               begin
                    prmicgMin := 0;
                    prmicgMax := 0;
               end;
               hrdinterface5.HRDInterfaceFreeString(hrdresult);
          end;
          if prhasPAGain Then
          Begin
               //Get slider-range PA
               hrdmsg := '[' + prradioContext + '] get slider-range ' + prradioName + ' ' + prpagControl;
               hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
               wcount := WordCount(hrdresult,hrdDelim);
               if wcount > 0 Then
               Begin
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(1,hrdresult,hrdDelim), ifoo) Then prpagMin := ifoo;
                    ifoo := -1;
                    If TryStrToInt(ExtractWord(2,hrdresult,hrdDelim), ifoo) Then prpagMax := ifoo;
                    ifoo := -1;
               end
               else
               begin
                    prpagMin := 0;
                    prpagMax := 0;
               end;
               hrdinterface5.HRDInterfaceFreeString(hrdresult);
          end;
          hrdresult := '';
          hrdmsg := 'Get Frequency';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          prRXQRG := hrdresult;
          prTXQRG := hrdresult;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
     end
     else
     begin
          prhrdAlive        := False;
          prhasAFGain       := False;
          prhasRFGain       := False;
          prhasMicGain      := False;
          prhasPAGain       := False;
          prhasTX           := False;
          prhasSMeter       := False;
          prhasAutoTune     := False;
          prhasAutoTuneDo   := False;
          prafgControl      := '';
          prrfgControl      := '';
          prmicgControl     := '';
          prpagControl      := '';
          prtxControl       := '';
          prsmeterControl   := '';
          prautotuneControl := '';
          prradioName       := '';
          prradioContext    := '';
     end;
end;

procedure THrdRig.readHRDQRG();
Var
   qrg                : Double;
   hrdresult          : PWIDECHAR;
   hrdmsg             : WideString;
   hrdon              : Boolean;
Begin
     hrdon := False;
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdRigCAPS();
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if hrdon then
     begin
          hrdresult := '';
          hrdmsg := 'Get Frequency';
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(hrdmsg);
          prRXQRG := hrdresult;
          prTXQRG := hrdresult;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
     end
     else
     begin
          prRXQRG := '0';
          prTXQRG := '0';
     end;
End;

function THrdRig.readHRD(_para1:WideString): WideString;
Var
   hrdresult          : PWIDECHAR;
   hrdon              : Boolean;
   foo                : WideString;
Begin
     hrdon := False;
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if not hrdon then hrdRigCAPS();
     hrdon := hrdinterface5.HRDInterfaceIsConnected();
     if hrdon then
     begin
          hrdresult := hrdinterface5.HRDInterfaceSendMessage(_para1);
          foo := hrdresult;
          hrdinterface5.HRDInterfaceFreeString(hrdresult);
          result := foo;
     end
     else
     begin
          Result := 'NAK';
     end;
End;

procedure THrdRig.pollRig();
begin
     hrdRigCaps();
end;

procedure THrdRig.setRig();
begin
end;

procedure THrdRig.setQRG(qrg : Integer);
begin
     if writeHRD('[' + prradioContext + '] set frequency-hz ' + intToStr(qrg)) Then
     Begin
          prRXQRG := intToStr(qrg);
          prTXQRG := intToStr(qrg);
     end;
end;

procedure THrdRig.PTT(state : Boolean);
begin
     if state then hrdRaisePTT() else hrdLowerPTT();
end;

end.
