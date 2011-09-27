unit log;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics,
  Dialogs, StdCtrls, adif, EditBtn;

type

  { TForm2 }

  TForm2 = class(TForm)
    btnLogQSO: TButton;
    Button1: TButton;
    DirectoryEdit1: TDirectoryEdit;
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
    Label29: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure btnLogQSOClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form2: TForm2;
  logmycall, logmygrid : String;

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
     // TODO Add ifdefs for linux so fname will be correct.
     fname := Form2.DirectoryEdit1.Directory + '\jt65hf_log.adi';
     AssignFile(lfile, fname);
     If FileExists(fname) Then append(lfile) else rewrite(lfile);
     writeln(lfile,foo);
     closeFile(lfile);
     Form2.visible := False;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
     Form2.visible := False;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
     Form2.DirectoryEdit1.Directory := GetAppConfigDir(False);
end;

initialization
  {$I log.lrs}

end.

