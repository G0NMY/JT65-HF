unit maincode;
//
// Copyright (c) 2008,2009,2010,2011 J C Large - W6CQZ
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
{$PACKRECORDS C}    (* GCC/Visual C/C++ compatible record packing *)
{$MODE DELPHI }
{$H+}

{TODO DT adjustment leads to no WF display}
{TODO Remove internal DB functions replace with SQLite now that I know it will run in thread}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, CTypes, StrUtils, Math, portaudio, ExtCtrls, ComCtrls, Spin,
  DateUtils, encode65, globalData, XMLPropStorage, adc, FileUtil,
  dac, ClipBrd, dlog, rawdec, cfgvtwo, guiConfig, verHolder,
  catControl, Menus, synaser, log, diagout, synautil, waterfall, d65,
  spectrum, {$IFDEF WIN32}windows, {$ENDIF}{$IFDEF LINUX}unix, {$ENDIF}
  {$IFDEF DARWIN}unix, {$ENDIF} about, spot, valobject, lconvencoding;

Const
  JT_DLL = 'jt65.dll';

type
  { TForm1 }

  TForm1 = class(TForm)
    Bevel1 : TBevel;
    Bevel3 : TBevel;
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
    Edit3 : TEdit;
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
    Label18 : TLabel;
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
    Label32 : TLabel ;
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
    Label21: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    MainMenu1: TMainMenu;
    MenuItem14b : TMenuItem ;
    MenuItem17a : TMenuItem ;
    MenuItem18a : TMenuItem ;
    MenuItem15b : TMenuItem ;
    MenuItem2a: TMenuItem;
    MenuItem11a: TMenuItem;
    MenuItem12a: TMenuItem;
    MenuItem1a: TMenuItem;
    MenuItem1b: TMenuItem;
    MenuItem2b: TMenuItem;
    MenuItem19a : TMenuItem ;
    MenuItem16b : TMenuItem ;
    MenuItem3b: TMenuItem;
    MenuItem20a : TMenuItem ;
    MenuItem17b : TMenuItem ;
    MenuItem4b: TMenuItem;
    MenuItem18b : TMenuItem ;
    MenuItem5b: TMenuItem;
    MenuItem19b : TMenuItem ;
    MenuItem6b: TMenuItem;
    MenuItem20b : TMenuItem ;
    MenuItem7b: TMenuItem;
    MenuItem3a: TMenuItem;
    MenuItem8b: TMenuItem;
    MenuItem9b: TMenuItem;
    MenuItem13a: TMenuItem;
    MenuItem14a: TMenuItem;
    MenuItem10b: TMenuItem;
    MenuItem11b: TMenuItem;
    MenuItem12b: TMenuItem;
    MenuItem13b: TMenuItem;
    MenuItem15a: TMenuItem;
    MenuItem16a: TMenuItem;
    MenuItem4a: TMenuItem;
    menuHeard: TMenuItem;
    menuSetup: TMenuItem;
    menuRawDecoder: TMenuItem;
    menuRigControl: TMenuItem;
    menuTXLog: TMenuItem;
    menuAbout: TMenuItem;
    MenuItem5a: TMenuItem;
    MenuItem6a: TMenuItem;
    MenuItem7a: TMenuItem;
    MenuItem8a: TMenuItem;
    MenuItem9a: TMenuItem;
    MenuItem10a: TMenuItem;
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
    spinDecoderBin : TSpinEdit;
    spinDecoderCF: TSpinEdit;
    SpinEdit1: TSpinEdit;
    SpinDT : TSpinEdit ;
    spinGain: TSpinEdit;
    spinTXCF: TSpinEdit;
    Timer1: TTimer;
    cfg: TXMLPropStorage;
    Timer2 : TTimer;
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
    procedure cbEnPSKRChange(Sender: TObject);
    procedure cbSmoothChange(Sender: TObject);
    procedure chkAFCChange(Sender: TObject);
    procedure chkAutoTxDFChange(Sender: TObject);
    procedure chkMultiDecodeChange(Sender: TObject);
    procedure chkNBChange(Sender: TObject);
    procedure cbSpecPalChange(Sender: TObject);
    procedure edFreeTextDblClick(Sender: TObject);
    procedure edFreeTextKeyPress (Sender : TObject ; var Key : char );
    procedure edHisCallDblClick(Sender: TObject);
    procedure edHisCallKeyPress (Sender : TObject ; var Key : char );
    procedure edHisGridDblClick(Sender: TObject);
    procedure editManQRGChange(Sender: TObject);
    procedure editManQRGKeyPress (Sender : TObject ; var Key : char );
    procedure edMsgDblClick(Sender: TObject);
    procedure edSigRepDblClick(Sender: TObject);
    procedure edSigRepKeyPress (Sender : TObject ; var Key : char );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Label17DblClick(Sender: TObject);
    procedure Label22DblClick(Sender: TObject);
    procedure Label31DblClick(Sender: TObject);
    procedure Label32DblClick (Sender : TObject );
    procedure Label39Click(Sender: TObject);
    procedure menuAboutClick(Sender: TObject);
    procedure MenuItemHandler(Sender: TObject);
    procedure menuRawDecoderClick(Sender: TObject);
    procedure menuRigControlClick(Sender: TObject);
    procedure menuSetupClick(Sender: TObject);
    procedure menuTXLogClick(Sender: TObject);
    procedure rbFreeMsgChange(Sender: TObject);
    procedure spinDecoderBWChange(Sender: TObject);
    procedure spinDecoderBinChange(Sender: TObject);
    procedure spinDecoderCFKeyPress (Sender : TObject ; var Key : char );
    procedure SpinEdit1Change(Sender: TObject);
    procedure spinGainChange(Sender: TObject);
    procedure spinTXCFChange(Sender: TObject);
    procedure spinTXCFKeyPress (Sender : TObject ; var Key : char );
    procedure tbBrightChange(Sender: TObject);
    procedure tbContrastChange(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ListBox1DrawItem(Control: TWinControl; Index: Integer; ARect: TRect; State: TOwnerDrawState);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure rbFirstChange(Sender: TObject);
    procedure rbUseMixChange(Sender: TObject);
    procedure spinDecoderCFChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender : TObject);
    procedure addToDisplay(i, m : Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure updateAudio();
    procedure DisableFloatingPointExceptions();
    procedure initializerCode();
    procedure audioChange();
    procedure processOngoing();
    procedure raisePTT();
    procedure lowerPTT();
    procedure altRaisePTT();
    procedure altLowerPTT();
    procedure hrdRaisePTT();
    procedure hrdLowerPTT();
    procedure initDecode();
    procedure updateSR();
    procedure genTX1();
    procedure myCallCheck();
    procedure txControls();
    procedure processNewMinute(st : TSystemTime);
    procedure processOncePerSecond(st : TSystemTime);
    procedure oncePerTick();
    procedure displayAudio(audioAveL : Integer; audioAveR : Integer);
    function  getPTTMethod() : String;
    function  isSigRep(rep : String) : Boolean;
    function  utcTime : TSYSTEMTIME;
    procedure addToRBC(i , m : Integer);
    procedure addToDisplayE(msg : String);
    procedure rbcCheck();
    //procedure updateList(callsign : String);
    procedure WaterfallMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure addToDisplayTX(exchange : String);
    procedure saveCSV();
    Function  ValidateCallsign(csign : String) : Boolean;
    Function  ValidateSlashedCallsign(csign : String) : Boolean;
    function  ValidateGrid(const grid : String) : Boolean;
    function  SetAudio(auin : Integer; auout : Integer) : Boolean;
    function  genNormalMessage(const exchange : String; var Msg : String; var err : String; var doQSO : Boolean; const lsiglevel : String) : Boolean;
    function  genSlashedMessage(const exchange : String; var Msg : String; var err : String; var doQSO : Boolean; const lsiglevel : String) : Boolean;
    procedure SaveConfig;
    procedure updateStatus(i : Integer);

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
     paInParams, paOutParams    : TPaStreamParameters;
     ppaInParams, ppaOutParams  : PPaStreamParameters;
     paResult                   : TPaError;
     alreadyHere                : Boolean;
     mnlooper, ij               : Integer;
     decoderThread              : decodeThread;
     rigThread                  : catThread;
     rbThread                   : rbcThread;
     rbcPing                    : Boolean;
     primed                     : Boolean;
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
     sLevel1, sLevel2           : Integer;
     smeterIdx                  : Integer;
     txCount                    : Integer;
     bStart, bEnd, rxCount      : Integer;
     TxDirty, TxValid           : Boolean;
     answeringCQ                : Boolean;
     msgToSend                  : String;
     dErrLErate, dErrAErate     : Double;
     dErrError, adError         : Double;
     adLErate, adAErate         : Double;
     dErrCount, adCount         : Integer;
     mnnport                    : String;
     mnpttOpened, itemsIn       : Boolean;
     firstReport                : Boolean;
     paInStream, paOutStream    : PPaStream;
     lastMsg, curMsg            : String;
     gst, ost                   : TSYSTEMTIME;
     thisTX, lastTX             : String;
     watchMulti, doCAT          : Boolean;
     haveRXSRerr, haveTXSRerr   : Boolean;
     rxsrs, txsrs, lastSRerr    : String;
     preTXCF, preRXCF           : Integer;
     audioAve1, audioAve2       : Integer;
     sopQRG, eopQRG             : Double;
     tsopQRG, teopQRG, tqrg     : String; // Start/end/current period QRG as string
     mnpttSerial                : TBlockSerial;
     //rbsHeardList               : Array[0..499] Of rbHeard;
     csvEntries                 : Array[0..99] of String;
     qsoSTime, qsoETime         : String;
     qsoSDate                   : String;
     haveOddBuffer              : Boolean;
     d65doDecodePass            : Boolean;
     catInProgress              : Boolean;
     rxInProgress, doCWID       : Boolean;
     useBuffer                  : Integer;
     //d65samfacout               : CTypes.cdouble;
     cfgerror, cfgRecover       : Boolean;
     mnHavePrefix, mnHaveSuffix : Boolean;
     txmode                     : Integer;
     reDecode, haveEvenBuffer   : Boolean;
     actionSet                  : Boolean;
     rb                         : spot.TSpot; // Class variable for new spotting code.
     mval                       : valobject.TValidator; // Class variable for validator object.  Needed for QRG conversions.
     inStandby, enteringQRG     : Boolean;
     eot                        : Integer; // Index to last "real" sample of TX Data

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

function  ptt(nport : Pointer; msg : Pointer; ntx : Pointer; iptt : Pointer) : CTypes.cint; cdecl; external JT_DLL name 'ptt_';

procedure morse(msg, buffer, dits : Pointer); cdecl; external JT_DLL name 'morse_';

procedure genCW(PMsg, Pfreqcw, Piwave, Pnwave : Pointer); cdecl; external JT_DLL name 'gencwid_';

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

function TForm1.utcTime: TSystemTime;
   {$IFDEF LINUX}
   var
      TV: TimeVal;
      TD: TDateTime;
   begin
        result.Day := 0;
        fpgettimeofday(@TV, nil);
        TD := UnixDateDelta + (TV.tv_sec + TV.tv_usec / 1000000) / 86400;
        DateTimeToSystemTime(TD,result);
   {$ENDIF}
   {$IFDEF DARWIN}
   var
      TV: TimeVal;
      TD: TDateTime;
   begin
        result.Day := 0;
        fpgettimeofday(@TV, nil);
        TD := UnixDateDelta + (TV.tv_sec + TV.tv_usec / 1000000) / 86400;
        DateTimeToSystemTime(TD,result);
   {$ENDIF}
   {$IFDEF WIN32}
   Begin
        result.Day := 0;
        GetSystemTime(result);
   {$ENDIF}
end;

function TForm1.getPTTMethod() : String;
Begin
     result := '';
     if cfgvtwo.Form6.cbUseAltPTT.Checked Then result := 'ALT' else result := 'PTT';
     if cfgvtwo.Form6.chkHRDPTT.Checked And cfgvtwo.Form6.chkUseHRD.Checked Then result := 'HRD';
end;

procedure rbcThread.Execute;
Var
   qrgk : Double;
   eQRG : Integer;
   tfoo : String;
begin
     while not Terminated and not Suspended and not rb.busy do
     begin
          // Since this is a thread all the calls to sleep have no impact on
          // the main loop/overall timing.  The sleep calls intent is to spread
          // the load placed upon the RB server a bit.
          rb.myCall := TrimLeft(TrimRight(cfgvtwo.Form6.editPSKRCall.Text));
          rb.myGrid := TrimLeft(TrimRight(cfgvtwo.Form6.edMyGrid.Text));
          eqrg := 0;
          qrgk := 0.0;
          tfoo := '';
          if mval.evalQRG(globalData.strqrg, 'STRICT', qrgk, eQRG, tfoo) Then globalData.iqrg := eqrg else globalData.iqrg := 0;
          if eQRG > 0 then
          Begin
               // Checking for QSY
               if (eQRG <> rb.myQRG) and Form1.cbEnRB.Checked and (not rb.busy) then
               begin
                    // QRG has changed, update RB status.
                    rb.myQRG := eQRG;
                    globalData.rbLoggedIn := rb.logoutRB;
                    sleep(100);
                    globalData.rbLoggedIn := rb.loginRB;
                    sleep(100);
               end;
               rb.myQRG  := eQRG;
               // Set status for RB/PSKR use
               if Form1.cbEnRB.Checked Then rb.useRB  := True else rb.useRB := False;

               // Check to see if I need a login cycle
               if (rb.useRB) and (not rb.rbOn) and (not rb.busy) then
               begin
                    globalData.rbLoggedIn := rb.loginRB;
                    //dlog.fileDebug('RB login request.');
                    sleep(100);
               end;
               // Check to see if I need a logout cycle
               if (not rb.useRB) and (rb.rbOn) and (not rb.busy) then
               begin
                    globalData.rbLoggedIn := rb.logoutRB;
                    //dlog.fileDebug('RB logout request.');
                    sleep(100);
               end;
               if (rbcPing) And (not rb.busy) Then
               Begin
                    globalData.rbLoggedIn := rb.loginRB;
                    rbcPing := False;
                    //dlog.fileDebug('Refreshed RB login.');
                    sleep(100);
               end;

               // Do not use internal database system for now.
               rb.useDBF := False;

               // PSKR work
               if Form1.cbEnPSKR.Checked Then rb.usePSKR := True else rb.usePSKR := False;
               if (rb.usePSKR) and (not rb.pskrOn) and (not rb.busy) then
               begin
                    rb.loginPSKR;
                    //dlog.fileDebug('PSKR login request.');
                    sleep(100);
               end;
               // Check to see if I need a logout cycle
               if (not rb.usePSKR) and (rb.pskrOn) and (not rb.busy) then
               begin
                    rb.logoutPSKR;
                    //dlog.fileDebug('PSKR logout request.');
                    sleep(100);
               end;

               // Give PSKR some processing time
               if (not rb.busy) and (rb.usePSKR) then
               begin
                    rb.pskrTickle;
               end;
               sleep(100);

               // Push spots, this happens even if all the RB/PSKR function is off just
               // to keep the internal data structures up to date.
               if not rb.busy then rb.pushSpots;
               sleep(100);

          end;
          Sleep(100);
     end;
end;

procedure decodeThread.Execute;
Var
   kverr : Integer;
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
             dlog.fileDebug('Exception in decoder thread');
             if reDecode then reDecode := False;
          end;
          kverr := 0;
          while FileExists('KVASD.DAT') do
          begin
               DeleteFile('KVASD.DAT');
               inc(kverr);
               if kverr > 10000 then break;
          end;
          Sleep(100);
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
             fname := TrimFileName(cfgvtwo.Form6.DirectoryEdit1.Directory + PathDelim + 'JT65hf-log.csv');
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
             dlog.fileDebug('Exception in write csv log');
          end;
     end;
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
Var
   ifoo : Integer;
   qrg  : String;
   sqrg : String;
begin
     // Regardless of CAT method the global variable globalData.strqrg will hold a read QRG value (='0' on error)
     // This will be of use with the validator class that attempts to parse string floats/integers to something
     // of reliable use.

     // Changing this to take the QRG value as it's found by the method of choice, then running it through the
     // mval.evalQRG() QRG evaluation/conversion/validate routine to set the float, integer and string variables.
     // The string for QRG returned by CAT control method of choice is in qrg : String

     // DO NOT run a rig control cycle if Timer2 is enabled as this indicates the user is currently
     // entering a manual QRG change (Timer2 handler sets enteringQRG = true to handle this need).
     while not Terminated And not Suspended And not catInProgress do
     begin
          Try
             catInProgress := True;

             If doCAT and not enteringQRG Then
             Begin
                  qrg := '0';
                  if cfgvtwo.glcatBy = 'omni' Then
                  Begin
                       ifoo := 0;
                       if cfgvtwo.Form6.radioOmni1.Checked Then ifoo := 1;
                       if cfgvtwo.Form6.radioOmni2.Checked Then ifoo := 2;
                       qrg := catControl.readOmni(ifoo);
                  End;

                  if cfgvtwo.glcatBy = 'commander' Then qrg := catControl.readDXLabs();

                  if cfgvtwo.glcatBy = 'none' Then qrg := Form1.editManQRG.Text;

                  if cfgvtwo.glcatBy = 'hrd' Then
                  Begin
                       if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion := 4;
                       if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion := 5;
                       catControl.hrdrigCAPS();
                       if globalData.hrdcatControlcurrentRig.hrdAlive Then
                       Begin
                            cfgvtwo.Form6.groupHRD.Caption := 'HRD Connected to ' + globalData.hrdcatControlcurrentRig.radioName;
                            qrg := catControl.readHRDQRG();

                            if globalData.hrdcatControlcurrentRig.hasTX Then
                            begin
                                 cfgvtwo.Form6.chkHRDPTT.Visible := True;
                                 cfgvtwo.Form6.testHRDPTT.Visible := True;
                            end
                            else
                            begin
                                 cfgvtwo.Form6.chkHRDPTT.Checked := False;
                                 cfgvtwo.Form6.chkHRDPTT.Visible := False;
                                 cfgvtwo.Form6.testHRDPTT.Visible := False;
                            end;
                            if globalData.hrdcatControlcurrentRig.hasAutoTune and globalData.hrdcatControlcurrentRig.hasAutoTuneDo Then
                            Begin
                                 cfgvtwo.Form6.cbATQSY1.Visible := True;
                                 cfgvtwo.Form6.cbATQSY2.Visible := True;
                                 cfgvtwo.Form6.cbATQSY3.Visible := True;
                                 cfgvtwo.Form6.cbATQSY4.Visible := True;
                                 cfgvtwo.Form6.cbATQSY5.Visible := True;
                            end
                            else
                            begin
                                 cfgvtwo.Form6.cbATQSY1.Checked := False;
                                 cfgvtwo.Form6.cbATQSY2.Checked := False;
                                 cfgvtwo.Form6.cbATQSY3.Checked := False;
                                 cfgvtwo.Form6.cbATQSY4.Checked := False;
                                 cfgvtwo.Form6.cbATQSY5.Checked := False;
                                 cfgvtwo.Form6.cbATQSY1.Visible := False;
                                 cfgvtwo.Form6.cbATQSY2.Visible := False;
                                 cfgvtwo.Form6.cbATQSY3.Visible := False;
                                 cfgvtwo.Form6.cbATQSY4.Visible := False;
                                 cfgvtwo.Form6.cbATQSY5.Visible := False;
                            end;
                       end
                       else
                       begin
                            qrg := '0';
                       end;
                  End;

                  // At this point String(qrg) contains "something" for evalQRG to digest.
                  if globalData.decimalOverride1 then mval.forceDecimal1 := true else mval.forceDecimal1 := False;
                  if globalData.decimalOverride2 then mval.forceDecimal2 := true else mval.forceDecimal2 := False;

                  If not mval.evalQRG(qrg, 'LAX', globalData.gqrg, globalData.iqrg, globalData.strqrg) Then
                  Begin
                       // Failed to convert
                       globalData.gqrg := 0.0;
                       globalData.iqrg := 0;
                       globalData.strqrg := '0';
                  End;
                  sqrg := globalData.strqrg;
                  // OK.. if either override is set above it means there is a 'disagreement' with the OS over which
                  // characters indicate decimal point and thousands mark.  To keep things in sync I have to get the
                  // returned display string into correct format before entering it into the QRG control box or it
                  // may loop back to QRG = 0.
                  if globalData.decimalOverride1 or globalData.decimalOverride2 Then
                  Begin
                       // In decimaloverride1 the decimal point is , and thousands is .
                       // In decimaloverride2 the decimal point is . and thousands is ,
                       // Now set the returned string from evalQRG such that it matches
                       // the forced convention for decimal point.
                       if globalData.decimalOverride1 Then
                       Begin
                            // Replace any . in sqrg with ,
                            sqrg := StringReplace(sqrg,'.',',',[rfReplaceAll]);
                       end;
                       if globalData.decimalOverride2 Then
                       Begin
                            // Replace any , in sqrg with .
                            sqrg := StringReplace(sqrg,',','.',[rfReplaceAll]);
                       end;
                  end;
                  globalData.strqrg := sqrg;
                  cfgvtwo.Form6.rigQRG.Text := sqrg;
                  Form1.editManQRG.Text := sqrg;
                  doCAT := False;
             end;
             catInProgress := False;
          except
             dlog.fileDebug('Exception in rig thread');
             globalData.gqrg := 0.0;
             globalData.iqrg := 0;
             globalData.strqrg := '0';
          end;
          sleep(100);
     end;
end;

{TODO [1.1.0] Re-hook this eventually}
//procedure TForm1.updateList(callsign : String);
//Var
//   i     : integer;
//   found : Boolean;
//Begin
//     found := False;
//     i := 0;
//     while i < 500 do
//     begin
//          if rbsHeardList[i].callsign = callsign Then
//          Begin
//               inc(rbsHeardList[i].count);
//               found := True;
//               i := 501;
//          End;
//          inc(i);
//     end;
//     if not found Then
//     Begin
//          i := 0;
//          while i < 500 do
//          begin
//               if rbsHeardList[i].callsign = '' Then
//               Begin
//                    rbsHeardList[i].callsign := callsign;
//                    rbsHeardList[i].count := 1;
//                    i := 500;
//               End;
//               inc(i);
//          end;
//     End;
//End;

procedure TForm1.altRaisePTT();
var
   np : Integer;
Begin
     mnpttOpened := False;
     if not mnpttOpened Then
     Begin
          mnnport := '';
          mnnport := cfgvtwo.Form6.editUserDefinedPort1.Text;
          if mnnport = 'None' Then mnnport := '';
          if mnnport = 'NONE' Then mnnport := '';
          if Length(mnnport) > 3 Then
          Begin
               try
                  mnpttSerial := TBlockSerial.Create;
                  mnpttSerial.RaiseExcept := True;
                  mnpttSerial.Connect(mnnport);
                  mnpttSerial.Config(9600,8,'N',0,false,true);
                  mnpttOpened := True;
               except
                  dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
               end;
          End
          Else
          Begin
               np := 0;
               if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
               Begin
                    Try
                       mnpttSerial := TBlockSerial.Create;
                       mnpttSerial.RaiseExcept := True;
                       mnpttSerial.Connect('COM' + IntToStr(np));
                       mnpttSerial.Config(9600,8,'N',0,false,true);
                       mnpttOpened := True;
                    Except
                       dlog.fileDebug('PTT Port [COM' + IntToStr(np) + '] failed to key up.');
                    End;
               End
               Else
               Begin
                    mnpttOpened := False;
               End;
          End;
     End;
End;

procedure TForm1.altLowerPTT();
Begin
     if mnpttOpened Then
     Begin
          mnpttOpened := False;
          mnpttSerial.Free;
     End
     Else
     Begin
          mnpttOpened := False;
     End;
End;

procedure TForm1.raisePTT();
var
   np, ntx, iptt, ioresult : CTypes.cint;
   msg                     : CTypes.cschar;
   tmp                     : String;
Begin
     ioresult := 0;
     msg := 0;
     np := 0;
     ntx := 1;
     iptt := 0;
     tmp := '';
     mnpttOpened := False;
     if not mnpttOpened Then
     Begin
          mnnport := '';

          mnnport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);

          if mnnport = 'None' Then mnnport := '';
          if mnnport = 'NONE' Then mnnport := '';

          if Length(mnnport) > 3 Then
          Begin
               if Length(mnnport) = 4 Then
               Begin
                    // Length = 4 = COM#
                    tmp := '';
                    tmp := mnnport[4];
               End;
               if Length(mnnport) = 5 Then
               Begin
                    // Length = 5 = COM##
                    tmp := '';
                    tmp := mnnport[4..5];
               End;
               If Length(mnnport) = 6 Then
               Begin
                    // Length = 6 = COM###
                    tmp := '';
                    tmp := mnnport[4..6];
               End;
               np := StrToInt(tmp);
               if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
               if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
               if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
          End
          Else
          Begin
               np := 0;
               if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
               Begin
                    if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
                    if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
                    if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
               End
               Else
               Begin
                    mnpttOpened := False;
               End;
          End;
     End;
End;

procedure TForm1.lowerPTT();
var
   np, ntx, iptt, ioresult : CTypes.cint;
   msg                     : CTypes.cschar;
   tmp                     : String;
Begin
     ioresult := 0;
     msg := 0;
     np := 0;
     ntx := 0;
     iptt := 0;
     tmp := '';
     mnpttOpened := False;
     mnnport := '';

     mnnport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);

     if mnnport = 'None' Then mnnport := '';
     if mnnport = 'NONE' Then mnnport := '';

     if Length(mnnport) > 3 Then
     Begin
          if Length(mnnport) = 4 Then
          Begin
               // Length = 4 = COM#
               tmp := '';
               tmp := mnnport[4];
          End;
          if Length(mnnport) = 5 Then
          Begin
               // Length = 5 = COM##
               tmp := '';
               tmp := mnnport[4..5];
          End;
          If Length(mnnport) = 6 Then
          Begin
               // Length = 6 = COM###
               tmp := '';
               tmp := mnnport[4..6];
          End;
          np := StrToInt(tmp);
          if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
          if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key down.');
          if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
     End
     Else
     Begin
          np := 0;
          if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
          Begin
               if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
               if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key down.');
               if ioresult = 0 Then mnpttOpened := False;
          End;
     End;
End;

procedure TForm1.hrdRaisePTT();
begin
     if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion := 4;
     if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion := 5;
     mnpttOpened := False;
     if globalData.hrdcatControlcurrentRig.hrdAlive Then
     Begin
          mnpttOpened := catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set button-select ' + globalData.hrdcatControlcurrentRig.txControl + ' 1');
     end;
end;

procedure TForm1.hrdLowerPTT();
begin
     if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion := 4;
     if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion := 5;
     if globalData.hrdcatControlcurrentRig.hrdAlive Then
     Begin
          if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set button-select ' + globalData.hrdcatControlcurrentRig.txControl + ' 0') then mnpttopened := False;
     end;
end;

procedure TForm1.initDecode();
Var
   sr               : CTypes.cdouble;
   i                : Integer;
