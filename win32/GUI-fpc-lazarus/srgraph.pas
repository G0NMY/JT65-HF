unit srgraph;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs, Menus, StdCtrls, TAGraph, TASeries, TATypes,
  TATools, TATransformations;

type

  { TForm8 }

  TForm8 = class(TForm )
    Label1 : TLabel;
    MenuItem1 : TMenuItem;
    PopupMenu1 : TPopupMenu;
    srChart  : TChart;
    srChart1 : TChart;
    series1 : TLineSeries;
    series2 : TLineSeries;
    series3 : TLineSeries;
    series4 : TLineSeries;
    procedure FormCreate(Sender : TObject);
    procedure MenuItem1Click(Sender : TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form8 : TForm8;

implementation

{ TForm8 }

procedure TForm8.FormCreate(Sender : TObject);
begin
  series1 := TLineSeries.Create(srChart);
  series1.ShowLines := true;
  series1.ShowPoints := false;
  series1.Pointer.Style := psCross;
  series1.Pointer.Brush.Color := clLime;
  series1.SeriesColor := clLime;
  series1.Title := 'Short Avg';
  srchart.AddSeries(series1);

  series2 := TLineSeries.Create(srChart);
  series2.ShowLines := true;
  series2.ShowPoints := false;
  series2.Pointer.Style := psDiagCross;
  series2.Pointer.Brush.Color := clBlue;
  series2.SeriesColor := clBlue;
  series2.Title := 'Long Avg';
  srchart.AddSeries(series2);

  series3 := TLineSeries.Create(srChart);
  series3.ShowLines := true;
  series3.ShowPoints := false;
  series3.Pointer.Style := psDiagCross;
  series3.Pointer.Brush.Color := clRed;
  series3.SeriesColor := clRed;
  series3.Title := 'Short Avg';
  srchart1.AddSeries(series3);

  series4 := TLineSeries.Create(srChart);
  series4.ShowLines := true;
  series4.ShowPoints := false;
  series4.Pointer.Style := psDiagCross;
  series4.Pointer.Brush.Color := clBlack;
  series4.SeriesColor := clBlack;
  series4.Title := 'Long Avg';
  srchart1.AddSeries(series4);
end;

procedure TForm8.MenuItem1Click(Sender : TObject);
begin
     srchart1.SaveToBitmapFile('txsr.bmp');
     srchart.SaveToBitmapFile('rxsr.bmp');
end;

initialization
  {$I srgraph.lrs}
end.

