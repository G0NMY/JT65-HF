unit guidedconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes , SysUtils , FileUtil , LResources , Forms , Controls , Graphics ,
  Dialogs , StdCtrls , ExtCtrls , ComCtrls , ColorBox , Spin , IniPropStorage ,
  EditBtn , valobject , rigobject , paobject , CTypes , srgraph , serialobject,
  StrUtils;

type
  tmacrolist = array of String;
  tqrglist   = array of integer;

  { TForm7 }

  TForm7 = class(TForm )
    buttonContinue8 : TButton ;
    buttonContinue4 : TButton ;
    buttonTestCAT : TButton ;
    buttonTestSerialPTT : TButton ;
    buttonTestSound : TButton ;
    buttonContinue2 : TButton ;
    buttonContinue3 : TButton ;
    buttonContinue5 : TButton ;
    buttonContinue6 : TButton ;
    buttonContinue7 : TButton ;
    buttonContinue9 : TButton ;
    buttonContinue10 : TButton ;
    buttonEnableSuffixPrefix : TButton ;
    buttonContinue1 : TButton ;
    buttonContinue0 : TButton ;
    cbEnAT2 : TCheckBox ;
    cbEnAT3 : TCheckBox ;
    cbEnAT4 : TCheckBox ;
    cbEnAT5 : TCheckBox ;
    cbEnAT6 : TCheckBox ;
    cbEnAutoQSY2 : TCheckBox ;
    cbEnAutoQSY3 : TCheckBox ;
    cbEnAutoQSY4 : TCheckBox ;
    cbEnAutoQSY5 : TCheckBox ;
    cbEnAutoQSY6 : TCheckBox ;
    cbEnAT1 : TCheckBox ;
    cbSRErrorCheck : TCheckBox ;
    cbCATPTT : TCheckBox ;
    cbEnAutoQSY1 : TCheckBox ;
    cbAutoTXSR : TCheckBox ;
    cbSaveCSV : TCheckBox ;
    cbSaveDB : TCheckBox ;
    cbDisableMultiInQSO : TCheckBox ;
    cbEnableMultiAfterQSO : TCheckBox ;
    cbTXWatchdog : TCheckBox ;
    cbSaveADIF : TCheckBox ;
    cbdoeqsl : TCheckBox ;
    cbdoDXLab : TCheckBox ;
    cbRestoresDefaultsMulti : TCheckBox ;
    cbPTTAltCode : TCheckBox ;
    cbSendCWIDFree : TCheckBox ;
    cbSendCWIDAll : TCheckBox ;
    cbNoSpotting : TCheckBox ;
    cbForceMonoIO : TCheckBox ;
    cbRBEnable : TCheckBox ;
    cbPSKREnable : TCheckBox ;
    cbDisableColorCoding : TCheckBox ;
    cbUseOptFFT : TCheckBox ;
    cbUseKV : TCheckBox ;
    cbAutoRXSR : TCheckBox ;
    colorBoxCQ : TColorBox ;
    colorBoxQSO : TColorBox ;
    colorBoxMine : TColorBox ;
    comboSoundIn : TComboBox ;
    comboPrefix : TComboBox ;
    comboSoundOut : TComboBox ;
    comboSuffix : TComboBox ;
    cqtext : TLabel ;
    cqtext1 : TLabel ;
    edQRG1 : TEdit ;
    edQRG2 : TEdit ;
    edQRG3 : TEdit ;
    edQRG4 : TEdit ;
    edQRG5 : TEdit ;
    edQRG6 : TEdit ;
    edQSYTime1 : TEdit ;
    edQSYTime2 : TEdit ;
    edQSYTime3 : TEdit ;
    edQSYTime4 : TEdit ;
    edQSYTime5 : TEdit ;
    edQSYTime6 : TEdit ;
    ini : TIniPropStorage ;
    Label35 : TLabel ;
    Label44 : TLabel ;
    Label45 : TLabel ;
    Label46 : TLabel ;
    Label47 : TLabel ;
    Label48 : TLabel ;
    Label49 : TLabel ;
    Label50 : TLabel ;
    Label51 : TLabel ;
    Label52 : TLabel ;
    Label53 : TLabel ;
    Label54 : TLabel ;
    Label55 : TLabel ;
    Label56 : TLabel ;
    Label57 : TLabel ;
    Label58 : TLabel ;
    Label59 : TLabel ;
    Label60 : TLabel ;
    Label61 : TLabel ;
    Label62 : TLabel ;
    rbcall : TEdit ;
    edRBCallsign : TEdit ;
    edRBInfo : TEdit ;
    editMacro1 : TEdit ;
    editMacro10 : TEdit ;
    editMacro11 : TEdit ;
    editMacro12 : TEdit ;
    editMacro13 : TEdit ;
    editMacro14 : TEdit ;
    editMacro15 : TEdit ;
    editMacro16 : TEdit ;
    editMacro17 : TEdit ;
    editMacro18 : TEdit ;
    editMacro19 : TEdit ;
    editMacro2 : TEdit ;
    editMacro20 : TEdit ;
    editMacro21 : TEdit ;
    editMacro22 : TEdit ;
    editMacro23 : TEdit ;
    editMacro24 : TEdit ;
    editQRG1 : TEdit ;
    editMacro3 : TEdit ;
    editMacro4 : TEdit ;
    editMacro5 : TEdit ;
    editMacro6 : TEdit ;
    editMacro7 : TEdit ;
    editMacro8 : TEdit ;
    editMacro9 : TEdit ;
    editQRG10 : TEdit ;
    editQRG11 : TEdit ;
    editQRG12 : TEdit ;
    editQRG13 : TEdit ;
    editQRG14 : TEdit ;
    editQRG15 : TEdit ;
    editQRG16 : TEdit ;
    editQRG2 : TEdit ;
    editQRG3 : TEdit ;
    editQRG4 : TEdit ;
    editQRG5 : TEdit ;
    editQRG6 : TEdit ;
    editQRG7 : TEdit ;
    editQRG8 : TEdit ;
    editQRG9 : TEdit ;
    edPTTPort : TEdit ;
    edCWCallsign : TEdit ;
    fullcall : TEdit ;
    edStationCallsign : TEdit ;
    edStationGrid : TEdit ;
    cwcall : TEdit ;
    GroupBox1 : TGroupBox ;
    GroupBox2 : TGroupBox ;
    GroupBox3 : TGroupBox ;
    Label1 : TLabel ;
    Label10 : TLabel ;
    Label11 : TLabel ;
    Label12 : TLabel ;
    Label13 : TLabel ;
    Label14 : TLabel ;
    Label15 : TLabel ;
    Label16 : TLabel ;
    Label17 : TLabel ;
    Label18 : TLabel ;
    Label19 : TLabel ;
    Label2 : TLabel ;
    Label20 : TLabel ;
    Label21 : TLabel ;
    Label22 : TLabel ;
    Label23 : TLabel ;
    Label24 : TLabel ;
    Label25 : TLabel ;
    Label26 : TLabel ;
    Label27 : TLabel ;
    Label28 : TLabel ;
    Label29 : TLabel ;
    Label3 : TLabel ;
    Label30 : TLabel ;
    Label31 : TLabel ;
    Label32 : TLabel ;
    Label33 : TLabel ;
    Label34 : TLabel ;
    Label36 : TLabel ;
    Label37 : TLabel ;
    Label38 : TLabel ;
    Label39 : TLabel ;
    Label4 : TLabel ;
    Label40 : TLabel ;
    Label41 : TLabel ;
    Label42 : TLabel ;
    Label43 : TLabel ;
    Label5 : TLabel ;
    Label6 : TLabel ;
    Label7 : TLabel ;
    Label8 : TLabel ;
    Label9 : TLabel ;
    listBoxSoundDiag : TListBox ;
    Memo1 : TMemo ;
    PageControl1 : TPageControl ;
    CallsignGrid : TTabSheet ;
    PrefixSuffix : TTabSheet ;
    qsotext : TLabel ;
    qsotext1 : TLabel ;
    rbPTTVox : TRadioButton ;
    rbOmni : TRadioButton ;
    rbNoCAT : TRadioButton ;
    rbPTTCom : TRadioButton ;
    rbPTTCat : TRadioButton ;
    rbPTTNoTX : TRadioButton ;
    rbDTRRTS : TRadioButton ;
    rbRTS : TRadioButton ;
    rbDTR : TRadioButton ;
    rbHRD : TRadioButton ;
    rbCommander : TRadioButton ;
    RadioGroup1 : TRadioGroup ;
    SoundDevice : TTabSheet ;
    PTTRigControl : TTabSheet;
    spinTXCount : TSpinEdit;
    Spotting : TTabSheet;
    Macros : TTabSheet;
    Colors : TTabSheet;
    Advanced : TTabSheet;
    Review : TTabSheet;
    AutoQSY : TTabSheet;
    Logging : TTabSheet;
    Timer1 : TTimer;
    tometext : TLabel;
    tometext1 : TLabel;
    procedure buttonContinue0Click(Sender : TObject);
    procedure buttonContinue1Click(Sender : TObject);
    procedure buttonContinue2Click(Sender : TObject);
    procedure buttonContinue3Click(Sender : TObject);
    procedure buttonContinue4Click(Sender : TObject);
    procedure buttonContinue5Click(Sender : TObject);
    procedure buttonContinue6Click(Sender : TObject);
    procedure buttonContinue7Click(Sender : TObject);
    procedure buttonContinue8Click(Sender : TObject);
    procedure buttonContinue9Click(Sender : TObject);
    procedure buttonContinue10Click(Sender : TObject);
    procedure buttonEnableSuffixPrefixClick(Sender : TObject);
    procedure buttonTestCATClick(Sender : TObject);
    procedure buttonTestSerialPTTClick(Sender : TObject);
    procedure buttonTestSoundClick(Sender : TObject);
    procedure cbDisableColorCodingChange(Sender : TObject);
    procedure cbEnAT1Change(Sender : TObject);
    procedure cbForceMonoIOChange(Sender : TObject);
    procedure cbNoSpottingChange(Sender : TObject);
    procedure cbRBEnableChange(Sender : TObject);
    procedure colorBoxCQChange(Sender : TObject);
    procedure colorBoxMineChange(Sender : TObject);
    procedure colorBoxQSOChange(Sender : TObject);
    procedure comboPrefixChange(Sender : TObject);
    procedure comboSoundInChange(Sender : TObject);
    procedure comboSoundOutChange(Sender : TObject);
    procedure comboSuffixChange(Sender : TObject);
    procedure editMacro1Change(Sender : TObject);
    procedure editQRG1Change(Sender : TObject);
    procedure edPTTPortChange(Sender : TObject);
    procedure edQSYTime1Change (Sender : TObject );
    procedure edStationCallsignChange(Sender : TObject);
    procedure FormShow (Sender : TObject );
    procedure rbPTTCatChange(Sender : TObject);
    procedure rbPTTComChange(Sender : TObject);
    procedure rbPTTNoTXChange(Sender : TObject);
    procedure rbPTTVoxChange(Sender : TObject);
    procedure Timer1Timer(Sender : TObject);
    procedure saveConfig(cfgname : string);
    procedure readConfig(cfgname : string);
    function  macroVal(macro : String) : String;
  private
    { private declarations }
  public
    { public declarations }
  end; 

  TSettings = Class
    private
      // Tab 0 Values Callsign/Grid
      prCallsign      : String;
      prCWCallsign    : String;
      prRBCallsign    : String;
      prGrid          : String;
      // Tab 1 Values Callsign Suffix/Prefix
      prPrefix        : Integer;  // Index of selected prefix
      prSuffix        : Integer;  // Index of selected suffix
      // Tab 2 Values Sound Device
      prSoundInN      : Integer;  // Sound input device index (pa device id)
      prSoundOutN     : Integer;  // Sound output device index (pa device id)
      prSoundInS      : String;   // Sound input device name
      prSoundOutS     : String;   // Sound output device name
      prSoundTested   : Boolean;  // Has sound device test ran and passed?
      prSoundETested  : Boolean;  // Has extended device test ran and passed?
      prSoundValid    : Boolean;  // Is sound configuration valid?
      prSoundMonoRX   : Boolean;  // ADC must be in mono mode?
      prSoundMonoTX   : Boolean;  // DAC must be in mono mode?
      prForceMono     : Boolean;  // User selected force mono i/o?
      // Tab 3 Values PTT And Rig Control
      prPTTMethod     : String;
      prCATMethod     : String;
      prPTTPort       : String;
      prAltPTT        : Boolean;
      prPTTLines      : String;
      prPTTTested     : Boolean;
      prCATEnabled    : Boolean;
      // Tab 4 Values Auto QSY
      prEnQSY1        : Boolean;
      prEnQSY2        : Boolean;
      prEnQSY3        : Boolean;
      prEnQSY4        : Boolean;
      prEnQSY5        : Boolean;
      prEnQSY6        : Boolean;
      prQSYTime1      : String;
      prQSYTime2      : String;
      prQSYTime3      : String;
      prQSYTime4      : String;
      prQSYTime5      : String;
      prQSYTime6      : String;
      prQSYQRG1       : String;
      prQSYQRG2       : String;
      prQSYQRG3       : String;
      prQSYQRG4       : String;
      prQSYQRG5       : String;
      prQSYQRG6       : String;
      prQSYTune1      : Boolean;
      prQSYTune2      : Boolean;
      prQSYTune3      : Boolean;
      prQSYTune4      : Boolean;
      prQSYTune5      : Boolean;
      prQSYTune6      : Boolean;
      // Tab 5 Values Spotting Network
      prNoSpot        : Boolean;
      prRB            : Boolean;
      prPSKR          : Boolean;
      prRBInfo        : String;
      // Tab 6 Values Macros
      prMacros        : tmacrolist;
      prQRGs          : tqrglist;
      // Tab 7 Values Colors
      prCQColor       : TColor;
      prQSOColor      : TColor;
      prMyColor       : TColor;
      prNoColor       : Boolean;
      // Tab 8 Values Logging
      prSaveCSV       : Boolean;
      prSaveDB        : Boolean;
      prSaveADIF      : Boolean;
      prdoeQSL        : Boolean;
      prdodxLab       : Boolean;
      // Tab 9 Values Advanced Settings
      prNoMultiQSO    : Boolean;
      prMultiRestore  : Boolean;
      prMultiDefMulti : Boolean;
      prCWIDfree      : Boolean;
      prCWIDall       : Boolean;
      prTXWatchdog    : Boolean;
      prTXWatchdogInt : Integer;
      prUseOptFFT     : Boolean;
      prUseKV         : Boolean;
      prRXAutoSR      : Boolean;
      prTXAutoSR      : Boolean;
      // Tab 10 Value Review
      prCFGName       : String;
      prbasedir       : String;
      prsrcdir        : String;
      prlogdir        : String;
      prcfgdir        : String;
      prkvdir         : String;
      // General Program settings not covered in configuration
      prVersion       : String;
      // Spectrum Display settings
      prSpecColor     : Integer;
      prSpecContrast  : Integer;
      prSpecBright    : Integer;
      prSpecSpeed     : Integer;
      prSpecGain      : Integer;
      prSpecSmooth    : Boolean;
      // Audio I/O settings
      prAudioUseLeft  : Boolean;
      prAudioUseRight : Boolean;
      prAudioDGainL   : Integer;
      prAudioDGainR   : Integer;
      // Decoder settings
      prTXRXDF        : Boolean;
      prAFC           : Boolean;
      prNoiseBlank    : Boolean;
      prMulti         : Boolean;
      prDecoderBW     : Integer;
      prMultiBW       : Integer;
      prQRG           : Integer;
      // Spotting
      prRBEnable      : Boolean;
      prPSKREnable    : Boolean;

    public
      Constructor create();
      function  validateSound() : Boolean;

      property callsign : String
        read  prCallsign
        write prCallsign;
      property cwcallsign : String
        read  prCWCallsign
        write prCWCallsign;
      property rbcallsign : String
        read  prRBCallsign
        write prRBCallsign;
      property grid      : String
        read  prGrid
        write prGrid;
      property prefix    : Integer
        read  prPrefix
        write prPrefix;
      property suffix    : Integer
        read  prSuffix
        write prSuffix;
      property PTTMethod : String
        read  prPTTMethod
        write prPTTMethod;
      property CATMethod : String
        read  prCATMethod
        write prCATMethod;
      property PTTPort   : String
        read  prPTTPort
        write prPTTPort;
      property AltPTT    : Boolean
        read  prAltPTT
        write prAltPTT;
      property pttLines : String
        read  prPTTLines
        write prPTTLines;
      property pttTested : Boolean
        read  prPTTTested
        write prPTTTested;
      property soundIn : Integer
        read  prSoundInN
        write prSoundInN;
      property soundOut : Integer
        read  prSoundOutN
        write prSoundOutN;
      property soundInS : String
        read  prSoundInS
        write prSoundInS;
      property soundOutS : String
        read  prSoundOutS
        write prSoundOutS;
      property soundTested : Boolean
        read  prSoundTested
        write prSoundTested;
      property soundExtendedTested : Boolean
        read  prSoundETested
        write prSoundETested;
      property soundValid : Boolean
        read  validateSound;
      property monoRX : Boolean
        read  prSoundMonoRX
        write prSoundMonoRX;
      property monoTX : Boolean
        read  prSoundMonoTX
        write prSoundMonoTX;
      property forceMono : Boolean
        read  prForceMono
        write prForceMono;
      property configFile : String
        write prCFGName;
      property baseDir : String
        read  prBaseDir
        write prBaseDir;
      property srcdir : String
        read  prSrcDir
        write prSrcDir;
      property logdir : String
        read  prLogDir
        write prLogDir;
      property cfgdir : String
        read  prCfgDir
        write prCfgDir;
      property kvdir : String
        read  prKVDir
        write prKVDir;
      property version : String
        read  prVersion
        write prVersion;
      property specColor : Integer
        read  prSpecColor
        write prSpecColor;
      property specContrast : Integer
        read  prSpecContrast
        write prSpecContrast;
      property specBright : Integer
        read  prSpecBright
        write prSpecBright;
      property specSpeed : Integer
        read  prSpecSpeed
        write prSpecSpeed;
      property specGain : Integer
        read  prSpecGain
        write prSpecGain;
      property specSmooth : Boolean
        read  prSpecSmooth
        write prSpecSmooth;
      property useAudioLeft : Boolean
        read  prAudioUseLeft
        write prAudioUseLeft;
      property useAudioRight : Boolean
        read  prAudioUseRight
        write prAudioUseRight;
      property dgainL : Integer
        read  prAudioDGainL
        write prAudioDGainL;
      property dgainR : Integer
        read  prAudioDGainR
        write prAudioDGainR;
      property afc : Boolean
        read  prAFC
        write prAFC;
      property noiseblank : Boolean
        read  prNoiseBlank
        write prNoiseBlank;
      property multi : Boolean
        read  prMulti
        write prMulti;
      property decoderBW : Integer
        read  prDecoderBW
        write prDecoderBW;
      property multiBW : Integer
        read  prMultiBW
        write prMultiBW;
      property guiQRG : Integer
        read  prQRG
        write prQRG;
      property useRB : Boolean
        read  prRBEnable
        write prRBEnable;
      property usePSKR : Boolean
        read  prPSKREnable
        write prPSKREnable;
      property useTXeqRXDF : Boolean
        read  prTXRXDF
        write prTXRXDF;
  end;

