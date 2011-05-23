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
  Classes , SysUtils , LResources , Forms , Controls , Graphics , Dialogs ,
  StdCtrls , CTypes , StrUtils , Math , ExtCtrls , ComCtrls , Spin , Windows ,
  DateUtils , encode65 , globalData , ClipBrd , rawdec , guiConfig , verHolder ,
  dispatchobject , PSKReporter , Menus , log , diagout , synautil ,
  waterfall , d65 , spectrum , about , FileUtil , TAGraph , guidedconfig ,
  valobject , rigobject , portaudio , adc , dac , audiodiag, spot;

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
    Edit3: TEdit;
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
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
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
    MenuItem30 : TMenuItem ;
    MenuItem31 : TMenuItem ;
    MenuItem32 : TMenuItem ;
    MenuItem33 : TMenuItem ;
    MenuItem34 : TMenuItem ;
    MenuItem35 : TMenuItem ;
    MenuItem36 : TMenuItem ;
    MenuItem37 : TMenuItem ;
    MenuItem38 : TMenuItem ;
    MenuItem39 : TMenuItem ;
    MenuItem4 : TMenuItem ;
    MenuItem40 : TMenuItem ;
    MenuItem41 : TMenuItem ;
    MenuItem42 : TMenuItem ;
    MenuItem43 : TMenuItem ;
    MenuItem44 : TMenuItem ;
    MenuItem45 : TMenuItem ;
    MenuItem46 : TMenuItem ;
    MenuItem47 : TMenuItem ;
    MenuItem48 : TMenuItem ;
    MenuItem49 : TMenuItem ;
    MenuItem5 : TMenuItem ;
    MenuItem50 : TMenuItem ;
    MenuItem51 : TMenuItem ;
    MenuItem52 : TMenuItem ;
    MenuItem53 : TMenuItem ;
    menuSetup: TMenuItem;
    menuRawDecoder: TMenuItem;
    menuRigControl: TMenuItem;
    menuTXLog: TMenuItem;
    menuAbout: TMenuItem;
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
    spinDecoderMBW: TSpinEdit;
    spinDecoderCF: TSpinEdit;
    spinSpecSpeed: TSpinEdit;
    spinGain: TSpinEdit;
    spinTXCF: TSpinEdit;
    Timer1: TTimer;
    tbDgainL: TTrackBar;
    tbDGainR: TTrackBar;
    Timer2 : TTimer ;
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
    procedure spinDecoderMBWChange(Sender: TObject);
    procedure spinSpecSpeedChange(Sender: TObject);
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
    procedure tbDgainLChange(Sender: TObject);
    procedure Timer2Timer (Sender : TObject );
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
    procedure myCallCheck();
    procedure txControls();
    procedure processNewMinute(st : TSystemTime);
    procedure processOncePerSecond(st : TSystemTime);
    procedure oncePerTick();
    procedure displayAudio(audioAveL : Integer; audioAveR : Integer);
    function BuildRemoteString (call, mode, freq, date, time : String) : WideString;
    function BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
    function BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
    function isSigRep(rep : String) : Boolean;
    function utcTime() : TSYSTEMTIME;
    procedure addToRBC(i, m : Integer);
    procedure rbcCheck();
    procedure updateList(callsign : String);
    procedure WaterfallMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure addToDisplayTX(exchange : String);
    procedure saveCSV();

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

    rbHeard = record
       callsign : String;
       count    : Integer;
    end;

  var
     Form1                      : TForm1;
     auOddBuffer, auEvenBuffer  : Packed Array[0..661503] of CTypes.cint16;
     paInParams, paOutParams    : TPaStreamParameters;  // Portaudio I/O params
     ppaInParams, ppaOutParams  : PPaStreamParameters;  // Pointer to I/O params
     paResult                   : TPaError;             // Result of last PA Call
     paInStream, paOutStream    : PPaStream;            // Portaudio I/O Streams

     decoderThread              : decodeThread;
     rbThread                   : rbcThread;

     pskrStats                  : PSKReporter.REPORTER_STATISTICS;
     pskrstat                   : Integer;

     mnlooper, ij               : Integer;
     sLevel1, sLevel2, sLevelM  : Integer;
     smeterIdx                  : Integer;
     bStart, bEnd, rxCount      : Integer;
     exchange                   : String;
     msgToSend                  : String;
     siglevel                   : String;
     //dErrLErate, dErrAErate     : Double;
     //dErrError, adError         : Double;
     //adLErate, adAErate         : Double;
     //dErrCount, adCount         : Integer;
     lastMsg, curMsg            : String;
     gst, ost                   : TSYSTEMTIME;
     //rxsrs, txsrs, lastSRerr    : String;

     preTXCF, preRXCF           : Integer;

     audioAve1, audioAve2       : Integer;

     sopQRG, eopQRG             : Integer;  // Start of period QRG/End of period QRG in Hertz

     rbsHeardList               : Array[0..499] Of rbHeard;
     csvEntries                 : Array[0..99] of String;

     qsoSTime, qsoETime         : String;
     qsoSDate                   : String;
     rbRunOnce                  : Boolean;

     d65samfacout               : CTypes.cdouble;
     d65nwave, d65nmsg          : CTypes.cint;
     d65sendingsh               : CTypes.cint;

     d65txmsg                   : PChar;
     cwidMsg                    : PChar;
     d65sending                 : PChar;

     rig                        : rigobject.TRadio;
     mval                       : valobject.TValidator;
     ctrl                       : dispatchobject.TDispatcher;
     rb                         : spot.TSpot;
implementation

{ TForm1 }
constructor decodeThread.Create(CreateSuspended : boolean);
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

function TForm1.utcTime(): TSYSTEMTIME;
Var
   st : TSYSTEMTIME;
Begin
     st.Hour:=0;
     GetSystemTime(st);
     result := st;
End;

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
     if rb.busy then
     begin
          halt;
     end;
     if Terminated then
     begin
          halt;
     end;
     if Suspended then
     begin
          halt;
     end;
     while not Terminated and not Suspended do
     begin
          Try
             if Length(TrimLeft(TrimRight(guidedconfig.cfg.rbcallsign)))>0 Then
             Begin
                  If ctrl.dorbReport And not rb.busy Then
                  Begin
                       // DEBUG
                       rb.useRB   := True;
                       rb.usePSKR := False;
                       rb.useDBF  := False;
                       // REMOVE ABOVE
                       rb.myCall := TrimLeft(TrimRight(guidedconfig.cfg.rbcallsign));
                       rb.myGrid := TrimLeft(TrimRight(guidedconfig.cfg.grid));
                       rb.myQRG  := guidedconfig.cfg.guiQRG;
                       ctrl.dorbReport := rb.pushSpots;
                  end;
                  if ctrl.rbcPing And not rb.busy Then
                  Begin
                       // DEBUG
                       rb.useRB   := True;
                       rb.usePSKR := False;
                       rb.useDBF  := False;
                       // REMOVE ABOVE
                       rb.myCall := TrimLeft(TrimRight(guidedconfig.cfg.rbcallsign));
                       rb.myGrid := TrimLeft(TrimRight(guidedconfig.cfg.grid));
                       rb.myQRG  := guidedconfig.cfg.guiQRG;
                       //ctrl.rbcPing := rb.loginRB;
                       ctrl.rbcPing := false;
                  End;
                  if ctrl.doRBLogout And not rb.busy Then
                  Begin
                       // DEBUG
                       rb.useRB   := True;
                       rb.usePSKR := False;
                       rb.useDBF  := False;
                       // REMOVE ABOVE
                       rb.myCall := TrimLeft(TrimRight(guidedconfig.cfg.rbcallsign));
                       rb.myGrid := TrimLeft(TrimRight(guidedconfig.cfg.grid));
                       rb.myQRG  := guidedconfig.cfg.guiQRG;
                       //ctrl.doRBLogout := rb.logoutRB;
                       ctrl.doRBLogout := false;
                  End;
                  if ctrl.rbcCache And not rb.busy Then
                  Begin
                       // TODO Reinstate following once cache uploader is verified.
                       //rbc.sendCached();
                       ctrl.rbcCache := False;
                  End;
             End;
          Except
             //dlog.fileDebug('Notice:  Exception in rbc thread');
          end;
          Sleep(500);
     end;
end;

procedure decodeThread.Execute;
begin
     while not Terminated and not Suspended and not d65.glinprog do
     begin
          Try
          if ctrl.d65doDecodePass And not d65.glinprog Then
          Begin
               d65.gldecoderPass := 0;
               d65.doDecode(0,533504);
               ctrl.d65doDecodePass := False;
          End
          Else
          Begin
               ctrl.d65doDecodePass := False;
          End;
          Except
             //dlog.fileDebug('Notice:  Exception in decoder thread');
             if ctrl.reDecode then ctrl.reDecode := False;
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
     needLog := False;
     for i := 0 to 99 do
     begin
          if csvEntries[i] <> '' Then needLog := True;
     end;
     if needLog Then
     begin
          Try
             fname := guidedconfig.cfg.logdir + '\JT65hf-log.csv';
             AssignFile(logFile, fname);
             If FileExists(fname) Then
             Begin
                  Append(logFile);
             End
             Else
             Begin
                  Rewrite(logFile);
                  WriteLn(logFile,'"Date","Time","QRG","Sync","DB","DT","DF","Decoder","Exchange"');
             End;
             // Write the record
             for i := 0 to 99 do
             begin
                  if csvEntries[i] <> '' Then WriteLn(logFile,csvEntries[i]);
                  csvEntries[i] := '';
             end;
             // Close the file
             CloseFile(logFile);
          except
             //dlog.fileDebug('Exception in write csv log');
          end;
     end;
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
     if not d65.glinprog Then
     Begin
          if FileExists(d65.gld65kvfname) Then DeleteFileUTF8(d65.gld65kvfname);
          if not guidedconfig.cfg.useOptFFT Then
          Begin
               d65.glfftFWisdom := 0;
               d65.glfftSWisdom := 0;
          End;
          // Clear transfer buffer
          for i := 0 to 661503 do
          Begin
               d65.glinBuffer[i] := 0;
          end;
          // Range adjust and copy raw buffer to transfer buffer and rewind buffer
          bStart := 0;
          bEnd := 533504;
          for i := bStart to bEnd do
          Begin
               d65.glinBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
               if Odd(ctrl.thisMinute) Then
               Begin
                    auOddBuffer[i] := d65.glinBuffer[i];
                    ctrl.haveOddBuffer := True;
                    ctrl.haveEvenBuffer := False;
               End
               else
               Begin
                    auEvenBuffer[i] := d65.glinBuffer[i];;
                    ctrl.haveEvenBuffer := True;
                    ctrl.haveOddBuffer := False;
               End;
          end;
          ost := utcTime();
          d65.gld65timestamp := '';
          d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Year);
          if ost.Month < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Month) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Month);
          if ost.Day < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Day) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Day);
          if ost.Hour < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Hour) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Hour);
          if ost.Minute < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Minute) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Minute);
          d65.gld65timestamp := d65.gld65timestamp + '00';
          sr := 1.0;
          { TODO : Code sample rate factor setting }
          //if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
          globalData.d65samfacin := 1.0;
          d65samfacout := 1.0;
          d65.glMouseDF := Form1.spinDecoderCF.Value;
          if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
          if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
          if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
          if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;
          If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
          d65.glNshift := 0;
          if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
          d65.glNzap := 0;
          d65.gldecoderPass := 0;
          if form1.chkMultiDecode.Checked Then d65.glsteps := 1 else d65.glsteps := 0;
          ctrl.d65doDecodePass := True;
     End;
end;

procedure TForm1.btnEngageTxClick(Sender: TObject);
begin
     Form1.chkEnTX.Checked := True;
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
     If guidedconfig.cfg.defMultiOn Then Form1.chkMultiDecode.Checked := True;
end;

procedure TForm1.btnHaltTxClick(Sender: TObject);
begin
  // Halt an upcoming or ongoing TX
  if globalData.txInProgress Then
  Begin
       // TX is in progress.  Abort it!
       // Unkey the TX, terminate the PA output stream and set op state to idle.
       globalData.txInProgress := False;
       sleep(100);
       rig1.PTT(false);
       sleep(100);
       ctrl.nextAction := 2;
       ctrl.txNextPeriod := False;
       Form1.chkEnTX.Checked := False;
       ctrl.thisAction := 2;
       ctrl.actionSet := False;
       ctrl.txCount := 0;
  end
  else
  begin
       // TX was requested but has not started.  Cancel request.
       if ctrl.nextAction = 3 then ctrl.nextAction := 2;
       if ctrl.txNextPeriod Then ctrl.txNextPeriod := False;
       chkEnTX.Checked := False;
       ctrl.actionSet := False;
       ctrl.txCount := 0;
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
     ctrl.firstReport := True;
     ctrl.itemsIn := False;
     Form1.ListBox1.Clear;
     // Check for TX/RB/PSKR disable and place notice.
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
end;

