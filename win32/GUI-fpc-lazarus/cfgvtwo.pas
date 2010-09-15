unit cfgvtwo;
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
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, StrUtils, globalData, CTypes, synaser,
  EditBtn, Grids, Si570dev;

const myWordDelims = [' ',','];
Const JT_DLL = 'jt65.dll';

type

  { TForm6 }

  TForm6 = class(TForm)
    btnSetSi570: TButton;
    btnClearLog: TButton;
    Button1: TButton;
    buttonTestPTT: TButton;
    cbAudioIn: TComboBox;
    cbAudioOut: TComboBox;
    cbDisableMultiQSO: TCheckBox;
    cbMultiAutoEnable: TCheckBox;
    cbSaveCSV: TCheckBox;
    cbTXWatchDog: TCheckBox;
    cbUsePSKReporter: TCheckBox;
    cbUseRB: TCheckBox;
    cbUseAltPTT: TCheckBox;
    cbNoInet: TCheckBox;
    cbRestoreMulti: TCheckBox;
    cbSi570PTT: TCheckBox;
    cbCWID: TCheckBox;
    checkSi570: TCheckBox;
    chkNoOptFFT: TCheckBox;
    chkUseCommander: TCheckBox;
    chkUseHRD: TCheckBox;
    chkUseOmni: TCheckBox;
    chkEnableAutoSR: TCheckBox;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    comboSuffix: TComboBox;
    comboPrefix: TComboBox;
    DirectoryEdit1: TDirectoryEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    editSI570Freq: TEdit;
    editSI570FreqOffset: TEdit;
    edUserMsg10: TEdit;
    edUserMsg11: TEdit;
    edUserMsg12: TEdit;
    edUserMsg13: TEdit;
    edUserMsg5: TEdit;
    edUserMsg6: TEdit;
    edUserMsg7: TEdit;
    edUserMsg8: TEdit;
    edUserMsg9: TEdit;
    edUserQRG1: TEdit;
    edUserQRG2: TEdit;
    edUserQRG3: TEdit;
    edUserQRG4: TEdit;
    editPSKRCall: TEdit;
    editPSKRAntenna: TEdit;
    editUserDefinedPort1: TEdit;
    edUserMsg4: TEdit;
    groupHRD: TGroupBox;
    Label10: TLabel;
    labelHRDRig: TLabel;
    Label12: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label28: TLabel;
    Label3: TLabel;
    Label30: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label6: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    labelHRDButtons: TLabel;
    labelHRDDropDowns: TLabel;
    labelHRDSliders: TLabel;
    OmniGroup: TRadioGroup;
    Page3: TPage;
    Page5: TPage;
    Page6: TPage;
    Colors: TPage;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    radioOmni1: TRadioButton;
    radioOmni2: TRadioButton;
    radioSI570X1: TRadioButton;
    radioSI570X2: TRadioButton;
    radioSI570X4: TRadioButton;
    rigQRG: TEdit;
    edMyCall: TEdit;
    edMyGrid: TEdit;
    edRXSRCor: TEdit;
    edTXSRCor: TEdit;
    Label1: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label9: TLabel;
    lbDiagLog: TListBox;
    Notebook1: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Page4: TPage;
    sgCallsHeard: TStringGrid;
    procedure btnClearLogClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure buttonTestPTTClick(Sender: TObject);
    procedure cbAudioInChange(Sender: TObject);
    procedure cbAudioOutChange(Sender: TObject);
    procedure cbNoInetChange(Sender: TObject);
    procedure cbUseRBChange(Sender: TObject);
    procedure cbSi570PTTChange(Sender: TObject);
    procedure checkSi570Change(Sender: TObject);
    procedure chkEnableAutoSRChange(Sender: TObject);
    procedure chkUseCommanderChange(Sender: TObject);
    procedure chkUseHRDChange(Sender: TObject);
    procedure chkUseOmniChange(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure comboPrefixChange(Sender: TObject);
    procedure editSI570FreqChange(Sender: TObject);
    procedure edMyCallChange(Sender: TObject);
    procedure edUserMsgChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form6            : TForm6;
  glcqColor        : TColor;
  glcallColor      : TColor;
  glqsoColor       : TColor;
  glsi57           : Si570Dev.TSi570Device;
  glsi57QRGi       : Integer;
  glsi57QRGs       : Integer;
  cfpttSerial      : TBlockSerial;
  glsi57Set        : Boolean;
  glautoSR         : Boolean;
  glmyCall         : String;
  glmustConfig     : Boolean;
  glcatBy          : String; // Can be hamlib, omnirig, hrd, commander or none.
  glrbcLogin       : Boolean;
  glrbcLogout      : Boolean;
  gld65AudioChange : Boolean;
  glcallChange     : Boolean;
implementation

{ TForm6 }

function ptt(nport : Pointer; msg : Pointer; ntx : Pointer; iptt : Pointer) : CTypes.cint; cdecl; external JT_DLL name 'ptt_';

procedure raisePTT();
var
   np, ntx, iptt : CTypes.cint;
   msg           : CTypes.cschar;
   tmp, nport    : String;
Begin
     msg := 0;
     np := 0;
     ntx := 1;
     iptt := 0;
     tmp := '';
     nport := '';

     nport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);

     if nport = 'None' Then nport := '';
     if nport = 'NONE' Then nport := '';

     if Length(nport) > 3 Then
     Begin
          if Length(nport) = 4 Then
          Begin
               // Length = 4 = COM#
               tmp := '';
               tmp := nport[4];
          End;
          if Length(nport) = 5 Then
          Begin
               // Length = 5 = COM##
               tmp := '';
               tmp := nport[4..5];
          End;
          If Length(nport) = 6 Then
          Begin
               // Length = 6 = COM###
               tmp := '';
               tmp := nport[4..6];
          End;
          np := StrToInt(tmp);
          if np > 0 Then ptt(@np, @msg, @ntx, @iptt);
     End
     Else
     Begin
          np := 0;
          if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
          Begin
               if np > 0 Then ptt(@np, @msg, @ntx, @iptt);
          End;
     End;