var
  Form7  : TForm7;
  val1   : valobject.TValidator;
  rig1   : rigobject.TRadio;
  cfg    : guidedconfig.TSettings;
  dsp    : paobject.TpaDSP;
  ser    : serialobject.TSerial;
  fail   : Boolean;
  going  : Boolean;
  prepop : Boolean;


implementation

{ TForm7 }
constructor TSettings.Create();
var
  i : integer;
begin
      // Tab 0 Values Callsign/Grid
      prCallsign      := '';
      prCWCallsign    := '';
      prRBCallsign    := '';
      prGrid          := '';
      // Tab 1 Values Callsign Suffix/Prefix
      prPrefix        := 0;
      prSuffix        := 0;
      // Tab 2 Values Sound Device
      prSoundInN      := -1;
      prSoundOutN     := -1;
      prSoundInS      := '';
      prSoundOutS     := '';
      prSoundTested   := false;
      prSoundETested  := false;
      prSoundValid    := false;
      prSoundMonoRX   := false;
      prSoundMonoTX   := false;
      // Tab 3 Values PTT And Rig Control
      prPTTMethod     := '';
      prCATMethod     := '';
      prPTTPort       := '';
      prAltPTT        := False;
      prPTTLines      := '';
      prPTTTested     := False;
      prCATEnabled    := False;
      // Tab 4 Values Auto QSY

      // Tab 5 Values Spotting Network
      prNoSpot        := False;
      prRB            := False;
      prPSKR          := False;
      prRBInfo        := '';
      // Tab 6 Values Macros
      setLength(prMacros,64);
      setLength(prQRGs,64);
      for i := 0 to 63 do
      begin
           prMacros[i] := '';
           prQRGs[i]   := 0;
      end;
      // Tab 7 Values Colors
      prCQColor       := clLime;
      prQSOColor      := clSilver;
      prMyColor       := clRed;
      prNoColor       := False;
      // Tab 8 Values Logging
      prSaveCSV       := false;
      prSaveDB        := false;
      prSaveADIF      := false;
      prdoeQSL        := false;
      prdodxLab       := false;
      // Tab 9 Values Advanced Settings
      prNoMultiQSO    := False;
      prMultiRestore  := False;
      prMultiDefMulti := False;
      prCWIDfree      := False;
      prCWIDall       := False;
      prTXWatchdog    := False;
      prTXWatchdogInt := 10;
      prUseOptFFT     := False;
      prUseKV         := False;
      prRXAutoSR      := False;
      prTXAutoSR      := False;
      // Tab 10 Value Review
      prCFGName       := '';
      // General Program settings not covered in configuration
      prVersion       := '0.0.0';
      // Spectrum Display settings
      prSpecColor     := 0;
      prSpecContrast  := 0;
      prSpecBright    := 0;
      prSpecSpeed     := 0;
      prSpecGain      := 0;
      prSpecSmooth    := False;
      // Audio I/O settings
      prAudioUseLeft  := False;
      prAudioUseRight := False;
      prAudioDGainL   := 0;
      prAudioDGainR   := 0;
      // Decoder settings
      prTXRXDF        := False;
      prAFC           := False;
      prNoiseBlank    := False;
      prMulti         := False;
      prDecoderBW     := 0;
      prMultiBW       := 0;
      prQRG           := 0;
end;

function  TSettings.validateSound() : Boolean;
var
  valid : Boolean;
begin
      valid := true;
      if prSoundInN < 1 then valid := false;
      if prSoundOutN < 1 then valid := false;
      result := valid;
end;

procedure TForm7.buttonContinue0Click(Sender : TObject);
var
     svalid, cvalid, rvalid, gvalid : Boolean;
     sfoo, cfoo, rfoo, gfoo         : String;
begin
     // Validate tab 0 (General configuration) and move to tab 1 (suffix/prefix) if valid
     val1.setCallsign(edStationCallsign.Text);
     sfoo := val1.callError;
     svalid := val1.callsignValid;
     edStationCallsign.Text := val1.callsign;

     val1.setCWCallsign(edCWCallsign.Text);
     cfoo := val1.callError;
     cvalid := val1.cwCallsignValid;
     edCWCallsign.Text := val1.cwCallsign;

     val1.setRBCallsign(edRBCallsign.Text);
     rfoo := val1.callError;
     rvalid := val1.rbCallsignValid;
     edRBCallsign.Text := val1.rbCallsign;

     val1.setGrid(edStationGrid.Text);
     gfoo := val1.gridError;
     gvalid := val1.gridValid;
     edStationGrid.Text := val1.grid;

     if not svalid then
     begin
          Label4.Visible := true;
          cfg.callsign   := '';
     end
     else
     begin
          Label4.Visible := false;
          cfg.callsign   := val1.callsign;
     end;

     if not cvalid then
     begin
          Label38.Visible := true;
          cfg.cwcallsign := '';
     end
     else
     begin
          Label38.Visible := false;
          cfg.cwcallsign := val1.cwCallsign;
     end;

     if not rvalid then
     begin
          Label40.Visible := true;
          cfg.rbcallsign := '';
     end
     else
     begin
          Label40.Visible := false;
          cfg.rbcallsign := val1.rbCallsign;
     end;

     if not gvalid then
     begin
          Label10.Caption := gfoo;
          Label5.Visible  := true;
          Label9.Visible  := true;
          Label10.Visible := true;
          cfg.grid        := '';
     end
     else
     begin
          Label5.Visible  := false;
          Label9.Visible  := false;
          Label10.Visible := false;
          cfg.grid        := val1.grid;
     end;

     if svalid and cvalid and rvalid and gvalid then
     begin
          // All good, moving on to Tab 1  Values Callsign Suffix/Prefix

          comboPrefix.ItemIndex := 0;
          comboSuffix.ItemIndex := 0;
          label4.Visible := false;
          label7.Visible := false;
          label8.Visible := false;
          Label17.Caption := 'Callsign:  ' + comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex] + '  ' + 'Grid:  ' + edStationGrid.Text + '  CW ID:  ' + edCWCallsign.Text + '  RB ID:  ' + edRBCallsign.Text;
          Label17.Visible := True;
          fullcall.Text := comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex];
          cwcall.Text := val1.cwCallsign;
          rbcall.Text := val1.rbCallsign;
          PageControl1.Pages[1].TabVisible := true;
          PageControl1.ActivePageIndex := 1;
     end
     else
     begin
          // Problems
          if not svalid then
          begin
               label4.Visible := true;
               label7.Visible := true;
               label8.Caption := sfoo;
               label8.Visible := true;
          end;
          if not cvalid then
          begin
               label38.Visible := true;
               label7.Visible := true;
               label8.Caption := cfoo;
               label8.Visible := true;
          end;
          if not rvalid then
          begin
               label40.Visible := true;
               label7.Visible := true;
               label8.Caption := rfoo;
               label8.Visible := true;
          end;
     end;
end;

procedure TForm7.buttonContinue1Click(Sender : TObject);
var
   foo   : String;
   i,j,k : integer;