Begin
     if not d65.glinprog Then
     Begin
          if cfgvtwo.Form6.chkNoOptFFT.Checked Then
          Begin
               d65.glfftFWisdom := 0;
               d65.glfftSWisdom := 0;
          End;
          bStart := 0;
          bEnd := 533504;
          for i := bStart to bEnd do
          Begin
               if paInParams.channelCount = 2 then d65.glinBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
               if Odd(thisMinute) Then
               Begin
                    if paInParams.channelCount = 2 then auOddBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
                    haveOddBuffer := True;
                    haveEvenBuffer := False;
               End
               else
               Begin
                    if paInParams.channelCount = 2 then auEvenBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
                    haveEvenBuffer := True;
                    haveOddBuffer := False;
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
          if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
          //d65samfacout := 1.0;
          d65.glMouseDF := Form1.spinDecoderCF.Value;
          if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
          if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
          // Single bin spacing
          if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
          if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
          if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
          if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;
          // Multi Bin spacing
          if spinDecoderBin.Value = 1 Then d65.glbinspace := 20;
          if spinDecoderBin.Value = 2 Then d65.glbinspace := 50;
          if spinDecoderBin.Value = 3 Then d65.glbinspace := 100;
          if spinDecoderBin.Value = 4 Then d65.glbinspace := 200;

          if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
          if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;

          If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
          d65.glNshift := 0;
          if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
          d65.glNzap := 0;
          d65.gldecoderPass := 0;
          if form1.chkMultiDecode.Checked Then d65.glsteps := 1 else d65.glsteps := 0;
          d65doDecodePass := True;
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
     {Excluding single/multi bin spacing from defaults restore}
     //Form1.spinDecoderBW.Value := 3;
     //Form1.spinDecoderBin.Value := 3;
     //edit2.Text := '100';
     //d65.glDFTolerance := 100;
     //edit3.Text := '100';
     //d65.glbinspace := 100;
     Form1.rbGenMsg.Checked := True;
     Form1.chkAutoTxDF.Checked := True;
     Form1.chkEnTX.Checked := False;
     If cfgvtwo.Form6.cbRestoreMulti.Checked Then Form1.chkMultiDecode.Checked := True;
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
       if getPTTMethod() = 'HRD' Then hrdLowerPTT();
       if getPTTMethod() = 'ALT' Then altLowerPTT();
       if getPTTMethod() = 'PTT' Then lowerPTT();
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
  if cfgvtwo.Form6.cbMultiAutoEnableHTX.Checked then chkMultiDecode.Checked := true;
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
end;

procedure TForm1.buttonAckReport1Click(Sender: TObject);
begin
     // Test for both callsigns having /
     If Ansicontainstext(globalData.fullcall,'/') And AnsiContainsText(Form1.edHisCall.Text,'/') Then
     Begin
          Form1.edMsg.Text := Form1.edHisCall.Text + '';
     end
     else
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
end;

procedure TForm1.buttonAckReport2Click(Sender: TObject);
begin
     // Test for both callsigns having /
     If Ansicontainstext(globalData.fullcall,'/') And AnsiContainsText(Form1.edHisCall.Text,'/') Then
     Begin
          Form1.edMsg.Text := '';
     end
     else
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
end;

procedure TForm1.buttonCQClick(Sender: TObject);
begin
     if (globalData.fullcall <> '') And (cfgvtwo.Form6.edMyGrid.Text <> '') Then
     Begin
          if AnsiContainsStr(globalData.fullcall,'/') Then
          Begin                      
               Form1.edMsg.Text := 'CQ ' + globalData.fullcall;
          End
          Else
          Begin
               Form1.edMsg.Text := 'CQ ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
          End;
          doCWID := False;
          Form1.rbGenMsg.Checked := True;
          Form1.rbGenMsg.Font.Color := clRed;
          Form1.rbFreeMsg.Font.Color  := clBlack;
          useBuffer := 0;
     End;
end;

procedure TForm1.buttonAnswerCQClick(Sender: TObject);
begin
     // Test for both callsigns having /
     If Ansicontainstext(globalData.fullcall,'/') And AnsiContainsText(Form1.edHisCall.Text,'/') Then
     Begin
          Form1.edMsg.Text := '';
     end
     else
     begin
          if (globalData.fullcall <> '') And (cfgvtwo.Form6.edMyGrid.Text <> '') And (Form1.edHisCall.Text <> '') Then
          Begin
               if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
               Begin
                    Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall;
               End
               Else
               Begin
                    Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
               End;
               Form1.rbGenMsg.Checked := True;
               Form1.rbGenMsg.Font.Color := clRed;
               Form1.rbFreeMsg.Font.Color  := clBlack;
               useBuffer := 0;
               doCWID := False;
          End;
     end;
end;

procedure TForm1.buttonEndQSO1Click(Sender: TObject);
begin
     // Test for both callsigns having /
     If Ansicontainstext(globalData.fullcall,'/') And AnsiContainsText(Form1.edHisCall.Text,'/') Then
     Begin
          Form1.edMsg.Text := '';
     end
     else
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
               doCWID := True;
          End;
     end;
end;

procedure TForm1.buttonSendReportClick(Sender: TObject);
begin
     // Test for both callsigns having /
     If Ansicontainstext(globalData.fullcall,'/') And AnsiContainsText(Form1.edHisCall.Text,'/') Then
     begin
          Form1.edMsg.Text := '';
     end
     else
     begin
          if (globalData.fullcall <> '') And (Form1.edHisCall.Text <> '') Then
          Begin
               if AnsiContainsStr(globalData.fullcall,'/') Or AnsiContainsStr(Form1.edHiscall.Text,'/') Then
               Begin
                    Form1.edMsg.Text := Form1.edHisCall.Text + ' ' + Form1.edSigRep.Text;
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
end;

procedure TForm1.cbEnPSKRChange(Sender: TObject);
begin
     if cbEnPSKR.Checked then rb.usePSKR := true else rb.usePSKR:=false;
     if cbEnRB.Checked then rb.useRB := true else rb.useRB := false;
end;

procedure TForm1.menuRigControlClick(Sender: TObject);
begin
     cfgvtwo.Form6.PageControl1.ActivePage := cfgvtwo.Form6.TabSheet2;
     cfgvtwo.Form6.Show;
     cfgvtwo.Form6.BringToFront;
end;

procedure TForm1.menuSetupClick(Sender: TObject);
begin
     cfgvtwo.Form6.PageControl1.ActivePage := cfgvtwo.Form6.TabSheet1;
     cfgvtwo.Form6.Show;
     cfgvtwo.Form6.BringToFront;
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

     if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
     if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
     if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
     if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;
end;

procedure TForm1.spinDecoderBinChange(Sender: TObject);
begin
     if spinDecoderBin.Value = 1 Then edit3.Text := '20';
     if spinDecoderBin.Value = 2 Then edit3.Text := '50';
     if spinDecoderBin.Value = 3 Then edit3.Text := '100';
     if spinDecoderBin.Value = 4 Then edit3.Text := '200';

     if spinDecoderBin.Value = 1 Then d65.glbinspace := 20;
     if spinDecoderBin.Value = 2 Then d65.glbinspace := 50;
     if spinDecoderBin.Value = 3 Then d65.glbinspace := 100;
     if spinDecoderBin.Value = 4 Then d65.glbinspace := 200;
end;

procedure TForm1.spinDecoderCFKeyPress (Sender : TObject ; var Key : char );
Var
   i : Integer;
begin
     // Filtering input to signal report text box such that it only allows numerics and -
     i := ord(key);
     if not (i=8) then
     begin
        Key := upcase(key);
        if not mval.asciiValidate(Key,'sig') then Key := #0;
     end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
     if spinEdit1.Value > 5 then spinEdit1.Value := 5;
     if spinEdit1.Value < -1 then spinEdit1.Value := -1;
     spectrum.specSpeed2 := Form1.SpinEdit1.Value;
     // Handle spectrum being off (speed = -1)
     if spectrum.specSpeed2 < 0 then
     begin
          waterfall.Visible := False;
          Label5.Visible := True;
     end
     else
     begin
          waterfall.Visible := true;
          Label5.Visible := false;
     end;
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
          globalData.mtext := '/Multi%20On%202K%20BW';
     End
     Else
     Begin
          Form1.chkMultiDecode.Font.Color := clRed;
          globalData.mtext := '';
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

procedure TForm1.edFreeTextKeyPress(Sender : TObject; var Key : char);
var
   i : Integer;
begin
     // Filtering input to free text box such that it only allows jt65 characters
     i := ord(key);
     if not (i=8) then
     begin
        Key := upcase(key);
        if not mval.asciiValidate(Key,'free') then Key := #0;
     end;
end;

procedure TForm1.edHisCallDblClick(Sender: TObject);
begin
  // Clear it
  Form1.edHisCall.Clear;
end;

procedure TForm1 .edHisCallKeyPress (Sender : TObject ; var Key : char );
var
   i : Integer;
begin
  // Filtering input to TX to text box such that it only allows jt65 callsign characters
  i := ord(key);
  if not (i=8) then
  begin
     Key := upcase(key);
     if not mval.asciiValidate(Key,'xcsign') then Key := #0;
  end;
end;

procedure TForm1.edHisGridDblClick(Sender: TObject);
begin
  // Clear it
  Form1.edHisGrid.Clear;
end;

procedure TForm1.editManQRGChange(Sender: TObject);
begin
     enteringQRG := True;
     // Update QRG variables
     // Now... this gets tricky as I need to allow entry to complete before trying
     // to validate the QRG.  In the past I've attempted to do this on the fly, but
     // now I'm using a timer that's triggered upon first change to this field.
     // Each time the input box changes timer2 will be reset to 0 and enabled to
     // fire at 3.5 second intervals.  If the timer makes it to 3.5 seconds then, and
     // only then, the field will be evaluated, validated and, if valid, set the
     // QRG variables that feed 'up the chain'.
     if not timer2.Enabled then
     begin
          timer2.Enabled := true;
     end
     else
     begin
          // The disable/enable cycle resets the timer as each character is entered
          // This allows the input to be completed before the evaluation fires.  The
          // current delay until evaluation from entry of last character is 3.5 seconds
          timer2.Enabled := false;
          timer2.Enabled := true;
     end;
end;

procedure TForm1.editManQRGKeyPress (Sender : TObject ; var Key : char );
Var
   i : Integer;
begin
     // Filtering input to QRG text box such that it only allows numerics
     i := ord(key);
     if not (i=8) then
     begin
        Key := upcase(key);
        if not mval.asciiValidate(Key,'numeric') then Key := #0;
     end;

end;

procedure TForm1.Timer2Timer(Sender : TObject);
begin
     Timer2.Enabled := false;
     // OK, input was made to the QRG Entry field and seems to be completed so
     // lets try to validate the field.  Do this by firing a rig control cycle.
     enteringQRG := False;
     catInProgress := False;
     doCat := True;
end;


procedure TForm1.edMsgDblClick(Sender: TObject);
begin
  Form1.edMsg.Clear;
end;

procedure TForm1.edSigRepDblClick(Sender: TObject);
begin
     Form1.edSigRep.Text := '';
end;

procedure TForm1 .edSigRepKeyPress (Sender : TObject ; var Key : char );
Var
   i : Integer;
begin
     // Filtering input to signal report text box such that it only allows numerics
     i := ord(key);
     if not (i=8) then
     begin
        Key := upcase(key);
        if not mval.asciiValidate(Key,'sig') then Key := #0;
     end;
end;

procedure TForm1.SaveConfig;
Var
   foo : String;
Begin
     // Update configuration settings.
     cfg.StoredValue['call']         := UpperCase(cfgvtwo.glmycall);
     cfg.StoredValue['pfx']          := IntToStr(cfgvtwo.Form6.comboPrefix.ItemIndex);
     cfg.StoredValue['sfx']          := IntToStr(cfgvtwo.Form6.comboSuffix.ItemIndex);
     cfg.StoredValue['grid']         := cfgvtwo.Form6.edMyGrid.Text;
     cfg.StoredValue['txCF'] := IntToStr(Form1.spinTXCF.Value);
     cfg.StoredValue['rxCF'] := IntToStr(Form1.spinDecoderCF.Value);
     cfg.StoredValue['soundin']      := IntToStr(cfgvtwo.Form6.cbAudioIn.ItemIndex);
     cfg.StoredValue['soundout']     := IntToStr(cfgvtwo.Form6.cbAudioOut.ItemIndex);
     foo := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     foo := foo[4..Length(foo)];
     cfg.StoredValue['LastInput'] := foo;
     foo := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     foo := foo[4..Length(foo)];
     cfg.StoredValue['LastOutput'] := foo;
     cfg.StoredValue['ldgain']       := IntToStr(Form1.TrackBar1.Position);
     cfg.StoredValue['rdgain']       := IntToStr(Form1.TrackBar2.Position);
     cfg.StoredValue['samfacin']     := cfgvtwo.Form6.edRXSRCor.Text;
     cfg.StoredValue['samfacout']    := cfgvtwo.Form6.edTXSRCor.Text;
     if Form1.rbUseLeft.Checked Then cfg.StoredValue['audiochan'] := 'L' Else cfg.StoredValue['audiochan'] := 'R';
     If cfgvtwo.Form6.chkEnableAutoSR.Checked Then cfg.StoredValue['autoSR'] := '1' else cfg.StoredValue['autoSR'] := '0';
     cfg.StoredValue['pttPort']      := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);
     if Form1.chkAFC.Checked Then cfg.StoredValue['afc'] := '1' Else cfg.StoredValue['afc'] := '0';
     if Form1.chkNB.Checked Then cfg.StoredValue['noiseblank'] := '1' Else cfg.StoredValue['noiseblank'] := '0';
     cfg.StoredValue['brightness']   := IntToStr(Form1.tbBright.Position);
     cfg.StoredValue['contrast']     := IntToStr(Form1.tbContrast.Position);
     cfg.StoredValue['colormap']     := IntToStr(Form1.cbSpecPal.ItemIndex);
     cfg.StoredValue['specspeed']    := IntToStr(Form1.SpinEdit1.Value);
     cfg.StoredValue['version'] := verHolder.verReturn();
     if cfgvtwo.Form6.cbTXWatchDog.Checked Then cfg.StoredValue['txWatchDog'] := '1' else cfg.StoredValue['txWatchDog'] := '0';
     if cfgvtwo.Form6.cbDisableMultiQSO.Checked Then cfg.StoredValue['multiQSOToggle'] := '1' else cfg.StoredValue['multiQSOToggle'] := '0';
     if cfgvtwo.Form6.cbMultiAutoEnable.Checked Then cfg.StoredValue['multiQSOWatchDog'] := '1' else cfg.StoredValue['multiQSOWatchDog'] := '0';
     if cfgvtwo.Form6.cbSaveCSV.Checked Then cfg.StoredValue['saveCSV'] := '1' else cfg.StoredValue['saveCSV'] := '0';
     cfg.StoredValue['csvPath'] := cfgvtwo.Form6.DirectoryEdit1.Directory;
     cfg.StoredValue['adiPath'] := log.Form2.DirectoryEdit1.Directory;
     cfg.StoredValue['catBy'] := cfgvtwo.glcatBy;
     if cbEnPSKR.Checked Then cfg.StoredValue['usePSKR'] := 'yes' else cfg.StoredValue['usePSKR'] := 'no';
     if cbEnRB.Checked Then cfg.StoredValue['useRB'] := 'yes' else cfg.StoredValue['useRB'] := 'no';
     cfg.StoredValue['pskrAntenna'] := cfgvtwo.Form6.editPSKRAntenna.Text;
     cfg.StoredValue['pskrCall'] := cfgvtwo.Form6.editPSKRCall.Text;
     cfg.StoredValue['userQRG1'] := cfgvtwo.Form6.edUserQRG1.Text;
     cfg.StoredValue['userQRG2'] := cfgvtwo.Form6.edUserQRG2.Text;
     cfg.StoredValue['userQRG3'] := cfgvtwo.Form6.edUserQRG3.Text;
     cfg.StoredValue['userQRG4'] := cfgvtwo.Form6.edUserQRG4.Text;
     cfg.StoredValue['userQRG5'] := cfgvtwo.Form6.edUserQRG5.Text;
     cfg.StoredValue['userQRG6'] := cfgvtwo.Form6.edUserQRG6.Text;
     cfg.StoredValue['userQRG7'] := cfgvtwo.Form6.edUserQRG7.Text;
     cfg.StoredValue['userQRG8'] := cfgvtwo.Form6.edUserQRG8.Text;
     cfg.StoredValue['userQRG9'] := cfgvtwo.Form6.edUserQRG9.Text;
     cfg.StoredValue['userQRG10'] := cfgvtwo.Form6.edUserQRG10.Text;
     cfg.StoredValue['userQRG11'] := cfgvtwo.Form6.edUserQRG11.Text;
     cfg.StoredValue['userQRG12'] := cfgvtwo.Form6.edUserQRG12.Text;
     cfg.StoredValue['userQRG13'] := cfgvtwo.Form6.edUserQRG13.Text;
     cfg.StoredValue['usrMsg1'] := cfgvtwo.Form6.edUserMsg4.Text;
     cfg.StoredValue['usrMsg2'] := cfgvtwo.Form6.edUserMsg5.Text;
     cfg.StoredValue['usrMsg3'] := cfgvtwo.Form6.edUserMsg6.Text;
     cfg.StoredValue['usrMsg4'] := cfgvtwo.Form6.edUserMsg7.Text;
     cfg.StoredValue['usrMsg5'] := cfgvtwo.Form6.edUserMsg8.Text;
     cfg.StoredValue['usrMsg6'] := cfgvtwo.Form6.edUserMsg9.Text;
     cfg.StoredValue['usrMsg7'] := cfgvtwo.Form6.edUserMsg10.Text;
     cfg.StoredValue['usrMsg8'] := cfgvtwo.Form6.edUserMsg11.Text;
     cfg.StoredValue['usrMsg9'] := cfgvtwo.Form6.edUserMsg12.Text;
     cfg.StoredValue['usrMsg10'] := cfgvtwo.Form6.edUserMsg13.Text;
     cfg.StoredValue['usrMsg11'] := cfgvtwo.Form6.edUserMsg14.Text;
     cfg.StoredValue['usrMsg12'] := cfgvtwo.Form6.edUserMsg15.Text;
     cfg.StoredValue['usrMsg13'] := cfgvtwo.Form6.edUserMsg16.Text;
     cfg.StoredValue['usrMsg14'] := cfgvtwo.Form6.edUserMsg17.Text;
     cfg.StoredValue['usrMsg15'] := cfgvtwo.Form6.edUserMsg18.Text;
     cfg.StoredValue['usrMsg16'] := cfgvtwo.Form6.edUserMsg19.Text;
     cfg.StoredValue['usrMsg17'] := cfgvtwo.Form6.edUserMsg20.Text;
     if Form1.cbSmooth.Checked Then cfg.StoredValue['smooth'] := 'on' else cfg.StoredValue['smooth'] := 'off';
     if cfgvtwo.Form6.cbRestoreMulti.Checked Then cfg.StoredValue['restoreMulti'] := 'on' else cfg.StoredValue['restoreMulti'] := 'off';
     if cfgvtwo.Form6.chkNoOptFFT.Checked Then cfg.StoredValue['optFFT'] := 'off' else cfg.StoredValue['optFFT'] := 'on';
     if cfgvtwo.Form6.cbUseAltPTT.Checked Then cfg.StoredValue['useAltPTT'] := 'yes' else cfg.StoredValue['useAltPTT'] := 'no';
     if cfgvtwo.Form6.chkHRDPTT.Checked Then cfg.StoredValue['useHRDPTT'] := 'yes' else cfg.StoredValue['useHRDPTT'] := 'no';
     cfg.StoredValue['specVGain'] := IntToStr(spinGain.Value);
     cfg.StoredValue['binspace'] := IntToStr(spinDecoderBin.Value);
     cfg.StoredValue['singleRange'] := IntToStr(spinDecoderBW.Value);
     cfg.StoredValue['cqColor'] := IntToStr(cfgvtwo.Form6.ComboBox1.ItemIndex);
     cfg.StoredValue['callColor'] := IntToStr(cfgvtwo.Form6.ComboBox2.ItemIndex);
     cfg.StoredValue['qsoColor'] := IntToStr(cfgvtwo.Form6.ComboBox3.ItemIndex);
     cfg.StoredValue['si570ptt'] := 'n';
     if cfgvtwo.Form6.cbCWID.Checked Then cfg.StoredValue['useCWID'] := 'y' else cfg.StoredValue['useCWID'] := 'n';
     if cfgvtwo.Form6.chkTxDFVFO.Checked Then cfg.StoredValue['useCATTxDF'] := 'yes' else cfg.StoredValue['useCATTxDF'] := 'no';
     if cfgvtwo.Form6.cbEnableQSY1.Checked Then cfg.StoredValue['enAutoQSY1'] := 'yes' else cfg.StoredValue['enAutoQSY1'] := 'no';
     if cfgvtwo.Form6.cbEnableQSY2.Checked Then cfg.StoredValue['enAutoQSY2'] := 'yes' else cfg.StoredValue['enAutoQSY2'] := 'no';
     if cfgvtwo.Form6.cbEnableQSY3.Checked Then cfg.StoredValue['enAutoQSY3'] := 'yes' else cfg.StoredValue['enAutoQSY3'] := 'no';
     if cfgvtwo.Form6.cbEnableQSY4.Checked Then cfg.StoredValue['enAutoQSY4'] := 'yes' else cfg.StoredValue['enAutoQSY4'] := 'no';
     if cfgvtwo.Form6.cbEnableQSY5.Checked Then cfg.StoredValue['enAutoQSY5'] := 'yes' else cfg.StoredValue['enAutoQSY5'] := 'no';
     if cfgvtwo.Form6.cbATQSY1.Checked Then cfg.StoredValue['autoQSYAT1'] := 'yes' else cfg.StoredValue['autoQSYAT1'] := 'no';
     if cfgvtwo.Form6.cbATQSY2.Checked Then cfg.StoredValue['autoQSYAT2'] := 'yes' else cfg.StoredValue['autoQSYAT2'] := 'no';
     if cfgvtwo.Form6.cbATQSY3.Checked Then cfg.StoredValue['autoQSYAT3'] := 'yes' else cfg.StoredValue['autoQSYAT3'] := 'no';
     if cfgvtwo.Form6.cbATQSY4.Checked Then cfg.StoredValue['autoQSYAT4'] := 'yes' else cfg.StoredValue['autoQSYAT4'] := 'no';
     if cfgvtwo.Form6.cbATQSY5.Checked Then cfg.StoredValue['autoQSYAT5'] := 'yes' else cfg.StoredValue['autoQSYAT5'] := 'no';
     cfg.StoredValue['autoQSYQRG1'] := cfgvtwo.Form6.edQRGQSY1.Text;
     cfg.StoredValue['autoQSYQRG2'] := cfgvtwo.Form6.edQRGQSY2.Text;
     cfg.StoredValue['autoQSYQRG3'] := cfgvtwo.Form6.edQRGQSY3.Text;
     cfg.StoredValue['autoQSYQRG4'] := cfgvtwo.Form6.edQRGQSY4.Text;
     cfg.StoredValue['autoQSYQRG5'] := cfgvtwo.Form6.edQRGQSY5.Text;
     cfg.StoredValue['hrdAddress'] := cfgvtwo.Form6.hrdAddress.Text;
     cfg.StoredValue['hrdPort'] := cfgvtwo.Form6.hrdPort.Text;
     if length(log.Form2.edLogComment.Text)>0 Then cfg.StoredValue['LogComment'] := log.Form2.edLogComment.Text else cfg.StoredValue['LogComment'] := '';
     if cfgvtwo.Form6.qsyHour1.Value < 10 Then
     Begin
          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     End
     Else
     Begin
          foo := IntToStr(cfgvtwo.Form6.qsyHour1.Value);
     end;
     if cfgvtwo.Form6.qsyMinute1.Value < 10 Then
     Begin
          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     End
     Else
     Begin
          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute1.Value);
     end;
     cfg.StoredValue['autoQSYUTC1'] := foo;

     if cfgvtwo.Form6.qsyHour2.Value < 10 Then
     Begin
          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     End
     Else
     Begin
          foo := IntToStr(cfgvtwo.Form6.qsyHour2.Value);
     end;
     if cfgvtwo.Form6.qsyMinute2.Value < 10 Then
     Begin
          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     End
     Else
     Begin
          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute2.Value);
     end;
     cfg.StoredValue['autoQSYUTC2'] := foo;

     if cfgvtwo.Form6.qsyHour3.Value < 10 Then
     Begin
          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     End
     Else
     Begin
          foo := IntToStr(cfgvtwo.Form6.qsyHour3.Value);
     end;
     if cfgvtwo.Form6.qsyMinute3.Value < 10 Then
     Begin
          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     End
     Else
     Begin
          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute3.Value);
     end;
     cfg.StoredValue['autoQSYUTC3'] := foo;

     if cfgvtwo.Form6.qsyHour4.Value < 10 Then
     Begin
          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     End
     Else
     Begin
          foo := IntToStr(cfgvtwo.Form6.qsyHour4.Value);
     end;
     if cfgvtwo.Form6.qsyMinute4.Value < 10 Then
     Begin
          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     End
     Else
     Begin
          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute4.Value);
     end;
     cfg.StoredValue['autoQSYUTC4'] := foo;

     if cfgvtwo.Form6.qsyHour5.Value < 10 Then
     Begin
          foo := '0' + IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     End
     Else
     Begin
          foo := IntToStr(cfgvtwo.Form6.qsyHour5.Value);
     end;
     if cfgvtwo.Form6.qsyMinute5.Value < 10 Then
     Begin
          foo := foo + '0' + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     End
     Else
     Begin
          foo := foo + IntToStr(cfgvtwo.Form6.qsyMinute5.Value);
     end;
     cfg.StoredValue['autoQSYUTC5'] := foo;
     cfg.StoredValue['high'] := IntToStr(Form1.Height);
     cfg.StoredValue['wide'] := IntToStr(Form1.Width);
     cfg.StoredValue['showonce'] := '1';
     if log.Form2.CheckBox1.Checked then cfg.StoredValue['lognotes'] := '0' else cfg.StoredValue['lognotes'] := '1';
     if cfgvtwo.Form6.cbDecodeDivider.Checked then cfg.StoredValue['divider'] := 'y' else cfg.StoredValue['divider'] := 'n';
     if cfgvtwo.Form6.cbMultiAutoEnableHTX.Checked then cfg.StoredValue['multihalt'] := 'y' else cfg.StoredValue['multihalt'] := 'n';
     if cfgvtwo.Form6.cbCWIDFT.Checked then cfg.StoredValue['cwidfree'] := 'y' else cfg.StoredValue['cwidfree'] := 'n';
     if cfgvtwo.Form6.cbDecodeDividerCompact.Checked then cfg.StoredValue['dividecompact'] := 'y' else cfg.StoredValue['dividecompact'] := 'n';
     cfg.StoredValue['TXWDCounter'] := IntToStr(cfgvtwo.Form6.SpinTXCount.Value);
     if cfgvtwo.Form6.CheckBox1.Checked then cfg.StoredValue['decimalForce1'] := 'y' else cfg.StoredValue['decimalForce1'] := 'n';
     if cfgvtwo.Form6.CheckBox2.Checked then cfg.StoredValue['decimalForce2'] := 'y' else cfg.StoredValue['decimalForce2'] := 'n';
     cfg.Save;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
   i, termcount : Integer;
   kverr        : Integer;
