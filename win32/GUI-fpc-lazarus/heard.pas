unit heard;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, CTypes, DateUtils;

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
    Button4: TButton;
    cb160: TCheckBox;
    cb6: TCheckBox;
    cb2: TCheckBox;
    wcb160: TCheckBox;
    wcb80: TCheckBox;
    wcb40: TCheckBox;
    wcb30: TCheckBox;
    wcb20: TCheckBox;
    wcb17: TCheckBox;
    wcb15: TCheckBox;
    wcb12: TCheckBox;
    cb80: TCheckBox;
    wcb10: TCheckBox;
    wcb6: TCheckBox;
    wcb2: TCheckBox;
    cb40: TCheckBox;
    cb30: TCheckBox;
    cb20: TCheckBox;
    cb17: TCheckBox;
    cb15: TCheckBox;
    cb12: TCheckBox;
    cb10: TCheckBox;
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
    procedure Button4Click(Sender: TObject);
    procedure cbClick(Sender: TObject);
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
     // Clear the transfer record
     for i := 0 to 16 do
     begin
          pubSP.callsign[i] := chr(0);
          if i < 7 then pubSP.grid1[i] := chr(0);
          if i < 7 then pubSP.grid2[i] := chr(0);
          if i < 7 then pubSP.grid3[i] := chr(0);
          if i < 7 then pubSP.grid4[i] := chr(0);
     end;
     pubSP.count := 0;
     pubSP.first := Now;
     pubSP.last  := Now;
     pubSP.b160  := false;
     pubsp.b80   := false;
     pubsp.b40   := false;
     pubsp.b30   := false;
     pubsp.b20   := false;
     pubsp.b17   := false;
     pubsp.b15   := false;
     pubsp.b12   := false;
     pubsp.b10   := false;
     pubsp.b6    := false;
     pubsp.b2    := false;
     pubSP.wb160 := false;
     pubsp.wb80  := false;
     pubsp.wb40  := false;
     pubsp.wb30  := false;
     pubsp.wb20  := false;
     pubsp.wb17  := false;
     pubsp.wb15  := false;
     pubsp.wb12  := false;
     pubsp.wb10  := false;
     pubsp.wb6   := false;
     pubsp.wb2   := false;
     // Clear the checkbox state arrays
     for i := 0 to 10 do
     begin
          cbstate[i]  := false;
          wcbstate[i] := false;
     end;
     // Publish search params so main code can do the search
     pubLUCall := upcase(trimleft(trimright(edSearchCallsign.Text)));
     pubhaveDB := false;
     pubFailDB := false;
     pubdoDB    := true;
     // Wait for result
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
          pubDoDB   := False;
          pubhaveDB := False;
          pubLUCall := '';
          lbSearchResults.Clear;
          s := '';
          for i := 1 to 16 do
          begin
               s := s + pubSP.callsign[i];
          end;
          s := trimleft(trimright(s));
          if pubSP.count = 1 then lbSearchResults.Items.Add(' ' + s + ' Has been heard 1 time.') else lbSearchResults.Items.Add(' ' + s + ' Has been heard ' + IntToStr(pubSP.count) + ' times.');
          lbSearchResults.Items.Add('');
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
               if gc > 1 then s := s + ' Grids:  ' else s := s + ' Grid:  ';
               if gc = 1 then s := s + g1;
               if gc = 2 then s := s + g1 + ' ' + g2;
               if gc = 3 then s := s + g1 + ' ' + g2 + ' ' + g3;
               if gc = 4 then s := s + g1 + ' ' + g2 + ' ' + g3 + ' ' + g4;
          end;
          if gc > 0 then lbSearchResults.Items.Add(s);
          if gc > 0 then lbSearchResults.Items.Add('');
          lbSearchResults.Items.Add(' First:  ' + FormatDateTime('mm-dd-yy',pubSP.first) + ' at ' + formatDateTime('hh:nn',pubSP.first) + ' UTC');
          lbSearchResults.Items.Add('');
          lbSearchResults.Items.Add(' Last:  ' + FormatDateTime('mm-dd-yy',pubSP.last) + ' at ' + formatDateTime('hh:nn',pubSP.last) + ' UTC');
          if pubSP.b160 then cbstate[0]  := true;
          if pubSP.b80  then cbstate[1]  := true;
          if pubSP.b40  then cbstate[2]  := true;
          if pubSP.b30  then cbstate[3]  := true;
          if pubSP.b20  then cbstate[4]  := true;
          if pubSP.b17  then cbstate[5]  := true;
          if pubSP.b15  then cbstate[6]  := true;
          if pubSP.b12  then cbstate[7]  := true;
          if pubSP.b10  then cbstate[8]  := true;
          if pubSP.b6   then cbstate[9]  := true;
          if pubSP.b2   then cbstate[10] := true;
          if pubSP.wb160 then wcbstate[0]  := true;
          if pubSP.wb80  then wcbstate[1]  := true;
          if pubSP.wb40  then wcbstate[2]  := true;
          if pubSP.wb30  then wcbstate[3]  := true;
          if pubSP.wb20  then wcbstate[4]  := true;
          if pubSP.wb17  then wcbstate[5]  := true;
          if pubSP.wb15  then wcbstate[6]  := true;
          if pubSP.wb12  then wcbstate[7]  := true;
          if pubSP.wb10  then wcbstate[8]  := true;
          if pubSP.wb6   then wcbstate[9]  := true;
          if pubSP.wb2   then wcbstate[10] := true;
          // Set indicator(s) for band(s) station has been heard on
          cb160.Checked := cbstate[0];
          cb80.Checked  := cbstate[1];
          cb40.Checked  := cbstate[2];
          cb30.Checked  := cbstate[3];
          cb20.Checked  := cbstate[4];
          cb17.Checked  := cbstate[5];
          cb15.Checked  := cbstate[6];
          cb12.Checked  := cbstate[7];
          cb10.Checked  := cbstate[8];
          cb6.Checked   := cbstate[9];
          cb2.Checked   := cbstate[10];
          // Set indicator(s) for band(s) station has been worked
          wcb160.Checked := wcbstate[0];
          wcb80.Checked  := wcbstate[1];
          wcb40.Checked  := wcbstate[2];
          wcb30.Checked  := wcbstate[3];
          wcb20.Checked  := wcbstate[4];
          wcb17.Checked  := wcbstate[5];
          wcb15.Checked  := wcbstate[6];
          wcb12.Checked  := wcbstate[7];
          wcb10.Checked  := wcbstate[8];
          wcb6.Checked   := wcbstate[9];
          wcb2.Checked   := wcbstate[10];
     end;
     if pubFailDB Then
     begin
          // Failed to find
          lbSearchResults.Clear;
          lbSearchResults.Items.Add(' Callsign not found.');
          // Clear heard band indicators;
          cb160.Checked := cbstate[0];
          cb80.Checked  := cbstate[1];
          cb40.Checked  := cbstate[2];
          cb30.Checked  := cbstate[3];
          cb20.Checked  := cbstate[4];
          cb17.Checked  := cbstate[5];
          cb15.Checked  := cbstate[6];
          cb12.Checked  := cbstate[7];
          cb10.Checked  := cbstate[8];
          cb6.Checked   := cbstate[9];
          cb2.Checked   := cbstate[10];
          // Clear worked band indicators;
          wcb160.Checked := wcbstate[0];
          wcb80.Checked  := wcbstate[1];
          wcb40.Checked  := wcbstate[2];
          wcb30.Checked  := wcbstate[3];
          wcb20.Checked  := wcbstate[4];
          wcb17.Checked  := wcbstate[5];
          wcb15.Checked  := wcbstate[6];
          wcb12.Checked  := wcbstate[7];
          wcb10.Checked  := wcbstate[8];
          wcb6.Checked   := wcbstate[9];
          wcb2.Checked   := wcbstate[10];
          pubDoDB := False;
     end;
     if timeout Then
     begin
          // Timed out
          lbSearchResults.Clear;
          lbSearchResults.Items.Add(' Timed out.  Try again later.');
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

procedure TForm9.Button4Click(Sender: TObject);
begin
     // Export internal DB to CSV file in /basedir/logs
end;

procedure TForm9.cbClick(Sender: TObject);
begin
     // OK... checkboxes are difficult to see (state of) when disabled, so, I
     // will enable them but not allow the state to actually change :)
     cb160.Checked := cbstate[0];
     cb80.Checked  := cbstate[1];
     cb40.Checked  := cbstate[2];
     cb30.Checked  := cbstate[3];
     cb20.Checked  := cbstate[4];
     cb17.Checked  := cbstate[5];
     cb15.Checked  := cbstate[6];
     cb12.Checked  := cbstate[7];
     cb10.Checked  := cbstate[8];
     cb6.Checked   := cbstate[9];
     cb2.Checked   := cbstate[10];
end;

initialization
  {$I heard.lrs}

end.