begin
     // Called from Callsign/Grid Tab
     // Set values for suffix, prefix, cwcall and rbcall
     cfg.prefix := comboPrefix.ItemIndex;
     cfg.suffix := comboSuffix.ItemIndex;
     cfg.cwcallsign := cwcall.Text;
     cfg.rbcallsign := rbcall.Text;
     // Move to tab 2 (audio devices) but populate sound device lists first
     comboSoundIn.Clear;
     comboSoundOut.Clear;
     j := length(dsp.adcList);
     k := length(dsp.dacList);
     for i := 0 to j do
     begin
          if dsp.adcList[i] <> 'NILL' then comboSoundIn.Items.Insert(0,dsp.adcList[i]);
     end;
     for i := 0 to k do
     begin
          if dsp.dacList[i] <> 'NILL' then comboSoundOut.Items.Insert(0,dsp.dacList[i]);
     end;
     // Setup defaults
     cfg.soundIn := dsp.defaultInput;
     cfg.soundInS := dsp.defaultInputName;
     cfg.soundOut := dsp.defaultOutput;
     cfg.soundOutS := dsp.defaultOutputName;
     cfg.soundTested := false;
     cfg.soundExtendedTested := false;
     // Lets try to select the default input and output devices ahead of time...
     // This uses the properties dsp.defaultInput (Int) and dsp.defaultInput (String)
     // dsp.defaultOutput (Int) and dsp.defaultOutputS (String)
     if dsp.defaultInput < 10 then foo := '0' + IntToStr(dsp.defaultInput) + '-' + dsp.defaultInputName else foo := IntToStr(dsp.defaultInput) + '-' + dsp.defaultInputName;
     k := -1;
     for i := 0 to comboSoundIn.Items.Count-1 do
     begin
          if comboSoundIn.Items.Strings[i] = foo then k := i;
     end;
     comboSoundIn.ItemIndex := k;

     if dsp.defaultOutput < 10 then foo := '0' + IntToStr(dsp.defaultOutput) + '-' + dsp.defaultOutputName else foo := IntToStr(dsp.defaultOutput) + '-' + dsp.defaultOutputName;
     k := -1;
     for i := 0 to comboSoundOut.Items.Count-1 do
     begin
          if comboSoundOut.Items.Strings[i] = foo then k := i;
     end;
     comboSoundOut.ItemIndex := k;
     if (comboSoundIn.ItemIndex > -1) and (comboSoundOut.ItemIndex > -1) then
     begin
          buttonTestSound.Enabled := true;
          buttonTestSound.Visible := true;
          cbSRErrorCheck.Enabled  := true;
          cbSRErrorCheck.Visible  := true;
     end;
     PageControl1.Pages[2].TabVisible := true;
     PageControl1.ActivePageIndex := 2;
end;

procedure TForm7.buttonContinue2Click(Sender : TObject);
begin
     // Called from Callsign Suffix/Prefix Tab
     // Configure sound device and continue on to tab 3 (PTT/Rig Control)
     Label44.Caption := ser.serialList;
     if cfg.callsign = 'SWL' Then
     begin
          // Stations using SWL as callsign do not need PTT :)
          RadioGroup1.Enabled := False;
          GroupBox1.Enabled   := False;
          cbCATPTT.Enabled    := False;
          cbCATPTT.Visible    := False;
          cfg.PTTMethod       := 'DISABLED';
          cfg.AltPTT          := false;
     end
     else
     begin
          RadioGroup1.Enabled := true;
          if rbPTTCom.Checked then GroupBox1.Enabled := true else GroupBox1.Enabled := False;
          cbCATPTT.Enabled := true;
          cbCATPTT.Visible := true;
          cfg.PTTMethod := 'DISABLED';
          cfg.AltPTT    := true;
     end;
     PageControl1.Pages[3].TabVisible := true;
     PageControl1.ActivePageIndex := 3;
end;

procedure TForm7.buttonContinue3Click(Sender : TObject);
begin
     // Called from Callsign PTT and Rig Control Tab
     // Save PTT/CAT Settings
     if rbPTTVox.Checked then cfg.PTTMethod := 'VOX';
     if rbPTTCom.Checked then cfg.PTTMethod := 'COM';
     if rbPTTCat.Checked then cfg.PTTMethod := 'CAT';
     if rbPTTNoTX.Checked then cfg.PTTMethod := 'OFF';
     if rbDTRRTS.Checked then cfg.pttLines := 'DTRRTS';
     if rbRTS.Checked then cfg.pttLines := 'RTS';
     if rbDTR.Checked then cfg.pttLines := 'DTR';
     if cbPTTAltCode.Checked then cfg.AltPTT := true else cfg.AltPTT := false;
     if rbHRD.Checked then cfg.CATMethod := 'HRD';
     if rbCommander.Checked then cfg.CATMethod :='COMMANDER';
     if rbOmni.Checked then cfg.CATMethod := 'OMNI';
     if rbNoCAT.Checked then cfg.CATMethod := 'NONE';
     cfg.PTTPort := edPTTPort.Text;
     if rbHRD.Checked or rbCommander.Checked or rbOmni.Checked then cfg.prCATEnabled := true;
     // Move to Tab 4  Values Spotting Network
     if cfg.prCATEnabled then
     begin
          PageControl1.Pages[4].TabVisible := true;
          PageControl1.ActivePageIndex := 4;
     end
     else
     begin
          PageControl1.Pages[5].TabVisible := true;
          PageControl1.ActivePageIndex := 5;
     end;
end;

procedure TForm7.buttonContinue4Click(Sender : TObject);
begin
     // Called from Auto QSY Tab
     if cbEnAutoQSY1.Checked then cfg.prEnQSY1 := true else cfg.prEnQSY1 := false;
     if cbEnAutoQSY2.Checked then cfg.prEnQSY2 := true else cfg.prEnQSY2 := false;
     if cbEnAutoQSY3.Checked then cfg.prEnQSY3 := true else cfg.prEnQSY3 := false;
     if cbEnAutoQSY4.Checked then cfg.prEnQSY4 := true else cfg.prEnQSY4 := false;
     if cbEnAutoQSY5.Checked then cfg.prEnQSY5 := true else cfg.prEnQSY5 := false;
     if cbEnAutoQSY6.Checked then cfg.prEnQSY6 := true else cfg.prEnQSY6 := false;

     cfg.prQSYTime1 := edQSYTime1.Text;
     cfg.prQSYTime2 := edQSYTime2.Text;
     cfg.prQSYTime3 := edQSYTime3.Text;
     cfg.prQSYTime4 := edQSYTime4.Text;
     cfg.prQSYTime5 := edQSYTime5.Text;
     cfg.prQSYTime6 := edQSYTime6.Text;

     cfg.prQSYQRG1 := edQRG1.Text;
     cfg.prQSYQRG2 := edQRG2.Text;
     cfg.prQSYQRG3 := edQRG3.Text;
     cfg.prQSYQRG4 := edQRG4.Text;
     cfg.prQSYQRG5 := edQRG5.Text;
     cfg.prQSYQRG6 := edQRG6.Text;

     if cbEnAT1.Checked then cfg.prQSYTune1 := true else cfg.prQSYTune1 := false;
     if cbEnAT2.Checked then cfg.prQSYTune2 := true else cfg.prQSYTune2 := false;
     if cbEnAT3.Checked then cfg.prQSYTune3 := true else cfg.prQSYTune3 := false;
     if cbEnAT4.Checked then cfg.prQSYTune4 := true else cfg.prQSYTune4 := false;
     if cbEnAT5.Checked then cfg.prQSYTune5 := true else cfg.prQSYTune5 := false;
     if cbEnAT6.Checked then cfg.prQSYTune6 := true else cfg.prQSYTune6 := false;

     PageControl1.Pages[5].TabVisible := true;
     PageControl1.ActivePageIndex := 5;
end;

procedure TForm7.buttonContinue5Click(Sender : TObject);
begin
     // Called from Spotting Networks Tab
     // Save spotting network settings and move on to Macros
     if cbNoSpotting.Checked Then cfg.prNoSpot := True else cfg.prNoSpot := False;
     if cbRBEnable.Checked Then cfg.prRB := True else cfg.prRB := False;
     if cbPSKREnable.Checked Then cfg.prPSKR := True else cfg.prPSKR := False;
     cfg.prRBInfo := edRBInfo.Text;
     PageControl1.Pages[6].TabVisible := true;
     PageControl1.ActivePageIndex := 6;
end;

procedure TForm7.buttonContinue6Click(Sender : TObject);
var
   tstflt : Single;
begin
     // Called from Macros Tab
     // Now... can I learn to iterate the controls via code or do I have to do this by 'hand'

     cfg.prMacros[0] :=  trimleft(trimright(upcase(editMacro1.Text)));
     cfg.prMacros[1] :=  trimleft(trimright(upcase(editMacro2.Text)));
     cfg.prMacros[2] :=  trimleft(trimright(upcase(editMacro3.Text)));
     cfg.prMacros[3] :=  trimleft(trimright(upcase(editMacro4.Text)));
     cfg.prMacros[4] :=  trimleft(trimright(upcase(editMacro5.Text)));
     cfg.prMacros[5] :=  trimleft(trimright(upcase(editMacro6.Text)));
     cfg.prMacros[6] :=  trimleft(trimright(upcase(editMacro7.Text)));
     cfg.prMacros[7] :=  trimleft(trimright(upcase(editMacro8.Text)));
     cfg.prMacros[8] :=  trimleft(trimright(upcase(editMacro9.Text)));
     cfg.prMacros[9] :=  trimleft(trimright(upcase(editMacro10.Text)));
     cfg.prMacros[10] := trimleft(trimright(upcase(editMacro11.Text)));
     cfg.prMacros[11] := trimleft(trimright(upcase(editMacro12.Text)));
     cfg.prMacros[12] := trimleft(trimright(upcase(editMacro13.Text)));
     cfg.prMacros[13] := trimleft(trimright(upcase(editMacro14.Text)));
     cfg.prMacros[14] := trimleft(trimright(upcase(editMacro15.Text)));
     cfg.prMacros[15] := trimleft(trimright(upcase(editMacro16.Text)));
     cfg.prMacros[16] := trimleft(trimright(upcase(editMacro17.Text)));
     cfg.prMacros[17] := trimleft(trimright(upcase(editMacro18.Text)));
     cfg.prMacros[18] := trimleft(trimright(upcase(editMacro19.Text)));
     cfg.prMacros[19] := trimleft(trimright(upcase(editMacro20.Text)));
     cfg.prMacros[20] := trimleft(trimright(upcase(editMacro21.Text)));
     cfg.prMacros[21] := trimleft(trimright(upcase(editMacro22.Text)));
     cfg.prMacros[22] := trimleft(trimright(upcase(editMacro23.Text)));
     cfg.prMacros[23] := trimleft(trimright(upcase(editMacro24.Text)));
     //
     // TValidator.testQRG(const qrg : String; var qrgk : Double; var qrghz : Integer) : Boolean;
     //
     tstflt := 0.0;
     val1.testQRG(editQRG1.Text,tstflt,cfg.prQRGs[0]);
     val1.testQRG(editQRG2.Text,tstflt,cfg.prQRGs[1]);
     val1.testQRG(editQRG3.Text,tstflt,cfg.prQRGs[2]);
     val1.testQRG(editQRG4.Text,tstflt,cfg.prQRGs[3]);
     val1.testQRG(editQRG5.Text,tstflt,cfg.prQRGs[4]);
     val1.testQRG(editQRG6.Text,tstflt,cfg.prQRGs[5]);
     val1.testQRG(editQRG7.Text,tstflt,cfg.prQRGs[6]);
     val1.testQRG(editQRG8.Text,tstflt,cfg.prQRGs[7]);
     val1.testQRG(editQRG9.Text,tstflt,cfg.prQRGs[8]);
     val1.testQRG(editQRG10.Text,tstflt,cfg.prQRGs[9]);
     val1.testQRG(editQRG11.Text,tstflt,cfg.prQRGs[10]);
     val1.testQRG(editQRG12.Text,tstflt,cfg.prQRGs[11]);
     val1.testQRG(editQRG13.Text,tstflt,cfg.prQRGs[12]);
     val1.testQRG(editQRG14.Text,tstflt,cfg.prQRGs[13]);
     val1.testQRG(editQRG15.Text,tstflt,cfg.prQRGs[14]);
     val1.testQRG(editQRG16.Text,tstflt,cfg.prQRGs[15]);
     PageControl1.Pages[7].TabVisible := true;
     PageControl1.ActivePageIndex := 7;
end;

procedure TForm7.buttonContinue7Click(Sender : TObject);
begin
     // Called from Colors Tab
     // Save colors values
     // Tab 7 Values Colors
     if cbDisableColorCoding.Checked then
     begin
          cfg.prNoColor := true;
          cfg.prCQColor  := clWhite;
          cfg.prQSOColor := clWhite;
          cfg.prMyColor  := clWhite;
     end
     else
     begin
          cfg.prNoColor  := false;
          cfg.prCQColor  := colorBoxCQ.Colors[colorBoxCQ.ItemIndex];
          cfg.prQSOColor := colorBoxQSO.Colors[colorBoxQSO.ItemIndex];
          cfg.prMyColor  := colorBoxMine.Colors[colorBoxMine.ItemIndex];
     end;
     PageControl1.Pages[8].TabVisible := true;
     PageControl1.ActivePageIndex := 8;
end;

