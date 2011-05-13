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
unit maincode;
{$PACKRECORDS C}    (* GCC/Visual C/C++ compatible record packing *)
{$MODE DELPHI }

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, CTypes, StrUtils, Math, ExtCtrls, ComCtrls, Spin,
  Windows, DateUtils, encode65, globalData, XMLPropStorage,
  ClipBrd, dlog, rawdec, guiConfig, verHolder,
  PSKReporter, Menus, rbc, log, diagout, synautil,
  waterfall, d65, spectrum, about, fileutil, cfgobject, guidedconfig, rigobject;//,valobject;

//Const
//  JT_DLL = 'jt65.dll';

type
  { TForm1 }

  TForm1 = class(TForm)
    btnHaltTx: TButton;
    btnEngageTx: TButton;
    btnDefaults: TButton;
    btnZeroRX: TButton;
    btnZeroTX: TButton;
    btnLogQSO: TButton;
    btnReDecode: TButton;
    buttonClearList: TButton;
    buttonEndQSO2: TButton;
    buttonAckReport2: TButton;
    buttonCQ: TButton;
    buttonAnswerCQ: TButton;
    buttonSendReport: TButton;
    buttonAckReport1: TButton;
    cbEnPSKR: TCheckBox;
    cbEnRB: TCheckBox;
    cbSpecPal: TComboBox;
    cbSmooth: TCheckBox;
    chkAFC: TCheckBox;
    chkAutoTxDF: TCheckBox;
    chkEnTX: TCheckBox;
    chkMultiDecode: TCheckBox;
    chkNB: TCheckBox;
    edFreeText: TEdit;
    Edit2: TEdit;
    editManQRG: TEdit;
    edSigRep: TEdit;
    edMsg: TEdit;
    edHisCall: TEdit;
    edHisGrid: TEdit;
    GroupBox1: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18 : TLabel ;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label5 : TLabel ;
    Label50: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label21: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    MenuItem3: TMenuItem;
    menuHeard: TMenuItem;
    menuSetup: TMenuItem;
    menuRawDecoder: TMenuItem;
    menuRigControl: TMenuItem;
    menuTXLog: TMenuItem;
    menuAbout: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    PaintBox1: TPaintBox;
    pbAU1: TProgressBar;
    pbAu2: TProgressBar;
    popupMsgs: TPopupMenu;
    popupQRG: TPopupMenu;
    ProgressBar3: TProgressBar;
    rbFreeMsg: TRadioButton;
    rbGenMsg: TRadioButton;
    RadioGroup1: TRadioGroup;
    rbTX1: TRadioButton;
    rbTX2: TRadioButton;
    rbUseLeft: TRadioButton;
    rbUseRight: TRadioButton;
    spinDecoderBW: TSpinEdit;
    spinDecoderCF: TSpinEdit;
    SpinEdit1: TSpinEdit;
    spinGain: TSpinEdit;
    spinTXCF: TSpinEdit;
    Timer1: TTimer;
    cfg: TXMLPropStorage;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    Waterfall : TWaterfallControl;
    tbBright: TTrackBar;
    tbContrast: TTrackBar;
    procedure btnDefaultsClick(Sender: TObject);
    procedure btnEngageTxClick(Sender: TObject);
    procedure btnHaltTxClick(Sender: TObject);
    procedure btnRawDecoderClick(Sender: TObject);
    procedure btnZeroRXClick(Sender: TObject);
    procedure btnZeroTXClick(Sender: TObject);
    procedure btnLogQSOClick(Sender: TObject);
    procedure btnReDecodeClick(Sender: TObject);
    procedure buttonClearListClick(Sender: TObject);
    procedure buttonAckReport1Click(Sender: TObject);
    procedure buttonAckReport2Click(Sender: TObject);
    procedure buttonAnswerCQClick(Sender: TObject);
    procedure buttonCQClick(Sender: TObject);
    procedure buttonEndQSO1Click(Sender: TObject);
    procedure buttonSendReportClick(Sender: TObject);
    procedure buttonSetupClick(Sender: TObject);
    procedure cbEnPSKRClick(Sender: TObject);
    procedure cbEnRBChange(Sender: TObject);
    procedure cbSmoothChange(Sender: TObject);
    procedure chkAFCChange(Sender: TObject);
    procedure chkAutoTxDFChange(Sender: TObject);
    procedure chkMultiDecodeChange(Sender: TObject);
    procedure chkNBChange(Sender: TObject);
    procedure cbSpecPalChange(Sender: TObject);
    procedure edFreeTextDblClick(Sender: TObject);
    procedure edHisCallDblClick(Sender: TObject);
    procedure edHisGridDblClick(Sender: TObject);
    procedure editManQRGChange(Sender: TObject);
    procedure edMsgDblClick(Sender: TObject);
    procedure edSigRepDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Label17DblClick(Sender: TObject);
    procedure Label19DblClick(Sender: TObject);
    procedure Label22DblClick(Sender: TObject);
    procedure Label30DblClick(Sender: TObject);
    procedure Label31DblClick(Sender: TObject);
    procedure Label39Click(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure menuHeardClick(Sender: TObject);
    procedure MenuItemHandler(Sender: TObject);
    procedure menuRawDecoderClick(Sender: TObject);
    procedure menuRigControlClick(Sender: TObject);
    procedure menuSetupClick(Sender: TObject);
    procedure menuTXLogClick(Sender: TObject);
    procedure rbFreeMsgChange(Sender: TObject);
    procedure spinDecoderBWChange(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure spinGainChange(Sender: TObject);
    procedure spinTXCFChange(Sender: TObject);
    procedure tbBrightChange(Sender: TObject);
    procedure tbContrastChange(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure rbFirstChange(Sender: TObject);
    procedure rbUseMixChange(Sender: TObject);
    procedure spinDecoderCFChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure addToDisplay(i, m : Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure updateAudio();
    procedure updateStatus(i : Integer);
    procedure DisableFloatingPointExceptions();
    procedure initializerCode();
    procedure audioChange();
    procedure processOngoing();
    procedure initDecode();
    procedure updateSR();
    procedure genTX1();
    procedure genTX2();
    procedure rbThreadCheck();
    procedure myCallCheck();
    procedure txControls();
    procedure processNewMinute(st : TSystemTime);
    procedure processOncePerSecond(st : TSystemTime);
    procedure oncePerTick();
    procedure displayAudio(audioAveL : Integer; audioAveR : Integer);
    function getPTTMethod() : String;
    function BuildRemoteString (call, mode, freq, date, time : String) : WideString;
    function BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
    function BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
    function isSigRep(rep : String) : Boolean;
    function valCallsign(callsign : String) : Integer;
    function utcTime() : TSYSTEMTIME;
    procedure addToRBC(i, m : Integer);
    procedure rbcCheck();
    procedure updateList(callsign : String);
    procedure WaterfallMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure addToDisplayTX(exchange : String);
    procedure saveCSV();
    function valConfig() : boolean;

  private
    { private declarations }
  public
    { public declarations }
  end;
   
  Type
    decodeThread = class(TThread)
      protected
        procedure Execute; override;
      public
        Constructor Create(CreateSuspended : boolean);
    end;

    rbcThread = class(TThread)
      protected
            procedure Execute; override;
      public
            Constructor Create(CreateSuspended : boolean);
    end;

    catThread = class(TThread)
      protected
        procedure Execute; override;
      public
        Constructor Create(CreateSuspended : boolean);
    end;

    rbHeard = record
       callsign : String;
       count    : Integer;
    end;

  var
     Form1                      : TForm1;
     auOddBuffer, auEvenBuffer  : Packed Array[0..661503] of CTypes.cint16;
     //paInParams, paOutParams    : TPaStreamParameters;
     //ppaInParams, ppaOutParams  : PPaStreamParameters;
     //paResult                   : TPaError;
     alreadyHere                : Boolean;
     mnlooper, ij               : Integer;
     decoderThread              : decodeThread;
     rigThread                  : catThread;
     rbThread                   : rbcThread;
     rbcPing, dorbReport        : Boolean;
     rbcCache, primed           : Boolean;
     txNextPeriod               : Boolean;
     statusChange               : Boolean;
     runOnce                    : Boolean;
     lastSecond                 : Word;
     txPeriod                   : Integer;
     thisMinute                 : Word;
     thisSecond                 : Word;
     lastMinute                 : Word;
     nextMinute                 : Word;
     lastAction                 : Integer;  // 1=Init, 2=RX, 3=TX, 4=Decoding, 5=Idle
     thisAction                 : Integer;
     nextAction                 : Integer;
     sLevel1, sLevel2, sLevelM  : Integer;
     smeterIdx                  : Integer;
     txCount                    : Integer;
     bStart, bEnd, rxCount      : Integer;
     exchange                   : String;
     TxDirty, TxValid           : Boolean;
     answeringCQ                : Boolean;
     msgToSend                  : String;
     siglevel                   : String;
     dErrLErate, dErrAErate     : Double;
     dErrError, adError         : Double;
     adLErate, adAErate         : Double;
     dErrCount, adCount         : Integer;
     mnnport                    : String;
     mnpttOpened, itemsIn       : Boolean;
     firstReport                : Boolean;
     //paInStream, paOutStream    : PPaStream;
     lastMsg, curMsg            : String;
     gst, ost                   : TSYSTEMTIME;
     thisTX, lastTX             : String;
     watchMulti, doCAT          : Boolean;
     haveRXSRerr, haveTXSRerr   : Boolean;
     rxsrs, txsrs, lastSRerr    : String;
     preTXCF, preRXCF           : Integer;
     pskrStats                  : PSKReporter.REPORTER_STATISTICS;
     audioAve1, audioAve2       : Integer;
     sopQRG, eopQRG             : Double;
     doRB                       : Boolean;
     rbsHeardList               : Array[0..499] Of rbHeard;
     csvEntries                 : Array[0..99] of String;
     qsoSTime, qsoETime         : String;
     qsoSDate                   : String;
     resyncLoop, haveOddBuffer  : Boolean;
     d65doDecodePass            : Boolean;
     d4doDecodePass             : Boolean;
     catInProgress              : Boolean;
     rxInProgress, doCWID       : Boolean;
     useBuffer                  : Integer;
     pskrstat                   : Integer;
     rbRunOnce                  : Boolean;
     d65samfacout               : CTypes.cdouble;
     d65nwave, d65nmsg          : CTypes.cint;
     d65sendingsh               : CTypes.cint;
     d65txmsg                   : PChar;
     cwidMsg                    : PChar;
     d65sending                 : PChar;
     cfgerror, cfgRecover       : Boolean;
     mnHavePrefix, mnHaveSuffix : Boolean;
     txmode                     : Integer;
     reDecode, haveEvenBuffer   : Boolean;
     actionSet                  : Boolean;
     config1, config2           : cfgobject.TConfiguration;
     rig1                       : rigobject.TRadio;
implementation

{ TForm1 }
constructor decodeThread.Create(CreateSuspended : boolean);
begin
     FreeOnTerminate := True;
     inherited Create(CreateSuspended);
end;

constructor catThread.Create(CreateSuspended : boolean);
begin
     FreeOnTerminate := True;
     inherited Create(CreateSuspended);
end;

constructor rbcThread.Create(CreateSuspended : boolean);
begin
     FreeOnTerminate := True;
     inherited Create(CreateSuspended);
end;

procedure TForm1.DisableFloatingPointExceptions();
begin
  // This routine was borrowed from ultrastar deluxe, a game written in delphi/
  // free pascal and is GPL V2 code.  In the case of this routine it's copyright
  // belongs to its creator.  Routine defined in UCommon.pas in the ultrastar
  // source tree.
  (*
  // We will use SetExceptionMask() instead of Set8087CW()/SetSSECSR().
  // Note: Leave these lines for documentation purposes just in case
  //       SetExceptionMask() does not work anymore (due to bugs in FPC etc.).
  {$IF Defined(CPU386) or Defined(CPUI386) or Defined(CPUX86_64)}
  Set8087CW($133F);
  {$IFEND}
  {$IF Defined(FPC)}
  if (has_sse_support) then
    SetSSECSR($1F80);
  {$IFEND}
  *)

  // disable all of the six FPEs (x87 and SSE) to be compatible with C/C++ and
  // other libs which rely on the standard FPU behaviour (no div-by-zero FPE anymore).
  SetExceptionMask([exInvalidOp, exDenormalized, exZeroDivide,
                    exOverflow, exUnderflow, exPrecision]);
end;

procedure ver(vint : Pointer; vstr : Pointer); cdecl; external JT_DLL name 'version_';

function nchar(c : char) : integer;
begin
     result := -1;
     case c of
           '0' : Result := 0;
           '1' : Result := 1;
           '2' : Result := 2;
           '3' : Result := 3;
           '4' : Result := 4;
           '5' : Result := 5;
           '6' : Result := 6;
           '7' : Result := 7;
           '8' : Result := 8;
           '9' : Result := 9;
           'A' : Result := 10;
           'B' : Result := 11;
           'C' : Result := 12;
           'D' : Result := 13;
           'E' : Result := 14;
           'F' : Result := 15;
           'G' : Result := 16;
           'H' : Result := 17;
           'I' : Result := 18;
           'J' : Result := 19;
           'K' : Result := 20;
           'L' : Result := 21;
           'M' : Result := 22;
           'N' : Result := 23;
           'O' : Result := 24;
           'P' : Result := 25;
           'Q' : Result := 26;
           'R' : Result := 27;
           'S' : Result := 28;
           'T' : Result := 29;
           'U' : Result := 30;
           'V' : Result := 31;
           'W' : Result := 32;
           'X' : Result := 33;
           'Y' : Result := 34;
           'Z' : Result := 35;
           ' ' : Result := 36;
     end;
end;

function isAlphaNumericSpace(c : char) : Integer;
begin
     result := 0;
     case c of 'A'..'Z','0'..'9',' ' : result := 1; end;
end;

function isAlphaNumeric(c : char) : Integer;
begin
     result := 0;
     case c of 'A'..'Z','0'..'9' : result := 1; end;
end;

function isNumeric(c : char) : Integer;
begin
     result := 0;
     case c of '0'..'9' : result := 1; end;
end;

function isAlphaSpace(c : char) : Integer;
begin
     result := 0;
     case c of 'A'..'Z',' ' : result := 1; end;
end;

function TForm1.valCallsign(callsign : String) : Integer;
var
   foo, foo2   : String;
   ncall, nfoo : Integer;
   c2, c3      : Boolean;
begin
     result := -1;
     foo := Trimleft(Trimright(callsign));
     foo := upcase(foo);
     // Basic length checks
     if length(foo) > 6 then result := -1;
     if length(foo) < 3 then result := -1;
     if (length(foo) > 2) and (length(foo) < 7) then
     begin
          c2 := false;
          c3 := false;
          case foo[3] of '0'..'9': c3 := True else c3 := False; end;
          if not c3 then
          begin
               case foo[2] of '0'..'9': c2 := True else c2 := False; end;
          end;
          if c2 or c3 then
          begin
               if c3 then
               begin
                    // If c3 then padright to 6 characters
                    foo := padright(foo,6);
                    nfoo := 0;
                    nfoo := nfoo + isAlphaNumericSpace(foo[1]);
                    nfoo := nfoo + isAlphaNumeric(foo[2]);
                    nfoo := nfoo + isNumeric(foo[3]);
                    nfoo := nfoo + isAlphaSpace(foo[4]);
                    nfoo := nfoo + isAlphaSpace(foo[5]);
                    nfoo := nfoo + isAlphaSpace(foo[6]);
                    if nfoo = 6 then
                    begin
                         ncall := 0;
                         ncall := nchar(foo[1]);
                         ncall := 36*ncall+nchar(foo[2]);
                         ncall := 10*ncall+nchar(foo[3]);
                         ncall := 27*ncall+nchar(foo[4])-10;
                         ncall := 27*ncall+nchar(foo[5])-10;
                         ncall := 27*ncall+nchar(foo[6])-10;
                         result := ncall;
                    end
                    else
                    begin
                         result := -1;
                    end;
               end;
               if c2 then
               begin
                    // Need to insert a space to left then pad right to 6
                    // According to JT65 rules a callsign with a numeral as 2nd character can not
                    // be over 5 characters in length...
                    if length(foo) < 6 then
                    begin
                         // pad righ to 6
                         foo := padright(foo,6);
                         foo2 := '      ';
                         // Shift characters right by 1 character
                         foo2[1] := ' ';
                         foo2[2] := foo[1];
                         foo2[3] := foo[2];
                         foo2[4] := foo[3];
                         foo2[5] := foo[4];
                         foo2[6] := foo[5];
                         nfoo := 0;
                         nfoo := nfoo + isAlphaNumericSpace(foo2[1]);
                         nfoo := nfoo + isAlphaNumeric(foo2[2]);
                         nfoo := nfoo + isNumeric(foo2[3]);
                         nfoo := nfoo + isAlphaSpace(foo2[4]);
                         nfoo := nfoo + isAlphaSpace(foo2[5]);
                         nfoo := nfoo + isAlphaSpace(foo2[6]);
                         if nfoo = 6 then
                         begin
                              ncall := 0;
                              ncall := nchar(foo2[1]);
                              ncall := 36*ncall+nchar(foo2[2]);
                              ncall := 10*ncall+nchar(foo2[3]);
                              ncall := 27*ncall+nchar(foo2[4])-10;
                              ncall := 27*ncall+nchar(foo2[5])-10;
                              ncall := 27*ncall+nchar(foo2[6])-10;
                              result := ncall;
                         end
                         else
                         begin
                              result := -1;
                         end;
                    end
                    else
                    begin
                         result := -1;
                    end;
               end;
          end
          else
          begin
               result := -1;
          end;
     end
     else
     begin
          result := -1;
     end;
end;

function TForm1.utcTime(): TSYSTEMTIME;
Var
   st : TSYSTEMTIME;
Begin
     st.Hour:=0;
     GetSystemTime(st);
     result := st;
End;

function TForm1.getPTTMethod() : String;
Begin
     result := '';
     //if cfgvtwo.Form6.cbUseAltPTT.Checked Then result := 'ALT' else result := 'PTT';
     //if cfgvtwo.Form6.cbSi570PTT.Checked Then result := 'SI5';
     //if cfgvtwo.Form6.chkHRDPTT.Checked And cfgvtwo.Form6.chkUseHRD.Checked Then result := 'HRD';
end;

function TForm1.BuildRemoteString (call, mode, freq, date, time : String) : WideString;
begin
     If freq='0' Then
        result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0
     else
        result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'freq' + #0 + freq + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0;
end;

function TForm1.BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
begin
     If freq='0' Then
        result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'grid' + #0 + grid + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0
     else
        result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'freq' + #0 + freq + #0 + 'grid' + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0;
end;

function TForm1.BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
begin
     result := 'station_callsign' + #0 + station_callsign + #0 + 'my_gridsquare' + #0 + my_gridsquare + #0 +
               'programid' + #0 + programid + #0 +
               'programversion' + #0 + programversion + #0 +
               'my_antenna' + #0 + my_antenna + #0 + #0;
end;

procedure rbcThread.Execute;
begin
     //while not Terminated and not Suspended and not rbc.glrbActive do
     //begin
     //     Try
     //        if globalData.rbCacheOnly Then
     //        Begin
     //             // rbCacheOnly is set, but, should it be?
     //             //if not cfgvtwo.Form6.cbNoInet.Checked And cfgvtwo.Form6.cbUseRB.Checked Then globalData.rbCacheOnly := False;
     //             //if cfgvtwo.Form6.cbNoInet.Checked And cfgvtwo.Form6.cbUseRB.Checked Then globalData.rbCacheOnly := True;
     //        End;
          //   if Length(TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text)))>0 Then
          //   Begin
          //        If (dorbReport) And (not rbc.glrbActive) Then
          //        Begin
          //             rbc.glrbCallsign := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
          //             rbc.glrbGrid := TrimLeft(TrimRight(cfgvtwo.Form6.edMyGrid.Text));
          //             rbc.glrbQRG := Form1.editManQRG.Text;
          //             rbc.glrbActive := True;
          //             rbc.processRB();
          //             dorbReport := False;
          //        end;
          //        if (cfgvtwo.glrbcLogin) And (not rbc.glrbActive) Then
          //        Begin
          //             rbc.glrbCallsign := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
          //             rbc.glrbQRG := Form1.editManQRG.Text;
          //             rbc.glrbGrid := TrimLeft(TrimRight(cfgvtwo.Form6.edMyGrid.Text));
          //             rbc.glrbActive := True;
          //             rbc.doLogin();
          //             cfgvtwo.glrbcLogin := False;
          //        End;
          //        if (cfgvtwo.glrbcLogout) And (not rbc.glrbActive) Then
          //        Begin
          //             rbc.glrbCallsign := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
          //             rbc.glrbQRG := Form1.editManQRG.Text;
          //             rbc.glrbGrid := TrimLeft(TrimRight(cfgvtwo.Form6.edMyGrid.Text));
          //             rbc.glrbActive := True;
          //             rbc.doLogout();
          //             cfgvtwo.glrbcLogout := False;
          //        End;
          //        if (rbcPing) And (not rbc.glrbActive) Then
          //        Begin
          //             rbc.glrbCallsign := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
          //             rbc.glrbQRG := Form1.editManQRG.Text;
          //             rbc.glrbGrid := TrimLeft(TrimRight(cfgvtwo.Form6.edMyGrid.Text));
          //             rbc.glrbActive := True;
          //             rbc.doLogin();
          //             rbcPing := False;
          //        End;
          //        if (rbcCache) And (not rbc.glrbActive) Then
          //        Begin
          //             // TODO Reinstate following once cache uploader is verified.
          //             //rbc.sendCached();
          //             rbcCache := False;
          //        End;
          //   End;
          //Except
          //   dlog.fileDebug('Notice:  Exception in rbc thread');
          //end;
          Sleep(500);
     //end;
end;

procedure decodeThread.Execute;
begin
     while not Terminated and not Suspended and not d65.glinprog do
     begin
          Try
          if d65doDecodePass And not d65.glinprog Then
          Begin
               d65.gldecoderPass := 0;
               d65.doDecode(0,533504);
               d65doDecodePass := False;
          End
          Else
          Begin
               d65doDecodePass := False;
          End;
          Except
             dlog.fileDebug('Notice:  Exception in decoder thread');
             if reDecode then reDecode := False;
          end;
          Sleep(500);
     end;
end;

procedure TForm1.saveCSV();
Var
   logFile : TextFile;
   i       : Integer;
   needLog : Boolean;
   fname   : String;
Begin
     //needLog := False;
     //for i := 0 to 99 do
     //begin
     //     if csvEntries[i] <> '' Then needLog := True;
     //end;
     //if needLog Then
     //begin
     //     Try
     //        fname := cfgvtwo.Form6.DirectoryEdit1.Directory + '\JT65hf-log.csv';
     //        AssignFile(logFile, fname);
     //        If FileExists(fname) Then
     //        Begin
     //             Append(logFile);
     //        End
     //        Else
     //        Begin
     //             Rewrite(logFile);
     //             WriteLn(logFile,'"Date","Time","QRG","Sync","DB","DT","DF","Decoder","Exchange"');
     //        End;
     //        // Write the record
     //        for i := 0 to 99 do
     //        begin
     //             if csvEntries[i] <> '' Then WriteLn(logFile,csvEntries[i]);
     //             csvEntries[i] := '';
     //        end;
     //        // Close the file
     //        CloseFile(logFile);
     //     except
     //        dlog.fileDebug('Exception in write csv log');
     //     end;
     //end;
end;

function getRigValue(rigStr : String) : Integer;
var
   foo : Integer;
Begin
     // Returns integer value for hamlib rig model from first four characters of string.
     // This allows the #### value that begins each pulldown entry to be parsed.
     Result := 0;
     foo := 0;
     If TryStrToInt(rigStr[1..4], foo) Then Result := foo else Result := 0;
End;

procedure catThread.Execute();
//Var
//   ifoo : Integer;
//   foo  : WideString;
//   efoo : WideString;
//   tqrg : Double;
//   bqrg : Boolean;
begin
     //while not Terminated And not Suspended And not catInProgress do
     //begin
     //     Try
     //        catInProgress := True;
     //        If doCAT Then
     //        Begin
     //             if cfgvtwo.glcatBy = 'omni' Then
     //             Begin
     //                  ifoo := 0;
     //                  if cfgvtwo.Form6.radioOmni1.Checked Then ifoo := 1;
     //                  if cfgvtwo.Form6.radioOmni2.Checked Then ifoo := 2;
     //                  globalData.gqrg := catControl.readOmni(ifoo);
     //             End;
     //             if cfgvtwo.glcatBy = 'hrd' Then
     //             Begin
     //                  if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion := 4;
     //                  if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion := 5;
     //                  catControl.hrdrigCAPS();
     //                  if globalData.hrdcatControlcurrentRig.hrdAlive Then
     //                  Begin
     //                       cfgvtwo.Form6.groupHRD.Caption := 'HRD Connected to ' + globalData.hrdcatControlcurrentRig.radioName;
     //                       globalData.gqrg := catControl.readHRDQRG();
     //
     //                       if globalData.hrdcatControlcurrentRig.hasAFGain Then
     //                       Begin
     //                            // Read audio level
     //                            cfgvtwo.Form6.sliderAFGain.Visible := True;
     //                            cfgvtwo.Form6.Label11.Visible := True;
     //                            cfgvtwo.Form6.pbAULeft.Visible := True;
     //                            cfgvtwo.Form6.pbAURight.Visible := True;
     //                            cfgvtwo.Form6.sliderAFGain.Min := globalData.hrdcatControlcurrentRig.afgMin;
     //                            cfgvtwo.Form6.sliderAFGain.Max := globalData.hrdcatControlcurrentRig.afgMax;
     //                            foo := catControl.readHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] Get slider-pos ' + globalData.hrdcatControlcurrentRig.radioName + ' ' + globalData.hrdcatControlcurrentRig.afgControl);
     //                            efoo := ExtractWord(1,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.sliderAFGain.Position := ifoo;
     //                            cfgvtwo.Form6.Label11.Caption := 'Audio Gain (Currently:  ' + ExtractWord(2,foo,catControl.HRDDelim) + '%)';
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.sliderAFGain.Visible := False;
     //                            cfgvtwo.Form6.Label11.Visible := False;
     //                            cfgvtwo.Form6.pbAULeft.Visible := False;
     //                            cfgvtwo.Form6.pbAURight.Visible := False;
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasRFGain Then
     //                       Begin
     //                            // Read RF Gain level
     //                            cfgvtwo.Form6.sliderRFGain.Visible := True;
     //                            cfgvtwo.Form6.Label17.Visible := True;
     //                            cfgvtwo.Form6.sliderRFGain.Min := globalData.hrdcatControlcurrentRig.rfgMin;
     //                            cfgvtwo.Form6.sliderRFGain.Max := globalData.hrdcatControlcurrentRig.rfgMax;
     //                            foo := catControl.readHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] Get slider-pos ' + globalData.hrdcatControlcurrentRig.radioName + ' ' + globalData.hrdcatControlcurrentRig.rfgControl);
     //                            efoo := ExtractWord(1,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.sliderRFGain.Position := ifoo;
     //                            cfgvtwo.Form6.Label17.Caption := 'RF Gain (Currently:  ' + ExtractWord(2,foo,catControl.HRDDelim) + '%)';
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.sliderRFGain.Visible := False;
     //                            cfgvtwo.Form6.Label17.Visible := False;
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasMicGain Then
     //                       Begin
     //                            // Read Mic Gain level
     //                            cfgvtwo.Form6.sliderMicGain.Visible := True;
     //                            cfgvtwo.Form6.Label15.Visible := True;
     //                            cfgvtwo.Form6.sliderMicGain.Min := globalData.hrdcatControlcurrentRig.micgMin;
     //                            cfgvtwo.Form6.sliderMicGain.Max := globalData.hrdcatControlcurrentRig.micgMax;
     //                            foo := catControl.readHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] Get slider-pos ' + globalData.hrdcatControlcurrentRig.radioName + ' ' + globalData.hrdcatControlcurrentRig.micgControl);
     //                            efoo := ExtractWord(1,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.sliderMicGain.Position := ifoo;
     //                            cfgvtwo.Form6.Label15.Caption := 'Mic Gain (Currently:  ' + ExtractWord(2,foo,catControl.HRDDelim) + '%)';
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.sliderMicGain.Visible := False;
     //                            cfgvtwo.Form6.Label15.Visible := False;
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasPAGain Then
     //                       Begin
     //                            // Read PA limit level
     //                            cfgvtwo.Form6.sliderPALevel.Visible := True;
     //                            cfgvtwo.Form6.Label18.Visible := True;
     //                            cfgvtwo.Form6.sliderPALevel.Min := globalData.hrdcatControlcurrentRig.pagMin;
     //                            cfgvtwo.Form6.sliderPALevel.Max := globalData.hrdcatControlcurrentRig.pagMax;
     //                            foo := catControl.readHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] Get slider-pos ' + globalData.hrdcatControlcurrentRig.radioName + ' ' + globalData.hrdcatControlcurrentRig.pagControl);
     //                            efoo := ExtractWord(1,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.sliderPALevel.Position := ifoo;
     //                            cfgvtwo.Form6.Label18.Caption := 'RF Output Level (Currently:  ' + ExtractWord(2,foo,catControl.HRDDelim) + '%)';
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.sliderPALevel.Visible := False;
     //                            cfgvtwo.Form6.Label18.Visible := False;
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasSMeter Then
     //                       Begin
     //                            // Read S-Meter level
     //                            // Smeter returns 3 csv values. 1 = Text S level, 2 = raw level and 3 = max level.
     //                            foo := catControl.readHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] Get ' + globalData.hrdcatControlcurrentRig.smeterControl);
     //                            efoo := ExtractWord(3,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            cfgvtwo.Form6.pbSMeter.Min := 0;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.pbSMeter.Max := ifoo;
     //                            efoo := ExtractWord(2,foo,catControl.hrdDelim);
     //                            ifoo := -1;
     //                            If TryStrToInt(efoo, ifoo) Then cfgvtwo.Form6.pbSMeter.Position := ifoo;
     //                            cfgvtwo.Form6.Label24.Caption := ExtractWord(1,foo,catControl.HRDDelim);
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasTX Then
     //                       begin
     //                            cfgvtwo.Form6.chkHRDPTT.Visible := True;
     //                            cfgvtwo.Form6.testHRDPTT.Visible := True;
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.chkHRDPTT.Checked := False;
     //                            cfgvtwo.Form6.chkHRDPTT.Visible := False;
     //                            cfgvtwo.Form6.testHRDPTT.Visible := False;
     //                       end;
     //                       if globalData.hrdcatControlcurrentRig.hasAutoTune and globalData.hrdcatControlcurrentRig.hasAutoTuneDo Then
     //                       Begin
     //                            cfgvtwo.Form6.cbATQSY1.Visible := True;
     //                            cfgvtwo.Form6.cbATQSY2.Visible := True;
     //                            cfgvtwo.Form6.cbATQSY3.Visible := True;
     //                            cfgvtwo.Form6.cbATQSY4.Visible := True;
     //                            cfgvtwo.Form6.cbATQSY5.Visible := True;
     //                       end
     //                       else
     //                       begin
     //                            cfgvtwo.Form6.cbATQSY1.Checked := False;
     //                            cfgvtwo.Form6.cbATQSY2.Checked := False;
     //                            cfgvtwo.Form6.cbATQSY3.Checked := False;
     //                            cfgvtwo.Form6.cbATQSY4.Checked := False;
     //                            cfgvtwo.Form6.cbATQSY5.Checked := False;
     //                            cfgvtwo.Form6.cbATQSY1.Visible := False;
     //                            cfgvtwo.Form6.cbATQSY2.Visible := False;
     //                            cfgvtwo.Form6.cbATQSY3.Visible := False;
     //                            cfgvtwo.Form6.cbATQSY4.Visible := False;
     //                            cfgvtwo.Form6.cbATQSY5.Visible := False;
     //                       end;
     //                  end
     //                  else
     //                  begin
     //                       globalData.gqrg := 0.0;
     //                       globalData.strqrg := '0';
     //                  end;
     //             End;
     //             if cfgvtwo.glcatBy = 'commander' Then
     //             Begin
     //                  ifoo := 0;
     //                  globalData.gqrg := catControl.readDXLabs();
     //             End;
     //             if cfgvtwo.glcatBy = 'si57' Then
     //             Begin
     //                  // Si570 is active and has QRG info.
     //                  // glsi57QRGi is dial QRG in Hz.
     //                  if cfgvtwo.glsi57QRGi > 999 Then tqrg := cfgvtwo.glsi57QRGi else tqrg := 0.0;
     //                  if tqrg > 0 Then
     //                  Begin
     //                       globalData.gqrg := tqrg;
     //                       globalData.strqrg := FloatToStr(tqrg);
     //                  End
     //                  Else
     //                  Begin
     //                       globalData.gqrg := 0.0;
     //                       globalData.strqrg := '0.0';
     //                  End;
     //             End;
     //             if cfgvtwo.glcatBy = 'none' Then
     //             Begin
     //                  tqrg := 0.0;
     //                  if TryStrToFloat(Form1.editManQRG.Text, tqrg) Then
     //                  Begin
     //                       // Need to eval the box and try to determine if it's
     //                       // Hz, KHz or MHz.
     //                       // Valid range of MHz 1.8 ... 460 (for now)
     //                       // Valid range of KHz 1800 460000
     //                       // > 460000 must be Hz.
     //                       bqrg := False;
     //                       If tqrg > 1000000 Then
     //                       Begin
     //                            // Eval as Hz
     //                            globalData.gqrg := tqrg;
     //                            globalData.strqrg := FloatToStr(tqrg);
     //                            bqrg := True;
     //                       End;
     //                       If (tqrg > 460) And (tqrg < 1000000) And not bqrg Then
     //                       Begin
     //                            // Eval as KHz
     //                            globalData.gqrg := tqrg*1000;
     //                            globalData.strqrg := FloatToStr(tqrg*1000);
     //                            bqrg := True;
     //                       End;
     //                       If (tqrg > 0) And (tqrg < 461) And not bqrg Then
     //                       Begin
     //                            // Eval as MHz
     //                            globalData.gqrg := tqrg*1000000;
     //                            globalData.strqrg := FloatToStr(tqrg*1000000);
     //                            bqrg := True;
     //                       End;
     //                       If not bqrg Then
     //                       Begin
     //                            // No idea....
     //                            globalData.gqrg := 0.0;
     //                            globalData.strqrg := '0';
     //                            Form1.editManQRG.Text := '0';
     //                       End;
     //                  End
     //                  Else
     //                  Begin
     //                       globalData.gqrg := 0.0;
     //                       globalData.strqrg := '0';
     //                  End;
     //             End;
     //             cfgvtwo.Form6.rigQRG.Text := globalData.strqrg;
     //             doCAT := False;
     //        end;
     //        catInProgress := False;
     //     except
     //        dlog.fileDebug('Exception in rig thread');
     //     end;
     //     sleep(100);
     //end;
end;

procedure TForm1.updateList(callsign : String);
Var
   i     : integer;
   found : Boolean;
Begin
     found := False;
     i := 0;
     while i < 500 do
     begin
          if rbsHeardList[i].callsign = callsign Then
          Begin
               inc(rbsHeardList[i].count);
               found := True;
               i := 501;
          End;
          inc(i);
     end;
     if not found Then
     Begin
          i := 0;
          while i < 500 do
          begin
               if rbsHeardList[i].callsign = '' Then
               Begin
                    rbsHeardList[i].callsign := callsign;
                    rbsHeardList[i].count := 1;
                    i := 500;
               End;
               inc(i);
          end;
     End;
End;

procedure TForm1.initDecode();
Var
   sr               : CTypes.cdouble;
   i                : Integer;
Begin
     //if not d65.glinprog Then
     //Begin
     //     if cfgvtwo.Form6.chkNoOptFFT.Checked Then
     //     Begin
     //          d65.glfftFWisdom := 0;
     //          d65.glfftSWisdom := 0;
     //     End;
     //     // Clear transfer buffer
     //     for i := 0 to 661503 do
     //     Begin
     //          d65.glinBuffer[i] := 0;
     //     end;
     //     // Range adjust and copy raw buffer to transfer buffer and rewind buffer
     //     bStart := 0;
     //     bEnd := 533504;
     //     for i := bStart to bEnd do
     //     Begin
     //          //d65.glinBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
     //          if Odd(thisMinute) Then
     //          Begin
     //               auOddBuffer[i] := d65.glinBuffer[i];
     //               haveOddBuffer := True;
     //               haveEvenBuffer := False;
     //          End
     //          else
     //          Begin
     //               auEvenBuffer[i] := d65.glinBuffer[i];;
     //               haveEvenBuffer := True;
     //               haveOddBuffer := False;
     //          End;
     //     end;
     //     ost := utcTime();
     //     d65.gld65timestamp := '';
     //     d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Year);
     //     if ost.Month < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Month) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Month);
     //     if ost.Day < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Day) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Day);
     //     if ost.Hour < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Hour) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Hour);
     //     if ost.Minute < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Minute) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Minute);
     //     d65.gld65timestamp := d65.gld65timestamp + '00';
     //     sr := 1.0;
     //     if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
     //     d65samfacout := 1.0;
     //     d65.glMouseDF := Form1.spinDecoderCF.Value;
     //     if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
     //     if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
     //     if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
     //     if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
     //     if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
     //     if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;
     //     d65.glbinspace := 100;
     //     if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
     //     if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;
     //     If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
     //     d65.glNshift := 0;
     //     if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
     //     d65.glNzap := 0;
     //     d65.gldecoderPass := 0;
     //     if form1.chkMultiDecode.Checked Then d65.glsteps := 1 else d65.glsteps := 0;
     //     d65doDecodePass := True;
     //End;
end;

procedure TForm1.btnEngageTxClick(Sender: TObject);
begin
     //if not globalData.validgrid then
     //begin
     //     cfgvtwo.Form6.Notebook1.ActivePage := 'Station Setup';
     //     cfgvtwo.Form6.Show;
     //     cfgvtwo.Form6.BringToFront;
     //     Form1.chkEnTX.Checked := False;
     //end
     //else
     //begin
     //     Form1.chkEnTX.Checked := True;
     //end;
end;

procedure TForm1.btnDefaultsClick(Sender: TObject);
begin
     Form1.edMsg.Clear;
     Form1.edFreeText.Clear;
     Form1.edHisCall.Clear;
     Form1.edSigRep.Clear;
     Form1.edHisGrid.Clear;
     Form1.spinTXCF.Value := 0;
     Form1.spinDecoderCF.Value := 0;
     Form1.spinDecoderBW.Value := 3;
     Form1.rbGenMsg.Checked := True;
     Form1.chkAutoTxDF.Checked := True;
     Form1.chkEnTX.Checked := False;
     //If cfgvtwo.Form6.cbRestoreMulti.Checked Then Form1.chkMultiDecode.Checked := True;
end;

procedure TForm1.btnHaltTxClick(Sender: TObject);
begin
  // Halt an upcoming or ongoing TX
  if globalData.txInProgress Then
  Begin
       // TX is in progress.  Abort it!
       // Unkey the TX, terminate the PA output stream and set op state to idle.
       // Changing this to drop txInProgress, pause .1 second then drop ptt in
       // response to report of lockup on dropPTT.  If the problem continues will
       // likely drop synaserial and use wsjt ptt from library.
       globalData.txInProgress := False;
       sleep(100);
       //if getPTTMethod() = 'SI5' Then si570Lowerptt();
       //if getPTTMethod() = 'HRD' Then hrdLowerPTT();
       //if getPTTMethod() = 'ALT' Then altLowerPTT();
       //if getPTTMethod() = 'PTT' Then lowerPTT();
       nextAction := 2;
       txNextPeriod := False;
       Form1.chkEnTX.Checked := False;
       thisAction := 2;
       actionSet := False;
       txCount := 0;
  end
  else
  begin
       // TX was requested but has not started.  Cancel request.
       if nextAction = 3 then nextAction := 2;
       if txNextPeriod Then txNextPeriod := False;
       Form1.chkEnTX.Checked := False;
       actionSet := False;
       txCount := 0;
  end;
end;

procedure TForm1.btnRawDecoderClick(Sender: TObject);
begin
     diagout.Form3.Visible := True;
     rawdec.Form5.Visible := True;
end;

procedure TForm1.buttonClearListClick(Sender: TObject);
begin
     // Clear the decoder listbox
     firstReport := True;
     itemsIn := False;
     Form1.ListBox1.Clear;
     // Check for TX/RB/PSKR disable and place notice.
     If not config1.canTX Then
     Begin
          If firstReport Then
          begin
               Form1.ListBox1.Items.Strings[0] := 'ERROR: Transmit disabled. Bad callsign or grid.';
               firstReport := False;
               itemsIn := True;
          end
          Else
          Begin
               Form1.ListBox1.Items.Insert(0,'ERROR: Transmit disabled. Bad callsign or grid.');
               itemsIn := True;
          End;
     End;
     If not config1.canSpot Then
     Begin
          If firstReport Then
          begin
               Form1.ListBox1.Items.Strings[0] := 'ERROR: RB/PSKR disabled. Bad callsign or grid.';
               firstReport := False;
               itemsIn := True;
          end
          Else
          Begin
               Form1.ListBox1.Items.Insert(0,'ERROR: RB/PSKR disabled. Bad callsign or grid.');
               itemsIn := True;
          End;
     End;
end;

procedure TForm1.buttonAckReport1Click(Sender: TObject);
begin
     if (globalData.fullcall <> '') And (Form1.edHisCall.Text <> '') Then
     Begin
          if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' RRR';
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' RRR';
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
          doCWID := False;
     End;
end;

procedure TForm1.buttonAckReport2Click(Sender: TObject);
begin
     if (globalData.fullcall <> '') And (Form1.edHisCall.Text <> '') Then
     Begin
          if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' R' + Form1.edSigRep.Text;
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' R' + Form1.edSigRep.Text;
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
          doCWID := False;
     end;
end;

procedure TForm1.buttonCQClick(Sender: TObject);
begin
     //if (globalData.fullcall <> '') And (cfgvtwo.Form6.edMyGrid.Text <> '') Then
     //Begin
     //     if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
     //     Begin
     //          Form1.edMsg.Text := 'CQ ' + globalData.fullcall;
     //     End
     //     Else
     //     Begin
     //          Form1.edMsg.Text := 'CQ ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
     //     End;
     //     doCWID := False;
     //     Form1.rbGenMsg.Checked := True;
     //     Form1.rbGenMsg.Font.Color := clRed;
     //     Form1.rbFreeMsg.Font.Color  := clBlack;
     //     useBuffer := 0;
     //End;
end;

procedure TForm1.buttonAnswerCQClick(Sender: TObject);
begin
     //if (globalData.fullcall <> '') And (cfgvtwo.Form6.edMyGrid.Text <> '') And (Form1.edHisCall.Text <> '') Then
     //Begin
     //     if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
     //     Begin
     //          Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall;
     //     End
     //     Else
     //     Begin
     //          Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
     //     End;
     //     Form1.rbGenMsg.Checked := True;
     //     Form1.rbGenMsg.Font.Color := clRed;
     //     Form1.rbFreeMsg.Font.Color  := clBlack;
     //     useBuffer := 0;
     //     doCWID := False;
     //End;
end;

procedure TForm1.buttonEndQSO1Click(Sender: TObject);
begin
     if (globalData.fullcall <> '') And (Form1.edHisCall.Text <> '') Then
     Begin
          if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' 73';
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' 73';
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
          //if cfgvtwo.Form6.cbCWID.Checked Then doCWID := True else doCWID := False;
     End;
end;

procedure TForm1.buttonSendReportClick(Sender: TObject);
begin
     if (globalData.fullcall <> '') And (Form1.edHisCall.Text <> '') Then
     Begin
          if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + Form1.edSigRep.Text;
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' ' + Form1.edSigRep.Text;
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
          doCWID := False;
     End;
end;

procedure TForm1.buttonSetupClick(Sender: TObject);
begin
     //cfgvtwo.Form6.Notebook1.ActivePage := 'Station Setup';
     //cfgvtwo.Form6.Show;
     //cfgvtwo.Form6.BringToFront;
end;

procedure TForm1.cbEnPSKRClick(Sender: TObject);
begin
     //if not globaldata.validgrid Then
     //begin
     //     cfgvtwo.Form6.Notebook1.ActivePage := 'Station Setup';
     //     cfgvtwo.Form6.Show;
     //     cfgvtwo.Form6.BringToFront;
     //     cfgvtwo.Form6.cbUsePSKReporter.Checked := False;
     //     Form1.cbEnPSKR.Checked := False;
     //end
     //else
     //begin
     //     If Form1.cbEnPSKR.Checked Then cfgvtwo.Form6.cbUsePSKReporter.Checked := True else cfgvtwo.Form6.cbUsePSKReporter.Checked := False;
     //end;
end;

procedure TForm1.cbEnRBChange(Sender: TObject);
begin
     //if not globaldata.validgrid Then
     //begin
     //     cfgvtwo.Form6.Notebook1.ActivePage := 'Station Setup';
     //     cfgvtwo.Form6.Show;
     //     cfgvtwo.Form6.BringToFront;
     //     cfgvtwo.Form6.cbUseRB.Checked := False;
     //     Form1.cbEnRB.Checked := False;
     //end
     //else
     //begin
     //     If Form1.cbEnRB.Checked Then cfgvtwo.Form6.cbUseRB.Checked := True else cfgvtwo.Form6.cbUseRB.Checked := False;
     //     If cfgvtwo.Form6.cbUseRB.Checked And not cfgvtwo.Form6.cbNoInet.Checked Then cfgvtwo.glrbcLogin := True else cfgvtwo.glrbcLogout := True;
     //     // Handle case of rb having been online but now set to offline mode.
     //     If (cfgvtwo.Form6.cbNoInet.Checked) And (globalData.rbLoggedIn) Then cfgvtwo.glrbcLogout := True;
     //end;
end;

procedure TForm1.cbSmoothChange(Sender: TObject);
begin
     if Form1.cbSmooth.Checked Then spectrum.specSmooth := True else spectrum.specSmooth := False;
end;

procedure TForm1.rbFreeMsgChange(Sender: TObject);
begin
     if Form1.rbFreeMsg.Checked Then
     Begin
          Form1.rbFreeMsg.Font.Color := clRed;
          Form1.rbGenMsg.Font.Color  := clBlack;
          useBuffer := 1;
     End;
     if Form1.rbGenMsg.Checked Then
     Begin
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
     End;
end;

procedure TForm1.spinDecoderBWChange(Sender: TObject);
begin
     if spinDecoderBW.Value = 1 Then edit2.Text := '20';
     if spinDecoderBW.Value = 2 Then edit2.Text := '50';
     if spinDecoderBW.Value = 3 Then edit2.Text := '100';
     if spinDecoderBW.Value = 4 Then edit2.Text := '200';
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
     if spinEdit1.Value > 5 then spinEdit1.Value := 5;
     if spinEdit1.Value < 0 then spinEdit1.Value := 0;
     spectrum.specSpeed2 := Form1.SpinEdit1.Value;
end;

procedure TForm1.spinGainChange(Sender: TObject);
begin
     if spinGain.value > 6 Then spinGain.Value := 6;
     if spinGain.value < -6 Then spinGain.Value := -6;
     spectrum.specVGain := 7 + spinGain.Value;
end;

procedure TForm1.chkAFCChange(Sender: TObject);
begin
  If Form1.chkAFC.Checked Then Form1.chkAFC.Font.Color := clRed else
  Form1.chkAFC.Font.Color := clBlack;
  if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
end;

procedure TForm1.chkAutoTxDFChange(Sender: TObject);
begin
     If Form1.chkAutoTxDF.Checked Then
     Begin
          Form1.Label39.Font.Color := clRed;
          Form1.spinTXCF.Value := Form1.spinDecoderCF.Value;
     End
     Else
     Begin
          Form1.Label39.Font.Color := clBlack;
     End;
end;

procedure TForm1.chkMultiDecodeChange(Sender: TObject);
begin

     If Form1.chkMultiDecode.Checked Then
     Begin
          Form1.chkMultiDecode.Font.Color := clBlack;
     End
     Else
     Begin
          Form1.chkMultiDecode.Font.Color := clRed;
     End;
end;

procedure TForm1.chkNBChange(Sender: TObject);
begin
  If Form1.chkNB.Checked Then Form1.chkNB.Font.Color := clRed else
  Form1.chkNB.Font.Color := clBlack;
end;

procedure TForm1.cbSpecPalChange(Sender: TObject);
begin
  spectrum.specColorMap := Form1.cbSpecPal.ItemIndex;
end;

procedure TForm1.WaterFallMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
   df : Single;
begin
     if x = 0 then df := -1019;
     if x > 0 Then df := X*2.7027;
     df := -1018.9189 + df;

     if Button = mbLeft Then
     Begin
          Form1.spinTXCF.Value := round(df);
          if form1.chkAutoTxDF.Checked Then Form1.spinDecoderCF.Value := Form1.spinTXCF.Value;
     End;

     if Button = mbRight Then
     Begin
          Form1.spinDecoderCF.Value := round(df);
          if form1.chkAutoTxDF.Checked Then Form1.spinTXCF.Value := Form1.spinDecoderCF.Value;
     End;

end;

procedure TForm1.edFreeTextDblClick(Sender: TObject);
begin
  // Clear it
  Form1.edFreeText.Clear;
end;

procedure TForm1.edHisCallDblClick(Sender: TObject);
begin
  // Clear it
  Form1.edHisCall.Clear;
end;

procedure TForm1.edHisGridDblClick(Sender: TObject);
begin
  // Clear it
  Form1.edHisGrid.Clear;
end;

procedure TForm1.editManQRGChange(Sender: TObject);
begin
     if globalData.rbLoggedIn Then
     Begin
          globalData.rbLoggedIn := False;
          //cfgvtwo.glrbcLogin := True;
     End;
end;

procedure TForm1.edMsgDblClick(Sender: TObject);
begin
  Form1.edMsg.Clear;
end;

procedure TForm1.edSigRepDblClick(Sender: TObject);
begin
     Form1.edSigRep.Text := '';
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
   i, termcount : Integer;
   foo          : String;
begin
     Form1.Timer1.Enabled := False;
     //diagout.Form3.ListBox1.Clear;
     //diagout.Form3.Show;
     //diagout.Form3.BringToFront;
     //diagout.Form3.ListBox1.Items.Add('Closing JT65-HF.  This will take a few seconds.');
     //diagout.Form3.ListBox1.Items.Add('Saving Configuration');
     //if CloseAction = caFree Then
     //Begin
     //     // Update configuration settings.
     //     cfg.StoredValue['call']         := UpperCase(cfgvtwo.glmycall);
     //     cfg.StoredValue['pfx']          := IntToStr(cfgvtwo.Form6.comboPrefix.ItemIndex);
     //     cfg.StoredValue['sfx']          := IntToStr(cfgvtwo.Form6.comboSuffix.ItemIndex);
     //     cfg.StoredValue['grid']         := cfgvtwo.Form6.edMyGrid.Text;
     //     cfg.StoredValue['txCF'] := IntToStr(Form1.spinTXCF.Value);
     //     cfg.StoredValue['rxCF'] := IntToStr(Form1.spinDecoderCF.Value);
     //     cfg.StoredValue['soundin']      := IntToStr(cfgvtwo.Form6.cbAudioIn.ItemIndex);
     //     cfg.StoredValue['soundout']     := IntToStr(cfgvtwo.Form6.cbAudioOut.ItemIndex);
     //     cfg.StoredValue['ldgain']       := IntToStr(Form1.TrackBar1.Position);
     //     cfg.StoredValue['rdgain']       := IntToStr(Form1.TrackBar2.Position);
     //     cfg.StoredValue['samfacin']     := cfgvtwo.Form6.edRXSRCor.Text;
     //     cfg.StoredValue['samfacout']    := cfgvtwo.Form6.edTXSRCor.Text;
     //     if Form1.rbUseLeft.Checked Then cfg.StoredValue['audiochan'] := 'L' Else cfg.StoredValue['audiochan'] := 'R';
     //     If cfgvtwo.Form6.chkEnableAutoSR.Checked Then cfg.StoredValue['autoSR'] := '1' else cfg.StoredValue['autoSR'] := '0';
     //     cfg.StoredValue['pttPort']      := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);
     //     if Form1.chkAFC.Checked Then cfg.StoredValue['afc'] := '1' Else cfg.StoredValue['afc'] := '0';
     //     if Form1.chkNB.Checked Then cfg.StoredValue['noiseblank'] := '1' Else cfg.StoredValue['noiseblank'] := '0';
     //     cfg.StoredValue['brightness']   := IntToStr(Form1.tbBright.Position);
     //     cfg.StoredValue['contrast']     := IntToStr(Form1.tbContrast.Position);
     //     cfg.StoredValue['colormap']     := IntToStr(Form1.cbSpecPal.ItemIndex);
     //     cfg.StoredValue['specspeed']    := IntToStr(Form1.SpinEdit1.Value);
     //     cfg.StoredValue['version'] := verHolder.verReturn();
     //     if cfgvtwo.Form6.cbTXWatchDog.Checked Then cfg.StoredValue['txWatchDog'] := '1' else cfg.StoredValue['txWatchDog'] := '0';
     //     cfg.StoredValue['txWatchDogCount'] := IntToStr(cfgvtwo.Form6.spinTXCounter.Value);
     //     if cfgvtwo.Form6.cbDisableMultiQSO.Checked Then cfg.StoredValue['multiQSOToggle'] := '1' else cfg.StoredValue['multiQSOToggle'] := '0';
     //     if cfgvtwo.Form6.cbMultiAutoEnable.Checked Then cfg.StoredValue['multiQSOWatchDog'] := '1' else cfg.StoredValue['multiQSOWatchDog'] := '0';
     //     if cfgvtwo.Form6.cbSaveCSV.Checked Then cfg.StoredValue['saveCSV'] := '1' else cfg.StoredValue['saveCSV'] := '0';
     //     cfg.StoredValue['csvPath'] := cfgvtwo.Form6.DirectoryEdit1.Directory;
     //     cfg.StoredValue['adiPath'] := cfgvtwo.Form6.DirectoryEdit1.Directory;
     //     cfg.StoredValue['catBy'] := cfgvtwo.glcatBy;
     //     if cfgvtwo.Form6.cbUsePSKReporter.Checked Then cfg.StoredValue['usePSKR'] := 'yes' else cfg.StoredValue['usePSKR'] := 'no';
     //     if cfgvtwo.Form6.cbUseRB.Checked Then cfg.StoredValue['useRB'] := 'yes' else cfg.StoredValue['useRB'] := 'no';
     //     cfg.StoredValue['pskrAntenna'] := cfgvtwo.Form6.editPSKRAntenna.Text;
     //     cfg.StoredValue['pskrCall'] := cfgvtwo.Form6.editPSKRCall.Text;
     //     cfg.StoredValue['userQRG1'] := cfgvtwo.Form6.edUserQRG1.Text;
     //     cfg.StoredValue['userQRG2'] := cfgvtwo.Form6.edUserQRG2.Text;
     //     cfg.StoredValue['userQRG3'] := cfgvtwo.Form6.edUserQRG3.Text;
     //     cfg.StoredValue['userQRG4'] := cfgvtwo.Form6.edUserQRG4.Text;
     //     cfg.StoredValue['usrMsg1'] := cfgvtwo.Form6.edUserMsg4.Text;
     //     cfg.StoredValue['usrMsg2'] := cfgvtwo.Form6.edUserMsg5.Text;
     //     cfg.StoredValue['usrMsg3'] := cfgvtwo.Form6.edUserMsg6.Text;
     //     cfg.StoredValue['usrMsg4'] := cfgvtwo.Form6.edUserMsg7.Text;
     //     cfg.StoredValue['usrMsg5'] := cfgvtwo.Form6.edUserMsg8.Text;
     //     cfg.StoredValue['usrMsg6'] := cfgvtwo.Form6.edUserMsg9.Text;
     //     cfg.StoredValue['usrMsg7'] := cfgvtwo.Form6.edUserMsg10.Text;
     //     cfg.StoredValue['usrMsg8'] := cfgvtwo.Form6.edUserMsg11.Text;
     //     cfg.StoredValue['usrMsg9'] := cfgvtwo.Form6.edUserMsg12.Text;
     //     cfg.StoredValue['usrMsg10'] := cfgvtwo.Form6.edUserMsg13.Text;
     //     if Form1.cbSmooth.Checked Then cfg.StoredValue['smooth'] := 'on' else cfg.StoredValue['smooth'] := 'off';
     //     if cfgvtwo.Form6.cbRestoreMulti.Checked Then cfg.StoredValue['restoreMulti'] := 'on' else cfg.StoredValue['restoreMulti'] := 'off';
     //     if cfgvtwo.Form6.chkNoOptFFT.Checked Then cfg.StoredValue['optFFT'] := 'off' else cfg.StoredValue['optFFT'] := 'on';
     //     if cfgvtwo.Form6.cbUseAltPTT.Checked Then cfg.StoredValue['useAltPTT'] := 'yes' else cfg.StoredValue['useAltPTT'] := 'no';
     //     if cfgvtwo.Form6.chkHRDPTT.Checked Then cfg.StoredValue['useHRDPTT'] := 'yes' else cfg.StoredValue['useHRDPTT'] := 'no';
     //     cfg.StoredValue['specVGain'] := IntToStr(spinGain.Value);
     //     cfg.StoredValue['binspace'] := '100';
     //     cfg.StoredValue['cqColor'] := IntToStr(cfgvtwo.Form6.ComboBox1.ItemIndex);
     //     cfg.StoredValue['callColor'] := IntToStr(cfgvtwo.Form6.ComboBox2.ItemIndex);
     //     cfg.StoredValue['qsoColor'] := IntToStr(cfgvtwo.Form6.ComboBox3.ItemIndex);
     //     if cfgvtwo.Form6.radioSI570X1.Checked Then cfg.StoredValue['si570mul'] := '1';
     //     if cfgvtwo.Form6.radioSI570X2.Checked Then cfg.StoredValue['si570mul'] := '2';
     //     if cfgvtwo.Form6.radioSI570X4.Checked Then cfg.StoredValue['si570mul'] := '4';
     //     cfg.StoredValue['si570cor'] := cfgvtwo.Form6.editSI570FreqOffset.Text;
     //     cfg.StoredValue['si570qrg'] := cfgvtwo.Form6.editSI570Freq.Text;
     //     if cfgvtwo.Form6.cbSi570PTT.Checked Then cfg.StoredValue['si570ptt'] := 'y' else cfg.StoredValue['si570ptt'] := 'n';
     //     if cfgvtwo.Form6.cbCWID.Checked Then cfg.StoredValue['useCWID'] := 'y' else cfg.StoredValue['useCWID'] := 'n';
     //     if cfgvtwo.Form6.chkTxDFVFO.Checked Then cfg.StoredValue['useCATTxDF'] := 'yes' else cfg.StoredValue['useCATTxDF'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY1.Checked Then cfg.StoredValue['enAutoQSY1'] := 'yes' else cfg.StoredValue['enAutoQSY1'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY2.Checked Then cfg.StoredValue['enAutoQSY2'] := 'yes' else cfg.StoredValue['enAutoQSY2'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY3.Checked Then cfg.StoredValue['enAutoQSY3'] := 'yes' else cfg.StoredValue['enAutoQSY3'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY4.Checked Then cfg.StoredValue['enAutoQSY4'] := 'yes' else cfg.StoredValue['enAutoQSY4'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY5.Checked Then cfg.StoredValue['enAutoQSY5'] := 'yes' else cfg.StoredValue['enAutoQSY5'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY1.Checked Then cfg.StoredValue['autoQSYAT1'] := 'yes' else cfg.StoredValue['autoQSYAT1'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY2.Checked Then cfg.StoredValue['autoQSYAT2'] := 'yes' else cfg.StoredValue['autoQSYAT2'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY3.Checked Then cfg.StoredValue['autoQSYAT3'] := 'yes' else cfg.StoredValue['autoQSYAT3'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY4.Checked Then cfg.StoredValue['autoQSYAT4'] := 'yes' else cfg.StoredValue['autoQSYAT4'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY5.Checked Then cfg.StoredValue['autoQSYAT5'] := 'yes' else cfg.StoredValue['autoQSYAT5'] := 'no';
     //     cfg.StoredValue['autoQSYQRG1'] := cfgvtwo.Form6.edQRGQSY1.Text;
     //     cfg.StoredValue['autoQSYQRG2'] := cfgvtwo.Form6.edQRGQSY2.Text;
     //     cfg.StoredValue['autoQSYQRG3'] := cfgvtwo.Form6.edQRGQSY3.Text;
     //     cfg.StoredValue['autoQSYQRG4'] := cfgvtwo.Form6.edQRGQSY4.Text;
     //     cfg.StoredValue['autoQSYQRG5'] := cfgvtwo.Form6.edQRGQSY5.Text;
     //     cfg.StoredValue['hrdAddress'] := cfgvtwo.Form6.hrdAddress.Text;
     //     cfg.StoredValue['hrdPort'] := cfgvtwo.Form6.hrdPort.Text;
     //     if cfgvtwo.Form6.qsyHour1.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute1.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC1'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour2.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute2.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC2'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour3.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute3.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC3'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour4.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute4.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC4'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour5.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute5.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC5'] := foo;
     //     cfg.Save;
     //     diagout.Form3.ListBox1.Items.Add('Saved configuration');
     //
     //     if mnpttOpened Then
     //     Begin
     //          diagout.Form3.ListBox1.Items.Add('Closing PTT Port');
     //          if getPTTMethod() = 'SI5' Then si570Lowerptt();
     //          if getPTTMethod() = 'HRD' Then hrdLowerPTT();
     //          if getPTTMethod() = 'ALT' Then altLowerPTT();
     //          if getPTTMethod() = 'PTT' Then lowerPTT();
     //          diagout.Form3.ListBox1.Items.Add('Closed PTT Port');
     //     end;
     //     if globalData.rbLoggedIn Then
     //     Begin
     //          diagout.Form3.ListBox1.Items.Add('Closing RB');
     //          cfgvtwo.glrbcLogout := True;
     //          sleep(1000);
     //     end;
     //     termcount := 0;
     //     While rbc.glrbActive Do
     //     Begin
     //          application.ProcessMessages;
     //          sleep(1000);
     //          inc(termcount);
     //          if termcount > 9 then break;
     //     end;
     //     diagout.Form3.ListBox1.Items.Add('Closed RB');
     //     diagout.Form3.ListBox1.Items.Add('Terminating RB Thread');
     //     rbThread.Suspend;
     //     diagout.Form3.ListBox1.Items.Add('Terminated RB Thread');
     //
     //     diagout.Form3.ListBox1.Items.Add('Terminating Decoder Thread');
     //     termcount := 0;
     //     while d65.glinProg Do
     //     Begin
     //          application.ProcessMessages;
     //          sleep(1000);
     //          inc(termcount);
     //          if termcount > 9 then break;
     //     end;
     //     decoderThread.Suspend;
     //     diagout.Form3.ListBox1.Items.Add('Terminated Decoder Thread');
     //
     //     diagout.Form3.ListBox1.Items.Add('Terminating Rig Control Thread');
     //     termcount :=0;
     //     if catcontrol.hrdConnected() then diagout.Form3.ListBox1.Items.Add('Disconnecting HRD');
     //     while catcontrol.hrdConnected() do
     //     Begin
     //          application.ProcessMessages;
     //          catcontrol.hrdDisconnect();
     //          sleep(1000);
     //          inc(termcount);
     //          if termcount > 9 Then break;
     //     end;
     //     termcount := 0;
     //     while catInProgress Do
     //     Begin
     //          application.ProcessMessages;
     //          sleep(1000);
     //          inc(termcount);
     //          if termcount > 9 then break;
     //     end;
     //     rigThread.Suspend;
     //     diagout.Form3.ListBox1.Items.Add('Terminated Rig Control Thread');
     //
     //     diagout.Form3.ListBox1.Items.Add('Freeing Threads');
     //     rbThread.Terminate;
     //     decoderThread.Terminate;
     //     rigThread.Terminate;
     //     if not rbThread.FreeOnTerminate Then rbThread.Free;
     //     if not decoderThread.FreeOnTerminate Then decoderThread.Free;
     //     if not rigThread.FreeOnTerminate Then rigThread.Free;
     //     diagout.Form3.ListBox1.Items.Add('Done');

          //diagout.Form3.ListBox1.Items.Add('Cleaning up Audio Streams');
          //portAudio.Pa_StopStream(paInStream);
          //portAudio.Pa_StopStream(paOutStream);
          //termcount := 0;
          //while (portAudio.Pa_IsStreamActive(paInStream) > 0) or (portAudio.Pa_IsStreamActive(paOutStream) > 0) Do
          //Begin
          //     application.ProcessMessages;
          //     if portAudio.Pa_IsStreamActive(paInStream) > 0 Then portAudio.Pa_StopStream(paInStream);
          //     if portAudio.Pa_IsStreamActive(paOutStream) > 0 Then portAudio.Pa_StopStream(paOutStream);
          //     sleep(1000);
          //     inc(termcount);
          //     if termcount > 9 then break;
          //end;
          //diagout.Form3.ListBox1.Items.Add('Stopped Audio Streams');
          //diagout.Form3.ListBox1.Items.Add('Terminating PortAudio');
          //portaudio.Pa_Terminate();
          //diagout.Form3.ListBox1.Items.Add('Terminated PortAudio');

     //     if cfgvtwo.Form6.cbUsePSKReporter.Checked Then
     //     Begin
     //          diagout.Form3.ListBox1.Items.Add('Cleaning up PSK Reporter Interface');
     //          PSKReporter.ReporterUninitialize;
     //          diagout.Form3.ListBox1.Items.Add('Cleaned up PSK Reporter Interface');
     //     end
     //     else
     //     begin
     //          PSKReporter.ReporterUninitialize;
     //     end;
     //     diagout.Form3.ListBox1.Items.Add('Releasing waterfall');
     //     Waterfall.Free;
     //     diagout.Form3.ListBox1.Items.Add('Released waterfall');
     //     diagout.Form3.ListBox1.Items.Add('JT65-HF Shutdown complete.  Exiting.');
     //     For i := 0 to 9 do
     //     begin
     //          application.ProcessMessages;
     //          sleep(100);
     //     end;
     //End;
end;

procedure Tform1.addToRBC(i , m : Integer);
Var
   ii : Integer;
begin
     //If cfgvtwo.Form6.cbUseRB.Checked Then
     //Begin
     //     // Clear rb pass-through array of processed entries.
     //     for ii := 0 to 499 do
     //     begin
     //          if rbc.glrbReports[ii].rbProcessed Then
     //          Begin
     //               rbc.glrbReports[ii].rbCached    := False;
     //               rbc.glrbReports[ii].rbCharSync  := '';
     //               rbc.glrbReports[ii].rbDecoded   := '';
     //               rbc.glrbReports[ii].rbDeltaFreq := '';
     //               rbc.glrbReports[ii].rbDeltaTime := '';
     //               rbc.glrbReports[ii].rbFrequency := '';
     //               rbc.glrbReports[ii].rbNumSync   := '';
     //               rbc.glrbReports[ii].rbSigLevel  := '';
     //               rbc.glrbReports[ii].rbSigW      := '';
     //               rbc.glrbReports[ii].rbDecoder   := '';
     //               rbc.glrbReports[ii].rbTimeStamp := '';
     //               rbc.glrbReports[ii].rbProcessed := True;
     //               rbc.glrbReports[ii].rbMode      := 0;
     //          end;
     //     end;
     //     ii := 0;
     //     while ii < 500 do
     //     begin
     //          if rbc.glrbReports[ii].rbProcessed Then
     //          Begin
     //               if (eopQRG=sopQRG) And (Form1.editManQRG.Text<>'0') Then
     //               Begin
     //                    if m=65 then
     //                    Begin
     //                         // If rbProcessed then safe to overwrite previous contents
     //                         rbc.glrbReports[ii].rbTimeStamp := d65.gld65decodes[i].dtTimeStamp;
     //                         rbc.glrbReports[ii].rbNumSync   := d65.gld65decodes[i].dtNumSync;
     //                         rbc.glrbReports[ii].rbSigLevel  := d65.gld65decodes[i].dtSigLevel;
     //                         rbc.glrbReports[ii].rbDeltaTime := d65.gld65decodes[i].dtDeltaTime;
     //                         rbc.glrbReports[ii].rbDeltaFreq := d65.gld65decodes[i].dtDeltaFreq;
     //                         rbc.glrbReports[ii].rbSigW      := d65.gld65decodes[i].dtSigW;
     //                         rbc.glrbReports[ii].rbCharSync  := d65.gld65decodes[i].dtCharSync;
     //                         rbc.glrbReports[ii].rbDecoded   := d65.gld65decodes[i].dtDecoded;
     //                         rbc.glrbReports[ii].rbDecoder   := d65.gld65decodes[i].dtType;
     //                         rbc.glrbReports[ii].rbFrequency := FloatToStr(eopQRG/1000);
     //                         rbc.glrbReports[ii].rbMode      := m;
     //                         rbc.glrbReports[ii].rbProcessed := False;
     //                         rbc.glrbReports[ii].rbCached    := False;
     //                    End;
     //               End
     //               Else
     //               Begin
     //                    dlog.FileDebug('RB Report discarded Start/End QRG not same.');
     //               End;
     //               d65.gld65decodes[i].dtProcessed := True;
     //               ii := 501;
     //          End;
     //          inc(ii);
     //     end;
     //End
     //Else
     //Begin
     //     d65.gld65decodes[i].dtProcessed := True;
     //End;
end;

procedure TForm1.FormCreate(Sender: TObject);
Var
   fname       : String;
   PIDL : PItemIDList;
   Folder : array[0..MAX_PATH] of Char;
   const CSIDL_PERSONAL = $0005;
begin
     // DEBUGGING
     SHGetSpecialFolderLocation(0, CSIDL_PERSONAL, PIDL);
     SHGetPathFromIDList(PIDL, Folder);
     globalData.basedir := Folder;
     globalData.srcdir  := globalData.basedir + '\JT65HF';
     globalData.logdir  := globalData.basedir + '\JT65HF\log';
     globalData.cfgdir  := globalData.basedir + '\JT65HF\data';
     globalData.kvdir   := globalData.basedir + '\JT65HF\kvdt';
     cfgError := True;
     Try
        fname := globalData.cfgdir+'\station1.xml';
        cfg.FileName := fname;
        cfgError := False;
     Except
        // An exception here means the xml config file is corrupted. :(
        // So, I need to delete it and force a regeneration.
        //function RenameFileUTF8(const OldName, NewName: String): Boolean;
        //function DeleteFileUTF8(const FileName: String): Boolean;
        if not DeleteFileUTF8(globalData.cfgdir+'\station1.xml') Then
        Begin
             cfgError := True;
             cfgRecover := False;
        End
        else
        Begin
             cfg.FileName := fname;
             cfgRecover := True;
        End;
     End;
end;

procedure TForm1.Label17DblClick(Sender: TObject);
begin
     // Zero brightness
     Form1.tbBright.Position := 0;
     spectrum.specGain := 0;
end;

procedure TForm1.Label22DblClick(Sender: TObject);
begin
     // Zero contrast
     Form1.tbContrast.Position := 0;
     spectrum.specContrast := 0;
end;

procedure TForm1.Label19DblClick(Sender: TObject);
begin
     // Disable PSKR reportings
     //cfgvtwo.Form6.cbUsePSKReporter.Checked := False;
end;

procedure TForm1.Label30DblClick(Sender: TObject);
begin
     // Disbale RB Reportings
     //cfgvtwo.Form6.cbUseRB.Checked := False;
end;

procedure TForm1.Label31DblClick(Sender: TObject);
begin
     Form1.spinGain.Value := 0;
     spectrum.specVGain := Form1.spinGain.Value + 7;
end;

procedure TForm1.Label39Click(Sender: TObject);
begin
     if chkAutoTxDF.Checked Then chkAutoTxDF.Checked := False else chkAutoTxDF.Checked := True;
end;

procedure TForm1.menuAboutClick(Sender: TObject);
begin
     about.Form4.Visible := True;
end;

procedure TForm1.menuHeardClick(Sender: TObject);
begin
     //cfgvtwo.Form6.Notebook1.ActivePage := 'Heard List/PSKR Setup/RB Setup';
     //cfgvtwo.Form6.Show;
     //cfgvtwo.Form6.BringToFront;
end;

procedure TForm1.MenuItemHandler(Sender: TObject);
Begin

     // QRG Control Items
     If Sender=Form1.MenuItem1 Then Form1.editManQRG.Text := '3576';
     If Sender=Form1.MenuItem2 Then Form1.editManQRG.Text := '7039';
     If Sender=Form1.MenuItem3 Then Form1.editManQRG.Text := '7076';
     If Sender=Form1.MenuItem4 Then Form1.editManQRG.Text := '10139';
     If Sender=Form1.MenuItem5 Then Form1.editManQRG.Text := '10147';
     If Sender=Form1.MenuItem6 Then Form1.editManQRG.Text := '14076';
     If Sender=Form1.MenuItem7 Then Form1.editManQRG.Text := '18102';
     If Sender=Form1.MenuItem8 Then Form1.editManQRG.Text := '18106';
     If Sender=Form1.MenuItem9 Then Form1.editManQRG.Text := '21076';
     If Sender=Form1.MenuItem10 Then Form1.editManQRG.Text := '24920';
     If Sender=Form1.MenuItem11 Then Form1.editManQRG.Text := '28076';
     If Sender=Form1.MenuItem12 Then Form1.editManQRG.Text := '1838';
     //If Sender=Form1.MenuItem22 Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG1.Text;
     //If Sender=Form1.MenuItem23 Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG2.Text;
     //If Sender=Form1.MenuItem28 Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG3.Text;
     //If Sender=Form1.MenuItem29 Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG4.Text;
     // Free Text Messages
     If Sender=Form1.MenuItem13 Then Form1.edFreeText.Text := 'RO';
     If Sender=Form1.MenuItem14 Then Form1.edFreeText.Text := 'RRR';
     If Sender=Form1.MenuItem15 Then Form1.edFreeText.Text := '73';
     //If Sender=Form1.MenuItem16 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg4.Text;
     //If Sender=Form1.MenuItem17 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg5.Text;
     //If Sender=Form1.MenuItem18 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg6.Text;
     //If Sender=Form1.MenuItem19 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg7.Text;
     //If Sender=Form1.MenuItem20 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg8.Text;
     //If Sender=Form1.MenuItem21 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg9.Text;
     //If Sender=Form1.MenuItem24 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg10.Text;
     //If Sender=Form1.MenuItem25 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg11.Text;
     //If Sender=Form1.MenuItem26 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg12.Text;
     //If Sender=Form1.MenuItem27 Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg13.Text;

End;

procedure TForm1.menuRawDecoderClick(Sender: TObject);
begin
     diagout.Form3.Visible := True; // diagout is the raw decoder output form... it was repurposed for this.
end;

procedure TForm1.menuRigControlClick(Sender: TObject);
begin
     //cfgvtwo.Form6.Notebook1.ActivePage := 'Rig Control/PTT';
     //cfgvtwo.Form6.Show;
     //cfgvtwo.Form6.BringToFront;
end;

procedure TForm1.menuSetupClick(Sender: TObject);
begin
     //cfgvtwo.Form6.Notebook1.ActivePage := 'Station Setup';
     //cfgvtwo.Form6.Show;
     //cfgvtwo.Form6.BringToFront;
end;

procedure TForm1.menuTXLogClick(Sender: TObject);
begin
     rawdec.Form5.Visible := True;
end;

procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
   MousePos      : TPoint;
   OverItemIndex : integer;
begin
     MousePos.x := X;
     MousePos.y := Y;
     if (Button = mbRight) And itemsIn then
     begin
          OverItemIndex := Form1.ListBox1.ItemAtPos(MousePos,True);
          If OverItemIndex > -1 Then Form1.ListBox1.ItemIndex:=OverItemIndex;
          If OverItemIndex > -1 Then Clipboard.AsText := Form1.ListBox1.Items[OverItemIndex];
     end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
Var
   word1, word2, word3 : String;
   txhz, srxp, ss, foo : String;
   wcount, irxp, itxp  : Integer;
   itxhz, idx          : Integer;
   resolved, doQSO     : Boolean;
   entTXCF, entRXCF    : Integer;
   isiglevel           : Integer;
begin
     if itemsIn and config1.canTX Then
     Begin
          If Form1.chkMultiDecode.Checked Then
          Begin
               entTXCF := Form1.spinTXCF.Value;
               entRXCF := Form1.spinDecoderCF.Value;
          End;

          idx := Form1.ListBox1.ItemIndex;
          if idx > -1 Then
          Begin
               // On a double click I need to figure out the form of the message text..
               // CQ CALL GRID, SOMECALL MYCALL SOMEGRID, SOMECALL MYCALL SOMEREPORT,
               // SOMECALL SOMECALL SOMETEXT, SOMETEXT.  Dependingn upon the form I will
               // setup a specific exchange.
               //
               // Need to determine which line clicked and generate appropriate TX msg for it
               // First thing to do is try to determine what message to generate... in general
               // this would be an answer to a CQ or a reply to a station answering my CQ.
               // I can look to see if the double clicked exchange is a CQ CALLSIGN GRID as
               // a hint, then suggest the proper response.  No matter what I think the proper
               // response is I need to at least fill in the Remote callsign and grid fields
               // or just a callsign if no grid available.  I'll start with that.

               resolved := False;
               doQSO    := False;
               wcount   := 0;
               itxhz    := 0;

               exchange := Form1.ListBox1.Items[idx];
               txMode := 65;

               exchange := exchange[28..Length(exchange)];
               exchange := TrimLeft(TrimRight(exchange));
               exchange := DelSpace1(exchange);

               siglevel := Form1.ListBox1.Items[idx];
               siglevel := siglevel[10..12];
               siglevel := TrimLeft(TrimRight(siglevel));

               isiglevel := -30;
               if not tryStrToInt(siglevel,isiglevel) Then
               Begin
                    isiglevel := -25;
                    siglevel := '-25';
               End
               Else
               Begin
                    if isiglevel > -1 Then
                    Begin
                         isiglevel := -1;
                         siglevel := '-1';
                    End;
               End;
               if (isiglevel > -10) and (isiglevel < 0) Then
               Begin
                    foo := '-0';
                    siglevel := IntToStr(isiglevel);
                    foo := foo + siglevel[2];
                    siglevel := foo;
               end;
               txhz := Form1.ListBox1.Items[idx];
               txhz := txhz[19..23];
               txhz := TrimLeft(TrimRight(txhz));
               txhz := DelSpace1(txhz);

               //wcount := WordCount(exchange,parseCallSign.WordDelimiter);
               if wcount = 3 Then
               Begin
                    // Since I have three words I can potentially work with this...
                    //word1 := ExtractWord(1,exchange,parseCallSign.WordDelimiter);
                    //word2 := ExtractWord(2,exchange,parseCallSign.WordDelimiter);
                    //word3 := ExtractWord(3,exchange,parseCallSign.WordDelimiter);
                    If (word1 = 'CQ') Or (word1 = 'QRZ') Or (word1 = 'CQDX') Then
                    Begin
                         If word2 = 'DX' Then
                         Begin
                              If length(word3)> 2 Then
                              begin
                                   //if parseCallSign.validateCallsign(word3) Then Form1.edHisCall.Text := word3 Else Form1.edHisCall.Text := '';
                                   Form1.edHisGrid.Text := '';
                                   resolved := True;
                                   answeringCQ := True;
                                   doQSO := True;
                                   //msgToSend := word3 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
                                   doCWID := False;
                              end;
                         end
                         else
                         begin
                              if length(word2)>2 Then
                              Begin
                                   //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                              end
                              else
                              begin
                                   Form1.edHisCall.Text := '';
                              end;
                              if length(word3)>3 Then
                              Begin
                                   //If parseCallSign.isGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                              end
                              else
                              begin
                                   Form1.edHisGrid.Text := '';
                              end;
                              resolved    := True;
                              answeringCQ := True;
                              doQSO       := True;
                              //msgToSend   := word2 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
                              doCWID := False;
                         end;
                    End
                    Else
                    Begin
                         If word1 = globalData.fullcall Then
                         Begin
                              // Seems to be a call to me.
                              // word3 could/should be as follows...
                              // Grid, signal report, R signal report, an RRR or a 73
                              resolved := False;
                              //if parseCallSign.isGrid(word3) And not resolved Then
                              //Begin
                              //     // This seems to be a callsign calling me with a grid
                              //     // The usual response would be a signal report back
                              //     If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                              //     If parseCallSign.isGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                              //     resolved    := True;
                              //     answeringCQ := False;
                              //     doQSO       := True;
                              //     msgToSend := word2 + ' ' + globalData.fullcall + ' ' + siglevel;
                              //     doCWID := False;
                              //End;
                              if (word3[1] = '-') And not resolved Then
                              Begin
                                   // This seems an -## signal report
                                   // The usual response would be an R-##
                                   //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + globalData.fullcall + ' R' + siglevel;
                                   doCWID := False;
                              End;
                              if (word3[1..2] = 'R-') And not resolved Then
                              Begin
                                   // This seems an R-## response to my report
                                   // The usual response would be an RRR
                                   //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + globalData.fullcall + ' RRR';
                                   doCWID := False;
                              End;
                              if (word3 = 'RRR') And not resolved Then
                              Begin
                                   // This is an ack.  The usual response would be 73
                                   //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + globalData.fullcall + ' 73';
                                   //if cfgvtwo.Form6.cbCWID.Checked Then doCWID := True else doCWID := False;
                              End;
                              if (word3 = '73') And not resolved Then
                              Begin
                                   // The usual response to a 73 is a 73
                                   //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + globalData.fullcall + ' 73';
                                   //if cfgvtwo.Form6.cbCWID.Checked Then doCWID := True else doCWID := False;
                              End;
                         End
                         Else
                         Begin
                              // A call to someone else, lets not break into that, but prep to tail in once the existing QSO is complete.
                              //If parseCallSign.validateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                              //If parseCallSign.isGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                              If Length(Form1.edHisCall.Text)>1 Then
                              Begin
                                   resolved    := True;
                                   answeringCQ := False;
                                   doQSO       := False;
                                   //msgToSend   := word2 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
                                   doCWID := False;
                              End;
                         End;
                    End;
               End;

               if wcount = 2 Then
               Begin
                    // CQ W6CQZ/4, QRZ W6CQZ/4, SOMECALL W6CQZ/4, W6CQZ/4 -22, W6CQZ/4 R-22, W6CQZ/4 73
                    // OK... The first three forms are of use.  SOMECALL/SOMESUFFIX Calling CQ, QRZ or
                    // another call.  The last 3 are not of use at all... those don't show the callsign
                    // of the TX station.
                    //word1 := ExtractWord(1,exchange,parseCallSign.WordDelimiter);
                    //word2 := ExtractWord(2,exchange,parseCallSign.WordDelimiter);
                    If (word1='QRZ') or (word1='CQ') Then
                    Begin
                         //If parseCallSign.validateCallsign(word2) Then
                         //Begin
                         //     Form1.edHisCall.Text := word2;
                         //     Form1.edHisGrid.Text := '';
                         //     msgToSend := word2 + ' ' + globalData.fullcall;
                         //     resolved := True;
                         //     doQSO       := True;
                         //     answeringCQ := True;
                         //     doCWID := False;
                         //end
                         //else
                         //begin
                         //     resolved := False;
                         //     exchange := '';
                         //end;
                    End
                    Else
                    Begin
                         exchange := '';
                         resolved := False;
                    End;
                    // Now looking for my callsign with -##, R-##, RRR or 73
                    if not resolved then
                    Begin
                         If word1=globalData.fullCall Then
                         Begin
                              //If parseCallSign.validateCallsign(word2) Then
                              //Begin
                              //     Form1.edHisCall.Text := word2;
                              //     msgToSend := word2 + ' ' + siglevel;
                              //     resolved := True;
                              //     doCWID := False;
                              //End
                              //Else
                              //Begin
                              //     resolved := False;
                              //End;
                              if not resolved then
                              Begin
                                   if word2 = 'RRR'Then
                                   Begin
                                        msgToSend := edHisCall.Text + ' 73';
                                        Resolved := True;
                                        doQSO       := True;
                                        //if cfgvtwo.Form6.cbCWID.Checked then doCWID := True else doCWID := False;
                                   End
                                   Else
                                   Begin
                                        resolved := False;
                                   End;
                              End;
                              if not resolved Then
                              Begin
                                   if word2[1] = '-' Then
                                   Begin
                                        msgToSend := edHisCall.Text + ' R' + siglevel;
                                        resolved := True;
                                        doQSO       := True;
                                        doCWID := False;
                                   End
                                   Else
                                   Begin
                                        resolved := False;
                                   End;
                              End;
                              If not resolved Then
                              Begin
                                   if word2[1..2] = 'R-' Then
                                   Begin
                                        msgToSend := edHisCall.Text + ' RRR';
                                        resolved := True;
                                        doQSO       := True;
                                        doCWID := False;
                                   End
                                   Else
                                   Begin
                                        resolved := False;
                                   End;
                              End;
                         End
                         Else
                         Begin
                              resolved := False;
                         End;
                    End;
               End;

               If (wcount < 2) Or (wcount > 3) Then
               Begin
                    exchange := '';
                    resolved := False;
               End;

               If resolved Then
               Begin
                    form1.edSigRep.Text := siglevel;
                    if TryStrToInt(txhz, itxhz) Then
                    Begin
                         itxhz := StrToInt(txhz);
                         if form1.chkAutoTxDF.Checked then form1.spinTXCF.Value := itxhz;
                         form1.spinDecoderCF.value := itxhz;
                    End;
                    srxp := Form1.ListBox1.Items[idx];
                    srxp := srxp[1..5];
                    srxp := TrimLeft(TrimRight(srxp));
                    srxp := DelSpace1(srxp);
                    srxp := srxp[4..5];
                    irxp := StrToInt(srxp);
                    itxp := irxp+1;
                    if itxp = 60 Then itxp := 0;
                    if Odd(itxp) Then
                    Begin
                         Form1.rbTX1.Checked := False;
                         Form1.rbTX2.Checked := True;
                    End
                    Else
                    Begin
                         Form1.rbTX2.Checked := False;
                         Form1.rbTX1.Checked := True;
                    End;
                    form1.edMsg.Text := msgToSend;
                    if doQSO Then
                    Begin
                         watchMulti := False;
                         //if cfgvtwo.Form6.cbDisableMultiQSO.Checked And Form1.chkMultiDecode.Checked Then
                         //Begin
                         //     preTXCF := entTXCF;
                         //     preRXCF := entRXCF;
                         //     if Form1.chkMultiDecode.Checked Then Form1.chkMultiDecode.Checked := False;
                         //     rxCount := 0;
                         //     if cfgvtwo.Form6.cbMultiAutoEnable.Checked Then watchMulti := True else watchMulti := False;
                         //End;
                         Form1.chkEnTX.Checked := True;
                         Form1.rbGenMsg.Checked := True;
                         Form1.rbGenMsg.Font.Color := clRed;
                         Form1.rbFreeMsg.Font.Color  := clBlack;
                         useBuffer := 0;
                         ss := '';
                         if gst.Hour < 10 Then ss := '0' + IntToStr(gst.Hour) else ss := ss + IntToStr(gst.Hour);
                         if gst.Minute < 10 Then ss := ss + '0' + IntToStr(gst.Minute) else ss := ss + IntToStr(gst.Minute);
                         qsoSTime := ss;
                         ss := '';
                         ss := IntToStr(gst.Year);
                         if gst.Month < 10 Then ss := ss + '0' + IntToStr(gst.Month) else ss := ss + IntToStr(gst.Month);
                         if gst.Day < 10 Then ss := ss + '0' + IntToStr(gst.Day) else ss := ss + IntToStr(gst.Day);
                         qsoSDate := ss;
                    End;
               End;
          End;
     end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
Var
   myColor            : TColor;
   myBrush            : TBrush;
   lineCQ, lineMyCall : Boolean;
   lineErr            : Boolean;
   foo                : String;
begin
     lineCQ := False;
     lineMyCall := False;
     lineErr := False;
     if Index > -1 Then
     Begin
          foo := Form1.ListBox1.Items[Index];
          //if IsWordPresent('ERROR:', foo, parseCallsign.WordDelimiter) Then lineErr := True;
          //if IsWordPresent('CQ', foo, parseCallSign.WordDelimiter) Then lineCQ := True;
          //if IsWordPresent('QRZ', foo, parseCallSign.WordDelimiter) Then lineCQ := True;
          //if IsWordPresent(globalData.fullcall, foo, parseCallsign.WordDelimiter) Then lineMyCall := True;
          myBrush := TBrush.Create;
          with (Control as TListBox).Canvas do
          begin
               //myColor := cfgvtwo.glqsoColor;
               //if lineCQ Then myColor := cfgvtwo.glcqColor;
               //if lineMyCall Then myColor := cfgvtwo.glcallColor;
               if lineErr Then myColor := clRed;
               myBrush.Style := bsSolid;
               myBrush.Color := myColor;
               Windows.FillRect(handle, ARect, myBrush.Reference.Handle);
               Brush.Style := bsClear;
               TextOut(ARect.Left, ARect.Top,(Control as TListBox).Items[Index]);
               MyBrush.Free;
          end;
     end;
end;

procedure TForm1.rbFirstChange(Sender: TObject);
begin
     If Form1.rbTX1.Checked Then
     Begin
          txPeriod := 0;
          Form1.rbTX1.Font.Color := clRed;
          Form1.rbTX2.Font.Color := clBlack;
     End;
     If Form1.rbTX2.Checked Then
     Begin
          txPeriod := 1;
          Form1.rbTX2.Font.Color := clRed;
          Form1.rbTX1.Font.Color := clBlack;
     End;
     if nextAction = 3 Then nextAction := 2;
end;

procedure TForm1.rbUseMixChange(Sender: TObject);
begin
  //If Form1.rbUseLeft.Checked Then adc.adcChan  := 1;
  //If Form1.rbUseRight.Checked Then adc.adcChan := 2;
end;


procedure TForm1.spinDecoderCFChange(Sender: TObject);
begin
     If spinDecoderCF.Value < -1000 then spinDecoderCF.Value := -1000;
     If spinDecoderCF.Value > 1000 then spinDecoderCF.Value := 1000;
     if form1.chkAutoTxDF.Checked Then
     Begin
          form1.spinTXCF.Value := form1.spinDecoderCF.Value;
     End;
end;

procedure TForm1.spinTXCFChange(Sender: TObject);
begin
     if spinTXCF.Value < -1000 then spinTXCF.Value := -1000;
     if spinTXCF.Value > 1000 then spinTXCF.Value := 1000;
     if form1.chkAutoTxDF.Checked Then
     Begin
          form1.spinDecoderCF.Value := form1.spinTXCF.Value;
     End;
end;

procedure TForm1.tbBrightChange(Sender: TObject);
begin
     spectrum.specGain := Form1.tbBright.Position;
end;

procedure TForm1.tbContrastChange(Sender: TObject);
begin
     spectrum.specContrast := Form1.tbContrast.Position;
end;

procedure TForm1.btnZeroTXClick(Sender: TObject);
begin
     Form1.spinTXCF.Value := 0;
     if form1.chkAutoTxDF.Checked Then form1.spinDecoderCF.Value := 0;
end;

procedure TForm1.btnLogQSOClick(Sender: TObject);
var
   ss   : String;
   fqrg : Double;
   sqrg : String;
begin
     log.Form2.edLogCall.Text := edHisCall.Text;
     log.Form2.edLogGrid.Text := edHisGrid.Text;
     log.Form2.edLogDate.Text := qsoSDate;
     log.Form2.edLogSTime.Text := qsoSTime;
     ss := '';
     if gst.Hour < 10 Then ss := ss + '0' + IntToStr(gst.hour) else ss := ss + IntToStr(gst.hour);
     if gst.Minute < 10 then ss := ss + '0' + IntToStr(gst.Minute) else ss := ss + IntToStr(gst.Minute);
     qsoETime := ss;
     log.Form2.edLogETime.Text := qsoETime;
     log.Form2.edLogSReport.Text := edSigRep.Text;
     fqrg := 0.0;
     sqrg := '0';
     //fqrg := StrToFloat(cfgvtwo.Form6.rigQRG.Text);
     fqrg := fqrg/1000000;
     sqrg := FloatToStr(fqrg);
     log.Form2.edLogFrequency.Text := sqrg;
     log.logmycall := globalData.fullcall;
     //log.logmygrid := cfgvtwo.Form6.edMyGrid.Text;
     log.Form2.Visible := True;
     log.Form2.Show;
     log.Form2.BringToFront;
end;

procedure TForm1.btnReDecodeClick(Sender: TObject);
Var
   proceed : Boolean;
   i       : Integer;
   sr      : CTypes.cdouble;
begin
     proceed := False;
     if haveOddBuffer Then
     Begin
          proceed := True;
     End;
     if haveEvenBuffer Then
     Begin
          proceed := True;
     End;
     if proceed Then
     Begin
          if not d65.glinprog Then
          Begin
               //if cfgvtwo.Form6.chkNoOptFFT.Checked Then
               //Begin
               //     d65.glfftFWisdom := 0;
               //     d65.glfftSWisdom := 0;
               //End;
               bStart := 0;
               bEnd := 533504;
               for i := bStart to bEnd do
               Begin
                    //if haveOddBuffer then d65.glinBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]))
               end;
               d65.gld65timestamp := '';
               d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Year);
               if ost.Month < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Month) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Month);
               if ost.Day < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Day) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Day);
               if ost.Hour < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Hour) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Hour);
               if ost.Minute < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Minute) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Minute);
               d65.gld65timestamp := d65.gld65timestamp + '00';
               sr := 1.0;
               //if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
               d65samfacout := 1.0;
               d65.glMouseDF := Form1.spinDecoderCF.Value;
               if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
               if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
               if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
               if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
               if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
               if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;
               if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
               if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;
               d65.glbinspace := 100;
               If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
               d65.glNshift := 0;
               if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
               d65.glNzap := 0;
               d65.gldecoderPass := 0;
               if form1.chkMultiDecode.Checked Then d65.glsteps := 1 else d65.glsteps := 0;
               reDecode := True;
               d65doDecodePass := True;
          End;
     End;