End;

procedure lowerPTT();
var
   np, ntx, iptt : CTypes.cint;
   msg           : CTypes.cschar;
   tmp, nport    : String;
Begin
     msg := 0;
     np := 0;
     ntx := 0;
     iptt := 0;
     tmp := '';
     nport := '';

     nport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);

     if nport = 'None' Then nport := '';
     if nport = 'NONE' Then nport := '';

     if Length(nport) > 3 Then
     Begin
          if Length(nport) = 4 Then
          Begin
               // Length = 4 = COM#
               tmp := '';
               tmp := nport[4];
          End;
          if Length(nport) = 5 Then
          Begin
               // Length = 5 = COM##
               tmp := '';
               tmp := nport[4..5];
          End;
          If Length(nport) = 6 Then
          Begin
               // Length = 6 = COM###
               tmp := '';
               tmp := nport[4..6];
          End;
          np := StrToInt(tmp);
          if np > 0 Then ptt(@np, @msg, @ntx, @iptt);
     End
     Else
     Begin
          np := 0;
          if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
          Begin
               if np > 0 Then ptt(@np, @msg, @ntx, @iptt);
          End;
     End;
End;

procedure altRaisePTT();
var
   np        : Integer;
   pttOpened : Boolean;
   nport     : String;
Begin
     pttOpened := False;
     if not pttOpened Then
     Begin
          nport := '';
          nport := Form6.editUserDefinedPort1.Text;
          if nport = 'None' Then nport := '';
          if nport = 'NONE' Then nport := '';
          if Length(nport) > 3 Then
          Begin
               try
                  cfpttSerial := TBlockSerial.Create;
                  cfpttSerial.RaiseExcept := True;
                  cfpttSerial.Connect(nport);
                  cfpttSerial.Config(9600,8,'N',0,false,true);
                  pttOpened := True;
               except
                  //dlog.fileDebug('PTT Port [' + nport + '] failed to key up.');
               end;
          End
          Else
          Begin
               np := 0;
               if tryStrToInt(Form6.editUserDefinedPort1.Text,np) Then
               Begin
                    Try
                       cfpttSerial := TBlockSerial.Create;
                       cfpttSerial.RaiseExcept := True;
                       cfpttSerial.Connect('COM' + IntToStr(np));
                       cfpttSerial.Config(9600,8,'N',0,false,true);
                       pttOpened := True;
                    Except
                       //dlog.fileDebug('PTT Port [COM' + IntToStr(np) + '] failed to key up.');
                    End;
               End
               Else
               Begin
                    pttOpened := False;
               End;
          End;
     End;
