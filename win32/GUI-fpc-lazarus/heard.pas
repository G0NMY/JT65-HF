unit heard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  Grids, StdCtrls, CTypes, DateUtils;

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
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    edSearchCallsign: TEdit;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbSearchResults: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

implementation

{ TForm9 }

procedure TForm9.Button1Click(Sender: TObject);
Var
   i,gc    : Integer;
   s,g1,g2 : String;
   g3,g4   : String;
   timeout : Boolean;
begin
     // Search for callsign in internal DB
     lbSearchResults.Clear;
     lbSearchResults.Items.Add('Searching...');
     pubLUCall := upcase(trimleft(trimright(edSearchCallsign.Text)));
     pubhaveDB := false;
     pubFailDB := false;
     pubdoDB    := true;
     i := 0;
     timeout := false;
     while (not pubhaveDB) and (not pubFailDB) do
     begin
          application.ProcessMessages;
          sleep(10);
          inc(i);
          if i > 1000 then
             begin
                  timeout := true;
                  break;
             end;
     end;
     if pubhaveDB Then
     begin
          // Have a record in sp
          lbSearchResults.Clear;
          s := '';
          for i := 1 to 16 do
          begin
               s := s + pubSP.callsign[i];
          end;
          s := trimleft(trimright(s));
          if pubSP.count = 1 then lbSearchResults.Items.Add(s + ' Has been heard 1 time.') else lbSearchResults.Items.Add(s + ' Has been heard ' + IntToStr(pubSP.count) + ' times.');
          g1 := '';
          g2 := '';
          g3 := '';
          g4 := '';
          for i := 1 to 6 do
          begin
               g1 := g1 + pubSP.grid1[i];
               g2 := g2 + pubSP.grid2[i];
               g3 := g3 + pubSP.grid3[i];
               g4 := g4 + pubSP.grid4[i];
          end;
          g1 := trimleft(trimright(g1));
          g2 := trimleft(trimright(g2));
          g3 := trimleft(trimright(g3));
          g4 := trimleft(trimright(g4));
          if g1 = 'NILL' then g1 := '';
          if g2 = 'NILL' then g2 := '';
          if g3 = 'NILL' then g3 := '';
          if g4 = 'NILL' then g4 := '';
          gc := 0;
          s  := '';
          if not (g1 = '') then inc(gc);
          if not (g2 = '') then inc(gc);
          if not (g3 = '') then inc(gc);
          if not (g4 = '') then inc(gc);
          if gc > 0 then
          begin
               if gc > 1 then s := s + 'Grids this call heard from:  ' else s := s + 'Grid this call heard from:  ';
               if gc = 1 then s := s + g1;
               if gc = 2 then s := s + g1 + ' ' + g2;
               if gc = 3 then s := s + g1 + ' ' + g2 + ' ' + g3;
               if gc = 4 then s := s + g1 + ' ' + g2 + ' ' + g3 + ' ' + g4;
          end;
          if gc > 0 then lbSearchResults.Items.Add(s);
          lbSearchResults.Items.Add('First heard on ' + FormatDateTime('dddd mmmm d, yyyy',pubSP.first) + ' at ' + formatDateTime('hh:nn:ss',pubSP.first) + ' UTC');
          lbSearchResults.Items.Add('Last heard on ' + FormatDateTime('dddd mmmm d, yyyy',pubSP.last) + ' at ' + formatDateTime('hh:nn:ss',pubSP.last) + ' UTC');

          pubDoDB   := False;
          pubhaveDB := False;
     end;
     if pubFailDB Then
     begin
          // Failed to find
          lbSearchResults.Clear;
          lbSearchResults.Items.Add('Callsign not found.');
          pubDoDB := False;
     end;
     if timeout Then
     begin
          // Timed out
          lbSearchResults.Clear;
          lbSearchResults.Items.Add('Timed out.  Try again later.');
          pubDoDB := False;
     end;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
     // Clear heard list
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
     // Update record (really only allows setting of callsign looked up as
     // worked/not worked on a particular band.  It does not allow setting
     // of any other portions of the record
end;

initialization
  {$I heard.lrs}

end.

