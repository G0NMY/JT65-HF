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
unit log;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, adif, EditBtn, globalData;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnLogQSO: TButton;
    Button1: TButton;
    edLogComment: TEdit;
    edLogSTime: TEdit;
    edLogDate: TEdit;
    edLogETime: TEdit;
    edLogCall: TEdit;
    edLogSReport: TEdit;
    edLogRReport: TEdit;
    edLogPower: TEdit;
    edLogFrequency: TEdit;
    edLogGrid: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure btnLogQSOClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form2: TForm2;
  logmycall, logmygrid, logadifpath : String;
  adifName : String;

implementation

{ TForm2 }

procedure TForm2.btnLogQSOClick(Sender: TObject);
Var
   foo, fname   : String;
   lfile        : TextFile;
begin
     // Need to build the log entry and add it to log file.
     foo := '';
     foo := adif.adifString(edLogCall.Text,edLogFrequency.Text,edLogGrid.Text,adif.JT65A,
                            edLogRReport.Text,edLogSReport.Text,edLogSTime.Text,
                            edLogETime.Text,edLogPower.Text,edLogDate.Text,edLogComment.Text,
                            logmycall, logmygrid);
     fname := adifName;
     AssignFile(lfile, fname);
     If FileExists(fname) Then
     Begin
          append(lfile);
     end
     else
     Begin
          rewrite(lfile);
          writeln(lfile,'JT65-HF ADIF Export');
          //writeln(lfile,'<adif_ver:4>2.26');
          writeln(lfile,'<eoh>');
     end;
     writeln(lfile,foo);
     closeFile(lfile);
     Form2.visible := False;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
     Form2.visible := False;
end;

initialization
  {$I log.lrs}

end.

