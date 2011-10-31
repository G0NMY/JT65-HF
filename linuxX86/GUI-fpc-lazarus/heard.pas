unit heard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls , CTypes, DateUtils;

type

  spotDBRec    = record
      callsign : Array[0..16] of Char;
      grid1    : Array[0..6] of Char;
      grid2    : Array[0..6] of Char;
      grid3    : Array[0..6] of Char;
      grid4    : Array[0..6] of Char;
      count    : CTypes.cuint32;
      first    : TDateTime;
      last     : TDateTime;
      b160     : Boolean;
      b80      : Boolean;
      b40      : Boolean;
      b30      : Boolean;
      b20      : Boolean;
      b17      : Boolean;
      b15      : Boolean;
      b12      : Boolean;
      b10      : Boolean;
      b6       : Boolean;
      b2       : Boolean;
      wb160    : Boolean;
      wb80     : Boolean;
      wb40     : Boolean;
      wb30     : Boolean;
      wb20     : Boolean;
      wb17     : Boolean;
      wb15     : Boolean;
      wb12     : Boolean;
      wb10     : Boolean;
      wb6      : Boolean;
      wb2      : Boolean;
  end;

  { TForm9 }

  TForm9 = class(TForm)
    Label3: TLabel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form9     : TForm9;
  pubSP     : spotDBRec;
  pubdoDB   : Boolean;
  publuCall : String;
  pubhaveDB : Boolean;
  pubfailDB : Boolean;
  cbstate   : Array[0..10] of Boolean;
  wcbstate  : Array[0..10] of Boolean;

implementation

{ TForm9 }

initialization
  {$I heard.lrs}

end.