procedure TForm7.buttonContinue8Click(Sender : TObject);
begin
     // Called from Logging Tab
     // Save values for Logging Tab
     if cbSaveCSV.Checked then cfg.prSaveCSV := true else cfg.prSaveCSV := false;
     if cbSaveDB.Checked then cfg.prSaveDB := true else cfg.prSaveDB := false;
     if cbSaveADIF.Checked then cfg.prSaveADIF := true else cfg.prSaveADIF :=false;
     if cbdoeqsl.Checked then cfg.prdoeQSL := true else cfg.prdoeQSL := false;
     if cbdoDXLab.Checked then cfg.prdodxLab := true else cfg.prdodxLab := false;
     PageControl1.Pages[9].TabVisible := true;
     PageControl1.ActivePageIndex := 9;
end;

procedure TForm7.buttonContinue9Click(Sender : TObject);
begin
     // Called from Advanced Tab
     if cbDisableMultiInQSO.Checked then cfg.prNoMultiQSO := true else cfg.prNoMultiQSO := false;
     if cbEnableMultiAfterQSO.Checked then cfg.prMultiRestore := true else cfg.prMultiRestore := false;
     if cbRestoresDefaultsMulti.Checked then cfg.prMultiDefMulti := true else cfg.prMultiDefMulti := false;
     if cbSendCWIDFree.Checked then cfg.prCWIDfree := true else cfg.prCWIDfree := false;
     if cbSendCWIDAll.Checked then cfg.prCWIDall := true else cfg.prCWIDall := false;
     if cbTXWatchdog.Checked then cfg.prTXWatchDog := true else cfg.prTXWatchdog := false;
     cfg.prTXWatchdogInt := spinTXCount.Value;
     if cbUseOptFFT.Checked then cfg.prUseOptFFT := true else cfg.prUseOptFFT := false;
     if cbUseKV.Checked then cfg.prUseKV := true else cfg.prUseKV := false;
     if cbAutoRXSR.Checked then cfg.prRXAutoSR := true else cfg.prRXAutoSR := false;
     if cbAutoTXSR.Checked then cfg.prTXAutoSR := true else cfg.prTXAutoSR := false;
     // Setup Review Tab
     Label53.Caption := 'Callsign Used for Over The Air Transmissions:  ' + cfg.prCallsign;
     Label54.Caption := 'Callsign Used for Over The Air CW ID:  ' + cfg.prCWCallsign;
     Label55.Caption := 'Callsign Used for Internet Spotting Network(s):  ' + cfg.prRBCallsign;
     Label56.Caption := 'Grid Square:  ' + cfg.prGrid;
     Label57.Caption := 'Sound Device for Output:  ' + cfg.prSoundOutS;
     Label58.Caption := 'Sound Device for Input:  ' + cfg.prSoundInS;
     Label59.Caption := 'PTT Control Method:  ' + cfg.prPTTMethod;
     Label60.Caption := 'Rig Control Method:  ' + cfg.prCATMethod;
     if cfg.prCWIDfree then Label61.Caption := 'CW ID is enabled for SH and Text Messages';
     if cfg.prCWIDall  then Label61.Caption := 'CW ID is enabled for SH, Text and normal 73 Messages';
     if not cfg.prCWIDall and not cfg.prCWIDfree then Label61.Visible := false else Label61.Visible := true;
     // Move to Tab 10 Review
     PageControl1.Pages[10].TabVisible := true;
     PageControl1.ActivePageIndex := 10;
end;

procedure TForm7.buttonContinue10Click(Sender : TObject);
begin
     // Called from Review Tab
     // Configuration complete and user has theoretically reviewed and
     // approved the configuration.
     // Need to save the configuration
     saveConfig(cfg.prCFGName);
     // All done, hide window and back to main program loop.
     // Free the portaudio object now that we're done with it.
     srgraph.Form8.series1.Clear;
     srgraph.Form8.series2.Clear;
     srgraph.Form8.series3.Clear;
     srgraph.Form8.series4.Clear;
     dsp.terminate();
     self.Hide;
     going := False;
end;


procedure TForm7.buttonEnableSuffixPrefixClick(Sender : TObject);
begin
     if buttonEnableSuffixPrefix.Caption = 'Enable Suffix or Prefix for your callsign' Then
     Begin
          Label1.Visible := False;
          Label15.Visible := True;
          Label16.Visible := True;
          comboPrefix.Visible := True;
          comboPrefix.Enabled := True;
          comboSuffix.Visible := True;
          comboSuffix.Enabled := True;
          Label17.Caption := 'Callsign:  ' + comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex] + '  ' + 'Grid:  ' + edStationGrid.Text + '  CW ID:  ' + edCWCallsign.Text + '  RB ID:  ' + edRBCallsign.Text;
          Label17.Visible := True;
          fullcall.Text := comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex];
          buttonEnableSuffixPrefix.Caption := 'Disable Suffix or Prefix for your callsign'
     end
     else
     begin
          Label1.Visible := True;
          Label15.Visible := False;
          Label16.Visible := False;
          Label17.Caption := 'Callsign:  ' + comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex] + '  ' + 'Grid:  ' + edStationGrid.Text + '  CW ID:  ' + edCWCallsign.Text + '  RB ID:  ' + edRBCallsign.Text;
          Label17.Visible := True;
          comboPrefix.ItemIndex := 0;
          comboSuffix.ItemIndex := 0;
          comboPrefix.Visible := False;
          comboPrefix.Enabled := False;
          comboSuffix.Visible := False;
          comboSuffix.Enabled := False;
          buttonEnableSuffixPrefix.Caption := 'Enable Suffix or Prefix for your callsign';
          fullcall.Text := comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex];
     end;
end;

procedure TForm7.buttonTestSerialPTTClick(Sender : TObject);
begin
     ser.port := trimleft(trimright(upcase(edPTTPort.Text)));
     ser.ptt  := false;
     ser.togglePTT();
     sleep(1000);
     ser.togglePTT();
     cfg.pttTested := true;
end;

procedure TForm7.comboSoundInChange(Sender : TObject);
var
   foo : String;
   i   : integer;
begin
     if (comboSoundIn.ItemIndex > 0) and (comboSoundOut.ItemIndex > 0) then
     begin
          buttonTestSound.Enabled := true;
          buttonTestSound.Visible := true;
          cbSRErrorCheck.Enabled := true;
          cbSRErrorCheck.Visible := true;
          cbSRErrorCheck.Checked := false;
          foo := comboSoundIn.Items.Strings[comboSoundIn.ItemIndex];
          if length(foo) > 2 then
          begin
               cfg.soundIn := strToInt(foo[1..2]);
               i := length(foo);
               cfg.soundInS := foo[4..i];
          end;
     end
     else
     begin
          buttonTestSound.Enabled := false;
          buttonTestSound.Visible := true;
          cbSRErrorCheck.Enabled := false;
          cbSRErrorCheck.Visible := true;
          cbSRErrorCheck.Checked := false;
          cfg.soundIn := -1;
          cfg.soundInS := 'Nil';
     end;
end;

procedure TForm7.comboSoundOutChange(Sender : TObject);
var
   foo : String;
   i : integer;
begin
     if (comboSoundIn.ItemIndex > 0) and (comboSoundOut.ItemIndex > 0) then
     begin
          buttonTestSound.Enabled := true;
          buttonTestSound.Visible := true;
          cbSRErrorCheck.Enabled := true;
          cbSRErrorCheck.Visible := true;
          cbSRErrorCheck.Checked := false;
          foo := comboSoundOut.Items.Strings[comboSoundOut.ItemIndex];
          if length(foo) > 2 then
          begin
               cfg.soundOut := strToInt(foo[1..2]);
               i := length(foo);
               cfg.soundOutS := foo[4..i];
          end;
     end
     else
     begin
          buttonTestSound.Enabled := false;
          buttonTestSound.Visible := true;
          cbSRErrorCheck.Enabled := false;
          cbSRErrorCheck.Visible := true;
          cbSRErrorCheck.Checked := false;
          cfg.soundOut := -1;
          cfg.soundOutS := 'Nil';
     end;
end;