procedure TForm1.buttonAckReport1Click(Sender: TObject);
begin
     if Form1.edHisCall.Text <> '' Then
     Begin
          if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' RRR';
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall + ' RRR';
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
          ctrl.doCWID := False;
     End;
end;

procedure TForm1.buttonAckReport2Click(Sender: TObject);
begin
     if Form1.edHisCall.Text <> '' Then
     Begin
          if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' R' + Form1.edSigRep.Text;
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall + ' R' + Form1.edSigRep.Text;
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
          ctrl.doCWID := False;
     end;
end;

procedure TForm1.buttonCQClick(Sender: TObject);
begin
     if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
     Begin
          Form1.edMsg.Text := 'CQ ' + ctrl.myCall;
     End
     Else
     Begin
          Form1.edMsg.Text := 'CQ ' + ctrl.myCall + ' ' + guidedconfig.cfg.grid[1..4];
     End;
     ctrl.doCWID := False;
     Form1.rbGenMsg.Checked := True;
     Form1.rbGenMsg.Font.Color := clRed;
     Form1.rbFreeMsg.Font.Color  := clBlack;
     ctrl.useBuffer := 0;
End;

procedure TForm1.buttonAnswerCQClick(Sender: TObject);
begin
     if Form1.edHisCall.Text <> '' Then
     Begin
          if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall;
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall + ' ' + guidedconfig.cfg.grid[1..4];
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
          ctrl.doCWID := False;
     End;
end;

procedure TForm1.buttonEndQSO1Click(Sender: TObject);
begin
     if Form1.edHisCall.Text <> '' Then
     Begin
          if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' 73';
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall + ' 73';
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
          if guidedconfig.cfg.cwIDall or guidedconfig.cfg.cwIDfree then ctrl.doCWID := true else ctrl.doCWID := false;
     End;
end;

