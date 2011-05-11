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
unit cfgobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

type
  TConfiguration = Class
     private
        // Station callsign and grid, must be valid for TX enable
        stCallsign : String;
        stGrid     : String;
        stPrefix   : Integer;
        stSuffix   : Integer;
        // RB/PSK Reporter values, must be valid for RB/PSKR Enable
        spCallsign : String;
        spInfo     : String;
        spRBOn     : Boolean;
        spPSOn     : Boolean;
        spQRG      : Integer;
        rbOnline   : Boolean;
        prOnline   : Boolean;
        spEnable   : Boolean;
        // Decoder settings
        cfgLogCSV   : Boolean;
        cfgCSVpath  : String;
        cfgADIpath  : String;
        cfgAFC      : Boolean;
        cfgNB       : Boolean;
        cfgRXDF     : Integer;
        cfgDecBW    : Integer;
        cfgBinSpace : Integer;
        cfgOptFFT   : Boolean;
        cfgOptFFTFn : String;
        cfgMulti    : Boolean;
        cfgMultiQSO : Boolean;
        cfgMultiRe  : Boolean;
        cfgMultiDef : Boolean;
        // TX variables
        cfgTXPeriod : Integer;
        cfgTRXDF    : Boolean;
        cfgTXDF     : Integer;
        cfgTXEnable : Boolean;
        cfgTXSMsg   : String;
        cfgTXFMsg   : String;
        cfgPTTDev   : String;
        cfgPTTType  : String;
        cfgPTTOn    : Boolean;
        cfgCWID     : Boolean;
        cfgTXFree   : Boolean;
        cfgTXWD     : Boolean;
        cfgTXWDc    : Integer;
        cfgTXIsOn   : Boolean;
        cfgTXTo     : String;
        cfgTXReport : String;
        // Audio Device
        cfgAUIn     : Integer;
        cfgAUOut    : Integer;
        cfgAUInTxt  : String;
        cfgAUOutTxt : String;
        cfgAURChans : Integer;
        cfgAUTChans : Integer;
        cfgAURChan  : Integer;
        cfgAUTChan  : Integer;
        cfgAURXSR   : Double;
        cfgAUTXSR   : Double;
        cfgAUSRCorr : Boolean;
        cfgAULDgain : Integer;
        cfgAURDgain : Integer;
        cfgMonoADC  : Boolean;
        cfgMonoDAC  : Boolean;
        cfgADStatus : Integer;
        cfgDAStatus : Integer;
        // Spectrum Display
        cfgSpecP    : Integer;
        cfgSpecB    : Integer;
        cfgSpecC    : Integer;
        cfgSpecS    : Integer;
        cfgSpecG    : Integer;
        cfgSpecSm   : Boolean;
        // Mode settings
        cfgTXMode   : String;
        cfgRXMode   : String;
        cfgUseKV    : Boolean;
        cfgStrict   : Boolean;
        // Program GUI settings
        cfgCQLine   : Integer;
        cfgMyLine   : Integer;
        cfgQSOLine  : Integer;
        // Rig Control
        cfgRCType   : String;
        txdfcat     : Boolean;
        txdfCATtol  : Integer;
        // Counters
        cfgRBCount  : Integer;
        cfgPRCount  : Integer;
        cfgTXCount  : Integer;
        // Overall configuration state
        cfgiVersion : Integer;
        cfgsVersion : String;
        cfgValid    : Boolean;

     public
        Constructor create();

        procedure stCallsignSet(callsign : String);
        procedure stGridSet(grid : String);
        procedure rbCallsignSet(callsign : String);
        procedure txFMsgSet(txmsg : String);
        procedure incRBCount();
        procedure incPSKRCount();
        procedure incTXCount();

        //function stCallsignGet() : String;

        // Call validate to return an overall status of configuration object.
        // Anything critical that is incorrect will lead to a false result.
        function  validate() : Boolean;

        // Feed this a message and will reutrn true if it's a valid JT65 message
        function  testMsg(msg : String) : Boolean;

        // Feed this a qrid and will reutrn true if it's valid
        function  validateGrid(grid : String) : Boolean;

        // Feed this a QRG (string) and it will return a value in hertz (integer)
        function  testQRG(qrg : String) : Integer;

        // Toggles PTT - returns true if PTT ON false if PTT OFF
        function  pttToggle() : Boolean;

        // This is the primary station callsign used for TX
        property callsign : String
           read  stCallsign
           write stCallsignSet;
        // Integer value to element in callsign suffix value list (-1 = None)
        property suffix : Integer
           read  stSuffix
           write stSuffix;
        // Integer value to element in callsign prefix value list (-1 = None)
        property prefix : Integer
           read  stPrefix
           write stPrefix;
        // Station's Maidenhead grid square
        property grid : String
           read  stGrid
           write stGridSet;
        // This is the RB and/or PSK Reporter callsign.  May be same as primary
        // or 'extended'
        property rbcallsign : String
           read  spCallsign
           write rbCallsignSet;
        // String holding station info.  Only used for PSK Reporter (for now).
        property rbInfo : String
           read  spInfo
           write spInfo;
        // Boolean for RB enable/disable
        property RBOn : Boolean
           read  spRBOn
           write spRBOn;
        // Boolean for PSK Reporter enable/disable
        property PSKROn : Boolean
           read  spPSOn
           write spPSOn;
        // Boolean for RB connection status
        property rbStatus : Boolean
           read  rbOnline
           write rbOnline;
        // Boolean for PSKR connection status
        property pskrStatus : Boolean
           read  prOnline
           write prOnline;
        // Integer value of Dial QRG in Hertz
        property dialQRG : Integer
           read  spQRG
           write spQRG;
        // Boolean for Log Receptions/Transmissions to CSV file
        property logCSV : Boolean
           read  cfgLogCSV
           write cfgLogCSV;
        // String for CSV file path
        property logCSVpath : String
           read  cfgCSVpath
           write cfgCSVpath;
        // String for ADIF file path
        property logADIpath : String
           read  cfgADIpath
           write cfgADIpath;
        // Boolean for AFC Enable/Disable
        property decoderAFC : Boolean
           read  cfgAFC
           write cfgAFC;
        // Boolean for NB Enable/Disable
        property decoderNB : Boolean
           read  cfgNB
           write cfgNB;
        // Integer for Single Decoder BW
        property decoderBW : Integer
           read  cfgDecBW
           write cfgDecBW;
        // Boolean for TX DF = RX DF matching
        property decoderTRXDF : Boolean
           read  cfgTRXDF
           write cfgTRXDF;
        // Integer value of current RX DF setting
        property decoderRXDF : Integer
           read  cfgRXDF
           write cfgRXDF;
        // Integer value of current TX DF setting
        property decoderTXDF : Integer
           read  cfgTXDF
           write cfgTXDF;
        // Integer value defining multiple decoder bin spacing
        property multiBinSpace : Integer
           read  cfgBinSpace
           write cfgBinSpace;
        // Boolean for enable/disable optimum FFT metric usage
        property decoderOptFFT : Boolean
           read  cfgOptFFT
           write cfgOptFFT;
        // String holding path/filename of optimum fft metrics
        property decoderOptFFTFile : String
           read  cfgOptFFTFn
           write cfgOptFFTFn;
        // Boolean for multi decoder enable/disable
        property decoderMulti : Boolean
           read  cfgMulti
           write cfgMulti;
        // Boolean for multi off in QSO setting.  True = disable multi in QSO
        property multiOffInQSO : Boolean
           read  cfgMultiQSO
           write cfgMultiQSO;
        // Boolean for multi on when QSO completed.  True = re-enable multi after QSO
        property multiOnQSOEnd : Boolean
           read  cfgMultiRe
           write cfgMultiRe;
        // Boolean for multi on when defaults selected
        property multiOnDefaults : Boolean
           read  cfgMultiDef
           write cfgMultiDef;
        // Integer value for period to TX 0 = Even, 1 = Odd
        property txPeriod : Integer
           read  cfgTXPeriod
           write cfgTXPeriod;
        // Boolean for TX Enable/Disable
        // This defines the ability to TX.  May be false due to configuration error.
        // If false NO TX IS ALLOWED FOR ANY REASON.
        property canTX : Boolean
           read  cfgTXEnable
           write cfgTXEnable;
        // Boolean for Spotting Enable/Disable
        // This defines the ability to Spot.  May be false due to configuration error.
        // If false NO spotting IS ALLOWED FOR ANY REASON.
        property canSpot : Boolean
           read  spEnable
           write spEnable;
        // Boolean for PTT Enable/Disable
        property pttState : Boolean
           read  cfgPTTOn
           write cfgPTTOn;
        // Boolean holding status of TX (true = TX is on now)
        property txStatus : Boolean
           read  cfgTXIsOn
           write cfgTXIsOn;
        // String of callsign to transmit to
        property txTo : String
           read  cfgTXto
           write cfgTXto;
        // String of signal report value to send
        property txReport : String
           read  cfgTXReport
           write cfgTXReport;
        // String value of PTT device (COMX, VOX, NONE, RIGCTRL)
        property pttDevice : String
           read  cfgPTTDev
           write cfgPTTDev;
        // String holding PTT Type (None, VOX, SERIALA, SERIALB, RIGCTRL)
        // SerialA = libjt65 ptt code - SerialB = native ptt code
        property pttType : String
           read  cfgPTTType
           write cfgPTTType;
        // String holding rig control type (none, hrd, commander, omni, si570, hamlib)
        property rigControl : String
           read  cfgRCType
           write cfgRCType;
        // Enable/disable TxDF via CAT
        property txdfByCAT : Boolean
           read  txdfcat
           write txdfcat;
        // Integer holding tolerance for CAT TxDF change.  This defines how far, it at
        // all, TxDF will use audio tune versus RF tune
        property txdfByCATtolerance : Integer
           read  txdfCATtol
           write txdfCATtol;
        // Boolean for message type to send true = free text/false = structured
        property sendFreeText : Boolean
           read  cfgTXFree
           write cfgTXFree;
        // Enable/disable runaway TX monitor (TX Watchdog)
        property txWatchDog : Boolean
           read  cfgTXWD
           write cfgTXWD;
        // How many same TX equals too many
        property txWatchDogCount : Integer
           read  cfgTXWDc
           write cfgTXWDc;
        // String holding free text message to TX
        property txFMessage : String
           read  cfgTXFMsg
           write txFMsgSet;
        // String holding structured text message to TX
        property txSMessage : String
           read  cfgTXSMsg
           write cfgTXSMsg;
        // Integer holding index to selected RX Audio device
        property rxAudio : Integer
           read  cfgAUIn
           write cfgAUIn;
        // Integer holding index to selected TX Audio device
        property txAudio : Integer
           read  cfgAUOut
           write cfgAUOut;
        // String holding text name of RX device
        property rxAudioTxt : String
           read  cfgAUInTxt
           write cfgAUInTxt;
        // String holding text name of TX device
        property txAudioTxt : String
           read  cfgAUOutTxt
           write cfgAUOutTxt;
        // Integer holding count of RX Audio channels
        property rxChans : Integer
           read  cfgAURChans
           write cfgAURChans;
        // Integer holding count of TX Audio channels
        property txChans : Integer
           read  cfgAUTChans
           write cfgAUTChans;
        // Integer holding current RX Audio channel (1 = Left, 2 = Right)
        property rxChan : Integer
           read  cfgAURChan
           write cfgAURChan;
        // Integer holding current TX Audio channel
        property txChan : Integer
           read  cfgAUTChan
           write cfgAUTChan;
        // Float holding current RX Sample rate correction factor
        property rxSRAdj : Double
           read  cfgAURXSR
           write cfgAURXSR;
        // Float holding current TX Sample rate correction factor
        property txSRAdj : Double
           read  cfgAUTXSR
           write cfgAUTXSR;
        // Boolean to enable/disable automatic SR correction (applies to TX and RX)
        property autoSRcorrect : Boolean
           read  cfgAUSRCorr
           write cfgAUSRCorr;
        // Integer holding current RX Audio digital gain for left channel
        property dgainL : Integer
           read  cfgAULDgain
           write cfgAULDgain;
        // Integer holding current RX Audio digital gain for right channel
        property dgainR : Integer
           read  cfgAURDgain
           write cfgAURDgain;
        // Boolean for use 1 channel ADC
        property monoADC : Boolean
           read  cfgMonoADC
           write cfgMonoADC;
        // Boolean for use 1 channel DAC
        property monoDAC : Boolean
           read  cfgMonoDAC
           write cfgMonoDAC;
        // Integer for ADC status (-1 error, 0 idle, 1 running)
        property adcStatus : Integer
           read  cfgADStatus
           write cfgADStatus;
        // Integer for DAC status (-1 error, 0 idle, 1 running)
        property dacStatus : Integer
           read  cfgDAStatus
           write cfgDAStatus;
        // Boolean for enable/disable CW ID
        property cwID : Boolean
           read  cfgCWID
           write cfgCWID;
        // Integer holding index of selected spectrum display pallete
        property spectrumPallete : Integer
           read  cfgSpecP
           write cfgSpecP;
        // Integer holding brightness value for spectrum display
        property spectrumBrightness : Integer
           read  cfgSpecB
           write cfgSpecB;
        // Integer holding contrast value for spectrum display
        property spectrumContrast : Integer
           read  cfgSpecC
           write cfgSpecC;
        // Integer holding speed value for spectrum display
        property spectrumSpeed : Integer
           read  cfgSpecS
           write cfgSpecS;
        // Integer holding visual gain value for spectrum display
        property spectrumGain : Integer
           read  cfgSpecG
           write cfgSpecG;
        // Boolean for spectrum display smoothing enable/disable
        property spectrumSmooth : Boolean
           read  cfgSpecSm
           write cfgSpecSm;
        // String holding currently selected TX Mode (65A, 65B, 65C, 4A, 4B, 4C)
        property txMode : String
           read  cfgTXMode
           write cfgTXMode;
        // String holding currently selected RX Mode (65A, 65B, 65C, 4A, 4B, 4C)
        property rxMode : String
           read  cfgRXMode
           write cfgRXMode;
        // Boolean for KVASD enable/disable
        property useKV : Boolean
           read  cfgUseKV
           write cfgUseKV;
        // Boolean for strict mode enable/disable (Strict mode = no late TX start)
        property useStrict : Boolean
           read  cfgStrict
           write cfgStrict;
        // Integer holding count of RB Reports sent
        property rbCount : Integer
           read  cfgRBCount
           write cfgRBCount;
        // Integer holding count of PSKR Reports sent
        property pskrCount : Integer
           read  cfgPRCount
           write cfgPRCount;
        // Integer holding count of TX Message sent (same TX message counter)
        property txCount : Integer
           read  cfgTXCount
           write cfgTXCount;
        // Integer holding index to background color for line with 'CQ'
        property cqLineColor : Integer
           read  cfgCQLine
           write cfgCQLine;
        // Integer holding index to background color for line with 'my call'
        property mycallLineColor : Integer
           read  cfgMyLine
           write cfgMyLine;
        // Integer holding index to background color for line with 'ongoing QSO'
        property qsoLineColor : Integer
           read  cfgQSOLine
           write cfgQSOLine;
        // Integer holding program version (108, 200 and etc.)
        property swiVersion : Integer
           read  cfgiVersion
           write cfgiVersion;
        // String holding program version (1.0.8, 2.0.0 and etc)
        property swsVersion : String
           read  cfgsVersion
           write cfgsVersion;
        // Status of overall configuration object
        property configurationValid : Boolean
           read validate;
  end;

