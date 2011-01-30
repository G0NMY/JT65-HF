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
     fname := globalData.logdir+'\JT65HF_ADIFLOG.adi';
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