begin
     Form1.Timer1.Enabled := False;
     diagout.Form3.ListBox1.Clear;
     diagout.Form3.Show;
     diagout.Form3.BringToFront;
     diagout.Form3.ListBox1.Items.Add('Closing JT65-HF.  This will take a few seconds.');
     diagout.Form3.ListBox1.Items.Add('Saving Configuration');
     if CloseAction = caFree Then
     Begin
          kverr := 0;
          while FileExists('KVASD.DAT') do
          begin
               DeleteFile('KVASD.DAT');
               inc(kverr);
               if kverr > 10000 then break;
          end;

          saveConfig;

          {TODO [1.1.0] Debug this.. something seems awry.  Using Try/Except to pass this for 1.0.8}
          Try
             if mnpttOpened Then
             Begin
                  diagout.Form3.ListBox1.Items.Add('Closing PTT Port');
                  if getPTTMethod() = 'HRD' Then hrdLowerPTT();
                  if getPTTMethod() = 'ALT' Then altLowerPTT();
                  if getPTTMethod() = 'PTT' Then lowerPTT();
                  diagout.Form3.ListBox1.Items.Add('Closed PTT Port');
             end;
          Except
             // Nothing needs to be done, this simply allows the code to pass safely on fail.
          end;

          if globalData.rbLoggedIn Then
          Begin
               diagout.Form3.ListBox1.Items.Add('Closing RB');
               rb.logoutRB;
               diagout.Form3.ListBox1.Items.Add('Closed RB');
          end;
          diagout.Form3.ListBox1.Items.Add('Terminating RB Thread');
          //rbThread.Suspend;
          diagout.Form3.ListBox1.Items.Add('Terminated RB Thread');

          diagout.Form3.ListBox1.Items.Add('Terminating Decoder Thread');
          termcount := 0;
          while d65.glinProg Do
          Begin
               application.ProcessMessages;
               sleep(1000);
               inc(termcount);
               if termcount > 9 then break;
          end;
          //decoderThread.Suspend;
          diagout.Form3.ListBox1.Items.Add('Terminated Decoder Thread');

          diagout.Form3.ListBox1.Items.Add('Terminating Rig Control Thread');
          termcount :=0;
          if catcontrol.hrdConnected() then diagout.Form3.ListBox1.Items.Add('Disconnecting HRD');
          while catcontrol.hrdConnected() do
          Begin
               application.ProcessMessages;
               catcontrol.hrdDisconnect();
               sleep(1000);
               inc(termcount);
               if termcount > 9 Then break;
          end;
          termcount := 0;
          while catInProgress Do
          Begin
               application.ProcessMessages;
               sleep(1000);
               inc(termcount);
               if termcount > 9 then break;
          end;
          //rigThread.Suspend;
          diagout.Form3.ListBox1.Items.Add('Terminated Rig Control Thread');

          diagout.Form3.ListBox1.Items.Add('Freeing Threads');
          rbThread.Terminate;
          decoderThread.Terminate;
          rigThread.Terminate;
          if not rbThread.FreeOnTerminate Then rbThread.Free;
          if not decoderThread.FreeOnTerminate Then decoderThread.Free;
          if not rigThread.FreeOnTerminate Then rigThread.Free;
          diagout.Form3.ListBox1.Items.Add('Done');

          diagout.Form3.ListBox1.Items.Add('Cleaning up Audio Streams');
          portAudio.Pa_StopStream(paInStream);
          portAudio.Pa_StopStream(paOutStream);
          termcount := 0;
          while (portAudio.Pa_IsStreamActive(paInStream) > 0) or (portAudio.Pa_IsStreamActive(paOutStream) > 0) Do
          Begin
               application.ProcessMessages;
               if portAudio.Pa_IsStreamActive(paInStream) > 0 Then portAudio.Pa_AbortStream(paInStream);
               if portAudio.Pa_IsStreamActive(paOutStream) > 0 Then portAudio.Pa_AbortStream(paOutStream);
               sleep(1000);
               inc(termcount);
               if termcount > 9 then break;
          end;
          diagout.Form3.ListBox1.Items.Add('Stopped Audio Streams');
          diagout.Form3.ListBox1.Items.Add('Terminating PortAudio');
          portaudio.Pa_Terminate();
          diagout.Form3.ListBox1.Items.Add('Terminated PortAudio');

          if cbEnPSKR.Checked Then
          Begin
               diagout.Form3.ListBox1.Items.Add('Closing PSK Reporter');
               rb.logoutPSKR;
               diagout.Form3.ListBox1.Items.Add('Closed PSK Reporter');
          end;

          diagout.Form3.ListBox1.Items.Add('Releasing waterfall');
          Waterfall.Free;
          diagout.Form3.ListBox1.Items.Add('Released waterfall');
          diagout.Form3.ListBox1.Items.Add('JT65-HF Shutdown complete.  Exiting.');
          For i := 0 to 9 do
          begin
               application.ProcessMessages;
               sleep(100);
          end;
     End;
end;

procedure Tform1.addToRBC(i , m : Integer);
Var
   srec : spot.spotRecord;
   eqrg : Integer;
   qrgk : Double;
   foo  : String;
begin
     // function  rb.addSpot(const spot : spotRecord) : Boolean;
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
     // Always add to spotting unit... if spotting is disabled it will be handled
     // properly there.  No need to care about RB or PSKR enabled/not enabled here.
     if eopQRG = sopQRG then
     begin
          // i holds index to data in d65.gld65decodes to spot
          // m holds mode as integer 65 or 4
          // OK.. rather than try to convert everything to the new 2.0 QRG handler I have placed the necessary variable for eopQRG into teopWRG
          // as string for conversion to integer with mval.evalQRG
          //function evalQRG(const qrg : String; const mode : string; var qrgk : Double; var qrghz : Integer; var asciiqrg : String) : Boolean;
          foo := '';
          qrgk := 0.0;
          eQRG := 0;
          if mval.evalQRG(teopqrg, 'LAX', qrgk, eQRG, foo) Then
          Begin
               globalData.iqrg := eQRG;
               srec.qrg      := eQRG;
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
               srec.dbfsent  := false;
               if rb.addSpot(srec) then d65.gld65decodes[i].dtProcessed := True;
          end;
     end;
     // Mark as processed no matter the outcome above.
     d65.gld65decodes[i].dtProcessed := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
Var
   fname, foo  : String;
   pfname      : PChar;
   tstfile     : TextFile;
   i           : Integer;
begin
     // I still need to just do away with XML config other than its use as a
     // holder for the screen positioning.  But not today.

     fname := TrimFileName(GetAppConfigDir(False) + PathDelim + 'station1.xml');

     // Create and initialize TWaterfallControl
     Waterfall := TWaterfallControl.Create(Self);
     Waterfall.Height := 180;
     Waterfall.Width  := 750;
     Waterfall.Top    := 25;
     Waterfall.Left   := 177;
     Waterfall.Parent := Self;
     Waterfall.OnMouseDown := waterfallMouseDown;
     Waterfall.DoubleBuffered := True;

     cfgError := True;

     Try
        fname := TrimFileName(GetAppConfigDir(False) + PathDelim + 'station1.xml');
        cfg.FileName := fname;
        cfgError := False;
     Except
        // An exception here means the xml config file is corrupted. :(
        // So, I need to delete it and force a regeneration.
        pfname := StrAlloc(Length(fname)+1);
        strPcopy(pfname,fname);
        if not DeleteFile(pfname) Then
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
     pfname := StrAlloc(0);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
     // The following is for Wine with Linux/OS X as it doesn't honor the min/max
     // form height/width.
     If Form1.Height < 550 then Form1.Height:=550;
     If (Form1.Width < 935) or (Form1.Width > 935) Then Form1.Width:=935;
     // Scale waterfall size depending upon available form height.
     If Form1.Height < 660 then waterfall.Height := 145 else waterfall.Height := 178;
     // Place Prgress bar position for compact versus expanded layout.
     If Form1.Height > 659 then
     begin
          Label16.Top := 210;
          ProgressBar3.Top := 210;
          Label19.Visible:=true;
          Label23.Visible:=true;
          Label24.Visible:=true;
          Label30.Visible:=true;
     end
     else
     begin
          Label16.Top := 173;
          ProgressBar3.Top := 173;
          Label19.Visible:=false;
          Label23.Visible:=false;
          Label24.Visible:=false;
          Label30.Visible:=false;
     end;
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

procedure TForm1.Label31DblClick(Sender: TObject);
begin
     Form1.spinGain.Value := 0;
     spectrum.specVGain := Form1.spinGain.Value + 7;
end;

procedure TForm1 .Label32DblClick (Sender : TObject );
begin
     // Set DT offset to 0
     spinDT.Value := 0;
end;

procedure TForm1.Label39Click(Sender: TObject);
begin
     if chkAutoTxDF.Checked Then chkAutoTxDF.Checked := False else chkAutoTxDF.Checked := True;
end;

//procedure TForm1.ListBox3DblClick(Sender : TObject);
//begin
//     ListBox3.Clear;
//end;

procedure TForm1.menuAboutClick(Sender: TObject);
begin
     about.Form4.Visible := True;
end;

procedure TForm1.MenuItemHandler(Sender: TObject);
Begin

     // QRG Control Items
     If Sender=Form1.MenuItem1a  Then Form1.editManQRG.Text := '1838';
     If Sender=Form1.MenuItem2a  Then Form1.editManQRG.Text := '3576';
     If Sender=Form1.MenuItem3a  Then Form1.editManQRG.Text := '7039';
     If Sender=Form1.MenuItem4a  Then Form1.editManQRG.Text := '7076';
     If Sender=Form1.MenuItem5a  Then Form1.editManQRG.Text := '14076';
     If Sender=Form1.MenuItem6a  Then Form1.editManQRG.Text := '21076';
     If Sender=Form1.MenuItem7a  Then Form1.editManQRG.Text := '28076';
     If Sender=Form1.MenuItem8a  Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG1.Text;
     If Sender=Form1.MenuItem9a  Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG2.Text;
     If Sender=Form1.MenuItem10a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG3.Text;
     If Sender=Form1.MenuItem11a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG4.Text;
     If Sender=Form1.MenuItem12a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG5.Text;
     If Sender=Form1.MenuItem13a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG6.Text;
     If Sender=Form1.MenuItem14a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG7.Text;
     If Sender=Form1.MenuItem15a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG8.Text;
     If Sender=Form1.MenuItem16a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG9.Text;
     If Sender=Form1.MenuItem17a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG10.Text;
     If Sender=Form1.MenuItem18a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG11.Text;
     If Sender=Form1.MenuItem19a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG12.Text;
     If Sender=Form1.MenuItem20a Then Form1.editManQRG.Text := cfgvtwo.Form6.edUserQRG13.Text;
     // Free Text Messages
     If Sender=Form1.MenuItem1b  Then Form1.edFreeText.Text := 'RO';
     If Sender=Form1.MenuItem2b  Then Form1.edFreeText.Text := 'RRR';
     If Sender=Form1.MenuItem3b  Then Form1.edFreeText.Text := '73';
     If Sender=Form1.MenuItem4b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg4.Text;
     If Sender=Form1.MenuItem5b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg5.Text;
     If Sender=Form1.MenuItem6b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg6.Text;
     If Sender=Form1.MenuItem7b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg7.Text;
     If Sender=Form1.MenuItem8b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg8.Text;
     If Sender=Form1.MenuItem9b  Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg9.Text;
     If Sender=Form1.MenuItem10b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg10.Text;
     If Sender=Form1.MenuItem11b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg11.Text;
     If Sender=Form1.MenuItem12b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg12.Text;
     If Sender=Form1.MenuItem13b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg13.Text;
     If Sender=Form1.MenuItem14b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg14.Text;
     If Sender=Form1.MenuItem15b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg15.Text;
     If Sender=Form1.MenuItem16b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg16.Text;
     If Sender=Form1.MenuItem17b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg17.Text;
     If Sender=Form1.MenuItem18b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg18.Text;
     If Sender=Form1.MenuItem19b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg19.Text;
     If Sender=Form1.MenuItem20b Then Form1.edFreeText.Text := cfgvtwo.Form6.edUserMsg20.Text;

End;

procedure TForm1.menuRawDecoderClick(Sender: TObject);
begin
     diagout.Form3.Visible := True; // diagout is the raw decoder output form... it was repurposed for this.
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

function  TForm1.genSlashedMessage(const exchange : String; var Msg : String; var err : String; var doQSO : Boolean; Const lsiglevel : String) : Boolean;
Var
   localslash, cont      : Boolean;
   remoteslash, resolved : Boolean;
   word1, word2          : String;

Begin
     // Confirmed this code is working live thanks to a N5 signing KP2/ :)
     //
     // CQ W6CQZ/4, QRZ W6CQZ/4, SOMECALL W6CQZ/4, W6CQZ/4 -22, W6CQZ/4 R-22, W6CQZ/4 73
     // OK... The first three forms are of use.  SOMECALL/SOMESUFFIX Calling CQ, QRZ or
     // another call.  The last 3 are not of use at all... those don't show the callsign
     // of the TX station.

     // First check for case of local and remote containing slash, if so fail.  The
     // JT65 protocol does not allow for both stations having slashed callsigns as
     // there is no "room" in the bits to hold 2 slashed callsigns.  Reminds me how
     // This is SUBTLE.  When using pfx or sfx the exchanges have to change to fit
     // in the pfx/sfx.  For instance, the CQ message replaces the grid value with
     // pfx/sfx so for example:
     // CQ KG6CQZ EL98 is a "normal form"
     // CQ KG6CQZ/4 is a "slashed form", take note the grid is gone - it was replaced by /4
     // so...
     // If I attempt to answer a normal form I'd do so as:
     // KG6CQZ KC4NGO EL88
     // Where answering a slashed form I'd do so as:
     // KG6CQZ/4 KC4NGO again dropping the grid value to hold the sfx.
     // now...
     // KG6CQZ/4 KC4NGO/5 CAN NOT WORK.  I'm already using the grid "space" to hold the /4 so where exactly does /5 go?
     // Nowhere.  There are only so many bits in a frame and they're all used by the pair of calls and ONE pfx/sfx, no
     // home for a second pfx/sfx.
     // The above would revert to 13 character limit free text yielding an actual TX message of:
     // KG6CQZ/4 KC4N
     // This only serves to remind me that I  L O A T H E  the entire pfx/sfx mess.

     // OK.. close but no cigar.  In reviewing this with fresh eyes it's still not good enough.  I'm not accounting
     // for all the permutations of it being local call is slashed or remote call slashed.  As the code stands it
     // assumes the remote is slashed and the local is not in some parts and opposite in others.  So... yay... I need
     // to double the code here.

     // So, first things first.  Test for presence of slashed local callsign, then for a callsign
     // in the encoded exchange that IS NOT the local callsign with a slash.  If this contition is
     // detected then the QSO can not be realized.

     localslash := false;
     remoteslash := false;

     // Break the string into words.
     word1 := ExtractWord(1,exchange,[' ']);
     word2 := ExtractWord(2,exchange,[' ']);

     // Test for slash in local callsign
     If AnsiContainsText(globalData.fullcall,'/') Then localslash := true else localslash := false;

     // Quick test for CQ callsign/sfx or CQ pfx/callsign or local user's callsign, then
     // see if I can continue.  What I'm really testing here is presence of slash in both
     // callsigns in which case I can't continue.

     // Test for CQ, QRZ or local callsign
     If (word1='QRZ') or (word1='CQ') or (word1=globalData.fullcall) Then
     Begin
          // Now test word 2 as a NOT SLASHED callsign to determine if word2 contains /.
          if ansicontainstext(word2,'/') then remoteslash := true else remoteslash := false;
     end;

     // Now I should have one of the following to continue:
     // localslash = true AND remoteslash = false
     // localslash = false AND remoteslash = true
     //
     // Can NOT continue if:
     // localslash = false AND remoteslash = false [I may change this, but not today.]
     // localslash = true AND remoteslash = true

     // Test to see if I can continue.
     if localslash AND remoteslash then cont := False else cont := True;

     // Now a second level test to see if there's any point in trying to parse
     // if the test above passed.
     if cont then
     begin
          cont := False;
          // One of the following has to be true to continue.  Again, any one of
          // these as true gives something to work with.
          if word1 = globalData.fullcall then cont := true;
          if word1 = 'CQ' then cont := true;
          if word1 = 'QRZ' then cont := true;
     end;

     // Now, if cont = true I have something to work with.  If not, it's game over.
     if cont then
     begin
          // Check for slash in callsign (local or remote), if present continue while
          // if not do nothing.  In a 2 word excahnge something has to be a slashed
          // callsign.  Yes... it is possible that someone is sending CQ AB1CD without
          // a grid or TEST BC2DEF or any number of other things, but, I can't account
          // for anything other than properly structured messages here.  I will resolve
          // the case of CQ CALLSIGN (no slash), but, the rest is left up to human
          // intervention.
          If AnsiContainsText(word1,'/') Or AnsiContainsText(word2,'/') Or AnsiContainsText(globalData.fullcall,'/') Then
          Begin
               // Testing for a CQ, QRZ or message to local callsign with remote callsign
               // present message type.  This (and only this test) gives context from a 2
               // word exchange.  It will set Form1.edHisCall.Text which is necessary to
               // continue for the 2 words exchanges that do not give full context.

               // First test is for CQ or QRZ as the first word.  Second word MUST be a valid
               // callsign.  I've already checked for case of both local/remote callsigns being
               // slashed, but, check it one more time just to be 100% sure.
               If (word1='QRZ') OR (word1='CQ') Then
               Begin
                    If ValidateSlashedCallsign(word2) OR ValidateCallsign(word2) Then
                    Begin
                         // One last check for both calls being slashed.
                         if ansicontainstext(word2,'/') then remoteslash := true else remoteslash := false;
                         if localslash and remoteslash then
                         begin
                              // No can do, both calls slashed.
                              Form1.edHisCall.Text := '';
                              Form1.edHisGrid.Text := '';
                              msg := '';
                              resolved := False;
                              doQSO := False;
                              doCWID := False;
                         end
                         else
                         begin
                              Form1.edHisCall.Text := word2;
                              Form1.edHisGrid.Text := '';
                              msg := word2 + ' ' + globalData.fullcall;
                              resolved := True;
                              doQSO := True;
                              doCWID := False;
                         end;
                    end
                    else
                    begin
                         // The parsed callsign is not valid :(
                         Form1.edHisCall.Text := '';
                         Form1.edHisGrid.Text := '';
                         msg := '';
                         resolved := False;
                         doQSO := False;
                         doCWID := False;
                    end;
               end
               else
               begin
                    // Didn't resolve, but there's still hope.
                    resolved := False;
                    msg := '';
                    doQSO := False;
                    doCWID := False;
               End;

               // Second test is for local callsign present and a VALID callsign in word2
               if (not resolved) AND (word1=globalData.fullcall) AND (ValidateSlashedCallsign(word2) OR ValidateCallsign(word2)) Then
               Begin
                    // Have word1 as local user's callsign and a valid callsign in word2
                    // so there's some context.  :)  This is the form of a not slashed
                    // callsign answering a slashed callsign calling CQ or a slashed
                    // callsign answering a not slashed callsign calling CQ.
                    // One last check for both calls being slashed.
                    // Check for both callsigns being slashed
                    if ansicontainstext(word2,'/') then remoteslash := true else remoteslash := false;
                    if localslash and remoteslash then
                    begin
                         // No can do, both calls slashed.
                         Form1.edHisCall.Text := '';
                         Form1.edHisGrid.Text := '';
                         msg := '';
                         resolved := False;
                         doQSO := False;
                         doCWID := False;
                         err := 'Can not work with both calls having /.';
                    end
                    else
                    begin
                         // Generate response
                         Form1.edHisCall.Text := word2;
                         Form1.edHisGrid.Text := '';
                         msg := word2 + ' ' + lsiglevel;
                         resolved := true;
                         doQSO := true;
                         doCWID := False;
                    end;
               end;

               // If the tests above didn't resolve I'm Now looking for local callsign
               // with -##, R-##, RRR or 73.  Anything as first word other than local
               // callsign yields failure.  Anything other than -##, R-##, RRR or 73
               // as second words yields failure.

               // To generate a message from these the text in Form1.edHisCall.Text
               // MUST NOT BE EMPTY and a valid slashed or not slashed callsign. And
               // only one of the local/remote callsigns is allowed to contain a /

               if localslash and remoteslash then cont := false else cont := true;
               if (ValidateCallsign(Form1.edHisCall.Text) or ValidateSlashedCallsign(Form1.edHisCall.Text)) and cont then cont := true else cont := false;

               // OK.  Now I have context, valid local/remote callsigns in place and
               // can attempt to resolve for 2 word exchanges of the for local callsign + -##, R-##, RRR and 73.

               if (not resolved) and cont then
               Begin
                    // For these tests the first word MUST BE THE LOCAL USER'S
                    // CALLSIGN.
                    If word1=globalData.fullcall Then
                    Begin
                         // Test for case of an -## to local callsign
                         // Proper response is remote callsign + R-##
                         if not resolved Then
                         Begin
                              if word2[1] = '-' Then
                              Begin
                                   msg := edHisCall.Text + ' R' + lsiglevel;
                                   resolved := True;
                                   doQSO       := True;
                                   doCWID := False;
                              End
                              Else
                              Begin
                                   resolved := False;
                              End;
                         End;
                         // Test for case on an R-## to local callsign
                         // Proper response is remote callsign + RRR
                         If not resolved Then
                         Begin
                              if word2[1..2] = 'R-' Then
                              Begin
                                   msg := edHisCall.Text + ' RRR';
                                   resolved := True;
                                   doQSO    := True;
                                   doCWID   := False;
                              End
                              Else
                              Begin
                                   resolved := False;
                              End;
                         End;
                         // Test for case of an RRR to local callsign
                         // Proper response is remote callsign + 73 message.
                         if not resolved then
                         Begin
                              if word2 = 'RRR'Then
                              Begin
                                   msg := edHisCall.Text + ' 73';
                                   Resolved := True;
                                   doQSO       := True;
                                   doCWID := True;
                              End
                              Else
                              Begin
                                   resolved := False;
                              End;
                         End;
                         // Test for case on an 73 to local callsign
                         // Proper response is remote callsign + 73
                         If not resolved Then
                         Begin
                              if word2[1..2] = '73' Then
                              Begin
                                   msg := edHisCall.Text + ' 73';
                                   resolved := True;
                                   doQSO    := True;
                                   doCWID   := False;
                              End
                              Else
                              Begin
                                   resolved := False;
                              End;
                         End;
                         // Can't figure this one out.
                         if not resolved then
                         begin
                              err := 'Can not compute TX message.';
                              Resolved := false;
                              Form1.edHisCall.Text := '';
                         end;
                    End
                    Else
                    Begin
                         // First word is NOT local callsign, no can do.
                         err := 'Can not compute TX message.';
                         Resolved := false;
                         Form1.edHisCall.Text := '';
                    End;
               End;
          End
          else
          begin
               // Neither word contains a slash so this isn't a "valid" 2 word exchange.
               // But, because it's seen too often and can be my fault due to a bug in
               // JT65-HF [Version before 1.0.8] I need to check for the form CQ CALLSIGN
               // or QRZ CALLSIGN with no slash in callsign or CALLSIGN CALLSIGN with no
               // slash in either before I give up.
               If ((word1='QRZ') OR (word1='CQ')) AND ValidateCallsign(word2) Then
               Begin
                    // In case local callsign is not slashed I generate a full 3 word
                    // response else 2 word response.
                    if localslash then
                    begin
                         // Generate the 2 word response
                         Form1.edHisCall.Text := word2;
                         Form1.edHisGrid.Text := '';
                         msg := word2 + ' ' + globalData.fullcall;
                         resolved := True;
                         doQSO := True;
                         doCWID := False;
                    end
                    else
                    begin
                         // Since neither call is slashed generate the 3 word response.
                         Form1.edHisCall.Text := word2;
                         Form1.edHisGrid.Text := '';
                         msg := word2 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
                         resolved := True;
                         doQSO := True;
                         doCWID := False;
                    end;
               end
               else
               begin
                    // Didn't pass test for CQ/QRZ CALLSIGN form, last check for CALLSIGN CALLSIGN form
                    if (word1=globalData.fullcall) AND ValidateCallsign(word2) Then
                    Begin
                         // This is a callsign callsign form with no slashes anywhere
                         Form1.edHisCall.Text := word2;
                         Form1.edHisGrid.Text := '';
                         msg := word2 + ' ' + globalData.fullcall + ' ' + lsiglevel;
                         resolved := True;
                         doQSO := True;
                         doCWID := False;
                    end
                    else
                    begin
                         // The parsed callsign is not valid :(
                         err := 'Can not compute TX message.';
                         Form1.edHisCall.Text := '';
                         Form1.edHisGrid.Text := '';
                         msg := '';
                         resolved := False;
                         doQSO := False;
                         doCWID := False;
                    end;
               end;
          End;
     end
     else
     begin
          // Word1 is not local callsign, CQ or QRZ.
          err := 'Can not compute TX message.';
          Resolved := false;
          Form1.edHisCall.Text := '';
     end;

     // Insure context indicators are cleared if resolver fails here.  No need to post
     // an error message as this has been handled above.
     if not resolved then
     begin
          msg    := '';
          doCWID := False;
          doQSO  := False;
          result := False;
     end
     else
     begin
          result := True;
     end;
end;

function  TForm1.genNormalMessage(const exchange : String; var Msg : String; var err : String; var doQSO : Boolean; const lsiglevel : String) : Boolean;
Var
   word1, word2, word3 : String;
   resolved            : Boolean;