procedure TForm1.buttonSendReportClick(Sender: TObject);
begin
     if Form1.edHisCall.Text <> '' Then
     Begin
          if AnsiContainsStr(ctrl.myCall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + Form1.edSigRep.Text;
          End
          Else
          Begin
               Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + ctrl.myCall + ' ' + Form1.edSigRep.Text;
          End;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
          ctrl.doCWID := False;
     End;
end;

procedure TForm1.cbEnRBChange(Sender: TObject);
begin
     if not guidedconfig.cfg.noSpotting then
     begin
          If cbEnRB.Checked Then
          begin
               guidedconfig.cfg.useRB := true;
               ctrl.rbcPing := true;
          end
          else
          begin
               ctrl.doRBLogout := true;
               guidedconfig.cfg.useRB := false;
          end;
          If cbEnPSKR.Checked Then
          begin
               guidedconfig.cfg.usePSKR := true;
               ctrl.rbcPing := true;
          end
          else
          begin
               ctrl.doRBLogout := true;
               guidedconfig.cfg.usePSKR := false;
          end;
     end
     else
     begin
          guidedconfig.cfg.useRB := false;
          guidedconfig.cfg.usePSKR := false;
          cbEnRB.Checked   := False;
          cbEnPSKR.Checked := False;
     end;
end;

procedure TForm1.cbSmoothChange(Sender: TObject);
begin
     if cbSmooth.Checked Then spectrum.specSmooth := True else spectrum.specSmooth := False;
     if cbSmooth.Checked Then guidedconfig.cfg.specSmooth := True else guidedconfig.cfg.specSmooth := False;
end;

procedure TForm1.rbFreeMsgChange(Sender: TObject);
begin
     if Form1.rbFreeMsg.Checked Then
     Begin
          Form1.rbFreeMsg.Font.Color := clRed;
          Form1.rbGenMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 1;
     End;
     if Form1.rbGenMsg.Checked Then
     Begin
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          ctrl.useBuffer := 0;
     End;
end;

procedure TForm1.spinDecoderBWChange(Sender: TObject);
begin
     // Single decoder segment size selector
     if spinDecoderBW.Value = 1 Then edit2.Text := '20';
     if spinDecoderBW.Value = 2 Then edit2.Text := '50';
     if spinDecoderBW.Value = 3 Then edit2.Text := '100';
     if spinDecoderBW.Value = 4 Then edit2.Text := '200';
     if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
     if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
     if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
     if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;
     guidedconfig.cfg.decoderBW := spinDecoderBW.Value;
end;

procedure TForm1.spinDecoderMBWChange(Sender: TObject);
begin
     // Multi decoder segment size selector
     if spinDecoderMBW.Value = 1 Then edit3.Text := '20';
     if spinDecoderMBW.Value = 2 Then edit3.Text := '50';
     if spinDecoderMBW.Value = 3 Then edit3.Text := '100';
     if spinDecoderMBW.Value = 4 Then edit3.Text := '200';
     if spinDecoderMBW.Value = 1 Then d65.glbinspace := 20;
     if spinDecoderMBW.Value = 2 Then d65.glbinspace := 50;
     if spinDecoderMBW.Value = 3 Then d65.glbinspace := 100;
     if spinDecoderMBW.Value = 4 Then d65.glbinspace := 200;
     guidedconfig.cfg.multiBW := spinDecoderMBW.Value;
end;

procedure TForm1.spinSpecSpeedChange(Sender: TObject);
begin
     if spinSpecSpeed.Value > 5 then spinSpecSpeed.Value := 5;
     if spinSpecSpeed.Value < 0 then spinSpecSpeed.Value := 0;
     spectrum.specSpeed2 := spinSpecSpeed.Value;
     guidedconfig.cfg.specSpeed := spinSpecSpeed.Value;
end;

procedure TForm1.spinGainChange(Sender: TObject);
begin
     if spinGain.value > 6 Then spinGain.Value := 6;
     if spinGain.value < -6 Then spinGain.Value := -6;
     spectrum.specVGain := 7 + spinGain.Value;
     guidedconfig.cfg.specGain := spinGain.Value;
end;

procedure TForm1.chkAFCChange(Sender: TObject);
begin
     If chkAFC.Checked Then chkAFC.Font.Color := clRed else
     chkAFC.Font.Color := clBlack;
     if chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
     if chkAFC.Checked then guidedconfig.cfg.afc := true else guidedconfig.cfg.afc := false;
end;

procedure TForm1.chkAutoTxDFChange(Sender: TObject);
begin
     If Form1.chkAutoTxDF.Checked Then
     Begin
          Label39.Font.Color := clRed;
          spinTXCF.Value := Form1.spinDecoderCF.Value;
          guidedconfig.cfg.useTXeqRXDF := True;
     End
     Else
     Begin
          Label39.Font.Color := clBlack;
          guidedconfig.cfg.useTXeqRXDF := False;
     End;
end;

procedure TForm1.chkMultiDecodeChange(Sender: TObject);
begin

     If chkMultiDecode.Checked Then
     Begin
          chkMultiDecode.Font.Color := clBlack;
          guidedconfig.cfg.multi := true;
     End
     Else
     Begin
          chkMultiDecode.Font.Color := clRed;
          guidedconfig.cfg.multi := false;
     End;
end;

procedure TForm1.chkNBChange(Sender: TObject);
begin
     If chkNB.Checked Then chkNB.Font.Color := clRed else chkNB.Font.Color := clBlack;
     if chkNB.Checked then guidedconfig.cfg.noiseblank := True else guidedconfig.cfg.noiseblank := false;
end;

procedure TForm1.cbSpecPalChange(Sender: TObject);
begin
     spectrum.specColorMap := cbSpecPal.ItemIndex;
     guidedconfig.cfg.specColor := cbSpecPal.ItemIndex;

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
     // In theory, QRG is entered by user as a floating point value in KHz.
     // Theory does not always bear true.  So.  I need to look at the input
     // value and attempt to convert it to Hz as that's the internal representation
     // used by JT65-HF.
     //
     // Now... this gets tricky as I need to allow entry to complete before trying
     // to validate the QRG.  In the past I've attempted to do this on the fly, but
     // now I'm about using a timer that's triggered upon first change to this field.
     // Each time the input box changes timer2 will be reset to 0 and enabled to
     // fire at 2 second intervals.  If the timer makes it to 2 seconds then, and
     // only then, the field will be evaluated, validated and, if valid, set the
     // QRG variables that feed 'up the chain'.
     if not timer2.Enabled then
     begin
          timer2.Enabled := true;
     end
     else
     begin
          timer2.Enabled := false;
          timer2.Enabled := true;
     end;
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
   termcount    : Integer;
begin
     Form1.Timer1.Enabled := False;
     if rbUseLeft.Checked  then guidedconfig.cfg.useAudioLeft  := true else guidedconfig.cfg.useAudioLeft := false;
     if rbUseRight.Checked then guidedconfig.cfg.useAudioRight := true else guidedconfig.cfg.useAudioRight := false;
     guidedconfig.cfg.dgainL := tbDgainL.Position;
     guidedconfig.cfg.dgainR := tbDGainR.Position;
     guidedconfig.cfg.specColor := cbSpecPal.ItemIndex;
     guidedconfig.cfg.specBright := tbBright.Position;
     guidedconfig.cfg.specContrast := tbContrast.Position;
     guidedconfig.cfg.specSpeed := spinSpecSpeed.Value;
     guidedconfig.cfg.specGain := spinGain.Value;
     if cbSmooth.Checked then guidedconfig.cfg.specSmooth := true else guidedconfig.cfg.specSmooth := false;
     if chkAutoTXDF.Checked then guidedconfig.cfg.useTXeqRXDF := true else guidedconfig.cfg.useTXeqRXDF := false;
     guidedconfig.cfg.decoderBW := spinDecoderBW.Value;
     guidedconfig.cfg.multiBW := spinDecoderMBW.Value;
     if chkAFC.Checked then guidedconfig.cfg.afc := true else guidedconfig.cfg.afc := false;
     if chkNB.Checked then guidedconfig.cfg.noiseblank := true else guidedconfig.cfg.noiseblank := false;
     if chkMultiDecode.Checked then guidedconfig.cfg.multi := true else guidedconfig.cfg.multi := false;
     if cbEnRB.Checked then guidedconfig.cfg.useRB := true else guidedconfig.cfg.useRB := false;
     if cbEnPSKR.Checked then guidedconfig.cfg.usePSKR := true else guidedconfig.cfg.usePSKR := false;
     // GUI elements that are maintained in configuration file have now been updated for saving.
     guidedconfig.Form7.saveConfig(guidedconfig.cfg.cfgdir+'\jt65hf.ini');
     rig1.PTT(false);
     //if globalData.rbLoggedIn Then
     //Begin
     //     cfgvtwo.glrbcLogout := True;
     //     sleep(100);
     //end;
     //termcount := 0;
     //While rbc.glrbActive Do
     //Begin
     //     application.ProcessMessages;
     //     sleep(100);
     //     inc(termcount);
     //     if termcount > 9 then break;
     //end;
     termcount := 0;
     while d65.glinProg Do
     Begin
          application.ProcessMessages;
          sleep(100);
          inc(termcount);
          if termcount > 9 then break;
     end;
     decoderThread.Suspend;
     rbThread.Suspend;
     rbThread.Terminate;
     decoderThread.Terminate;
     if not rbThread.FreeOnTerminate Then rbThread.Free;
     if not decoderThread.FreeOnTerminate Then decoderThread.Free;
     portAudio.Pa_StopStream(paInStream);
     portAudio.Pa_StopStream(paOutStream);
     termcount := 0;
     while (portAudio.Pa_IsStreamActive(paInStream) > 0) or (portAudio.Pa_IsStreamActive(paOutStream) > 0) Do
     Begin
          application.ProcessMessages;
          if portAudio.Pa_IsStreamActive(paInStream) > 0 Then portAudio.Pa_AbortStream(paInStream);
          if portAudio.Pa_IsStreamActive(paOutStream) > 0 Then portAudio.Pa_AbortStream(paOutStream);
          sleep(100);
          inc(termcount);
          if termcount > 9 then break;
     end;
     portaudio.Pa_Terminate();
     //if cfgvtwo.Form6.cbUsePSKReporter.Checked Then PSKReporter.ReporterUninitialize;
     Waterfall.Free;
end;

procedure Tform1.addToRBC(i , m : Integer);
Var
   ii   : Integer;
   srec : spot.spotRecord;
begin
     // Reworking this to use the new spot code
     // Using:
     // function  addSpot(const spot : spotRecord) : Boolean;
     // Where spotRecord is:
     // spotRecord = record
     //   qrg      : Integer;
     //   date     : String;
     //   time     : String;
     //   sync     : Integer;
     //   db       : Integer;
     //   dt       : Double;
     //   df       : Integer;
     //   decoder  : String;
     //   exchange : String;
     //   mode     : String;
     //   rbsent   : Boolean;
     //   pskrsent : Boolean;
     // end;


     If not guidedconfig.cfg.noSpotting and (guidedconfig.cfg.useRB or guidedconfig.cfg.usePSKR) Then
     Begin
          if eopQRG = sopQRG then
          begin
               // i holds index to data in d65.gld65decodes to spot
               // m holds mode as integer 65 or 4
               srec.qrg      := eopQRG;
               srec.date     := d65.gld65decodes[i].dtTimeStamp;
               srec.time     := '';
               srec.sync     := strToInt(d65.gld65decodes[i].dtNumSync);
               srec.db       := strToInt(d65.gld65decodes[i].dtSigLevel);
               srec.dt       := strToFloat(d65.gld65decodes[i].dtDeltaTime);
               srec.df       := strToInt(d65.gld65decodes[i].dtDeltaFreq);
               srec.decoder  := d65.gld65decodes[i].dtType;
               srec.exchange := d65.gld65decodes[i].dtDecoded;
               if m = 65 then srec.mode := '65A';
               srec.rbsent   := false;
               srec.pskrsent := false;
               if rb.addSpot(srec) then d65.gld65decodes[i].dtProcessed := True else d65.gld65decodes[i].dtProcessed := false;
          end
          else
          begin
               d65.gld65decodes[i].dtProcessed := True;
          end;
     End
     Else
     Begin
          d65.gld65decodes[i].dtProcessed := True;
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
     If Sender=Form1.MenuItem12 Then Form1.editManQRG.Text :=  '1838';
     If Sender=Form1.MenuItem1  Then Form1.editManQRG.Text :=  '3576';
     If Sender=Form1.MenuItem2  Then Form1.editManQRG.Text :=  '7039';
     If Sender=Form1.MenuItem3  Then Form1.editManQRG.Text :=  '7076';
     If Sender=Form1.MenuItem6  Then Form1.editManQRG.Text := '14076';
     If Sender=Form1.MenuItem7  Then Form1.editManQRG.Text := '18102';
     If Sender=Form1.MenuItem8  Then Form1.editManQRG.Text := '18106';
     If Sender=Form1.MenuItem9  Then Form1.editManQRG.Text := '21076';
     If Sender=Form1.MenuItem10 Then Form1.editManQRG.Text := '24917';
     If Sender=Form1.MenuItem11 Then Form1.editManQRG.Text := '28076';
     If Sender=Form1.MenuItem22 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[0]/1000);
     If Sender=Form1.MenuItem23 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[1]/1000);
     If Sender=Form1.MenuItem28 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[2]/1000);
     If Sender=Form1.MenuItem29 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[3]/1000);
     If Sender=Form1.MenuItem4  Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[4]/1000);
     If Sender=Form1.MenuItem5  Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[5]/1000);
     If Sender=Form1.MenuItem44 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[6]/1000);
     If Sender=Form1.MenuItem45 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[7]/1000);
     If Sender=Form1.MenuItem46 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[8]/1000);
     If Sender=Form1.MenuItem47 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[9]/1000);
     If Sender=Form1.MenuItem48 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[10]/1000);
     If Sender=Form1.MenuItem49 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[11]/1000);
     If Sender=Form1.MenuItem50 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[12]/1000);
     If Sender=Form1.MenuItem51 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[13]/1000);
     If Sender=Form1.MenuItem52 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[14]/1000);
     If Sender=Form1.MenuItem53 Then Form1.editManQRG.Text := floattostr(guidedconfig.cfg.qrgList[15]/1000);
     // Free Text Messages
     If Sender=Form1.MenuItem13 Then Form1.edFreeText.Text := 'RO';
     If Sender=Form1.MenuItem14 Then Form1.edFreeText.Text := 'RRR';
     If Sender=Form1.MenuItem15 Then Form1.edFreeText.Text := '73';
     If Sender=Form1.MenuItem16 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[0];
     If Sender=Form1.MenuItem17 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[1];
     If Sender=Form1.MenuItem18 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[2];
     If Sender=Form1.MenuItem19 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[3];
     If Sender=Form1.MenuItem20 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[4];
     If Sender=Form1.MenuItem21 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[5];
     If Sender=Form1.MenuItem24 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[6];
     If Sender=Form1.MenuItem25 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[7];
     If Sender=Form1.MenuItem26 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[8];
     If Sender=Form1.MenuItem27 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[9];
     If Sender=Form1.MenuItem30 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[10];
     If Sender=Form1.MenuItem31 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[11];
     If Sender=Form1.MenuItem32 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[12];
     If Sender=Form1.MenuItem33 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[13];
     If Sender=Form1.MenuItem34 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[14];
     If Sender=Form1.MenuItem35 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[15];
     If Sender=Form1.MenuItem36 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[16];
     If Sender=Form1.MenuItem37 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[17];
     If Sender=Form1.MenuItem38 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[18];
     If Sender=Form1.MenuItem39 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[19];
     If Sender=Form1.MenuItem40 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[20];
     If Sender=Form1.MenuItem41 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[21];
     If Sender=Form1.MenuItem42 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[22];
     If Sender=Form1.MenuItem43 Then Form1.edFreeText.Text := guidedconfig.cfg.macroList[23];
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
     guidedconfig.prepop := true;
     guidedconfig.Form7.PageControl1.ActivePageIndex := 0;
     guidedconfig.Form7.Show;
     guidedconfig.Form7.BringToFront;
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
     if (Button = mbRight) And ctrl.itemsIn then
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
     //if itemsIn and guidedconfig.cfg.txAllowed() Then
     if ctrl.itemsIn Then
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
               ctrl.txMode := 65;

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

               wcount := WordCount(exchange,[' ']);
               if wcount = 3 Then
               Begin
                    // Since I have three words I can potentially work with this...
                    word1 := ExtractWord(1,exchange,[' ']);
                    word2 := ExtractWord(2,exchange,[' ']);
                    word3 := ExtractWord(3,exchange,[' ']);
                    If (word1 = 'CQ') Or (word1 = 'QRZ') Or (word1 = 'CQDX') Then
                    Begin
                         If word2 = 'DX' Then
                         Begin
                              If length(word3)> 2 Then
                              begin
                                   if mval.evalCSign(word3) then Form1.edHisCall.Text := word3 Else Form1.edHisCall.Text := '';
                                   Form1.edHisGrid.Text := '';
                                   resolved := True;
                                   ctrl.answeringCQ := True;
                                   doQSO := True;
                                   msgToSend := word3 + ' ' + ctrl.myCall + ' ' + ctrl.myGrid;
                                   ctrl.doCWID := False;
                              end;
                         end
                         else
                         begin
                              if length(word2)>2 Then
                              Begin
                                   if mval.evalCSign(word2) then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                              end
                              else
                              begin
                                   Form1.edHisCall.Text := '';
                              end;
                              if length(word3)>3 Then
                              Begin
                                   if mval.evalGrid(word3) then edHisGrid.Text := word3 else edHisGrid.text := '';
                              end
                              else
                              begin
                                   Form1.edHisGrid.Text := '';
                              end;
                              resolved    := True;
                              ctrl.answeringCQ := True;
                              doQSO       := True;
                              msgToSend   := word2 + ' ' + ctrl.myCall + ' ' + ctrl.myGrid[1..4];
                              ctrl.doCWID := False;
                         end;
                    End
                    Else
                    Begin
                         If word1 = ctrl.myCall Then
                         Begin
                              // Seems to be a call to me.
                              // word3 could/should be as follows...
                              // Grid, signal report, R signal report, an RRR or a 73
                              resolved := False;
                              if mval.evalGrid(word3) And Not resolved Then
                              Begin
                                   // This seems to be a callsign calling me with a grid
                                   // The usual response would be a signal report back
                                   If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   If mval.evalGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + ctrl.myCall + ' ' + siglevel;
                                   ctrl.doCWID := False;
                              End;
                              if (word3[1] = '-') And not resolved Then
                              Begin
                                   // This seems an -## signal report
                                   // The usual response would be an R-##
                                   If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + ctrl.myCall + ' R' + siglevel;
                                   ctrl.doCWID := False;
                              End;
                              if (word3[1..2] = 'R-') And not resolved Then
                              Begin
                                   // This seems an R-## response to my report
                                   // The usual response would be an RRR
                                   If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + ctrl.myCall + ' RRR';
                                   ctrl.doCWID := False;
                              End;
                              if (word3 = 'RRR') And not resolved Then
                              Begin
                                   // This is an ack.  The usual response would be 73
                                   If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + ctrl.myCall + ' 73';
                                   if guidedconfig.cfg.cwIDall or guidedconfig.cfg.cwIDfree Then ctrl.doCWID := True else ctrl.doCWID := False;
                              End;
                              if (word3 = '73') And not resolved Then
                              Begin
                                   // The usual response to a 73 is a 73
                                   If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := True;
                                   msgToSend := word2 + ' ' + ctrl.myCall + ' 73';
                                   if guidedconfig.cfg.cwIDall or guidedconfig.cfg.cwIDfree Then ctrl.doCWID := True else ctrl.doCWID := False;
                              End;
                         End
                         Else
                         Begin
                              // A call to someone else, lets not break into that, but prep to tail in once the existing QSO is complete.
                              If mval.evalCSign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                              If mval.evalGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                              If Length(Form1.edHisCall.Text)>1 Then
                              Begin
                                   resolved    := True;
                                   ctrl.answeringCQ := False;
                                   doQSO       := False;
                                   msgToSend   := word2 + ' ' + ctrl.myCall + ' ' + ctrl.myGrid[1..4];
                                   ctrl.doCWID := False;
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
                    word1 := ExtractWord(1,exchange,[' ']);
                    word2 := ExtractWord(2,exchange,[' ']);
                    If (word1='QRZ') or (word1='CQ') Then
                    Begin
                         If mval.evalCSign(word2) Then
                         Begin
                              Form1.edHisCall.Text := word2;
                              Form1.edHisGrid.Text := '';
                              msgToSend := word2 + ' ' + ctrl.myCall;
                              resolved := True;
                              doQSO       := True;
                              ctrl.answeringCQ := True;
                              ctrl.doCWID := False;
                         end
                         else
                         begin
                              resolved := False;
                              exchange := '';
                         end;
                    End
                    Else
                    Begin
                         exchange := '';
                         resolved := False;
                    End;
                    // Now looking for my callsign with -##, R-##, RRR or 73
                    if not resolved then
                    Begin
                         If word1=ctrl.myCall Then
                         Begin
                              If mval.evalCSign(word2) Then
                              Begin
                                   Form1.edHisCall.Text := word2;
                                   msgToSend := word2 + ' ' + siglevel;
                                   resolved := True;
                                   ctrl.doCWID := False;
                              End
                              Else
                              Begin
                                   resolved := False;
                              End;
                              if not resolved then
                              Begin
                                   if word2 = 'RRR'Then
                                   Begin
                                        msgToSend := edHisCall.Text + ' 73';
                                        Resolved := True;
                                        doQSO       := True;
                                        if guidedconfig.cfg.cwIDall or guidedconfig.cfg.cwIDfree Then ctrl.doCWID := True else ctrl.doCWID := False;
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
                                        ctrl.doCWID := False;
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
                                        ctrl.doCWID := False;
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
                         ctrl.watchMulti := False;
                         if guidedconfig.cfg.noMultiQSO And Form1.chkMultiDecode.Checked Then
                         Begin
                              preTXCF := entTXCF;
                              preRXCF := entRXCF;
                              if Form1.chkMultiDecode.Checked Then Form1.chkMultiDecode.Checked := False;
                              rxCount := 0;
                              if guidedconfig.cfg.multiRestore Then ctrl.watchMulti := True else ctrl.watchMulti := False;
                         End;
                         Form1.chkEnTX.Checked := True;
                         Form1.rbGenMsg.Checked := True;
                         Form1.rbGenMsg.Font.Color := clRed;
                         Form1.rbFreeMsg.Font.Color  := clBlack;
                         ctrl.useBuffer := 0;
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
          if IsWordPresent('ERROR:', foo, [' ']) Then lineErr := True;
          if IsWordPresent('CQ', foo, [' ']) Then lineCQ := True;
          if IsWordPresent('QRZ', foo,  [' ']) Then lineCQ := True;
          if IsWordPresent(ctrl.myCall, foo,  [' ']) Then lineMyCall := True;
          myBrush := TBrush.Create;
          with (Control as TListBox).Canvas do
          begin
               myColor := guidedconfig.cfg.QSOColor;
               if lineCQ Then myColor := guidedconfig.cfg.cqColor;
               if lineMyCall Then myColor := guidedconfig.cfg.myColor;
               if lineErr Then myColor := guidedconfig.cfg.cqColor;
               if guidedconfig.cfg.noColor then myColor := clSilver;
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
          ctrl.txPeriod := 0;
          Form1.rbTX1.Font.Color := clRed;
          Form1.rbTX2.Font.Color := clBlack;
     End;
     If Form1.rbTX2.Checked Then
     Begin
          ctrl.txPeriod := 1;
          Form1.rbTX2.Font.Color := clRed;
          Form1.rbTX1.Font.Color := clBlack;
     End;
     if ctrl.nextAction = 3 Then ctrl.nextAction := 2;
end;