end;

procedure TForm1.btnZeroRXClick(Sender: TObject);
begin
     Form1.spinDecoderCF.Value := 0;
     if form1.chkAutoTxDF.Checked Then
     Begin
          form1.spinTXCF.Value := 0;
     End;
end;

function TForm1.isSigRep(rep : String) : Boolean;
Begin
     Result := False;
     if TrimLeft(TrimRight(rep))[1..2] = 'R-' Then
     begin
          Result := True;
     end;
     if TrimLeft(TrimRight(rep))[1] = '-' Then
     begin
          Result := True;
     end;
end;

procedure TForm1.addToDisplayTX(exchange : String);
Var
   st  : TSystemTime;
   foo : String;
   rpt : String;
   idx : Integer;
Begin
     st := utcTime();
     foo := '';
     if st.Hour < 10 Then foo := '0' + IntToStr(st.Hour) + ':' else foo := IntToStr(st.Hour) + ':';
     if st.Minute < 10 then foo := foo + '0' + IntToStr(st.Minute) else foo := foo + IntToStr(st.Minute);
     rpt := foo + '  TX ' + exchange;
     If firstReport Then
     Begin
          rawdec.Form5.ListBox1.Clear;
          rawdec.Form5.ListBox1.Items.Add(rpt);
          firstReport := False;
          itemsIn := True;
     End
     Else
     Begin
          rawdec.Form5.ListBox1.Items.Add(rpt);
          itemsIn := True;
     End;
     // Manage size of scrollback
     If Form1.ListBox1.Items.Count > 500 Then
     Begin
          for idx := ListBox1.Items.Count - 1 downto 100 do
          Begin
              ListBox1.Items.Delete(idx);
          end;
     End;
