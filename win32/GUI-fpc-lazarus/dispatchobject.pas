unit dispatchobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CTypes;

type

  TDispatcher = Class
     private
        // Station callsign and grid
        prThisMinute      : byte;
        prLastMinute      : byte;
        prNextMinute      : byte;
        prLastSecond      : byte;
        prThisSecond      : byte;
        prNextSecond      : byte;
        prThisTick        : integer;
        prLastTick        : integer;
        prThisAction      : byte;
        prLastAction      : byte;
        prNextAction      : byte;
        pralreadyHere     : Boolean;
        prtxNextPeriod    : Boolean;
        prstatusChange    : Boolean;
        prrunOnce         : Boolean;
        prtxPeriod        : byte;
        prrbcPing         : Boolean;
        prdorbReport      : Boolean;
        prrbcCache        : Boolean;
        prprimed          : Boolean;
        prfirstReport     : Boolean;
        prwatchMulti      : Boolean;
        prdoCAT           : Boolean;
        prhaveRXSRerr     : Boolean;
        prhaveTXSRerr     : Boolean;
        prdoRB            : Boolean;
        prresyncLoop      : Boolean;
        prhaveOddBuffer   : Boolean;
        prd65doDecodePass : Boolean;
        prd4doDecodePass  : Boolean;
        prcatInProgress   : Boolean;
        prrxInProgress    : Boolean;
        prdoCWID          : Boolean;
        pruseBuffer       : Integer;
        prtxmode          : Integer;
        prreDecode        : Boolean;
        prhaveEvenBuffer  : Boolean;
        practionSet       : Boolean;
        prsoundvalid      : Boolean;
        prfftvalid        : Boolean;
        prcfgerror        : Boolean;
        prcfgRecover      : Boolean;
        prHavePrefix      : Boolean;
        prHaveSuffix      : Boolean;
        prTxDirty         : Boolean;
        prTxValid         : Boolean;
        pransweringCQ     : Boolean;
        prtxCount         : Integer;
        pritemsIn         : Boolean;
        prthisTX          : String;
        prlastTX          : String;
        prMyCall          : String;

     public
        Constructor create();

     property thisMinute : Byte
        read  prThisMinute
        write prThisMinute;
     property lastMinute : Byte
        read  prLastMinute
        write prLastMinute;
     property nextMinute : Byte
        read  prNextMinute
        write prNextMinute;
     property lastSecond : Byte
        read  prLastSecond
        write prLastSecond;
     property thisSecond : Byte
        read  prThisSecond
        write prThisSecond;
     property nextSecond : Byte
        read  prNextSecond
        write prNextSecond;
     property thisTick : Integer
        read  prThisTick
        write prThisTick;
     property lastTick : Integer
        read  prLastTick
        write prLastTick;
     property thisAction : Byte
        read  prThisAction
        write prThisAction;
     property lastAction : Byte
        read  prLastAction
        write prLastAction;
     property nextAction : Byte
        read  prNextAction
        write prNextAction;
     property alreadyHere : Boolean
        read  prAlreadyHere
        write prAlreadyHere;
     property txNextPeriod : Boolean
        read  prTXNextPeriod
        write prTXNextPeriod;
     property statusChange : Boolean
        read  prStatusChange
        write prStatusChange;
     property runOnce : Boolean
        read  prRunOnce
        write prRunOnce;
     property txPeriod : Byte
        read  prTXPeriod
        write prTXPeriod;
     property rbcPing : Boolean
        read  prRBCPing
        write prRBCPing;
     property doRBReport : Boolean
        read  prDoRBReport
        write prDoRBReport;
     property rbcCache : Boolean
        read  prRBCCache
        write prRBCCache;
     property primed : Boolean
        read  prPrimed
        write prPrimed;
     property firstReport : Boolean
        read  prFirstReport
        write prFirstReport;
     property watchMulti : Boolean
        read  prWatchMulti
        write prWatchMulti;
     property doCAT : Boolean
        read  prdoCAT
        write prdoCAT;
     property haveRXSRErr : Boolean
        read  prHaveRXSRErr
        write prHaveRXSRErr;
     property haveTXSRErr : Boolean
        read  prHaveTXSRErr
        write prHaveTXSRErr;
     property doRB : Boolean
        read  prdoRB
        write prdoRB;
     property resyncLoop : Boolean
        read  prResyncLoop
        write prResyncLoop;
     property haveOddBuffer : Boolean
        read  prHaveOddBuffer
        write prHaveOddBuffer;
     property d65doDecodePass : Boolean
        read  prd65doDecodePass
        write prd65doDecodePass;
     property d4doDecodePass : Boolean
        read  prd4doDecodePass
        write prd4doDecodePass;
     property catInProgress : Boolean
        read  prCATInProgress
        write prCATInProgress;
     property rxInProgress : Boolean
        read  prRXInProgress
        write prRXInProgress;
     property doCWID : Boolean
        read  prDoCWID
        write prDoCWID;
     property useBuffer : Integer
        read  prUseBuffer
        write prUseBuffer;
     property txMode : Integer
        read  prTXMode
        write prTXMode;
     property reDecode : Boolean
        read  prreDecode
        write prreDecode;
     property haveEvenBuffer : Boolean
        read  prHaveEvenBuffer
        write prHaveEvenBuffer;
     property actionSet : Boolean
        read  prActionSet
        write prActionSet;
     property soundValid : Boolean
        read  prSoundValid
        write prSoundValid;
     property fftValid : Boolean
        read  prFFTValid
        write prFFTValid;
     property cfgError : Boolean
        read  prCfgError
        write prCfgError;
     property cfgRecover : Boolean
        read  prCfgRecover
        write prCfgRecover;
     property havePrefix : Boolean
        read  prHavePrefix
        write prHavePrefix;
     property haveSuffix : Boolean
        read  prHaveSuffix
        write prHaveSuffix;
     property txDirty : Boolean
        read  prTXDirty
        write prTXDirty;
     property txValid : Boolean
        read  prTXValid
        write prTXValid;
     property answeringCQ : Boolean
        read  prAnsweringCQ
        write prAnsweringCQ;
     property txCount : Integer
        read  prTXCount
        write prTXCount;
     property itemsIn : Boolean
        read  pritemsIn
        write pritemsIn;
     property lastTX : String
        read  prLastTX
        write prLastTX;
     property thisTX : String
        read  prThisTX
        write prThisTX;
     property myCall : String
        read  prMyCall
        write prMyCall;
  end;