procedure TForm1.rbUseMixChange(Sender: TObject);
begin
     If rbUseLeft.Checked Then guidedconfig.cfg.useAudioLeft  := True else guidedconfig.cfg.useAudioLeft := False;
     If rbUseRight.Checked Then guidedconfig.cfg.useAudioRight := True else guidedconfig.cfg.useAudioRight := False;
     if rbUseLeft.Checked Then adc.adcChan := 1;
     if rbUseRight.Checked Then adc.adcChan:= 2;
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
     spectrum.specGain := tbBright.Position;
     guidedconfig.cfg.specBright := tbBright.Position;
end;

procedure TForm1.tbContrastChange(Sender: TObject);
begin
     spectrum.specContrast := tbContrast.Position;
     guidedconfig.cfg.specContrast := tbContrast.Position;
end;

procedure TForm1.btnZeroTXClick(Sender: TObject);
begin
     Form1.spinTXCF.Value := 0;
     if form1.chkAutoTxDF.Checked Then form1.spinDecoderCF.Value := 0;
end;

procedure TForm1.btnLogQSOClick(Sender: TObject);
var
   ss   : String;
   fqrg : Single;
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
     log.logmycall := ctrl.myCall;
     log.logmygrid := ctrl.myGrid;
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
     if ctrl.haveOddBuffer Then
     Begin
          proceed := True;
     End;
     if ctrl.haveEvenBuffer Then
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
{ TODO : FIX Sample Rate adjuster! }
               globalData.d65samfacin := 1.0;
               //if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
               d65samfacout := 1.0;
               d65.glMouseDF := Form1.spinDecoderCF.Value;
               if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
               if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
               if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
               if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;
               If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
               d65.glNshift := 0;
               if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
               d65.glNzap := 0;
               d65.gldecoderPass := 0;
               if form1.chkMultiDecode.Checked Then d65.glsteps := 1 else d65.glsteps := 0;
               ctrl.reDecode := True;
               ctrl.d65doDecodePass := True;
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
     If ctrl.firstReport Then
     Begin
          rawdec.Form5.ListBox1.Clear;
          rawdec.Form5.ListBox1.Items.Add(rpt);
          ctrl.firstReport := False;
          ctrl.itemsIn := True;
     End
     Else
     Begin
          rawdec.Form5.ListBox1.Items.Add(rpt);
          ctrl.itemsIn := True;
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
          csvstr := csvstr + '"' + IntToStr(guidedconfig.cfg.guiQRG) + '"' + ',';
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
          If ctrl.firstReport Then
          Begin
               Form1.ListBox1.Items.Strings[0] := rpt;
               ctrl.firstReport := False;
               ctrl.itemsIn := True;
          End
          Else
          Begin
               Form1.ListBox1.Items.Insert(0,rpt);
               ctrl.itemsIn := True;
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
          if guidedconfig.cfg.saveCSV Then
          Begin
               for ii := 0 to 99 do
               begin
                    if csvEntries[ii] = '' Then
                    begin
                         csvEntries[ii] := csvstr;
                         break;
                    end;
               end;
               form1.saveCSV();
          end;
          // Trying to find a signal report value
          wcount := 0;
          wcount := WordCount(d65.gld65decodes[i].dtDecoded,[' ']);
          if wcount = 3 Then
          Begin
               word1 := ExtractWord(1,d65.gld65decodes[i].dtDecoded,[' ']); // CQ or a call sign
               word2 := ExtractWord(2,d65.gld65decodes[i].dtDecoded,[' ']); // call sign
               word3 := ExtractWord(3,d65.gld65decodes[i].dtDecoded,[' ']); // could be grid or report.
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
                    if (word1 = ctrl.myCall) And isSigRep(word3) Then
                    Begin
                         if TrimLeft(TrimRight(word3))[1] = 'R' Then log.Form2.edLogRReport.Text := TrimLeft(TrimRight(word3))[2..4];
                         if TrimLeft(TrimRight(word3))[1] = '-' Then log.Form2.edLogRReport.Text := TrimLeft(TrimRight(word3))[1..3];
                    end;
               end;
          end;
     end;
End;

procedure TForm1.tbDgainLChange(Sender: TObject);
begin
     // Handle change to Digital Gain
     guidedconfig.cfg.dgainL := tbDGainL.Position;
     guidedconfig.cfg.dgainR := tbDGainR.Position;
     Form1.Label10.Caption := 'L: ' + IntToStr(tbDGainL.Position);
     If tbDGainL.Position <> 0 Then Form1.Label10.Font.Color := clRed else Form1.Label10.Font.Color := clBlack;
     Form1.Label11.Caption := 'R: ' + IntToStr(tbDGainR.Position);
     If tbDGainR.Position <> 0 Then Form1.Label11.Font.Color := clRed else Form1.Label11.Font.Color := clBlack;
end;

procedure TForm1.Timer2Timer(Sender : TObject);
var
   qrgk  : Single;
   qrghz : Integer;
   valid : Boolean;
begin
     Timer2.Enabled := false;
     // OK, input was made to the QRG Entry field and seems to be completed so
     // lets try to validate the field.
     //function testQRG(const qrg : String; var qrgk : Double; var qrghz : Integer) : Boolean;
     qrgk := 0.0;
     qrghz := 0;
     if mval.testQRG(editManQRG.Text, qrgk, qrghz) then
     begin
          valid := false;
          if (qrghz >    1799999) and (qrghz <    2000001) then valid := true;  // 160M
          if (qrghz >    3499999) and (qrghz <    4000001) then valid := true;  //  80M
          if (qrghz >    6999999) and (qrghz <    7300001) then valid := true;  //  40M
          if (qrghz >   10099999) and (qrghz <   10150001) then valid := true;  //  30M
          if (qrghz >   13999999) and (qrghz <   14350001) then valid := true;  //  20M
          if (qrghz >   18067999) and (qrghz <   18168001) then valid := true;  //  17M
          if (qrghz >   20999999) and (qrghz <   21450001) then valid := true;  //  15M
          if (qrghz >   24889999) and (qrghz <   24990001) then valid := true;  //  12M
          if (qrghz >   27999999) and (qrghz <   29700001) then valid := true;  //  10M
          if (qrghz >   49999999) and (qrghz <   54000001) then valid := true;  //   6M
          if (qrghz >  143999999) and (qrghz <  148000001) then valid := true;  //   2M
          if (qrghz >  221999999) and (qrghz <  225000001) then valid := true;  //   1.25M
          if (qrghz >  419999999) and (qrghz <  450000001) then valid := true;  //   70cm
          if (qrghz >  901999999) and (qrghz <  928000001) then valid := true;  //   33cm
          if (qrghz > 1269999999) and (qrghz < 1300000001) then valid := true;  //   23cm
     end;
     if not valid then editManQRG.Text := '0.0';
     if valid then guidedconfig.cfg.guiQRG := qrghz;
     if valid then editManQRG.Text := floatToStr(qrghz/1000);
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
     if audioAve1 > 0 Then audioAve1 := (audioAve1+adc.specLevel1) DIV 2 else audioAve1 := adc.specLevel1;
     if audioAve2 > 0 Then audioAve2 := (audioAve1+adc.specLevel2) DIV 2 else audioAve2 := adc.specLevel2;
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
     // Convert S Level to dB for text display
     if adc.specLevel1 > 0 Then Form1.rbUseLeft.Caption := 'L ' + IntToStr(Round((audioAveL*0.4)-20)) Else Form1.rbUseLeft.Caption := 'L -20';
     if adc.specLevel2 > 0 Then Form1.rbUseRight.Caption := 'R ' + IntToStr(Round((audioAveR*0.4)-20)) Else Form1.rbUseRight.Caption := 'R -20';
     if (adc.specLevel1 < 40) Or (adc.specLevel1 > 60) Then rbUseLeft.Font.Color := clRed else rbUseLeft.Font.Color := clBlack;
     if (adc.specLevel2 < 40) Or (adc.specLevel2 > 60) Then rbUseRight.Font.Color := clRed else rbUseRight.Font.Color := clBlack;
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
          //rbc.glrbQRG := IntToStr(guidedconfig.cfg.guiQRG);  // (Was) If parseCallSign.valQRG(intvar) Then rbc.glrbQRG := Form1.editManQRG.Text else rbc.glrbQRG := '0';
     End;
     // Update form title with rb info.
     If guidedconfig.cfg.useRB and not guidedconfig.cfg.noSpotting Then
     Begin
          foo := 'JT65-HF Version ' + verHolder.verReturn() + '  [RB Enabled, ';
          //If cfgvtwo.Form6.cbNoInet.Checked Then foo := foo + ' offline mode.  ' Else foo := foo + ' online mode.  ';
          //If cfgvtwo.Form6.cbNoInet.Checked Then
          //Begin
               //foo := foo + 'QRG = ' + Form1.editManQRG.Text + ' KHz]';
          //End
          //Else
          //Begin
               //If globalData.rbLoggedIn Then
                  //foo := foo + 'Logged In.  QRG = ' + Form1.editManQRG.Text + ' KHz]'
               //Else
                  foo := foo + 'Not Logged In.  QRG = ' + Form1.editManQRG.Text + ' KHz]';
          //End;
          foo := foo + ' [de ' + ctrl.myCall + ']';
     End
     Else
     Begin
          foo := 'JT65-HF Version ' + verHolder.verReturn() + '  [de ' + ctrl.myCall + ']';
     End;
     if Form1.Caption <> foo Then Form1.Caption := foo;
     // Try to login the RB if it's marked online but not logged in.
     //If (cfgvtwo.Form6.cbUseRB.Checked) And (not cfgvtwo.Form6.cbNoInet.Checked) And (not globalData.rbLoggedIn) Then cfgvtwo.glrbcLogin := True;
end;

procedure TForm1.initializerCode();
const
   CSIDL_PERSONAL = $0005;
var
   foo                : String;
   i, ifoo            : Integer;
   vint, tstint       : Integer;
   vstr               : PChar;
   st                 : TSYSTEMTIME;
   tstflt             : Single;
   fname              : String;
   verUpdate          : Boolean;
   PIDL               : PItemIDList;
   Folder             : array[0..MAX_PATH] of Char;
   lfile              : TextFile;
   tbol               : Boolean;