end;

procedure TForm1.addToDisplay(i, m : Integer);
Var
   foo, rpt     : String;
   csvstr       : String;
   wcount       : Integer;
   word1, word2 : String;
   word3        : String;
   lstrQRG       : String;
   idx, ii      : Integer;
   tmpdouble1   : Double;
   tmpdouble2   : Double;
   mode         : String;
Begin
     if globalData.gmode = 65 Then mode := 'JT65A';
     if globalData.gmode =  4 Then mode := 'JT4B';
     csvstr := '';
     rpt := '';
     //                     YYYYMMDDHHMMSS
     // dtTimestamp is like 20100113165400
     //                     12345678911111
     //                              01234
     // For log... csvstring is;
     // "Date","Time","QRG","Sync","DB","DT","DF","Decoder","Exchange";
     if m = 65 Then
     Begin
          foo := d65.gld65decodes[i].dtTimeStamp;
          // UTC
          rpt := foo[9..10] + ':' + foo[11..12] + ' ';
          csvstr := csvstr + '"' + foo[1..4] + '-' + foo[5..6] + '-' + foo[7..8] + '"' + ',';
          csvstr := csvstr + '"' + foo[9..10] + ':' + foo[11..12] + '"' + ',';
          // QRG
          csvstr := csvstr + '"' + FloatToStr(globalData.gqrg) + '"' + ',';
          // Sync
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtNumSync))) = 1 Then rpt := rpt + ' ' + d65.gld65decodes[i].dtNumSync + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtNumSync))) = 2 Then rpt := rpt + d65.gld65decodes[i].dtNumSync + ' ';
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtNumSync + '"' + ',';
          // dB
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtSigLevel))) = 1 Then rpt := rpt + '  ' + d65.gld65decodes[i].dtSigLevel + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtSigLevel))) = 2 Then rpt := rpt + ' ' + d65.gld65decodes[i].dtSigLevel + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtSigLevel))) = 3 Then rpt := rpt + d65.gld65decodes[i].dtSigLevel + ' ';
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtSigLevel + '"' + ',';
          // DT
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaTime))) = 3 Then rpt := rpt + ' ' + d65.gld65decodes[i].dtDeltaTime + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaTime))) = 4 Then rpt := rpt + d65.gld65decodes[i].dtDeltaTime + ' ';
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtDeltaTime + '"' + ',';
          // DF
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq))) = 5 Then rpt := rpt + d65.gld65decodes[i].dtDeltaFreq + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq))) = 4 Then rpt := rpt + ' ' + d65.gld65decodes[i].dtDeltaFreq + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq))) = 3 Then rpt := rpt + '  ' + d65.gld65decodes[i].dtDeltaFreq + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq))) = 2 Then rpt := rpt + '   ' + d65.gld65decodes[i].dtDeltaFreq + ' ';
          if Length(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq))) = 1 Then rpt := rpt + '    ' + d65.gld65decodes[i].dtDeltaFreq + ' ';
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtDeltaFreq + '"' + ',';
          rpt := rpt + ' ' + d65.gld65decodes[i].dtType + ' ';
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtType + '"' + ',';
          // Exchange
          rpt := rpt + TrimLeft(TrimRight(d65.gld65decodes[i].dtDecoded));
          csvstr := csvstr + '"' + d65.gld65decodes[i].dtDecoded + '","65A"';
          // csvstr now contains a possible report to file if user wishes.
          // Do actual display
          If firstReport Then
          Begin
               Form1.ListBox1.Items.Strings[0] := rpt;
               firstReport := False;
               itemsIn := True;
          End
          Else
          Begin
               Form1.ListBox1.Items.Insert(0,rpt);
               itemsIn := True;
          End;
          // Manage size of scrollback
          If Form1.ListBox1.Items.Count > 500 Then
          Begin
               for idx := ListBox1.Items.Count - 1 downto 100 do
               Begin
                    ListBox1.Items.Delete(idx);
               end;
          End;
          d65.gld65decodes[i].dtDisplayed := True;
          d65.gld65decodes[i].dtProcessed := True;
          // Save to RX/TX log if user has selected such.
          //if cfgvtwo.Form6.cbSaveCSV.Checked Then
          //Begin
          //     for ii := 0 to 99 do
          //     begin
          //          if csvEntries[ii] = '' Then
          //          begin
          //               csvEntries[ii] := csvstr;
          //               break;
          //          end;
          //     end;
          //     form1.saveCSV();
          //end;
          // Trying to find a signal report value
          wcount := 0;
          //wcount := WordCount(d65.gld65decodes[i].dtDecoded,parseCallSign.WordDelimiter);
          if wcount = 3 Then
          Begin
               //word1 := ExtractWord(1,d65.gld65decodes[i].dtDecoded,parseCallSign.WordDelimiter); // CQ or a call sign
               //word2 := ExtractWord(2,d65.gld65decodes[i].dtDecoded,parseCallSign.WordDelimiter); // call sign
               //word3 := ExtractWord(3,d65.gld65decodes[i].dtDecoded,parseCallSign.WordDelimiter); // could be grid or report.
          End
          Else
          Begin
               word1 := '';
               word2 := '';
               word3 := '';
          end;
          If wcount > 1 Then
          Begin
               if (Length(word1)> 2) And (Length(word3)>2) Then
               Begin
                    if (word1 = globalData.fullcall) And isSigRep(word3) Then
                    Begin
                         if TrimLeft(TrimRight(word3))[1] = 'R' Then log.Form2.edLogRReport.Text := TrimLeft(TrimRight(word3))[2..4];
                         if TrimLeft(TrimRight(word3))[1] = '-' Then log.Form2.edLogRReport.Text := TrimLeft(TrimRight(word3))[1..3];
                    end;
               end;
          end;
          // Process for PSKReporter if enabled.
          //if not (sopQRG=eopQRG) and cfgvtwo.Form6.cbUsePSKReporter.Checked Then dlog.fileDebug('End of sequence QRG not same as start QRG. Report discarded.');
 //        If (wcount > 1) And cfgvtwo.Form6.cbUsePSKReporter.Checked And (sopQRG=eopQRG) And not reDecode Then
 //         Begin
 //              if (length(word1)>1) And (length(word2)>2) Then
 //              Begin
 //                   tmpDouble1 := -1.0;
 //                   tmpDouble2 := 0;
 //                   if sopQRG > 0.0 Then
 //                   Begin
 //                        tmpDouble1 := sopQRG;
 //                        if tryStrToFloat(TrimLeft(TrimRight(d65.gld65decodes[i].dtDeltaFreq)),tmpDouble2) Then tmpDouble1 := tmpDouble1 + tmpDouble2;
 //                   End;
 //                   if tmpDouble1 > 0 Then lstrQRG := FloatToStr(tmpDouble1) Else lstrQRG := '0';
 //                   If (word1 = 'CQ') or (word1 = 'cq') or (word1 = 'QRZ') or (word1 = 'qrz') or (word1 = 'TEST') or (word1 = 'test') Then
 //                   Begin
 //                        If parseCallSign.validateCallsign(word2) Then
 //                        Begin
 //                             // Seems to be a valid call calling CQ.  Word2=Call sign.
 //                             // dtTimestamp is like 20100113165400
 //                             // d65.gld65decodes[i].dtTimeStamp;
 //                             if length(word3)=4 Then
 //                             Begin
 //                                  if parseCallSign.isGrid(word3) Then
 //                                  PSKReporter.ReporterSeenCallsign(BuildRemoteStringGrid(word2,mode,lstrQRG,word3,
 //                                                                   d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                   d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                   BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                   cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                   cfgvtwo.Form6.editPSKRAntenna.Text),
 //                                                                   PSKReporter.REPORTER_SOURCE_AUTOMATIC)
 //                                  else
 //                                  PSKReporter.ReporterSeenCallsign(BuildRemoteString(word2,mode,lstrQRG,d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                   d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                   BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                   cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                   cfgvtwo.Form6.editPSKRAntenna.Text),PSKReporter.REPORTER_SOURCE_AUTOMATIC);
 //                                  end
 //                             else
 //                             begin
 //                                  PSKReporter.ReporterSeenCallsign(BuildRemoteString(word2,mode,lstrQRG,d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                                     d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                                     BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                                     cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                                     cfgvtwo.Form6.editPSKRAntenna.Text),PSKReporter.REPORTER_SOURCE_AUTOMATIC);
 //                             end;
 //                        End;
 //                   End
 //                   Else
 //                   Begin
 //                        If (Length(word1)>2) And (Length(word2)>2) Then
 //                        Begin
 //                             If (parseCallSign.validateCallsign(word1)) And (parseCallSign.validateCallsign(word2)) Then
 //                             Begin
 //                                  // Seems to be a valid call working a valid call.  Word2= TX Call sign.
 //                                  if Length(Word3)=4 Then
 //                                  Begin
 //                                       if parseCallsign.isGrid(word3) Then
 //                                       PSKReporter.ReporterSeenCallsign(BuildRemoteStringGrid(word2,mode,lstrQRG,word3,
 //                                                                                              d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                                              d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                                              BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                                              cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                                              cfgvtwo.Form6.editPSKRAntenna.Text),
 //                                                                                              PSKReporter.REPORTER_SOURCE_AUTOMATIC)
 //                                       else
 //                                       PSKReporter.ReporterSeenCallsign(BuildRemoteString(word2,mode,lstrQRG,d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                                          d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                                          BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                                          cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                                          cfgvtwo.Form6.editPSKRAntenna.Text),
 //                                                                                          PSKReporter.REPORTER_SOURCE_AUTOMATIC);
 //                                  end
 //                                  else
 //                                  begin
 //                                       PSKReporter.ReporterSeenCallsign(BuildRemoteString(word2,mode,lstrQRG,d65.gld65decodes[i].dtTimeStamp[1..8],
 //                                                                                          d65.gld65decodes[i].dtTimeStamp[9..12]),
 //                                                                                          BuildLocalString(cfgvtwo.Form6.editPSKRCall.Text,
 //                                                                                          cfgvtwo.Form6.edMyGrid.Text,'JT65-HF',verHolder.verReturn(),
 //                                                                                          cfgvtwo.Form6.editPSKRAntenna.Text),
 //                                                                                          PSKReporter.REPORTER_SOURCE_AUTOMATIC);
 //                                  end;
 //                             End;
 //                        End;
 //                   End;
 //              End;
 //         end;
     end;