implementation
   constructor TConfiguration.Create();
   begin
        stCallsign  := '';
        stPrefix    := -1;
        stSuffix    := -1;
        stGrid      := '';
        spCallsign  := '';
        spInfo      := '';
        spRBOn      := False;
        spPSOn      := False;
        spQRG       := 0;
        cfgiVersion := 0;
        cfgsVersion := '';
        cfgLogCSV   := False;
        cfgCSVpath  := '';
        cfgADIpath  := '';
        cfgAFC      := False;
        cfgNB       := False;
        cfgDecBW    := 100;
        cfgTRXDF    := False;
        cfgTXDF     := 0;
        cfgRXDF     := 0;
        cfgBinSpace := 0;
        cfgTXPeriod := 0;
        cfgTXEnable := False;
        spEnable    := False;
        cfgTXWD     := False;
        cfgTXWDc    := 0;
        cfgTXIsOn   := False;
        cfgPTTDev   := '';
        cfgPTTType  := '';
        cfgPTTOn    := False;
        cfgTXFree   := False;
        cfgTXSMsg   := '';
        cfgTXFMsg   := '';
        cfgTXTo     := '';
        cfgTXReport := '';
        cfgAUIn     := 0;
        cfgAUOut    := 0;
        cfgAUInTxt  := '';
        cfgAUOutTxt := '';
        cfgAURChans := 0;
        cfgAUTChans := 0;
        cfgAURChan  := 0;
        cfgAUTChan  := 0;
        cfgAURXSR   := 0.0;
        cfgAUTXSR   := 0.0;
        cfgAUSRCorr := False;
        cfgAULDgain := 0;
        cfgAURDgain := 0;
        cfgADStatus := 0;
        cfgDAStatus := 0;
        cfgOptFFT   := False;
        cfgOptFFTFn := '';
        cfgCWID     := False;
        cfgMulti    := False;
        cfgMultiQSO := False;
        cfgMultiRe  := False;
        cfgMultiDef := False;
        cfgSpecP    := 0;
        cfgSpecB    := 0;
        cfgSpecC    := 0;
        cfgSpecS    := 0;
        cfgSpecG    := 0;
        cfgRBCount  := 0;
        cfgPRCount  := 0;
        cfgTXCount  := 0;
        cfgTXMode   := '65A';
        cfgRXMode   := '65A';
        cfgRCType   := '';
        cfgUseKV    := False;
        cfgStrict   := False;
        cfgSpecSm   := False;
        cfgCQLine   := 0;
        cfgMyLine   := 0;
        cfgQSOLine  := 0;
        rbOnline    := False;
        prOnline    := False;
        cfgValid    := False;
        cfgMonoADC  := False;
        cfgMonoDAC  := False;
        txdfcat     := False;
        txdfcattol  := 0;
   end;

   procedure TConfiguration.incRBCount();
   begin
        inc(cfgRBCount);
   end;

   procedure TConfiguration.incPSKRCount();
   begin
        inc(cfgPRCount);
   end;

   procedure TConfiguration.incTXCount();
   begin
        inc(cfgTXCount);
   end;

   procedure TConfiguration.stCallsignSet(callsign : String);
   var
        valid    : Boolean;
        testcall : String;
   begin
        valid := True;
        testcall := trimleft(trimright(callsign));
        testcall := upcase(testcall);
        if (length(testcall) < 3) or (length(testcall) > 6) then
        begin
             stCallsign := '';
             valid := False;
        end;
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
             // Second check for some common things... this should be covered by the
             // checks above, but, it doesn't hurt to check again.
             if valid then
             begin
                  If (AnsiContainsText(testcall,'/')) Or (AnsiContainsText(testcall,'.')) Or
                     (AnsiContainsText(testcall,'-')) Or (AnsiContainsText(testcall,'\')) Or
                     (AnsiContainsText(testcall,',')) Then valid := false;
             end;
             // Tested again for presence of 'bad' characters.
        end;
        if valid then stCallsign := testcall else stCallsign := '';
   end;

   procedure TConfiguration.stGridSet(grid : String);
   var
        valid    : Boolean;
        testGrid : String;
   begin
        valid := True;
        testGrid := trimleft(trimright(grid));
        testGrid := upcase(testGrid);
        if (length(testGrid) < 4) or (length(testGrid) > 6) or (length(testGrid) = 5) then
        begin
             stGrid := '';
             valid := False;
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
        if valid then
        begin
             if length(testGrid) = 4 then testGrid := testGrid + 'mm';
             stGrid := testGrid;
        end
        else
        begin
             stGrid := '';
        end;
   end;

   procedure TConfiguration.rbCallsignSet(callsign : String);
   var
        valid    : Boolean;
        testcall : String;
   begin
        valid := True;
        testcall := trimleft(trimright(callsign));
        testcall := upcase(testcall);
        if (length(testcall) < 3) or (length(testcall) > 32) then
        begin
             spCallsign := '';
             valid := False;
        end;
        if valid then spCallsign := testcall else spCallsign := '';
   end;

   procedure TConfiguration.txFMsgSet(txmsg : String);
   var
        tmpmsg : String;
        shmsg  : Boolean;
        valid  : Boolean;
        i      : integer;
   begin
        // In the case of a free text message I need to validate it such that
        // it does not exceed the 13 character limit or have characters in it
        // that are not part of the JT65 character set.
        // The JT65 Character set is:
        // A...Z 0...9 _+-./? (_ = Space)
        valid  := False;
        tmpmsg := txmsg;
        // Insure upper case
        tmpmsg := upcase(tmpmsg);
        // Check for start of message characters that will result in shorthand
        // message instead of text.
        shmsg := False;
        if tmpmsg[1..2] = '73' then shmsg := true;
        if tmpmsg[1..2] = 'RO' then shmsg := true;
        if tmpmsg[1..3] = 'RRR' then shmsg := true;
        if shmsg then
        begin
             if tmpmsg[1..2] = '73' then tmpmsg :=  '73 SHORTHAND';
             if tmpmsg[1..2] = 'RO' then tmpmsg :=  'RO SHORTHAND';
             if tmpmsg[1..3] = 'RRR' then tmpmsg := 'RRR SHORTHAND';
             valid := true;
        end;
        // If not evaluated as shorthand validate/clean the free text.
        if not shmsg then
        begin
             // Truncate to 13 characters if needed.
             if length(tmpmsg)>13 then tmpmsg := tmpmsg[1..13];
             i := 1;
             while i < 13 do
             begin
                  valid := False;
                  case tmpmsg[i] of 'A'..'Z': valid := True else valid := False; end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of ' ': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '+': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '-': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '.': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '/': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '?': valid := True else valid := False; end;
                  end;
                  if not valid then tmpmsg[i] := ' ';
                  inc(i);
             end;
        end;
        // All invalid characters replaced with space,or, if it will evaluate to
        // shorthand message converted to shorthand form.
        cfgtxFMsg := tmpmsg;
   end;

   function TConfiguration.validate() : Boolean;
   Var
        valid : Boolean;
   Begin
        valid := True;
        if length(stCallsign) > 0 then valid := True else valid := False;
        if length(spCallsign) > 0 then valid := True else valid := False;
        if length(stGrid) > 0 then valid := True else valid := False;
        result := valid;
   end;

   function  TConfiguration.validateGrid(grid : String) : Boolean;
   var
        valid    : Boolean;
        testGrid : String;
   begin
        valid := True;
        testGrid := trimleft(trimright(grid));
        testGrid := upcase(testGrid);
        if (length(testGrid) < 4) or (length(testGrid) > 6) or (length(testGrid) = 5) then
        begin
             stGrid := '';
             valid := False;
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
   function TConfiguration.testMsg(msg : String) : Boolean;
   var
        tmpmsg : String;
        shmsg  : Boolean;
        valid  : Boolean;
        i      : integer;
   begin
        // In the case of a free text message I need to validate it such that
        // it does not exceed the 13 character limit or have characters in it
        // that are not part of the JT65 character set.
        // The JT65 Character set is:
        // A...Z 0...9 _+-./? (_ = Space)
        valid  := False;
        tmpmsg := msg;
        // Insure upper case
        tmpmsg := upcase(tmpmsg);
        // Check for start of message characters that will result in shorthand
        // message instead of text.
        shmsg := False;
        if tmpmsg[1..2] = '73' then shmsg := true;
        if tmpmsg[1..2] = 'RO' then shmsg := true;
        if tmpmsg[1..3] = 'RRR' then shmsg := true;
        if shmsg then valid := true;
        // If not evaluated as shorthand validate/clean the free text.
        if not shmsg then
        begin
             // Truncate to 13 characters if needed.
             if length(tmpmsg)>13 then tmpmsg := tmpmsg[1..13];
             i := 1;
             while i < 13 do
             begin
                  valid := False;
                  case tmpmsg[i] of 'A'..'Z': valid := True else valid := False; end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of ' ': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '+': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '-': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '.': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '/': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       case tmpmsg[i] of '?': valid := True else valid := False; end;
                  end;
                  inc(i);
             end;
        end;
        // All invalid characters replaced with space,or, if it will evaluate to
        // shorthand message converted to shorthand form.
        result := valid;
   end;

   function TConfiguration.testQRG(qrg : String) : Integer;
   var
        i, j     : Integer;
        tstint   : Integer;
        tstflt   : Double;
        valid    : Boolean;
   begin
        // Test for , in value and replace with .
        j := length(qrg);
        for i := 1 to j do
        begin
             if qrg[i] = ',' then qrg[i] := '.';
        end;
        // Test for non-numerics
        valid := true;
        for i := 1 to j do
        begin
             if valid then
             begin
                  case qrg[i] of '0'..'9': valid := True else valid := False; end;
                  if not valid then
                  begin
                       case qrg[i] of '.': valid := True else valid := False; end;
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
             If not AnsiContainsText(qrg,'.') then
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

   function  TConfiguration.pttToggle() : Boolean;
   begin
        if cfgPTTOn then
        begin
             cfgPTTOn := False;
             result := False;
        end
        else
        begin
             cfgPTTOn := True;
             result := True;
        end;
   end;

end.

