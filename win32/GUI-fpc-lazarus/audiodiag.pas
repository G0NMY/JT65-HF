unit audiodiag;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs , StdCtrls;

type

  { TForm6 }

  TForm6 = class(TForm)
    Label1 : TLabel ;
    Label2 : TLabel ;
    Label3 : TLabel ;
    Label4 : TLabel ;
    Label5 : TLabel ;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form6 : TForm6;

implementation

initialization
  {$I audiodiag.lrs}

end.