Begin
     // This is a three word exchange
     word1 := ExtractWord(1,exchange,[' ']);
     word2 := ExtractWord(2,exchange,[' ']);
     word3 := ExtractWord(3,exchange,[' ']);
     resolved := False;

     If (word1 = 'CQ') Or (word1 = 'QRZ') Then
     Begin
          // Callsigns have to be at least 3 characters.
          if length(word2)>2 Then
          Begin
               if ValidateCallsign(word2) then
               Begin
                    Form1.edHisCall.Text := word2;
                    resolved := True;
               End
               Else
               Begin
                    Form1.edHisCall.Text := '';
                    Resolved := False;
               end;
          end
          else
          begin
               Form1.edHisCall.Text := '';
               Resolved := False;
          end;

          // No need to check for grid if length < 4 or > 4 or not resolved for callsign above.
          if (length(word3)>3) And (length(word3)<5) And resolved Then
          Begin
               if ValidateGrid(word3) then edHisGrid.Text := word3 else edHisGrid.text := '';
          end
          else
          begin
               Form1.edHisGrid.Text := '';
          end;

          if resolved then
          begin
               resolved := True;
               if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' ' + globalData.fullcall else msg := word2 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
               doCWID   := False;
               doQSO    := True;
          end
          else
          begin
               resolved := False;
               msg := '';
               doCWID := false;
               doQSO := false;
          end;
     End
     Else
     Begin
          // Message is not a CQ or QRZ form, try what's left.
          If word1 = globalData.fullcall Then
          Begin
               // Seems to be a call to me.
               // word3 could/should be as follows...
               // Grid, signal report, R signal report, an RRR or a 73
               resolved := False;
               if ValidateGrid(word3) And Not resolved Then
               Begin
                    // This seems to be a callsign calling me with a grid
                    // The usual response would be a signal report back
                    If ValidateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                    If ValidateGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' ' + lsiglevel else msg := word2 + ' ' + globalData.fullcall + ' ' + lsiglevel;
                    doCWID   := False;
                    doQSO    := True;
               End;
               if (word3[1] = '-') And not resolved Then
               Begin
                    // This seems an -## signal report
                    // The usual response would be an R-##
                    If ValidateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' R' + lsiglevel else msg := word2 + ' ' + globalData.fullcall + ' R' + lsiglevel;
                    doCWID   := False;
                    doQSO    := True;
               End;
               if (word3[1..2] = 'R-') And not resolved Then
               Begin
                    // This seems an R-## response to my report
                    // The usual response would be an RRR
                    If ValidateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' RRR' else msg := word2 + ' ' + globalData.fullcall + ' RRR';
                    doCWID   := False;
                    doQSO    := True;
               End;
               if (word3 = 'RRR') And not resolved Then
               Begin
                    // This is an ack.  The usual response would be 73
                    If ValidateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' 73' else msg := word2 + ' ' + globalData.fullcall + ' 73';
                    doCWID := True;
                    doQSO    := True;
               End;
               if (word3 = '73') And not resolved Then
               Begin
                    // The usual response to a 73 is a 73
                    If ValidateCallsign(word2) Then Form1.edHisCall.Text := word2 Else Form1.edHisCall.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' 73' else msg := word2 + ' ' + globalData.fullcall + ' 73';
                    doCWID := True;
                    doQSO  := True;
               End;
          End
          Else
          Begin
               // A call to someone else, lets not break into that, but prep to tail in once the existing QSO is complete.
               If ValidateCallsign(word1) And ValidateCallsign(word2) Then
               Begin
                    Form1.edHisCall.Text := word2;
                    If ValidateGrid(word3) Then Form1.edHisGrid.Text := word3 Else Form1.edHisGrid.Text := '';
                    resolved := True;
                    if ansiContainsText(globalData.fullcall,'/') Then msg := word2 + ' ' + globalData.fullcall else msg := word2 + ' ' + globalData.fullcall + ' ' + cfgvtwo.Form6.edMyGrid.Text[1..4];
                    doCWID   := False;
                    doQSO    := False;
               end
               else
               begin
                    resolved := False;
                    msg := '';
                    edHisCall.Text := '';
                    edHisGrid.Text := '';
                    doCWID := False;
                    doQSO := false;
               end;
          End;
     End;
     if not resolved then
     begin
          err := 'Can not compute TX message.';
          msg    := '';
          doCWID := False;
          doQSO  := False;
          result := False;
     end
     else
     begin
          Result := True;
     end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
Var
   txhz, srxp, ss, foo : String;
   txt, efoo           : String;
   exchange            : String;
   wcount, irxp, itxp  : Integer;
   itxhz, idx, i       : Integer;
   resolved, doQSO     : Boolean;
   entTXCF, entRXCF    : Integer;
   isiglevel           : Integer;
   siglevel            : String;
begin
     if itemsIn Then
     Begin
          If Form1.chkMultiDecode.Checked Then
          Begin
               entTXCF := Form1.spinTXCF.Value;
               entRXCF := Form1.spinDecoderCF.Value;
          End;

          // Correct issue where TX was previously enabled for a double clicked message,
          // then user double clicks another message that generates a TX message but
          // should not have TX enabled (a tail in type).  To correct this is simple...
          // always set chkEnTX.checked = false and generated msg edMsg.Text to Nil and
          // call txControls()
          chkEnTX.Enabled := False;
          edMsg.Text := '';
          txControls();

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

               // OK.. Now that I'm placing some warnings/error messages into the decoder output
               // I need to account for this and not try to parse them.  For it to be a decoded
               // message versus an error message the first two characters must be resolvable
               // to an integer ranging from 00 to 23.  Will use TryStrToInt()
               i := 0;
               if TryStrToInt(exchange[1..2],i) Then
               Begin
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

                    If (wcount < 2) Or (wcount > 3) Then
                    Begin
                         Resolved := false;
                         Form1.edHisCall.Text := '';
                         msgToSend := '';
                         exchange := '';
                         resolved := False;
                         efoo     := 'Can not compute TX message';
                    End;

                    {TODO [1.1.0 and beyond] Continue testing result of message parsers for both 2/3 word forms.}

                    // Lots of comments.  :)
                    //
                    // OK.. outline the entire process and try to get it right once and for all.  It will
                    // be a happy day in my little world when I can say this works and forget about it.
                    //
                    // This routine needs to compute a response message to the finite set of STRUCTURED
                    // messages defined by JT65 as a protocol.  The allowed messages come in two forms,
                    // one set for local and remote callsigns NOT having a slashed callsign and another
                    // for those where ONE and ONLY ONE callsign is slashed.  If both local and remote
                    // is slashed then the QSO can not be made.
                    //
                    // Take the best/easiet case first:  Local and remote callsign is slash free leading
                    // to the finite set of messages to parse as:
                    // (R_CALLSIGN = Remote callsign L_CALLSIGN = Local callsign)
                    //
                    // Message Received                 Response
                    // ----------------------           --------------------------
                    // CQ  CALLSIGN GRID                R_CALLSIGN L_CALLSIGN GRID
                    // QRZ CALLSIGN GRID                R_CALLSIGN L_CALLSIGN GRID
                    // CALLSIGN CALLSIGN GRID           R_CALLSIGN L_CALLSIGN -##
                    // CALLSIGN CALLSIGN -##            R_CALLSIGN L_CALLSIGN R-##
                    // CALLSIGN CALLSIGN R-##           R_CALLSIGN L_CALLSIGN RRR
                    // CALLSIGN CALLSIGN RRR            R_CALLSIGN L_CALLSIGN 73
                    // CALLSIGN CALLSIGN 73             R_CALLSIGN L_CALLSIGN 73

                    // Next comes Remote callsign is slashed, local is not.
                    // It does not matter if remote callsign is with prefix or suffix, slash is slash.
                    // ONLY the following 3 can be used to generate a response message since when using
                    // slashed callsing these are the only ones where both the remote and local callsign
                    // is present in the decode.  The remaining sequences only contain a single callsign
                    // and -##, R-##, RRR or 73 leading to no ability to ascertain which station is actually
                    // transmitting.  Subtle, but follow it 2 or 3 times and it'll become apparent.
                    //
                    // Message Received                 Response
                    // ----------------------           --------------------------
                    // CQ  CALLSIGN/x                   R_CALLSIGN/x L_CALLSIGN
                    // QRZ CALLSIGN/x                   R_CALLSIGN/x L_CALLSIGN
                    // CALLSIGN/x CALLSIGN              R_CALLSIGN -##
                    //
                    // Note the switch in context for the third form.  This is CALLSIGN/x answering a
                    // message from remote CALLSIGN with no slash in its call.

                    // Next comes Remote callsign is not slashed, local is.
                    // Message Received                 Response
                    // ----------------------           --------------------------
                    // CQ  CALLSIGN GRID                R_CALLSIGN L_CALLSIGN/x
                    // QRZ CALLSIGN GRID                R_CALLSIGN L_CALLSIGN/x
                    // CALLSIGN CALLSIGN/x              R_CALLSIGN/x -##
                    //
                    // Again, you see a swtich in message form based on context at the third form.
                    // In both cases where a / is present you can only parse the 3 forms listed above.
                    // The remaining forms can not be parsed UNLESS YOU HAVE THE CONTEXT given by
                    // those 3 messages!
                    //
                    // To complete the / message types (those with no context unless the 3 above have
                    // been received and, ultimately contain the local operator's callsign) you have:
                    //
                    // Message Received
                    // ----------------------
                    // CALLSIGN    -##
                    // CALLSIGN/x  -##
                    // CALLSIGN   R-##
                    // CALLSIGN/x R-##
                    // CALLSIGN   RRR
                    // CALLSIGN/x RRR
                    // CALLSIGN   73
                    // CALLSIGN/x 73
                    //
                    // In each of the 2 word types shown above the CALLSIGN or CALLSIGN/x is the callsign
                    // OF THE RECEIVING STATION, not the callsign of the TRANSMITTING STATION. So, one more
                    // time, there is no way of working into those 2 word exchanges without having the
                    // context of the 3 word exchanges.  Time for a headache pill yet? :)
                    //
                    // So.  It's all about context.  In a 3 word exchange you can always get context IF
                    // it's a valid structured message form.  This implies that when dealing with 2 word
                    // exchanges the first word MUST BE THE LOCAL USER'S CALLSIGN or CQ or QRZ to result
                    // in response generation.

                    if wcount = 3 Then
                    Begin
                         // Call message generator for normal sequences.  For 3 word sequences context
                         // of the current message can always be found if it's a VALID 3 word structured
                         // message.
                         txt   := '';
                         efoo  := '';
                         doQSO := False;
                         resolved := genNormalMessage(exchange, txt, efoo, doQSO, siglevel);
                    End;

                    if wcount = 2 Then
                    Begin
                         txt   := '';
                         efoo  := '';
                         doQSO := False;
                         // Call message generator for slashed sequences.  For 2 word sequences context
                         // is less apparent and can only be found when first word is CQ or QRZ or the
                         // local operator's callsign.
                         resolved := genSlashedMessage(exchange, txt, efoo, doQSO, siglevel);
                    end;
               end
               else
               begin
                    // Line clicked is not a decode, probably a warning/error message.
                    Resolved := false;
                    Form1.edHisCall.Text := '';
                    Form1.edHisGrid.Text := '';
                    msgToSend := '';
                    exchange := '';
                    resolved := False;
                    efoo     := 'Can not compute TX message';
               end;

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
                    form1.edMsg.Text := txt;
                    if doQSO Then
                    Begin
                         watchMulti := False;
                         if cfgvtwo.Form6.cbDisableMultiQSO.Checked And Form1.chkMultiDecode.Checked Then
                         Begin
                              preTXCF := entTXCF;
                              preRXCF := entRXCF;
                              if Form1.chkMultiDecode.Checked Then Form1.chkMultiDecode.Checked := False;
                              rxCount := 0;
                              if cfgvtwo.Form6.cbMultiAutoEnable.Checked Then watchMulti := True else watchMulti := False;
                         End;
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
               If not resolved then
               begin
                    // Message didn't resolve
                    addToDisplayE(efoo);
               end;
          End;
     end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
Var
   myColor            : TColor;
   myBrush            : TBrush;
   lineCQ, lineMyCall : Boolean;
   lineWarn           : Boolean;
   foo                : String;
begin
     lineCQ := False;
     lineMyCall := False;
     if Index > -1 Then
     Begin
          foo := Form1.ListBox1.Items[Index];
          if IsWordPresent('WARNING:', foo, [' ']) Then lineWarn := True else lineWarn := False;
          if IsWordPresent('CQ', foo, [' ']) Then lineCQ := True;
          if IsWordPresent('QRZ', foo, [' ']) Then lineCQ := True;
          if IsWordPresent(globalData.fullcall, foo, [' ']) Then lineMyCall := True else lineMyCall := False;
          myBrush := TBrush.Create;
          with (Control as TListBox).Canvas do
          begin
               myColor := cfgvtwo.glqsoColor;
               if lineCQ Then myColor := cfgvtwo.glcqColor;
               if lineMyCall Then myColor := cfgvtwo.glcallColor;
               if lineWarn then myColor := clRed;
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
  If Form1.rbUseLeft.Checked Then adc.adcChan  := 1;
  If Form1.rbUseRight.Checked Then adc.adcChan := 2;
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

procedure TForm1 .spinTXCFKeyPress (Sender : TObject ; var Key : char );
Var
   i : Integer;
begin
     // Filtering input to signal report text box such that it only allows numerics and -
     i := ord(key);
     if not (i=8) then
     begin
        Key := upcase(key);
        if not mval.asciiValidate(Key,'sig') then Key := #0;
     end;
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
     fqrg := globalData.iqrg / 1000000;
     sqrg := FloatToStr(fqrg);
     log.Form2.edLogFrequency.Text := sqrg;
     log.logmycall := globalData.fullcall;
     log.logmygrid := cfgvtwo.Form6.edMyGrid.Text;
     if log.Form2.CheckBox1.Checked Then log.Form2.edLogComment.Text:='';
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
               if cfgvtwo.Form6.chkNoOptFFT.Checked Then
               Begin
                    d65.glfftFWisdom := 0;
                    d65.glfftSWisdom := 0;
               End;
               bStart := 0;
               bEnd := 533504;
               for i := bStart to bEnd do
               Begin
                    if paInParams.channelCount = 2 then
                    begin
                         if haveOddBuffer then d65.glinBuffer[i] := min(32766,max(-32766,adc.d65rxBuffer[i]));
                    end;
               end;
               d65.gld65timestamp := '';
               d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Year);
               if ost.Month < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Month) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Month);
               if ost.Day < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Day) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Day);
               if ost.Hour < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Hour) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Hour);
               if ost.Minute < 10 Then d65.gld65timestamp := d65.gld65timestamp + '0' + IntToStr(ost.Minute) else d65.gld65timestamp := d65.gld65timestamp + IntToStr(ost.Minute);
               d65.gld65timestamp := d65.gld65timestamp + '00';
               sr := 1.0;
               if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text) else globalData.d65samfacin := 1.0;
               //d65samfacout := 1.0;
               d65.glMouseDF := Form1.spinDecoderCF.Value;
               if d65.glMouseDF > 1000 then d65.glMouseDF := 1000;
               if d65.glMouseDF < -1000 then d65.glMouseDF := -1000;
               // Single bin spacing
               if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
               if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
               if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
               if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;

               // Multi bin spacing
               if spinDecoderBin.Value = 1 Then d65.glbinspace := 20;
               if spinDecoderBin.Value = 2 Then d65.glbinspace := 50;
               if spinDecoderBin.Value = 3 Then d65.glbinspace := 100;
               if spinDecoderBin.Value = 4 Then d65.glbinspace := 200;

               if d65.glDFTolerance > 200 then d65.glDFTolerance := 200;
               if d65.glDFTolerance < 20 then d65.glDFTolerance := 20;

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

procedure TForm1.addToDisplayE(msg : String);
Begin
     If firstReport Then
     Begin
          Form1.ListBox1.Items.Strings[0] := msg;
          firstReport := False;
          itemsIn := True;
     End
     Else
     Begin
          Form1.ListBox1.Items.Insert(0,msg);
          itemsIn := True;
     End;
end;

procedure TForm1.addToDisplay(i, m : Integer);
Var
   foo, rpt     : String;
   csvstr       : String;
   wcount       : Integer;
   word1, word3 : String;
   idx, ii      : Integer;
Begin
     //if globalData.gmode = 65 Then mode := 'JT65A';
     //if globalData.gmode =  4 Then mode := 'JT4B';
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
          if cfgvtwo.Form6.cbSaveCSV.Checked Then
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
               //word2 := ExtractWord(2,d65.gld65decodes[i].dtDecoded,[' ']); // call sign
               word3 := ExtractWord(3,d65.gld65decodes[i].dtDecoded,[' ']); // could be grid or report.
          End
          Else
          Begin
               word1 := '';
               //word2 := '';
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
     end;
End;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  // Handle change to Digital Gain
  adc.adcLDgain := Form1.TrackBar1.Position;
  Form1.Label10.Caption := 'L: ' + IntToStr(Form1.TrackBar1.Position);
  If Form1.TrackBar1.Position <> 0 Then Form1.Label10.Font.Color := clRed else Form1.Label10.Font.Color := clBlack;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
  adc.adcRDgain := Form1.TrackBar2.Position;
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
     if paInParams.channelCount = 2 then
     begin
          if audioAve1 > 0 Then audioAve1 := (audioAve1+adc.specLevel1) DIV 2 else audioAve1 := adc.specLevel1;
     end;
     if paInParams.channelCount = 2 then
     Begin
          if audioAve2 > 0 Then audioAve2 := (audioAve1+adc.specLevel2) DIV 2 else audioAve2 := adc.specLevel2;
     end;
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
     if paInParams.channelCount = 2 then
     Begin
          if adc.specLevel1 > 0 Then Form1.rbUseLeft.Caption := 'L ' + IntToStr(Round((audioAveL*0.4)-20)) Else Form1.rbUseLeft.Caption := 'L -20';
     end;
     if paInParams.channelCount = 2 then
     Begin
          if adc.specLevel2 > 0 Then Form1.rbUseRight.Caption := 'R ' + IntToStr(Round((audioAveR*0.4)-20)) Else Form1.rbUseRight.Caption := 'R -20';
     end;
     if paInParams.channelCount = 2 then
     begin
          if (adc.specLevel1 < 40) Or (adc.specLevel1 > 60) Then rbUseLeft.Font.Color := clRed else rbUseLeft.Font.Color := clBlack;
     end;
     if paInParams.channelCount = 2 then
     begin
          if (adc.specLevel2 < 40) Or (adc.specLevel2 > 60) Then rbUseRight.Font.Color := clRed else rbUseRight.Font.Color := clBlack;
     end;
End;

procedure TForm1.rbcCheck();
Var
   foo          : String;
begin
     // Update form title with rb info.
     If cbEnRB.Checked Then
     Begin
          foo := 'JT65-HF Version ' + verHolder.verReturn + '  [ RB Enabled, ';
          If globalData.rbLoggedIn Then foo := foo + 'logged in.  QRG = ' + Form1.editManQRG.Text + ' KHz ]' Else foo := foo + 'not logged in.  QRG = ' + Form1.editManQRG.Text + ' KHz ]';
          foo := foo + ' [ ' + globalData.fullcall + ' QRV ]';
     End
     Else
     Begin
          foo := 'JT65-HF Version ' + verHolder.verReturn + '  [ ' + globalData.fullcall + ' QRV ]';
     End;
     if Form1.Caption <> foo Then Form1.Caption := foo;
end;

procedure TForm1.initializerCode();
var
   paInS, paOutS, foo   : String;
   i, ifoo, kverr       : Integer;
   paDefApi             : Integer;
   paDefApiDevCount     : Integer;
   vint, tstint         : Integer;
   painputs, paoutputs  : Integer;
   vstr                 : PChar;
   st                   : TSYSTEMTIME;
   tstflt               : Double;
   fname, lasto, lasti  : String;
   verUpdate, cont      : Boolean;
   ain, aout, din, dout : Integer;