Begin
     // This procedure is only executed once at program start
     // Initialize the decoder output listbox, need this here now in case
     // I need to display an error message later in the initializer.
     timer1.Enabled := false;
     timer2.Enabled := false;
     Form1.ListBox1.Clear;
     ctrl.firstReport := True;
     ctrl.itemsIn := False;
     guidedconfig.Form7.Hide;
     audiodiag.Form6.Hide;
     // basedir holds path to current user's my documents space like:
     // C:\Users\Joe\Documents
     // I have confirmed this to work under Windows 7, Vista, XP and Wine
     //
     // I want to use basedir + \JT65HF\log\  as default location for adif/csv
     //                         \JT65HF\data\ as directory for holding config and fft wisdom
     //                         \JT65HF\kvdt\ as directory for holding KVASD.EXE and KVASD.DAT (maybe...)
     //
     // Get directory basis (basedir) for whatever is like 'My Documents'
     SHGetSpecialFolderLocation(0, CSIDL_PERSONAL, PIDL);
     SHGetPathFromIDList(PIDL, Folder);
     guidedconfig.cfg.baseDir := Folder;
     guidedconfig.cfg.srcDir := guidedconfig.cfg.baseDir + '\JT65HF';
     guidedconfig.cfg.logdir := guidedconfig.cfg.baseDir + '\JT65HF\log';
     guidedconfig.cfg.cfgdir := guidedconfig.cfg.baseDir + '\JT65HF\data';
     guidedconfig.cfg.kvdir  := guidedconfig.cfg.baseDir + '\JT65HF\kvdt';
     log.adifName := guidedconfig.cfg.logdir + '\JT65HF_ADIFLOG.adi';
{ TODO : Change this (or at least attempt to) to use KVASD in installed directory but use KVASD.DAT in kv directory. }
     d65.gld65kvfname  := guidedconfig.cfg.kvdir + '\KVASD.DAT';
     d65.gld65kvpath   := guidedconfig.cfg.kvdir;
     d65.gld65wisfname := guidedconfig.cfg.cfgdir + '\wisdom2.dat';
     if FileExists(d65.gld65kvfname) Then DeleteFileUTF8(d65.gld65kvfname);
     if not directoryExists(guidedconfig.cfg.srcDir) Then createDir(guidedconfig.cfg.srcDir);
     if not directoryExists(guidedconfig.cfg.logdir) Then createDir(guidedconfig.cfg.logdir);
     if not directoryExists(guidedconfig.cfg.cfgdir) Then createDir(guidedconfig.cfg.cfgdir);
     if not directoryExists(guidedconfig.cfg.kvdir)  Then createDir(guidedconfig.cfg.kvdir);
     // Copy over what I can from an old install.  Alas, configuration is no longer usable in the new world order.
     if not fileExists(guidedconfig.cfg.cfgdir+'\wisdom2.dat') And fileExists(GetAppConfigDir(False)+'wisdom2.dat') Then
     Begin
          // OK, I have wisdom2.dat in the old location but not the new so copy it.
          if fileutil.CopyFile(GetAppConfigDir(False)+'wisdom2.dat',guidedconfig.cfg.cfgdir+'\wisdom2.dat') Then showmessage('Copied wisdom');
     end;
     if not fileExists(guidedconfig.cfg.logdir+'\JT65HF-log.csv') Then
     Begin
          AssignFile(lfile, guidedconfig.cfg.logdir+'\JT65HF-log.csv');
          rewrite(lfile);
          WriteLn(lfile,'"Date","Time","QRG","Sync","DB","DT","DF","Decoder","Exchange"');
          closeFile(lfile);
     end;
     if not fileExists(guidedconfig.cfg.logdir+'\JT65HF_ADIFLOG.adi') Then
     Begin
          AssignFile(lfile, guidedconfig.cfg.logdir+'\JT65HF_ADIFLOG.adi');
          rewrite(lfile);
          writeln(lfile,'JT65-HF ADIF Export');
          writeln(lfile,'<eoh>');
          closeFile(lfile);
     end;
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
     tstint := 0;
     tstflt := 0.0;
     Form1.Caption := 'JT65-HF V' + verHolder.verReturn() + ' (c) 2009,2010 W6CQZ.  Free to use/modify/distribute under GPL 2.0 License.';
     // See comments in procedure code to understand why this is a MUST to use.
     DisableFloatingPointExceptions();
     // Read in existing configuration or create new if necessary
     fname := guidedconfig.cfg.cfgdir+'\jt65hf.ini';
     if not fileExists(fname) Then
     Begin
          guidedconfig.cfg.configFile := fname;
          guidedconfig.prepop := False;
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
          // Read back the recently saved configuration
          guidedconfig.cfg.configFile := fname;
          guidedconfig.prepop := true;
          guidedconfig.Form7.readConfig(fname);
          self.Visible := true;
          self.Show;
          self.BringToFront;
     End
     Else
     Begin
          guidedconfig.cfg.configFile := fname;
          guidedconfig.prepop := true;
          guidedconfig.Form7.readConfig(fname);
          guidedconfig.Form7.PageControl1.ActivePageIndex := 0;
          if not (verholder.verReturn() = guidedconfig.cfg.version) then
          begin
               guidedconfig.cfg.version := verholder.verReturn();
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
          End;
     end;
     // At this point configuration has been read (or created and read if needed)
     // All configurable variables now exist in the guidedconfig.cfg object
     // Now set GUI elements to pre-configured values or sane defaults
     d65.gld65dokv     := guidedconfig.cfg.useKV;
     rbUseLeft.Checked := guidedconfig.cfg.useAudioLeft;
     rbUseMixChange(rbUseLeft);
     rbUseRight.Checked := guidedconfig.cfg.useAudioRight;
     rbUseMixChange(rbUseRight);
     tbDgainL.Position := guidedconfig.cfg.dgainL;
     tbDgainLChange(tbDgainL);
     tbDGainR.Position := guidedconfig.cfg.dgainR;
     tbDgainLChange(tbDGainR);
     cbSpecPal.ItemIndex := guidedconfig.cfg.specColor;
     cbSpecPalChange(cbSpecPal);
     tbBright.Position := guidedconfig.cfg.specBright;
     tbBrightChange(tbBright);
     tbContrast.Position := guidedconfig.cfg.specContrast;
     tbContrastChange(tbContrast);
     spinSpecSpeed.Value := guidedconfig.cfg.specSpeed;
     spinSpecSpeedChange(spinSpecSpeed);
     spinGain.Value := guidedconfig.cfg.specGain;
     spinGainChange(spinGain);
     cbSmooth.Checked := guidedconfig.cfg.specSmooth;
     cbSmoothChange(cbSmooth);
     chkAutoTXDF.Checked := guidedconfig.cfg.useTXeqRXDF;
     chkAutoTxDFChange(chkAutoTXDF);
     spinDecoderBW.Value := guidedconfig.cfg.decoderBW;
     spinDecoderBWChange(spinDecoderBW);
     spinDecoderMBW.Value := guidedconfig.cfg.multiBW;
     spinDecoderMBWChange(spinDecoderMBW);
     chkAFC.Checked := guidedconfig.cfg.afc;
     chkAFCChange(chkAFC);
     chkNB.Checked := guidedconfig.cfg.noiseblank;
     chkNBChange(chkNB);
     chkMultiDecode.Checked := guidedconfig.cfg.multi;
     chkMultiDecodeChange(chkMultiDecode);
     cbEnRB.Checked := guidedconfig.cfg.useRB;
     cbEnRBChange(cbEnRB);
     cbEnPSKR.Checked := guidedconfig.cfg.usePSKR;
     cbEnRBChange(cbEnPSKR);
     editManQRG.Text := floatToStrf((guidedconfig.cfg.guiQRG/1000),ffFixed,0,3);
     editManQRGChange(editManQRG);
     guidedconfig.Form7.saveConfig(fname);
     // This sets the full station callsign prefix callsign suffix (Will be either just callsign or prefix/callsign or callsign/suffix)
     ctrl.myCall := guidedconfig.cfg.getPrefix() + guidedconfig.cfg.callsign + guidedconfig.cfg.getSuffix();
     ctrl.myGrid := guidedconfig.cfg.grid;
     rig1.rigcontroller := guidedconfig.cfg.CATMethod;
     rig1.pollRig();  // Go ahead and attempt to read the rig and update the main gui
     sleep(100);
{ TODO : Change this to use QRG validator code! }
     if not (upcase(rig1.rigcontroller) = 'NONE') then editManQRG.Text := floatToStr(rig1.qrg/1000);
     // Setup PTT controller
     rig1.useAltPTT := guidedconfig.cfg.AltPTT;
     if guidedconfig.cfg.PTTMethod = 'VOX' then rig1.useVOXPTT := true else rig1.useVOXPTT := false;
     if guidedconfig.cfg.PTTMethod = 'COM' then rig1.useSerialPTT := true else rig1.useSerialPTT := false;
     if guidedconfig.cfg.PTTMethod = 'CAT' then rig1.useCATPTT := true else rig1.useCATPTT := false;
     if guidedconfig.cfg.PTTMethod = 'OFF' then rig1.noTX := true else rig1.noTX := false;
     rig1.pttlines := guidedconfig.cfg.pttLines;
     rig1.pttport := guidedconfig.cfg.PTTPort;
     rig1.ptt(false);
     // Init PA.  If this doesn't work there's no reason to continue.
     //audiodiag.Form6.Label5.Visible := True;
     //audiodiag.Form6.Show;
     //audiodiag.Form6.Visible := True;
     //audiodiag.Form6.BringToFront;
     audiodiag.Form6.Label3.Caption := guidedconfig.cfg.soundInS;
     audiodiag.Form6.Label4.Caption := guidedconfig.cfg.soundOutS;
     audiodiag.Form6.Label5.Caption := 'Initializing PortAudio';
     PaResult := portaudio.Pa_Initialize();
     If PaResult <> 0 Then
     Begin
          audiodiag.Form6.Label5.Caption := 'PortAudio open failed';
          ShowMessage('Fatal Error.  Could not initialize portaudio.');
          halt;
     end;
     // Setup input device
     ppaInParams := @paInParams;
     paInParams.device := guidedconfig.cfg.soundIn;
     paInParams.sampleFormat := paInt16;
     paInParams.suggestedLatency := 1;
     paInParams.hostApiSpecificStreamInfo := Nil;
     if guidedconfig.cfg.forceMono then paInParams.channelCount := 1 else paInParams.channelCount := 2;
     // Set rxBuffer index to start of array and set ptr to start of buffer..
     adc.d65rxBufferIdx := 0;
     adc.adcT := 0;
     adc.d65rxBufferPtr := @adc.d65rxBuffer[0];
     // Initialize rx stream.
     audiodiag.Form6.Label5.Caption := 'Opening input device';
     if guidedconfig.cfg.forceMono then
     begin
          // Dealing with a mono stream either by necessity or user choice.
          audiodiag.Form6.Label5.Caption := 'Opening input device in mono mode';
          paResult := portaudio.Pa_OpenStream(paInStream,ppaInParams,Nil,11025,2048,0,@adc.madcCallback,Pointer(Self));
     end
     else
     begin
          audiodiag.Form6.Label5.Caption := 'Opening input device in stereo mode';
          paResult := portaudio.Pa_OpenStream(paInStream,ppaInParams,Nil,11025,2048,0,@adc.sadcCallback,Pointer(Self));
     end;
     if paResult <> 0 Then
     Begin
          if guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Failed to open in mono mode';
          if not guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Failed to open in stereo mode';
          audiodiag.Form6.Label1.Caption := 'Input device status:  FAIL';
          for i := 0 to 1000 do
          begin
               application.ProcessMessages;
               sleep(10);
          end;
          ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)) + sLineBreak +
                      'Could not setup for input.  Please check your setup.' + sLineBreak +
                      'Attempted to open device:  ' + guidedconfig.cfg.soundInS);
          halt;
     end
     else
     begin
          if guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Opened input in mono mode';
          if not guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Opened input in stereo mode';
          audiodiag.Form6.Label1.Caption := 'Input device status:  OK';
          // Start the stream.
          audiodiag.Form6.Label5.Caption := 'Starting input sample stream';
          paResult := portaudio.Pa_StartStream(paInStream);
     end;
     if paResult <> 0 Then
     Begin
          audiodiag.Form6.Label5.Caption := 'Input sample stream not running';
          audiodiag.Form6.Label1.Caption := 'Input device status:  FAIL';
          //for i := 0 to 1000 do
          //begin
               //application.ProcessMessages;
               //sleep(10);
          //end;
          ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)) + sLineBreak +
                      'Could not setup for input.  Please check your setup.' + sLineBreak +
                      'Attempted to open device:  ' + guidedconfig.cfg.soundInS);
          halt;
     End
     else
     begin
          audiodiag.Form6.Label5.Caption := 'Input sample stream running';
          audiodiag.Form6.Label1.Caption := 'Input device status:  OK';
     end;
     // Setup output device
     audiodiag.Form6.Label5.Caption := 'Opening output device';
     ppaOutParams := @paOutParams;
     paOutParams.device := guidedconfig.cfg.soundOut;
     paOutParams.sampleFormat := paInt16;
     paOutParams.suggestedLatency := 1;
     paOutParams.hostApiSpecificStreamInfo := Nil;
     if guidedconfig.cfg.forceMono then paOutParams.channelCount := 1 else paOutParams.channelCount := 2;
     // Set txBuffer index to start of array and set ptr to start of buffer.
     dac.d65txBufferIdx := 0;
     dac.dacT := 0;
     dac.d65txBufferPtr := @dac.d65txBuffer[0];
     // Initialize tx stream.
     if guidedconfig.cfg.forceMono then
     begin
          // Dealing with a mono stream either by necessity or user choice.
          audiodiag.Form6.Label5.Caption := 'Opening output device in mono mode';
          paResult := portaudio.Pa_OpenStream(paOutStream,Nil,ppaOutParams,11025,2048,0,@dac.mdacCallback,Pointer(Self));
     end
     else
     begin
          audiodiag.Form6.Label5.Caption := 'Opening output device in stereo mode';
          paResult := portaudio.Pa_OpenStream(paOutStream,Nil,ppaOutParams,11025,2048,0,@dac.sdacCallback,Pointer(Self));
     end;
     if paResult <> 0 Then
     Begin
          if guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Failed to open in mono mode';
          if not guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Failed to open in stereo mode';
          audiodiag.Form6.Label2.Caption := 'Output device status:  FAIL';
          //for i := 0 to 1000 do
          //begin
               //application.ProcessMessages;
               //sleep(10);
          //end;
          ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)) + sLineBreak +
                      'Could not setup for output.  Please check your setup.' + sLineBreak +
                      'Attempted to open device:  ' + guidedconfig.cfg.soundOutS);
          halt;
     End
     else
     begin
          if guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Opened output in mono mode';
          if not guidedconfig.cfg.forceMono then audiodiag.Form6.Label5.Caption := 'Opened output in stereo mode';
          audiodiag.Form6.Label2.Caption := 'Output device status:  OK';
     end;
     // Start the stream.
     audiodiag.Form6.Label5.Caption := 'Starting output sample stream';
     paResult := portaudio.Pa_StartStream(paOutStream);
     if paResult <> 0 Then
     Begin
          audiodiag.Form6.Label5.Caption := 'Output sample stream not running';
          audiodiag.Form6.Label2.Caption := 'Output device status:  FAIL';
          //for i := 0 to 1000 do
          //begin
               //application.ProcessMessages;
               //sleep(10);
          //end;
          ShowMessage('PA Error:  ' + StrPas(portaudio.Pa_GetErrorText(paResult)) + sLineBreak +
                      'Could not setup for output.  Please check your setup.' + sLineBreak +
                      'Attempted to open device:  ' + guidedconfig.cfg.soundOutS);
          halt;
     End
     else
     begin
          audiodiag.Form6.Label5.Caption := 'Output sample stream running';
          audiodiag.Form6.Label2.Caption := 'Output device status:  OK';
     end;
     ctrl.soundvalid := True;
     audiodiag.Form6.Label5.Caption := 'Input/Output sample streams running';
     //while (adc.adcCount < 50) and (dac.dacCount < 50) do
     //begin
     //     audiodiag.Form6.Label5.Caption := 'This window will close shortly, testing streams...';
     //     audiodiag.Form6.Label6.Caption := 'ADC Calls:  ' + IntToStr(adc.adcCount) + sLineBreak + sLineBreak +
     //                                       'ADC SR:  ' + FloatToStrF(adc.adcErate,ffFixed,0,4) + sLineBreak + sLineBreak +
     //                                       'CPU Load ADC:  ' + FloatToStrF(portaudio.Pa_GetStreamCpuLoad(paInStream)*100,ffFixed,0,2) + ' %' + '  DAC:  ' + FloatToStrF(portaudio.Pa_GetStreamCpuLoad(paOutStream)*100,ffFixed,0,2) + ' %' + sLineBreak + sLineBreak +
     //                                       'ADC Last Block Time:  ' + FloatToStrF(adc.adcErr,ffFixed,0,2) + ' ms' + sLineBreak + sLineBreak +
     //                                       'DAC Calls:  ' + IntToStr(dac.dacCount) + sLineBreak + sLineBreak +
     //                                       'DAC SR:  ' + FloatToStrF(dac.dacErate,ffFixed,0,4) + sLineBreak + sLineBreak +
     //                                       'DAC Last Block Time:  ' + FloatToStrF(dac.dacErr,ffFixed,0,2) + ' ms' + sLineBreak + sLineBreak +
     //                                       'TIME ADC:  ' + FloatToStrF((adc.adcCount*adc.adcErr)/1000,ffFixed,0,2) + '  DAC:  ' + FloatToStrF((dac.dacCount*dac.dacErr)/1000,ffFixed,0,2) + ' Seconds';
     //     application.ProcessMessages;
     //     sleep(10);
     //end;
     //audiodiag.Form6.Label5.Visible := false;
     //audiodiag.Form6.Hide;

     //With wisdom comes speed.
     d65.glfftFWisdom := 0;
     d65.glfftSWisdom := 0;
     if guidedconfig.cfg.useOptFFT Then
     Begin
          fname := guidedconfig.cfg.cfgdir+'\wisdom2.dat';
          if FileExists(fname) Then
          Begin
               // I have data for FFTW_MEASURE metrics use ical settings in
               // decode65 for measure.
               d65.glfftFWisdom := 1;  // Causes measure wisdom to be loaded on first pass of decode65
               d65.glfftSWisdom := 11; // uses measure wisdom (no load/no save) on != first pass of decode65
               ctrl.fftvalid := true;
          End
          Else
          Begin
               showMessage('FFT Wisdom missing.  Searched at:' + sLineBreak + fname);
               ctrl.fftvalid := false;
          End;
     End
     Else
     Begin
          d65.glfftFWisdom := 0;
          d65.glfftSWisdom := 0;
          showMessage('Running without optimal FFT enabled by user request.');
          ctrl.fftvalid := false;
     End;
     // Setup pchar strings for wisdom and kv data files
     d65.glwisfile := StrAlloc(Length(guidedconfig.cfg.cfgdir+'\wisdom2.dat')+1);
     d65.glkvfname := StrAlloc(Length(guidedconfig.cfg.kvdir+'\KVASD.DAT')+1);
     strPcopy(d65.glkvfname,guidedconfig.cfg.kvdir+'\KVASD.DAT');
     strPcopy(d65.glwisfile,guidedconfig.cfg.cfgdir+'\wisdom2.dat');

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
     ctrl.thisMinute := st.Minute;
     if st.Minute = 0 then
     Begin
          ctrl.lastMinute := 59;
     End
     Else
     Begin
          ctrl.lastMinute := st.Minute-1;
     End;
     if st.Minute = 59 then
     Begin
          ctrl.nextMinute := 0;
     End
     Else
     Begin
          ctrl.nextMinute := st.Minute+1;
     End;
     // Create the decoder thread with param False so it starts.
     d65.glinProg := False;
     // Create threads with param False so they start.
     decoderThread := decodeThread.Create(False);
     rbThread := rbcThread.Create(False);
     ctrl.doRBReport := False;
     ctrl.doRB       := False;
     ctrl.rbcPing    := False;
     //
     // RB/PSKR Setup
     //
     if not guidedconfig.cfg.noSpotting Then
     Begin
          cbEnRB.Checked   := True;
          cbEnRB.Enabled   := True;
          if guidedconfig.cfg.usePSKR then
          begin
               // Initialize PSK Reporter DLL
               If PSKReporter.ReporterInitialize('report.pskreporter.info','4739') = 0 Then pskrstat := 1 else pskrstat := 0;
               cbEnPSKR.Checked := True;
          end
          else
          begin
               cbEnPSKR.Checked := False;
          end;
          if guidedconfig.cfg.useRB then
          begin
               cbEnRB.Checked := True;
          end
          else
          begin
               cbEnRB.Checked := False;
          end;
     End
     Else
     Begin
          cbEnPSKR.Checked := False;
          cbEnPSKR.Enabled := False;
          cbEnRB.Checked   := False;
          cbEnRB.Enabled   := False;
     end;
     // Setup rbstats
     i := 0;
     while i < 500 do
     begin
          rbsHeardList[i].callsign := '';
          rbsHeardList[i].count := 0;
          inc(i);
     end;
     rb.myCall := guidedconfig.cfg.rbcallsign;
     //if ctrl.soundvalid then label2.Caption := 'In: ' + guidedconfig.cfg.soundInS + ' Out: ' + guidedconfig.cfg.soundOutS else Label2.Caption := 'Sound I/O INVALID';
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
        globalData.d65samfacin := 1.0;
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
     if ctrl.useBuffer = 0 Then
     Begin
          curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     End;
     if ctrl.useBuffer = 1 Then
     Begin
          curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
          if guidedconfig.cfg.cwIDall or guidedconfig.cfg.cwIDfree Then ctrl.doCWID := True else ctrl.doCWID := False;
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
          if ctrl.doCWID Then
          Begin
               diagout.Form3.ListBox3.Clear;
               ctrl.doCWID := False;
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
               StrPCopy(cwidMsg,UpCase(padRight(ctrl.myCall,22)));
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
          ctrl.TxValid := True;
          ctrl.TxDirty := False;
          ctrl.thisTX := curMsg + IntToStr(txdf);
          if ctrl.lastTX <> ctrl.thisTX Then
          Begin
               ctrl.txCount := 0;
               ctrl.lastTX := ctrl.thisTX;
          End
          Else
          Begin
               ctrl.txCount := ctrl.txCount + 1;
          End;
          ctrl.thisAction := 3;
          ctrl.actionSet := True;
     End
     Else
     Begin
          globalData.txInProgress := False;
          ctrl.rxInProgress := False;
          form1.chkEnTX.Checked := False;
          ctrl.TxValid := False;
          ctrl.TxDirty := True;
          ctrl.thisAction := 2;
          ctrl.lastTX := '';
          ctrl.actionSet := False;
     End;