End;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  // Handle change to Digital Gain
  //adc.adcLDgain := Form1.TrackBar1.Position;
  //madc.adcLDgain := Form1.TrackBar1.Position;
  Form1.Label10.Caption := 'L: ' + IntToStr(Form1.TrackBar1.Position);
  If Form1.TrackBar1.Position <> 0 Then Form1.Label10.Font.Color := clRed else Form1.Label10.Font.Color := clBlack;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  //adc.adcRDgain := Form1.TrackBar2.Position;
  //madc.adcRDgain := Form1.TrackBar2.Position;
  Form1.Label11.Caption := 'R: ' + IntToStr(Form1.TrackBar2.Position);
  If Form1.TrackBar2.Position <> 0 Then Form1.Label11.Font.Color := clRed else Form1.Label11.Font.Color := clBlack;
end;

procedure TForm1.updateAudio();
Var
   i, ii, txHpix     : Integer;
   cfPix, lPix, hPix : Integer;
   floatVar          : Single;
   loBound, hiBound  : Double;
   lowF, hiF         : Double;
Begin
     // Create header for spectrum display
     Form1.PaintBox1.Canvas.Brush.Color := clWhite;
     Form1.PaintBox1.Canvas.Brush.Style := bsSolid;
     Form1.PaintBox1.Canvas.FillRect(0,0,749,11);
     Form1.PaintBox1.Canvas.Pen.Color := clBlack;
     Form1.PaintBox1.Canvas.Pen.Width := 1;
     Form1.PaintBox1.Canvas.MoveTo(0,0);
     Form1.PaintBox1.Canvas.Line(0,0,749,0);
     Form1.PaintBox1.Canvas.Line(0,11,749,11);
     Form1.PaintBox1.Canvas.Line(0,0,0,11);
     Form1.PaintBox1.Canvas.Line(749,0,749,11);
     // Paint 100hz tick marks.  This scales 0 to be at pixel 376, -1000 at 6
     // and +1000 at 746.
     Form1.PaintBox1.Canvas.Pen.Color := clBlack;
     Form1.PaintBox1.Canvas.Pen.Width := 3;
     ii := 6;
     For i := 1 To 21 do
     Begin
          Form1.PaintBox1.Canvas.Line(ii,1,ii,6);
          ii := ii+37;
     End;
     // I now need to paint the RX and TX passbands.
     // Have to change this to reflect that I can now have a different TX postion from RX position.
     If form1.chkMultiDecode.Checked Then
     Begin
          // Multi-decode is checked so I need to compute the markers for multi
          loBound := -1000;
          hiBound := 1000;
          // Now that I have a center, low and high points I can convert those to
          // relative pixel position for the spectrum display.  0 df = 376 and 1
          // pixel ~ 2.7027 hz.
          lowF := loBound/2.7027;
          hiF := hiBound/2.7027;
          lowF := 376+lowF;
          hiF := 376+hiF;
          cfPix := 376;
          hPix := Round(hiF);
          lPix := Round(lowF);
          if lPix < 1 Then lPix := 1;
          if hPix > 751 Then hPix := 751;
          Form1.PaintBox1.Canvas.Pen.Width := 3;
          Form1.PaintBox1.Canvas.Pen.Color := clLime;
          // Paint the RX passband, horizontal lime green line.
          //Form1.PaintBox1.Canvas.Line(lPix,9,hPix,9);
          //Form1.PaintBox1.Canvas.Line(lPix,1,lPix,9);
          //Form1.PaintBox1.Canvas.Line(hPix,1,hPix,9);
          // Paint 'bins'
          // Bins define segments decoder will evaluate for a decode using a
          // bandwidth of 20, 40, 80 or 160 Hz (+/- 10, +/- 20 etc) from a
          // center point starting at -1000 Hz.  Spacing is defined in d65.glbinspace
          Form1.PaintBox1.Canvas.Pen.Width := 3;
          Form1.PaintBox1.Canvas.Pen.Color := clTeal;
          lobound := -1000 - (d65.glbinspace div 2);
          hibound := -1000 + (d65.glbinspace div 2);
          hiF := 0;
          lowF := 0;
          while hiBound < 1001 do
          Begin
               // Compute markers
               lowF := loBound/2.7027;
               hiF := (loBound+d65.glbinspace)/2.7027;
               lowF := 376+lowF;
               hiF := 376+hiF;
               lPix := Round(lowF);
               hPix := Round(hiF);
               if (lPix > 0) And (hPix < 752) Then
               Begin
                    Form1.PaintBox1.Canvas.Line(lPix,8,lPix,10);
                    Form1.PaintBox1.Canvas.Line(hPix,8,hPix,10);
               End;
               loBound := loBound + d65.glbinspace;
               hiBound := hiBound + d65.glbinspace;
          End;

          If form1.chkAutoTxDF.Checked Then
          Begin
               // Paint the TX passband, vertical red lines.
               If form1.spinDecoderCF.Value <> 0 Then
               Begin
                    floatVar := form1.spinDecoderCF.Value / 2.7027;
                    floatVar := 376+floatVar;
                    cfPix := Round(floatVar);
                    txHpix := Round(floatVar+66.7);
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End
               Else
               Begin
                    // CF = 0hz so CF marker is at pixel 376
                    cfPix := 376;
                    txHpix := 376+67;
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End;
          End
          Else
          Begin
               // Paint the TX passband, vertical red lines.
               If form1.spinTXCF.Value <> 0 Then
               Begin
                    floatVar := form1.spinTXCF.Value / 2.7027;
                    floatVar := 376+floatVar;
                    cfPix := Round(floatVar);
                    txHpix := Round(floatVar+66.7);
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End
               Else
               Begin
                    // TXCF = 0hz so CF marker is at pixel 376
                    cfPix := 376;
                    txHpix := 376+67;
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End;
          End;
     End
     Else
     Begin
          // Single decode set.  The passband for single is centered on
          // Form1.spinDecoderCF.Value going Form1.spinDecoderBW.Value
          // above and below CF.
          // At 37 pixels per 100 hz 1 pixel = 2.7027 hz...
          // Display is 2000 hz wide, -1000 at pixel 1, 0 at pixel 376 and
          // +1000 at pixel 746
          loBound := form1.spinDecoderCF.Value - (StrToInt(Form1.Edit2.Text));
          hiBound := form1.spinDecoderCF.Value + (StrToInt(Form1.Edit2.Text));
          // Now that I have a center, low and high points I can convert those to
          // relative pixel position for the spectrum display.  0 df = 376 and 1
          // pixel ~ 2.7027 hz.
          lowF := loBound/2.7027;
          hiF := hiBound/2.7027;
          lowF := 376+lowF;
          hiF := 376+hiF;
          cfPix := 376;
          hPix := Round(hiF);
          lPix := Round(lowF);
          if lPix < 1 Then lPix := 1;
          if hPix > 751 Then hPix := 751;
          // Paint the RX passband, horizontal lime green line.
          Form1.PaintBox1.Canvas.Pen.Width := 3;
          Form1.PaintBox1.Canvas.Pen.Color := clLime;
          Form1.PaintBox1.Canvas.Line(lPix,9,hPix,9);
          Form1.PaintBox1.Canvas.Line(lPix,1,lPix,9);
          Form1.PaintBox1.Canvas.Line(hPix,1,hPix,9);
          If form1.chkAutoTxDF.Checked Then
          Begin
               If form1.spinDecoderCF.Value <> 0 Then
               Begin
                    floatVar := form1.spinDecoderCF.Value / 2.7027;
                    floatVar := 376+floatVar;
                    cfPix := Round(floatVar);
                    txHpix := Round(floatVar+66.7);
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,9);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,9);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End
               Else
               Begin
                    // CF = 0hz so CF marker is at pixel 376
                    cfPix := 376;
                    txHpix := 376+67;
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,9);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,9);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End;
          End
          Else
          Begin
               // Paint the TX passband, vertical red lines.
               If form1.spinTXCF.Value <> 0 Then
               Begin
                    floatVar := form1.spinTXCF.Value / 2.7027;
                    floatVar := 376+floatVar;
                    cfPix := Round(floatVar);
                    txHpix := Round(floatVar+66.7);
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End
               Else
               Begin
                    // TXCF = 0hz so CF marker is at pixel 376
                    cfPix := 376;
                    txHpix := 376+67;
                    Form1.PaintBox1.Canvas.Pen.Color := clRed;
                    Form1.PaintBox1.Canvas.Pen.Width := 3;
                    Form1.PaintBox1.Canvas.Line(cfPix,1,cfPix,7);
                    Form1.PaintBox1.Canvas.Line(txHpix,1,txHpix,7);
                    Form1.PaintBox1.Canvas.Line(cfPix,1,txHpix,1);
               End;
          End;
     End;
     //if audioAve1 > 0 Then audioAve1 := (audioAve1+adc.specLevel1) DIV 2 else audioAve1 := adc.specLevel1;
     //if audioAve2 > 0 Then audioAve2 := (audioAve1+adc.specLevel2) DIV 2 else audioAve2 := adc.specLevel2;
End;

procedure TForm1.displayAudio(audioAveL : Integer; audioAveR : Integer);
Begin
     // Mark current audio level
     // sLevel = 50 = 0dB sLevel 0 = -20dB sLevel 100 = 20dB
     // 1 sLevel = .4dB
     // db = (sLevel*0.4)-20
     // No warning range -10 .. +10 dB or 25 .. 75 sLevel
     Form1.pbAu1.Position := audioAveL;
     Form1.pbAu2.Position := audioAveR;
     //cfgvtwo.Form6.pbAULeft.Position := audioAveL;
     //cfgvtwo.Form6.pbAURight.Position := audioAveR;
     // Convert S Level to dB for text display
     //if adc.specLevel1 > 0 Then Form1.rbUseLeft.Caption := 'L ' + IntToStr(Round((audioAveL*0.4)-20)) Else Form1.rbUseLeft.Caption := 'L -20';
     //if adc.specLevel2 > 0 Then Form1.rbUseRight.Caption := 'R ' + IntToStr(Round((audioAveR*0.4)-20)) Else Form1.rbUseRight.Caption := 'R -20';
     //if (adc.specLevel1 < 40) Or (adc.specLevel1 > 60) Then rbUseLeft.Font.Color := clRed else rbUseLeft.Font.Color := clBlack;
     //if (adc.specLevel2 < 40) Or (adc.specLevel2 > 60) Then rbUseRight.Font.Color := clRed else rbUseRight.Font.Color := clBlack;
     //if adc.specLevel1 > 0 Then cfgvtwo.Form6.Label25.Caption := 'L ' + IntToStr(Round((audioAveL*0.4)-20)) Else cfgvtwo.Form6.Label25.Caption := 'L -20';
     //if adc.specLevel2 > 0 Then cfgvtwo.Form6.Label31.Caption := 'R ' + IntToStr(Round((audioAveR*0.4)-20)) Else cfgvtwo.Form6.Label31.Caption := 'R -20';
     //if (adc.specLevel1 < 40) Or (adc.specLevel1 > 60) Then cfgvtwo.Form6.Label25.Font.Color := clRed else cfgvtwo.Form6.Label25.Font.Color := clBlack;
     //if (adc.specLevel2 < 40) Or (adc.specLevel2 > 60) Then cfgvtwo.Form6.Label31.Font.Color := clRed else cfgvtwo.Form6.Label31.Font.Color := clBlack;
End;

procedure TForm1.updateStatus(i : Integer);
Var
   foo : String;
begin
     If i = 1 Then
     Begin
          foo := 'Current Operation:  Initializing';
          if Form1.Label24.Caption <> foo Then
          Form1.Label24.Caption := foo;
     End;
     If i = 2 then
     Begin
          foo := 'Current Operation:  Receiving';
          if Form1.Label24.Caption <> foo Then
          Form1.Label24.Caption := foo;
     End;
     If i = 3 then
     Begin
          foo := 'Current Operation:  Transmitting';
          if Form1.Label24.Caption <> foo Then
          Form1.Label24.Caption := foo;
     End;
     If i = 4 then
     Begin
          foo := 'Current Operation:  Starting Decoder';
          if Form1.Label24.Caption <> foo Then
          Form1.Label24.Caption := foo;
     End;
     If i = 5 then
     Begin
          if d65.glinProg Then
             foo := 'Current Operation:  Decoding pass ' + IntToStr(d65.gldecoderPass+1)
          else
             foo := 'Current Operation:  Idle';
          if Form1.Label24.Caption <> foo Then
          Form1.Label24.Caption := foo;
     End;
end;

procedure TForm1.rbcCheck();
Var
   floatvar     : Single;
   intvar       : Integer;
   foo          : String;
begin
     floatvar := 0;
     If TryStrToFloat(Form1.editManQRG.Text, floatvar) Then
     Begin
          intvar := trunc(floatvar);
          //If parseCallSign.valQRG(intvar) Then rbc.glrbQRG := Form1.editManQRG.Text else rbc.glrbQRG := '0';
     End;
     // Update form title with rb info.
     //If cfgvtwo.Form6.cbUseRB.Checked Then
     //Begin
     //     foo := 'JT65-HF Version ' + verHolder.verReturn() + '  [RB Enabled, ';
     //     If cfgvtwo.Form6.cbNoInet.Checked Then foo := foo + ' offline mode.  ' Else foo := foo + ' online mode.  ';
     //     If cfgvtwo.Form6.cbNoInet.Checked Then
     //     Begin
     //          foo := foo + 'QRG = ' + Form1.editManQRG.Text + ' KHz]';
     //     End
     //     Else
     //     Begin
     //          If globalData.rbLoggedIn Then
     //             foo := foo + 'Logged In.  QRG = ' + Form1.editManQRG.Text + ' KHz]'
     //          Else
     //             foo := foo + 'Not Logged In.  QRG = ' + Form1.editManQRG.Text + ' KHz]';
     //     End;
     //     foo := foo + ' [de ' + globalData.fullcall + ']';
     //End
     //Else
     //Begin
     //     foo := 'JT65-HF Version ' + verHolder.verReturn() + '  [de ' + globalData.fullcall + ']';
     //End;
     if Form1.Caption <> foo Then Form1.Caption := foo;
     // Try to login the RB if it's marked online but not logged in.
     //If (cfgvtwo.Form6.cbUseRB.Checked) And (not cfgvtwo.Form6.cbNoInet.Checked) And (not globalData.rbLoggedIn) Then cfgvtwo.glrbcLogin := True;
end;

function TForm1.valConfig();
Begin
     globalData.chkconfig := false;
     result := True;
end;

procedure TForm1.initializerCode();
var
   foo                : String;
   i, ifoo            : Integer;
   vint, tstint       : Integer;
   vstr               : PChar;
   st                 : TSYSTEMTIME;
   tstflt             : Double;
   fname              : String;
   verUpdate          : Boolean;
