unit txlog;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm4 }

  TForm4 = class(TForm)
    Memo1: TMemo;
    procedure Memo1DblClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form4: TForm4; 

implementation

{ TForm4 }

procedure TForm4.Memo1DblClick(Sender: TObject);
begin
     Memo1.Clear;
     Memo1.Lines.Add('Transmitted Messages.  Double Click in this window to clear.');
end;

initialization
  {$I txlog.lrs}

end.