End;

procedure altLowerPTT();
Begin
     cfpttSerial.Free;
End;

procedure TForm6.Button1Click(Sender: TObject);
begin
     glmustConfig := False;
     self.Hide;
end;

procedure TForm6.buttonTestPTTClick(Sender: TObject);
begin
     if Form6.cbUseAltPTT.Checked Then altRaisePTT() else raisePTT();
     sleep(500);
     if Form6.cbUseAltPTT.Checked Then altLowerPTT() else lowerPTT();
end;

procedure TForm6.cbAudioInChange(Sender: TObject);
begin
     gld65AudioChange := True;
end;

procedure TForm6.cbAudioOutChange(Sender: TObject);
begin
     gld65AudioChange := True;
end;

procedure TForm6.cbNoInetChange(Sender: TObject);
begin
  // If checked setup rbc for cacheonly
  If cbNoInet.Checked Then
  Begin
       globalData.rbCacheOnly := True;
       If globalData.rbLoggedIn Then glrbcLogout := True;
  End
  Else
  Begin
       globalData.rbCacheOnly := False;
       If (cbUseRB.Checked) And (not globalData.rbLoggedIn) Then glrbcLogin := True;
  End;
end;

procedure TForm6.cbUseRBChange(Sender: TObject);
begin
     If cbUseRB.Checked And not cbNoInet.Checked Then
     Begin
          glrbcLogin := True;
     End
     else
     Begin
          glrbcLogout := True;
     End;

     // Handle case of rb having been online but now set to offline mode.
     If (cbNoInet.Checked) And (globalData.rbLoggedIn) Then
     Begin
          glrbcLogout := True;
     End;
end;

procedure TForm6.cbSi570PTTChange(Sender: TObject);
begin
     if cbSi570PTT.Checked Then globalData.si570ptt := True else globalData.si570ptt := False;
end;

procedure TForm6.chkEnableAutoSRChange(Sender: TObject);
begin
     if Form6.chkEnableAutoSR.Checked Then glautoSR := True else glautoSR := False;
end;

procedure TForm6.chkUseCommanderChange(Sender: TObject);
begin
     If chkUseCommander.Checked Then
     Begin
          chkUseHRD.Checked := False;
          chkUseOmni.Checked := False;
          glcatBy := 'commander';
     End
     Else
     Begin
          glcatBy := 'none';
          globalData.gqrg := 0.0;
          globalData.strqrg := '0';
     End;
end;

procedure TForm6.chkUseHRDChange(Sender: TObject);
begin
     If chkUseHRD.Checked Then
     Begin
          cfgvtwo.Form6.labelHRDRig.Caption := 'Waiting for data...';
          cfgvtwo.Form6.groupHRD.Visible := True;
          chkUseOmni.Checked := False;
          chkUseCommander.Checked := False;
          glcatBy := 'hrd';
     End
     Else
     Begin
          cfgvtwo.Form6.groupHRD.Visible := False;
          glcatBy := 'none';
          globalData.gqrg := 0.0;
          globalData.strqrg := '0';
     End;
end;

procedure TForm6.chkUseOmniChange(Sender: TObject);
begin
     If chkUseOmni.Checked Then
     Begin
          chkUseHRD.Checked := False;
          chkUseCommander.Checked := False;
          glcatBy := 'omni';
     End
     Else
     Begin
          glcatBy := 'none';
          globalData.gqrg := 0.0;
          globalData.strqrg := '0';
     End;
end;

procedure TForm6.editSI570FreqChange(Sender: TObject);
var
   ifoo1, ifoo2, ifoo3, ifoo4 : Integer;