Begin
     // This procedure is only executed once at program start
     //if globalData.debugOn Then showMessage('Debug ON');
     // Initialize the decoder output listbox, need this here now in case
     // I need to display an error message later in the initializer.
     Form1.ListBox1.Clear;
     firstReport := True;
     itemsIn := False;
     guidedconfig.Form7.Hide;

     //config1 := cfgobject.TConfiguration.create();   // Primary configuration object
     //config2 := cfgobject.TConfiguration.create();   // Backup used when revert changes engaged.
     //rig1 := rigobject.TRadio.create();              // Rig control object (Used even if control is manual)

     // Set the rig control method [none, hrd, commander, omni, hamlib, si570]
     //rig1.rigcontroller := 'commander';
     //rig1.rigcontroller := 'omni';
     //rig1.rigcontroller := 'hrd';
     //rig1.pollRig();
     //label18.Caption := rig1.rigcontroller + ' says QRG is ' + intToStr(rig1.qrg) + ' Hz';

     // Disabled config copy so I can work with a 'clean' setup.

     //// basedir holds path to current user's my documents space like:
     //// C:\Users\Joe\Documents
     //// I have confirmed this to work under Windows 7, Vista, XP and Wine
     ////
     //// I want to use basedir + \JT65HF\log\  as default location for adif/csv
     ////                         \JT65HF\data\ as directory for holding config and fft wisdom
     ////                         \JT65HF\kvdt\ as directory for holding KVASD.EXE and KVASD.DAT (maybe...)
     //
     //if not directoryExists(globalData.srcdir) Then createDir(globalData.srcdir);
     //if not directoryExists(globalData.logdir) Then createDir(globalData.logdir);
     //if not directoryExists(globalData.cfgdir) Then createDir(globalData.cfgdir);
     //if not directoryExists(globalData.kvdir) Then createDir(globalData.kvdir);
     //
     //// Now... I need to handle the case of a user that has configuration and fft metrics in old location
     //// by copying that data into the new locations.
     //if not fileExists(globalData.cfgdir+'\station1.xml') And fileExists(GetAppConfigDir(False)+'station1.xml') Then
     //Begin
     //     // OK, I have station1.xml in the old location but not the new so copy it.
     //     if fileutil.CopyFile(GetAppConfigDir(False)+'station1.xml',globalData.cfgdir+'\station1.xml') Then showmessage('Copied config');
     //end;
     //if not fileExists(globalData.cfgdir+'\wisdom2.dat') And fileExists(GetAppConfigDir(False)+'wisdom2.dat') Then
     //Begin
     //     // OK, I have wisdom2.dat in the old location but not the new so copy it.
     //     if fileutil.CopyFile(GetAppConfigDir(False)+'wisdom2.dat',globalData.cfgdir+'\wisdom2.dat') Then showmessage('Copied wisdom');
     //end;
     //if not fileExists(globalData.logdir+'\JT65HF-log.csv') Then
     //Begin
     //     AssignFile(lfile, globalData.logdir+'\JT65HF-log.csv');
     //     rewrite(lfile);
     //     WriteLn(lfile,'"Date","Time","QRG","Sync","DB","DT","DF","Decoder","Exchange"');
     //     closeFile(lfile);
     //end;
     //if not fileExists(globalData.logdir+'\JT65HF_ADIFLOG.adi') Then
     //Begin
     //     AssignFile(lfile, globalData.logdir+'\JT65HF_ADIFLOG.adi');
     //     rewrite(lfile);
     //     writeln(lfile,'JT65-HF ADIF Export');
     //     writeln(lfile,'<eoh>');
     //     closeFile(lfile);
     //end;

     // Error checks for configuration
     if cfgError Then
     Begin
          showMessage('Configuration file damaged and can not be recovered.');
          Halt;
     End;
     if cfgRecover then ShowMessage('Configuration file erased due to unrecoverable error.  Please reconfigure.');
     dlog.fileDebug('Entering initializer code.');
     // Check dll version.
     vstr   := StrAlloc(7);
     vint := 0;
     vstr := '0.0.0.0';
     ver(@vint, vstr);
     if vint <> verHolder.dllReturn() Then
     Begin
          showMessage('wsjt.dll incorrect version.  Program halted.');
          halt;
     end;
     dlog.fileDebug('JT65.dll version check OK.');
     tstint := 0;
     tstflt := 0.0;
     Form1.Caption := 'JT65-HF V' + verHolder.verReturn() + ' (c) 2009,2010 W6CQZ.  Free to use/modify/distribute under GPL 2.0 License.';
     // See comments in procedure code to understand why this is a MUST to use.
     DisableFloatingPointExceptions();
     // Create the decoder thread with param False so it starts.
     //d65.glinProg := False;
     //decoderThread := decodeThread.Create(False);
     // Create the CAT control thread with param True so it starts.
     //rigThread := catThread.Create(False);
     // Create RB thread with param False so it starts.
     //cfgvtwo.glrbcLogin := False;
     //cfgvtwo.glrbcLogout := False;
     //rbcPing := False;
     //dorbReport := False;
     //rbThread := rbcThread.Create(False);

     //// Init PA.  If this doesn't work there's no reason to continue.
     //PaResult := portaudio.Pa_Initialize();
     //If PaResult <> 0 Then
     //Begin
     //     ShowMessage('Fatal Error.  Could not initialize portaudio.');
     //     halt;
     //end;
     //If PaResult = 0 Then dlog.fileDebug('Portaudio initialized OK.');
     //// Now I need to populate the Sound In/Out pulldowns.  First I'm going to get
     //// a list of the portaudio API descriptions.  For now I'm going to stick with
     //// the default windows interface, but in the future I may look at directsound
     //// usage as well.
     //paDefApi := portaudio.Pa_GetDefaultHostApi();
     //if paDefApi >= 0 Then
     //Begin
     //     cfgvtwo.Form6.cbAudioIn.Clear;
     //     cfgvtwo.Form6.cbAudioOut.Clear;
     //     guidedconfig.Form7.comboSoundIn.Clear;
     //     guidedconfig.Form7.comboSoundOut.Clear;
     //     paDefApiDevCount := portaudio.Pa_GetHostApiInfo(paDefApi)^.deviceCount;
     //     i := paDefApiDevCount-1;
     //     While i >= 0 do
     //     Begin
     //          // I need to populate the pulldowns with the devices supported by
     //          // the default portaudio API, select the default in/out devices for
     //          // said API or restore the saved value of the user's choice of in
     //          // out devices.
     //          If portaudio.Pa_GetDeviceInfo(i)^.maxInputChannels > 0 Then
     //          Begin
     //               if i < 10 Then
     //                  paInS := '0' + IntToStr(i) + '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)
     //               else
     //                  paInS := IntToStr(i) + '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name);
     //               cfgvtwo.Form6.cbAudioIn.Items.Insert(0,paInS);
     //               guidedconfig.Form7.comboSoundIn.Items.Insert(0,paInS);
     //          End;
     //          If portaudio.Pa_GetDeviceInfo(i)^.maxOutputChannels > 0 Then
     //          Begin
     //               if i < 10 Then
     //                  paOutS := '0' + IntToStr(i) +  '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)
     //               else
     //                  paOutS := IntToStr(i) +  '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name);
     //               cfgvtwo.Form6.cbAudioOut.Items.Insert(0,paOutS);
     //               guidedconfig.Form7.comboSoundOut.Items.Insert(0,paOutS);
     //          End;
     //          dec(i);
     //     End;
     //     // pulldowns populated.  Now I need to select the portaudio default
     //     // devices.  To map the values to the pulldown I simply use the integer
     //     // value of the input device as the pulldown index, for the output I
     //     // subtract 2 from the pa value to map the correct pulldown index.
     //     cfgvtwo.Form6.cbAudioIn.ItemIndex := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultInputDevice;
     //     cfgvtwo.Form6.cbAudioOut.ItemIndex := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultOutputDevice-2;
     //     guidedconfig.Form7.comboSoundIn.ItemIndex := -1;
     //     guidedconfig.Form7.comboSoundOut.ItemIndex := -1;
     //     dlog.fileDebug('Audio Devices added to pulldowns.');
     //End
     //Else
     //Begin
     //     // This is yet another fatal error as portaudio can't function if it
     //     // can't provide a default API value >= 0.  TODO Handle this should it
     //     // happen.
     //     dlog.fileDebug('FATAL:  Portaudio DID NOT INIT.  No defapi found.');
     //     ShowMessage('FATAL:  Portaudio DID NOT INIT.  No default api found, program closing.');
     //     halt;
     //End;

     fname := globalData.cfgdir+'\station1.xml';

     if not fileExists(fname) Then
     Begin
          guidedconfig.Form7.PageControl1.ActivePageIndex := 0;
          guidedconfig.Form7.Show;
          guidedconfig.Form7.BringToFront;
          self.Visible := false;
          guidedconfig.going := true;
          repeat
                sleep(10);
                Application.ProcessMessages
          until not guidedconfig.going;
          guidedconfig.Form7.Visible := False;
          self.Visible := true;
          self.Show;
          self.BringToFront;
          if guidedconfig.cfg.soundTested then foo := 'Sound devices tested' + sLineBreak else foo := 'Sound devices not tested' + sLineBreak;
          if guidedconfig.cfg.soundExtendedTested then foo := foo + 'Sound devices extended tested' + sLineBreak else foo := foo + 'Sound devices not extended tested' + sLineBreak;
          if guidedconfig.cfg.soundValid then foo := foo + 'Sound system is valid' + sLineBreak else foo := foo + 'Sound system is not valid' + sLineBreak;
          showmessage('Callsign = ' + guidedconfig.cfg.callsign + sLineBreak +
                      'CW ID = ' + guidedconfig.cfg.cwcallsign + sLineBreak +
                      'RB ID = ' + guidedconfig.cfg.rbcallsign + sLineBreak +
                      'Prefix = ' + IntToStr(guidedconfig.cfg.prefix) + sLineBreak +
                      'Suffix = ' + IntToStr(guidedconfig.cfg.suffix) + sLineBreak +
                      'RX PA Device = ' + IntToStr(guidedconfig.cfg.soundIn) + sLineBreak +
                      'RX PA Device = ' + guidedconfig.cfg.soundInS + sLineBreak +
                      'TX PA Device = ' + IntToStr(guidedconfig.cfg.soundOut) + sLineBreak +
                      'TX PA Device = ' + guidedconfig.cfg.soundOutS + sLineBreak +
                      foo
                      );
          halt;

          // Setup default sane value for config form.
          //cfgvtwo.Form6.edMyCall.Clear;
          //cfgvtwo.Form6.edMyGrid.Clear;
          //cfgvtwo.Form6.cbAudioIn.ItemIndex := 0;
          //cfgvtwo.Form6.cbAudioOut.ItemIndex := 0;
          //cfgvtwo.Form6.comboPrefix.ItemIndex := 0;
          //cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
          //cfgvtwo.Form6.cbTXWatchDog.Checked := True;
          //cfgvtwo.Form6.spinTXCounter.Value := 15;
          //cfgvtwo.Form6.cbDisableMultiQSO.Checked := True;
          //cfgvtwo.Form6.cbMultiAutoEnable.Checked := True;
          //cfgvtwo.Form6.edRXSRCor.Text := '1.0000';
          //cfgvtwo.Form6.edTXSRCor.Text := '1.0000';
          //cfgvtwo.Form6.chkEnableAutoSR.Checked := True;
          //cfgvtwo.Form6.cbSaveCSV.Checked := True;
          //cfgvtwo.Form6.DirectoryEdit1.Directory := globalData.logdir;
          //cfgvtwo.Form6.editUserDefinedPort1.Text := 'None';
          //cfgvtwo.Form6.ComboBox1.ItemIndex := 8;
          //cfgvtwo.Form6.ComboBox1.Color := clLime;
          //cfgvtwo.Form6.ComboBox2.ItemIndex := 7;
          //cfgvtwo.Form6.ComboBox2.Color := clRed;
          //cfgvtwo.Form6.ComboBox3.ItemIndex := 6;
          //cfgvtwo.Form6.ComboBox3.Color := clSilver;
          //cfgvtwo.glcqColor := clLime;
          //cfgvtwo.glcallColor := clRed;
          //cfgvtwo.glqsoColor := clSilver;
          //cfgvtwo.Form6.cbEnableQSY1.Checked := False;
          //cfgvtwo.Form6.cbEnableQSY2.Checked := False;
          //cfgvtwo.Form6.cbEnableQSY3.Checked := False;
          //cfgvtwo.Form6.cbEnableQSY4.Checked := False;
          //cfgvtwo.Form6.cbEnableQSY5.Checked := False;
          //cfgvtwo.Form6.qsyHour1.Value := 0;
          //cfgvtwo.Form6.qsyHour2.Value := 0;
          //cfgvtwo.Form6.qsyHour3.Value := 0;
          //cfgvtwo.Form6.qsyHour4.Value := 0;
          //cfgvtwo.Form6.qsyHour5.Value := 0;
          //cfgvtwo.Form6.qsyMinute1.Value := 0;
          //cfgvtwo.Form6.qsyMinute2.Value := 0;
          //cfgvtwo.Form6.qsyMinute3.Value := 0;
          //cfgvtwo.Form6.qsyMinute4.Value := 0;
          //cfgvtwo.Form6.qsyMinute5.Value := 0;
          //cfgvtwo.Form6.edQRGQSY1.Text := '14076000';
          //cfgvtwo.Form6.edQRGQSY2.Text := '14076000';
          //cfgvtwo.Form6.edQRGQSY3.Text := '14076000';
          //cfgvtwo.Form6.edQRGQSY4.Text := '14076000';
          //cfgvtwo.Form6.edQRGQSY5.Text := '14076000';
          //cfgvtwo.Form6.cbATQSY1.Checked := False;
          //cfgvtwo.Form6.cbATQSY2.Checked := False;
          //cfgvtwo.Form6.cbATQSY3.Checked := False;
          //cfgvtwo.Form6.cbATQSY4.Checked := False;
          //cfgvtwo.Form6.cbATQSY5.Checked := False;
          //cfgvtwo.Form6.chkHRDPTT.Checked := False;
          //cfgvtwo.Form6.chkTxDFVFO.Checked := False;
          //cfgvtwo.Form6.hrdAddress.Text := 'localhost';
          //cfgvtwo.Form6.hrdPort.Text := '7809';
          //cfgvtwo.Form6.chkNoOptFFT.Checked := False;
          //cfgvtwo.glcatBy := 'none';

          Form1.spinGain.Value := 0;
          Form1.spinTXCF.Value := 0;
          Form1.spinDecoderCF.Value := 0;
          Form1.spinDecoderBW.Value := 3;
          Form1.chkAFC.Checked := False;
          Form1.chkNB.Checked := False;
          Form1.cbSpecPal.ItemIndex := 0;
          Form1.tbBright.Position := 0;
          Form1.tbContrast.Position := 0;
          Form1.SpinEdit1.Value := 5;
          Form1.rbUseLeft.Checked := True;
          Form1.TrackBar1.Position := 0;
          Form1.TrackBar2.Position := 0;
          Form1.rbGenMsg.Checked := True;
          Form1.rbTX1.Checked := True;
          Form1.chkEnTX.Checked := False;
          Form1.edFreeText.Clear;
          Form1.edMsg.Clear;
          Form1.edHisCall.Clear;
          Form1.edHisGrid.Clear;
          Form1.edSigRep.Clear;

     //     cfg.StoredValue['call']         := UpperCase(cfgvtwo.glmycall);
     //     cfg.StoredValue['pfx']          := IntToStr(cfgvtwo.Form6.comboPrefix.ItemIndex);
     //     cfg.StoredValue['sfx']          := IntToStr(cfgvtwo.Form6.comboSuffix.ItemIndex);
     //     cfg.StoredValue['grid']         := cfgvtwo.Form6.edMyGrid.Text;
     //     cfg.StoredValue['soundin']      := IntToStr(cfgvtwo.Form6.cbAudioIn.ItemIndex);
     //     cfg.StoredValue['soundout']     := IntToStr(cfgvtwo.Form6.cbAudioOut.ItemIndex);
     //     cfg.StoredValue['ldgain']       := IntToStr(Form1.TrackBar1.Position);
     //     cfg.StoredValue['rdgain']       := IntToStr(Form1.TrackBar2.Position);
     //     cfg.StoredValue['samfacin']     := cfgvtwo.Form6.edRXSRCor.Text;
     //     cfg.StoredValue['samfacout']    := cfgvtwo.Form6.edTXSRCor.Text;
     //     if Form1.rbUseLeft.Checked Then cfg.StoredValue['audiochan'] := 'L' Else cfg.StoredValue['audiochan'] := 'R';
     //     If cfgvtwo.Form6.chkEnableAutoSR.Checked Then cfg.StoredValue['autoSR'] := '1' else cfg.StoredValue['autoSR'] := '0';
     //     cfg.StoredValue['pttPort']      := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);
     //     if Form1.chkAFC.Checked Then cfg.StoredValue['afc'] := '1' Else cfg.StoredValue['afc'] := '0';
     //     If Form1.chkNB.Checked Then cfg.StoredValue['noiseblank'] := '1' Else cfg.StoredValue['noiseblank'] := '0';
     //     cfg.StoredValue['brightness']   := IntToStr(Form1.tbBright.Position);
     //     cfg.StoredValue['contrast']     := IntToStr(Form1.tbContrast.Position );
     //     cfg.StoredValue['colormap']     := IntToStr(Form1.cbSpecPal.ItemIndex);
     //     cfg.StoredValue['specspeed']    := IntToStr(Form1.SpinEdit1.Value);
     //     cfg.StoredValue['txCF']         := '0';
     //     cfg.StoredValue['rxCF']         := '0';
     //     if cfgvtwo.Form6.cbTXWatchDog.Checked Then cfg.StoredValue['txWatchDog'] := '1' else cfg.StoredValue['txWatchDog'] := '0';
     //     cfg.StoredValue['txWatchDogCount'] := IntToStr(cfgvtwo.Form6.spinTXCounter.Value);
     //     If cfgvtwo.Form6.cbSaveCSV.Checked Then cfg.StoredValue['saveCSV'] := '1' Else cfg.StoredValue['saveCSV'] := '0';
     //     cfg.StoredValue['csvPath'] := cfgvtwo.Form6.DirectoryEdit1.Directory;
     //     cfg.StoredValue['adiPath'] := cfgvtwo.Form6.DirectoryEdit1.Directory;
     //     cfg.StoredValue['version'] := verHolder.verReturn();
     //     cfg.StoredValue['cqColor'] := IntToStr(cfgvtwo.Form6.ComboBox1.ItemIndex);
     //     cfg.StoredValue['callColor'] := IntToStr(cfgvtwo.Form6.ComboBox2.ItemIndex);
     //     cfg.StoredValue['qsoColor'] := IntToStr(cfgvtwo.Form6.ComboBox3.ItemIndex);
     //     cfg.StoredValue['catBy'] := cfgvtwo.glcatBy;
     //     if cfgvtwo.Form6.editPSKRCall.Text = '' Then cfgvtwo.Form6.editPSKRCall.Text := cfgvtwo.Form6.edMyCall.Text;
     //     if cfgvtwo.Form6.cbUsePSKReporter.Checked Then cfg.StoredValue['usePSKR'] := 'yes' else cfg.StoredValue['usePSKR'] := 'no';
     //     if cfgvtwo.Form6.cbUseRB.Checked Then cfg.StoredValue['useRB'] := 'yes' else cfg.StoredValue['useRB'] := 'no';
     //     cfg.StoredValue['pskrCall'] := cfgvtwo.Form6.editPSKRCall.Text;
     //     cfg.StoredValue['pskrAntenna'] := cfgvtwo.Form6.editPSKRAntenna.Text;
     //     if cfgvtwo.Form6.chkNoOptFFT.Checked Then cfg.StoredValue['optFFT'] := 'off' else cfg.StoredValue['optFFT'] := 'on';
     //     if cfgvtwo.Form6.cbUseAltPTT.Checked Then cfg.StoredValue['useAltPTT'] := 'yes' else cfg.StoredValue['useAltPTT'] := 'no';
     //     if cfgvtwo.Form6.chkHRDPTT.Checked Then cfg.StoredValue['useHRDPTT'] := 'yes' else cfg.StoredValue['useHRDPTT'] := 'no';
     //     cfg.StoredValue['userQRG1'] := cfgvtwo.Form6.edUserQRG1.Text;
     //     cfg.StoredValue['userQRG2'] := cfgvtwo.Form6.edUserQRG2.Text;
     //     cfg.StoredValue['userQRG3'] := cfgvtwo.Form6.edUserQRG3.Text;
     //     cfg.StoredValue['userQRG4'] := cfgvtwo.Form6.edUserQRG4.Text;
     //     cfg.StoredValue['usrMsg1'] := cfgvtwo.Form6.edUserMsg4.Text;
     //     cfg.StoredValue['usrMsg2'] := cfgvtwo.Form6.edUserMsg5.Text;
     //     cfg.StoredValue['usrMsg3'] := cfgvtwo.Form6.edUserMsg6.Text;
     //     cfg.StoredValue['usrMsg4'] := cfgvtwo.Form6.edUserMsg7.Text;
     //     cfg.StoredValue['usrMsg5'] := cfgvtwo.Form6.edUserMsg8.Text;
     //     cfg.StoredValue['usrMsg6'] := cfgvtwo.Form6.edUserMsg9.Text;
     //     cfg.StoredValue['usrMsg7'] := cfgvtwo.Form6.edUserMsg10.Text;
     //     cfg.StoredValue['usrMsg8'] := cfgvtwo.Form6.edUserMsg11.Text;
     //     cfg.StoredValue['usrMsg9'] := cfgvtwo.Form6.edUserMsg12.Text;
     //     cfg.StoredValue['usrMsg10'] := cfgvtwo.Form6.edUserMsg13.Text;
     //     cfg.StoredValue['binspace'] := '100';
     //     if Form1.cbSmooth.Checked Then cfg.StoredValue['smooth'] := 'on' else cfg.StoredValue['smooth'] := 'off';
     //     if cfgvtwo.Form6.cbRestoreMulti.Checked Then cfg.StoredValue['restoreMulti'] := 'on' else cfg.StoredValue['restoreMulti'] := 'off';
     //     cfg.StoredValue['specVGain'] := IntToStr(spinGain.Value);
     //     if cfgvtwo.Form6.radioSI570X1.Checked Then cfg.StoredValue['si570mul'] := '1';
     //     if cfgvtwo.Form6.radioSI570X2.Checked Then cfg.StoredValue['si570mul'] := '2';
     //     if cfgvtwo.Form6.radioSI570X4.Checked Then cfg.StoredValue['si570mul'] := '4';
     //     cfg.StoredValue['si570cor'] := cfgvtwo.Form6.editSI570FreqOffset.Text;
     //     cfg.StoredValue['si570qrg'] := cfgvtwo.Form6.editSI570Freq.Text;
     //     if cfgvtwo.Form6.cbSi570PTT.Checked Then cfg.StoredValue['si570ptt'] := 'y' else cfg.StoredValue['si570ptt'] := 'n';
     //     if cfgvtwo.Form6.cbSi570PTT.Checked Then cfg.StoredValue['si570ptt'] := 'y' else cfg.StoredValue['si570ptt'] := 'n';
     //     if cfgvtwo.Form6.cbCWID.Checked Then cfg.StoredValue['useCWID'] := 'y' else cfg.StoredValue['useCWID'] := 'n';
     //     if cfgvtwo.Form6.chkTxDFVFO.Checked Then cfg.StoredValue['useCATTxDF'] := 'yes' else cfg.StoredValue['useCATTxDF'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY1.Checked Then cfg.StoredValue['enAutoQSY1'] := 'yes' else cfg.StoredValue['enAutoQSY1'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY2.Checked Then cfg.StoredValue['enAutoQSY2'] := 'yes' else cfg.StoredValue['enAutoQSY2'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY3.Checked Then cfg.StoredValue['enAutoQSY3'] := 'yes' else cfg.StoredValue['enAutoQSY3'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY4.Checked Then cfg.StoredValue['enAutoQSY4'] := 'yes' else cfg.StoredValue['enAutoQSY4'] := 'no';
     //     if cfgvtwo.Form6.cbEnableQSY5.Checked Then cfg.StoredValue['enAutoQSY5'] := 'yes' else cfg.StoredValue['enAutoQSY5'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY1.Checked Then cfg.StoredValue['autoQSYAT1'] := 'yes' else cfg.StoredValue['autoQSYAT1'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY2.Checked Then cfg.StoredValue['autoQSYAT2'] := 'yes' else cfg.StoredValue['autoQSYAT2'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY3.Checked Then cfg.StoredValue['autoQSYAT3'] := 'yes' else cfg.StoredValue['autoQSYAT3'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY4.Checked Then cfg.StoredValue['autoQSYAT4'] := 'yes' else cfg.StoredValue['autoQSYAT4'] := 'no';
     //     if cfgvtwo.Form6.cbATQSY5.Checked Then cfg.StoredValue['autoQSYAT5'] := 'yes' else cfg.StoredValue['autoQSYAT5'] := 'no';
     //     cfg.StoredValue['autoQSYQRG1'] := cfgvtwo.Form6.edQRGQSY1.Text;
     //     cfg.StoredValue['autoQSYQRG2'] := cfgvtwo.Form6.edQRGQSY2.Text;
     //     cfg.StoredValue['autoQSYQRG3'] := cfgvtwo.Form6.edQRGQSY3.Text;
     //     cfg.StoredValue['autoQSYQRG4'] := cfgvtwo.Form6.edQRGQSY4.Text;
     //     cfg.StoredValue['autoQSYQRG5'] := cfgvtwo.Form6.edQRGQSY5.Text;
     //     if cfgvtwo.Form6.qsyHour1.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute1.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC1'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour2.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute2.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC2'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour3.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute3.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC3'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour4.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute4.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC4'] := foo;
     //
     //     if cfgvtwo.Form6.qsyHour5.Value < 10 Then
     //     Begin
     //          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     //     End
     //     Else
     //     Begin
     //          foo := IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     //     end;
     //     if cfgvtwo.Form6.qsyMinute5.Value < 10 Then
     //     Begin
     //          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     //     End
     //     Else
     //     Begin
     //          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     //     end;
     //     cfg.StoredValue['autoQSYUTC5'] := foo;
     //     cfg.StoredValue['hrdAddress'] := cfgvtwo.Form6.hrdAddress.Text;
     //     cfg.StoredValue['hrdPort'] := cfgvtwo.Form6.hrdPort.Text;
     //     cfg.Save;
     //     dlog.fileDebug('Ran initial configuration.');
     //End;
     //// Read configuration data from XMLpropstorage (cfg.)
     //
     //tstint := 0;
     //
     //config1.callsign := cfg.StoredValue['call'];
     //config2.callsign := cfg.StoredValue['call'];
     //if TryStrToInt(cfg.storedValue['pfx'],tstint) Then config1.prefix := tstint else config1.prefix := 0;
     //config2.prefix := config1.prefix;
     //if TryStrToInt(cfg.storedValue['sfx'],tstint) Then config1.suffix := tstint else config1.suffix := 0;
     //config2.suffix := config1.suffix;
     //config1.grid := cfg.StoredValue['grid'];
     //if TryStrToInt(cfg.StoredValue['rxCF'],tstint) Then config1.decoderRXDF := tstint else config1.decoderRXDF := 0;
     //config2.decoderRXDF := config1.decoderRXDF;
     //if TryStrToInt(cfg.StoredValue['txCF'],tstint) Then config1.decoderTXDF := tstint else config1.decoderTXDF := 0;
     //config2.decoderTXDF := config1.decoderTXDF;
     //config1.decoderBW := 100;
     //config2.decoderBW := config1.decoderBW;
     //
     //if TryStrToInt(cfg.StoredValue['soundin'],tstint) Then config1.rxAudio := tstint else config1.rxAudio := 0;
     //config2.rxAudio := config1.rxAudio;
     //if TryStrToInt(cfg.StoredValue['soundout'],tstint) Then config1.txAudio := tstint else config1.txAudio := 0;
     //config2.txAudio := config1.txAudio;
     //
     //if TryStrToInt(cfg.StoredValue['ldgain'],tstint) Then config1.dgainL := tstint else config1.dgainL := 0;
     //config2.dgainL := config1.dgainL;
     //
     //if TryStrToInt(cfg.StoredValue['rdgain'],tstint) Then config1.dgainR := tstint else config1.dgainR := 0;
     //config2.dgainR := config1.dgainR;
     //
     //tstflt := 0.0;
     //
     //if TryStrToFloat(cfg.StoredValue['samfacin'],tstflt) Then config1.rxSRAdj := tstflt else config1.rxSRAdj := 1.0000;
     //config2.rxSRAdj := config1.rxSRAdj;
     //
     //if TryStrToFloat(cfg.StoredValue['samfacout'],tstflt) Then config1.txSRAdj := tstflt else config1.txSRAdj := 1.0000;
     //config2.txSRAdj := config1.txSRAdj;
     //
     //config1.rxChans := 2;
     //config2.rxChans := config1.rxChans;
     //
     //config1.txChans := 2;
     //config2.txChans := config1.txChans;
     //
     //if cfg.StoredValue['audiochan'] = 'L' Then config1.rxChan := 1;
     //config2.rxChan := config1.rxChan;
     //
     //if cfg.StoredValue['audiochan'] = 'R' Then config1.rxChan := 2;
     //config2.rxChan := config1.rxChan;
     //
     //if cfg.StoredValue['autoSR'] = '1' Then config1.autoSRcorrect := True else config1.autoSRcorrect := False;
     //config2.autoSRcorrect := config1.autoSRcorrect;
     //
     //config1.pttDevice := TrimLeft(TrimRight(UpperCase(cfg.StoredValue['pttPort'])));
     //config2.pttDevice := config1.pttDevice;
     //
     //config1.pttType := 'SERIALA';
     //config2.pttType := config1.pttType;
     //
     //if cfg.StoredValue['useAltPTT'] = 'yes' Then config1.pttType := 'SERIALB';
     //config2.pttType := config1.pttType;
     //
     //if cfg.StoredValue['afc'] = '1' Then config1.decoderAFC := True Else config1.decoderAFC := False;
     //config2.decoderAFC := config1.decoderAFC;
     //
     //if cfg.StoredValue['noiseblank'] = '1' Then config1.decoderNB := True Else config1.decoderNB := False;
     //config2.decoderNB := config1.decoderNB;
     //
     //If TryStrToInt(cfg.StoredValue['brightness'],tstint) Then config1.spectrumBrightness := tstint else config1.spectrumBrightness := 0;
     //config2.spectrumBrightness := config1.spectrumBrightness;
     //
     //If TryStrToInt(cfg.StoredValue['contrast'],tstint) Then config1.spectrumContrast := tstint else config1.spectrumContrast := 0;
     //config2.spectrumContrast := config1.spectrumContrast;
     //
     //If TryStrToInt(cfg.StoredValue['colormap'],tstint) Then config1.spectrumPallete := tstint else config1.spectrumPallete := 0;
     //config2.spectrumPallete := config1.spectrumPallete;
     //
     //If TryStrToInt(cfg.StoredValue['specspeed'],tstint) Then config1.spectrumSpeed := tstint else config1.spectrumSpeed := 0;
     //config2.spectrumSpeed := config1.spectrumSpeed;
     //
     //If TryStrToInt(cfg.StoredValue['specVGain'],tstint) Then config1.spectrumGain := tstint else config1.spectrumGain :=0;
     //config2.spectrumGain := config1.spectrumGain;
     //
     //if cfg.StoredValue['saveCSV'] = '1' Then config1.logCSV := True else config1.logCSV := False;
     //config2.logCSV := config1.logCSV;
     //
     //if Length(cfg.StoredValue['csvPath']) > 0 Then config1.logCSVpath := cfg.StoredValue['csvPath'] else config1.logCSVpath := globalData.logdir;
     //config2.logCSVpath := config1.logCSVpath;
     //
     //if Length(cfg.StoredValue['adiPath']) > 0 Then config1.logADIpath := cfg.StoredValue['adiPath'] else config1.logADIpath := globalData.logdir;
     //config2.logADIpath := config1.logADIpath;
     //
     //config1.swiVersion := verHolder.iverReturn();
     //config2.swiVersion := config1.swiVersion;
     //
     //config1.swsVersion := verHolder.verReturn();
     //config2.swsVersion := config1.swsVersion;
     //
     //if cfg.StoredValue['txWatchDog'] = '1' Then config1.txWatchDog := True else config1.txWatchDog := false;
     //config2.txWatchDog := config1.txWatchDog;
     //
     //If TryStrToInt(cfg.StoredValue['txWatchDogCount'],tstint) Then config1.txWatchDogCount := tstint else config1.txWatchDogCount := 15;
     //config2.txWatchDogCount := config1.txWatchDogCount;
     //
     //if cfg.StoredValue['multiQSOToggle'] = '1' Then config1.multiOffInQSO := True else config1.multiOffInQSO := False;
     //config2.multiOffInQSO := config1.multiOffInQSO;
     //
     //if cfg.StoredValue['multiQSOWatchDog'] = '1' Then config1.multiOnQSOEnd := True else config1.multiOnQSOEnd := False;
     //config2.multiOnQSOEnd := config1.multiOnQSOEnd;
     //
     //If TryStrToInt(cfg.StoredValue['cqColor'],tstint) Then config1.cqLineColor := tstint else config1.cqLineColor := 8;
     //config2.cqLineColor := config1.cqLineColor;
     //
     //If TryStrToInt(cfg.StoredValue['callColor'],tstint) Then config1.mycallLineColor := tstint else config1.mycallLineColor := 7;
     //config2.mycallLineColor := config1.mycallLineColor;
     //
     //If TryStrToInt(cfg.StoredValue['qsoColor'],tstint) Then config1.qsoLineColor := tstint else config1.qsoLineColor := 6;
     //config2.qsoLineColor := config1.qsoLineColor;
     //
     //// String holding rig control type (none, hrd, commander, omni, si570, hamlib)
     //config1.rigControl := cfg.StoredValue['catBy'];
     //config2.rigControl := config1.rigControl;
     //
     //if cfg.StoredValue['pskrCall'] = '' Then config1.rbcallsign := config1.callsign else config1.rbcallsign := cfg.StoredValue['pskrCall'];
     //config2.rbcallsign := config1.rbcallsign;
     //
     //if cfg.StoredValue['usePSKR'] = 'yes' Then config1.PSKROn := True else config1.PSKROn := False;
     //config2.PSKROn := config1.PSKROn;
     //
     //if cfg.StoredValue['useRB'] = 'yes' Then config1.RBOn := True else config1.RBOn := False;
     //config2.RBOn := config1.RBOn;
     //
     //config1.rbInfo := cfg.StoredValue['pskrAntenna'];
     //config2.rbInfo := config1.rbInfo;
     //
     //if cfg.StoredValue['optFFT'] = 'on' Then config1.decoderOptFFT := true else config1.decoderOptFFT := false;
     //config2.decoderOptFFT := config1.decoderOptFFT;
     //
     //if cfg.StoredValue['useHRDPTT'] = 'yes' Then
     //begin
     //     config1.pttType    := 'RIGCTRL';
     //     config1.pttDevice  := 'RIGCTRL';
     //     config1.rigControl := 'hrd';
     //     config2.pttType    := 'RIGCTRL';
     //     config2.pttDevice  := 'RIGCTRL';
     //     config2.rigControl := 'hrd';
     //end;
     //
     //if cfg.StoredValue['useCommanderPTT'] = 'yes' Then
     //begin
     //     config1.pttType    := 'RIGCTRL';
     //     config1.pttDevice  := 'RIGCTRL';
     //     config1.rigControl := 'commander';
     //     config2.pttType    := 'RIGCTRL';
     //     config2.pttDevice  := 'RIGCTRL';
     //     config2.rigControl := 'commander';
     //end;
     //
     //if cfg.StoredValue['useOmniPTT'] = 'yes' Then
     //begin
     //     config1.pttType    := 'RIGCTRL';
     //     config1.pttDevice  := 'RIGCTRL';
     //     config1.rigControl := 'omni';
     //     config2.pttType    := 'RIGCTRL';
     //     config2.pttDevice  := 'RIGCTRL';
     //     config2.rigControl := 'omni';
     //end;
     //
     //if cfg.StoredValue['useHamlibPTT'] = 'yes' Then
     //begin
     //     config1.pttType    := 'RIGCTRL';
     //     config1.pttDevice  := 'RIGCTRL';
     //     config1.rigControl := 'hamlib';
     //     config2.pttType    := 'RIGCTRL';
     //     config2.pttDevice  := 'RIGCTRL';
     //     config2.rigControl := 'hamlib';
     //end;
     //
     //if cfg.StoredValue['si570ptt'] = 'y' Then
     //begin
     //     config1.pttType    := 'RIGCTRL';
     //     config1.pttDevice  := 'RIGCTRL';
     //     config1.rigControl := 'si570';
     //     config2.pttType    := 'RIGCTRL';
     //     config2.pttDevice  := 'RIGCTRL';
     //     config2.rigControl := 'si570';
     //end;
     //
     //if cfg.StoredValue['useCATTxDF'] = 'yes' Then config1.txdfByCAT := True else config1.txdfByCAT := False;
     //config2.txdfByCAT := config1.txdfByCAT;
     //
     //config1.txdfByCATtolerance := 300;
     //config2.txdfByCATtolerance := config1.txdfByCATtolerance;
     //
     //config1.multiBinSpace := 100;
     //config2.multiBinSpace := config1.multiBinSpace;
     //
     //if cfg.StoredValue['smooth'] = 'on' Then config1.spectrumSmooth := True else config1.spectrumSmooth := False;
     //config2.spectrumSmooth := config1.spectrumSmooth;
     //
     //if cfg.StoredValue['restoreMulti'] = 'on' Then config1.multiOnQSOEnd := True else config1.multiOnQSOEnd := False;
     //config2.multiOnQSOEnd := config1.multiOnQSOEnd;
     //
     //if cfg.storedValue['useCWID'] = 'y' then config1.cwID := True else config1.cwID := False;
     //config2.cwID := config1.cwID;
     //
     //if (config1.callsign = '') or (config1.grid = '') or (config1.rbcallsign = '') Then
     //begin
     //     //showMessage('Configuration is NOT valid.  Debugging problem.');
     //     if config1.callsign = '' then
     //     begin
     //          showMessage('Your callsign does not conform to the format' + sLineBreak +
     //                      'required by the JT65 protocol.  It can not be' + sLineBreak +
     //                      'used as entered.  Please review your settings.');
     //          config1.canTX := False;
     //     end;
     //     if config1.grid = '' then
     //     begin
     //          showMessage('Your Maidenhead grid square value is invalid.' + sLineBreak +
     //                      'Transmit can not be enabled until a correct' + sLineBreak +
     //                      'value is entered.  RB and PSKR spotting is' + sLineBreak +
     //                      'also disabled while grid value is incorrect.' + sLineBreak +
     //                      'Please review your settings.');
     //          config1.canTX   := False;
     //          config1.canSpot := False;
     //     end;
     //     if config1.rbcallsign = '' then
     //     begin
     //          showMessage('Your RB and/or PSK Reporter callsign is' + sLineBreak +
     //                      'It is either less than 3 characters or' + sLineBreak +
     //                      'more than 32 characters long.  Either' + sLineBreak +
     //                      'condition is invalid and disable RB and' + sLineBreak +
     //                      'PSK Reporter spotting.  Please review' + sLineBreak +
     //                      'your configuration');
     //          config1.canSpot := False;
     //     end;
     //end
     //else
     //begin
     //     config1.canTX   := True;
     //     config1.canSpot := True;
     //end;
     //// Display error condition in decoder output window, if necessary.
     //If not config1.canTX Then
     //Begin
     //     If firstReport Then
     //     begin
     //          Form1.ListBox1.Items.Strings[0] := 'ERROR: Transmit disabled. Bad callsign or grid.';
     //          firstReport := False;
     //          itemsIn := True;
     //     end
     //     Else
     //     Begin
     //          Form1.ListBox1.Items.Insert(0,'ERROR: Transmit disabled. Bad callsign or grid.');
     //          itemsIn := True;
     //     End;
     //End;
     //If not config1.canSpot Then
     //Begin
     //     If firstReport Then
     //     begin
     //          Form1.ListBox1.Items.Strings[0] := 'ERROR: RB/PSKR disabled. Bad callsign or grid.';
     //          firstReport := False;
     //          itemsIn := True;
     //     end
     //     Else
     //     Begin
     //          Form1.ListBox1.Items.Insert(0,'ERROR: RB/PSKR disabled. Bad callsign or grid.');
     //          itemsIn := True;
     //     End;
     //End;
     //// Configuration objects populated and good to go.
     //
     //tstint := 0;
     //cfgvtwo.glmycall := cfg.StoredValue['call'];
     //if TryStrToInt(cfg.storedValue['pfx'],tstint) Then cfgvtwo.Form6.comboPrefix.ItemIndex := tstint else cfgvtwo.Form6.comboPrefix.ItemIndex := 0;
     //if TryStrToInt(cfg.storedValue['sfx'],tstint) Then cfgvtwo.Form6.comboSuffix.ItemIndex := tstint else cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
     //// Check for invalid case of suffix AND prefix being set.  If so prefix wins.
     //if (cfgvtwo.Form6.comboPrefix.ItemIndex > 0) And (cfgvtwo.Form6.comboSuffix.ItemIndex > 0) Then cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
     //if cfgvtwo.Form6.comboPrefix.ItemIndex > 0 then mnHavePrefix := True else mnHavePrefix := False;
     //if cfgvtwo.Form6.comboSuffix.ItemIndex > 0 then mnHaveSuffix := True else mnHaveSuffix := False;
     //cfgvtwo.Form6.edMyCall.Text := cfgvtwo.glmycall;
     //if mnHavePrefix or mnHaveSuffix Then
     //Begin
     //     if mnHavePrefix then globalData.fullcall := cfgvtwo.Form6.comboPrefix.Items[cfgvtwo.Form6.comboPrefix.ItemIndex] + '/' + cfgvtwo.glmycall;
     //     if mnHaveSuffix then globalData.fullcall := cfgvtwo.glmycall + '/' + cfgvtwo.Form6.comboSuffix.Items[cfgvtwo.Form6.comboSuffix.ItemIndex];
     //End
     //Else
     //Begin
     //     globalData.fullcall := cfgvtwo.glmycall;
     //End;
     //cfgvtwo.Form6.edMyGrid.Text := cfg.StoredValue['grid'];
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['rxCF'],tstint) Then Form1.spinDecoderCF.Value := tstint else Form1.spinDecoderCF.Value := 0;
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['txCF'],tstint) Then Form1.spinTXCF.Value := tstint else Form1.spinTXCF.Value := 0;
     //tstint := 0;
     //Form1.spinDecoderBW.Value := 3;
     //Form1.Edit2.Text := '100';
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['soundin'],tstint) Then cfgvtwo.Form6.cbAudioIn.ItemIndex := tstint else cfgvtwo.Form6.cbAudioIn.ItemIndex := 0;
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['soundout'],tstint) Then cfgvtwo.Form6.cbAudioOut.ItemIndex := tstint else cfgvtwo.Form6.cbAudioOut.ItemIndex := 0;
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['ldgain'],tstint) Then
     //Begin
     //     Form1.TrackBar1.Position := tstint;
     //     //adc.adcLDgain := Form1.TrackBar1.Position;
     //End
     //else
     //Begin
     //     Form1.TrackBar1.Position := 0;
     //     //adc.adcLDgain := Form1.TrackBar1.Position;
     //End;
     //tstint := 0;
     //if TryStrToInt(cfg.StoredValue['rdgain'],tstint) Then
     //Begin
     //     Form1.TrackBar2.Position := tstint;
     //     //adc.adcRDgain := Form1.TrackBar2.Position;
     //End
     //else
     //Begin
     //     Form1.TrackBar2.Position := 0;
     //     //adc.adcRDgain := Form1.TrackBar2.Position;
     //End;
     //Form1.Label10.Caption := 'L: ' + IntToStr(Form1.TrackBar1.Position);
     //Form1.Label11.Caption := 'R: ' + IntToStr(Form1.TrackBar2.Position);
     //If Form1.TrackBar1.Position <> 0 Then Form1.Label10.Font.Color := clRed else Form1.Label10.Font.Color := clBlack;
     //If Form1.TrackBar2.Position <> 0 Then Form1.Label11.Font.Color := clRed else Form1.Label11.Font.Color := clBlack;
     //tstflt := 0.0;
     //if TryStrToFloat(cfg.StoredValue['samfacin'],tstflt) Then cfgvtwo.Form6.edRXSRCor.Text := cfg.StoredValue['samfacin'] else cfgvtwo.Form6.edRXSRCor.Text := '1.0000';
     //tstflt := 0.0;
     //if TryStrToFloat(cfg.StoredValue['samfacout'],tstflt) Then cfgvtwo.Form6.edTXSRCor.Text := cfg.StoredValue['samfacout'] else cfgvtwo.Form6.edTXSRCor.Text := '1.0000';
     //if cfg.StoredValue['audiochan'] = 'L' Then Form1.rbUseLeft.Checked := True;
     //if cfg.StoredValue['audiochan'] = 'R' Then Form1.rbUseRight.Checked := True;
     ////If Form1.rbUseLeft.Checked Then adc.adcChan  := 1;
     ////If Form1.rbUseRight.Checked Then adc.adcChan := 2;
     //if cfg.StoredValue['autoSR'] = '1' Then
     //Begin
     //     cfgvtwo.Form6.chkEnableAutoSR.Checked := True;
     //     cfgvtwo.glautoSR := True;
     //end
     //else
     //begin
     //     cfgvtwo.Form6.chkEnableAutoSR.Checked := False;
     //     cfgvtwo.glautoSR := False;
     //end;
     //cfgvtwo.Form6.editUserDefinedPort1.Text := UpperCase(cfg.StoredValue['pttPort']);
     //if cfg.StoredValue['afc'] = '1' Then Form1.chkAfc.Checked := True Else Form1.chkAfc.Checked := False;
     //If Form1.chkAFC.Checked Then Form1.chkAFC.Font.Color := clRed else Form1.chkAFC.Font.Color := clBlack;
     //if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
     //if cfg.StoredValue['noiseblank'] = '1' Then Form1.chkNB.Checked := True Else Form1.chkNB.Checked := False;
     //If Form1.chkNB.Checked then Form1.chkNB.Font.Color := clRed else Form1.chkNB.Font.Color := clBlack;
     //If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['brightness'],tstint) Then Form1.tbBright.Position := tstint else Form1.tbBright.Position := 0;
     //spectrum.specGain := Form1.tbBright.Position;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['contrast'],tstint) Then Form1.tbContrast.Position := tstint else Form1.tbContrast.Position := 0;
     //spectrum.specContrast := Form1.tbContrast.Position;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['colormap'],tstint) Then Form1.cbSpecPal.ItemIndex := tstint else Form1.cbSpecPal.ItemIndex := 0;
     //spectrum.specColorMap := Form1.cbSpecPal.ItemIndex;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['specspeed'],tstint) Then
     //Begin
     //     Form1.SpinEdit1.Value := tstint;
     //     spectrum.specSpeed2 := tstint;
     //End
     //Else
     //Begin
     //     spectrum.specSpeed2 := 0;
     //     Form1.SpinEdit1.Value := 0;
     //End;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['specVGain'],tstint) Then
     //Begin
     //     Form1.SpinGain.Value := tstint;
     //     spectrum.specVGain := tstint+7;
     //End
     //Else
     //Begin
     //     Form1.SpinGain.Value := 0;
     //     spectrum.specVGain := 7;
     //End;
     //if cfg.StoredValue['saveCSV'] = '1' Then cfgvtwo.Form6.cbSaveCSV.Checked := True else cfgvtwo.Form6.cbSaveCSV.Checked := False;
     //if Length(cfg.StoredValue['csvPath']) > 0 Then cfgvtwo.Form6.DirectoryEdit1.Directory := cfg.StoredValue['csvPath'] else cfgvtwo.Form6.DirectoryEdit1.Directory := globalData.logdir;
     ////if Length(cfg.StoredValue['adiPath']) > 0 Then log.Form2.DirectoryEdit1.Directory := cfg.StoredValue['adiPath'] else log.Form2.DirectoryEdit1.Directory := globalData.logdir;
     //if cfg.StoredValue['version'] <> verHolder.verReturn() Then verUpdate := True else verUpdate := False;
     //if cfg.StoredValue['txWatchDog'] = '1' Then
     //Begin
     //     cfgvtwo.Form6.cbTXWatchDog.Checked := True
     //End
     //else
     //Begin
     //     cfgvtwo.Form6.cbTXWatchDog.Checked := False;
     //End;
     //If TryStrToInt(cfg.StoredValue['txWatchDogCount'],tstint) Then cfgvtwo.Form6.spinTXCounter.Value := tstint else cfgvtwo.Form6.spinTXCounter.Value := 15;
     //if cfg.StoredValue['multiQSOToggle'] = '1' Then cfgvtwo.Form6.cbDisableMultiQSO.Checked := True else cfgvtwo.Form6.cbDisableMultiQSO.Checked := False;
     //if cfg.StoredValue['multiQSOWatchDog'] = '1' Then cfgvtwo.Form6.cbMultiAutoEnable.Checked := True else cfgvtwo.Form6.cbMultiAutoEnable.Checked := False;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['cqColor'],tstint) Then cfgvtwo.Form6.ComboBox1.ItemIndex := tstint else cfgvtwo.Form6.ComboBox1.ItemIndex := 8;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['callColor'],tstint) Then cfgvtwo.Form6.ComboBox2.ItemIndex := tstint else cfgvtwo.Form6.ComboBox2.ItemIndex := 7;
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['qsoColor'],tstint) Then cfgvtwo.Form6.ComboBox3.ItemIndex := tstint else cfgvtwo.Form6.ComboBox1.ItemIndex := 6;
     //Case cfgvtwo.Form6.ComboBox1.ItemIndex of
     //     0  : cfgvtwo.Form6.Edit1.Color := clGreen;
     //     1  : cfgvtwo.Form6.Edit1.Color := clOlive;
     //     2  : cfgvtwo.Form6.Edit1.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.Edit1.Color := clPurple;
     //     4  : cfgvtwo.Form6.Edit1.Color := clTeal;
     //     5  : cfgvtwo.Form6.Edit1.Color := clGray;
     //     6  : cfgvtwo.Form6.Edit1.Color := clSilver;
     //     7  : cfgvtwo.Form6.Edit1.Color := clRed;
     //     8  : cfgvtwo.Form6.Edit1.Color := clLime;
     //     9  : cfgvtwo.Form6.Edit1.Color := clYellow;
     //     10 : cfgvtwo.Form6.Edit1.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.Edit1.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.Edit1.Color := clAqua;
     //     13 : cfgvtwo.Form6.Edit1.Color := clCream;
     //     14 : cfgvtwo.Form6.Edit1.Color := clMedGray;
     //     15 : cfgvtwo.Form6.Edit1.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox1.ItemIndex of
     //     0  : cfgvtwo.Form6.ComboBox1.Color := clGreen;
     //     1  : cfgvtwo.Form6.ComboBox1.Color := clOlive;
     //     2  : cfgvtwo.Form6.ComboBox1.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.ComboBox1.Color := clPurple;
     //     4  : cfgvtwo.Form6.ComboBox1.Color := clTeal;
     //     5  : cfgvtwo.Form6.ComboBox1.Color := clGray;
     //     6  : cfgvtwo.Form6.ComboBox1.Color := clSilver;
     //     7  : cfgvtwo.Form6.ComboBox1.Color := clRed;
     //     8  : cfgvtwo.Form6.ComboBox1.Color := clLime;
     //     9  : cfgvtwo.Form6.ComboBox1.Color := clYellow;
     //     10 : cfgvtwo.Form6.ComboBox1.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.ComboBox1.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.ComboBox1.Color := clAqua;
     //     13 : cfgvtwo.Form6.ComboBox1.Color := clCream;
     //     14 : cfgvtwo.Form6.ComboBox1.Color := clMedGray;
     //     15 : cfgvtwo.Form6.ComboBox1.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox1.ItemIndex of
     //     0  : cfgvtwo.glcqColor := clGreen;
     //     1  : cfgvtwo.glcqColor := clOlive;
     //     2  : cfgvtwo.glcqColor := clSkyBlue;
     //     3  : cfgvtwo.glcqColor := clPurple;
     //     4  : cfgvtwo.glcqColor := clTeal;
     //     5  : cfgvtwo.glcqColor := clGray;
     //     6  : cfgvtwo.glcqColor := clSilver;
     //     7  : cfgvtwo.glcqColor := clRed;
     //     8  : cfgvtwo.glcqColor := clLime;
     //     9  : cfgvtwo.glcqColor := clYellow;
     //     10 : cfgvtwo.glcqColor := clMoneyGreen;
     //     11 : cfgvtwo.glcqColor := clFuchsia;
     //     12 : cfgvtwo.glcqColor := clAqua;
     //     13 : cfgvtwo.glcqColor := clCream;
     //     14 : cfgvtwo.glcqColor := clMedGray;
     //     15 : cfgvtwo.glcqColor := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox2.ItemIndex of
     //     0  : cfgvtwo.Form6.Edit2.Color := clGreen;
     //     1  : cfgvtwo.Form6.Edit2.Color := clOlive;
     //     2  : cfgvtwo.Form6.Edit2.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.Edit2.Color := clPurple;
     //     4  : cfgvtwo.Form6.Edit2.Color := clTeal;
     //     5  : cfgvtwo.Form6.Edit2.Color := clGray;
     //     6  : cfgvtwo.Form6.Edit2.Color := clSilver;
     //     7  : cfgvtwo.Form6.Edit2.Color := clRed;
     //     8  : cfgvtwo.Form6.Edit2.Color := clLime;
     //     9  : cfgvtwo.Form6.Edit2.Color := clYellow;
     //     10 : cfgvtwo.Form6.Edit2.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.Edit2.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.Edit2.Color := clAqua;
     //     13 : cfgvtwo.Form6.Edit2.Color := clCream;
     //     14 : cfgvtwo.Form6.Edit2.Color := clMedGray;
     //     15 : cfgvtwo.Form6.Edit2.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox2.ItemIndex of
     //     0  : cfgvtwo.Form6.ComboBox2.Color := clGreen;
     //     1  : cfgvtwo.Form6.ComboBox2.Color := clOlive;
     //     2  : cfgvtwo.Form6.ComboBox2.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.ComboBox2.Color := clPurple;
     //     4  : cfgvtwo.Form6.ComboBox2.Color := clTeal;
     //     5  : cfgvtwo.Form6.ComboBox2.Color := clGray;
     //     6  : cfgvtwo.Form6.ComboBox2.Color := clSilver;
     //     7  : cfgvtwo.Form6.ComboBox2.Color := clRed;
     //     8  : cfgvtwo.Form6.ComboBox2.Color := clLime;
     //     9  : cfgvtwo.Form6.ComboBox2.Color := clYellow;
     //     10 : cfgvtwo.Form6.ComboBox2.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.ComboBox2.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.ComboBox2.Color := clAqua;
     //     13 : cfgvtwo.Form6.ComboBox2.Color := clCream;
     //     14 : cfgvtwo.Form6.ComboBox2.Color := clMedGray;
     //     15 : cfgvtwo.Form6.ComboBox2.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox2.ItemIndex of
     //     0  : cfgvtwo.glcallColor := clGreen;
     //     1  : cfgvtwo.glcallColor := clOlive;
     //     2  : cfgvtwo.glcallColor := clSkyBlue;
     //     3  : cfgvtwo.glcallColor := clPurple;
     //     4  : cfgvtwo.glcallColor := clTeal;
     //     5  : cfgvtwo.glcallColor := clGray;
     //     6  : cfgvtwo.glcallColor := clSilver;
     //     7  : cfgvtwo.glcallColor := clRed;
     //     8  : cfgvtwo.glcallColor := clLime;
     //     9  : cfgvtwo.glcallColor := clYellow;
     //     10 : cfgvtwo.glcallColor := clMoneyGreen;
     //     11 : cfgvtwo.glcallColor := clFuchsia;
     //     12 : cfgvtwo.glcallColor := clAqua;
     //     13 : cfgvtwo.glcallColor := clCream;
     //     14 : cfgvtwo.glcallColor := clMedGray;
     //     15 : cfgvtwo.glcallColor := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox3.ItemIndex of
     //     0  : cfgvtwo.Form6.Edit3.Color := clGreen;
     //     1  : cfgvtwo.Form6.Edit3.Color := clOlive;
     //     2  : cfgvtwo.Form6.Edit3.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.Edit3.Color := clPurple;
     //     4  : cfgvtwo.Form6.Edit3.Color := clTeal;
     //     5  : cfgvtwo.Form6.Edit3.Color := clGray;
     //     6  : cfgvtwo.Form6.Edit3.Color := clSilver;
     //     7  : cfgvtwo.Form6.Edit3.Color := clRed;
     //     8  : cfgvtwo.Form6.Edit3.Color := clLime;
     //     9  : cfgvtwo.Form6.Edit3.Color := clYellow;
     //     10 : cfgvtwo.Form6.Edit3.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.Edit3.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.Edit3.Color := clAqua;
     //     13 : cfgvtwo.Form6.Edit3.Color := clCream;
     //     14 : cfgvtwo.Form6.Edit3.Color := clMedGray;
     //     15 : cfgvtwo.Form6.Edit3.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox3.ItemIndex of
     //     0  : cfgvtwo.Form6.ComboBox3.Color := clGreen;
     //     1  : cfgvtwo.Form6.ComboBox3.Color := clOlive;
     //     2  : cfgvtwo.Form6.ComboBox3.Color := clSkyBlue;
     //     3  : cfgvtwo.Form6.ComboBox3.Color := clPurple;
     //     4  : cfgvtwo.Form6.ComboBox3.Color := clTeal;
     //     5  : cfgvtwo.Form6.ComboBox3.Color := clGray;
     //     6  : cfgvtwo.Form6.ComboBox3.Color := clSilver;
     //     7  : cfgvtwo.Form6.ComboBox3.Color := clRed;
     //     8  : cfgvtwo.Form6.ComboBox3.Color := clLime;
     //     9  : cfgvtwo.Form6.ComboBox3.Color := clYellow;
     //     10 : cfgvtwo.Form6.ComboBox3.Color := clMoneyGreen;
     //     11 : cfgvtwo.Form6.ComboBox3.Color := clFuchsia;
     //     12 : cfgvtwo.Form6.ComboBox3.Color := clAqua;
     //     13 : cfgvtwo.Form6.ComboBox3.Color := clCream;
     //     14 : cfgvtwo.Form6.ComboBox3.Color := clMedGray;
     //     15 : cfgvtwo.Form6.ComboBox3.Color := clWhite;
     //End;
     //Case cfgvtwo.Form6.ComboBox3.ItemIndex of
     //     0  : cfgvtwo.glqsoColor := clGreen;
     //     1  : cfgvtwo.glqsoColor := clOlive;
     //     2  : cfgvtwo.glqsoColor := clSkyBlue;
     //     3  : cfgvtwo.glqsoColor := clPurple;
     //     4  : cfgvtwo.glqsoColor := clTeal;
     //     5  : cfgvtwo.glqsoColor := clGray;
     //     6  : cfgvtwo.glqsoColor := clSilver;
     //     7  : cfgvtwo.glqsoColor := clRed;
     //     8  : cfgvtwo.glqsoColor := clLime;
     //     9  : cfgvtwo.glqsoColor := clYellow;
     //     10 : cfgvtwo.glqsoColor := clMoneyGreen;
     //     11 : cfgvtwo.glqsoColor := clFuchsia;
     //     12 : cfgvtwo.glqsoColor := clAqua;
     //     13 : cfgvtwo.glqsoColor := clCream;
     //     14 : cfgvtwo.glqsoColor := clMedGray;
     //     15 : cfgvtwo.glqsoColor := clWhite;
     //End;
     //
     //if cfg.StoredValue['catBy'] = 'none' Then
     //Begin
     //     cfgvtwo.Form6.chkUseCommander.Checked := False;
     //     cfgvtwo.Form6.chkUseOmni.Checked := False;
     //     cfgvtwo.Form6.chkUseHRD.Checked := False;
     //     cfgvtwo.glcatBy := 'none';
     //End;
     //if cfg.StoredValue['catBy'] = 'omni' Then
     //Begin
     //     cfgvtwo.Form6.chkUseCommander.Checked := False;
     //     cfgvtwo.Form6.chkUseOmni.Checked := True;
     //     cfgvtwo.Form6.chkUseHRD.Checked := False;
     //     cfgvtwo.glcatBy := 'omni';
     //End;
     //if cfg.StoredValue['catBy'] = 'hamlib' Then
     //Begin
     //     cfgvtwo.Form6.chkUseCommander.Checked := False;
     //     cfgvtwo.Form6.chkUseOmni.Checked := False;
     //     cfgvtwo.Form6.chkUseHRD.Checked := False;
     //     cfgvtwo.glcatBy := 'none';
     //End;
     //if cfg.StoredValue['catBy'] = 'hrd' Then
     //Begin
     //     cfgvtwo.Form6.chkUseCommander.Checked := False;
     //     cfgvtwo.Form6.chkUseOmni.Checked := False;
     //     cfgvtwo.Form6.chkUseHRD.Checked := True;
     //     cfgvtwo.glcatBy := 'hrd';
     //End;
     //if cfg.StoredValue['catBy'] = 'commander' Then
     //Begin
     //     cfgvtwo.Form6.chkUseCommander.Checked := True;
     //     cfgvtwo.Form6.chkUseOmni.Checked := False;
     //     cfgvtwo.Form6.chkUseHRD.Checked := False;
     //     cfgvtwo.glcatBy := 'commander';
     //End;
     //if cfg.StoredValue['pskrCall'] = '' Then cfgvtwo.Form6.editPSKRCall.Text := cfgvtwo.Form6.edMyCall.Text else cfgvtwo.Form6.editPSKRCall.Text := cfg.StoredValue['pskrCall'];
     //if cfg.StoredValue['usePSKR'] = 'yes' Then cfgvtwo.Form6.cbUsePSKReporter.Checked := True else cfgvtwo.Form6.cbUsePSKReporter.Checked := False;
     //if cfg.StoredValue['useRB'] = 'yes' Then cfgvtwo.Form6.cbUseRB.Checked := True else cfgvtwo.Form6.cbUseRB.Checked := False;
     //cfgvtwo.Form6.editPSKRAntenna.Text := cfg.StoredValue['pskrAntenna'];
     //if cfg.StoredValue['optFFT'] = 'on' Then cfgvtwo.Form6.chkNoOptFFT.Checked := False else cfgvtwo.Form6.chkNoOptFFT.Checked := True;
     //if cfg.StoredValue['useAltPTT'] = 'yes' Then cfgvtwo.Form6.cbUseAltPTT.Checked := True else cfgvtwo.Form6.cbUseAltPTT.Checked := False;
     //if cfg.StoredValue['useHRDPTT'] = 'yes' Then cfgvtwo.Form6.chkHRDPTT.Checked := True else cfgvtwo.Form6.chkHRDPTT.Checked := False;
     //if cfg.StoredValue['useCATTxDF'] = 'yes' Then cfgvtwo.Form6.chkTxDFVFO.Checked := True else cfgvtwo.Form6.chkTxDFVFO.Checked := False;
     //
     //cfgvtwo.Form6.edUserQRG1.Text := cfg.StoredValue['userQRG1'];
     //cfgvtwo.Form6.edUserQRG2.Text := cfg.StoredValue['userQRG2'];
     //cfgvtwo.Form6.edUserQRG3.Text := cfg.StoredValue['userQRG3'];
     //cfgvtwo.Form6.edUserQRG4.Text := cfg.StoredValue['userQRG4'];
     //cfgvtwo.Form6.edUserMsg4.Text := cfg.StoredValue['usrMsg1'];
     //cfgvtwo.Form6.edUserMsg5.Text := cfg.StoredValue['usrMsg2'];
     //cfgvtwo.Form6.edUserMsg6.Text := cfg.StoredValue['usrMsg3'];
     //cfgvtwo.Form6.edUserMsg7.Text := cfg.StoredValue['usrMsg4'];
     //cfgvtwo.Form6.edUserMsg8.Text := cfg.StoredValue['usrMsg5'];
     //cfgvtwo.Form6.edUserMsg9.Text := cfg.StoredValue['usrMsg6'];
     //cfgvtwo.Form6.edUserMsg10.Text := cfg.StoredValue['usrMsg7'];
     //cfgvtwo.Form6.edUserMsg11.Text := cfg.StoredValue['usrMsg8'];
     //cfgvtwo.Form6.edUserMsg12.Text := cfg.StoredValue['usrMsg9'];
     //cfgvtwo.Form6.edUserMsg13.Text := cfg.StoredValue['usrMsg10'];
     //
     //Form1.MenuItem22.Caption := cfg.StoredValue['userQRG1'];
     //Form1.MenuItem23.Caption := cfg.StoredValue['userQRG2'];
     //Form1.MenuItem28.Caption := cfg.StoredValue['userQRG3'];
     //Form1.MenuItem29.Caption := cfg.StoredValue['userQRG4'];
     //Form1.MenuItem16.Caption := cfg.StoredValue['usrMsg1'];
     //Form1.MenuItem17.Caption := cfg.StoredValue['usrMsg2'];
     //Form1.MenuItem18.Caption := cfg.StoredValue['usrMsg3'];
     //Form1.MenuItem19.Caption := cfg.StoredValue['usrMsg4'];
     //Form1.MenuItem20.Caption := cfg.StoredValue['usrMsg5'];
     //Form1.MenuItem21.Caption := cfg.StoredValue['usrMsg6'];
     //Form1.MenuItem24.Caption := cfg.StoredValue['usrMsg7'];
     //Form1.MenuItem25.Caption := cfg.StoredValue['usrMsg8'];
     //Form1.MenuItem26.Caption := cfg.StoredValue['usrMsg9'];
     //Form1.MenuItem27.Caption := cfg.StoredValue['usrMsg10'];
     //tstint := 0;
     //d65.glbinspace := 100;
     //
     //if cfg.StoredValue['smooth'] = 'on' Then Form1.cbSmooth.Checked := True else Form1.cbSmooth.Checked := False;
     //if Form1.cbSmooth.Checked Then spectrum.specSmooth := True else spectrum.specSmooth := False;
     //if cfg.StoredValue['restoreMulti'] = 'on' Then cfgvtwo.Form6.cbRestoreMulti.Checked := True else cfgvtwo.Form6.cbRestoreMulti.Checked := False;
     //if cfg.StoredValue['si570mul'] = '1' Then cfgvtwo.Form6.radioSI570X1.Checked := True;
     //if cfg.StoredValue['si570mul'] = '2' Then cfgvtwo.Form6.radioSI570X2.Checked := True;
     //if cfg.StoredValue['si570mul'] = '4' Then cfgvtwo.Form6.radioSI570X4.Checked := True;
     //cfgvtwo.Form6.editSI570FreqOffset.Text := cfg.StoredValue['si570cor'];
     //cfgvtwo.Form6.editSI570Freq.Text := cfg.StoredValue['si570qrg'];
     //if cfg.storedValue['si570ptt'] = 'y' then cfgvtwo.Form6.cbSi570PTT.Checked := True else cfgvtwo.Form6.cbSi570PTT.Checked := False;
     //if cfg.storedValue['si570ptt'] = 'y' then globalData.si570ptt := True else globalData.si570ptt := False;
     //if cfg.storedValue['useCWID'] = 'y' then cfgvtwo.Form6.cbCWID.Checked := True else cfgvtwo.Form6.cbCWID.Checked := False;
     //if cfg.StoredValue['useCATTxDF'] = 'yes' then cfgvtwo.Form6.chkTxDFVFO.Checked := True else cfgvtwo.Form6.chkTxDFVFO.Checked := False;
     //
     //if cfg.StoredValue['enAutoQSY1'] = 'yes' then cfgvtwo.Form6.cbEnableQSY1.Checked := True else cfgvtwo.Form6.cbEnableQSY1.Checked := False;
     //if cfg.StoredValue['enAutoQSY2'] = 'yes' then cfgvtwo.Form6.cbEnableQSY2.Checked := True else cfgvtwo.Form6.cbEnableQSY2.Checked := False;
     //if cfg.StoredValue['enAutoQSY3'] = 'yes' then cfgvtwo.Form6.cbEnableQSY3.Checked := True else cfgvtwo.Form6.cbEnableQSY3.Checked := False;
     //if cfg.StoredValue['enAutoQSY4'] = 'yes' then cfgvtwo.Form6.cbEnableQSY4.Checked := True else cfgvtwo.Form6.cbEnableQSY4.Checked := False;
     //if cfg.StoredValue['enAutoQSY5'] = 'yes' then cfgvtwo.Form6.cbEnableQSY5.Checked := True else cfgvtwo.Form6.cbEnableQSY5.Checked := False;
     //
     //if cfg.StoredValue['autoQSYAT1'] = 'yes' then cfgvtwo.Form6.cbATQSY1.Checked := True else cfgvtwo.Form6.cbATQSY1.Checked := False;
     //if cfg.StoredValue['autoQSYAT2'] = 'yes' then cfgvtwo.Form6.cbATQSY2.Checked := True else cfgvtwo.Form6.cbATQSY2.Checked := False;
     //if cfg.StoredValue['autoQSYAT3'] = 'yes' then cfgvtwo.Form6.cbATQSY3.Checked := True else cfgvtwo.Form6.cbATQSY3.Checked := False;
     //if cfg.StoredValue['autoQSYAT4'] = 'yes' then cfgvtwo.Form6.cbATQSY4.Checked := True else cfgvtwo.Form6.cbATQSY4.Checked := False;
     //if cfg.StoredValue['autoQSYAT5'] = 'yes' then cfgvtwo.Form6.cbATQSY5.Checked := True else cfgvtwo.Form6.cbATQSY5.Checked := False;
     //
     //cfgvtwo.Form6.edQRGQSY1.Text := cfg.StoredValue['autoQSYQRG1'];
     //cfgvtwo.Form6.edQRGQSY2.Text := cfg.StoredValue['autoQSYQRG2'];
     //cfgvtwo.Form6.edQRGQSY3.Text := cfg.StoredValue['autoQSYQRG3'];
     //cfgvtwo.Form6.edQRGQSY4.Text := cfg.StoredValue['autoQSYQRG4'];
     //cfgvtwo.Form6.edQRGQSY5.Text := cfg.StoredValue['autoQSYQRG5'];
     //
     //foo := cfg.StoredValue['autoQSYUTC1'];
     //if TryStrToInt(cfg.StoredValue['autoQSYUTC1'],ifoo) Then
     //Begin
     //     cfgvtwo.Form6.qsyHour1.Value := StrToInt(foo[1..2]);
     //     cfgvtwo.Form6.qsyMinute1.Value := StrToInt(foo[3..4]);
     //end
     //else
     //begin
     //     cfgvtwo.Form6.qsyHour1.Value := 0;
     //     cfgvtwo.Form6.qsyMinute1.Value := 0;
     //end;
     //
     //foo := cfg.StoredValue['autoQSYUTC2'];
     //if TryStrToInt(cfg.StoredValue['autoQSYUTC2'],ifoo) Then
     //Begin
     //     cfgvtwo.Form6.qsyHour2.Value := StrToInt(foo[1..2]);
     //     cfgvtwo.Form6.qsyMinute2.Value := StrToInt(foo[3..4]);
     //end
     //else
     //begin
     //     cfgvtwo.Form6.qsyHour2.Value := 0;
     //     cfgvtwo.Form6.qsyMinute2.Value := 0;
     //end;
     //
     //foo := cfg.StoredValue['autoQSYUTC3'];
     //if TryStrToInt(cfg.StoredValue['autoQSYUTC3'],ifoo) Then
     //Begin
     //     cfgvtwo.Form6.qsyHour3.Value := StrToInt(foo[1..2]);
     //     cfgvtwo.Form6.qsyMinute3.Value := StrToInt(foo[3..4]);
     //end
     //else
     //begin
     //     cfgvtwo.Form6.qsyHour3.Value := 0;
     //     cfgvtwo.Form6.qsyMinute3.Value := 0;
     //end;
     //
     //foo := cfg.StoredValue['autoQSYUTC4'];
     //if TryStrToInt(cfg.StoredValue['autoQSYUTC4'],ifoo) Then
     //Begin
     //     cfgvtwo.Form6.qsyHour4.Value := StrToInt(foo[1..2]);
     //     cfgvtwo.Form6.qsyMinute4.Value := StrToInt(foo[3..4]);
     //end
     //else
     //begin
     //     cfgvtwo.Form6.qsyHour4.Value := 0;
     //     cfgvtwo.Form6.qsyMinute4.Value := 0;
     //end;
     //
     //foo := cfg.StoredValue['autoQSYUTC5'];
     //if TryStrToInt(cfg.StoredValue['autoQSYUTC5'],ifoo) Then
     //Begin
     //     cfgvtwo.Form6.qsyHour5.Value := StrToInt(foo[1..2]);
     //     cfgvtwo.Form6.qsyMinute5.Value := StrToInt(foo[3..4]);
     //end
     //else
     //begin
     //     cfgvtwo.Form6.qsyHour5.Value := 0;
     //     cfgvtwo.Form6.qsyMinute5.Value := 0;
     //end;
     //
     //cfgvtwo.Form6.hrdAddress.Text := cfg.StoredValue['hrdAddress'];
     //globalData.hrdcatControlcurrentRig.hrdAddress := cfgvtwo.Form6.hrdAddress.Text;
     //cfgvtwo.Form6.hrdPort.Text := cfg.StoredValue['hrdPort'];
     //
     //tstint := 0;
     //If TryStrToInt(cfg.StoredValue['hrdPort'],tstint) Then
     //Begin
     //     cfgvtwo.Form6.hrdPort.Text := cfg.StoredValue['hrdPort'];
     //     globalData.hrdcatControlcurrentRig.hrdPort := tstint;
     //end
     //else
     //begin
     //     cfgvtwo.Form6.hrdPort.Text := '7809';
     //     globalData.hrdcatControlcurrentRig.hrdPort := 7809;
     //end;
     //
     //if cfg.StoredValue['version'] <> verHolder.verReturn() Then verUpdate := True else verUpdate := False;
     //
     //if verUpdate Then
     //Begin
     //     cfgvtwo.glmustConfig := True;
     //     cfgvtwo.Form6.Show;
     //     cfgvtwo.Form6.BringToFront;
     //     repeat
     //           sleep(10);
     //           Application.ProcessMessages
     //     until not cfgvtwo.glmustConfig;
     //     cfg.StoredValue['version'] := verHolder.verReturn();
     //     cfg.Save;
     //     dlog.fileDebug('Ran configuration update.');
     //End;

     //With wisdom comes speed.
     end;
     d65.glfftFWisdom := 0;
     d65.glfftSWisdom := 0;
     //if not cfgvtwo.Form6.chkNoOptFFT.Checked Then
     //Begin
     //     fname := globalData.cfgdir+'\wisdom2.dat';
     //     if FileExists(fname) Then
     //     Begin
     //          // I have data for FFTW_MEASURE metrics use ical settings in
     //          // decode65 for measure.
     //          d65.glfftFWisdom := 1;  // Causes measure wisdom to be loaded on first pass of decode65
     //          d65.glfftSWisdom := 11; // uses measure wisdom (no load/no save) on != first pass of decode65
     //          dlog.fileDebug('Imported FFTW3 Wisdom.');
     //     End
     //     Else
     //     Begin
     //          dlog.fileDebug('FFT Wisdom missing... you should run optfft');
     //     End;
     //End
     //Else
     //Begin
     //     d65.glfftFWisdom := 0;
     //     d65.glfftSWisdom := 0;
     //     dlog.fileDebug('Running without optimal FFT enabled by user request.');
     //End;

     // Setup input device
     //dlog.fileDebug('Setting up ADC.');
     //foo := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     //paInParams.device := StrToInt(foo[1..2]);
     //paInParams.sampleFormat := paInt16;
     //paInParams.suggestedLatency := 1;
     //paInParams.hostApiSpecificStreamInfo := Nil;
     //ppaInParams := @paInParams;
     // Set rxBuffer index to start of array.
     //adc.d65rxBufferIdx := 0;
     //adc.adcT := 0;
     // Set ptr to start of buffer.
     //adc.d65rxBufferPtr := @adc.d65rxBuffer[0];
     // Initialize rx stream.
     //paInParams.channelCount := 2;
     //paResult := portaudio.Pa_OpenStream(paInStream,ppaInParams,Nil,11025,2048,0,@adc.adcCallback,Pointer(Self));
     //if paResult <> 0 Then
     //Begin
     //     ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)) + ' Could not setup for stereo input.  Please check your setup.');
     //end
     //else
     //begin
     //    paResult := portaudio.Pa_StartStream(paInStream);
     //end;
     // Start the stream.
     //if paResult <> 0 Then
     //Begin
     //     ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)));
     //End;
     // Setup output device
     //dlog.fileDebug('Setting up DAC.');
     //foo := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     //paOutParams.device := StrToInt(foo[1..2]);
     //paOutParams.sampleFormat := paInt16;
     //paOutParams.suggestedLatency := 1;
     //paOutParams.hostApiSpecificStreamInfo := Nil;
     //ppaOutParams := @paOutParams;
     // Set txBuffer index to start of array.
     //dac.d65txBufferIdx := 0;
     //dac.dacT := 0;
     // Set ptr to start of buffer.
     //dac.d65txBufferPtr := @dac.d65txBuffer[0];
     // Initialize tx stream.
     //paOutParams.channelCount := 2;
     //paResult := portaudio.Pa_OpenStream(paOutStream,Nil,ppaOutParams,11025,2048,0,@dac.dacCallback,Pointer(Self));
     //if paResult <> 0 Then
     //Begin
     //     ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)));
     //     //Need to exit this puppy, pa is dead.
     //End;
     //// Start the stream.
     //paResult := portaudio.Pa_StartStream(paOutStream);
     //if paResult <> 0 Then
     //Begin
     //     ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)));
     //End;
     //if cfgvtwo.Form6.cbUsePSKReporter.Checked Then
     //Begin
     //     // Initialize PSK Reporter DLL
     //     If PSKReporter.ReporterInitialize('report.pskreporter.info','4739') = 0 Then pskrstat := 1 else pskrstat := 0;
     //     Form1.cbEnPSKR.Checked := True;
     //End
     //Else
     //Begin
     //     Form1.cbEnPSKR.Checked := False;
     //end;
     //if cfgvtwo.Form6.cbUseRB.Checked then Form1.cbEnRB.Checked := True else Form1.cbEnRB.Checked := False;
     // Create and initialize TWaterfallControl
     Waterfall := TWaterfallControl.Create(Self);
     Waterfall.Height := 180;
     Waterfall.Width  := 750;
     Waterfall.Top    := 25;
     Waterfall.Left   := 177;
     Waterfall.Parent := Self;
     Waterfall.OnMouseDown := waterfallMouseDown;
     Waterfall.DoubleBuffered := True;
     //
     // Initialize various form items to startup values
     //
     st := utcTime();
     thisMinute := st.Minute;
     if st.Minute = 0 then
     Begin
          lastMinute := 59;
     End
     Else
     Begin
          lastMinute := st.Minute-1;
     End;
     if st.Minute = 59 then
     Begin
          nextMinute := 0;
     End
     Else
     Begin
          nextMinute := st.Minute+1;
     End;
     // Setup rbstats
     i := 0;
     while i < 500 do
     begin
          rbsHeardList[i].callsign := '';
          rbsHeardList[i].count := 0;
          rbc.glrbsLastCall[i] := '';
          inc(i);
     end;
     rbc.glrbsSentCount := 0;
     //rbc.glrbCallsign := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
