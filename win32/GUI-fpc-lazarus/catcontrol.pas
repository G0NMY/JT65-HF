unit catControl;
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
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, Process, globalData, dlog, hrdinterface, cfgvtwo, StrUtils;

Const
    hrdDelim = [','];

Type
    omniRec = Record
     r1stat  : String;
     r1model : String;
     r1freqA : String;
     r1freqB : String;
     r1freq  : String;
     r2stat  : String;
     r2model : String;
     r2freqA : String;
     r2freqB : String;
     r2freq  : String;
    end;

  function readOmni(rig : Integer) : Double;  // rig = 1 or 2.
  function readHRD(): Double;
  function readDXLabs(): Double;

implementation

function writeHRD(_para1:WideString): Boolean;
Var
   hrdcontext         : PWIDECHAR;
   hrdradio           : PWIDECHAR;
   hrdresult          : PWIDECHAR;
   hrdmsg             : WideString;
   hrdon              : Boolean;
Begin
     Result := False;
     hrdon := False;
     hrdon := hrdinterface.HRDInterfaceConnect('localhost', 7809);
     if hrdon then
     begin
          hrdradio := '';
          hrdcontext := '';
          hrdresult := '';
          hrdmsg := 'Get Radio';
          hrdradio := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          hrdmsg := 'Get Context';
          hrdcontext := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          hrdresult := hrdinterface.HRDInterfaceSendMessage(_para1);
          if hrdresult='OK' Then Result := True else Result := False;
          hrdinterface.HRDInterfaceFreeString(hrdcontext);
          hrdinterface.HRDInterfaceFreeString(hrdradio);
          hrdinterface.HRDInterfaceFreeString(hrdresult);
          hrdinterface.HRDInterfaceDisconnect();
     end
     else
     begin
          Result := False;
     end;
end;

function readHRD(): Double;
Var
   foo                : WideString;
   qrg                : Double;
   wcount             : Integer;
   hrdcontext         : PWIDECHAR;
   hrdradio           : PWIDECHAR;
   hrdqrg             : PWIDECHAR;
   hrdbuttons         : PWIDECHAR;
   hrddropdowns       : PWIDECHAR;
   hrdsliders         : PWIDECHAR;
   hrdresult          : PWIDECHAR;
   hrdModeList        : PWIDECHAR;
   hrdError           : PWIDECHAR;
   hrdmsg             : WideString;
   hrdon              : Boolean;
Begin
     hrdon := False;
     hrdon := hrdinterface.HRDInterfaceConnect('localhost', 7809);
     if hrdon then
     begin
          hrdradio := '';
          hrdcontext := '';
          hrdqrg := '';
          hrdbuttons := '';
          hrddropdowns := '';
          hrdsliders := '';
          hrdresult := '';
          hrdModeList := '';
          hrdmsg := 'Get Radio';
          hrdradio := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          cfgvtwo.Form6.labelHRDRig.Caption := 'Controlled Rig:  ' + hrdradio;
          hrdmsg := 'Get Context';
          hrdcontext := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          hrdmsg := 'Get Frequency';
          hrdqrg := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          hrdmsg := '[' + hrdcontext + '] get buttons';
          hrdbuttons := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          //cfgvtwo.Form6.labelHRDButtons.Caption := 'Buttons:  ' + hrdbuttons;


          hrdmsg := '[' + hrdcontext + '] get dropdowns';
          hrddropdowns := hrdinterface.HRDInterfaceSendMessage(hrdmsg);

          //wcount := WordCount(hrddropdowns,hrdDelim);
          foo := ExtractWord(1,hrddropdowns,HRDDelim);
          cfgvtwo.Form6.Label17.Caption := Foo;
          foo := ExtractWord(2,hrddropdowns,HRDDelim);
          cfgvtwo.Form6.Label18.Caption := Foo;

          hrdError := '';
          hrdModeList := '';
          hrdmsg := '[' + hrdcontext + '] Get Dropdown-list Mode';
          //hrdmsg := '[' + hrdcontext + '] Get dropdown-list ' + ExtractWord(1,hrddropdowns,HRDDelim);
          hrdModeList := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          //hrdError := hrdinterface.HRDInterfaceGetLastError();
          //cfgvtwo.Form6.labelHRDresult.Caption := hrdError;

          //wcount := WordCount(hrdModeList,hrdDelim);

          cfgvtwo.Form6.labelHRDDropDowns.Caption := 'Modes:  ' + hrdModeList;

          hrdmsg := '[' + hrdcontext + '] get sliders';
          hrdsliders := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          cfgvtwo.Form6.labelHRDSliders.Caption := 'Sliders:  ' + hrdsliders;
          hrdresult := '';
          //hrdmsg := '[' + hrdcontext + '] set dropdown mode usb 1';
          //hrdmsg := '[' + hrdcontext + '] set dropdown mode usb 1';
          //hrdresult := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          hrdmsg := '[' + hrdcontext + '] Get slider-pos ' + hrdradio + ' AF~gain';
          hrdresult := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          //cfgvtwo.Form6.labelHRDresult.Caption := hrdresult;
          foo := ExtractWord(1,hrdresult,HRDDelim);
          cfgvtwo.Form6.sliderAF.Position := StrToInt(foo);
          cfgvtwo.Form6.Label11.Caption := 'Audio Gain (Currently:  ' + IntToStr(cfgvtwo.Form6.sliderAF.Position) + ')';

          hrdmsg := '[' + hrdcontext + '] Get slider-pos ' + hrdradio + ' Mic~gain';
          hrdresult := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          //cfgvtwo.Form6.labelHRDresult.Caption := hrdresult;
          foo := ExtractWord(1,hrdresult,HRDDelim);
          cfgvtwo.Form6.sliderMic.Position := StrToInt(foo);
          cfgvtwo.Form6.Label15.Caption := 'Mic Gain (Currently:  ' + IntToStr(cfgvtwo.Form6.sliderMic.Position) + ')';

          //dlog.fileDebug(hrdradio + ' ' + hrdcontext + ' ' + hrdqrg);
          //hrdmsg := '[' + hrdcontext + '] set frequency-hz 14076000';
          //hrdresult := hrdinterface.HRDInterfaceSendMessage(hrdmsg);
          //hrdmsg := 'Get Frequency';
          //hrdqrg := hrdinterface.HRDInterfaceSendMessage(hrdmsg);

          qrg := 0.0;
          If TryStrToFloat(hrdqrg,qrg) Then
          Begin
               Result := qrg;
               globalData.strqrg := FloatToStr(qrg);
          end
          else
          Begin
               Result := 0.0;
               globalData.strqrg := '0';
          end;
          hrdinterface.HRDInterfaceFreeString(hrdcontext);
          hrdinterface.HRDInterfaceFreeString(hrdradio);
          hrdinterface.HRDInterfaceFreeString(hrdqrg);
          hrdinterface.HRDInterfaceFreeString(hrdbuttons);
          hrdinterface.HRDInterfaceFreeString(hrddropdowns);
          hrdinterface.HRDInterfaceFreeString(hrdsliders);
          hrdinterface.HRDInterfaceFreeString(hrdresult);
          hrdinterface.HRDInterfaceFreeString(hrdModeList);
          hrdinterface.HRDInterfaceDisconnect();
     end
     else
     begin
          Result := 0.0;
     end;