procedure TForm7.comboSuffixChange(Sender : TObject);
begin
     // A suffix has been selectected.  Insure that suffix is set to -1
     // and update callsign readout.
     if comboSuffix.ItemIndex > -1 then
     begin
          comboPrefix.ItemIndex := 0;
          fullcall.Text := comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex];
          if cwcall.Text <> fullcall.Text then
          begin
               if MessageDlg('Question', 'CW Call is:  ' + cwcall.Text + sLineBreak + 'Station Call is:  ' + fullcall.Text + sLineBreak + 'Would you like to set CW call to Station Call?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
               begin
                    cwcall.Text := fullcall.Text;
               end
               else
               begin
                    cwcall.Text := edCWCallsign.Text;
               end;
          end;
          if not (rbcall.Text = fullcall.Text) then
          begin
               if MessageDlg('Question', 'RB Call is:  ' + rbcall.Text + sLineBreak + 'Station Call is:  ' + fullcall.Text + sLineBreak + 'Would you like to set CW call to Station Call?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
               begin
                    rbcall.Text := fullcall.Text;
               end
               else
               begin
                    rbcall.Text := edRBCallsign.Text;
               end;
          end;
          Label17.Caption := 'Callsign:  ' + fullcall.text + '  ' + 'Grid:  ' + edStationGrid.Text + '  CW ID:  ' + cwcall.Text + '  RB ID:  ' + rbcall.Text;
          Label17.Visible := True;
     end;
end;

procedure TForm7.edStationCallsignChange(Sender : TObject);
var
   i     : integer;
   valid : Boolean;
   foo   : String;
begin
     // Universal routine to handle validation of fields edStationCallsign, edCWCallsign and edRBCallsign
     valid := True;
     foo := TEdit(sender).Text;
     for i := 1 to length(foo) do
     begin
          if Sender = edStationCallSign then
          begin
               if not val1.asciiValidate(Char(foo[i]),'csign') then valid := false;
               if not val1.asciiValidate(Char(foo[i]),'csign') then foo[i] := ' ';
          end;
          if Sender = edStationGrid then
          begin
               if not val1.asciiValidate(Char(foo[i]),'gsign') then valid := false;
               if not val1.asciiValidate(Char(foo[i]),'gsign') then foo[i] := ' ';
          end;
          if (Sender = edCWCallsign) or (Sender = edRBCallsign) then
          begin
               if not val1.asciiValidate(Char(foo[i]),'xcsign') then valid := false;
               if not val1.asciiValidate(Char(foo[i]),'xcsign') then foo[i] := ' ';
          end;
     end;
     foo := trimleft(trimright(foo));
     if not valid then TEdit(sender).Text := foo;
     if not valid then TEdit(sender).SelStart := length(TEdit(sender).Text);
     if Sender = edStationCallSign then
     begin
          edCWCallsign.Text := edStationCallsign.Text;
          edRBCallsign.Text := edStationCallsign.Text;
     end;
end;

procedure TForm7.FormShow(Sender : TObject);
begin
     if prepop then
     begin
          PageControl1.Pages[0].TabVisible := true;
          PageControl1.Pages[1].TabVisible := true;
          PageControl1.Pages[2].TabVisible := true;
          PageControl1.Pages[3].TabVisible := true;
          PageControl1.Pages[4].TabVisible := true;
          PageControl1.Pages[5].TabVisible := true;
          PageControl1.Pages[6].TabVisible := true;
          PageControl1.Pages[7].TabVisible := true;
          PageControl1.Pages[8].TabVisible := true;
          PageControl1.Pages[9].TabVisible := true;
          PageControl1.Pages[10].TabVisible := true;
          PageControl1.ActivePageIndex := 0;
     end
     else
     begin
          PageControl1.Pages[0].TabVisible := true;
          PageControl1.Pages[1].TabVisible := false;
          PageControl1.Pages[2].TabVisible := false;
          PageControl1.Pages[3].TabVisible := false;
          PageControl1.Pages[4].TabVisible := false;
          PageControl1.Pages[5].TabVisible := false;
          PageControl1.Pages[6].TabVisible := false;
          PageControl1.Pages[7].TabVisible := false;
          PageControl1.Pages[8].TabVisible := false;
          PageControl1.Pages[9].TabVisible := false;
          PageControl1.Pages[10].TabVisible := false;
          PageControl1.ActivePageIndex := 0;
     end;
end;

procedure TForm7.editMacro1Change(Sender : TObject);
var
   i     : integer;
   valid : Boolean;
   foo   : String;
begin
     // Universal routine to handle validation of macro definition fields
     valid := True;
     foo := TEdit(sender).Text;
     for i := 1 to length(foo) do
     begin
          if not val1.asciiValidate(Char(foo[i]),'free') then valid := false;
          if not val1.asciiValidate(Char(foo[i]),'free') then foo[i] := ' ';
     end;
     foo := trimleft(trimright(foo));
     if not valid then TEdit(sender).Text := foo;
     if not valid then TEdit(sender).SelStart := length(TEdit(sender).Text);
end;

function  TForm7.macroVal(macro : String) : String;
Var
   i : Integer;
   foo : String;
Begin
     // Routine to handle validation of macros when reading back from saved configuration
     foo := macro;
     for i := 1 to length(foo) do
     begin
          if not val1.asciiValidate(Char(foo[i]),'free') then foo[i] := ' ';
     end;
     foo := trimleft(trimright(foo));
     result := foo;
end;

procedure TForm7.editQRG1Change(Sender : TObject);
var
   i     : integer;
   valid : Boolean;
   foo   : String;
begin
     // Universal routine to handle validation of QRG definition fields
     valid := True;
     foo := TEdit(sender).Text;
     for i := 1 to length(foo) do
     begin
          if not val1.asciiValidate(Char(foo[i]),'numeric') then valid := false;
          if not val1.asciiValidate(Char(foo[i]),'numeric') then foo[i] := ' ';
     end;
     foo := trimleft(trimright(foo));
     if not valid then TEdit(sender).Text := foo;
     if not valid then TEdit(sender).SelStart := length(TEdit(sender).Text);
end;

procedure TForm7.comboPrefixChange(Sender : TObject);
begin
     // A prefix has been selectected.  Insure that suffix is set to -1
     // and update callsign readout.
     if comboPrefix.ItemIndex > -1 then
     begin
          comboSuffix.ItemIndex := 0;
          fullcall.Text := comboPrefix.Items[comboPrefix.ItemIndex] + edStationCallsign.Text + comboSuffix.Items[comboSuffix.ItemIndex];
          if not (cwcall.Text = fullcall.Text) then
          begin
               if MessageDlg('Question', 'CW Call is:  ' + cwcall.Text + sLineBreak + 'Station Call is:  ' + fullcall.Text + sLineBreak + 'Would you like to set CW call to Station Call?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
               begin
                    cwcall.Text := fullcall.Text;
               end
               else
               begin
                    cwcall.Text := edCWCallsign.Text;
               end;
          end;
          if not (rbcall.Text = fullcall.Text) then
          begin
               if MessageDlg('Question', 'RB Call is:  ' + rbcall.Text + sLineBreak + 'Station Call is:  ' + fullcall.Text + sLineBreak + 'Would you like to set CW call to Station Call?', mtConfirmation, [mbYes, mbNo],0) = mrYes then
               begin
                    rbcall.Text := fullcall.Text;
               end
               else
               begin
                    rbcall.Text := edRBCallsign.Text;
               end;
          end;
          Label17.Caption := 'Callsign:  ' + fullcall.text + '  ' + 'Grid:  ' + edStationGrid.Text + '  CW ID:  ' + cwcall.Text + '  RB ID:  ' + rbcall.Text;
          Label17.Visible := True;
     end;
end;

procedure TForm7.edPTTPortChange(Sender : TObject);
begin
     if edPTTPort.Text = 'COMXXX' then buttonTestSerialPTT.Enabled := false else buttonTestSerialPTT.Enabled := true;
end;

procedure TForm7.edQSYTime1Change(Sender : TObject);
var
   valarray : Array[0..10] of String;
   i, j     : Integer;
   valid    : Boolean;
   foo      : String;
   hh,mm    : Integer;
begin
     valarray[0] := '0';
     valarray[1] := '1';
     valarray[2] := '2';
     valarray[3] := '3';
     valarray[4] := '4';
     valarray[5] := '5';
     valarray[6] := '6';
     valarray[7] := '7';
     valarray[8] := '8';
     valarray[9] := '9';
     valarray[10] := ':';
     // Universal validator for time input fields
     valid := true;
     foo := TEdit(sender).Text;
     for i := 1 to length(foo) do
     begin
          j := ansiIndexStr(foo[i],valarray);
          If j > -1 then foo[i] := foo[i] else foo[i] := '0';
     end;
     if (length(foo) = 4) or (length(foo) = 5) then
     begin
          // Lets see if we have a winner...
          if length(foo) = 5 then
          begin
               // This should be ##:##
               if foo[3] = ':' then
               begin
                    hh := strToInt(foo[1..2]);
                    mm := strToInt(foo[4..5]);
                    if ((hh > -1) and (hh < 24)) and ((mm > -1) and (mm < 60)) then valid := true else valid := false;
                    if not valid then foo := '';
               end;
          end;
          if length(foo) = 4 then
          begin
               // This could be #### or ##:# with ##:# being an incomplete entry
               if foo[3] = ':' then
               begin
                    // Nada
               end
               else
               begin
                    hh := strToInt(foo[1..2]);
                    mm := strToInt(foo[3..4]);
                    if ((hh > -1) and (hh < 24)) and ((mm > -1) and (hh < 60)) then valid := true else valid := false;
                    if not valid then foo := '';
               end;
          end;
     end;
     TEdit(Sender).Text := foo;

end;

procedure TForm7.rbPTTCatChange(Sender : TObject);
begin
     if rbPTTCat.Checked then groupbox1.Enabled := false;
     if rbPTTCat.Checked then cbCATPTT.Checked := true else cbCATPTT.Checked := false;
     if rbPTTCat.Checked then cbCATPTT.Enabled := true;
end;

procedure TForm7.rbPTTComChange(Sender : TObject);
begin
     if rbPTTCom.Checked then groupbox1.Enabled := true;
     if rbPTTCom.Checked then cbCATPTT.Checked := false;
     if rbPTTCom.Checked then cbCATPTT.Enabled := true;
end;

procedure TForm7.rbPTTNoTXChange(Sender : TObject);
begin
     if rbPTTNoTX.Checked then groupbox1.Enabled := false;
     if rbPTTNoTX.Checked then cbCATPTT.Checked := false;
     if rbPTTNoTX.Checked then cbCATPTT.Enabled := false;
end;

procedure TForm7.rbPTTVoxChange(Sender : TObject);
begin
     if rbPTTVox.Checked then groupbox1.Enabled := false;
     if rbPTTVox.Checked then cbCATPTT.Checked := false;
     if rbPTTVox.Checked then cbCATPTT.Enabled := true;
end;

procedure TForm7.Timer1Timer(Sender : TObject);
begin
     timer1.Enabled := false;
     fail := true;

end;

procedure TForm7.buttonTestSoundClick(Sender : TObject);
var
   foo : string;
   minerr, mouterr, sinerr, souterr : string;
   sinok, minok, soutok, moutok : Boolean;
   i,lb,erb,aerb, erbt, aerbt : integer;
   er, ert, adctime : CDouble;
   lastadccount, thisadccount : integer;
   adcerr, dacerr : String;
   stereovalid, monovalid : Boolean;
begin
     srgraph.Form8.hide;
     buttonContinue2.Enabled := false;
     buttonTestSound.Enabled := false;
     cbSRErrorCheck.Enabled  := false;
     cbForceMonoIO.Enabled := false;
     comboSoundIn.Enabled := false;
     comboSoundOut.Enabled := false;
     // Disable tab moves during testing
     PageControl1.Pages[0].Enabled := false;
     PageControl1.Pages[1].Enabled := false;
     PageControl1.Pages[3].Enabled := false;
     PageControl1.Pages[4].Enabled := false;
     PageControl1.Pages[5].Enabled := false;
     PageControl1.Pages[6].Enabled := false;
     PageControl1.Pages[7].Enabled := false;
     PageControl1.Pages[8].Enabled := false;
     PageControl1.Pages[0].TabVisible := false;
     PageControl1.Pages[1].TabVisible := false;
     PageControl1.Pages[3].TabVisible := false;
     PageControl1.Pages[4].TabVisible := false;
     PageControl1.Pages[5].TabVisible := false;
     PageControl1.Pages[6].TabVisible := false;
     PageControl1.Pages[7].TabVisible := false;
     PageControl1.Pages[8].TabVisible := false;
     // Validator booleans
     sinok  := false;  // Stereo in OK
     minok  := false;  // Mono in OK
     soutok := false;  // Stereo out OK
     moutok := false;  // Mono out OK
     // Error messages
     minerr  := '';  // Error for open input mono
     sinerr  := '';  // Error for open input stereo
     mouterr := '';  // Error for open output mono
     souterr := '';  // Error for open output stereo
     // Clear the diagnostics output box
     listBoxSoundDiag.Clear;
     // Start of tests
     if not cbForceMonoIO.Checked then
     begin
          // Start simple test with input device in stereo mode
          // First check with test open type then, if passes, do real open/start/stop/close cycle.
          dsp.inputChannels := 2;
          // Extract PA device ID from string in combobox
          foo := comboSoundIn.Items.Strings[comboSoundIn.ItemIndex];
          if length(foo) > 1 then dsp.paInputDevice := StrToInt(foo[1..2]) else dsp.paInputDevice := -1;
          // Attempt to open device in test mode
          dsp.testInputDevice();
          // Did it work?
          if dsp.lastResult <> 0 then
          begin
               sinerr := '  Test input device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               sinok := false;
          end
          else
          begin
               sinerr := '  Test input device [Stereo Mode]:  PASS';
               sinok := true;
          end;
          // Post result
          listBoxSoundDiag.Items.Add(sinerr);
          if sinok then
          begin
               // Test parameters open passed so do the real deal now.
               // Enable watchdog timer so we can break out in case of a hang
               timer1.Enabled := true;
               dsp.adcOn();
               if dsp.lastResult <> 0 Then
               Begin
                    // Failed to open.
                    sinerr := '  Open input device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
                    sinok := false;
               end
               else
               begin
                    sinerr := '  Open input device [Stereo Mode]:  PASS';
                    sinok := true;
               end;
               // Post result
               listBoxSoundDiag.Items.Add(sinerr);
               // Now, if open passed I need to shut it down
               if dsp.adcRunning then
               begin
                    dsp.adcOff();
               end;
               if dsp.lastResult <> 0 then
               begin
                    // Failed to close
                    sinerr := ' Close input device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
                    sinok := false;
               end
               else
               begin
                    // All is well
                    sinerr := ' Close input device [Stereo Mode]:  PASS';
                    sinok := true;
               end;
               timer1.Enabled := false;
               // Post result
               listBoxSoundDiag.Items.Add(sinerr);
          end;
          // Now output device in stereo mode
          dsp.outputChannels := 2;
          // Extract PA device ID from string in combobox
          foo := comboSoundOut.Items.Strings[comboSoundOut.ItemIndex];
          if length(foo) > 1 then dsp.paOutputDevice := StrToInt(foo[1..2]) else dsp.paOutputDevice := -1;
          // Attempt to open device in test mode
          dsp.testOutputDevice();
          // Did it work?
          if dsp.lastResult <> 0 then
          begin
               souterr := ' Test output device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               soutok := false;
          end
          else
          begin
               souterr := ' Test output device [Stereo Mode]:  PASS';
               soutok := true;
          end;
          // Post result
          listBoxSoundDiag.Items.Add(souterr);
          if soutok then
          begin
               // Test parameters open passed so do the real deal now.
               // Enable watchdog timer so we can break out in case of a hang
               timer1.Enabled := true;
               dsp.dacOn();
               if dsp.lastResult <> 0 Then
               Begin
                    // Failed to open.
                    souterr := ' Open output device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
                    soutok := false;
               end
               else
               begin
                    souterr := ' Open output device [Stereo Mode]:  PASS';
                    soutok := true;
               end;
               // Post result
               listBoxSoundDiag.Items.Add(souterr);
               // Now, if open passed I need to shut it down
               if dsp.dacRunning then
               begin
                    dsp.dacOff();
               end;
               if dsp.lastResult <> 0 then
               begin
                    // Failed to close
                    souterr := 'Close output device [Stereo Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
                    soutok := false;
               end
               else
               begin
                    // All is well
                    souterr := 'Close output device [Stereo Mode]:  PASS';
                    soutok := true;
               end;
               timer1.Enabled := false;
               // Post result
               listBoxSoundDiag.Items.Add(souterr);
          end;
          if soutok and sinok then stereovalid := true else stereovalid := false;
     end
     else
     begin
          // Use has forced mono mode so force stereo to be invalid
          stereovalid := false;
     end;
     // Now input device in mono mode
     // Start simple test with input device in mono mode
     // First check with test open type then, if passes, do real open/start/stop/close cycle.
     dsp.inputChannels := 1;
     // Extract PA device ID from string in combobox
     foo := comboSoundIn.Items.Strings[comboSoundIn.ItemIndex];
     if length(foo) > 1 then dsp.paInputDevice := StrToInt(foo[1..2]) else dsp.paInputDevice := -1;
     // Attempt to open device in test mode
     dsp.testInputDevice();
     // Did it work?
     if dsp.lastResult <> 0 then
     begin
          minerr := '  Test input device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
          minok := false;
     end
     else
     begin
          minerr := '  Test input device [Mono Mode]:  PASS';
          minok := true;
     end;
     // Post result
     listBoxSoundDiag.Items.Add(minerr);
     if minok then
     begin
          // Test parameters open passed so do the real deal now.
          // Enable watchdog timer so we can break out in case of a hang
          timer1.Enabled := true;
          dsp.adcOn();
          if dsp.lastResult <> 0 Then
          Begin
               // Failed to open.
               minerr := '  Open input device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               minok := false;
          end
          else
          begin
               minerr := '  Open input device [Mono Mode]:  PASS';
               minok := true;
          end;
          // Post result
          listBoxSoundDiag.Items.Add(minerr);
          // Now, if open passed I need to shut it down
          if dsp.adcRunning then
          begin
               dsp.adcOff();
          end;
          if dsp.lastResult <> 0 then
          begin
               // Failed to close
               minerr := ' Close input device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               minok := false;
          end
          else
          begin
               // All is well
               minerr := ' Close input device [Mono Mode]:  PASS';
               minok := true;
          end;
          timer1.Enabled := false;
          // Post result
          listBoxSoundDiag.Items.Add(minerr);
     end;
     // Now output device in mono mode
     dsp.outputChannels := 1;
     // Extract PA device ID from string in combobox
     foo := comboSoundOut.Items.Strings[comboSoundOut.ItemIndex];
     if length(foo) > 1 then dsp.paOutputDevice := StrToInt(foo[1..2]) else dsp.paOutputDevice := -1;
     // Attempt to open device in test mode
     dsp.testOutputDevice();
     // Did it work?
     if dsp.lastResult <> 0 then
     begin
          mouterr := ' Test output device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
          moutok := false;
     end
     else
     begin
          mouterr := ' Test output device [Mono Mode]:  PASS';
          moutok := true;
     end;
     // Post result
     listBoxSoundDiag.Items.Add(mouterr);
     if moutok then
     begin
          // Test parameters open passed so do the real deal now.
          // Enable watchdog timer so we can break out in case of a hang
          timer1.Enabled := true;
          dsp.dacOn();
          if dsp.lastResult <> 0 Then
          Begin
               // Failed to open.
               mouterr := ' Open output device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               moutok := false;
          end
          else
          begin
               mouterr := ' Open output device [Mono Mode]:  PASS';
               moutok := true;
          end;
          // Post result
          listBoxSoundDiag.Items.Add(mouterr);
          // Now, if open passed I need to shut it down
          if dsp.dacRunning then
          begin
               dsp.dacOff();
          end;
          if dsp.lastResult <> 0 then
          begin
               // Failed to close
               mouterr := 'Close output device [Mono Mode]:  FAIL' + '    ' + 'Error was:  ' + dsp.lastError;
               moutok := false;
          end
          else
          begin
               // All is well
               mouterr := 'Close output device [Mono Mode]:  PASS';
               moutok := true;
          end;
          timer1.Enabled := false;
          // Post result
          listBoxSoundDiag.Items.Add(mouterr);
     end;
     if moutok and minok then monovalid := true else monovalid := false;

     if (monovalid or stereovalid) and cbSRErrorCheck.Checked then
     begin
          // Now to more extensive test (if selected) and valid i/o set found
          listBoxSoundDiag.Items.clear;
          // Set mono/stereo mode based on earlier test (or user choice if forced mono)
          if stereovalid then dsp.inputChannels  := 2 else dsp.inputChannels  := 1;
          if stereovalid then dsp.outputChannels := 2 else dsp.outputChannels := 1;
          if stereovalid then listBoxSoundDiag.Items.Add('Starting extended testing [Stereo I/O]') else listBoxSoundDiag.Items.Add('Starting extended testing [Mono I/O]');
          fail := false;
          // Enable hang timer
          timer1.Enabled := true;
          // Clear the error tracking graphs
          srgraph.Form8.series1.Clear;
          srgraph.Form8.series2.Clear;
          srgraph.Form8.series3.Clear;
          srgraph.Form8.series4.Clear;
          // Start ADC
          dsp.adcOn();
          adcerr := dsp.getLastError();
          // Start DAC
          dsp.dacOn();
          dacerr := dsp.getLastError();
          // Disable hang timer for now
          timer1.Enabled := false;
          if dsp.adcRunning and dsp.dacRunning then
          begin
               // Setup the long term SR evaluation loop
               lastadccount := 0;
               thisadccount := 0;
               i := 1;
               er := 1.0;
               ert := 1.0;
               lb   := listBoxSoundDiag.Items.Add('Processing sample block ' + intToStr(dsp.adcCount) + ' of 1615  [ Time Index:  0 ]');
               listBoxSoundDiag.Items.Add('              Input Device Status:  ' + adcerr);
               listBoxSoundDiag.Items.Add('             Output Device Status:  ' + dacerr);
               erb   := listBoxSoundDiag.Items.Add('Short Term Averaged SR Error [RX]:  Calculating...');
               aerb  := listBoxSoundDiag.Items.Add(' Long Term Averaged SR Error [RX]:  Calculating...');
               erbt  := listBoxSoundDiag.Items.Add('Short Term Averaged SR Error [TX]:  Calculating...');
               aerbt := listBoxSoundDiag.Items.Add(' Long Term Averaged SR Error [TX]:  Calculating...');
               srgraph.Form8.series1.AddXY(0,dsp.adcErate);
               srgraph.Form8.series2.AddXY(0,1.0000);
               srgraph.Form8.series3.AddXY(0,dsp.dacErate);
               srgraph.Form8.series4.AddXY(0,1.0000);
               // Start the long term SR evaluation loop.  Running for 1615 2048 sample blocks (about 5 minutes)
               while (dsp.adcCount < 1615) and not fail do
               begin
                    // Enable hang timer
                    timer1.Enabled := true;
                    // Calculate time into loop based on adc count
                    adctime := ((1/11025)*2048) * dsp.adcCount;
                    thisadccount := dsp.adccount;
                    if thisadccount > lastadccount+1 then
                    begin
                         // update 1 second stats
                         timer1.Enabled := false;
                         fail := false;
                         lastadccount := thisadccount;
                         if adctime > 120 then er := er + dsp.adcErate;
                         if adctime > 120 then ert := ert + dsp.dacErate;
                         if adctime > 120 then inc(i);
                         srgraph.Form8.series1.AddXY(adctime,dsp.adcErate);
                         srgraph.Form8.series3.AddXY(adctime,dsp.dacErate);
                         listBoxSoundDiag.Items.Strings[erb]  := 'Short Term Averaged SR Error [RX]:  ' + floatToStrF(dsp.adcErate,ffFixed,0,4) + ' : 1.0000';
                         listBoxSoundDiag.Items.Strings[erbt] := 'Short Term Averaged SR Error [TX]:  ' + floatToStrF(dsp.dacErate,ffFixed,0,4) + ' : 1.0000';
                         if adctime > 120 then srgraph.Form8.series2.AddXY(adctime,er/i);
                         if adctime > 120 then srgraph.Form8.series4.AddXY(adctime,ert/i);
                         if adctime > 120 then listBoxSoundDiag.Items.Strings[aerb]  := ' Long Term Averaged SR Error [RX]:  ' + floatToStrF(er/i,ffFixed,0,4) + ' : 1.0000';
                         if adctime > 120 then listBoxSoundDiag.Items.Strings[aerbt] := ' Long Term Averaged SR Error [TX]:  ' + floatToStrF(ert/i,ffFixed,0,4) + ' : 1.0000';
                    end;
                    listBoxSoundDiag.Items.Strings[lb] :='Processing sample block ' + intToStr(dsp.adcCount) + ' of 1615  [ Time Index:  ' + floatToStrF(adctime,ffFixed,0,0) + ' ]';
                    application.ProcessMessages;
                    sleep(100);
               end;
               // Test loop complete display result
               listboxSoundDiag.Items.Add('                  Input Overflows:  ' + IntToStr(dsp.adcOverrun));
               listboxSoundDiag.Items.Add('                Output Underflows:  ' + IntToStr(dsp.dacUnderrun));
               listBoxSoundDiag.Items.Add('              2K Blocks processed:  ' + IntToStr(dsp.adcCount));
          end
          else
          begin
               // Failed
               listBoxSoundDiag.Items.Add('              Input Device Status:  ' + dsp.getLastError());
          end;
          // Clean up
          if dsp.adcRunning then dsp.adcOff();
          if dsp.adcRunning then listBoxSoundDiag.Items.Add('        Close Input Device result:  ' + dsp.getLastError()) else listBoxSoundDiag.Items.Add('        Close Input Device result:  ' + dsp.getLastError());
          if dsp.dacRunning then dsp.dacOff();
          if dsp.dacRunning then listBoxSoundDiag.Items.Add('       Close Output Device result:  ' + dsp.getLastError()) else listBoxSoundDiag.Items.Add('       Close Output Device result:  ' + dsp.getLastError());
          if fail then listBoxSoundDiag.Clear;
          if fail then listBoxSoundDiag.Items.Add('Testing failed.  Sound device access timeout.');
          if not fail then
          begin
               srgraph.form8.srchart.Extent.XMax := srgraph.form8.series1.GetXMax;
               srgraph.form8.srchart.Extent.XMin := srgraph.form8.series1.GetXMin;
               srgraph.form8.srchart.Extent.YMax := srgraph.form8.series1.GetYMax;
               srgraph.form8.srchart.Extent.YMin := srgraph.form8.series1.GetYMin;
               srgraph.Form8.srChart.Refresh;
               srgraph.form8.srchart1.Extent.XMax := srgraph.form8.series1.GetXMax;
               srgraph.form8.srchart1.Extent.XMin := srgraph.form8.series1.GetXMin;
               srgraph.form8.srchart1.Extent.YMax := srgraph.form8.series1.GetYMax;
               srgraph.form8.srchart1.Extent.YMin := srgraph.form8.series1.GetYMin;
               srgraph.Form8.srChart1.Refresh;
               srgraph.Form8.Show;
               srgraph.Form8.BringToFront;
          end
          else
          begin
               srgraph.Form8.hide;
          end;
          cfg.soundExtendedTested := true;
          cfg.soundTested := true;
     end
     else
     begin
          // Did not do extended test
          cfg.soundExtendedTested := false;
          cfg.soundTested := true;
     end;
     // Resture tabs and buttons
     buttonContinue2.Enabled := true;
     buttonTestSound.Enabled := true;
     cbSRErrorCheck.Enabled  := true;
     cbForceMonoIO.Enabled   := true;
     comboSoundIn.Enabled := true;
     comboSoundOut.Enabled := true;
     PageControl1.Pages[0].Enabled := true;
     PageControl1.Pages[1].Enabled := true;
     PageControl1.Pages[3].Enabled := true;
     PageControl1.Pages[4].Enabled := true;
     PageControl1.Pages[5].Enabled := true;
     PageControl1.Pages[6].Enabled := true;
     PageControl1.Pages[7].Enabled := true;
     PageControl1.Pages[8].Enabled := true;
     PageControl1.Pages[0].TabVisible := true;
     PageControl1.Pages[1].TabVisible := true;
     PageControl1.Pages[3].TabVisible := true;
     PageControl1.Pages[4].TabVisible := true;
     PageControl1.Pages[5].TabVisible := true;
     PageControl1.Pages[6].TabVisible := true;
     PageControl1.Pages[7].TabVisible := true;
     PageControl1.Pages[8].TabVisible := true;
end;

procedure TForm7.cbDisableColorCodingChange(Sender : TObject);
begin
     if cbDisableColorCoding.Checked then
     begin
          cqtext.Color := clWhite;
          cqtext1.Color := clWhite;
          tometext.Color := clWhite;
          tometext1.Color := clWhite;
          qsotext.Color := clWhite;
          qsotext1.Color := clWhite;
          colorBoxCQ.Enabled := false;
          colorBoxQSO.Enabled := false;
          colorBoxMine.Enabled := false;
     end
     else
     begin
          colorBoxCQ.Enabled := true;
          colorBoxQSO.Enabled := true;
          colorBoxMine.Enabled := true;
          cqtext.Color := colorBoxCQ.Colors[colorBoxCQ.ItemIndex];
          cqtext1.Color := colorBoxCQ.Colors[colorBoxCQ.ItemIndex];
          tometext.Color := colorBoxMine.Colors[colorBoxMine.ItemIndex];
          tometext1.Color := colorBoxMine.Colors[colorBoxMine.ItemIndex];
          qsotext.Color := colorBoxQSO.Colors[colorBoxQSO.ItemIndex];
          qsotext1.Color := colorBoxQSO.Colors[colorBoxQSO.ItemIndex];
     end;
end;

procedure TForm7.cbEnAT1Change(Sender : TObject);
begin
     if cbEnAT1.Checked or cbEnAT2.Checked or cbEnAT3.Checked or cbEnAT4.Checked or cbEnAT5.Checked or cbEnAT6.Checked then Label52.Visible := true else Label52.Visible := false;
end;

procedure TForm7.cbForceMonoIOChange(Sender : TObject);
begin
     if cbForceMonoIO.Checked then cfg.forceMono := true else cfg.forceMono := false;
end;

procedure TForm7.cbNoSpottingChange(Sender : TObject);
begin
     if cbNoSpotting.Checked then GroupBox3.Enabled := false else GroupBox3.Enabled :=true;
end;

procedure TForm7.cbRBEnableChange(Sender : TObject);
begin
     if cbRBEnable.Checked or cbPSKREnable.Checked Then
     Begin
          Label45.Caption := 'Notice:  When RB or PSK Reporter spotting is enabled you will need an active Internet connection' + sLineBreak +
                             'while the program is running.  Also, please make your best effort to maintain an accurate QRG' + sLineBreak +
                             'value either manually or via rig control software.';

     end
     else
     begin
          Label45.Caption := '';
     end;
end;

procedure TForm7.colorBoxCQChange(Sender : TObject);
begin
     cqtext.Color := colorBoxCQ.Colors[colorBoxCQ.ItemIndex];
     cqtext1.Color := colorBoxCQ.Colors[colorBoxCQ.ItemIndex];
end;

procedure TForm7.colorBoxMineChange(Sender : TObject);
begin
     tometext.Color := colorBoxMine.Colors[colorBoxMine.ItemIndex];
     tometext1.Color := colorBoxMine.Colors[colorBoxMine.ItemIndex];
end;

procedure TForm7.colorBoxQSOChange(Sender : TObject);
begin
     qsotext.Color := colorBoxQSO.Colors[colorBoxQSO.ItemIndex];
     qsotext1.Color := colorBoxQSO.Colors[colorBoxQSO.ItemIndex];
end;

procedure TForm7.buttonTestCATClick (Sender : TObject );
var
     foo : String;
begin
     Memo1.Clear;
     // Set the rig control method [none, hrd, commander, omni ]
     if rbHRD.Checked then rig1.rigcontroller       := 'hrd';
     if rbOmni.Checked then rig1.rigcontroller      := 'omni';
     if rbNoCAT.Checked then rig1.rigcontroller     := 'none';
     if rbCommander.Checked then rig1.rigcontroller := 'commander';
     if (rig1.rigcontroller = 'hrd') or (rig1.rigcontroller = 'omni') or (rig1.rigcontroller = 'none') or (rig1.rigcontroller = 'commander') then
     begin
          rig1.pollRig();
          foo := 'QRG = ' + intToStr(rig1.qrg) + ' Hz, Set QRG = 28076000 Hz, ';
          rig1.setQRG(28076000);
          sleep(500);
          rig1.pollRig();
          foo := foo + 'QRG = ' + intToStr(rig1.qrg) + ' Hz';
          foo := foo + sLineBreak + 'Rig = ' + rig1.rig;
          if cbCatPtt.Checked then
          begin
               rig1.togglePTT();
               sleep(1000);
               rig1.togglePTT();
          end;
          Memo1.Text := foo;
     end;
end;

procedure TForm7.saveConfig(cfgname : string);
var
   i       : Integer;
begin
     if length(cfgname) > 0 then
     begin
          ini.IniFileName := cfgname;
          ini.IniSection := 'JT65HF';
          ini.WriteString('callsign', cfg.prCallsign);
          ini.WriteString('cwcallsign', cfg.prCWCallsign);
          ini.WriteString('rbcallsign', cfg.prRBCallsign);
          ini.WriteString('grid',cfg.prGrid);
          ini.WriteInteger('prefix',cfg.prPrefix);
          ini.WriteInteger('suffix',cfg.prSuffix);
          ini.WriteInteger('soundin',cfg.prSoundInN);
          ini.WriteInteger('soundout',cfg.prSoundOutN);
          ini.WriteString('soundinname',cfg.prSoundInS);
          ini.WriteString('soundoutname',cfg.prSoundOutS);
          ini.WriteBoolean('soundtested',cfg.prSoundTested);
          ini.WriteBoolean('soundetested',cfg.prSoundETested);
          ini.WriteBoolean('soundvalid',cfg.prSoundValid);
          ini.WriteBoolean('soundmonorx',cfg.prSoundMonoRX);
          ini.WriteBoolean('soundmonotx',cfg.prSoundMonoTX);
          ini.WriteBoolean('forcemono',cfg.prForceMono);
          ini.WriteString('pttmethod',cfg.prPTTMethod);
          ini.WriteString('catmethod',cfg.prCATMethod);
          ini.WriteString('pttport',cfg.prPTTPort);
          ini.WriteBoolean('altptt',cfg.prAltPTT);
          ini.WriteString('pttlines',cfg.prPTTLines);
          ini.WriteBoolean('ptttested',cfg.prPTTTested);
          ini.WriteBoolean('catenabled',cfg.prCATEnabled);
          ini.WriteBoolean('enqsy1',cfg.prEnQSY1);
          ini.WriteBoolean('enqsy2',cfg.prEnQSY2);
          ini.WriteBoolean('enqsy3',cfg.prEnQSY3);
          ini.WriteBoolean('enqsy4',cfg.prEnQSY4);
          ini.WriteBoolean('enqsy5',cfg.prEnQSY5);
          ini.WriteBoolean('enqsy6',cfg.prEnQSY6);
          ini.WriteString('qsytime1',cfg.prQSYTime1);
          ini.WriteString('qsytime2',cfg.prQSYTime2);
          ini.WriteString('qsytime3',cfg.prQSYTime3);
          ini.WriteString('qsytime4',cfg.prQSYTime4);
          ini.WriteString('qsytime5',cfg.prQSYTime5);
          ini.WriteString('qsytime6',cfg.prQSYTime6);
          ini.WriteString('qsyqrg1',cfg.prQSYQRG1);
          ini.WriteString('qsyqrg2',cfg.prQSYQRG2);
          ini.WriteString('qsyqrg3',cfg.prQSYQRG3);
          ini.WriteString('qsyqrg4',cfg.prQSYQRG4);
          ini.WriteString('qsyqrg5',cfg.prQSYQRG5);
          ini.WriteString('qsyqrg6',cfg.prQSYQRG6);
          ini.WriteBoolean('qsyatune1',cfg.prQSYTune1);
          ini.WriteBoolean('qsyatune2',cfg.prQSYTune2);
          ini.WriteBoolean('qsyatune3',cfg.prQSYTune3);
          ini.WriteBoolean('qsyatune4',cfg.prQSYTune4);
          ini.WriteBoolean('qsyatune5',cfg.prQSYTune5);
          ini.WriteBoolean('qsyatune6',cfg.prQSYTune6);
          ini.WriteBoolean('nospotting',cfg.prNoSpot);
          ini.WriteBoolean('enablerb',cfg.prRB);
          ini.WriteBoolean('enablepskr',cfg.prPSKR);
          ini.WriteString('rbinfo',cfg.prRBInfo);
          for i := 0 to 63 do
          begin
               ini.WriteString('macro'+intToStr(i),cfg.prMacros[i]);
          end;
          for i := 0 to 63 do
          begin
               ini.WriteInteger('qrg'+intToStr(i),cfg.prQRGs[i]);
          end;
          ini.WriteInteger('cqcolor',cfg.prCQColor);
          ini.WriteInteger('qsocolor',cfg.prQSOColor);
          ini.WriteInteger('mycolor',cfg.prMyColor);
          ini.WriteBoolean('nocolor',cfg.prNoColor);
          ini.WriteBoolean('savecsv',cfg.prSaveCSV);
          ini.WriteBoolean('savedb',cfg.prSaveDB);
          ini.WriteBoolean('saveadif',cfg.prSaveADIF);
          ini.WriteBoolean('doeqsl',cfg.prdoeQSL);
          ini.WriteBoolean('dodxlab',cfg.prdodxLab);
          ini.WriteBoolean('nomultiqso',cfg.prNoMultiQSO);
          ini.WriteBoolean('multirestore',cfg.prMultiRestore);
          ini.WriteBoolean('multidefmulti',cfg.prMultiDefMulti);
          ini.WriteBoolean('cwidfree',cfg.prCWIDfree);
          ini.WriteBoolean('cwidall',cfg.prCWIDall);
          ini.WriteBoolean('txwatchdog',cfg.prTXWatchdog);
          ini.WriteInteger('txwatchdogcount',cfg.prTXWatchdogInt);
          ini.WriteBoolean('optfft',cfg.prUseOptFFT);
          ini.WriteBoolean('usekv',cfg.prUseKV);
          ini.WriteBoolean('rxsrauto',cfg.prRXAutoSR);
          ini.WriteBoolean('txsrauto',cfg.prTXAutoSR);
          ini.WriteString('version',cfg.prVersion);
          ini.WriteInteger('speccolor',cfg.prSpecColor);
          ini.WriteInteger('speccontrast',cfg.prSpecContrast);
          ini.WriteInteger('specbright',cfg.prSpecBright);
          ini.WriteInteger('specspeed',cfg.prSpecSpeed);
          ini.WriteInteger('specgain',cfg.prSpecGain);
          ini.WriteBoolean('specsmooth',cfg.prSpecSmooth);
          ini.WriteBoolean('audioleft',cfg.prAudioUseLeft);
          ini.WriteBoolean('audioright',cfg.prAudioUseRight);
          ini.WriteInteger('dgainl',cfg.prAudioDGainL);
          ini.WriteInteger('dgainr',cfg.prAudioDGainR);
          ini.WriteBoolean('txrxdf',cfg.prTXRXDF);
          ini.WriteBoolean('afc',cfg.prAFC);
          ini.WriteBoolean('nb',cfg.prNoiseBlank);
          ini.WriteBoolean('multion',cfg.prMulti);
          ini.WriteInteger('decbw',cfg.prDecoderBW);
          ini.WriteInteger('multibw',cfg.prMultiBW);
          ini.WriteInteger('guiqrg',cfg.prQRG);
          ini.Save;
     end;
end;

procedure TForm7.readConfig(cfgname : string);
var
   i       : Integer;
   tmpflt  : single;
   foo     : String;
begin
     tmpflt := 0.0;
     if length(cfgname) > 0 then
     begin
        ini.IniFileName := cfgname;
        ini.IniSection :='JT65HF';
        cfg.prVersion := ini.ReadString('version','0.0.0');
        cfg.prCallsign := ini.ReadString('callsign','');
        cfg.prCWCallsign := ini.ReadString('cwcallsign','');
        cfg.prRBCallsign := ini.ReadString('rbcallsign','');
        cfg.prGrid := ini.ReadString('grid','');
        cfg.prPrefix := ini.ReadInteger('prefix',0);
        cfg.prSuffix := ini.ReadInteger('suffix',0);
        cfg.prSoundInN := ini.ReadInteger('soundin',0);
        cfg.prSoundOutN := ini.ReadInteger('soundout',0);
        cfg.prSoundInS := ini.ReadString('soundinname','');
        cfg.prSoundOutS := ini.ReadString('soundoutname','');
        cfg.prSoundTested := ini.ReadBoolean('soundtested',False);
        cfg.prSoundETested := ini.ReadBoolean('soundetested',False);
        cfg.prSoundValid := ini.ReadBoolean('soundvalid',False);
        cfg.prsoundMonoRX := ini.ReadBoolean('soundmonorx',False);
        cfg.prsoundMonoTX := ini.ReadBoolean('soundmonotx',False);
        cfg.prForceMono := ini.ReadBoolean('forcemono',False);
        cfg.prPTTMethod := ini.ReadString('pttmethod','');
        cfg.prCATMethod := ini.ReadString('catmethod','');
        cfg.prPTTPort := ini.ReadString('pttport','');
        cfg.prAltPTT := ini.ReadBoolean('altptt',False);
        cfg.prPTTLines := ini.ReadString('pttlines','');
        cfg.prPTTTested := ini.ReadBoolean('ptttested',False);
        cfg.prCATEnabled := ini.ReadBoolean('catenabled',False);
        cfg.prEnQSY1 := ini.ReadBoolean('enqsy1',False);
        cfg.prEnQSY2 := ini.ReadBoolean('enqsy2',False);
        cfg.prEnQSY3 := ini.ReadBoolean('enqsy3',False);
        cfg.prEnQSY4 := ini.ReadBoolean('enqsy4',False);
        cfg.prEnQSY5 := ini.ReadBoolean('enqsy5',False);
        cfg.prEnQSY6 := ini.ReadBoolean('enqsy6',False);
        cfg.prQSYTime1 := ini.ReadString('qsytime1','');
        cfg.prQSYTime2 := ini.ReadString('qsytime2','');
        cfg.prQSYTime3 := ini.ReadString('qsytime3','');
        cfg.prQSYTime4 := ini.ReadString('qsytime4','');
        cfg.prQSYTime5 := ini.ReadString('qsytime5','');
        cfg.prQSYTime6 := ini.ReadString('qsytime6','');
        cfg.prQSYQRG1 := ini.ReadString('qsyqrg1','');
        cfg.prQSYQRG2 := ini.ReadString('qsyqrg2','');
        cfg.prQSYQRG3 := ini.ReadString('qsyqrg3','');
        cfg.prQSYQRG4 := ini.ReadString('qsyqrg4','');
        cfg.prQSYQRG5 := ini.ReadString('qsyqrg5','');
        cfg.prQSYQRG6 := ini.ReadString('qsyqrg6','');
        cfg.prQSYTune1 := ini.ReadBoolean('qsyatune1',False);
        cfg.prQSYTune2 := ini.ReadBoolean('qsyatune2',False);
        cfg.prQSYTune3 := ini.ReadBoolean('qsyatune3',False);
        cfg.prQSYTune4 := ini.ReadBoolean('qsyatune4',False);
        cfg.prQSYTune5 := ini.ReadBoolean('qsyatune5',False);
        cfg.prQSYTune6 := ini.ReadBoolean('qsyatune6',False);
        cfg.prNoSpot := ini.ReadBoolean('nospotting',False);
        cfg.prRB := ini.ReadBoolean('enablerb',False);
        cfg.prPSKR := ini.ReadBoolean('enablepskr',False);
        cfg.prRBInfo := ini.ReadString('rbinfo','');
        for i := 0 to 63 do
        begin
             foo := 'macro'+intToStr(i);
             cfg.prMacros[i] := ini.ReadString(foo,'');
        end;
        for i := 0 to 63 do
        begin
             foo := 'qrg'+intToStr(i);
             cfg.prQRGs[i] := ini.ReadInteger(foo,0);
        end;
        cfg.prCQColor := ini.ReadInteger('cqcolor',clLime);
        cfg.prQSOColor := ini.ReadInteger('qsocolor',clSilver);
        cfg.prMyColor := ini.ReadInteger('mycolor',clRed);
        cfg.prNoColor := ini.ReadBoolean('nocolor',False);
        cfg.prSaveCSV := ini.ReadBoolean('savecsv',False);
        cfg.prSaveDB := ini.ReadBoolean('savedb',False);
        cfg.prSaveADIF := ini.ReadBoolean('saveadif',False);
        cfg.prdoeQSL := ini.ReadBoolean('doeqsl',False);
        cfg.prdodxLab := ini.ReadBoolean('dodxlab',False);
        cfg.prNoMultiQSO := ini.ReadBoolean('nomultiqso',False);
        cfg.prMultiRestore := ini.ReadBoolean('multirestore',False);
        cfg.prMultiDefMulti := ini.ReadBoolean('multidefmulti',False);
        cfg.prCWIDfree := ini.ReadBoolean('cwidfree',False);
        cfg.prCWIDall := ini.ReadBoolean('cwidall',False);
        cfg.prTXWatchdog := ini.ReadBoolean('txwatchdog',False);
        cfg.prTXWatchdogInt := ini.ReadInteger('txwatchdogcount',10);
        cfg.prUseOptFFT := ini.ReadBoolean('optfft',True);
        cfg.prUseKV := ini.ReadBoolean('usekv',True);
        cfg.prRXAutoSR := ini.ReadBoolean('rxsrauto',True);
        cfg.prTXAutoSR := ini.ReadBoolean('txsrauto',True);
        cfg.prSpecColor := ini.ReadInteger('speccolor',0);
        cfg.prSpecContrast := ini.ReadInteger('speccontrast',0);
        cfg.prSpecBright := ini.ReadInteger('specbright',0);
        cfg.prSpecSpeed := ini.ReadInteger('specspeed',0);
        cfg.prSpecGain := ini.ReadInteger('specgain',0);
        cfg.prSpecSmooth := ini.ReadBoolean('specsmooth',False);
        cfg.prAudioUseLeft := ini.ReadBoolean('audioleft',False);
        cfg.prAudioUseRight := ini.ReadBoolean('audioright',False);
        cfg.prAudioDGainL := ini.ReadInteger('dgainl',0);
        cfg.prAudioDGainR := ini.ReadInteger('dgainr',0);
        cfg.prTXRXDF := ini.ReadBoolean('txrxdf',False);
        cfg.prAFC := ini.ReadBoolean('afc',False);
        cfg.prNoiseBlank := ini.ReadBoolean('nb',False);
        cfg.prMulti := ini.ReadBoolean('multion',False);
        cfg.prDecoderBW := ini.ReadInteger('decbw',0);
        cfg.prMultiBW := ini.ReadInteger('multibw',0);
        cfg.prQRG := ini.ReadInteger('guiqrg',0);
        // Configuration read now set the GUI elements in guidedconfig
        // Tab 0 Values Callsign/Grid
        edStationCallsign.Text := cfg.prCallsign;
        edCWCallsign.Text := cfg.prCWCallsign;
        edRBCallsign.Text := cfg.prRBCallsign;
        edStationGrid.Text := cfg.prGrid;
        // Tab 1 Values Callsign Suffix/Prefix
        comboPrefix.ItemIndex := cfg.prPrefix;
        comboSuffix.ItemIndex := cfg.prSuffix;
        // Tab 2 Values Sound Device
        comboSoundIn.ItemIndex := cfg.prSoundInN;
        comboSoundOut.ItemIndex := cfg.prSoundOutN;
        cbForceMonoIO.Checked := cfg.prForceMono;
        // Tab 3 Values PTT And Rig Control
        if cfg.prPTTMethod = 'VOX' then rbPTTVox.Checked := true else rbPTTVox.Checked := False;
        if cfg.prPTTMethod = 'COM' then rbPTTCom.Checked := true else rbPTTCom.checked := False;
        if cfg.prPTTMethod = 'CAT' then rbPTTCat.Checked := true else rbPTTCat.checked := False;
        if cfg.prPTTMethod = 'OFF' then rbPTTNoTX.Checked := true else rbPTTNoTX.checked := False;
        if cfg.pttLines = 'DTRRTS' then rbDTRRTS.Checked := true else rbDTRRTS.Checked := false;
        if cfg.pttLines = 'RTS' then rbRTS.Checked := true else rbRTS.Checked := false;
        if cfg.pttLines = 'DTR' then rbDTR.Checked := true else rbDTR.Checked := false;
        if cfg.CATMethod = 'HRD' then rbHRD.Checked := true else rbHRD.Checked := false;;
        if cfg.CATMethod = 'COMMANDER' then rbCommander.Checked := true else rbCommander.Checked := false;
        if cfg.CATMethod = 'OMNI' then rbOmni.Checked := true else rbOmni.Checked := false;
        if cfg.CATMethod = 'NONE' then rbNoCAT.Checked := true else rbNoCAT.checked := false;
        edPTTPort.Text := cfg.prPTTPort;
        cbPTTAltCode.checked := cfg.prAltPTT;
        // Tab 4 Values Auto QSY
        if cfg.prEnQSY1 then cbEnAutoQSY1.Checked := true else cbEnAutoQSY1.Checked := false;
        if cfg.prEnQSY2 then cbEnAutoQSY2.Checked := true else cbEnAutoQSY2.Checked := false;
        if cfg.prEnQSY3 then cbEnAutoQSY3.Checked := true else cbEnAutoQSY3.Checked := false;
        if cfg.prEnQSY4 then cbEnAutoQSY4.Checked := true else cbEnAutoQSY4.Checked := false;
        if cfg.prEnQSY5 then cbEnAutoQSY5.Checked := true else cbEnAutoQSY5.Checked := false;
        if cfg.prEnQSY6 then cbEnAutoQSY6.Checked := true else cbEnAutoQSY6.Checked := false;
        edQSYTime1.Text := cfg.prQSYTime1;
        edQSYTime2.Text := cfg.prQSYTime2;
        edQSYTime3.Text := cfg.prQSYTime3;
        edQSYTime4.Text := cfg.prQSYTime4;
        edQSYTime5.Text := cfg.prQSYTime5;
        edQSYTime6.Text := cfg.prQSYTime6;
        if val1.testQRG(cfg.prQSYQRG1,tmpflt,i) then edQRG1.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG1.Text := '0';
        if val1.testQRG(cfg.prQSYQRG2,tmpflt,i) then edQRG2.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG2.Text := '0';
        if val1.testQRG(cfg.prQSYQRG3,tmpflt,i) then edQRG3.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG3.Text := '0';
        if val1.testQRG(cfg.prQSYQRG4,tmpflt,i) then edQRG4.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG4.Text := '0';
        if val1.testQRG(cfg.prQSYQRG5,tmpflt,i) then edQRG5.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG5.Text := '0';
        if val1.testQRG(cfg.prQSYQRG6,tmpflt,i) then edQRG6.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG6.Text := '0';
        if cfg.prQSYTune1 then cbEnAT1.Checked := true else cbEnAT1.Checked := false;
        if cfg.prQSYTune2 then cbEnAT2.Checked := true else cbEnAT2.Checked := false;
        if cfg.prQSYTune3 then cbEnAT3.Checked := true else cbEnAT3.Checked := false;
        if cfg.prQSYTune4 then cbEnAT4.Checked := true else cbEnAT4.Checked := false;
        if cfg.prQSYTune5 then cbEnAT5.Checked := true else cbEnAT5.Checked := false;
        if cfg.prQSYTune6 then cbEnAT6.Checked := true else cbEnAT6.Checked := false;
        // Tab 5 Values Spotting Network
        if cfg.prNoSpot then cbNoSpotting.Checked := true else cbNoSpotting.Checked := false;
        if cfg.prRB then cbRBEnable.Checked := true else cbRBEnable.Checked := false;
        if cfg.prPSKR then cbPSKREnable.Checked := true else cbPSKREnable.checked := false;
        edRBInfo.Text := cfg.prRBInfo;
        // Tab 6 Values Macros
        editMacro1.Text := macroVal(cfg.prMacros[0]);
        editMacro2.Text := macroVal(cfg.prMacros[1]);
        editMacro3.Text := macroVal(cfg.prMacros[2]);
        editMacro4.Text := macroVal(cfg.prMacros[3]);
        editMacro5.Text := macroVal(cfg.prMacros[4]);
        editMacro6.Text := macroVal(cfg.prMacros[5]);
        editMacro7.Text := macroVal(cfg.prMacros[6]);
        editMacro8.Text := macroVal(cfg.prMacros[7]);
        editMacro9.Text := macroVal(cfg.prMacros[8]);
        editMacro10.Text := macroVal(cfg.prMacros[9]);
        editMacro11.Text := macroVal(cfg.prMacros[10]);
        editMacro12.Text := macroVal(cfg.prMacros[11]);
        editMacro13.Text := macroVal(cfg.prMacros[12]);
        editMacro14.Text := macroVal(cfg.prMacros[13]);
        editMacro15.Text := macroVal(cfg.prMacros[14]);
        editMacro16.Text := macroVal(cfg.prMacros[15]);
        editMacro17.Text := macroVal(cfg.prMacros[16]);
        editMacro18.Text := macroVal(cfg.prMacros[17]);
        editMacro19.Text := macroVal(cfg.prMacros[18]);
        editMacro20.Text := macroVal(cfg.prMacros[19]);
        editMacro21.Text := macroVal(cfg.prMacros[20]);
        editMacro22.Text := macroVal(cfg.prMacros[21]);
        editMacro23.Text := macroVal(cfg.prMacros[22]);
        editMacro24.Text := macroVal(cfg.prMacros[23]);
        if val1.testQRG(inttostr(cfg.prQRGs[0]),tmpflt,i) then editQRG1.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG1.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[1]),tmpflt,i) then editQRG2.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG2.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[2]),tmpflt,i) then editQRG3.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG3.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[3]),tmpflt,i) then editQRG4.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG4.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[4]),tmpflt,i) then editQRG5.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG5.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[5]),tmpflt,i) then editQRG6.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG6.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[6]),tmpflt,i) then editQRG7.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG7.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[7]),tmpflt,i) then editQRG8.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG8.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[8]),tmpflt,i) then editQRG9.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG9.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[9]),tmpflt,i) then editQRG10.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG10.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[10]),tmpflt,i) then editQRG11.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG11.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[11]),tmpflt,i) then editQRG12.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG12.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[12]),tmpflt,i) then editQRG13.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG13.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[13]),tmpflt,i) then editQRG14.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG14.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[14]),tmpflt,i) then editQRG15.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG15.Text := '0';
        if val1.testQRG(inttostr(cfg.prQRGs[15]),tmpflt,i) then editQRG16.Text := floatToStrF(tmpflt,ffFixed,0,2) else editQRG16.Text := '0';
        // Tab 7 Values Colors
        //prCQColor       : TColor;
        //prQSOColor      : TColor;
        //prMyColor       : TColor;
        if cfg.prNoColor then cbDisableColorCoding.Checked := true else cbDisableColorCoding.Checked := false;
        // Tab 8 Values Logging
        if cfg.prSaveCSV then cbSaveCSV.Checked := true else cbSaveCSV.Checked := false;
        if cfg.prSaveDB then cbSaveDB.checked := true else cbSaveDB.checked := false;
        if cfg.prSaveADIF then cbSaveADIF.checked := true else cbSaveADIF.checked := false;
        if cfg.prdoeQSL then cbdoeqsl.Checked := true else cbdoeqsl.checked := false;
        if cfg.prdodxLab then cbdoDXLab.Checked := true else cbdoDXLab.checked := false;
        // Tab 9 Values Advanced Settings
        if cfg.prNoMultiQSO then cbDisableMultiInQSO.Checked := true else cbDisableMultiInQSO.Checked := false;
        if cfg.prMultiRestore then cbEnableMultiAfterQSO.Checked := true else cbEnableMultiAfterQSO.Checked := false;
        if cfg.prMultiDefMulti then cbRestoresDefaultsMulti.Checked := true else cbRestoresDefaultsMulti.Checked := false;
        if cfg.prCWIDfree then cbSendCWIDFree.Checked := true else cbSendCWIDFree.Checked := false;
        if cfg.prCWIDall then cbSendCWIDAll.Checked := true else cbSendCWIDAll.Checked := false;
        if cfg.prTXWatchdog then cbTXWatchdog.Checked := true else cbTXWatchdog.Checked := false;
        spinTXCount.Value := cfg.prTXWatchdogInt;
        if cfg.prUseOptFFT then cbUseOptFFT.Checked := true else cbUseOptFFT.Checked := false;
        if cfg.prUseKV then cbUseKV.Checked := true else cbUseKV.Checked := false;
        if cfg.prRXAutoSR then cbAutoRXSR.Checked := true else cbAutoRXSR.Checked := false;
        if cfg.prTXAutoSR then cbAutoTXSR.Checked := true else cbAutoTXSR.Checked := false;
     end;
end;

initialization
  {$I guidedconfig.lrs}
  prepop := False;
  val1   := valobject.TValidator.create();
  rig1   := rigobject.TRadio.create();
  cfg    := guidedconfig.TSettings.create();
  dsp    := paobject.TpaDSP.create();
  ser    := serialobject.TSerial.create();
end.