implementation
constructor TDispatcher.Create();
begin
     prLastMinute      := 0;
     prThisMinute      := 0;
     prNextMinute      := 0;
     prLastSecond      := 0;
     prThisSecond      := 0;
     prNextSecond      := 0;
     prThisTick        := 0;
     prLastTick        := 0;
     prThisAction      := 0;
     prLastAction      := 0;
     prNextAction      := 0;
     pralreadyHere     := False;
     prtxNextPeriod    := False;
     prstatusChange    := False;
     prrunOnce         := False;
     prtxPeriod        := 0;
     prrbcPing         := False;
     prdorbReport      := False;
     prrbcCache        := False;
     prprimed          := False;
     prfirstReport     := False;
     prwatchMulti      := False;
     prdoCAT           := False;
     prhaveRXSRerr     := False;
     prhaveTXSRerr     := False;
     prdoRB            := False;
     prresyncLoop      := False;
     prhaveOddBuffer   := False;
     prd65doDecodePass := False;
     prd4doDecodePass  := False;
     prcatInProgress   := False;
     prrxInProgress    := False;
     prdoCWID          := False;
     pruseBuffer       := 0;
     prtxmode          := 0;
     prreDecode        := False;
     prhaveEvenBuffer  := False;
     practionSet       := False;
     prsoundvalid      := False;
     prfftvalid        := False;
     prcfgerror        := False;
     prcfgRecover      := False;
     prHavePrefix      := False;
     prHaveSuffix      := False;
     prTxDirty         := False;
     prTxValid         := False;
     pransweringCQ     := False;
     prtxCount         := 0;
     pritemsIn         := False;
     prLastTX          := '';
     prThisTX          := '';
     prMyCall          := '';
end;

end.