End;

procedure TForm1.updateSR();
//Var
//   errthresh, sr, aerr, derr, erate : CTypes.cdouble;
Begin
     // globalData.erate represents the sampling error rate for the last call to
     // adc unit.  This moves around a lot so one needs to take an average to
     // really see a correct figure.  Same applies to dac unit, it's all the same
     // code, just different vars.
     // Will use the following vars to keep the running average adc error rate..
     // globalData.erate Represents current calculated error rate
     // adLErate   Represents the previous returned error rate
     // adAErate   Sum of (up to) last 10 new erates
     // adError    average error rate (= adAErate/adCount)
     // adCount    averaging divider
     // When program starts adErate, adLErate, adAErate, adError, adCount and
     // globalData.erate will all equal 0.  What I need to look for is erate not
     // equal 0 allowing me to set adLErate = adErate = erate as an initial val.
     // Then when adLErate not equal to erate I will update adAErate with sum of
     // itself + new error rate, increment adCount and comput adError as asAErate
     // divided by adCount.  I think.
     // Update RX Sample Error Rate display.
     //haveRXSRerr := False;
     //haveTXSRerr := False;
     //If cfgvtwo.glautoSR Then errThresh := 0.0001 Else errThresh := 0.0005;
     //If (adError = 0) and (thisAction > 1) Then rxsrs := '';
     //If (adError = 0) and (thisAction = 1) Then rxsrs := '';
     //If adcErate <> 0 Then
     //Begin
     //     if adCount = 0 Then adCount := 1;
     //     if adLErate <> adcErate Then
     //     Begin
     //          // New error rate available.
     //          if (adcErate < 100) And (adcErate > -100) Then
     //          Begin
     //               adAErate := adAErate + adcErate;
     //               adLErate := adcErate;
     //               inc(adCount);
     //               adError := adAErate / adCount;
     //               if adCount >=50 Then
     //               Begin
     //                    adCount := 1;
     //                    adAErate := adError;
     //               End;
     //          End;
     //     End;
     //     rxsrs := 'RX SR:  ' + FormatFloat('0.0000',adError);
     //     sr := 1.0;
     //     if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then
     //        sr := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text)
     //     else
     //        sr := 1.0;
     //     aErr := adError-sr;
     //     if (aErr > (0.0+errThresh)) or (aErr < (0.0-0.0005)) Then
     //     Begin
     //          if cfgvtwo.glautoSR Then cfgvtwo.Form6.edRXSRCor.Text := FormatFloat('0.0000',adError);
     //          haveRXSRerr := True;
     //     End
     //     Else
     //     Begin
     //          haveRXSRerr := False;
     //     End;
     //End;
     // Update TX Sample Error Rate display.
     //If (dErrError = 0) and (thisAction > 1) Then txsrs := '';
     //If (dErrError = 0) and (thisAction = 1) Then txsrs := '';
     //erate := dac.dacErate;
     //If erate <> 0 Then
     //Begin
     //     if dErrCount = 0 Then dErrCount := 1;
     //     if dErrLErate <> erate Then
     //     Begin
     //          // New error rate available.
     //          if (erate < 100) And (erate > -100) Then
     //          Begin
     //               dErrAErate := dErrAErate + erate;
     //               dErrLErate := erate;
     //               inc(dErrCount);
     //               dErrError := dErrAErate / dErrCount;
     //               if dErrCount >=50 Then
     //               Begin
     //                    dErrCount := 1;
     //                    dErrAErate := dErrError;
     //               End;
     //          End;
     //     End;
     //     txsrs := 'TX SR:  ' + FormatFloat('0.0000',dErrError);
     //     sr := 1.0;
     //     if tryStrToFloat(cfgvtwo.Form6.edTXSRCor.Text,sr) Then
     //        sr := StrToFloat(cfgvtwo.Form6.edTXSRCor.Text)
     //     else
     //        sr := 1.0;
     //     dErr := dErrError-sr;
     //     if (dErr > (0.0+errThresh)) or (dErr < (0.0-errThresh)) Then
     //     Begin
     //          if cfgvtwo.glautoSR Then cfgvtwo.Form6.edTXSRCor.Text := FormatFloat('0.0000',dErrError);
     //          haveTXSRerr := True;
     //     End
     //     Else
     //     Begin
     //          haveTXSRerr := False;
     //     End;
     //End;
     //sr := 1.0;
     //if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then
        //globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text)
     //else
        //globalData.d65samfacin := 1.0;