End;

function readDXLabs(): Double;
Var
   catProc : TProcess;
   qrg     : Double;
   inStrs  : TStringList;
Begin
     catProc := TProcess.Create(nil);
     inStrs := TStringList.Create;
     catProc.CommandLine := 'hamlib\rig_dde\commander_dde1';
     catProc.Options := catProc.Options + [poWaitOnExit];
     catProc.Options := catProc.Options + [poNoConsole];
     catProc.Options := catProc.Options + [poUsePipes];
     catProc.Execute;
     inStrs.LoadFromStream(catProc.Output);
     qrg := 0.0;
     If TryStrToFloat(inStrs.Strings[0],qrg) Then
     Begin
          Result := qrg*1000;
          globalData.strqrg := FloatToStr(qrg*1000);
     end
     else
     Begin
          Result := 0.0;
          globalData.strqrg := '0';
     end;
     inStrs.Free;
     catProc.Destroy;
End;

function readOmni(rig : Integer) : Double;
Var
   ostat   : omniRec;
   fQRG    : TextFile;
   catProc : TProcess;
   qrg     : Double;
Begin
     Result := 0.0;
     catProc := TProcess.Create(nil);
     catProc.CommandLine := 'hamlib\omnicontrol';
     catProc.Options := catProc.Options + [poWaitOnExit];
     catProc.Options := catProc.Options + [poNoConsole];
     catProc.Execute;
     If fileExists('omniqrg.txt') Then
     Begin
          assignFile(fQRG,'omniqrg.txt');
          reset(fQRG);
          readLn(fQRG,ostat.r1stat);
          readLn(fQRG,ostat.r1model);
          readLn(fQRG,ostat.r1freqA);
          readLn(fQRG,ostat.r1freqB);
          readLn(fQRG,ostat.r1freq);
          readLn(fQRG,ostat.r2stat);
          readLn(fQRG,ostat.r2model);
          readLn(fQRG,ostat.r2freqA);
          readLn(fQRG,ostat.r2freqB);
          readLn(fQRG,ostat.r2freq);
          closeFile(fQRG);
          if FileExists('omniqrg.txt') Then DeleteFile('omniqrg.txt');
          qrg := 0.0;
          If (rig=1) And (ostat.r1stat='1-Online') Then
          Begin
               If TryStrToFloat(ostat.r1freq, qrg) Then
               Begin
                    Result := qrg;
                    globalData.strqrg := FloatToStr(qrg);
               end
               else
               Begin
                    dlog.FileDebug('EConvert: ostat.r1freq = ' + ostat.r1freq);
                    globalData.strqrg := '0';
                    Result := 0.0;
               End;
          End;

          If (rig=2) And (ostat.r2stat='2-Online') Then
          Begin
               If TryStrToFloat(ostat.r2freq, qrg) Then
               Begin
                    Result := qrg;
                    globalData.strqrg := FloatToStr(qrg);
               end
               else
               Begin
                    dlog.FileDebug('EConvert: ostat.r2freq = ' + ostat.r1freq);
                    globalData.strqrg := '0';
                    Result := 0.0;
               End;
          End;
     End
     Else
     Begin
          dlog.FileDebug('Did not find omniqrg.txt');
          globalData.strqrg := '0';
          Result := 0.0;
     End;
     catProc.Destroy;
End;
end.