begin
     ifoo1 := 0;
     ifoo2 := 0;
     ifoo3 := 0;
     ifoo3 := 0;
     TryStrToInt(self.editSI570Freq.Text, ifoo1);
     TryStrToInt(self.editSI570FreqOffset.Text, ifoo2);
     ifoo3 := ifoo1 + ifoo2;
     if ifoo3 > 0 Then
     Begin
          if self.radioSI570X4.Checked Then ifoo4 := ifoo3 * 4;
          if self.radioSI570X2.Checked Then ifoo4 := ifoo3 * 2;
          if self.radioSI570X1.Checked Then ifoo4 := ifoo3;
     End;
     if ifoo4 > 0 Then glsi57.SetFrequency(ifoo4);
     glsi57Set := True;
     glsi57QRGi := ifoo1;  // Indicated QRG Hz
     glsi57QRGs := ifoo3;  // Actual Si570 QRG Hz
     Label5.Caption := 'Indicated QRG Hz:  ' + IntToStr(glsi57QRGi);
     Label7.Caption := 'Actual Si570 QRG Hz:  ' + IntToStr(glsi57QRGs);
end;

procedure TForm6.checkSi570Change(Sender: TObject);
begin
     If checkSi570.Checked Then
     Begin
          glsi57 := Si570Dev.TSi570Device.Create;
          btnSetSi570.Enabled := True;
          glsi57Set := False;
          glcatBy := 'si57';
     End
     Else
     Begin
          glsi57.Close;
          glsi57.Destroy;
          btnSetSi570.Enabled := False;
          glsi57Set := False;
          glcatBy := 'none';
     End;
end;

procedure TForm6.btnClearLogClick(Sender: TObject);
begin
     Form6.lbDiagLog.Clear;
end;