Begin
     Timer1.Enabled := False;
     Timer2.Enabled := False;
     cfgvtwo.Form6.Visible := false;
     log.Form2.Visible := false;
     kverr := 0;
     while FileExists('KVASD.DAT') do
     begin
          DeleteFile('KVASD.DAT');
          inc(kverr);
          if kverr > 10000 then break;
     end;
     // This block is executed only once when the program starts
     if cfgError Then
     Begin
          showMessage('Configuration file damaged and can not be recovered.' + sLineBreak +
                      'Run JT65-HF Configuration Repair and use delete function.' + sLineBreak + sLineBreak +
                      'Program will now exit.');
          Halt;
     End;
     if cfgRecover then ShowMessage('Configuration file erased due to unrecoverable error.  Please reconfigure.');
     dlog.fileDebug('Entering initializer code.');
     // Check dll version.
     vstr   := StrAlloc(7);
     vint := 0;
     vstr := '0.0.0.0';
     ver(@vint, vstr);
     if vint <> verHolder.dllReturn Then showMessage('wsjt.dll incorrect version.  Program halted.');
     if vint <> verHolder.dllReturn Then halt;
     dlog.fileDebug('JT65.dll version check OK.');

     // Setup internal database
     rb.logDir := GetAppConfigDir(False);

     // Uncomment to dump database at program start.
     //rb.dbToCSV(rb.logdir + 'spots.csv');

     // Initialize prefix/suffix support
     encode65.pfxBuild();
     for i := 0 to 338 do
     begin
          cfgvtwo.Form6.comboPrefix.Items.Add(encode65.e65pfx[i]);
     end;
     for i := 0 to 11 do
     begin
          cfgvtwo.Form6.comboSuffix.Items.Add(encode65.e65sfx[i]);
     end;
     tstint := 0;
     tstflt := 0.0;
     Form1.Caption := 'JT65-HF V' + verHolder.verReturn + ' (c) 2009...2011 W6CQZ.  Free to use/modify/distribute under GPL 2.0 License.';
     // See comments in procedure code to understand why this is a MUST to use.
     DisableFloatingPointExceptions();
     // Setup temporal variables
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

     // Init PA.  If this doesn't work there's no reason to continue.
     PaResult := portaudio.Pa_Initialize();
     If PaResult <> 0 Then ShowMessage('Fatal Error.  Could not initialize portaudio.');
     If PaResult = 0 Then dlog.fileDebug('Portaudio initialized OK.');
     // Now I need to populate the Sound In/Out pulldowns.  First I'm going to get
     // a list of the portaudio API descriptions.  For now I'm going to stick with
     // the default windows interface.
     paDefApi := portaudio.Pa_GetDefaultHostApi();
     if paDefApi >= 0 Then
     Begin
          cfgvtwo.Form6.cbAudioIn.Clear;
          cfgvtwo.Form6.cbAudioOut.Clear;
          paDefApiDevCount := portaudio.Pa_GetHostApiInfo(paDefApi)^.deviceCount;
          i := paDefApiDevCount-1;
          // Get a count of input and output devices.  If input OR output
          // device count = 0 then CAN NOT continue as I need both.
          painputs  := 0;
          paoutputs := 0;

          While i >= 0 do
          Begin
               If portaudio.Pa_GetDeviceInfo(i)^.maxInputChannels > 0 Then inc(painputs);
               If portaudio.Pa_GetDeviceInfo(i)^.maxOutputChannels > 0 Then inc(paoutputs);
               dec(i);
          end;

          // Test for invaLid sound configuration based on device count.  Bail if hardware is invalid.
          if (painputs=0) OR (paoutputs=0) Then
          Begin
               // Unworkable hardware configuration.  Inform and exit.
               foo := 'Sound hardware error!' + sLineBreak + sLineBreak;
               if painputs = 0 Then foo :=  foo + 'Your system has no input devices present.' + sLineBreak +
                                            'Perhaps the sound device is unplugged or' + sLineBreak +
                                            'requires an input cable to be present.';
               if paoutputs = 0 Then foo := foo + 'Your system has no output devices present.' + sLineBreak +
                                            'Perhaps the sound device is unplugged or' + sLineBreak +
                                            'requires an output cable to be present.';
               foo := foo + sLineBreak +    'JT65-HF can not continue.  Please check' + sLineBreak +
                                            'your sound setup and try again.';
               showmessage(foo);
               halt;
          end;

          i := paDefApiDevCount-1;
          While i >= 0 do
          Begin
               // I need to populate the pulldowns with the devices supported by
               // the default portaudio API, select the default in/out devices for
               // said API or restore the saved value of the user's choice of in
               // out devices.
               If portaudio.Pa_GetDeviceInfo(i)^.maxInputChannels > 0 Then
               Begin
                    if i < 10 Then paInS := '0' + IntToStr(i) + '-' + ConvertEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name),GuessEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)),EncodingUTF8) else paInS := IntToStr(i) + '-' + ConvertEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name),GuessEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)),EncodingUTF8);

                    cfgvtwo.Form6.cbAudioIn.Items.Insert(0,paInS);
               End;
               If portaudio.Pa_GetDeviceInfo(i)^.maxOutputChannels > 0 Then
               Begin
                    if i < 10 Then paOutS := '0' + IntToStr(i) +  '-' + ConvertEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name),GuessEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)),EncodingUTF8) else paOutS := IntToStr(i) +  '-' + ConvertEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name),GuessEncoding(StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)),EncodingUTF8);
                    cfgvtwo.Form6.cbAudioOut.Items.Insert(0,paOutS);
               End;
               dec(i);
          End;
          // pulldowns populated.  Now I need to select the portaudio default
          // devices.  To map the values to the pulldown I simply use the integer
          // value of the input device as the pulldown index, for the output I
          // subtract 2 from the pa value to map the correct pulldown index.
          cfgvtwo.Form6.cbAudioIn.ItemIndex := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultInputDevice;
          cfgvtwo.Form6.cbAudioOut.ItemIndex := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultOutputDevice-2;
          dlog.fileDebug('Audio Devices added to pulldowns.');
     End
     Else
     Begin
          // This is yet another fatal error as portaudio can't function if it
          // can't provide a default API value >= 0.  TODO Handle this should it
          // happen.
          dlog.fileDebug('FATAL:  Portaudio DID NOT INIT.  No defapi found.');
          ShowMessage('FATAL:  Portaudio DID NOT initialize.  No default API found, program closing.');
          halt;
     End;

     fname := TrimFileName(GetAppConfigDir(False) + PathDelim + 'station1.xml');
     if not fileExists(fname) Then
     Begin
          cfgvtwo.glmustConfig := True;
          // Setup default sane value for config form.
          cfgvtwo.Form6.edMyCall.Clear;
          cfgvtwo.Form6.edMyGrid.Clear;
          cfgvtwo.Form6.cbAudioIn.ItemIndex := 0;
          cfgvtwo.Form6.cbAudioOut.ItemIndex := 0;
          cfgvtwo.Form6.comboPrefix.ItemIndex := 0;
          cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
          cfgvtwo.Form6.cbTXWatchDog.Checked := True;
          cfgvtwo.Form6.cbDisableMultiQSO.Checked := True;
          cfgvtwo.Form6.cbMultiAutoEnable.Checked := True;
          cfgvtwo.Form6.edRXSRCor.Text := '1.0000';
          cfgvtwo.Form6.edTXSRCor.Text := '1.0000';
          cfgvtwo.Form6.chkEnableAutoSR.Checked := True;
          cfgvtwo.Form6.cbSaveCSV.Checked := True;
          cfgvtwo.Form6.DirectoryEdit1.Directory := GetAppConfigDir(False);
          cfgvtwo.Form6.editUserDefinedPort1.Text := 'None';
          cfgvtwo.Form6.ComboBox1.ItemIndex := 8;
          cfgvtwo.Form6.ComboBox1.Color := clLime;
          cfgvtwo.Form6.ComboBox2.ItemIndex := 7;
          cfgvtwo.Form6.ComboBox2.Color := clRed;
          cfgvtwo.Form6.ComboBox3.ItemIndex := 6;
          cfgvtwo.Form6.ComboBox3.Color := clSilver;
          cfgvtwo.glcqColor := clLime;
          cfgvtwo.glcallColor := clRed;
          cfgvtwo.glqsoColor := clSilver;
          cfgvtwo.Form6.cbEnableQSY1.Checked := False;
          cfgvtwo.Form6.cbEnableQSY2.Checked := False;
          cfgvtwo.Form6.cbEnableQSY3.Checked := False;
          cfgvtwo.Form6.cbEnableQSY4.Checked := False;
          cfgvtwo.Form6.cbEnableQSY5.Checked := False;
          cfgvtwo.Form6.qsyHour1.Value := 0;
          cfgvtwo.Form6.qsyHour2.Value := 0;
          cfgvtwo.Form6.qsyHour3.Value := 0;
          cfgvtwo.Form6.qsyHour4.Value := 0;
          cfgvtwo.Form6.qsyHour5.Value := 0;
          cfgvtwo.Form6.qsyMinute1.Value := 0;
          cfgvtwo.Form6.qsyMinute2.Value := 0;
          cfgvtwo.Form6.qsyMinute3.Value := 0;
          cfgvtwo.Form6.qsyMinute4.Value := 0;
          cfgvtwo.Form6.qsyMinute5.Value := 0;
          cfgvtwo.Form6.edQRGQSY1.Text := '14076000';
          cfgvtwo.Form6.edQRGQSY2.Text := '14076000';
          cfgvtwo.Form6.edQRGQSY3.Text := '14076000';
          cfgvtwo.Form6.edQRGQSY4.Text := '14076000';
          cfgvtwo.Form6.edQRGQSY5.Text := '14076000';
          cfgvtwo.Form6.cbATQSY1.Checked := False;
          cfgvtwo.Form6.cbATQSY2.Checked := False;
          cfgvtwo.Form6.cbATQSY3.Checked := False;
          cfgvtwo.Form6.cbATQSY4.Checked := False;
          cfgvtwo.Form6.cbATQSY5.Checked := False;
          cfgvtwo.Form6.chkHRDPTT.Checked := False;
          cfgvtwo.Form6.chkTxDFVFO.Checked := False;
          cfgvtwo.Form6.hrdAddress.Text := 'localhost';
          cfgvtwo.Form6.hrdPort.Text := '7809';
          Form1.spinGain.Value := 0;
          cfgvtwo.Form6.chkNoOptFFT.Checked := False;
          cfgvtwo.glcatBy := 'none';
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
          Form1.spinDecoderBin.Value := 3;
          Form1.spinDecoderBW.Value  := 3;
          Form1.Edit3.Text := '100';
          Form1.Edit2.Text := '100';
          cfgvtwo.Form6.Show;
          cfgvtwo.Form6.BringToFront;
          repeat
                sleep(10);
                Application.ProcessMessages
          until not cfgvtwo.glmustConfig;
          cfgvtwo.Form6.Visible := False;
          saveConfig;
          ShowMessage('You can resize the main window! (Taller or shorter.)');
          dlog.fileDebug('Ran initial configuration.');
     End;
     // Read configuration data from XMLpropstorage (cfg.)
     tstint := 0;
     if TryStrToInt(cfg.StoredValue['high'],tstint) Then Form1.Height := tstint;
     tstint := 0;
     if TryStrToInt(cfg.StoredValue['wide'],tstint) Then Form1.Width := tstint;
     if Form1.Height < 550 then Form1.Height := 550;
     if (Form1.Width < 935) or (Form1.Width > 935) Then Form1.Width := 935;

     cfgvtwo.glmycall := cfg.StoredValue['call'];
     tstint := 0;
     if TryStrToInt(cfg.storedValue['pfx'],tstint) Then cfgvtwo.Form6.comboPrefix.ItemIndex := tstint else cfgvtwo.Form6.comboPrefix.ItemIndex := 0;
     if TryStrToInt(cfg.storedValue['sfx'],tstint) Then cfgvtwo.Form6.comboSuffix.ItemIndex := tstint else cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
     // Check for invalid case of suffix AND prefix being set.  If so prefix wins.
     if (cfgvtwo.Form6.comboPrefix.ItemIndex > 0) And (cfgvtwo.Form6.comboSuffix.ItemIndex > 0) Then cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
     if cfgvtwo.Form6.comboPrefix.ItemIndex > 0 then mnHavePrefix := True else mnHavePrefix := False;
     if cfgvtwo.Form6.comboSuffix.ItemIndex > 0 then mnHaveSuffix := True else mnHaveSuffix := False;
     cfgvtwo.Form6.edMyCall.Text := cfgvtwo.glmycall;
     if mnHavePrefix or mnHaveSuffix Then
     Begin
          if mnHavePrefix then globalData.fullcall := cfgvtwo.Form6.comboPrefix.Items[cfgvtwo.Form6.comboPrefix.ItemIndex] + '/' + cfgvtwo.glmycall;
          if mnHaveSuffix then globalData.fullcall := cfgvtwo.glmycall + '/' + cfgvtwo.Form6.comboSuffix.Items[cfgvtwo.Form6.comboSuffix.ItemIndex];
     End
     Else
     Begin
          globalData.fullcall := cfgvtwo.glmycall;
     End;
     cfgvtwo.Form6.edMyGrid.Text := cfg.StoredValue['grid'];
     tstint := 0;
     if TryStrToInt(cfg.StoredValue['rxCF'],tstint) Then Form1.spinDecoderCF.Value := tstint else Form1.spinDecoderCF.Value := 0;
     spinDecoderCFChange(spinDecoderCF);
     tstint := 0;
     if TryStrToInt(cfg.StoredValue['txCF'],tstint) Then Form1.spinTXCF.Value := tstint else Form1.spinTXCF.Value := 0;
     spinTXCFChange(spinTXCF);

     // Last selected in/out devices stored as names of device LESS the leading digits.
     // These won't be present until the program has been ran and properly close once.
     // So.. handle it if they're empty strings :)
     // The string name of a device begins at the 4th character since 1..3 is ##-

     lasto := cfg.StoredValue['LastOutput'];
     lasti := cfg.StoredValue['LastInput'];

     tstint := 0;
     if TryStrToInt(cfg.StoredValue['soundin'],tstint) Then
     Begin
          // Stored value is the index of the selected device from the last run.
          // It may be as expected, different or missing completly.
          if tstint < cfgvtwo.Form6.cbAudioIn.Items.Count then cfgvtwo.Form6.cbAudioIn.ItemIndex := tstint else cfgvtwo.Form6.cbAudioIn.ItemIndex:=0;
     end
     else
     begin
          cfgvtwo.Form6.cbAudioIn.ItemIndex := 0;
     end;

     tstint := 0;
     if TryStrToInt(cfg.StoredValue['soundout'],tstint) Then
     begin
          // Stored value is the index of the selected device from the last run.
          // It may be as expected, different or missing completly.
          if tstint < cfgvtwo.Form6.cbAudioOut.Items.Count then cfgvtwo.Form6.cbAudioOut.ItemIndex := tstint else cfgvtwo.Form6.cbAudioOut.ItemIndex:=0;
     end
     else
     begin
          cfgvtwo.Form6.cbAudioOut.ItemIndex := 0;
     end;

     // Test to see if currently selected devices match (string wise) previously selected devices.
     if length(lasti)>0 then
     begin
          // Compare lasti to currently selected input
          foo := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
          foo := foo[4..Length(foo)];
          if lasti <> foo then showmessage('The currently selected input device has changed from saved value.' + sLineBreak +
                                           'Saved:  ' + lasti + sLineBreak +
                                           'Current:  ' + foo + sLineBreak + sLineBreak +
                                           'Please check configuration to be sure correct device has been set.');
     end;

     if length(lasto)>0 then
     begin
          // Compare lasto to currently selected output
          foo := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
          foo := foo[4..Length(foo)];
          if lasto <> foo then showmessage('The currently selected output device has changed from saved value.' + sLineBreak +
                                           'Saved:  ' + lasto + sLineBreak +
                                           'Current:  ' + foo + sLineBreak + sLineBreak +
                                           'Please check configuration to be sure correct device has been set.');
     end;

     tstint := 0;
     if TryStrToInt(cfg.StoredValue['ldgain'],tstint) Then
     Begin
          Form1.TrackBar1.Position := tstint;
          adc.adcLDgain := Form1.TrackBar1.Position;
     End
     else
     Begin
          Form1.TrackBar1.Position := 0;
          adc.adcLDgain := Form1.TrackBar1.Position;
     End;
     tstint := 0;
     if TryStrToInt(cfg.StoredValue['rdgain'],tstint) Then
     Begin
          Form1.TrackBar2.Position := tstint;
          adc.adcRDgain := Form1.TrackBar2.Position;
     End
     else
     Begin
          Form1.TrackBar2.Position := 0;
          adc.adcRDgain := Form1.TrackBar2.Position;
     End;
     Form1.Label10.Caption := 'L: ' + IntToStr(Form1.TrackBar1.Position);
     Form1.Label11.Caption := 'R: ' + IntToStr(Form1.TrackBar2.Position);
     If Form1.TrackBar1.Position <> 0 Then Form1.Label10.Font.Color := clRed else Form1.Label10.Font.Color := clBlack;
     If Form1.TrackBar2.Position <> 0 Then Form1.Label11.Font.Color := clRed else Form1.Label11.Font.Color := clBlack;
     tstflt := 0.0;
     if TryStrToFloat(cfg.StoredValue['samfacin'],tstflt) Then cfgvtwo.Form6.edRXSRCor.Text := cfg.StoredValue['samfacin'] else cfgvtwo.Form6.edRXSRCor.Text := '1.0000';
     tstflt := 0.0;
     if TryStrToFloat(cfg.StoredValue['samfacout'],tstflt) Then cfgvtwo.Form6.edTXSRCor.Text := cfg.StoredValue['samfacout'] else cfgvtwo.Form6.edTXSRCor.Text := '1.0000';
     if cfg.StoredValue['audiochan'] = 'L' Then Form1.rbUseLeft.Checked := True;
     if cfg.StoredValue['audiochan'] = 'R' Then Form1.rbUseRight.Checked := True;
     If Form1.rbUseLeft.Checked Then adc.adcChan  := 1;
     If Form1.rbUseRight.Checked Then adc.adcChan := 2;
     if cfg.StoredValue['autoSR'] = '1' Then
     Begin
          cfgvtwo.Form6.chkEnableAutoSR.Checked := True;
          cfgvtwo.glautoSR := True;
     end
     else
     begin
          cfgvtwo.Form6.chkEnableAutoSR.Checked := False;
          cfgvtwo.glautoSR := False;
     end;
     cfgvtwo.Form6.editUserDefinedPort1.Text := UpperCase(cfg.StoredValue['pttPort']);
     if cfg.StoredValue['afc'] = '1' Then Form1.chkAfc.Checked := True Else Form1.chkAfc.Checked := False;
     If Form1.chkAFC.Checked Then Form1.chkAFC.Font.Color := clRed else Form1.chkAFC.Font.Color := clBlack;
     if Form1.chkAFC.Checked then d65.glNafc := 1 Else d65.glNafc := 0;
     if cfg.StoredValue['noiseblank'] = '1' Then Form1.chkNB.Checked := True Else Form1.chkNB.Checked := False;
     If Form1.chkNB.Checked then Form1.chkNB.Font.Color := clRed else Form1.chkNB.Font.Color := clBlack;
     If Form1.chkNB.Checked then d65.glNblank := 1 Else d65.glNblank := 0;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['brightness'],tstint) Then Form1.tbBright.Position := tstint else Form1.tbBright.Position := 0;
     spectrum.specGain := Form1.tbBright.Position;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['contrast'],tstint) Then Form1.tbContrast.Position := tstint else Form1.tbContrast.Position := 0;
     spectrum.specContrast := Form1.tbContrast.Position;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['colormap'],tstint) Then Form1.cbSpecPal.ItemIndex := tstint else Form1.cbSpecPal.ItemIndex := 0;
     spectrum.specColorMap := Form1.cbSpecPal.ItemIndex;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['specspeed'],tstint) Then
     Begin
          Form1.SpinEdit1.Value := tstint;
          spectrum.specSpeed2 := tstint;
     End
     Else
     Begin
          spectrum.specSpeed2 := 0;
          Form1.SpinEdit1.Value := 0;
     End;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['specVGain'],tstint) Then
     Begin
          Form1.SpinGain.Value := tstint;
          spectrum.specVGain := tstint+7;
     End
     Else
     Begin
          Form1.SpinGain.Value := 0;
          spectrum.specVGain := 7;
     End;
     if cfg.StoredValue['saveCSV'] = '1' Then cfgvtwo.Form6.cbSaveCSV.Checked := True else cfgvtwo.Form6.cbSaveCSV.Checked := False;
     if Length(cfg.StoredValue['csvPath']) > 0 Then cfgvtwo.Form6.DirectoryEdit1.Directory := cfg.StoredValue['csvPath'] else cfgvtwo.Form6.DirectoryEdit1.Directory := GetAppConfigDir(False);
     if Length(cfg.StoredValue['adiPath']) > 0 Then log.Form2.DirectoryEdit1.Directory := cfg.StoredValue['adiPath'] else log.Form2.DirectoryEdit1.Directory := GetAppConfigDir(False);
     if cfg.StoredValue['version'] <> verHolder.verReturn Then verUpdate := True else verUpdate := False;
     if cfg.StoredValue['txWatchDog'] = '1' Then
     Begin
          cfgvtwo.Form6.cbTXWatchDog.Checked := True
     End
     else
     Begin
          cfgvtwo.Form6.cbTXWatchDog.Checked := False;
     End;
     if cfg.StoredValue['multiQSOToggle'] = '1' Then cfgvtwo.Form6.cbDisableMultiQSO.Checked := True else cfgvtwo.Form6.cbDisableMultiQSO.Checked := False;
     if cfg.StoredValue['multiQSOWatchDog'] = '1' Then cfgvtwo.Form6.cbMultiAutoEnable.Checked := True else cfgvtwo.Form6.cbMultiAutoEnable.Checked := False;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['cqColor'],tstint) Then cfgvtwo.Form6.ComboBox1.ItemIndex := tstint else cfgvtwo.Form6.ComboBox1.ItemIndex := 8;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['callColor'],tstint) Then cfgvtwo.Form6.ComboBox2.ItemIndex := tstint else cfgvtwo.Form6.ComboBox2.ItemIndex := 7;
     tstint := 0;
     If TryStrToInt(cfg.StoredValue['qsoColor'],tstint) Then cfgvtwo.Form6.ComboBox3.ItemIndex := tstint else cfgvtwo.Form6.ComboBox1.ItemIndex := 6;
     Case cfgvtwo.Form6.ComboBox1.ItemIndex of
          0  : cfgvtwo.Form6.Edit1.Color := clGreen;
          1  : cfgvtwo.Form6.Edit1.Color := clOlive;
          2  : cfgvtwo.Form6.Edit1.Color := clSkyBlue;
          3  : cfgvtwo.Form6.Edit1.Color := clPurple;
          4  : cfgvtwo.Form6.Edit1.Color := clTeal;
          5  : cfgvtwo.Form6.Edit1.Color := clGray;
          6  : cfgvtwo.Form6.Edit1.Color := clSilver;
          7  : cfgvtwo.Form6.Edit1.Color := clRed;
          8  : cfgvtwo.Form6.Edit1.Color := clLime;
          9  : cfgvtwo.Form6.Edit1.Color := clYellow;
          10 : cfgvtwo.Form6.Edit1.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.Edit1.Color := clFuchsia;
          12 : cfgvtwo.Form6.Edit1.Color := clAqua;
          13 : cfgvtwo.Form6.Edit1.Color := clCream;
          14 : cfgvtwo.Form6.Edit1.Color := clMedGray;
          15 : cfgvtwo.Form6.Edit1.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox1.ItemIndex of
          0  : cfgvtwo.Form6.ComboBox1.Color := clGreen;
          1  : cfgvtwo.Form6.ComboBox1.Color := clOlive;
          2  : cfgvtwo.Form6.ComboBox1.Color := clSkyBlue;
          3  : cfgvtwo.Form6.ComboBox1.Color := clPurple;
          4  : cfgvtwo.Form6.ComboBox1.Color := clTeal;
          5  : cfgvtwo.Form6.ComboBox1.Color := clGray;
          6  : cfgvtwo.Form6.ComboBox1.Color := clSilver;
          7  : cfgvtwo.Form6.ComboBox1.Color := clRed;
          8  : cfgvtwo.Form6.ComboBox1.Color := clLime;
          9  : cfgvtwo.Form6.ComboBox1.Color := clYellow;
          10 : cfgvtwo.Form6.ComboBox1.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.ComboBox1.Color := clFuchsia;
          12 : cfgvtwo.Form6.ComboBox1.Color := clAqua;
          13 : cfgvtwo.Form6.ComboBox1.Color := clCream;
          14 : cfgvtwo.Form6.ComboBox1.Color := clMedGray;
          15 : cfgvtwo.Form6.ComboBox1.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox1.ItemIndex of
          0  : cfgvtwo.glcqColor := clGreen;
          1  : cfgvtwo.glcqColor := clOlive;
          2  : cfgvtwo.glcqColor := clSkyBlue;
          3  : cfgvtwo.glcqColor := clPurple;
          4  : cfgvtwo.glcqColor := clTeal;
          5  : cfgvtwo.glcqColor := clGray;
          6  : cfgvtwo.glcqColor := clSilver;
          7  : cfgvtwo.glcqColor := clRed;
          8  : cfgvtwo.glcqColor := clLime;
          9  : cfgvtwo.glcqColor := clYellow;
          10 : cfgvtwo.glcqColor := clMoneyGreen;
          11 : cfgvtwo.glcqColor := clFuchsia;
          12 : cfgvtwo.glcqColor := clAqua;
          13 : cfgvtwo.glcqColor := clCream;
          14 : cfgvtwo.glcqColor := clMedGray;
          15 : cfgvtwo.glcqColor := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox2.ItemIndex of
          0  : cfgvtwo.Form6.Edit2.Color := clGreen;
          1  : cfgvtwo.Form6.Edit2.Color := clOlive;
          2  : cfgvtwo.Form6.Edit2.Color := clSkyBlue;
          3  : cfgvtwo.Form6.Edit2.Color := clPurple;
          4  : cfgvtwo.Form6.Edit2.Color := clTeal;
          5  : cfgvtwo.Form6.Edit2.Color := clGray;
          6  : cfgvtwo.Form6.Edit2.Color := clSilver;
          7  : cfgvtwo.Form6.Edit2.Color := clRed;
          8  : cfgvtwo.Form6.Edit2.Color := clLime;
          9  : cfgvtwo.Form6.Edit2.Color := clYellow;
          10 : cfgvtwo.Form6.Edit2.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.Edit2.Color := clFuchsia;
          12 : cfgvtwo.Form6.Edit2.Color := clAqua;
          13 : cfgvtwo.Form6.Edit2.Color := clCream;
          14 : cfgvtwo.Form6.Edit2.Color := clMedGray;
          15 : cfgvtwo.Form6.Edit2.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox2.ItemIndex of
          0  : cfgvtwo.Form6.ComboBox2.Color := clGreen;
          1  : cfgvtwo.Form6.ComboBox2.Color := clOlive;
          2  : cfgvtwo.Form6.ComboBox2.Color := clSkyBlue;
          3  : cfgvtwo.Form6.ComboBox2.Color := clPurple;
          4  : cfgvtwo.Form6.ComboBox2.Color := clTeal;
          5  : cfgvtwo.Form6.ComboBox2.Color := clGray;
          6  : cfgvtwo.Form6.ComboBox2.Color := clSilver;
          7  : cfgvtwo.Form6.ComboBox2.Color := clRed;
          8  : cfgvtwo.Form6.ComboBox2.Color := clLime;
          9  : cfgvtwo.Form6.ComboBox2.Color := clYellow;
          10 : cfgvtwo.Form6.ComboBox2.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.ComboBox2.Color := clFuchsia;
          12 : cfgvtwo.Form6.ComboBox2.Color := clAqua;
          13 : cfgvtwo.Form6.ComboBox2.Color := clCream;
          14 : cfgvtwo.Form6.ComboBox2.Color := clMedGray;
          15 : cfgvtwo.Form6.ComboBox2.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox2.ItemIndex of
          0  : cfgvtwo.glcallColor := clGreen;
          1  : cfgvtwo.glcallColor := clOlive;
          2  : cfgvtwo.glcallColor := clSkyBlue;
          3  : cfgvtwo.glcallColor := clPurple;
          4  : cfgvtwo.glcallColor := clTeal;
          5  : cfgvtwo.glcallColor := clGray;
          6  : cfgvtwo.glcallColor := clSilver;
          7  : cfgvtwo.glcallColor := clRed;
          8  : cfgvtwo.glcallColor := clLime;
          9  : cfgvtwo.glcallColor := clYellow;
          10 : cfgvtwo.glcallColor := clMoneyGreen;
          11 : cfgvtwo.glcallColor := clFuchsia;
          12 : cfgvtwo.glcallColor := clAqua;
          13 : cfgvtwo.glcallColor := clCream;
          14 : cfgvtwo.glcallColor := clMedGray;
          15 : cfgvtwo.glcallColor := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox3.ItemIndex of
          0  : cfgvtwo.Form6.Edit3.Color := clGreen;
          1  : cfgvtwo.Form6.Edit3.Color := clOlive;
          2  : cfgvtwo.Form6.Edit3.Color := clSkyBlue;
          3  : cfgvtwo.Form6.Edit3.Color := clPurple;
          4  : cfgvtwo.Form6.Edit3.Color := clTeal;
          5  : cfgvtwo.Form6.Edit3.Color := clGray;
          6  : cfgvtwo.Form6.Edit3.Color := clSilver;
          7  : cfgvtwo.Form6.Edit3.Color := clRed;
          8  : cfgvtwo.Form6.Edit3.Color := clLime;
          9  : cfgvtwo.Form6.Edit3.Color := clYellow;
          10 : cfgvtwo.Form6.Edit3.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.Edit3.Color := clFuchsia;
          12 : cfgvtwo.Form6.Edit3.Color := clAqua;
          13 : cfgvtwo.Form6.Edit3.Color := clCream;
          14 : cfgvtwo.Form6.Edit3.Color := clMedGray;
          15 : cfgvtwo.Form6.Edit3.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox3.ItemIndex of
          0  : cfgvtwo.Form6.ComboBox3.Color := clGreen;
          1  : cfgvtwo.Form6.ComboBox3.Color := clOlive;
          2  : cfgvtwo.Form6.ComboBox3.Color := clSkyBlue;
          3  : cfgvtwo.Form6.ComboBox3.Color := clPurple;
          4  : cfgvtwo.Form6.ComboBox3.Color := clTeal;
          5  : cfgvtwo.Form6.ComboBox3.Color := clGray;
          6  : cfgvtwo.Form6.ComboBox3.Color := clSilver;
          7  : cfgvtwo.Form6.ComboBox3.Color := clRed;
          8  : cfgvtwo.Form6.ComboBox3.Color := clLime;
          9  : cfgvtwo.Form6.ComboBox3.Color := clYellow;
          10 : cfgvtwo.Form6.ComboBox3.Color := clMoneyGreen;
          11 : cfgvtwo.Form6.ComboBox3.Color := clFuchsia;
          12 : cfgvtwo.Form6.ComboBox3.Color := clAqua;
          13 : cfgvtwo.Form6.ComboBox3.Color := clCream;
          14 : cfgvtwo.Form6.ComboBox3.Color := clMedGray;
          15 : cfgvtwo.Form6.ComboBox3.Color := clWhite;
     End;
     Case cfgvtwo.Form6.ComboBox3.ItemIndex of
          0  : cfgvtwo.glqsoColor := clGreen;
          1  : cfgvtwo.glqsoColor := clOlive;
          2  : cfgvtwo.glqsoColor := clSkyBlue;
          3  : cfgvtwo.glqsoColor := clPurple;
          4  : cfgvtwo.glqsoColor := clTeal;
          5  : cfgvtwo.glqsoColor := clGray;
          6  : cfgvtwo.glqsoColor := clSilver;
          7  : cfgvtwo.glqsoColor := clRed;
          8  : cfgvtwo.glqsoColor := clLime;
          9  : cfgvtwo.glqsoColor := clYellow;
          10 : cfgvtwo.glqsoColor := clMoneyGreen;
          11 : cfgvtwo.glqsoColor := clFuchsia;
          12 : cfgvtwo.glqsoColor := clAqua;
          13 : cfgvtwo.glqsoColor := clCream;
          14 : cfgvtwo.glqsoColor := clMedGray;
          15 : cfgvtwo.glqsoColor := clWhite;
     End;
     if cfg.StoredValue['catBy'] = 'none' Then
     Begin
          cfgvtwo.Form6.chkUseCommander.Checked := False;
          cfgvtwo.Form6.chkUseOmni.Checked := False;
          cfgvtwo.Form6.chkUseHRD.Checked := False;
          cfgvtwo.glcatBy := 'none';
     End;
     if cfg.StoredValue['catBy'] = 'omni' Then
     Begin
          cfgvtwo.Form6.chkUseCommander.Checked := False;
          cfgvtwo.Form6.chkUseOmni.Checked := True;
          cfgvtwo.Form6.chkUseHRD.Checked := False;
          cfgvtwo.glcatBy := 'omni';
     End;
     if cfg.StoredValue['catBy'] = 'hamlib' Then
     Begin
          cfgvtwo.Form6.chkUseCommander.Checked := False;
          cfgvtwo.Form6.chkUseOmni.Checked := False;
          cfgvtwo.Form6.chkUseHRD.Checked := False;
          cfgvtwo.glcatBy := 'none';
          //ShowMessage('To prevent a very difficult to correct bug I have disabled HamLib support in JT65-HF.  Rig Control has been set to None.');
     End;
     if cfg.StoredValue['catBy'] = 'hrd' Then
     Begin
          cfgvtwo.Form6.chkUseCommander.Checked := False;
          cfgvtwo.Form6.chkUseOmni.Checked := False;
          cfgvtwo.Form6.chkUseHRD.Checked := True;
          cfgvtwo.glcatBy := 'hrd';
     End;
     if cfg.StoredValue['catBy'] = 'commander' Then
     Begin
          cfgvtwo.Form6.chkUseCommander.Checked := True;
          cfgvtwo.Form6.chkUseOmni.Checked := False;
          cfgvtwo.Form6.chkUseHRD.Checked := False;
          cfgvtwo.glcatBy := 'commander';
     End;
     if cfg.StoredValue['pskrCall'] = '' Then cfgvtwo.Form6.editPSKRCall.Text := cfgvtwo.Form6.edMyCall.Text else cfgvtwo.Form6.editPSKRCall.Text := cfg.StoredValue['pskrCall'];
     if cfg.StoredValue['usePSKR'] = 'yes' Then cbEnPSKR.Checked := True else cbEnPSKR.Checked := False;
     if cfg.StoredValue['useRB'] = 'yes' Then cbEnRB.Checked := True else cbEnRB.Checked := False;
     cfgvtwo.Form6.editPSKRAntenna.Text := cfg.StoredValue['pskrAntenna'];
     if cfg.StoredValue['optFFT'] = 'on' Then cfgvtwo.Form6.chkNoOptFFT.Checked := False else cfgvtwo.Form6.chkNoOptFFT.Checked := True;
     if cfg.StoredValue['useAltPTT'] = 'yes' Then cfgvtwo.Form6.cbUseAltPTT.Checked := True else cfgvtwo.Form6.cbUseAltPTT.Checked := False;
     if cfg.StoredValue['useHRDPTT'] = 'yes' Then cfgvtwo.Form6.chkHRDPTT.Checked := True else cfgvtwo.Form6.chkHRDPTT.Checked := False;
     if cfg.StoredValue['useCATTxDF'] = 'yes' Then cfgvtwo.Form6.chkTxDFVFO.Checked := True else cfgvtwo.Form6.chkTxDFVFO.Checked := False;

     cfgvtwo.Form6.edUserQRG1.Text := cfg.StoredValue['userQRG1'];
     cfgvtwo.Form6.edUserQRG2.Text := cfg.StoredValue['userQRG2'];
     cfgvtwo.Form6.edUserQRG3.Text := cfg.StoredValue['userQRG3'];
     cfgvtwo.Form6.edUserQRG4.Text := cfg.StoredValue['userQRG4'];
     cfgvtwo.Form6.edUserQRG5.Text := cfg.StoredValue['userQRG5'];
     cfgvtwo.Form6.edUserQRG6.Text := cfg.StoredValue['userQRG6'];
     cfgvtwo.Form6.edUserQRG7.Text := cfg.StoredValue['userQRG7'];
     cfgvtwo.Form6.edUserQRG8.Text := cfg.StoredValue['userQRG8'];
     cfgvtwo.Form6.edUserQRG9.Text := cfg.StoredValue['userQRG9'];
     cfgvtwo.Form6.edUserQRG10.Text := cfg.StoredValue['userQRG10'];
     cfgvtwo.Form6.edUserQRG11.Text := cfg.StoredValue['userQRG11'];
     cfgvtwo.Form6.edUserQRG12.Text := cfg.StoredValue['userQRG12'];
     cfgvtwo.Form6.edUserQRG13.Text := cfg.StoredValue['userQRG13'];

     cfgvtwo.Form6.edUserMsg4.Text := cfg.StoredValue['usrMsg1'];
     cfgvtwo.Form6.edUserMsg5.Text := cfg.StoredValue['usrMsg2'];
     cfgvtwo.Form6.edUserMsg6.Text := cfg.StoredValue['usrMsg3'];
     cfgvtwo.Form6.edUserMsg7.Text := cfg.StoredValue['usrMsg4'];
     cfgvtwo.Form6.edUserMsg8.Text := cfg.StoredValue['usrMsg5'];
     cfgvtwo.Form6.edUserMsg9.Text := cfg.StoredValue['usrMsg6'];
     cfgvtwo.Form6.edUserMsg10.Text := cfg.StoredValue['usrMsg7'];
     cfgvtwo.Form6.edUserMsg11.Text := cfg.StoredValue['usrMsg8'];
     cfgvtwo.Form6.edUserMsg12.Text := cfg.StoredValue['usrMsg9'];
     cfgvtwo.Form6.edUserMsg13.Text := cfg.StoredValue['usrMsg10'];
     cfgvtwo.Form6.edUserMsg14.Text := cfg.StoredValue['usrMsg11'];
     cfgvtwo.Form6.edUserMsg15.Text := cfg.StoredValue['usrMsg12'];
     cfgvtwo.Form6.edUserMsg16.Text := cfg.StoredValue['usrMsg13'];
     cfgvtwo.Form6.edUserMsg17.Text := cfg.StoredValue['usrMsg14'];
     cfgvtwo.Form6.edUserMsg18.Text := cfg.StoredValue['usrMsg15'];
     cfgvtwo.Form6.edUserMsg19.Text := cfg.StoredValue['usrMsg16'];
     cfgvtwo.Form6.edUserMsg20.Text := cfg.StoredValue['usrMsg17'];

     Form1.MenuItem8a.Caption  := cfg.StoredValue['userQRG1'];
     Form1.MenuItem9a.Caption  := cfg.StoredValue['userQRG2'];
     Form1.MenuItem10a.Caption := cfg.StoredValue['userQRG3'];
     Form1.MenuItem11a.Caption := cfg.StoredValue['userQRG4'];
     Form1.MenuItem12a.Caption := cfg.StoredValue['userQRG5'];
     Form1.MenuItem13a.Caption := cfg.StoredValue['userQRG6'];
     Form1.MenuItem14a.Caption := cfg.StoredValue['userQRG7'];
     Form1.MenuItem15a.Caption := cfg.StoredValue['userQRG8'];
     Form1.MenuItem16a.Caption := cfg.StoredValue['userQRG9'];
     Form1.MenuItem17a.Caption := cfg.StoredValue['userQRG10'];
     Form1.MenuItem18a.Caption := cfg.StoredValue['userQRG11'];
     Form1.MenuItem19a.Caption := cfg.StoredValue['userQRG12'];
     Form1.MenuItem20a.Caption := cfg.StoredValue['userQRG13'];

     Form1.MenuItem4b.Caption  := cfg.StoredValue['usrMsg1'];
     Form1.MenuItem5b.Caption  := cfg.StoredValue['usrMsg2'];
     Form1.MenuItem6b.Caption  := cfg.StoredValue['usrMsg3'];
     Form1.MenuItem7b.Caption  := cfg.StoredValue['usrMsg4'];
     Form1.MenuItem8b.Caption  := cfg.StoredValue['usrMsg5'];
     Form1.MenuItem9b.Caption  := cfg.StoredValue['usrMsg6'];
     Form1.MenuItem10b.Caption := cfg.StoredValue['usrMsg7'];
     Form1.MenuItem11b.Caption := cfg.StoredValue['usrMsg8'];
     Form1.MenuItem12b.Caption := cfg.StoredValue['usrMsg9'];
     Form1.MenuItem13b.Caption := cfg.StoredValue['usrMsg10'];
     Form1.MenuItem14b.Caption := cfg.StoredValue['usrMsg11'];
     Form1.MenuItem15b.Caption := cfg.StoredValue['usrMsg12'];
     Form1.MenuItem16b.Caption := cfg.StoredValue['usrMsg13'];
     Form1.MenuItem17b.Caption := cfg.StoredValue['usrMsg14'];
     Form1.MenuItem18b.Caption := cfg.StoredValue['usrMsg15'];
     Form1.MenuItem19b.Caption := cfg.StoredValue['usrMsg16'];
     Form1.MenuItem20b.Caption := cfg.StoredValue['usrMsg17'];

     tstint := 0;
     if TryStrToInt(cfg.StoredValue['binSpace'],tstint) Then Form1.spinDecoderBin.value := tstint else Form1.spinDecoderBin.Value := 3;
     if spinDecoderBin.Value = 1 Then edit3.Text := '20';
     if spinDecoderBin.Value = 2 Then edit3.Text := '50';
     if spinDecoderBin.Value = 3 Then edit3.Text := '100';
     if spinDecoderBin.Value = 4 Then edit3.Text := '200';
     if spinDecoderBin.Value = 1 Then d65.glbinspace := 20;
     if spinDecoderBin.Value = 2 Then d65.glbinspace := 50;
     if spinDecoderBin.Value = 3 Then d65.glbinspace := 100;
     if spinDecoderBin.Value = 4 Then d65.glbinspace := 200;

     tstint := 0;
     if TryStrToInt(cfg.StoredValue['singlerange'],tstint) Then Form1.spinDecoderBW.value := tstint else Form1.spinDecoderBW.Value := 3;
     if spinDecoderBW.Value = 1 Then edit2.Text := '20';
     if spinDecoderBW.Value = 2 Then edit2.Text := '50';
     if spinDecoderBW.Value = 3 Then edit2.Text := '100';
     if spinDecoderBW.Value = 4 Then edit2.Text := '200';

     if spinDecoderBW.Value = 1 Then d65.glDFTolerance := 20;
     if spinDecoderBW.Value = 2 Then d65.glDFTolerance := 50;
     if spinDecoderBW.Value = 3 Then d65.glDFTolerance := 100;
     if spinDecoderBW.Value = 4 Then d65.glDFTolerance := 200;

     if cfg.StoredValue['smooth'] = 'on' Then Form1.cbSmooth.Checked := True else Form1.cbSmooth.Checked := False;
     if Form1.cbSmooth.Checked Then spectrum.specSmooth := True else spectrum.specSmooth := False;
     if cfg.StoredValue['restoreMulti'] = 'on' Then cfgvtwo.Form6.cbRestoreMulti.Checked := True else cfgvtwo.Form6.cbRestoreMulti.Checked := False;
     if cfg.storedValue['useCWID'] = 'y' then cfgvtwo.Form6.cbCWID.Checked := True else cfgvtwo.Form6.cbCWID.Checked := False;
     if cfg.StoredValue['useCATTxDF'] = 'yes' then cfgvtwo.Form6.chkTxDFVFO.Checked := True else cfgvtwo.Form6.chkTxDFVFO.Checked := False;

     if cfg.StoredValue['enAutoQSY1'] = 'yes' then cfgvtwo.Form6.cbEnableQSY1.Checked := True else cfgvtwo.Form6.cbEnableQSY1.Checked := False;
     if cfg.StoredValue['enAutoQSY2'] = 'yes' then cfgvtwo.Form6.cbEnableQSY2.Checked := True else cfgvtwo.Form6.cbEnableQSY2.Checked := False;
     if cfg.StoredValue['enAutoQSY3'] = 'yes' then cfgvtwo.Form6.cbEnableQSY3.Checked := True else cfgvtwo.Form6.cbEnableQSY3.Checked := False;
     if cfg.StoredValue['enAutoQSY4'] = 'yes' then cfgvtwo.Form6.cbEnableQSY4.Checked := True else cfgvtwo.Form6.cbEnableQSY4.Checked := False;
     if cfg.StoredValue['enAutoQSY5'] = 'yes' then cfgvtwo.Form6.cbEnableQSY5.Checked := True else cfgvtwo.Form6.cbEnableQSY5.Checked := False;

     if cfg.StoredValue['autoQSYAT1'] = 'yes' then cfgvtwo.Form6.cbATQSY1.Checked := True else cfgvtwo.Form6.cbATQSY1.Checked := False;
     if cfg.StoredValue['autoQSYAT2'] = 'yes' then cfgvtwo.Form6.cbATQSY2.Checked := True else cfgvtwo.Form6.cbATQSY2.Checked := False;
     if cfg.StoredValue['autoQSYAT3'] = 'yes' then cfgvtwo.Form6.cbATQSY3.Checked := True else cfgvtwo.Form6.cbATQSY3.Checked := False;
     if cfg.StoredValue['autoQSYAT4'] = 'yes' then cfgvtwo.Form6.cbATQSY4.Checked := True else cfgvtwo.Form6.cbATQSY4.Checked := False;
     if cfg.StoredValue['autoQSYAT5'] = 'yes' then cfgvtwo.Form6.cbATQSY5.Checked := True else cfgvtwo.Form6.cbATQSY5.Checked := False;

     cfgvtwo.Form6.edQRGQSY1.Text := cfg.StoredValue['autoQSYQRG1'];
     cfgvtwo.Form6.edQRGQSY2.Text := cfg.StoredValue['autoQSYQRG2'];
     cfgvtwo.Form6.edQRGQSY3.Text := cfg.StoredValue['autoQSYQRG3'];
     cfgvtwo.Form6.edQRGQSY4.Text := cfg.StoredValue['autoQSYQRG4'];
     cfgvtwo.Form6.edQRGQSY5.Text := cfg.StoredValue['autoQSYQRG5'];

     foo := cfg.StoredValue['autoQSYUTC1'];
     if TryStrToInt(cfg.StoredValue['autoQSYUTC1'],ifoo) Then
     Begin
          cfgvtwo.Form6.qsyHour1.Value := StrToInt(foo[1..2]);
          cfgvtwo.Form6.qsyMinute1.Value := StrToInt(foo[3..4]);
     end
     else
     begin
          cfgvtwo.Form6.qsyHour1.Value := 0;
          cfgvtwo.Form6.qsyMinute1.Value := 0;
     end;

     foo := cfg.StoredValue['autoQSYUTC2'];
     if TryStrToInt(cfg.StoredValue['autoQSYUTC2'],ifoo) Then
     Begin
          cfgvtwo.Form6.qsyHour2.Value := StrToInt(foo[1..2]);
          cfgvtwo.Form6.qsyMinute2.Value := StrToInt(foo[3..4]);
     end
     else
     begin
          cfgvtwo.Form6.qsyHour2.Value := 0;
          cfgvtwo.Form6.qsyMinute2.Value := 0;
     end;

     foo := cfg.StoredValue['autoQSYUTC3'];
     if TryStrToInt(cfg.StoredValue['autoQSYUTC3'],ifoo) Then
     Begin
          cfgvtwo.Form6.qsyHour3.Value := StrToInt(foo[1..2]);
          cfgvtwo.Form6.qsyMinute3.Value := StrToInt(foo[3..4]);
     end
     else
     begin
          cfgvtwo.Form6.qsyHour3.Value := 0;
          cfgvtwo.Form6.qsyMinute3.Value := 0;
     end;

     foo := cfg.StoredValue['autoQSYUTC4'];
     if TryStrToInt(cfg.StoredValue['autoQSYUTC4'],ifoo) Then
     Begin
          cfgvtwo.Form6.qsyHour4.Value := StrToInt(foo[1..2]);
          cfgvtwo.Form6.qsyMinute4.Value := StrToInt(foo[3..4]);
     end
     else
     begin
          cfgvtwo.Form6.qsyHour4.Value := 0;
          cfgvtwo.Form6.qsyMinute4.Value := 0;
     end;

     foo := cfg.StoredValue['autoQSYUTC5'];
     if TryStrToInt(cfg.StoredValue['autoQSYUTC5'],ifoo) Then
     Begin
          cfgvtwo.Form6.qsyHour5.Value := StrToInt(foo[1..2]);
          cfgvtwo.Form6.qsyMinute5.Value := StrToInt(foo[3..4]);
     end
     else
     begin
          cfgvtwo.Form6.qsyHour5.Value := 0;
          cfgvtwo.Form6.qsyMinute5.Value := 0;
     end;

     cfgvtwo.Form6.hrdAddress.Text := cfg.StoredValue['hrdAddress'];
     globalData.hrdcatControlcurrentRig.hrdAddress := cfgvtwo.Form6.hrdAddress.Text;
     cfgvtwo.Form6.hrdPort.Text := cfg.StoredValue['hrdPort'];

     tstint := 0;
     If TryStrToInt(cfg.StoredValue['hrdPort'],tstint) Then
     Begin
          cfgvtwo.Form6.hrdPort.Text := cfg.StoredValue['hrdPort'];
          globalData.hrdcatControlcurrentRig.hrdPort := tstint;
     end
     else
     begin
          cfgvtwo.Form6.hrdPort.Text := '7809';
          globalData.hrdcatControlcurrentRig.hrdPort := 7809;
     end;

     if Length(cfg.StoredValue['LogComment'])>0 Then log.Form2.edLogComment.Text := cfg.StoredValue['LogComment'];
     if cfg.StoredValue['divider'] = 'y' then cfgvtwo.Form6.cbDecodeDivider.Checked := true else cfgvtwo.Form6.cbDecodeDivider.Checked := false;
     if cfg.StoredValue['multihalt'] = 'y' then cfgvtwo.Form6.cbMultiAutoEnableHTX.Checked := true else cfgvtwo.Form6.cbMultiAutoEnableHTX.Checked := false;
     if cfgvtwo.Form6.cbMultiAutoEnableHTX.Checked then cfg.StoredValue['multihalt'] := 'y' else cfg.StoredValue['multihalt'] := 'n';
     if cfg.StoredValue['cwidfree'] = 'y' then cfgvtwo.Form6.cbCWIDFT.Checked := true else cfgvtwo.Form6.cbCWIDFT.Checked := false;
     if cfg.StoredValue['dividecompact'] = 'y' then cfgvtwo.Form6.cbDecodeDividerCompact.Checked := true else cfgvtwo.Form6.cbDecodeDividerCompact.Checked := false;
     if cfg.StoredValue['version'] <> verHolder.verReturn Then verUpdate := True else verUpdate := False;
     if cfg.StoredValue['lognotes'] = '0' then log.Form2.CheckBox1.Checked:=true else log.Form2.CheckBox1.Checked:=false;
     ifoo := 0;
     if TryStrToInt(cfg.StoredValue['TXWDCounter'],ifoo) Then cfgvtwo.Form6.SpinTXCount.Value := ifoo else cfgvtwo.Form6.SpinTXCount.Value := 15;
     if cfg.StoredValue['decimalForce1'] = 'y' then cfgvtwo.Form6.CheckBox1.Checked := true else cfgvtwo.Form6.CheckBox1.Checked := false;
     if cfg.StoredValue['decimalForce2'] = 'y' then cfgvtwo.Form6.CheckBox2.Checked := true else cfgvtwo.Form6.CheckBox2.Checked := false;
     if cfgvtwo.Form6.CheckBox1.Checked then globalData.decimalOverride1 := true else globalData.decimalOverride1 := false;
     if cfgvtwo.Form6.CheckBox2.Checked then globalData.decimalOverride2 := true else globalData.decimalOverride2 := false;

     if verUpdate Then
     Begin
          cfgvtwo.glmustConfig := True;
          cfgvtwo.Form6.Show;
          cfgvtwo.Form6.BringToFront;
          repeat
                sleep(10);
                Application.ProcessMessages
          until not cfgvtwo.glmustConfig;
          cfg.StoredValue['version'] := verHolder.verReturn;
          saveConfig;
          ShowMessage('You can resize the main window! (Taller or shorter.)');
          ShowMessage('Please confirm values for Single and Multiple decoder BW' + sLineBreak +
                      'In some cases those will read 200 Hertz after update and' + sLineBreak +
                      'this may not be what you want.  Suggest 100 Hertz (or less)');
          dlog.fileDebug('Ran configuration update.');
     End;

     globalData.mtext := '/Multi%20On%202K%20BW';

     //With wisdom comes speed.
     d65.glfftFWisdom := 0;
     d65.glfftSWisdom := 0;
     if not cfgvtwo.Form6.chkNoOptFFT.Checked Then
     Begin
          fname := TrimFileName(GetAppConfigDir(False) + PathDelim + 'wisdom2.dat');
          if FileExists(fname) Then
          Begin
               // I have data for FFTW_MEASURE metrics use ical settings in
               // decode65 for measure.
               d65.glfftFWisdom := 1;  // Causes measure wisdom to be loaded on first pass of decode65
               d65.glfftSWisdom := 11; // uses measure wisdom (no load/no save) on != first pass of decode65
               dlog.fileDebug('Imported FFTW3 Wisdom.');
          End
          Else
          Begin
               dlog.fileDebug('FFT Wisdom missing... you should run optfft');
          End;
     End
     Else
     Begin
          d65.glfftFWisdom := 0;
          d65.glfftSWisdom := 0;
          dlog.fileDebug('Running without optimal FFT enabled by user request.');
     End;

     // Setup input/output devices
     // Translate strings to PA integer device ID for selected and default devices.
     foo  := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     Label23.Caption := foo;
     ain  := StrToInt(foo[1..2]);

     foo  := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     Label30.Caption := foo;
     aout := StrToInt(foo[1..2]);

     din  := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultInputDevice;
     dout := portaudio.Pa_GetHostApiInfo(paDefApi)^.defaultOutputDevice;
     // Call audio setup
     cont := False;
     cont := SetAudio(ain, aout);
     // If failure then attempt to work with default devices.
     if not cont then
     begin
          if (ain=din) and (aout=dout) then
          Begin
               // Default is already selected.  No need to try again.  Warn user and halt.
               ShowMessage('Previously selected input and/or output device' + sLineBreak +
                           'unavailable.  Attempt to use default devices failed' + sLineBreak +
                           'as well.  Please check that your sound device is' + sLineBreak +
                           'properly connected and any necessary cable(s) attached.' + sLineBreak + sLineBreak +
                           'Program will now end.  Please try again after checking' + sLineBreak +
                           'sound hardware.');
               halt;
          end;
          cont := false;
          cont := SetAudio(din, dout);
          if cont then
          begin
               // Defaults opened, warn user
               ShowMessage('WARNING! The previously selected input and/or output' + sLineBreak +
                           'device is unavailable.' + sLineBreak + sLineBreak +
                           'JT65-HF is currently using the default input and output' + sLineBreak +
                           'devices.  Please check that your sound device is properly' + sLineBreak +
                           'connected and any necessary cable(s) attached.' + sLineBreak + sLineBreak +
                           'THE DEFAULT DEVICES MAY NOT BE THE DEVICE YOU WISH TO USE!');
               Label23.Caption := 'Default Input Device';
               Label30.Caption := 'Default Output Device';
          end
          else
          begin
               // Default failed, warn user and halt.
               ShowMessage('Previously selected input and/or output device' + sLineBreak +
                           'unavailable.  Attempt to use default devices failed' + sLineBreak +
                           'as well.  Please check that your sound device is' + sLineBreak +
                           'properly connected and any necessary cable(s) attached.' + sLineBreak + sLineBreak +
                           'Program will now end.  Please try again after checking' + sLineBreak +
                           'sound hardware.');
               halt;
          end;
     end;

     // Check callsign and grid for validity.
     cont := False;
     // Verify callsign meets the JT65 protocol requirements.
     if ValidateCallsign(cfgvtwo.glmycall) then cont := true else cont := false;
     // Verify grid is a valid 4 or 6 character value
     if ValidateGrid(cfgvtwo.Form6.edMyGrid.Text) and cont then cont := true else cont := false;
     if cont then
     begin
          // Call and grid is good, enable TX, RB and PSKR functions as desired by end user.
          Form1.cbEnRB.Enabled := True;
          Form1.cbEnPSKR.Enabled := True;
          globalData.canTX := True;
     end
     else
     begin
          // Callsign and/or grid is invalid.  RB, PSKR and TX is disabled.
          Form1.cbEnRB.Checked := False;
          Form1.cbEnRB.Enabled := False;
          Form1.cbEnPSKR.Checked := False;
          Form1.cbEnPSKR.Enabled := False;
          globalData.canTX := False;
          if not ValidateCallsign(cfgvtwo.glmycall) then
          begin
               foo := 'Callsign entered does not meet the requirements' + sLineBreak +
                      'of the JT65 protocol.  Please check for common' + sLineBreak +
                      'errors such a typographical error or using a slashed' + sLineBreak +
                      'zero in place of a real ASCII 0.  Transmit, RB and ' + sLineBreak +
                      'PSK Reporter functions are disabled.  If you feel the' + sLineBreak +
                      'evaluation of your callsign is in error then notify' + sLineBreak +
                      'W6CQZ via the JT65-HF support group.';
               showmessage(foo);
          end;
          if not ValidateGrid(cfgvtwo.Form6.edMyGrid.Text) then
          begin
               foo := 'Maidenhead Grid square does not meet the requirements' + sLineBreak +
                      'of the JT65 protocol.  Please check for common' + sLineBreak +
                      'errors such a typographical error or using a slashed' + sLineBreak +
                      'zero in place of a real ASCII 0.  Transmit, RB and ' + sLineBreak +
                      'PSK Reporter functions are disabled.  If you feel the' + sLineBreak +
                      'evaluation of your grid is in error then notify' + sLineBreak +
                      'W6CQZ via the JT65-HF support group.';
               showmessage(foo);
          end;
     end;
     // Create the decoder thread with param False so it starts.
     d65.glinProg := False;
     decoderThread := decodeThread.Create(False);

     // Create the CAT control thread with param False so it starts.
     rigThread := catThread.Create(False);

     // Create the RB thread with param False so it starts.
     cfgvtwo.glrbcLogin := False;
     cfgvtwo.glrbcLogout := False;
     rbcPing := False;
     rbThread := rbcThread.Create(False);