End;

procedure TForm1.genTX2();
Var
   txdf : CTypes.cint;
   txsr : CTypes.cdouble;
Begin
     // Generate TX samples for a late starting TX Cycle.
     if ctrl.useBuffer = 0 Then
     Begin
          curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     End;
     if ctrl.useBuffer = 1 Then
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
          ctrl.TxValid := True;
          ctrl.TxDirty := False;
          ctrl.thisTX := curMsg + IntToStr(txdf);
          if ctrl.lastTX <> ctrl.thisTX Then
          Begin
               ctrl.txCount := 0;
               ctrl.lastTX := ctrl.thisTX;
          End
          Else
          Begin
               ctrl.txCount := ctrl.txCount + 1;
          End;
          ctrl.thisAction := 6;
          ctrl.actionSet := True;
     End
     Else
     Begin
          globalData.txInProgress := False;
          ctrl.rxInProgress := False;
          form1.chkEnTX.Checked := False;
          ctrl.TxValid := False;
          ctrl.TxDirty := True;
          ctrl.thisAction := 2;
          ctrl.actionSet := False;
          ctrl.lastTX := '';
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

//procedure TForm1.rbThreadCheck();
//Var
//   ts     : TDateTime;
//   tscalc : Double;
//   i      : Integer;
//Begin
//     ts := Now;
//     If rbc.glrbActive Then
//     Begin
//          // Compare timestamp in ts to globalData.rbEnterTS and if difference
//          // is greater than 90 seconds I will need to assume rbc thread has
//          // gone astray.
//          tscalc := SecondSpan(ts,rbc.glrbEnterTS);
//          If tscalc > 90 Then
//          Begin
//               // rb thread was started at least 90 seconds ago and is, seemingly,
//               // stuck.  Now the question is what to do about it.  Perhaps the
//               // most solid method will be to suspend its thread, terminate the
//               // thread, dispose of the thread and re-create it.  If that doesn't
//               // clear it I don't know what else will. ;)
//               rbThread.Suspend;
//               rbThread.Terminate;
//               rbThread.Destroy;
//               // This is probably undesirable, but, for now, I am going to clear
//               // the entire rbReports array to prevent an invalid entry in the
//               // structure from triggering a slow speed loop.  i.e. rb hangs,
//               // it's terminated then hangs again on restarting due to something
//               // in the rbReports array being processed again.
//               for i := 0 to 499 do
//               Begin
//                    rbc.glrbReports[i].rbProcessed := True;
//               End;
//               rbThread := rbcThread.Create(False);
//               rbc.glrbActive := False;
//          End;
//     End;
//End;

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
     if (Length(TrimLeft(TrimRight(Form1.edMsg.Text)))>1) And (ctrl.useBuffer=0) Then valTx := True;
     if (Length(TrimLeft(TrimRight(Form1.edFreeText.Text)))>1) And (ctrl.useBuffer=1) Then valTx := True;

     if not valTX and not globalData.txInProgress Then form1.chkEnTx.checked := False;

     if valTX and not form1.chkEnTx.checked Then form1.btnEngageTx.Enabled := True else form1.btnEngageTx.Enabled := False;
     if globalData.txInProgress or ctrl.txNextPeriod or (ctrl.nextAction = 3) or form1.chkEnTX.checked Then form1.btnHaltTx.Enabled := True else form1.btnHaltTx.Enabled := False;

     // Automatic TX checkbox.
     If Form1.chkEnTX.Checked Then
     Begin
          // Changing this to allow late (up to 15 seconds) start.  It seems a necessary
          // evil.
          txOdd  := False;
          if form1.rbTX2.Checked Then txOdd := True else txOdd := False;
          if (ctrl.thisSecond < 16) and not ctrl.actionSet Then
          Begin
               // Since thisSecond is 0..15 we can check to see if a late TX start
               // could work.
               if txOdd and Odd(ctrl.thisMinute) Then
               Begin
                    // yes, I can start this period.
                    ctrl.thisAction := 6;
                    ctrl.nextAction := 2;
               End;
               if not txOdd and not Odd(ctrl.thisMinute) Then
               Begin
                    // yes, I can start this period.
                    ctrl.thisAction := 6;
                    ctrl.nextAction := 2;
               End;
          End
          Else
          Begin
               ctrl.txNextPeriod := True;
          End;
     End
     Else
     Begin
          ctrl.txNextPeriod := False;
          if ctrl.nextAction = 3 then ctrl.nextAction := 2;
     End;
     If ctrl.txNextPeriod Then
     Begin
          // A TX cycle has been requested.  Determine if this can happen next
          // minute and, if so, setup to do so.
          // To accomplish this I need to look at requested TX period setting
          // and value of next minute.  If requested tx period and value of
          // next minute match (even/odd) then I will set nextAction to tx.
          ctrl.nextAction := 2;
          if Form1.rbTX2.Checked And Odd(ctrl.nextMinute) Then
          Begin
               ctrl.nextAction := 3;
          End
          Else
          Begin
               if Form1.rbTX1.Checked And Not Odd(ctrl.nextMinute) Then ctrl.nextAction := 3;
          End;
     End;
     enredec := True;
     if globalData.txInProgress then enredec := False;
     if (ctrl.thisSecond > 30) and (ctrl.thisSecond < 50) then enredec := False;
     if d65.glinprog then enredec := False;
     if not ctrl.haveOddBuffer and not ctrl.haveEvenBuffer then enredec := False;
     if enredec then Form1.btnReDecode.Enabled := True else Form1.btnReDecode.Enabled := False;
     if (globalData.gmode = 0) and (ctrl.txMode = 0) Then btnEngageTx.enabled := False;
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
     If ctrl.thisAction = 2 then
     Begin
          //
          // In this action I need to monitor the position of the rxBuffer
          // index and trigger a decode cycle when it's at proper length.
          //
          // I have a full RX buffer when d65rxBufferIdx >= 533504
          // For RX I need to scale progress bar for RX display
          if not ctrl.rxInProgress Then
          Begin
               Form1.ProgressBar3.Max := 533504;
               globalData.txInProgress := False;
               ctrl.rxInProgress := True;
               adc.d65rxBufferIdx := 0;

               ctrl.nextAction := 2; // As always, RX assumed to be next.
               inc(rxCount);
               if ctrl.watchMulti and guidedconfig.cfg.multiRestore and (rxCount > 2) Then
               Begin
                    rxCount := 0;
                    ctrl.watchMulti := False;
                    Form1.spinDecoderCF.Value := preRXCF;
                    Form1.spinTXCF.Value := preTXCF;
                    if form1.chkAutoTxDF.Checked Then
                    Begin
                         form1.spinTXCF.Value := form1.spinDecoderCF.Value;
                    End;
                    Form1.chkMultiDecode.Checked := True;
               End;
               if rxCount > 5 then rxCount := 0;
          End
          Else
          Begin
               // Code that only executes while in an active RX cycle.
               Form1.ProgressBar3.Position := adc.d65rxBufferIdx;
               ctrl.rxInProgress := True;
               globalData.txInProgress := False;
               If adc.d65rxBufferIdx >= 533504 Then
               Begin
                    // Get End of Period QRG
                    eopQRG := guidedconfig.cfg.guiQRG;
                    // Switch to decoder action
                    ctrl.thisAction := 4;
                    ctrl.rxInProgress := False;
                    globalData.txInProgress := False;
               End;
          End;
     End;
     //
     // State 3 (TX Sequence)
     //
     If ctrl.thisAction = 3 then
     Begin
          //
          // In this action I need to monitor the position of the txBuffer
          // index and end tx cycle when it's at proper length.
          //
          // I have a full TX cycle when d65txBufferIdx >= 538624
          if not globalData.txInProgress Then
          Begin
               // Force TX Sample generation.
               ctrl.TxDirty := True;
               // generate the txBuffer
               genTX1();
               if not guidedconfig.cfg.txWatchDog Then ctrl.txCount := 0;
               if ctrl.txCount < guidedconfig.cfg.txWatchDogInt Then
               Begin
                    // Flag TX Buffer as valid.
                    lastMsg := curMsg;
                    // Fire up TX
                    if not ctrl.TxDirty and ctrl.TxValid Then
                    Begin
                         // For TX I need to scale progress bar for TX display
                         Form1.ProgressBar3.Max := d65nwave;
                         ctrl.rxInProgress := False;
                         ctrl.nextAction := 2;
                         dac.d65txBufferIdx := 0;
                         dac.d65txBufferPtr := @dac.d65txBuffer[0];
                         rxCount := 0;
                         rig1.PTT(true);
                         globalData.txInProgress := True;
                         foo := '';
                         if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
                         if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
                         Form1.addToDisplayTX(lastMsg);
                         // Add TX to log if enabled.
                         if guidedconfig.cfg.saveCSV Then
                         Begin
                              foo := '"';
                              foo := foo + IntToStr(gst.Year) + '-';
                              if gst.Month < 10 Then foo := foo + '0' + IntToStr(gst.Month) + '-' else foo := foo + IntToStr(gst.Month) + '-';
                              if gst.Day < 10 Then foo := foo + '0' + IntToStr(gst.Day) else foo := foo + IntToStr(gst.Day);
                              foo := foo + '"' + ',';
                              if gst.Hour < 10 Then foo := foo + '"' + '0' + IntToStr(gst.Hour) + ':' else foo := foo + '"' + IntToStr(gst.Hour) + ':';
                              if gst.Minute < 10 Then foo := foo +'0' + IntToStr(gst.Minute) + '"' + ',' else foo := foo + IntToStr(gst.Minute) + '"' +',';
                              foo := foo + '"-","-","-","-","T","' + lastMsg + '"';
                              for i := 0 to 99 do
                              begin
                                   if csvEntries[i] = '' Then
                                   Begin
                                        csvEntries[i] := foo;
                                        break;
                                   end;
                              end;
                              form1.saveCSV();
                         End;
                    End
                    Else
                    Begin
                         form1.chkEnTX.Checked := False;
                         ctrl.thisAction := 2;
                         ctrl.nextAction := 2;
                         globalData.txInProgress := False;
                         ctrl.rxInProgress := False;
                    End;
               End
               Else
               Begin
                    ctrl.txCount := 0;
                    ctrl.lastTX := '';
                    Form1.chkEnTX.Checked := False;
                    diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent 15 times.');
                    diagout.Form3.Show;
                    diagout.Form3.BringToFront;
               End;
          End
          Else
          Begin
               globalData.txInProgress := True;
               ctrl.rxInProgress := False;
               if (dac.d65txBufferIdx >= d65nwave+11025) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Then
               Begin
                    globalData.txInProgress := False;
                    rig1.PTT(false);
                    ctrl.thisAction := 5;
                    ctrl.actionSet := False;
                    curMsg := '';
               End;
               Form1.ProgressBar3.Position := dac.d65txBufferIdx;
          End;
     End;
     //
     // State 4 (Decode Sequence)
     //
     If ctrl.thisAction = 4 then
     Begin
          initDecode();
          // It's critical that state be set to anything but 4 after
          // initDecode is called.
          ctrl.thisAction := 5;
     End;
     //
     // State 5 (Idle Sequence)
     //
     If ctrl.thisAction = 5 then
     Begin
          // Enjoy the time off.
     End;
     //
     // State 6 (Late Start TX Sequence)
     If ctrl.thisAction = 6 then
     Begin
          // Late start TX sequence requested.
          If not globalData.txInProgress Then
          Begin
               // Starting a late sequence TX
               // Generate TX Samples
               ctrl.TxDirty := True;
               genTX2();
               if not guidedconfig.cfg.txWatchDog Then ctrl.txCount := 0;
               if ctrl.txCount < guidedconfig.cfg.txWatchDogInt Then
               Begin
                    // Flag TX Buffer as valid.
                    lastMsg := curMsg;
                    // Fire up TX
                    if not ctrl.TxDirty and ctrl.TxValid Then
                    Begin
                         // For TX I need to scale progress bar for TX display
                         Form1.ProgressBar3.Max := 538624;
                         ctrl.rxInProgress := False;
                         ctrl.nextAction := 2;
                         dac.d65txBufferIdx := 0;

                         dac.d65txBufferPtr := @dac.d65txBuffer[0];

                         rxCount := 0;
                         rig1.PTT(true);
                         globalData.txInProgress := True;
                         foo := '';
                         if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
                         if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
                         form1.addToDisplayTX(lastMsg);
                         // Add TX to log if enabled.
                         if guidedconfig.cfg.saveCSV Then
                         Begin
                              foo := '"';
                              foo := foo + IntToStr(gst.Year) + '-';
                              if gst.Month < 10 Then foo := foo + '0' + IntToStr(gst.Month) + '-' else foo := foo + IntToStr(gst.Month) + '-';
                              if gst.Day < 10 Then foo := foo + '0' + IntToStr(gst.Day) else foo := foo + IntToStr(gst.Day);
                              foo := foo + '"' + ',';
                              if gst.Hour < 10 Then foo := foo + '"' + '0' + IntToStr(gst.Hour) + ':' else foo := foo + '"' + IntToStr(gst.Hour) + ':';
                              if gst.Minute < 10 Then foo := foo +'0' + IntToStr(gst.Minute) + '"' + ',' else foo := foo + IntToStr(gst.Minute) + '"' +',';
                              foo := foo + '"-","-","-","-","T","' + lastMsg + '"';
                              for i := 0 to 99 do
                              begin
                                   if csvEntries[i] = '' Then
                                   Begin
                                        csvEntries[i] := foo;
                                        break;
                                   end;
                              end;
                              form1.saveCSV();
                         End;
                    End
                    Else
                    Begin
                         form1.chkEnTX.Checked := False;
                         ctrl.thisAction := 2;
                         ctrl.nextAction := 2;
                         globalData.txInProgress := False;
                         ctrl.rxInProgress := False;
                    End;
               End
               Else
               Begin
                    ctrl.txCount := 0;
                    ctrl.lastTX := '';
                    Form1.chkEnTX.Checked := False;
                    diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent 15 times.');
                    diagout.Form3.Show;
                    diagout.Form3.BringToFront;
               End;
          End
          Else
          Begin
               // Continuing a late sequence TX
               globalData.txInProgress := True;
               ctrl.rxInProgress := False;
               if (dac.d65txBufferIdx >= d65nwave+11025) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Or (ctrl.thisSecond > 48) Then
               Begin
                    // I have a full TX cycle when d65txBufferIdx >= 538624 or thisSecond > 48
                    rig1.PTT(false);
                    ctrl.actionSet := False;
                    ctrl.thisAction := 5;
                    globalData.txInProgress := False;
                    curMsg := '';
               End;
               Form1.ProgressBar3.Position := dac.d65txBufferIdx;
          End;
     End;