procedure TForm6.edMyCallChange(Sender: TObject);
begin
     If (AnsiContainsText(Form6.edMyCall.Text,'/')) Or (AnsiContainsText(Form6.edMyCall.Text,'.')) Or
     (AnsiContainsText(Form6.edMyCall.Text,'-')) Or (AnsiContainsText(Form6.edMyCall.Text,'\')) Or
     (AnsiContainsText(Form6.edMyCall.Text,',')) Then
     Begin
          form6.edMyCall.Clear;
          glmyCall := '';
          form6.Label26.Font.Color := clRed;
          glCallChange := True;
     End
     Else
     Begin
          glmyCall := form6.edMyCall.Text;
          form6.Label26.Font.Color := clBlack;
          glCallChange := True;
     End;
end;

procedure TForm6.edUserMsgChange(Sender: TObject);
var
   vmsg   : Boolean;
   i, j   : Integer;
   foo, k : String;
begin
     vmsg := True;
     // Validate user message definition as containing only the allowed
     // JT65 character set which is;
     // 0123456789
     // ABCDEFGHIJKLMNOPQRSTUVWXYZ
     //  +-./?
     If Sender=Form6.edUserMsg4 Then
     Begin
          j := Length(edUserMsg4.Text);
          foo := edUserMsg4.Text;
          k := '4';
     End;
     If Sender=Form6.edUserMsg5 Then
     Begin
          j := Length(edUserMsg5.Text);
          foo := edUserMsg5.Text;
          k := '5';
     End;
     If Sender=Form6.edUserMsg6 Then
     Begin
          j := Length(edUserMsg6.Text);
          foo := edUserMsg6.Text;
          k := '6';
     End;
     If Sender=Form6.edUserMsg7 Then
     Begin
          j := Length(edUserMsg7.Text);
          foo := edUserMsg7.Text;
          k := '7';
     End;
     If Sender=Form6.edUserMsg8 Then
     Begin
          j := Length(edUserMsg8.Text);
          foo := edUserMsg8.Text;
          k := '8';
     End;
     If Sender=Form6.edUserMsg9 Then
     Begin
          j := Length(edUserMsg9.Text);
          foo := edUserMsg9.Text;
          k := '9';
     End;
     If Sender=Form6.edUserMsg10 Then
     Begin
          j := Length(edUserMsg10.Text);
          foo := edUserMsg10.Text;
          k := '10';
     End;
     If Sender=Form6.edUserMsg11 Then
     Begin
          j := Length(edUserMsg11.Text);
          foo := edUserMsg11.Text;
          k := '11';
     End;
     If Sender=Form6.edUserMsg12 Then
     Begin
          j := Length(edUserMsg12.Text);
          foo := edUserMsg12.Text;
          k := '12';
     End;
     If Sender=Form6.edUserMsg13 Then
     Begin
          j := Length(edUserMsg13.Text);
          foo := edUserMsg13.Text;
          k := '13';
     End;

     For i := 1 To j do
     Begin
          case foo[i] of 'A'..'Z','0'..'9',' ','+','-','.','/','?': vmsg := True;
             else vmsg := False;
          end;
     End;
     if vmsg Then
        Begin Label40.Caption := 'Message valid';
        Label40.Visible := False;
     end
     else
     Begin
          Label40.Caption := 'Message ' + k + ' not valid';
          Label40.Visible := True;
     End;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
     Form6.DirectoryEdit1.Directory := GetAppConfigDir(False);
end;

procedure TForm6.ComboBox1Change(Sender: TObject);
begin
     Case ComboBox1.ItemIndex of
          0  : Edit1.Color := clGreen;
          1  : Edit1.Color := clOlive;
          2  : Edit1.Color := clSkyBlue;
          3  : Edit1.Color := clPurple;
          4  : Edit1.Color := clTeal;
          5  : Edit1.Color := clGray;
          6  : Edit1.Color := clSilver;
          7  : Edit1.Color := clRed;
          8  : Edit1.Color := clLime;
          9  : Edit1.Color := clYellow;
          10 : Edit1.Color := clMoneyGreen;
          11 : Edit1.Color := clFuchsia;
          12 : Edit1.Color := clAqua;
          13 : Edit1.Color := clCream;
          14 : Edit1.Color := clMedGray;
          15 : Edit1.Color := clWhite;
     End;
     Case ComboBox1.ItemIndex of
          0  : ComboBox1.Color := clGreen;
          1  : ComboBox1.Color := clOlive;
          2  : ComboBox1.Color := clSkyBlue;
          3  : ComboBox1.Color := clPurple;
          4  : ComboBox1.Color := clTeal;
          5  : ComboBox1.Color := clGray;
          6  : ComboBox1.Color := clSilver;
          7  : ComboBox1.Color := clRed;
          8  : ComboBox1.Color := clLime;
          9  : ComboBox1.Color := clYellow;
          10 : ComboBox1.Color := clMoneyGreen;
          11 : ComboBox1.Color := clFuchsia;
          12 : ComboBox1.Color := clAqua;
          13 : ComboBox1.Color := clCream;
          14 : ComboBox1.Color := clMedGray;
          15 : ComboBox1.Color := clWhite;
     End;
     Case ComboBox1.ItemIndex of
          0  : glcqColor := clGreen;
          1  : glcqColor := clOlive;
          2  : glcqColor := clSkyBlue;
          3  : glcqColor := clPurple;
          4  : glcqColor := clTeal;
          5  : glcqColor := clGray;
          6  : glcqColor := clSilver;
          7  : glcqColor := clRed;
          8  : glcqColor := clLime;
          9  : glcqColor := clYellow;
          10 : glcqColor := clMoneyGreen;
          11 : glcqColor := clFuchsia;
          12 : glcqColor := clAqua;
          13 : glcqColor := clCream;
          14 : glcqColor := clMedGray;
          15 : glcqColor := clWhite;
     End;
end;

procedure TForm6.ComboBox2Change(Sender: TObject);
begin
     Case ComboBox2.ItemIndex of
          0  : Edit2.Color := clGreen;
          1  : Edit2.Color := clOlive;
          2  : Edit2.Color := clSkyBlue;
          3  : Edit2.Color := clPurple;
          4  : Edit2.Color := clTeal;
          5  : Edit2.Color := clGray;
          6  : Edit2.Color := clSilver;
          7  : Edit2.Color := clRed;
          8  : Edit2.Color := clLime;
          9  : Edit2.Color := clYellow;
          10 : Edit2.Color := clMoneyGreen;
          11 : Edit2.Color := clFuchsia;
          12 : Edit2.Color := clAqua;
          13 : Edit2.Color := clCream;
          14 : Edit2.Color := clMedGray;
          15 : Edit2.Color := clWhite;
     End;
     Case ComboBox2.ItemIndex of
          0  : ComboBox2.Color := clGreen;
          1  : ComboBox2.Color := clOlive;
          2  : ComboBox2.Color := clSkyBlue;
          3  : ComboBox2.Color := clPurple;
          4  : ComboBox2.Color := clTeal;
          5  : ComboBox2.Color := clGray;
          6  : ComboBox2.Color := clSilver;
          7  : ComboBox2.Color := clRed;
          8  : ComboBox2.Color := clLime;
          9  : ComboBox2.Color := clYellow;
          10 : ComboBox2.Color := clMoneyGreen;
          11 : ComboBox2.Color := clFuchsia;
          12 : ComboBox2.Color := clAqua;
          13 : ComboBox2.Color := clCream;
          14 : ComboBox2.Color := clMedGray;
          15 : ComboBox2.Color := clWhite;
     End;
     Case ComboBox2.ItemIndex of
          0  : glcallColor := clGreen;
          1  : glcallColor := clOlive;
          2  : glcallColor := clSkyBlue;
          3  : glcallColor := clPurple;
          4  : glcallColor := clTeal;
          5  : glcallColor := clGray;
          6  : glcallColor := clSilver;
          7  : glcallColor := clRed;
          8  : glcallColor := clLime;
          9  : glcallColor := clYellow;
          10 : glcallColor := clMoneyGreen;
          11 : glcallColor := clFuchsia;
          12 : glcallColor := clAqua;
          13 : glcallColor := clCream;
          14 : glcallColor := clMedGray;
          15 : glcallColor := clWhite;
     End;
end;

procedure TForm6.ComboBox3Change(Sender: TObject);
begin
     Case ComboBox3.ItemIndex of
          0  : Edit3.Color := clGreen;
          1  : Edit3.Color := clOlive;
          2  : Edit3.Color := clSkyBlue;
          3  : Edit3.Color := clPurple;
          4  : Edit3.Color := clTeal;
          5  : Edit3.Color := clGray;
          6  : Edit3.Color := clSilver;
          7  : Edit3.Color := clRed;
          8  : Edit3.Color := clLime;
          9  : Edit3.Color := clYellow;
          10 : Edit3.Color := clMoneyGreen;
          11 : Edit3.Color := clFuchsia;
          12 : Edit3.Color := clAqua;
          13 : Edit3.Color := clCream;
          14 : Edit3.Color := clMedGray;
          15 : Edit3.Color := clWhite;
     End;
     Case ComboBox3.ItemIndex of
          0  : ComboBox3.Color := clGreen;
          1  : ComboBox3.Color := clOlive;
          2  : ComboBox3.Color := clSkyBlue;
          3  : ComboBox3.Color := clPurple;
          4  : ComboBox3.Color := clTeal;
          5  : ComboBox3.Color := clGray;
          6  : ComboBox3.Color := clSilver;
          7  : ComboBox3.Color := clRed;
          8  : ComboBox3.Color := clLime;
          9  : ComboBox3.Color := clYellow;
          10 : ComboBox3.Color := clMoneyGreen;
          11 : ComboBox3.Color := clFuchsia;
          12 : ComboBox3.Color := clAqua;
          13 : ComboBox3.Color := clCream;
          14 : ComboBox3.Color := clMedGray;
          15 : ComboBox3.Color := clWhite;
     End;
     Case ComboBox3.ItemIndex of
          0  : glqsoColor := clGreen;
          1  : glqsoColor := clOlive;
          2  : glqsoColor := clSkyBlue;
          3  : glqsoColor := clPurple;
          4  : glqsoColor := clTeal;
          5  : glqsoColor := clGray;
          6  : glqsoColor := clSilver;
          7  : glqsoColor := clRed;
          8  : glqsoColor := clLime;
          9  : glqsoColor := clYellow;
          10 : glqsoColor := clMoneyGreen;
          11 : glqsoColor := clFuchsia;
          12 : glqsoColor := clAqua;
          13 : glqsoColor := clCream;
          14 : glqsoColor := clMedGray;
          15 : glqsoColor := clWhite;
     End;
end;

procedure TForm6.comboPrefixChange(Sender: TObject);
begin
     glCallChange := True;
end;

initialization
  {$I cfgvtwo.lrs}
  glcqColor     := clLime;
  glcallColor   := clRed;
  glqsoColor    := clSilver;
  glsi57QRGi      := 0;
  glsi57QRGs      := 0;
  glsi57Set       := False;
end.