End;

function TForm1.SetAudio(auin : Integer; auout : Integer) : Boolean;
Var
   cont, ingood, outgood : Boolean;
Begin
     ingood  := false;
     outgood := false;
     // Setup input device
     dlog.fileDebug('Setting up ADC/DAC.  ADC:  ' + IntToStr(auin) + ' DAC:  ' + IntToStr(auout));
     // Set parameters before call to start
     // Input
     paInParams.channelCount := 2;
     paInParams.device := auin;
     paInParams.sampleFormat := paInt16;
     paInParams.suggestedLatency := 1;
     paInParams.hostApiSpecificStreamInfo := Nil;
     ppaInParams := @paInParams;
     // Set rxBuffer index to start of array.
     adc.d65rxBufferIdx := 0;
     adc.adcT := 0;
     // Set ptr to start of buffer.
     adc.d65rxBufferPtr := @adc.d65rxBuffer[0];
     // output
     paOutParams.channelCount := 2;
     paOutParams.device := auout;
     paOutParams.sampleFormat := paInt16;
     paOutParams.suggestedLatency := 1;
     paOutParams.hostApiSpecificStreamInfo := Nil;
     ppaOutParams := @paOutParams;
     // Set txBuffer index to start of array.
     dac.d65txBufferIdx := 0;
     // Set ptr to start of buffer.
     //dac.d65txBufferPtr := @dac.d65txBuffer[0];
     dac.dacT := 0;
     // Attempt to open selected devices, both must pass open/start to continue.
     result := false;
     cont := False;
     // Initialize rx stream.
     paResult := portaudio.Pa_OpenStream(paInStream,ppaInParams,Nil,11025,2048,0,@adc.adcCallback,Pointer(Self));
     if paResult <> 0 Then
     Begin
          // Was unable to open.
          cont   := false;
          result := false;
          ingood := false;
     end
     else
     begin
          cont   := true;
          result := true;
          ingood := true;
     end;
     If cont then
     begin
          cont := false;
          // Start the stream.
          paResult := portaudio.Pa_StartStream(paInStream);
          if paResult <> 0 Then
          Begin
               // Was unable to start stream.
               cont   := false;
               result := false;
               ingood := false;
          End
          Else
          Begin
               cont   := True;
               result := true;
               ingood := true;
          end;
     end;
     // If input opened properly then on to output
     if cont then
     begin
          cont := False;
          // Initialize tx stream.
          paResult := portaudio.Pa_OpenStream(paOutStream,Nil,ppaOutParams,11025,2048,0,@dac.dacCallback,Pointer(Self));
          if paResult <> 0 Then
          Begin
               // Selected output device fails.
               cont    := False;
               result  := false;
               outgood := false;
          end
          Else
          Begin
               // Open was good, on to start.
               cont    := True;
               result  := True;
               outgood := True;
          end;
          if cont then
          begin
               // Start the stream.
               paResult := portaudio.Pa_StartStream(paOutStream);
               if paResult <> 0 Then
               Begin
                    // Start stream fails.
                    cont    := false;
                    result  := false;
                    outgood := false;
               End
               else
               begin
                    // Good to go
                    cont    := true;
                    result  := true;
                    outgood := true;
               end;
          end;
     end;
     if ingood and outgood then
     begin
          result := true;
     end
     else
     begin
          // Attempt to dereference any opened/started streams.
          paResult := portaudio.Pa_AbortStream(paInStream);
          paResult := portaudio.Pa_CloseStream(paInStream);
          paResult := portaudio.Pa_AbortStream(paOutStream);
          paResult := portaudio.Pa_CloseStream(paOutStream);
          result := false;
     end;

