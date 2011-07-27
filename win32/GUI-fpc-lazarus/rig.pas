unit rig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, rigObject;

var
  rig1          : rigobject.TRadio;
  rigPTT        : Boolean;
  rigController : String;
  rigAltPTT     : Boolean;
  rigPTTMethod  : String;
  rigPTTLines   : String;
  rigPTTPort    : String;
  rigQRG        : Integer;
  rigReadQRG    : Boolean;
  rigBusy       : Boolean;

procedure poll();
procedure init();

implementation
  procedure poll();
  var
    tempqrg : Double;
    tempfoo : String;
  begin
       rigBusy := True;
       if rigPTTMethod = 'VOX' then rig1.useVOXPTT := true else rig1.useVOXPTT := false;
       if rigPTTMethod = 'COM' then rig1.useSerialPTT := true else rig1.useSerialPTT := false;
       if rigPTTMethod = 'CAT' then rig1.useCATPTT := true else rig1.useCATPTT := false;
       if rigPTTMethod = 'OFF' then rig1.noTX := true else rig1.noTX := false;
       rig1.rigcontroller := rigController;
       tempFoo := rig1.rigController;
       if rigPTT then rig1.PTT(true) else rig1.PTT(false);
       if rigReadQRG then
       begin
            rig1.pollRig();
            rigQRG := rig1.qrg;
            tempQRG := rig1.QRG;
       end;
       rigBusy := False;
  end;

  procedure init();
  begin
       rig1          := rigobject.TRadio.create();
       rigPTT        := False;
       rigController := 'NONE';
       rigAltPTT     := False;
       rigPTTMethod  := 'OFF';
       rigPTTLines   := 'DTRRTS';
       rigPTTPort    := 'NONE';
       rigQRG        := 0;
       rigReadQRG    := False;
       rigBusy       := False;
  end;

end.