End;

procedure TForm1.processNewMinute(st : TSystemTime);
Var
   i, idx, ifoo : Integer;
Begin
     // Get Start of Period QRG
     ctrl.actionSet := False;
     sopQRG := guidedconfig.cfg.guiQRG;
     ctrl.rxInProgress := False;
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
     if not Form1.chkEnTX.Checked Then ctrl.txNextPeriod := False;
     ctrl.lastAction := ctrl.thisAction;
     ctrl.thisAction := ctrl.nextAction;
     ctrl.nextAction := 2;
     // I default to assuming the next action will be RX this can/will
     // be modified by the user clicking the TX next available period button.
     ctrl.statusChange := False;
     ctrl.lastMinute := ctrl.thisMinute;
     ctrl.thisMinute := st.Minute;
     if st.Minute = 59 then ctrl.nextMinute := 0 else ctrl.nextMinute := st.Minute + 1;
     // I can only see action 2..5 from here.  action=1 does not exist
     // if I have made it here.
     // Handler for action=2
     if ctrl.thisAction = 2 Then
     Begin
          //If cfgvtwo.gld65AudioChange Then audioChange();
     End;
     // Handler for action=3
     if ctrl.thisAction = 3 Then
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
     if rbthread.Suspended then
     begin
          rbthread.Suspended := false;
     end;

     //if rbthread.Suspended then
     //begin
          //halt;
     //end;

     ctrl.doRB := true;
     // Keep popup menu items in sync
     Form1.MenuItem22.Caption := floatToStr(guidedconfig.cfg.qrgList[0]/1000);
     Form1.MenuItem23.Caption := floatToStr(guidedconfig.cfg.qrgList[1]/1000);
     Form1.MenuItem28.Caption := floatToStr(guidedconfig.cfg.qrgList[2]/1000);
     Form1.MenuItem29.Caption := floatToStr(guidedconfig.cfg.qrgList[3]/1000);
     Form1.MenuItem4.Caption := floatToStr(guidedconfig.cfg.qrgList[4]/1000);
     Form1.MenuItem5.Caption := floatToStr(guidedconfig.cfg.qrgList[5]/1000);
     Form1.MenuItem44.Caption := floatToStr(guidedconfig.cfg.qrgList[6]/1000);
     Form1.MenuItem45.Caption := floatToStr(guidedconfig.cfg.qrgList[7]/1000);
     Form1.MenuItem46.Caption := floatToStr(guidedconfig.cfg.qrgList[8]/1000);
     Form1.MenuItem47.Caption := floatToStr(guidedconfig.cfg.qrgList[9]/1000);
     Form1.MenuItem48.Caption := floatToStr(guidedconfig.cfg.qrgList[10]/1000);
     Form1.MenuItem49.Caption := floatToStr(guidedconfig.cfg.qrgList[11]/1000);
     Form1.MenuItem50.Caption := floatToStr(guidedconfig.cfg.qrgList[12]/1000);
     Form1.MenuItem51.Caption := floatToStr(guidedconfig.cfg.qrgList[13]/1000);
     Form1.MenuItem52.Caption := floatToStr(guidedconfig.cfg.qrgList[14]/1000);
     Form1.MenuItem53.Caption := floatToStr(guidedconfig.cfg.qrgList[15]/1000);
     Form1.MenuItem16.Caption := guidedconfig.cfg.macroList[0];
     Form1.MenuItem17.Caption := guidedconfig.cfg.macroList[1];
     Form1.MenuItem18.Caption := guidedconfig.cfg.macroList[2];
     Form1.MenuItem19.Caption := guidedconfig.cfg.macroList[3];
     Form1.MenuItem20.Caption := guidedconfig.cfg.macroList[4];
     Form1.MenuItem21.Caption := guidedconfig.cfg.macroList[5];
     Form1.MenuItem24.Caption := guidedconfig.cfg.macroList[6];
     Form1.MenuItem25.Caption := guidedconfig.cfg.macroList[7];
     Form1.MenuItem26.Caption := guidedconfig.cfg.macroList[8];
     Form1.MenuItem27.Caption := guidedconfig.cfg.macroList[9];
     Form1.MenuItem30.Caption := guidedconfig.cfg.macroList[10];
     Form1.MenuItem31.Caption := guidedconfig.cfg.macroList[11];
     Form1.MenuItem32.Caption := guidedconfig.cfg.macroList[12];
     Form1.MenuItem33.Caption := guidedconfig.cfg.macroList[13];
     Form1.MenuItem34.Caption := guidedconfig.cfg.macroList[14];
     Form1.MenuItem35.Caption := guidedconfig.cfg.macroList[15];
     Form1.MenuItem36.Caption := guidedconfig.cfg.macroList[16];
     Form1.MenuItem37.Caption := guidedconfig.cfg.macroList[17];
     Form1.MenuItem38.Caption := guidedconfig.cfg.macroList[18];
     Form1.MenuItem39.Caption := guidedconfig.cfg.macroList[19];
     Form1.MenuItem40.Caption := guidedconfig.cfg.macroList[20];
     Form1.MenuItem41.Caption := guidedconfig.cfg.macroList[21];
     Form1.MenuItem42.Caption := guidedconfig.cfg.macroList[22];
     Form1.MenuItem43.Caption := guidedconfig.cfg.macroList[23];

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
     Label30.Caption := rb.rbCount;
     //if cfgvtwo.Form6.cbUseRB.Checked Then Form1.Label30.Visible := True else Form1.Label30.Visible := False;

     // Force Rig control read cycle.
     if (st.Second = 0) or (st.Second = 15) or (st.Second = 30) or (st.Second = 45) Then rig1.pollRig();
{ TODO : Fix this to use validator! }
     if not (upcase(rig1.rigcontroller) = 'NONE') then editManQRG.Text := floatToStr(rig1.qrg/1000);
{ TODO : Add code to allow setting QRG via CAT control if it is enabled. }
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

     if (editManQRG.Text = '0') or (editManQRG.Text = '0.0') Then
     Begin
          Form1.Label12.Font.Color := clRed;
          Form1.editManQRG.Font.Color := clRed;
     end
     else
     begin
         Form1.Label12.Font.Color := clBlack;
         Form1.editManQRG.Font.Color := clBlack;
     end;
     //If globalData.rbLoggedIn Then Form1.Label30.Font.Color := clBlack else Form1.Label30.Font.Color := clRed;

     // Update AU Levels display
     displayAudio(audioAve1, audioAve2);
     if Form1.chkMultiDecode.Checked Then ctrl.watchMulti := False;
     // Update rbstats once per minute at second = 30
     If st.Second = 30 Then
     Begin
          // Process the calls heard list
          //for i := 0 to 499 do
          //Begin
               //if Length(rbc.glrbsLastCall[i]) > 0 Then
               //Begin
               //     updateList(rbc.glrbsLastCall[i]);
               //     rbc.glrbsLastCall[i] := '';
               //End;
          //End;
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
     ctrl.lastSecond := st.Second;
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
     updateStatus(ctrl.thisAction);

     // rbc control
     // Check whether to enable/disable chkRBenable
     if not ctrl.primed then rbcCheck();

     // check for dispatching rb thread seconds every two seconds.
     If not guidedconfig.cfg.noSpotting and (guidedconfig.cfg.useRB or guidedconfig.cfg.usePSKR) Then
     Begin
          If (st.Second mod 2 = 0) And not d65.glinProg And not rb.busy Then
          Begin
               ctrl.doRBReport:= True;
          End
          else
          begin
              ctrl.doRBReport := False;
          end;
     End;

     // If rb Enabled (and not Offline Only) then ping RB server every
     // other minute at second = 55 to keep rb logged in.
     If not guidedconfig.cfg.noSpotting and (guidedconfig.cfg.useRB or guidedconfig.cfg.usePSKR) Then
     Begin
          if (st.Second = 55) Then
          Begin
               if odd(st.Minute) Then
               begin
                    ctrl.rbcPing := True;
               end
               else
               begin
                    ctrl.rbcPing := False;
               end;
          end;
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
     //if not ctrl.primed then rbThreadCheck();