End;

procedure TForm1.genTX1();
Var
   txdf, nwave, i : CTypes.cint;
   txsr, freqcw   : CTypes.cdouble;
Begin
     // Generate TX samples for a normal TX Cycle.
     // curMsg holds text to TX
     // A JT65 TX sequence runs 46.8 Seconds starting at 1 second into
     // minute, ending at 47.8 seconds.  Here I will raise PTT at second
     // = 0.  By adding 1 second of silence to the TX output I will have
     // a total TX buffer length of 1 second silence + 46.8 seconds of data
     // + 1 second of silence (last silence period allows TX buffer to
     // flush before lowering PTT) for a total buffer length of 48.8 seconds
     // or 538020 samples (262.7 2K buffers).  Raising upper bound to an
     // even 2K multiple gives me 538624 samples or 263 2K buffers.
     if useBuffer = 0 Then
     Begin
          curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     End;
     if useBuffer = 1 Then
     Begin
          curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
          //if cfgvtwo.Form6.cbCWID.Checked Then doCWID := True else doCWID := False;
     End;
     if Length(TrimLeft(TrimRight(curMsg)))>1 Then
     Begin
          StrPCopy(d65txmsg, curMsg);
          d65.glmode65 := 1;
          txdf := 0;
          txdf := Form1.spinTXCF.Value;
          d65nwave := 0;
          d65sendingsh := -1;
          d65nmsg := 0;
          txsr := 1.0;
          //if tryStrToFloat(cfgvtwo.Form6.edTXSRCor.Text,txsr) Then d65samfacout := StrToFloat(cfgvtwo.Form6.edTXSRCor.Text) else d65samfacout := 1.0;
          // Insert .3 second or 3307 samples of silence
          // .3 Seconds of prepended silence seems to get the timing right,
          // at least on my specific system.  Not sure if this will carry
          // correctly to others.
          for mnlooper := 0 to  3306 do
          begin
               //dac.d65txBuffer[mnlooper] := 0;
          end;
          //if txMode = 65 then encode65.gen65(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);
          //if txMode =  4 Then  encode65.gen4(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);
          //if txMode =  4 Then  encode65.gen4(d65txmsg,@txdf,@mdac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);

          //
          // Now I want to pad the data to length of txBuffer with silence
          // so there's no chance of sending anything other than generated
          // samples or silence...
          //
          mnlooper := d65nwave;
          // CW ID Handler
          if doCWID Then
          Begin
               diagout.Form3.ListBox3.Clear;
               doCWID := False;
               // Add 1s silence between end of JT65 and start of CW ID
               for mnlooper := mnlooper to mnlooper + 11025 do
               begin
                    //dac.d65txBuffer[mnlooper] := 0;
               end;
               // Gen CW ID
               for i := 0 to 110249 do
               begin
                    encode65.e65cwid[i] := 0; // Clear CW ID Buffer
               end;
               StrPCopy(cwidMsg,UpCase(padRight(globalData.fullcall,22)));
               if txdf < 0 Then
               Begin
                    freqcw := (1270-abs(txdf))-50;
               End;
               if txdf > 0 Then
               Begin
                    freqcw := (1270+txdf)-50;
               End;
               if txdf = 0 Then
               Begin
                    freqcw := 1220.0;
               End;
               if freqcw < 300.0 then freqcw := 300.0;
               if freqcw > 2270.0 then freqcw := 2270.0;
               diagout.Form3.ListBox3.Items.Add('CW ID Au=' + FloatToStr(freqcw) + ' Hz');
               nwave := 0;
               encode65.genCW(cwidMsg,@freqcw,@encode65.e65cwid[0],@nwave);
               //subroutine gencwid(msg,freqcw,iwave,nwave)
               // Append CW ID.  nwave is length of CWID samples buffer.
               if mnlooper+nwave < 661504 Then
               Begin
                    for i := 0 to nwave-1 do
                    begin
                         //dac.d65txBuffer[mnlooper] := encode65.e65cwid[i];
                         inc(mnlooper);
                    end;
               End
               Else
               Begin
                    // CW ID too long... so we will not do it.
                    for i := mnlooper to 661503 do
                    begin
                         //dac.d65txBuffer[i] := 0;
                    end;
               End;
               // Finish buffer to end with silence.
               for i := mnlooper to 661503 do
               begin
                    //dac.d65txBuffer[i] := 0;
               end;
          End
          Else
          Begin
               for i := mnlooper to 661503 do
               begin
                    //dac.d65txBuffer[i] := 0;
               end;
          End;
          // I now have a set of samples representing the JT65A audio
          // tones in txBuffer with nwave indicating number of samples
          // generated.
          d65nwave := mnlooper;
          TxValid := True;
          TxDirty := False;
          thisTX := curMsg + IntToStr(txdf);
          if lastTX <> thisTX Then
          Begin
               txCount := 0;
               lastTX := thisTX;
          End
          Else
          Begin
               inc(txCount);
          End;
          thisAction := 3;
          actionSet := True;
     End
     Else
     Begin
          globalData.txInProgress := False;
          rxInProgress := False;
          form1.chkEnTX.Checked := False;
          TxValid := False;
          TxDirty := True;
          thisAction := 2;
          lastTX := '';
          actionSet := False;
     End;
End;

procedure TForm1.genTX2();
Var
   txdf : CTypes.cint;
   txsr : CTypes.cdouble;
Begin
     // Generate TX samples for a late starting TX Cycle.
     if useBuffer = 0 Then
     Begin
          curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     End;
     if useBuffer = 1 Then
     Begin
          curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
     End;
     if Length(TrimLeft(TrimRight(curMsg)))>1 Then
     Begin
          StrPCopy(d65txmsg, curMsg);
          d65.glmode65 := 1;
          txdf := 0;
          txdf := Form1.spinTXCF.Value;
          d65nwave := 0;
          d65sendingsh := -1;
          d65nmsg := 0;
          txsr := 1.0;
          //if tryStrToFloat(cfgvtwo.Form6.edTXSRCor.Text,txsr) Then d65samfacout := StrToFloat(cfgvtwo.Form6.edTXSRCor.Text) else d65samfacout := 1.0;
          // Generate samples.
          //if txMode = 65 Then encode65.gen65(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);

          //if txMode =  4 Then  encode65.gen4(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);
          //if txMode =  4 Then  encode65.gen4(d65txmsg,@txdf,@mdac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);

          // Now I want to pad the data to length of txBuffer with silence
          mnlooper := d65nwave;
          while mnlooper < 661504 do
          begin
               //dac.d65txBuffer[mnlooper] := 0;
               inc(mnlooper);
          end;
          d65nwave := 538624;
          TxValid := True;
          TxDirty := False;
          thisTX := curMsg + IntToStr(txdf);
          if lastTX <> thisTX Then
          Begin
               txCount := 0;
               lastTX := thisTX;
          End
          Else
          Begin
               inc(txCount);
          End;
          thisAction := 6;
          actionSet := True;
     End
     Else
     Begin
          globalData.txInProgress := False;
          rxInProgress := False;
          form1.chkEnTX.Checked := False;
          TxValid := False;
          TxDirty := True;
          thisAction := 2;
          actionSet := False;
          lastTX := '';
     End;
End;

procedure TForm1.audioChange();
//Var
   //foo : String;
Begin
     // Need to change audio input device
     //paResult := portaudio.Pa_AbortStream(paInStream);
     //foo := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     //paInParams.device := StrToInt(foo[1..2]);
     //paInParams.sampleFormat := paInt16;
     //paInParams.suggestedLatency := 1;
     //paInParams.hostApiSpecificStreamInfo := Nil;
     //ppaInParams := @paInParams;
     //adc.d65rxBufferIdx := 0;

     //adc.adcT := 0;

     //paInParams.channelCount := 2;
     //paResult := portaudio.Pa_OpenStream(paInStream,ppaInParams,Nil,11025,2048,0,@adc.adcCallback,Pointer(Self));
     //if paResult = 0 Then
     //Begin
     //     paResult := portaudio.Pa_StartStream(paInStream);
     //end
     //else
     //begin
     //     ShowMessage('Unable to open audio device properly.  Please select another then restart program.');
     //end;

     // Need to change audio output device
     //paResult := portaudio.Pa_AbortStream(paOutStream);
     //paResult := portaudio.Pa_CloseStream(paOutStream);
     //
     //foo := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     //paOutParams.device := StrToInt(foo[1..2]);
     //paOutParams.sampleFormat := paInt16;
     //paOutParams.suggestedLatency := 1;
     //paOutParams.hostApiSpecificStreamInfo := Nil;
     //ppaOutParams := @paOutParams;
     //dac.d65txBufferIdx := 0;

     dErrCount := 0;
     adCount := 0;
     //dac.dacT := 0;

     //paOutParams.channelCount := 2;
     //paResult := portaudio.Pa_OpenStream(paOutStream,Nil,ppaOutParams,11025,2048,0,@dac.dacCallback,Pointer(Self));
     //if paresult = 0 Then
     //Begin
     //     paResult := portaudio.Pa_StartStream(paOutStream);
     //End
     //Else
     //Begin
     //     ShowMessage('Unable to open audio device properly.  Please select another then restart program.');
     //End;
     //cfgvtwo.gld65AudioChange := False;
End;

procedure TForm1.rbThreadCheck();
Var
   ts     : TDateTime;
   tscalc : Double;
   i      : Integer;
Begin
     ts := Now;
     If rbc.glrbActive Then
     Begin
          // Compare timestamp in ts to globalData.rbEnterTS and if difference
          // is greater than 90 seconds I will need to assume rbc thread has
          // gone astray.
          tscalc := SecondSpan(ts,rbc.glrbEnterTS);
          If tscalc > 90 Then
          Begin
               // rb thread was started at least 90 seconds ago and is, seemingly,
               // stuck.  Now the question is what to do about it.  Perhaps the
               // most solid method will be to suspend its thread, terminate the
               // thread, dispose of the thread and re-create it.  If that doesn't
               // clear it I don't know what else will. ;)
               rbThread.Suspend;
               rbThread.Terminate;
               rbThread.Destroy;
               // This is probably undesirable, but, for now, I am going to clear
               // the entire rbReports array to prevent an invalid entry in the
               // structure from triggering a slow speed loop.  i.e. rb hangs,
               // it's terminated then hangs again on restarting due to something
               // in the rbReports array being processed again.
               for i := 0 to 499 do
               Begin
                    rbc.glrbReports[i].rbProcessed := True;
               End;
               rbThread := rbcThread.Create(False);
               rbc.glrbActive := False;
               dlog.fileDebug('RBC Thread was reinitialized due to detection of lockup.');
          End;
     End;
End;

procedure TForm1.myCallCheck();
Begin
     //if cfgvtwo.glCallChange Then
     //Begin
     //     if (cfgvtwo.Form6.comboPrefix.ItemIndex > 0) And (cfgvtwo.Form6.comboSuffix.ItemIndex > 0) Then cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
     //     if cfgvtwo.Form6.comboPrefix.ItemIndex > 0 then mnHavePrefix := True else mnHavePrefix := False;
     //     if cfgvtwo.Form6.comboSuffix.ItemIndex > 0 then mnHaveSuffix := True else mnHaveSuffix := False;
     //     cfgvtwo.Form6.edMyCall.Text := cfgvtwo.glmycall;
     //     if mnHavePrefix or mnHaveSuffix Then
     //     Begin
     //          if mnHavePrefix then globalData.fullcall := cfgvtwo.Form6.comboPrefix.Items[cfgvtwo.Form6.comboPrefix.ItemIndex] + '/' + cfgvtwo.glmycall;
     //          if mnHaveSuffix then globalData.fullcall := cfgvtwo.glmycall + '/' + cfgvtwo.Form6.comboSuffix.Items[cfgvtwo.Form6.comboSuffix.ItemIndex];
     //     End
     //     Else
     //     Begin
     //          globalData.fullcall := cfgvtwo.glmycall;
     //     End;
     //End;
End;

procedure TForm1.txControls();
Var
   enredec, txOdd, valTX : Boolean;
Begin

     if globalData.txInProgress Then
     Begin
          Form1.Label8.Caption := 'Transmitting: ' + lastMsg;
          Form1.Label8.Visible := True;
          Form1.Label50.Caption := 'TX IN PROGRESS';
     End
     Else
     Begin
          If form1.chkEnTX.Checked Then Form1.Label50.Caption := 'TX ENABLED';
          If not form1.chkEnTX.Checked Then Form1.Label50.Caption := 'TX OFF';
          if Length(TrimLeft(TrimRight(curMsg)))>1 Then
          Begin
               Form1.Label8.Caption := 'Message To TX: ' + curMsg;
               Form1.Label8.Visible := True;
          End
          Else
          Begin
               Form1.Label8.Caption := 'Message To TX:  No message entered.';
               Form1.Label8.Visible := True;
          End;
     End;

     valTX := False;
     if (Length(TrimLeft(TrimRight(Form1.edMsg.Text)))>1) And (useBuffer=0) Then valTx := True;
     if (Length(TrimLeft(TrimRight(Form1.edFreeText.Text)))>1) And (useBuffer=1) Then valTx := True;

     if not valTX and not globalData.txInProgress Then form1.chkEnTx.checked := False;

     if valTX and not form1.chkEnTx.checked Then form1.btnEngageTx.Enabled := True else form1.btnEngageTx.Enabled := False;
     if globalData.txInProgress or txNextPeriod or (nextAction = 3) or form1.chkEnTX.checked Then form1.btnHaltTx.Enabled := True else form1.btnHaltTx.Enabled := False;

     // Automatic TX checkbox.
     If Form1.chkEnTX.Checked Then
     Begin
          // Changing this to allow late (up to 15 seconds) start.  It seems a necessary
          // evil.
          txOdd  := False;
          if form1.rbTX2.Checked Then txOdd := True else txOdd := False;
          if (thisSecond < 16) and not actionSet Then
          Begin
               // Since thisSecond is 0..15 we can check to see if a late TX start
               // could work.
               if txOdd and Odd(thisMinute) Then
               Begin
                    // yes, I can start this period.
                    thisAction := 6;
                    nextAction := 2;
               End;
               if not txOdd and not Odd(thisMinute) Then
               Begin
                    // yes, I can start this period.
                    thisAction := 6;
                    nextAction := 2;
               End;
          End
          Else
          Begin
               txNextPeriod := True;
          End;
     End
     Else
     Begin
          txNextPeriod := False;
          if nextAction = 3 then nextAction := 2;
     End;
     If txNextPeriod Then
     Begin
          // A TX cycle has been requested.  Determine if this can happen next
          // minute and, if so, setup to do so.
          // To accomplish this I need to look at requested TX period setting
          // and value of next minute.  If requested tx period and value of
          // next minute match (even/odd) then I will set nextAction to tx.
          nextAction := 2;
          if Form1.rbTX2.Checked And Odd(nextMinute) Then
          Begin
               nextAction := 3;
          End
          Else
          Begin
               if Form1.rbTX1.Checked And Not Odd(nextMinute) Then nextAction := 3;
          End;
     End;
     enredec := True;
     if globalData.txInProgress then enredec := False;
     if (thisSecond > 30) and (thisSecond < 50) then enredec := False;
     if d65.glinprog then enredec := False;
     if not haveOddBuffer and not haveEvenBuffer then enredec := False;
     if enredec then Form1.btnReDecode.Enabled := True else Form1.btnReDecode.Enabled := False;
     if (globalData.gmode = 0) and (txMode = 0) Then btnEngageTx.enabled := False;
End;

procedure TForm1.processOngoing();
Var
   foo : String;
   i   : Integer;
Begin
     //
     // I am currently in one of the following states;
     //
     // 1:  Waiting to begin an RX or TX cycle, i.e. initializing
     //     from a program startup.
     //
     // 2:  In a RX cycle getting data from the sound device
     //
     // 3:  In a TX cycle putting data to the sound device
     //
     // 4:  Decoding RX data (this can, and likely will overlap with
     //     states 2 and 3 especially when doing multi-decode).
     //
     // 5:  Idle.  Idle is typically the interval between ending a TX
     //     data event and starting a new cycle.
     //
     // Actions for state 1:
     //         Program starup, idle until top of new minute.
     //         Display condition in StatusBar
     //
     // Actions for state 2:
     //         Trigger decode if a full sequence has been captured.
     //         Display condition in StatusBar.
     //
     // Actions for state 3:
     //         Lower PTT if a full sequence has been sent.
     //         Display condition in StatusBar.
     //
     // Actions for state 4:
     //         None.  The deoder runs in its own thread so once
     //         dispatched it does its own thing until complete.
     //         The main program cares not what it does other than
     //         giving the user a que that it's running and then
     //         displaying the result(s).
     //
     // Actions for state 5:
     //         None.  Sit back, relax and enjoy the few seconds between
     //         end of TX and start of next cycle. ;)
     //
     //
     // Actions for state 6:
     //         Begin a late sequence TX.
     //
     // State 2 (RX sequence)
     //
     If thisAction = 2 then
     Begin
          //
          // In this action I need to monitor the position of the rxBuffer
          // index and trigger a decode cycle when it's at proper length.
          //
          // I have a full RX buffer when d65rxBufferIdx >= 533504
          // For RX I need to scale progress bar for RX display
          if not rxInProgress Then
          Begin
               Form1.ProgressBar3.Max := 533504;
               globalData.txInProgress := False;
               rxInProgress := True;
               //adc.d65rxBufferIdx := 0;

               nextAction := 2; // As always, RX assumed to be next.
               inc(rxCount);
               //if watchMulti and cfgvtwo.Form6.cbMultiAutoEnable.Checked and (rxCount > 2) Then
               //Begin
               //     rxCount := 0;
               //     watchMulti := False;
               //     Form1.spinDecoderCF.Value := preRXCF;
               //     Form1.spinTXCF.Value := preTXCF;
               //     if form1.chkAutoTxDF.Checked Then
               //     Begin
               //          form1.spinTXCF.Value := form1.spinDecoderCF.Value;
               //     End;
               //     Form1.chkMultiDecode.Checked := True;
               //End;
               if rxCount > 5 then rxCount := 0;
          End
          Else
          Begin
               // Code that only executes while in an active RX cycle.
               //Form1.ProgressBar3.Position := adc.d65rxBufferIdx;

               rxInProgress := True;
               globalData.txInProgress := False;

               //If adc.d65rxBufferIdx >= 533504 Then
               //Begin
               //     // Get End of Period QRG
               //     eopQRG := globalData.gqrg;
               //     // Switch to decoder action
               //     thisAction := 4;
               //     rxInProgress := False;
               //     globalData.txInProgress := False;
               //End;
          End;
     End;
     //
     // State 3 (TX Sequence)
     //
     If thisAction = 3 then
     Begin
          //
          // In this action I need to monitor the position of the txBuffer
          // index and end tx cycle when it's at proper length.
          //
          // I have a full TX cycle when d65txBufferIdx >= 538624
          if not globalData.txInProgress Then
          Begin
               // Force TX Sample generation.
               TxDirty := True;
               // generate the txBuffer
               genTX1();
               //if not cfgvtwo.Form6.cbTXWatchDog.Checked Then txCount := 0;
               //if txCount < cfgvtwo.Form6.spinTXCounter.Value Then
               //Begin
               //     // Flag TX Buffer as valid.
               //     lastMsg := curMsg;
               //     // Fire up TX
               //     if not TxDirty and TxValid Then
               //     Begin
               //          // For TX I need to scale progress bar for TX display
               //          Form1.ProgressBar3.Max := d65nwave;
               //          rxInProgress := False;
               //          nextAction := 2;
               //          //dac.d65txBufferIdx := 0;
               //
               //          //dac.d65txBufferPtr := @dac.d65txBuffer[0];
               //
               //          rxCount := 0;
               //          if getPTTMethod() = 'SI5' Then si570Raiseptt();
               //          if getPTTMethod() = 'HRD' Then hrdRaisePTT();
               //          if getPTTMethod() = 'ALT' Then altRaisePTT();
               //          if getPTTMethod() = 'PTT' Then raisePTT();
               //          globalData.txInProgress := True;
               //          foo := '';
               //          if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
               //          if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
               //          Form1.addToDisplayTX(lastMsg);
               //          // Add TX to log if enabled.
               //          if cfgvtwo.Form6.cbSaveCSV.Checked Then
               //          Begin
               //               foo := '"';
               //               foo := foo + IntToStr(gst.Year) + '-';
               //               if gst.Month < 10 Then foo := foo + '0' + IntToStr(gst.Month) + '-' else foo := foo + IntToStr(gst.Month) + '-';
               //               if gst.Day < 10 Then foo := foo + '0' + IntToStr(gst.Day) else foo := foo + IntToStr(gst.Day);
               //               foo := foo + '"' + ',';
               //               if gst.Hour < 10 Then foo := foo + '"' + '0' + IntToStr(gst.Hour) + ':' else foo := foo + '"' + IntToStr(gst.Hour) + ':';
               //               if gst.Minute < 10 Then foo := foo +'0' + IntToStr(gst.Minute) + '"' + ',' else foo := foo + IntToStr(gst.Minute) + '"' +',';
               //               foo := foo + '"-","-","-","-","T","' + lastMsg + '"';
               //               for i := 0 to 99 do
               //               begin
               //                    if csvEntries[i] = '' Then
               //                    Begin
               //                         csvEntries[i] := foo;
               //                         break;
               //                    end;
               //               end;
               //               form1.saveCSV();
               //          End;
               //     End
               //     Else
               //     Begin
               //          form1.chkEnTX.Checked := False;
               //          thisAction := 2;
               //          nextAction := 2;
               //          globalData.txInProgress := False;
               //          rxInProgress := False;
               //     End;
               //End
               //Else
               //Begin
               //     txCount := 0;
               //     lastTX := '';
               //     Form1.chkEnTX.Checked := False;
               //     diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent 15 times.');
               //     diagout.Form3.Show;
               //     diagout.Form3.BringToFront;
               //End;
          End
          Else
          Begin
               globalData.txInProgress := True;
               rxInProgress := False;
               //if (dac.d65txBufferIdx >= d65nwave+11025) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Then
               //Begin
               //     globalData.txInProgress := False;
               //     if getPTTMethod() = 'SI5' Then si570Lowerptt();
               //     if getPTTMethod() = 'HRD' Then hrdLowerPTT();
               //     if getPTTMethod() = 'ALT' Then altLowerPTT();
               //     if getPTTMethod() = 'PTT' Then lowerPTT();
               //     thisAction := 5;
               //     actionSet := False;
               //     curMsg := '';
               //End;
               //Form1.ProgressBar3.Position := dac.d65txBufferIdx;
          End;
     End;
     //
     // State 4 (Decode Sequence)
     //
     If thisAction = 4 then
     Begin
          initDecode();
          // It's critical that state be set to anything but 4 after
          // initDecode is called.
          thisAction := 5;
     End;
     //
     // State 5 (Idle Sequence)
     //
     If thisAction = 5 then
     Begin
          // Enjoy the time off.
     End;
     //
     // State 6 (Late Start TX Sequence)
     If thisAction = 6 then
     Begin
          // Late start TX sequence requested.
          If not globalData.txInProgress Then
          Begin
               // Starting a late sequence TX
               // Generate TX Samples
               TxDirty := True;
               genTX2();
               //if not cfgvtwo.Form6.cbTXWatchDog.Checked Then txCount := 0;
               //if txCount < cfgvtwo.Form6.spinTXCounter.Value Then
               //Begin
               //     // Flag TX Buffer as valid.
               //     lastMsg := curMsg;
               //     // Fire up TX
               //     if not TxDirty and TxValid Then
               //     Begin
               //          // For TX I need to scale progress bar for TX display
               //          Form1.ProgressBar3.Max := 538624;
               //          rxInProgress := False;
               //          nextAction := 2;
               //          //dac.d65txBufferIdx := 0;
               //
               //          //dac.d65txBufferPtr := @dac.d65txBuffer[0];
               //
               //          rxCount := 0;
               //          if getPTTMethod() = 'SI5' Then si570Raiseptt();
               //          if getPTTMethod() = 'HRD' Then hrdRaisePTT();
               //          if getPTTMethod() = 'ALT' Then altRaisePTT();
               //          if getPTTMethod() = 'PTT' Then raisePTT();
               //          globalData.txInProgress := True;
               //          foo := '';
               //          if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
               //          if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
               //          form1.addToDisplayTX(lastMsg);
               //          // Add TX to log if enabled.
               //          if cfgvtwo.Form6.cbSaveCSV.Checked Then
               //          Begin
               //               foo := '"';
               //               foo := foo + IntToStr(gst.Year) + '-';
               //               if gst.Month < 10 Then foo := foo + '0' + IntToStr(gst.Month) + '-' else foo := foo + IntToStr(gst.Month) + '-';
               //               if gst.Day < 10 Then foo := foo + '0' + IntToStr(gst.Day) else foo := foo + IntToStr(gst.Day);
               //               foo := foo + '"' + ',';
               //               if gst.Hour < 10 Then foo := foo + '"' + '0' + IntToStr(gst.Hour) + ':' else foo := foo + '"' + IntToStr(gst.Hour) + ':';
               //               if gst.Minute < 10 Then foo := foo +'0' + IntToStr(gst.Minute) + '"' + ',' else foo := foo + IntToStr(gst.Minute) + '"' +',';
               //               foo := foo + '"-","-","-","-","T","' + lastMsg + '"';
               //               for i := 0 to 99 do
               //               begin
               //                    if csvEntries[i] = '' Then
               //                    Begin
               //                         csvEntries[i] := foo;
               //                         break;
               //                    end;
               //               end;
               //               form1.saveCSV();
               //          End;
               //     End
               //     Else
               //     Begin
               //          form1.chkEnTX.Checked := False;
               //          thisAction := 2;
               //          nextAction := 2;
               //          globalData.txInProgress := False;
               //          rxInProgress := False;
               //     End;
               //End
               //Else
               //Begin
               //     txCount := 0;
               //     lastTX := '';
               //     Form1.chkEnTX.Checked := False;
               //     diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent 15 times.');
               //     diagout.Form3.Show;
               //     diagout.Form3.BringToFront;
               //End;
          End
          Else
          Begin
               // Continuing a late sequence TX
               globalData.txInProgress := True;
               rxInProgress := False;
               //if (dac.d65txBufferIdx >= d65nwave+11025) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Or (thisSecond > 48) Then
               //Begin
               //     // I have a full TX cycle when d65txBufferIdx >= 538624 or thisSecond > 48
               //     if getPTTMethod() = 'SI5' Then si570Lowerptt();
               //     if getPTTMethod() = 'HRD' Then hrdLowerPTT();
               //     if getPTTMethod() = 'ALT' Then altLowerPTT();
               //     if getPTTMethod() = 'PTT' Then lowerPTT();
               //     actionSet := False;
               //     thisAction := 5;
               //     globalData.txInProgress := False;
               //     curMsg := '';
               //End;
               //Form1.ProgressBar3.Position := dac.d65txBufferIdx;
          End;
     End;
