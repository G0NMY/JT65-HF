unit heard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Grids, StdCtrls;

type

  { TForm9 }

  TForm9 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    edSearchCallsign: TEdit;
    heardGrid: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbSearchResults: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure heardGridHeaderClick(Sender: TObject; IsColumn: Boolean;
      Index: Integer);
  private
    { private declarations }
    prData : Array of String;
    prIsSorted       : Boolean;
    prCallsignSorted : Boolean;
    prGridSorted     : Boolean;
    prBandSorted     : Boolean;
    prCountSorted    : Boolean;
    prLastSorted     : Boolean;
  public
    { public declarations }
    function addToSG(call,grid,band,count,last : String) : Boolean;
    function sortSG(column,direction : String) : Boolean;
  end;

var
  Form9 : TForm9;
  i     : integer;

implementation

{ TForm9 }

procedure TForm9.Button1Click(Sender: TObject);
begin
     // Search for callsign in internal DB
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
     // Clear heard list
end;

procedure TForm9.heardGridHeaderClick(Sender: TObject; IsColumn: Boolean;
  Index: Integer);
begin
     // OK... going to try to do this right this time around :)  I've only been
     // trying for the last 3 years.
     // When user clicks a column I want to sort by clicked column
     heardGrid.SortColRow(IsColumn,Index);
end;

function  TForm9.sortSG(column,direction : String) : Boolean;
begin
     // Sorts column (call,grid,band,count,last) in direction (asc,des)

end;

function  TForm9.addToSG(call,grid,band,count,last : String) : Boolean;
begin
     result := true;
end;

initialization
  {$I heard.lrs}
  //setLength(prData,8192);
  //for i := 0 to 8191 do
  //begin
  //     prData[i] := '';
  //end;
  //prIsSorted       := False;
  //prCallsignSorted := False;
  //prGridSorted     := False;
  //prBandSorted     := False;
  //prCountSorted    := False;
  //prLastSorted     := False;

end.

