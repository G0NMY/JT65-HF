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
unit diagout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form3: TForm3; 

implementation

initialization
  {$I diagout.lrs}

end.