end;

procedure TForm1.oncePerTick();
Var
   i    : Integer;
Begin
     myCallCheck();
     // Update spectrum display.
     if not globalData.txInProgress and not ctrl.primed and not globalData.spectrumComputing65 and not d65.glinProg Then
     Begin
          If globalData.specNewSpec65 Then Waterfall.Repaint;
     End;
     // Refresh audio level display
     if not ctrl.primed then updateAudio();
     // Update RX/TX SR Display
     if not ctrl.primed Then updateSR();
     // Determine TX Buffer to use
     if ctrl.useBuffer = 0 Then curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     if ctrl.useBuffer = 1 Then curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
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
                    if not ctrl.reDecode Then addToRBC(i,65);
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
          if ctrl.reDecode then ctrl.reDecode := False;
     End;
End;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     // Setup to evaluate where I am in the temporal loop.
     ctrl.statusChange := False;
     gst := utcTime();
     ctrl.thisSecond := gst.Second;
     // Runs at program start only
     If ctrl.runOnce Then
     Begin
          Form1.Timer1.Enabled := False;
          //ShowMessage('Main loop entered, calling initializer code...');
          // Run initializer code
          initializerCode();
          ctrl.runOnce := False;
          Form1.Timer1.Enabled := True;
          // Go ahead and mark the stream as active.  It won't run a decode, but it will paint the spectrum during init.
          ctrl.rxInProgress := True;
          // End of run once code.
          ctrl.rxInProgress := False;
          globalData.txInProgress := False;
          ctrl.thisAction   := 2;
          ctrl.nextAction   := 2;
     End;
     // This is a TIME CRITICAL loop. I have ~100..210ms here, if I exceed it
     // the timer will fire again and that wouldn't be a good thing at all. I
     // am adding some code to detect such a condition.
     //
     If ctrl.alreadyHere then
     Begin
          Form1.Timer1.Enabled := False;
          ctrl.resyncLoop := True;
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
          ctrl.alreadyHere := True;  // This will be set false at end of procedure.
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
     If gst.Second = 59 Then ctrl.primed := True;
     If ctrl.primed Then
     Begin
          // Kick the timer into 'high resolution' mode.
          Form1.Timer1.Interval := 1;
          If gst.Second = 0 Then
          Begin
               ctrl.resyncLoop := False;
               // I've gotten to second = 0 so I can reset the timer to 'low
               // resolution' mode and indicate top of minute status change.
               ctrl.statusChange := True;
               ctrl.primed := False;
               Form1.Timer1.Interval := 220;
          End
          Else
          Begin
               // Still between second = 59 and second = 0.
               ctrl.statusChange := False;
               ctrl.primed := True;
          End;
     End;
     // At this point I will be in one of two temporal positions.  Either at the
     // start of a new minute or not. statusChange=True=Start of new minute.
     //
     // This code block handles the start of a new minute.
     If ctrl.statusChange Then
     Begin
          processNewMinute(gst);
     end;
     // Handle event processing while NOT start of new minute.
     if not ctrl.statusChange and not ctrl.resyncLoop Then
     begin
          processOngoing();
     end;
     //
     // Code that executes once per second, but not necessary that it be exact 1
     // second intervals. This happens whether it's the top of a new minute or not.
     If (gst.Second <> ctrl.lastSecond) And not ctrl.resyncLoop Then
     begin
          processOncePerSecond(gst);
     end;
     // Code that runs each timer tick.
     if not ctrl.resyncLoop then oncePerTick();
     // Clear the timer overrun check variable.
     ctrl.alreadyHere := False;
end;

initialization
  {$I maincode.lrs}
  // Setup class/object
  ctrl := dispatchobject.TDispatcher.create();  // This object holds all the many variable that controls program flow
  rig  := rigobject.TRadio.create();  // Rig control object (Used even if control is manual)
  rb   := spot.TSpot.create(); // Used even if spotting is disabled
  mval := valobject.TValidator.create(); // This creates a access point to validation routines
  // rbc runs in its own thread and will send reports (if user ebables) at 3
  // and 33 seconds.  The thread will be triggered at each time interval and
  // suspended once rbc.rbcActive is False.
  // Initialize rbRecords array
  //for mnlooper := 0 to 499 do
  //begin
  //     rbc.glrbReports[mnlooper].rbTimeStamp := '';
  //     rbc.glrbReports[mnlooper].rbNumSync   := '';
  //     rbc.glrbReports[mnlooper].rbSigLevel  := '';
  //     rbc.glrbReports[mnlooper].rbDeltaTime := '';
  //     rbc.glrbReports[mnlooper].rbDeltaFreq := '';
  //     rbc.glrbReports[mnlooper].rbSigW      := '';
  //     rbc.glrbReports[mnlooper].rbCharSync  := '';
  //     rbc.glrbReports[mnlooper].rbDecoded   := '';
  //     rbc.glrbReports[mnlooper].rbFrequency := '';
  //     rbc.glrbReports[mnlooper].rbProcessed := True;
  //     rbc.glrbReports[mnlooper].rbCached    := False;
  //end;
  //for mnlooper := 0 to 499 do
  //begin
  //     rbc.glrbsLastCall[mnlooper] := '';
  //end;
  // The decoder runs in its own thread and will process the rxBuffer any time
  // globalData.d65doDecodePass = True.  I also need to define whether I want to do
  // multi-decode, the low..high multi-decode range and the step size or, for
  // single decode, the center frequency and bandwidth.
  //ctrl.d65doDecodePass := False;
  //ctrl.d4doDecodePass := False;
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
  ctrl.runOnce := True;
  spectrum.specFirstRun := True;
  //cfgvtwo.glrbcLogin := False;
  //cfgvtwo.glrbcLogout := False;
  ctrl.rbcPing := False;
  ctrl.dorbReport := False;
  ctrl.alreadyHere := False; // Used to detect an overrun of timer servicing loop.
  sLevel1 := 0;
  sLevel2 := 0;
  sLevelM := 0;
  smeterIdx := 0;
  adc.adcSpecCount := 0;
  globalData.specNewSpec65 := False;
  ctrl.primed       := False; // This is part of the time sync code.
  ctrl.txPeriod     := 0;     // 0 is even and 1 is odd minutes
  ctrl.lastSecond   := 0;     // I use this to update the clock display
  ctrl.rxInProgress := False; // Indicates I'm running a PA prcoess to aquire data
  globalData.txInProgress := False; // Indicates I'm running a PA process to output data
  ctrl.txNextPeriod := False; // Indicates I will begin TX at next inTimeSync True
  ctrl.statusChange := False; // Indicates I will need to change status bar staus block
  ctrl.lastAction   := 1;     // No reason, just setting it to be complete.
  ctrl.thisAction   := 1;     // Startup in init mode
  ctrl.nextAction   := 2;     // Next action will be RX
  ctrl.TxDirty      := True;
  ctrl.TxValid      := False;
  ctrl.itemsIn      := False;
  //
  // Actions 1=Init, 2=RX, 3=TX, 4=Decode, 5=Idle
  //
  exchange     := '';
  //adc.adcT         := 0;

  //adc.adcE         := 0;

  ctrl.firstReport  := True;
  ctrl.useBuffer := 0;
  //adc.adcLDgain := 0;

  //adc.adcRDgain := 0;

  lastMsg := '';
  curMsg := '';
  //cfgvtwo.glautoSR := False;
  //rbc.glrbNoInet := True;
  rbRunOnce := True;
  ctrl.thisTX := '';
  ctrl.lastTX := '';
  ctrl.txCount := 0;
  rxCount := 0;
  ctrl.watchMulti := False;
  ctrl.haveTXSRerr := False;
  ctrl.haveRXSRerr := False;
  audioAve1 := 0;
  audioAve2 := 0;
  ctrl.doCAT := False;
  sopQRG := 0;
  eopQRG := 0;
  //cfgvtwo.glcatBy := 'none';
  ctrl.doRB := False;
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
  ctrl.resyncLoop := False;
  //adc.adcRunning := False;

  d65.glnd65firstrun := True;
  d65.glbinspace := 100;
  d65.glDFTolerance := 100;
  globalData.debugOn := False;
  globalData.gmode := 65;
  ctrl.txmode := globalData.gmode;
  ctrl.HavePrefix := False;
  ctrl.HaveSuffix := False;
  ctrl.myCall := '';
  // Create stream for spectrum image
  globalData.specMs65 := TMemoryStream.Create;
  //adc.adcECount := 0;

  ctrl.reDecode := False;
  // Clear rewind buffers
  For mnlooper := 0 to 661503 do
  begin
       auOddBuffer[mnlooper]  := 0;
       auEvenBuffer[mnlooper] := 0;
  end;
  ctrl.haveOddBuffer := False;
  ctrl.haveEvenBuffer := False;
  ctrl.doCWID := False;
  ctrl.actionSet := False;
  // These will, hopefully, be set true soon.
  ctrl.soundvalid := False;
  ctrl.fftvalid   := False;
end.