end;

function  TForm1.ValidateGrid(const grid : String) : Boolean;
var
     valid    : Boolean;
     testGrid : String;
begin
     valid := True;
     testGrid := trimleft(trimright(grid));
     testGrid := upcase(testGrid);
     if (length(testGrid) < 4) or (length(testGrid) > 6) or (length(testGrid) = 5) then
     begin
          valid := False;
     end
     else
     begin
          valid := True;
     end;
     if valid then
     begin
          // Validate grid
          // Grid format:
          // Length = 4 or 6
          // characters 1 and 2 range of A ... R, upper case, alpha only.
          // characters 3 and 4 range of 0 ... 9, numeric only.
          // characters 5 and 6 range of a ... x, lower case, alpha only, optional.
          // Validate grid
          if length(testGrid) = 6 then
          begin
               testGrid[1] := upcase(testGrid[1]);
               testGrid[2] := upcase(testGrid[2]);
               testGrid[5] := lowercase(testGrid[5]);
               testGrid[6] := lowercase(testGrid[6]);
               valid := false;
               case testGrid[1] of 'A'..'R': valid := True else valid := False; end;
               if valid then case testGrid[2] of 'A'..'R': valid := True else valid := False; end;
               if valid then case testGrid[3] of '0'..'9': valid := True else valid := False; end;
               if valid then case testGrid[4] of '0'..'9': valid := True else valid := False; end;
               if valid then case testGrid[5] of 'a'..'x': valid := True else valid := False; end;
               if valid then case testGrid[6] of 'a'..'x': valid := True else valid := False; end;
          end
          else
          begin
               testGrid[1] := upcase(testGrid[1]);
               testGrid[2] := upcase(testGrid[2]);
               valid := false;
               case testGrid[1] of 'A'..'R': valid := True else valid := False; end;
               if valid then case testGrid[2] of 'A'..'R': valid := True else valid := False; end;
               if valid then case testGrid[3] of '0'..'9': valid := True else valid := False; end;
               if valid then case testGrid[4] of '0'..'9': valid := True else valid := False; end;
          end;
     End;
     result := valid;
end;

Function TForm1.ValidateSlashedCallsign(csign : String) : Boolean;
Var
     subword1, subword2 : String;
     i                  : Integer;
     cont, havecall1    : Boolean;
     havecall2          : Boolean;
     havepfx, havesfx   : Boolean;
Begin
     // Attempts to validate a callsign with prefix or suffix by breaking "full"
     // callsign into two parts bounded by / character.  Then looks at subwords
     // testing for parts being either VALID prefix / VALID callsign or VALID callsign / VALID suffix
     // Those are the only two valid options, anything else fails the test by it the
     // callsign, prefix or suffix that is invalid.
     // In this case word2 contains a /.  Need to extract the callsign,
     // validate then validate the prefix or suffix.

     // First of all the string passed in must contain a / character.
     If (AnsiContainsText(csign,'/')) Then cont := true else cont := false;
     If cont then
     begin
          // Break word2 into subword1 and subword2
          subword1  := ExtractWord(1,csign,['/']);
          subword2  := ExtractWord(2,csign,['/']);
          cont      := False;
          havepfx  := False;
          havesfx  := False;
          havecall1 := False;
          havecall2 := False;

          // Test subword1 and subword2 for validity as callsign
          If ValidateCallsign(subword1) then havecall1 := true else havecall1 := false;
          If ValidateCallsign(subword2) then havecall2 := true else havecall2 := false;
          // Test for one of the subwords being a valid callsign, if so move along - if not bail.
          if havecall1 or havecall2 then cont := true else cont := false;
          // Test for prefix/suffix validity if test aboves passed.
          if cont then
          begin
               cont := false;
               // If havecall1 then it must be a suffix in subword2
               // So test subword2 for validity as suffix
               // Do this using encode65.e65sfx[] array which holds all the valid suffix values
               if havecall1 then
               begin
                    for i := 0 to length(encode65.e65sfx)-1 do
                    begin
                         if subword2 = encode65.e65sfx[i] then
                         begin
                              havesfx := true;
                              break;
                         end;
                    end;
               end;

               // If havecall2 then it must be a prefix in subword1
               // So test subword1 for validity as prefix
               // Do this using encode65.e65pfx[] array which holds all the valid prefix values
               if havecall2 then
               begin
                    for i := 0 to length(encode65.e65pfx)-1 do
                    begin
                         if subword1 = encode65.e65pfx[i] then
                         begin
                              havepfx := true;
                              break;
                         end;
                    end;
               end;

               // Now, I must have havepfx and havecall2 or havecall1 and havesfx to continue.
               cont := False;
               if havecall1 and havesfx then cont := true;
               if havepfx and havecall2 then cont := true;
               // OK... maybe I have this right now.
               if cont then result := true else result := false;
          end
          else
          begin
               // Neither subword is a valid callsign.
               Result := False;
          end;

     end
     else
     begin
          // String passed in has no / present.
          result := False;
     end;
end;

Function TForm1.ValidateCallsign(csign : String) : Boolean;
var
     valid    : Boolean;
     testcall : String;
Begin
     valid := True;
     result := False;
     testcall := csign;
     // Simple length check
     if (length(testcall) < 3) or (length(testcall) > 6) then valid := False else valid := True;
     // Not too short or too long, now test for presence of 'bad' characters.
     if valid then
     begin
          If (AnsiContainsText(testcall,'/')) Or (AnsiContainsText(testcall,'.')) Or
             (AnsiContainsText(testcall,'-')) Or (AnsiContainsText(testcall,'\')) Or
             (AnsiContainsText(testcall,',')) Or (AnsiContainsText(testcall,' ')) Then valid := False else valid := true;
     end;
     // If length and bad character checks pass on to the full validator
     if valid then
     begin
          valid := False;
          // Callsign rules:
          // Length must be >= 3 and <= 6
          // Must be of one of the following;
          // A = Alpha character A ... Z
          // # = Numeral 0 ... 9
          //
          // A#A A#AA A#AAA or AA#A AA#AA AA#AAA or #A#A #A#AA #A#AAA or
          // A##A A##AA A##AAA
          //
          // All characters must be A...Z or 0...9 or space
          if length(testCall) = 3 Then
          Begin
               // 3 Character callsigns have only one valid format: A#A
               valid := False;
               case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
               if valid then
               begin
                    case testcall[2] of '0'..'9': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
               end;
               //if not valid then
               //begin
               //     if testcall = 'SWL' then valid := true else valid := false;
               //end;
          End;
          if length(testCall) = 4 Then
          Begin
               // 4 Character callsigns can be:  A#AA AA#A #A#A A##A
               // Testing for A#AA
               valid := False;
               case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
               if valid then
               begin
                    case testcall[2] of '0'..'9': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
               end;
               // Testing for AA#A (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
               // Testing for #A#A (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of '0'..'9': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
               // Testing for A##A (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
          End;
          if length(testCall) = 5 Then
          Begin
               // 5 Character callsigns can be:  A#AAA AA#AA #A#AA A##AA
               // Testing for A#AAA
               valid := False;
               case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
               if valid then
               begin
                    case testcall[2] of '0'..'9': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
               end;
               // Testing for AA#AA (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
               // Testing for #A#AA (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of '0'..'9': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
               // Testing for A##AA (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
          End;
          if length(testCall) = 6 Then
          Begin
               // 6 Character callsigns can be:  AA#AAA #A#AAA A##AAA
               // Testing for AA#AAA
               valid := False;
               case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
               if valid then
               begin
                    case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[3] of '0'..'9': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
               end;
               if valid then
               begin
                    case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
               end;
               // Testing for #A#AAA (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of '0'..'9': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
               // Testing for A##AAA (if test above didn't return true)
               if not valid then
               begin
                    case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                    if valid then
                    begin
                         case testcall[2] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[3] of '0'..'9': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                    end;
                    if valid then
                    begin
                         case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
                    end;
               end;
          End;
          // All possible 3, 4, 5 and 6 character length callsigns have been tested
          // for conformance to JT65 callsign encoding rules.  If valid = true we're
          // good to go.  Of course, you can still specify a callsign that is not
          // 'real', but, which conforms to the encoding rules...  I make no attempt
          // to validate a callsign to be something that is valid/legal.  Only that it
          // conforms to the encoder rules.
     end;
     result := valid;
end;

procedure TForm1.updateSR();
Var
   errthresh, sr, aerr, derr, erate : CTypes.cdouble;
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
     haveRXSRerr := False;
     haveTXSRerr := False;
     If cfgvtwo.glautoSR Then errThresh := 0.0001 Else errThresh := 0.0005;
     If (adError = 0) and (thisAction > 1) Then rxsrs := '';
     If (adError = 0) and (thisAction = 1) Then rxsrs := '';
     If adcErate <> 0 Then
     Begin
          if adCount = 0 Then adCount := 1;
          if adLErate <> adcErate Then
          Begin
               // New error rate available.
               if (adcErate < 100) And (adcErate > -100) Then
               Begin
                    adAErate := adAErate + adcErate;
                    adLErate := adcErate;
                    inc(adCount);
                    adError := adAErate / adCount;
                    if adCount >=50 Then
                    Begin
                         adCount := 1;
                         adAErate := adError;
                    End;
               End;
          End;
          rxsrs := 'RX SR:  ' + FormatFloat('0.0000',adError);
          sr := 1.0;
          if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then
             sr := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text)
          else
             sr := 1.0;
          aErr := adError-sr;
          if (aErr > (0.0+errThresh)) or (aErr < (0.0-0.0005)) Then
          Begin
               if cfgvtwo.glautoSR Then cfgvtwo.Form6.edRXSRCor.Text := FormatFloat('0.0000',adError);
               haveRXSRerr := True;
          End
          Else
          Begin
               haveRXSRerr := False;
          End;
     End;
     // Update TX Sample Error Rate display.
     If (dErrError = 0) and (thisAction > 1) Then txsrs := '';
     If (dErrError = 0) and (thisAction = 1) Then txsrs := '';
     if paOutParams.channelCount = 2 then erate := dac.dacErate;
     If erate <> 0 Then
     Begin
          if dErrCount = 0 Then dErrCount := 1;
          if dErrLErate <> erate Then
          Begin
               // New error rate available.
               if (erate < 100) And (erate > -100) Then
               Begin
                    dErrAErate := dErrAErate + erate;
                    dErrLErate := erate;
                    inc(dErrCount);
                    dErrError := dErrAErate / dErrCount;
                    if dErrCount >=50 Then
                    Begin
                         dErrCount := 1;
                         dErrAErate := dErrError;
                    End;
               End;
          End;
          txsrs := 'TX SR:  ' + FormatFloat('0.0000',dErrError);
          sr := 1.0;
          if tryStrToFloat(cfgvtwo.Form6.edTXSRCor.Text,sr) Then
             sr := StrToFloat(cfgvtwo.Form6.edTXSRCor.Text)
          else
             sr := 1.0;
          dErr := dErrError-sr;
          if (dErr > (0.0+errThresh)) or (dErr < (0.0-errThresh)) Then
          Begin
               if cfgvtwo.glautoSR Then cfgvtwo.Form6.edTXSRCor.Text := FormatFloat('0.0000',dErrError);
               haveTXSRerr := True;
          End
          Else
          Begin
               haveTXSRerr := False;
          End;
     End;
     sr := 1.0;
     if tryStrToFloat(cfgvtwo.Form6.edRXSRCor.Text,sr) Then
        globalData.d65samfacin := StrToFloat(cfgvtwo.Form6.edRXSRCor.Text)
     else
        globalData.d65samfacin := 1.0;
End;

procedure TForm1.genTX1();
Var
   txdf, nwave, i    : CTypes.cint;
   txsr, freqcw      : CTypes.cdouble;
   d65sending        : PChar;
   d65txmsg          : PChar;
   ditsb             : Array Of CTypes.cint8;
   pditsb            : CTypes.pcint8;
   dits              : CTypes.cint;
   pdits             : CTypes.pcint;
   fblocks           : CTypes.cfloat;
   iblocks           : Integer;
   d65nwave, d65nmsg : CTypes.cint;
   d65sendingsh      : CTypes.cint;
   cwidMsg           : PChar;
   txBuffer          : Array of CTypes.cint16;
   cwidb             : Array of CTypes.cint16;
   pcwidb            : CTypes.pcint16;
   ptxBuffer         : CTypes.pcint16;
   foo1, foo2        : String;
   txsamps           : Integer;
   cont, doLCWID     : Boolean;

Begin
     // Generate TX samples for a normal TX Cycle.
     // curMsg holds text to TX

     // A JT65 TX sequence runs 46.8 Seconds starting at 1 second into
     // minute, ending at 47.8 seconds.  Here I will raise PTT at second
     // = 0.  By adding 1 second lead in silence I will have a total TX
     // buffer length of 1 second silence + 46.8 seconds of data.

     // Frame times
     // Lead in silence 11025 samples
     // Data 126*4096 samples = 516096
     // Lead out silence to CW ID 5512 samples
     // CW ID 0 to max 110250 samples
     // Lead out silence to PTT off 5512 samples
     // Maximum frame = 11025 + 516096 + 5512 + 110250 + 5512 = 648395 = 58.811337868 seconds.
     // Minimum frame = 11025 + 516096 + 5512 + 0 + 5512 = 538145 = 48.811337868 seconds.
     // DAC Callback works in 2048 sample blocks.
     // Maximum frame = 648395/2048 = Int(317) blocks = 649216 samples = 58.885804989 seconds.
     // Minimum frame = 538145/2048 = Int(263) blocks = 538624 samples = 48.854784580 seconds.
     //
     // One 2K sample block = time of 0.185759637 second.

     // So... with TX assert at second = 0 then 1 second silence then
     // 46.811428571 seconds data then .5 second silence then (max) 10
     // seconds CW ID and ending with .5 second silence I have the worst
     // case length of 58.9 seconds before EOT.

     // Temporary buffer to hold generated JT65a tones.
     SetLength(txBuffer,661504);
     // Temporary buffer used to validate CW ID
     SetLength(ditsB,460);
     // Temporary buffer to hold generated CW ID tones.
     SetLength(cwidb,110250);

     // PChar setup for message, message generated and CW ID
     d65sending := StrAlloc(28);
     d65txmsg   := StrAlloc(28);
     cwidMsg    := StrAlloc(22);

     // Clear sample and other buffers
     for i := 0 to length(txBuffer)-1 do txBuffer[i] := 0;
     for i := 0 to length(dac.d65txBuffer)-1 do dac.d65txBuffer[i] := 0;
     for i := 0 to length(cwidb)-1 do cwidb[i] := 0;
     for i := 0 to length(ditsb)-1 do ditsb[i] := 0;

     // Pointer for JT65 signal sample buffer
     ptxBuffer := @txBuffer[0];
     // Pointer for "dits" buffer
     pditsb := @ditsb[0];
     // Pointer for CW ID sample buffer
     pcwidb := @cwidb[0];


     // Insure all PChar strings are clear
     for i := 0 to 27 do d65sending[i] := ' ';
     for i := 0 to 27 do d65TXMsg[i]   := ' ';
     for i := 0 to 21 do cwidMsg[i]    := ' ';

     // Select message input buffer to use
     if useBuffer = 0 Then
     Begin
          curMsg := UpCase(padRight(Form1.edMsg.Text,22));
          if doCWID and cfgvtwo.Form6.cbCWID.Checked Then doCWID := True else doCWID := false;
     End;
     if useBuffer = 1 Then
     Begin
          curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
          if cfgvtwo.Form6.cbCWID.Checked or cfgvtwo.Form6.cbCWIDFT.Checked Then doCWID := True else doCWID := false;
     End;

     // eot will hold the index to last sample for TX inclusive of all lead in, data, CW ID and lead out.
     // txsamps holds index to last sample in output buffer as I stich together the lead in, data, cw id and lead out samples
     // into a unified buffer (dac.d65txBuffer)

     eot     := 0;
     txsamps := 0;


     // Check for valid message and generate TX samples if so into txBuffer[]
     if Length(TrimLeft(TrimRight(curMsg)))>1 Then
     Begin
          cont := true;
          StrPCopy(d65txmsg, curMsg);
          d65.glmode65 := 1;
          txdf := 0;
          txdf := Form1.spinTXCF.Value;
          d65nwave := 0;
          d65sendingsh := -1;
          d65nmsg := 0;
          txsr := 1.0;
          //if tryStrToFloat(cfgvtwo.Form6.edTXSRCor.Text,txsr) Then d65samfacout := StrToFloat(cfgvtwo.Form6.edTXSRCor.Text) else d65samfacout := 1.0;
          {TODO Fix TX SR adjustment}

          // Generate JT65a frame samples into txBuffer[] taking note that gen65 adds 5512 silence samples at buffer end.
          if (paOutParams.channelCount = 2) And (txMode = 65) then encode65.gen65(d65txmsg,@txdf,ptxBuffer,@d65nwave,@d65sendingsh,d65sending,@d65nmsg);

          //if (paOutParams.channelCount = 2) And (txMode = 65) then encode65.gen65(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);
          //if txMode =  4 Then  encode65.gen4(d65txmsg,@txdf,@dac.d65txBuffer[0],@d65nwave,@d65sendingsh,d65sending,@d65nmsg);

          // Compare message requested for TX to actual message that will be TX
          foo1 := '';
          foo2 := '';
          for i := 1 to d65nmsg do
          begin
               foo1 := foo1 + d65TXMsg[i-1];
               foo2 := foo2 + d65Sending[i-1];
          end;

          if (foo1 = foo2) Then
          Begin
               // Input message same as output
               //sleep(100);
          end
          else
          begin
               // Input message NOT same as output
               cont := False;
               sleep(100);
          end;
     End
     Else
     Begin
          // Message to TX too short -- not valid.
          cont := false;
     End;

     // Data sample in txBuffer[] with no lead in.  Dealing with CW ID now.

     // Determine if CW ID can happen
     // procedure morse(msg, buffer, dits : Pointer); cdecl; external JT_DLL name 'morse_';
     // msg is pchar string with text to send padded to 22 characters
     // buffer is int16 buffer holding dits/dashes 460 elements.
     // dits is integer reutrning last element in buffer

     StrPCopy(cwidMsg,UpCase(padRight(globalData.fullcall,22))); // this is msg
     dits   := 0;
     nwave  := 0;
     pdits  := @dits;
     morse(cwidMsg, pditsb, pdits);

     // Length of samples for this CW ID will be
     // dits * tdit/dt where
     // tdit = 1.2/25.0 (25 WPM Morse)
     // dt   = 1.0/11025.0
     // tdit = 0.048
     // dt   = 0.000090703
     // tdit/dt = 529.19969571
     // Length of samples = dits * 529.19969571

     nwave  := Trunc(dits * 529.19969571);

     if nwave > 110250 then doLCWID := False else doLCWID := true;  // Length of CW ID exceeds maximum of 10 seconds (110250 samples)

     if doLCWID then
     begin
          // Generate CW ID
          StrPCopy(cwidMsg,UpCase(padRight(globalData.fullcall,22)));
          // DF of CW ID is -50 Hz from TxDF but never less than 200 Hz or greater than 2270 Hz.
          if txdf < 0 Then freqcw := (1270-abs(txdf))-50;
          if txdf > 0 Then freqcw := (1270+txdf)-50;
          if txdf = 0 Then freqcw := 1220.0;
          if freqcw < 200.0 then freqcw := 200.0;
          if freqcw > 2270.0 then freqcw := 2270.0;
          // DF of CW ID set and CW ID message set so make it happen.
          nwave := 0;
          genCW(cwidMsg,@freqcw,pcwidb,@nwave);
          // Clear from nwave to end of CW ID buffer
          for i := nwave to length(cwidb)-1 do cwidb[i] := 0;
     end;

     // Disable CW ID if tests above say no go.
     if not doLCWID then doCWID := False;

     // OK...  Now I have data samples in txBuffer[] and CW ID in cwidb[]
     // If I'm good to go then stich them together with appropriate lead in
     // and gaps/lead out added.

     if cont then
     begin
          // cont is set so message to send has been generated and is ready.

          // Need to investigate -- but no need for lead in -- with it TX starts
          // at second = ~2
          // I need to damn well understand why.

          // Start with 11025 samples of silence lead in
          //for i := 0 to 11024 do dac.d65txBuffer[i] := 0;
          //txsamps := i;

          // Add data from txBuff[0..4096*126]
          for i := 0 to 516095 do
          begin
               dac.d65txBuffer[txsamps] := txBuffer[i];
               inc(txsamps);
          end;

          // This will be lead out or gap to CW ID (.5 second silence)
          for i := 0 to 5511 do
          begin
               dac.d65txBuffer[txsamps] := 0;
               inc(txsamps);
          end;

          // If no CW ID then this really is eot :)
          eot := txsamps;

          // Handle CW ID if needed
          if doCWID then
          begin
               // CW ID generator sets nwave to length of CW ID tones.
               for i := 0 to nwave-1 do
               begin
                    dac.d65txBuffer[txsamps] := cwidb[i];
                    inc(txsamps);
               end;
          end;

          // Final lead out silence (.5 second)
          for i := 0 to 5511 do
          begin
               dac.d65txBuffer[txsamps] := 0;
               inc(txsamps);
          end;

          // Update eot
          eot := txsamps;

          // Clear to end of TX sample buffer.
          for i := txsamps to length(dac.d65txBuffer)-1 do dac.d65txBuffer[i] := 0;

          // Now round up eot to the next HIGHEST 2K block as the DAC callback
          // works in 2K blocks :)
          fblocks := eot/2048.0;
          iblocks := Trunc(fblocks)+1;

          // eot now set such that it's on a block boundary.
          eot := iblocks*2048+1;

          if doCWID Then doCWID := False;  // Reset doCWID so it can be set as needed for next frame -- this one is handled :)

          // Message is ready to TX
          TxValid := True;
          TxDirty := False;
          thisTX := curMsg + IntToStr(txdf);
          if lastTX <> thisTX Then
          Begin
               txCount := 1;
               lastTX := thisTX;
          End
          Else
          Begin
               inc(txCount);
          End;
          thisAction := 3;
          actionSet := True;
     end
     else
     begin
          // Message invalid NO TX will take place.
          globalData.txInProgress := False;
          rxInProgress := False;
          form1.chkEnTX.Checked := False;
          TxValid := False;
          TxDirty := True;
          thisAction := 2;
          lastTX := '';
          actionSet := False;
          eot := 0;
     end;

     // Clean up temporary arrays and PChar variables
     SetLength(txBuffer,0);
     SetLength(ditsB,0);
     SetLength(cwidb,0);
     d65sending := StrAlloc(0);
     d65txmsg   := StrAlloc(0);
     cwidMsg    := StrAlloc(0);
End;

procedure TForm1.audioChange();
Var
   foo       : String;
   pin, pout : Integer;
   ain, aout : Integer;
Begin
     // Preserve former in/out devices in case switch fails.
     pin  := paInParams.device;
     pout := paOutParams.device;
     // Stop timer while changing over
     timer1.Enabled := false;
     // Need to change audio input device
     paResult := portaudio.Pa_AbortStream(paInStream);
     paResult := portaudio.Pa_CloseStream(paInStream);
     foo := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     ain := StrToInt(foo[1..2]);
     // Need to change audio output device
     paResult := portaudio.Pa_AbortStream(paOutStream);
     paResult := portaudio.Pa_CloseStream(paOutStream);
     foo := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     aout := StrToInt(foo[1..2]);
     if not SetAudio(ain, aout) then
     begin
          // Failed to open new devices, notify and attempt to return to former devices.
          ShowMessage('The audio device(s) selected failed to open.' + sLineBreak + sLineBreak +
                      'Attempting to re-open previously selected devices.');
          if not SetAudio(pin, pout) then
          begin
               // Failed to revert.  Hopeless situation.
               ShowMessage('The audio device(s) selected failed to open.' + sLineBreak + sLineBreak +
                           'Attempt to re-open previously selected devices.' + sLineBreak +
                           'failed.  Program must exit.');
               halt;
          end;
     end
     else
     begin
          // Switch was good save configuration.
          saveConfig;
     end;
     cfgvtwo.gld65AudioChange := False;
     Label23.Caption := cfgvtwo.Form6.cbAudioIn.Items.Strings[cfgvtwo.Form6.cbAudioIn.ItemIndex];
     Label30.Caption := cfgvtwo.Form6.cbAudioOut.Items.Strings[cfgvtwo.Form6.cbAudioOut.ItemIndex];
     timer1.Enabled := true;
End;

procedure TForm1.myCallCheck();
Begin
     if cfgvtwo.glCallChange Then
     Begin
          if (cfgvtwo.Form6.comboPrefix.ItemIndex > 0) And (cfgvtwo.Form6.comboSuffix.ItemIndex > 0) Then cfgvtwo.Form6.comboSuffix.ItemIndex := 0;
          if cfgvtwo.Form6.comboPrefix.ItemIndex > 0 then mnHavePrefix := True else mnHavePrefix := False;
          if cfgvtwo.Form6.comboSuffix.ItemIndex > 0 then mnHaveSuffix := True else mnHaveSuffix := False;
          cfgvtwo.Form6.edMyCall.Text := cfgvtwo.glmycall;
          if mnHavePrefix or mnHaveSuffix Then
          Begin
               if mnHavePrefix then globalData.fullcall := cfgvtwo.Form6.comboPrefix.Items[cfgvtwo.Form6.comboPrefix.ItemIndex] + '/' + cfgvtwo.glmycall;
               if mnHaveSuffix then globalData.fullcall := cfgvtwo.glmycall + '/' + cfgvtwo.Form6.comboSuffix.Items[cfgvtwo.Form6.comboSuffix.ItemIndex];
          End
          Else
          Begin
               globalData.fullcall := cfgvtwo.glmycall;
          End;
     End;
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

     if valTX then
     Begin
          // First test for Grid validity
          if not ValidateGrid(cfgvtwo.Form6.edMyGrid.Text) then valTX := false;
          if valTX Then
          Begin
               // Test for Callsign validity
               if ansicontainstext(globalData.fullcall,'/') Then
               Begin
                    if not ValidateSlashedCallsign(globalData.fullcall) then valTX := False;
               end
               else
               begin
                    if not ValidateCallsign(globalData.fullcall) then valTX := False;
               end;
          end;
     end;

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
   nst : TSystemTime;
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
     //         end of TX and start of next cycle.
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
               adc.d65rxBufferIdx := 0;

               nextAction := 2; // As always, RX assumed to be next.
               inc(rxCount);
               if watchMulti and cfgvtwo.Form6.cbMultiAutoEnable.Checked and (rxCount > 2) Then
               Begin
                    rxCount := 0;
                    watchMulti := False;
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
               if paInParams.channelCount = 2 Then Form1.ProgressBar3.Position := adc.d65rxBufferIdx;

               rxInProgress := True;
               globalData.txInProgress := False;

               if paInParams.channelCount = 2 Then
               Begin
                    If adc.d65rxBufferIdx >= 533504 Then
                    Begin
                         // Get End of Period QRG
                         eopQRG := globalData.gqrg;
                         teopQRG := globalData.strqrg;
                         // Switch to decoder action
                         thisAction := 4;
                         rxInProgress := False;
                         globalData.txInProgress := False;
                    End;
               end;
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
               if not cfgvtwo.Form6.cbTXWatchDog.Checked Then txCount := 0;
               if cfgvtwo.Form6.SpinTXCount.Value < 2 then txCount := 0;
               if cfgvtwo.Form6.SpinTXCount.Value > 30 then cfgvtwo.Form6.SpinTXCount.Value := 30;
               if txCount < cfgvtwo.Form6.SpinTXCount.Value Then
               Begin
                    // Flag TX Buffer as valid.
                    lastMsg := curMsg;
                    // Fire up TX
                    if not TxDirty and TxValid Then
                    Begin
                         // For TX I need to scale progress bar for TX display
                         Form1.ProgressBar3.Max := eot+10240;
                         rxInProgress := False;
                         nextAction := 2;
                         dac.d65txBufferIdx := 0;

                         rxCount := 0;
                         if getPTTMethod() = 'HRD' Then hrdRaisePTT();
                         if getPTTMethod() = 'ALT' Then altRaisePTT();
                         if getPTTMethod() = 'PTT' Then raisePTT();
                         globalData.txInProgress := True;
                         foo := '';
                         if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
                         if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
                         Form1.addToDisplayTX(lastMsg);
                         // Add TX to log if enabled.
                         if cfgvtwo.Form6.cbSaveCSV.Checked Then
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
                         thisAction := 2;
                         nextAction := 2;
                         globalData.txInProgress := False;
                         rxInProgress := False;
                    End;
               End
               Else
               Begin
                    txCount := 0;
                    lastTX := '';
                    Form1.chkEnTX.Checked := False;
                    diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent ' + IntToStr(cfgvtwo.Form6.SpinTXCount.Value) + ' times.');
                    diagout.Form3.Show;
                    diagout.Form3.BringToFront;
               End;
          End
          Else
          Begin
               globalData.txInProgress := True;
               rxInProgress := False;
               if paOutParams.channelCount = 2 Then
               Begin
                    // eot + 10240 determined experimentally.  The 'padding' of 10240 ensures
                    // no tones get chopped by prematrue dropping of PTT.
                    if (dac.d65txBufferIdx >= eot+10240) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Then
                    Begin
                         globalData.txInProgress := False;
                         if getPTTMethod() = 'HRD' Then hrdLowerPTT();
                         if getPTTMethod() = 'ALT' Then altLowerPTT();
                         if getPTTMethod() = 'PTT' Then lowerPTT();
                         thisAction := 5;
                         actionSet := False;
                         curMsg := '';
                    End;
               end;
               // Update the progress indicator for this sequence.
               if paOutParams.channelCount = 2 Then Form1.ProgressBar3.Position := dac.d65txBufferIdx;
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
               genTX1();
               if not cfgvtwo.Form6.cbTXWatchDog.Checked Then txCount := 0;
               if cfgvtwo.Form6.SpinTXCount.Value < 2 then txCount := 0;
               if cfgvtwo.Form6.SpinTXCount.Value > 30 then cfgvtwo.Form6.SpinTXCount.Value := 30;
               if txCount < cfgvtwo.Form6.SpinTXCount.Value Then
               Begin
                    // Flag TX Buffer as valid.
                    lastMsg := curMsg;
                    // Fire up TX
                    if not TxDirty and TxValid Then
                    Begin
                         // For TX I need to scale progress bar for TX display
                         Form1.ProgressBar3.Max := 538624;
                         rxInProgress := False;
                         nextAction := 2;

                         // I want to attempt to start the tones where they would NOW be IF
                         // the TX had STARTED ON TIME
                         //nst.Minute := 0;
                         nst := utcTime();
                         // Calculate offset in samples to this second
                         dac.d65txBufferIdx := nst.Second * 11025;
                         //dac.d65txBufferPtr := @dac.d65txBuffer[dac.d65txBufferIdx];

                         rxCount := 0;
                         if getPTTMethod() = 'HRD' Then hrdRaisePTT();
                         if getPTTMethod() = 'ALT' Then altRaisePTT();
                         if getPTTMethod() = 'PTT' Then raisePTT();
                         globalData.txInProgress := True;
                         foo := '';
                         if gst.Hour < 10 then foo := '0' + IntToStr(gst.Hour) + ':' else foo := IntToStr(gst.Hour) + ':';
                         if gst.Minute < 10 then foo := foo + '0' + IntToStr(gst.Minute) else foo := foo + IntToStr(gst.Minute);
                         form1.addToDisplayTX(lastMsg);
                         // Add TX to log if enabled.
                         if cfgvtwo.Form6.cbSaveCSV.Checked Then
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
                         thisAction := 2;
                         nextAction := 2;
                         globalData.txInProgress := False;
                         rxInProgress := False;
                    End;
               End
               Else
               Begin
                    txCount := 0;
                    lastTX := '';
                    Form1.chkEnTX.Checked := False;
                    diagout.Form3.ListBox1.Items.Insert(0,'TX Halted.  Same message sent ' + IntToStr(cfgvtwo.Form6.SpinTXCount.Value) + ' times.');
                    diagout.Form3.Show;
                    diagout.Form3.BringToFront;
               End;
          End
          Else
          Begin
               // Continuing a late sequence TX
               globalData.txInProgress := True;
               rxInProgress := False;
               if paOutParams.channelCount = 2 Then
               Begin
                    if (dac.d65txBufferIdx >= eot+2048) Or (dac.d65txBufferIdx >= 661503-(11025 DIV 2)) Or (thisSecond > 48) Then
                    Begin
                         // I have a full TX cycle when d65txBufferIdx >= 538624 or thisSecond > 48
                         if getPTTMethod() = 'HRD' Then hrdLowerPTT();
                         if getPTTMethod() = 'ALT' Then altLowerPTT();
                         if getPTTMethod() = 'PTT' Then lowerPTT();
                         actionSet := False;
                         thisAction := 5;
                         globalData.txInProgress := False;
                         curMsg := '';
                    End;
               end;
               // Update the progress indicator for this sequence.
               if paOutParams.channelCount = 2 Then Form1.ProgressBar3.Position := dac.d65txBufferIdx;
          End;
     End;
End;

procedure TForm1.processNewMinute(st : TSystemTime);
Var
   i, idx, ifoo : Integer;
Begin
     // Warning for DT being offset
     if spinDT.Value <> 0 Then Form1.addToDisplayE('WARNING: DT offset is not 0');
     // Get Start of Period QRG
     actionSet := False;
     sopQRG := globalData.gqrg;
     tsopQRG := globalData.strqrg;
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
          If cfgvtwo.gld65AudioChange Then audioChange();
     End;
     // Handler for action=3
     if thisAction = 3 Then
     Begin
          If cfgvtwo.gld65AudioChange Then audioChange();
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
     if not Form1.chkEnTX.Checked And globalData.hrdcatControlcurrentRig.hrdAlive Then
     Begin
          if cfgvtwo.Form6.cbEnableQSY1.Checked Then
          Begin
               if (st.Hour = cfgvtwo.Form6.qsyHour1.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute1.Value) Then
               Begin
                    // QSY time slot 1
                    If TryStrToInt(cfgvtwo.Form6.edQRGQSY1.Text, ifoo) Then
                    Begin
                         if ifoo > 1799999 Then
                         Begin
                              if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
                              if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
                              if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY1.Text) Then
                              Begin
                                   if cfgvtwo.Form6.cbATQSY1.Checked Then
                                   Begin
                                   // Auto-tune cycle requested
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
          if cfgvtwo.Form6.cbEnableQSY2.Checked Then
          Begin
               if (st.Hour = cfgvtwo.Form6.qsyHour2.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute2.Value) Then
               Begin
                    // QSY time slot 2
                    If TryStrToInt(cfgvtwo.Form6.edQRGQSY2.Text, ifoo) Then
                    Begin
                         if ifoo > 1799999 Then
                         Begin
                              if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
                              if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
                              if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY2.Text) Then
                              Begin
                                   if cfgvtwo.Form6.cbATQSY2.Checked Then
                                   Begin
                                   // Auto-tune cycle requested
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
          if cfgvtwo.Form6.cbEnableQSY3.Checked Then
          Begin
               if (st.Hour = cfgvtwo.Form6.qsyHour3.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute3.Value) Then
               Begin
                    // QSY time slot 3
                    If TryStrToInt(cfgvtwo.Form6.edQRGQSY3.Text, ifoo) Then
                    Begin
                         if ifoo > 1799999 Then
                         Begin
                              if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
                              if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
                              if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY3.Text) Then
                              Begin
                                   if cfgvtwo.Form6.cbATQSY3.Checked Then
                                   Begin
                                   // Auto-tune cycle requested
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
          if cfgvtwo.Form6.cbEnableQSY4.Checked Then
          Begin
               if (st.Hour = cfgvtwo.Form6.qsyHour4.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute4.Value) Then
               Begin
                    // QSY time slot 4
                    If TryStrToInt(cfgvtwo.Form6.edQRGQSY4.Text, ifoo) Then
                    Begin
                         if ifoo > 1799999 Then
                         Begin
                              if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
                              if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
                              if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY4.Text) Then
                              Begin
                                   if cfgvtwo.Form6.cbATQSY4.Checked Then
                                   Begin
                                   // Auto-tune cycle requested
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
          if cfgvtwo.Form6.cbEnableQSY5.Checked Then
          Begin
               if (st.Hour = cfgvtwo.Form6.qsyHour5.Value) And (st.Minute = cfgvtwo.Form6.qsyMinute5.Value) Then
               Begin
                    // QSY time slot 5
                    If TryStrToInt(cfgvtwo.Form6.edQRGQSY5.Text, ifoo) Then
                    Begin
                         if ifoo > 1799999 Then
                         Begin
                              if cfgvtwo.Form6.rbHRD4.Checked Then globalData.hrdVersion :=4;
                              if cfgvtwo.Form6.rbHRD5.Checked Then globalData.hrdVersion :=5;
                              if catControl.writeHRD('[' + globalData.hrdcatControlcurrentRig.radioContext + '] set frequency-hz ' + cfgvtwo.Form6.edQRGQSY5.Text) Then
                              Begin
                                   if cfgvtwo.Form6.cbATQSY5.Checked Then
                                   Begin
                                   // Auto-tune cycle requested
                                   end;
                              end;
                         end;
                    end;
               end;
          end;
     end;