End;

procedure TForm1.processNewMinute(st : TSystemTime);
Var
   i, idx, ifoo : Integer;
Begin
     // Get Start of Period QRG
     actionSet := False;
     sopQRG := globalData.gqrg;
     rxInProgress := False;
     globalData.txInProgress := False;
     // Paint a start of new period line in the spectrum display.
     for i := 0 to 749 do
     begin
          spectrum.specDisplayData[0][i].r := 255;
     end;
     //
     // Entered a new cycle.
     // First I need to setup the actions for the next cycle.
     //
     if not Form1.chkEnTX.Checked Then txNextPeriod := False;
     lastAction := thisAction;
     thisAction := nextAction;
     nextAction := 2;
     // I default to assuming the next action will be RX this can/will
     // be modified by the user clicking the TX next available period button.
     statusChange := False;
     lastMinute := thisMinute;
     thisMinute := st.Minute;
     if st.Minute = 59 then nextMinute := 0 else nextMinute := st.Minute + 1;
     // I can only see action 2..5 from here.  action=1 does not exist
     // if I have made it here.
     // Handler for action=2
     if thisAction = 2 Then
     Begin
          //If cfgvtwo.gld65AudioChange Then audioChange();
     End;
     // Handler for action=3
     if thisAction = 3 Then
     Begin
          //If cfgvtwo.gld65AudioChange Then audioChange();
     End;
     // Keep raw decoder output from getting too large.
     If rawdec.Form5.ListBox1.Items.Count > 75 Then
     Begin
          for idx := rawdec.Form5.ListBox1.Items.Count - 1 downto 25 do
          Begin
               rawdec.Form5.ListBox1.Items.Delete(idx);
          end;
     End;
     // Is it time for an auto QSY? (Abort auto QSY if TX enabled...)
     //if not Form1.chkEnTX.Checked And globalData.hrdcatControlcurrentRig.hrdAlive Then
     //Begin
     //     if cfgvtwo.Form6.cbEnableQSY1.Checked Then
     //     Begin
     //          if (st.Hour = cfgvtwo.Form6.qsyHour1.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute1.Value) Then
     //          Begin
     //               // QSY time slot 1
     //               If TryStrToInt(cfgvtwo.Form6.edQRGQSY1.Text, ifoo) Then
     //               Begin
     //                    if ifoo > 1799999 Then
     //                    Begin
     //                         if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
     //                         if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
     //                         if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY1.Text) Then
     //                         Begin
     //                              if cfgvtwo.Form6.cbATQSY1.Checked Then
     //                              Begin
     //                              // Auto-tune cycle requested
     //                              end;
     //                         end;
     //                    end;
     //               end;
     //          end;
     //     end;
     //     if cfgvtwo.Form6.cbEnableQSY2.Checked Then
     //     Begin
     //          if (st.Hour = cfgvtwo.Form6.qsyHour2.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute2.Value) Then
     //          Begin
     //               // QSY time slot 2
     //               If TryStrToInt(cfgvtwo.Form6.edQRGQSY2.Text, ifoo) Then
     //               Begin
     //                    if ifoo > 1799999 Then
     //                    Begin
     //                         if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
     //                         if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
     //                         if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY2.Text) Then
     //                         Begin
     //                              if cfgvtwo.Form6.cbATQSY2.Checked Then
     //                              Begin
     //                              // Auto-tune cycle requested
     //                              end;
     //                         end;
     //                    end;
     //               end;
     //          end;
     //     end;
     //     if cfgvtwo.Form6.cbEnableQSY3.Checked Then
     //     Begin
     //          if (st.Hour = cfgvtwo.Form6.qsyHour3.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute3.Value) Then
     //          Begin
     //               // QSY time slot 3
     //               If TryStrToInt(cfgvtwo.Form6.edQRGQSY3.Text, ifoo) Then
     //               Begin
     //                    if ifoo > 1799999 Then
     //                    Begin
     //                         if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
     //                         if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
     //                         if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY3.Text) Then
     //                         Begin
     //                              if cfgvtwo.Form6.cbATQSY3.Checked Then
     //                              Begin
     //                              // Auto-tune cycle requested
     //                              end;
     //                         end;
     //                    end;
     //               end;
     //          end;
     //     end;
     //     if cfgvtwo.Form6.cbEnableQSY4.Checked Then
     //     Begin
     //          if (st.Hour = cfgvtwo.Form6.qsyHour4.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute4.Value) Then
     //          Begin
     //               // QSY time slot 4
     //               If TryStrToInt(cfgvtwo.Form6.edQRGQSY4.Text, ifoo) Then
     //               Begin
     //                    if ifoo > 1799999 Then
     //                    Begin
     //                         if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
     //                         if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
     //                         if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY4.Text) Then
     //                         Begin
     //                              if cfgvtwo.Form6.cbATQSY4.Checked Then
     //                              Begin
     //                              // Auto-tune cycle requested
     //                              end;
     //                         end;
     //                    end;
     //               end;
     //          end;
     //     end;
     //     if cfgvtwo.Form6.cbEnableQSY5.Checked Then
     //     Begin
     //          if (st.Hour = cfgvtwo.Form6.qsyHour5.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute5.Value) Then
     //          Begin
     //               // QSY time slot 5
     //               If TryStrToInt(cfgvtwo.Form6.edQRGQSY5.Text, ifoo) Then
     //               Begin
     //                    if ifoo > 1799999 Then
     //                    Begin
     //                         if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
     //                         if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
     //                         if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY5.Text) Then
     //                         Begin
     //                              if cfgvtwo.Form6.cbATQSY5.Checked Then
     //                              Begin
     //                              // Auto-tune cycle requested
     //                              end;
     //                         end;
     //                    end;
     //               end;
     //          end;
     //     end;
     //end;
End;

procedure TForm1.processOncePerSecond(st : TSystemTime);
Var
   i    : Integer;
   foo  : String;
   ffoo : Double;
Begin
     // Keep popup menu items in sync
     //Form1.MenuItem22.Caption := cfgvtwo.Form6.edUserQRG1.Text;
     //Form1.MenuItem23.Caption := cfgvtwo.Form6.edUserQRG2.Text;
     //Form1.MenuItem28.Caption := cfgvtwo.Form6.edUserQRG3.Text;
     //Form1.MenuItem29.Caption := cfgvtwo.Form6.edUserQRG4.Text;
     //Form1.MenuItem16.Caption := cfgvtwo.Form6.edUserMsg4.Text;
     //Form1.MenuItem17.Caption := cfgvtwo.Form6.edUserMsg5.Text;
     //Form1.MenuItem18.Caption := cfgvtwo.Form6.edUserMsg6.Text;
     //Form1.MenuItem19.Caption := cfgvtwo.Form6.edUserMsg7.Text;
     //Form1.MenuItem20.Caption := cfgvtwo.Form6.edUserMsg8.Text;
     //Form1.MenuItem21.Caption := cfgvtwo.Form6.edUserMsg9.Text;
     //Form1.MenuItem24.Caption := cfgvtwo.Form6.edUserMsg10.Text;
     //Form1.MenuItem25.Caption := cfgvtwo.Form6.edUserMsg11.Text;
     //Form1.MenuItem26.Caption := cfgvtwo.Form6.edUserMsg12.Text;
     //Form1.MenuItem27.Caption := cfgvtwo.Form6.edUserMsg13.Text;
     // PSKR Check
     //if cfgvtwo.Form6.cbUsePSKReporter.Checked Then
     //Begin
     //     if pskrstat = 0 Then
     //     Begin
     //          Form1.Timer1.Enabled := False;
     //          If PSKReporter.ReporterInitialize('report.pskreporter.info','4739') = 0 Then pskrstat := 1 else pskrstat := 0;
     //          Form1.Timer1.Enabled := True;
     //     End;
     //End;
     //if cfgvtwo.Form6.cbUsePSKReporter.Checked and not primed Then PSKReporter.ReporterTickle;
     //If cfgvtwo.Form6.cbUsePSKReporter.Checked and not primed Then
     //Begin
     //     If PSKReporter.ReporterGetStatistics(pskrStats,SizeOf(pskrStats)) = 0 Then Label19.Caption := IntToStr(pskrStats.callsigns_sent);
     //End;
     //if cfgvtwo.Form6.cbUsePSKReporter.Checked Then Form1.Label19.Visible := True else Form1.Label19.Visible := False;
     // RB Check
     //If cfgvtwo.Form6.cbUseRB.Checked Then Label30.Caption := IntToStr(rbc.glrbsSentCount);
     //if cfgvtwo.Form6.cbUseRB.Checked Then Form1.Label30.Visible := True else Form1.Label30.Visible := False;
     // Force Rig control read cycle.
     if (st.Second mod 3 = 0) And not primed Then doCAT := True;
     // Set manual entry ability.
     //if (cfgvtwo.glcatBy = 'none') and not cfgvtwo.glsi57Set Then Form1.editManQRG.Enabled := True else Form1.editManQRG.Enabled := False;
     //if (cfgvtwo.glcatBy = 'none') and not cfgvtwo.glsi57Set Then Form1.Label23.Visible := True else Form1.Label23.Visible := False;
     // Deal with QRG display
     //if (cfgvtwo.glcatBy = 'none') Then
     //Begin
     //     // Manual control (do nothing, I think...)
     //End
     //Else
     //Begin
     //     // In this instance some CAT method is in play.
     //     ffoo := globalData.gqrg;
     //     if ffoo < 100000 Then Form1.editManQRG.Text := '0' Else Form1.editManQRG.Text := FloatToStr(globalData.gqrg/1000);
     //End;
     if Form1.editManQRG.Text = '0' Then
     Begin
          Form1.Label12.Font.Color := clRed;
          Form1.editManQRG.Font.Color := clRed;
          //Form1.Label23.Font.Color := clRed;
     end
     else
     begin
         Form1.Label12.Font.Color := clBlack;
         Form1.editManQRG.Font.Color := clBlack;
         //Form1.Label23.Font.Color := clBlack;
     end;
     If globalData.rbLoggedIn Then Form1.Label30.Font.Color := clBlack else Form1.Label30.Font.Color := clRed;
     // Update AU Levels display
     displayAudio(audioAve1, audioAve2);
     if Form1.chkMultiDecode.Checked Then watchMulti := False;
     // Update rbstats once per minute at second = 30
     If st.Second = 30 Then
     Begin
          // Process the calls heard list
          for i := 0 to 499 do
          Begin
               if Length(rbc.glrbsLastCall[i]) > 0 Then
               Begin
                    updateList(rbc.glrbsLastCall[i]);
                    rbc.glrbsLastCall[i] := '';
               End;
          End;
          // Now update the calls heard string grid
          //cfgvtwo.Form6.sgCallsHeard.RowCount := 1;
          //for i := 0 to 499 do
          //begin
          //     if rbsHeardList[i].count > 0 Then
          //     Begin
          //          cfgvtwo.Form6.sgCallsHeard.InsertColRow(False,1);
          //          cfgvtwo.Form6.sgCallsHeard.Cells[0,1] := rbsHeardList[i].callsign;
          //          cfgvtwo.Form6.sgCallsHeard.Cells[1,1] := IntToStr(rbsHeardList[i].count);
          //     End;
          //end;
     end;
     // Update clock display
     lastSecond := st.Second;
     foo := Format('%2.2D',[st.Year]);
     if st.Month = 1 Then foo := foo + '-Jan-';
     if st.Month = 2 Then foo := foo + '-Feb-';
     if st.Month = 3 Then foo := foo + '-Mar-';
     if st.Month = 4 Then foo := foo + '-Apr-';
     if st.Month = 5 Then foo := foo + '-May-';
     if st.Month = 6 Then foo := foo + '-Jun-';
     if st.Month = 7 Then foo := foo + '-Jul-';
     if st.Month = 8 Then foo := foo + '-Aug-';
     if st.Month = 9 Then foo := foo + '-Sep-';
     if st.Month = 10 Then foo := foo + '-Oct-';
     if st.Month = 11 Then foo := foo + '-Nov-';
     if st.Month = 12 Then foo := foo + '-Dec-';
     if not guiConfig.getGUIType() Then Form1.Label9.Caption := foo + Format('%2.2D',[st.Day]);
     Form1.Label1.Caption := Format('%2.2D',[st.Hour]) + ':' +
                             Format('%2.2D',[st.Minute]) + ':' +
                             Format('%2.2D',[st.Second]);
     foo := foo + Format('%2.2D',[st.Day]) + '  ' +
                  Format('%2.2D',[st.Hour]) + ':' +
                  Format('%2.2D',[st.Minute]) + ':' +
                  Format('%2.2D',[st.Second]) + ' UTC';
     // Display current action in status panel
     updateStatus(thisAction);
     // rbc control
     // Check whether to enable/disable chkRBenable
     if not primed then rbcCheck();
     // check for dispatching rb thread seconds every two seconds.
     //If cfgvtwo.Form6.cbUseRB.Checked Then
     //Begin
     //     If (st.Second mod 2 = 0) And not d65.glinProg Then
     //     Begin
     //          doRB := False;
     //          i := 0;
     //          for i := 0 to 499 do
     //          begin
     //               if not rbc.glrbReports[i].rbProcessed then doRB := True;
     //          end;
     //          if doRB Then dorbReport := True;
     //     End;
     //End;
     // If rb Enabled (and not Offline Only) then ping RB server every
     // other minute at second = 55 to keep rb logged in.
     if st.Second = 55 Then
     Begin
          if odd(st.Minute) Then doRB := True else doRB := False;
          //If (cfgvtwo.Form6.cbUseRB.Checked) And (not cfgvtwo.Form6.cbNoInet.Checked) And (doRB) Then
          //Begin
          //     rbcPing := True;
          //End;
     end;
     // Offer to send cached rb reports if rb online and logged in.  Only make this offer once
     // per program run.
     // TODO reinstate this once I've confirmed new cache uploader works.
     //if globalData.rbRunOnce And Form1.chkRBenable.Checked And globalData.rbLoggedIn Then
     //Begin
          //If FileExists('rbcache.txt') Then
          //Begin
               //Form1.lbNotices.Items[3] := 'Have cached RB Data.  Click line to send';
               //globalData.rbRunOnce := False;
          //End
          //Else
          //Begin
               //globalData.rbRunOnce := False;
          //End;
     //End;
     // Check for RB thread error conditon.
     if not primed then rbThreadCheck();
     // Post rx/tx SR error to log output
end;

procedure TForm1.oncePerTick();
Var
   i    : Integer;
Begin
     myCallCheck();
     // Refresh audio level display
     if not primed then updateAudio();
     // Update spectrum display.
     if not globalData.txInProgress and not primed and not globalData.spectrumComputing65 and not d65.glinProg Then
     Begin
          If globalData.specNewSpec65 Then Waterfall.Repaint;
     End;
     // Update RX/TX SR Display
     if not primed Then updateSR();
     // Determine TX Buffer to use
     if useBuffer = 0 Then curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     if useBuffer = 1 Then curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
     // Enable/disable TX controls as needed.
     txControls();
     // Give some indication if multi is off
     if Form1.chkMultiDecode.Checked Then Form1.chkMultiDecode.Font.Color := clBlack else Form1.chkMultiDecode.Font.Color := clRed;
     // Display any decodes that may have been returned from the decoder thread.
     // Only run this block if decoder thread is inactive.
     If not d65.glinProg and d65.gld65HaveDecodes Then
     Begin
          for i := 0 to 49 do
          Begin
               if (not d65.gld65decodes[i].dtProcessed) And (not d65.gld65decodes[i].dtDisplayed) Then
               begin
                    addToDisplay(i,65);
                    if not reDecode Then addToRBC(i,65);
                    d65.gld65decodes[i].dtCharSync  := '';
                    d65.gld65decodes[i].dtDecoded   := '';
                    d65.gld65decodes[i].dtDeltaFreq := '';
                    d65.gld65decodes[i].dtDeltaTime := '';
                    d65.gld65decodes[i].dtDisplayed := True;
                    d65.gld65decodes[i].dtNumSync   := '';
                    d65.gld65decodes[i].dtProcessed := True;
                    d65.gld65decodes[i].dtSigLevel  := '';
                    d65.gld65decodes[i].dtSigW      := '';
                    d65.gld65decodes[i].dtTimeStamp := '';
                    d65.gld65decodes[i].dtType      := '';
               end;
          End;
          if reDecode then reDecode := False;
     End;
End;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     // Setup to evaluate where I am in the temporal loop.
     statusChange := False;
     gst := utcTime();
     thisSecond := gst.Second;
     // Runs at program start only
     If runOnce Then
     Begin
          Form1.Timer1.Enabled := False;
          //ShowMessage('Main loop entered, calling initializer code...');
          // Read in initializer code items that can't be run from form create.
          initializerCode();
          dlog.fileDebug('Initializer code complete.  Entering main timing loop.');
          runOnce := False;
          Form1.Timer1.Enabled := True;
          // Go ahead and mark the stream as active.  It won't run a decode, but it will paint the spectrum during init.
          // rxInProgress := True;
          // End of run once code.

          rxInProgress := False;
          globalData.txInProgress := False;
          thisAction   := 2;
          nextAction   := 2;
     End;
     // This is a TIME CRITICAL loop. I have ~100..210ms here, if I exceed it
     // the timer will fire again and that wouldn't be a good thing at all. I
     // am adding some code to detect such a condition.
     //
     If alreadyHere then
     Begin
          Form1.Timer1.Enabled := False;
          resyncLoop := True;
          diagout.Form3.Show;
          diagout.Form3.BringToFront;
          diagout.Form3.ListBox1.Items.Add('resync! ' + IntToStr(gst.Second));
          Form1.Timer1.Enabled := True;
          // TODO Either code a recovery from timer overrun or raise an
          // exception and end the program.
          //ShowMessage('CRITICAL ERROR! timer1 service routine called out of sync.');
          //ShowMessage('Please close program now as it is in idle mode.');
     End
     Else
     Begin
          alreadyHere := True;  // This will be set false at end of procedure.
          // That's it for the timer overrun check.
     End;
     // Now to the main loop.
     //
     // When I first start program I need to get into close sync with 1
     // second : 0 millisecond ticks so I start out in idle mode until I've
     // gotten (at least very close) to T= HH:MM:00:000.
     //
     // 220mS as the timing interval seems to work fine. (Why 220?  It's a
     // multiple of 55mS which is, apparently, the best reliabe timer resolution
     // under windows without resorting to far more complicated timing methods,
     // with most of those being unworkable on multi-core/processor systems.)
     //
     // To avoid some larger error in RX/TX start times I will run the timer at
     // 1mS rate during the sync slot (S=59 .. S=0).  Of course, the timer
     // won't really run at an accurate 1mS resolution, but it will give as
     // many ticks per interval as possible which should lead to better sync up
     // to top of minute.
     //
     // Now I need to look for a transition from HH:MM:59.mmm to HH:MM:00.mmm
     // to detect a start of minute.
     //
     If gst.Second = 59 Then primed := True;
     If primed Then
     Begin
          // Kick the timer into 'high resolution' mode.
          Form1.Timer1.Interval := 1;
          If gst.Second = 0 Then
          Begin
               resyncLoop := False;
               // I've gotten to second = 0 so I can reset the timer to 'low
               // resolution' mode and indicate top of minute status change.
               statusChange := True;
               primed := False;
               Form1.Timer1.Interval := 220;
          End
          Else
          Begin
               // Still between second = 59 and second = 0.
               statusChange := False;
               primed := True;
          End;
     End;
     // At this point I will be in one of two temporal positions.  Either at the
     // start of a new minute or not. statusChange=True=Start of new minute.
     //
     // This code block handles the start of a new minute.
     If statusChange Then
     Begin
          processNewMinute(gst);
     end;
     // Handle event processing while NOT start of new minute.
     if not statusChange and not resyncLoop Then
     begin
          processOngoing();
     end;
     //
     // Code that executes once per second, but not necessary that it be exact 1
     // second intervals. This happens whether it's the top of a new minute or not.
     If (gst.Second <> lastSecond) And not resyncLoop Then
     begin
          processOncePerSecond(gst);
     end;
     // Code that runs each timer tick.
     if not resyncLoop then oncePerTick();
     // Clear the timer overrun check variable.
     alreadyHere := False;
end;

initialization
  {$I maincode.lrs}
  // rbc runs in its own thread and will send reports (if user ebables) at 3
  // and 33 seconds.  The thread will be triggered at each time interval and
  // suspended once rbc.rbcActive is False.
  rbc.glrbActive := False;
  globalData.rbCacheOnly := False;
  rbc.glrbAlwaysSave := False;
  // Initialize rbRecords array
  for mnlooper := 0 to 499 do
  begin
       rbc.glrbReports[mnlooper].rbTimeStamp := '';
       rbc.glrbReports[mnlooper].rbNumSync   := '';
       rbc.glrbReports[mnlooper].rbSigLevel  := '';
       rbc.glrbReports[mnlooper].rbDeltaTime := '';
       rbc.glrbReports[mnlooper].rbDeltaFreq := '';
       rbc.glrbReports[mnlooper].rbSigW      := '';
       rbc.glrbReports[mnlooper].rbCharSync  := '';
       rbc.glrbReports[mnlooper].rbDecoded   := '';
       rbc.glrbReports[mnlooper].rbFrequency := '';
       rbc.glrbReports[mnlooper].rbProcessed := True;
       rbc.glrbReports[mnlooper].rbCached    := False;
  end;
  for mnlooper := 0 to 499 do
  begin
       rbc.glrbsLastCall[mnlooper] := '';
  end;
  // The decoder runs in its own thread and will process the rxBuffer any time
  // globalData.d65doDecodePass = True.  I also need to define whether I want to do
  // multi-decode, the low..high multi-decode range and the step size or, for
  // single decode, the center frequency and bandwidth.
  d65doDecodePass := False;
  d4doDecodePass := False;
  d65.gldecoderPass := 0;
  // Clear the decodes array structure
  for mnlooper := 0 to 49 do
  Begin
       d65.gld65decodes[mnlooper].dtTimeStamp := '';
       d65.gld65decodes[mnlooper].dtNumSync := '';
       d65.gld65decodes[mnlooper].dtSigLevel := '';
       d65.gld65decodes[mnlooper].dtDeltaTime := '';
       d65.gld65decodes[mnlooper].dtDeltaFreq := '';
       d65.gld65decodes[mnlooper].dtSigW := '';
       d65.gld65decodes[mnlooper].dtCharSync := '';
       d65.gld65decodes[mnlooper].dtDecoded := '';
       d65.gld65decodes[mnlooper].dtDisplayed := True;
       d65.gld65decodes[mnlooper].dtProcessed := True;
  End;
  // Initialize the spectrum display bufffer to 0 values
  for mnlooper := 0 to 179 do
  Begin
       for ij := 0 to 749 do
       begin
            spectrum.specDisplayData[mnlooper][ij].r := 0;
            spectrum.specDisplayData[mnlooper][ij].g := 0;
            spectrum.specDisplayData[mnlooper][ij].b := 0;
       end;
  End;
  // Initialize rxBuffer and its pointer, rxBuffer holds incoming sample data from PA
  //adc.d65rxBufferPtr := @adc.d65rxBuffer[0];  // pointer set to start of rxBuffer

  //adc.d65rxBufferIdx := 0;

  // Initialize txBuffer and its pointer, txBuffer holds outgoing sample data for PA
  //dac.d65txBufferPtr := @dac.d65txBuffer[0];  // pointer set to start of txBuffer

  //dac.d65txBufferIdx := 0;

  // Setup PChar type variables.
  d65txmsg := StrAlloc(28);
  d65sending := StrAlloc(28);
  cwidMsg := StrAlloc(22);
  // Miscelanious operational vars.
  runOnce := True;
  spectrum.specFirstRun := True;
  //cfgvtwo.glrbcLogin := False;
  //cfgvtwo.glrbcLogout := False;
  rbcPing := False;
  dorbReport := False;
  alreadyHere := False; // Used to detect an overrun of timer servicing loop.
  sLevel1 := 0;
  sLevel2 := 0;
  sLevelM := 0;
  smeterIdx := 0;
  //adc.adcSpecCount := 0;

  //adc.adcChan := 1;

  globalData.specNewSpec65 := False;
  primed       := False; // This is part of the time sync code.
  txPeriod     := 0;     // 0 is even and 1 is odd minutes
  lastSecond   := 0;     // I use this to update the clock display
  rxInProgress := False; // Indicates I'm running a PA prcoess to aquire data
  globalData.txInProgress := False; // Indicates I'm running a PA process to output data
  txNextPeriod := False; // Indicates I will begin TX at next inTimeSync True
  statusChange := False; // Indicates I will need to change status bar staus block
  lastAction   := 1;     // No reason, just setting it to be complete.
  thisAction   := 1;     // Startup in init mode
  nextAction   := 2;     // Next action will be RX
  TxDirty      := True;
  TxValid      := False;
  itemsIn      := False;
  // Setup error accumulators
  dErrLErate   := 0;
  dErrCount    := 0;
  dErrAErate   := 0;
  dErrError    := 0;
  adCount      := 0;
  adLErate     := 0;
  adAErate     := 0;
  adError      := 0;
  //
  // Actions 1=Init, 2=RX, 3=TX, 4=Decode, 5=Idle
  //
  exchange     := '';
  //adc.adcT         := 0;

  //adc.adcE         := 0;

  mnpttOpened    := False;
  firstReport  := True;
  useBuffer := 0;
  //adc.adcLDgain := 0;

  //adc.adcRDgain := 0;

  lastMsg := '';
  curMsg := '';
  //cfgvtwo.glautoSR := False;
  //rbc.glrbNoInet := True;
  rbRunOnce := True;
  thisTX := '';
  lastTX := '';
  txCount := 0;
  rxCount := 0;
  watchMulti := False;
  haveTXSRerr := False;
  haveRXSRerr := False;
  rxsrs := '';
  txsrs := '';
  lastSRerr := '';
  audioAve1 := 0;
  audioAve2 := 0;
  doCAT := False;
  sopQRG := 0.0;
  eopQRG := 0.0;
  //cfgvtwo.glcatBy := 'none';
  doRB := False;
  spectrum.specfftCount := 0;
  spectrum.specSpeed2 := 1;
  spectrum.specSmooth := False;
  for mnlooper := 0 to 99 do
  begin
       csvEntries[mnlooper] := '';
  end;
  d65.glInProg := False;
  spectrum.specVGain := 7;
  globalData.spectrumComputing65 := False;
  globalData.audioComputing := False;
  resyncLoop := False;
  //adc.adcRunning := False;

  d65.glnd65firstrun := True;
  d65.glbinspace := 100;
  globalData.debugOn := False;
  globalData.gmode := 65;
  txmode := globalData.gmode;
  mnHavePrefix := False;
  mnHaveSuffix := False;
  fullcall := '';
  // Create stream for spectrum image
  globalData.specMs65 := TMemoryStream.Create;
  //adc.adcECount := 0;

  reDecode := False;
  // Clear rewind buffers
  For mnlooper := 0 to 661503 do
  begin
       auOddBuffer[mnlooper]  := 0;
       auEvenBuffer[mnlooper] := 0;
  end;
  haveOddBuffer := False;
  haveEvenBuffer := False;
  globalData.si570ptt := False;
  doCWID := False;
  actionSet := False;
  //catControl.catControlautoQSY := False;
  //catControl.catControlcatTxDF := False;
  globalData.hrdcatControlcurrentRig.hrdAlive := False;
  globalData.hrdVersion := 5;
end.

