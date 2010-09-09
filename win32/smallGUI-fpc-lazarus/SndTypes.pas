//------------------------------------------------------------------------------
//The contents of this file are subject to the Mozilla Public License
//Version 1.1 (the "License"); you may not use this file except in compliance
//with the License. You may obtain a copy of the License at
//http://www.mozilla.org/MPL/ Software distributed under the License is
//distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express
//or implied. See the License for the specific language governing rights and
//limitations under the License.
//
//The Original Code is SndTypes.pas.
//
//The Initial Developer of the Original Code is Alex Shovkoplyas, VE3NEA.
//Portions created by Alex Shovkoplyas are
//Copyright (C) 2008 Alex Shovkoplyas. All Rights Reserved.
//------------------------------------------------------------------------------
unit SndTypes;

{$mode delphi}

interface

uses
  SysUtils;

const
  TWO_PI = 2 * Pi;

type
  TIntegerArray = array of integer;
  TSingleArray = array of Single;
  TDataBufferF = array of TSingleArray;
  TDataBufferI = array of TIntegerArray;
  TSingleArray2D = array of TSingleArray;
  TByteArray = array of Byte;

implementation

end.