End;

procedure TForm1.updateStatus(i : Integer);
Var
   foo : String;
begin
     If i = 1 Then
     Begin
          foo := 'Current Operation:  Initializing';
          if Form1.Label40.Caption <> foo Then
          Form1.Label40.Caption := foo;
     End;
     If i = 2 then
     Begin
          foo := 'Current Operation:  Receiving';
          if Form1.Label40.Caption <> foo Then
          Form1.Label40.Caption := foo;
     End;
     If i = 3 then
     Begin
          foo := 'Current Operation:  Transmitting';
          if Form1.Label40.Caption <> foo Then
          Form1.Label40.Caption := foo;
     End;
     If i = 4 then
     Begin
          foo := 'Current Operation:  Starting Decoder';
          if Form1.Label40.Caption <> foo Then
          Form1.Label40.Caption := foo;
     End;
     If i = 5 then
     Begin
          if d65.glinProg Then
             foo := 'Current Operation:  Decoding pass ' + IntToStr(d65.gldecoderPass+1)
          else
             foo := 'Current Operation:  Idle';
          if Form1.Label40.Caption <> foo Then
          Form1.Label40.Caption := foo;
     End;
end;

procedure TForm1.processOncePerSecond(st : TSystemTime);
Var
   foo  : String;
Begin
     // Keep popup menu items in sync
     Form1.MenuItem8a.Caption  := cfgvtwo.Form6.edUserQRG1.Text;
     Form1.MenuItem9a.Caption  := cfgvtwo.Form6.edUserQRG2.Text;
     Form1.MenuItem10a.Caption := cfgvtwo.Form6.edUserQRG3.Text;
     Form1.MenuItem11a.Caption := cfgvtwo.Form6.edUserQRG4.Text;
     Form1.MenuItem12a.Caption := cfgvtwo.Form6.edUserQRG5.Text;
     Form1.MenuItem13a.Caption := cfgvtwo.Form6.edUserQRG6.Text;
     Form1.MenuItem14a.Caption := cfgvtwo.Form6.edUserQRG7.Text;
     Form1.MenuItem15a.Caption := cfgvtwo.Form6.edUserQRG8.Text;
     Form1.MenuItem16a.Caption := cfgvtwo.Form6.edUserQRG9.Text;
     Form1.MenuItem17a.Caption := cfgvtwo.Form6.edUserQRG10.Text;
     Form1.MenuItem18a.Caption := cfgvtwo.Form6.edUserQRG11.Text;
     Form1.MenuItem19a.Caption := cfgvtwo.Form6.edUserQRG12.Text;
     Form1.MenuItem20a.Caption := cfgvtwo.Form6.edUserQRG13.Text;

     Form1.MenuItem4b.Caption  := cfgvtwo.Form6.edUserMsg4.Text;
     Form1.MenuItem5b.Caption  := cfgvtwo.Form6.edUserMsg5.Text;
     Form1.MenuItem6b.Caption  := cfgvtwo.Form6.edUserMsg6.Text;
     Form1.MenuItem7b.Caption  := cfgvtwo.Form6.edUserMsg7.Text;
     Form1.MenuItem8b.Caption  := cfgvtwo.Form6.edUserMsg8.Text;
     Form1.MenuItem9b.Caption  := cfgvtwo.Form6.edUserMsg9.Text;
     Form1.MenuItem10b.Caption := cfgvtwo.Form6.edUserMsg10.Text;
     Form1.MenuItem11b.Caption := cfgvtwo.Form6.edUserMsg11.Text;
     Form1.MenuItem12b.Caption := cfgvtwo.Form6.edUserMsg12.Text;
     Form1.MenuItem13b.Caption := cfgvtwo.Form6.edUserMsg13.Text;
     Form1.MenuItem14b.Caption := cfgvtwo.Form6.edUserMsg14.Text;
     Form1.MenuItem15b.Caption := cfgvtwo.Form6.edUserMsg15.Text;
     Form1.MenuItem16b.Caption := cfgvtwo.Form6.edUserMsg16.Text;
     Form1.MenuItem17b.Caption := cfgvtwo.Form6.edUserMsg17.Text;
     Form1.MenuItem18b.Caption := cfgvtwo.Form6.edUserMsg18.Text;
     Form1.MenuItem19b.Caption := cfgvtwo.Form6.edUserMsg19.Text;
     Form1.MenuItem20b.Caption := cfgvtwo.Form6.edUserMsg20.Text;

     // Update PSKR Count
     if cbEnPSKR.Checked Then Label7.Caption := rb.pskrCount;
     if cbEnPSKR.Checked Then Form1.Label7.Visible := True else Form1.Label7.Visible := False;
     // Update RB Count
     If cbEnRB.Checked Then Label2.Caption := rb.rbCount;
     if cbEnRB.Checked Then Form1.Label2.Visible := True else Form1.Label2.Visible := False;
     // Force Rig control read cycle.
     if (st.Second mod 3 = 0) And not primed Then doCAT := True;
     // Set manual entry ability.
     if cfgvtwo.glcatBy = 'none' Then Form1.editManQRG.Enabled := True else Form1.editManQRG.Enabled := False;
     if Form1.editManQRG.Text = '0' Then
     Begin
          Form1.Label12.Font.Color := clRed;
          Form1.editManQRG.Font.Color := clRed;
     end
     else
     begin
         Form1.Label12.Font.Color := clBlack;
         Form1.editManQRG.Font.Color := clBlack;
     end;
     If cbEnRB.Checked Then
     Begin
          If globalData.rbLoggedIn Then Form1.Label2.Font.Color := clBlack else Form1.Label2.Font.Color := clRed;
     end;
     // Update AU Levels display
     displayAudio(audioAve1, audioAve2);
     if Form1.chkMultiDecode.Checked Then watchMulti := False;
     {TODO [1.1.0] Reattach this to new RB Code}
     // Update rbstats once per minute at second = 30
     //If st.Second = 30 Then
     //Begin
     //     // Process the calls heard list
     //     for i := 0 to 499 do
     //     Begin
     //          if Length(rbc.glrbsLastCall[i]) > 0 Then
     //          Begin
     //               updateList(rbc.glrbsLastCall[i]);
     //               rbc.glrbsLastCall[i] := '';
     //          End;
     //     End;
     //     // Now update the calls heard string grid
     //     cfgvtwo.Form6.sgCallsHeard.RowCount := 1;
     //     for i := 0 to 499 do
     //     begin
     //          if rbsHeardList[i].count > 0 Then
     //          Begin
     //               cfgvtwo.Form6.sgCallsHeard.InsertColRow(False,1);
     //               cfgvtwo.Form6.sgCallsHeard.Cells[0,1] := rbsHeardList[i].callsign;
     //               cfgvtwo.Form6.sgCallsHeard.Cells[1,1] := IntToStr(rbsHeardList[i].count);
     //          End;
     //     end;
     //end;
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
     // If rb Enabled (and not Offline Only) then ping RB server every
     // other minute at second = 55 to keep rb logged in.
     if st.Second = 55 Then
     Begin
          If cbEnRB.Checked And odd(st.Minute) Then rbcPing := True;
     end;
     // Set RX CF to 0 if multi enabled
     //If Form1.chkMultiDecode.Checked Then spinDecoderCF.Value := 0;
end;

procedure TForm1.oncePerTick();
Var
   i    : Integer;
   cont : Boolean;
   ccnt : Integer;
Begin

     if rbthread.Suspended then
     begin
          timer1.enabled := false;
          showmessage('RB Thread is suspended.');
          timer1.Enabled := true;
     end;

     if spinDT.Value <> 0 Then Label32.Font.Color := clRed else Label32.Font.Color := clBlack;

     // Check for changes to configured callsign since last tick
     myCallCheck();

     // Verify callsign and meets the JT65 and/or RB protocol requirements.
     if ValidateGrid(cfgvtwo.Form6.edMyGrid.Text) AND (ValidateCallsign(globalData.fullcall) or ValidateSlashedCallsign(globalData.fullcall)) then cont := true else cont := false;
     if cont then
     begin
          // Callsign and Grid is good so RB is fine to be enabled.
          cbEnPSKR.Enabled := True;
          cbEnRB.Enabled   := True;
          globalData.canTX := True;
     end
     else
     begin
          cbEnPSKR.Enabled := False;
          cbEnRB.Enabled   := False;
          cbEnPSKR.Checked := False;
          cbEnRB.Checked   := False;
          globalData.canTX := False;
     end;
     // Refresh audio level display
     if not primed then updateAudio();
     // Update spectrum display.
     if not globalData.txInProgress and not primed and not globalData.spectrumComputing65 and not d65.glinProg Then
     Begin
          // Normal RX waterfall update
          If globalData.specNewSpec65 Then Waterfall.Repaint;
     End
     else
     begin
          // Simple repaint update to keep display "clean" during TX or between new data.
          Waterfall.Repaint;
     end;
     // Update RX/TX SR Display
     if not primed Then updateSR();
     // Determine TX Buffer to use
     if useBuffer = 0 Then curMsg := UpCase(padRight(Form1.edMsg.Text,22));
     if useBuffer = 1 Then curMsg := UpCase(padRight(Form1.edFreeText.Text,22));
     // Enable/disable TX controls as needed.
     txControls();
     // Give some indication if multi is off
     if Form1.chkMultiDecode.Checked Then Form1.chkMultiDecode.Font.Color := clBlack else Form1.chkMultiDecode.Font.Color := clRed;
     // If TX is enabled and waterfall is disabled then enable waterfall.
     if chkEnTX.Checked and (SpinEdit1.Value < 0) Then
     begin
          SpinEdit1.Value := 0;
          SpinEdit1Change(SpinEdit1)
     end;
     // Display any decodes that may have been returned from the decoder thread.
     // Only run this block if decoder thread is inactive.
     If not d65.glinProg and d65.gld65HaveDecodes Then
     Begin
          // Don't insert the decoder period divder when in compact mode or if user doesn't want it.
          if cfgvtwo.Form6.cbDecodeDivider.Checked Then
          Begin
               If Form1.Height > 619 Then ListBox1.Items.Insert(0,'---------------------------------------------');
          end;
          for i := 0 to 49 do
          Begin
               if (not d65.gld65decodes[i].dtProcessed) And (not d65.gld65decodes[i].dtDisplayed) Then
               begin
                    addToDisplay(i,65);
                    if not reDecode then addToRBC(i,65);
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
          if cfgvtwo.Form6.cbDecodeDividerCompact.Checked Then
          Begin
          // Remove extra '---------------------------------------------' lines
             if ListBox1.Items.Count > 1 Then
             Begin
                  // Get count of lines in decoder = '---------------------------------------------'
                  ccnt := 0;
                  for i := ListBox1.Items.Count-1 downto 1 do
                  begin
                       if ListBox1.Items.Strings[i] = '---------------------------------------------' Then
                       Begin
                            ccnt := ccnt+1;
                       end;
                  end;
                  If ccnt > 1 Then
                  Begin
                       // Compact :)
                       repeat
                             for i := ListBox1.Items.Count-1 downto 1 do
                             begin
                                  if ListBox1.Items.Strings[i] = '---------------------------------------------' then
                                  Begin
                                       ListBox1.Items.Delete(i);
                                       break;
                                  end;
                             end;
                             ccnt := 0;
                             for i := ListBox1.Items.Count-1 downto 1 do
                             begin
                                  if ListBox1.Items.Strings[i] = '---------------------------------------------' Then ccnt := ccnt+1;
                             end;
                       until ccnt < 2;
                  end;
             end;
          end;
          reDecode := False;
          d65.gld65HaveDecodes:= false;
     End;
End;

procedure TForm1.Timer1Timer(Sender: TObject);
Var
   ts : TTimeStamp;
   dt : TDateTime;
   ms : Comp;
begin
     // Setup to evaluate where I am in the temporal loop.
     statusChange := False;
     {This is where I need to start grafting in the DT adjustment}
     if spinDT.Value <> 0 Then
     Begin
          // Add spinDT.value to gst.second, taking into account any overflows.
          ts  := DateTimeToTimeStamp(Now);
          ms  := TimeStampToMSecs(ts);
          ms  := ms + spinDT.Value*1000;
          ts  := MSecsToTimeStamp(ms);
          dt  := TimeStampToDateTime(ts);
          DateTimeToSystemTime(dt,gst);
     end
     else
     begin
          gst := utcTime();
          thisSecond := gst.Second;
     end;
     // Runs at program start only
     If runOnce Then
     Begin
          Form1.Timer1.Enabled := False;
          //ShowMessage('Main loop entered, calling initializer code...');
          // Read in initializer code items that can't be run from form create.
          initializerCode();

          runOnce := False;
          dlog.fileDebug('Initializer code complete.  Entering main timing loop.');
          //ShowMessage('Initializer code completed entering main execution loop...');

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
          diagout.Form3.Show;
          diagout.Form3.BringToFront;
          diagout.Form3.ListBox1.Items.Add('resync! ' + IntToStr(gst.Second));
          runOnce := True;
          Form1.Timer1.Enabled := True;
          {TODO [1.1.0] Review this based on any feedback.}
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
     if not statusChange Then
     begin
          processOngoing();
     end;
     //
     // Code that executes once per second, but not necessary that it be exact 1
     // second intervals. This happens whether it's the top of a new minute or not.
     If gst.Second <> lastSecond Then
     begin
          processOncePerSecond(gst);
     end;
     // Code that runs each timer tick.
     oncePerTick();
     // Clear the timer overrun check variable.
     alreadyHere := False;
end;

initialization
  {$I maincode.lrs}
  // The decoder runs in its own thread and will process the rxBuffer any time
  // globalData.d65doDecodePass = True.  I also need to define whether I want to do
  // multi-decode, the low..high multi-decode range and the step size or, for
  // single decode, the center frequency and bandwidth.
  d65doDecodePass := False;
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
  adc.d65rxBufferPtr := @adc.d65rxBuffer[0];  // pointer set to start of rxBuffer
  adc.d65rxBufferIdx := 0;
  // Initialize txBuffer and its pointer, txBuffer holds outgoing sample data for PA
  //dac.d65txBufferPtr := @dac.d65txBuffer[0];  // pointer set to start of txBuffer
  dac.d65txBufferIdx := 0;
  // Miscelanious operational vars.
  runOnce := True;
  spectrum.specFirstRun := True;
  cfgvtwo.glrbcLogin := False;
  cfgvtwo.glrbcLogout := False;
  rbcPing := False;
  alreadyHere := False; // Used to detect an overrun of timer servicing loop.
  sLevel1 := 0;
  sLevel2 := 0;
  smeterIdx := 0;
  adc.adcSpecCount := 0;
  adc.adcChan := 1;
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
  adc.adcT         := 0;
  adc.adcE         := 0;
  mnpttOpened    := False;
  firstReport  := True;
  useBuffer := 0;
  adc.adcLDgain := 0;
  adc.adcRDgain := 0;
  lastMsg := '';
  curMsg := '';
  cfgvtwo.glautoSR := False;
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
  cfgvtwo.glcatBy := 'none';
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
  adc.adcRunning := False;
  d65.glnd65firstrun := True;
  d65.glbinspace := 0;
  globalData.debugOn := False;
  globalData.gmode := 65;
  txmode := globalData.gmode;
  mnHavePrefix := False;
  mnHaveSuffix := False;
  fullcall := '';
  // Create stream for spectrum image
  globalData.specMs65 := TMemoryStream.Create;
  adc.adcECount := 0;
  reDecode := False;
  // Clear rewind buffers
  For mnlooper := 0 to 661503 do
  begin
       auOddBuffer[mnlooper]  := 0;
       auEvenBuffer[mnlooper] := 0;
  end;
  haveOddBuffer := False;
  haveEvenBuffer := False;
  globalData.mtext := '/Multi%20On%202K%20BW';
  doCWID := False;
  actionSet := False;
  catControl.catControlautoQSY := False;
  catControl.catControlcatTxDF := False;
  globalData.hrdcatControlcurrentRig.hrdAlive := False;
  globalData.hrdVersion := 5;
  // Create spotting class object.
  rb   := spot.TSpot.create(); // Used even if spotting is disabled
  mval := valobject.TValidator.create(); // This creates a access point to validation routines needed for new RB code
  globalData.decimalOverride1 := false;
  globalData.decimalOverride2 := false;
end.

