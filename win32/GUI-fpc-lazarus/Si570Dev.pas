//------------------------------------------------------------------------------
//The contents of this file are subject to the Mozilla Public License
//Version 1.1 (the "License"); you may not use this file except in compliance
//with the License. You may obtain a copy of the License at
//http://www.mozilla.org/MPL/ Software distributed under the License is
//distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express
//or implied. See the License for the specific language governing rights and
//limitations under the License.
//
//The Original Code is Si570Dev.pas.
//
//The Initial Developer of the Original Code is Alex Shovkoplyas, VE3NEA.
//Portions created by Alex Shovkoplyas are
//Copyright (C) 2008 Alex Shovkoplyas. All Rights Reserved.
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// TSi570Device: Si570-USB hardware control
//------------------------------------------------------------------------------
// requires LibUsb.pas
//------------------------------------------------------------------------------

unit Si570Dev;

{$mode delphi}

interface

uses
  Windows, SysUtils, SndTypes, LibUsb, UsbDev;

const
  REQUEST_TYPE_IN = USB_TYPE_VENDOR or USB_ENDPOINT_IN;
  REQUEST_TYPE_OUT = USB_TYPE_VENDOR or USB_ENDPOINT_OUT;

  REQEST_SET_FREQ = $32;
  REQUEST_SET_PTT = $50;
  REQUEST_GET_CWKEY = $51;

  DEFAULT_CALIBRATION_FACTOR = 1E-6 * (1 shl 21);


type
  TPaddleState = (psNoneClosed, psDotClosed, psDashClosed, psBothClosed);


  TSi570Device = class (TUsbDevice)
  protected
    procedure DoData(AData: TByteArray; var ADone: boolean); override;
  public
    I2cAddr: integer;
    CalibrationFactor: Double;

    constructor Create;
    procedure Open;
    procedure Close;
    procedure SetPTT(Value: boolean);
    procedure SetFrequency(Value: integer);
    function ReadPaddleState: TPaddleState;
    procedure Calibrate(NominalFreq, TrueFreq: integer);
  end;


implementation

{ TSi570Device }

constructor TSi570Device.Create;
begin
  inherited;
  FVendorId := $16C0;
  FProductId := $05DC;
  I2cAddr := $55;
  CalibrationFactor := DEFAULT_CALIBRATION_FACTOR;
end;


procedure TSi570Device.DoData(AData: TByteArray; var ADone: boolean);
begin
  // not used
end;


procedure TSi570Device.Open;
begin
  OpenDevice;
end;


procedure TSi570Device.Close;
begin
  CloseDevice;
end;


procedure TSi570Device.SetFrequency(Value: integer);
var
  Buf: DWord;
  rc: integer;
begin
  Buf := Round(Value * CalibrationFactor);

  if not IsRunning then OpenDevice;
  rc := FunUsbControlMsg(FHandle, REQUEST_TYPE_OUT, REQEST_SET_FREQ, $700+I2cAddr, 0, Buf, SizeOf(Buf), 500);
  if rc <> SizeOf(Buf) then Err(Format('SetFrequency(%d Hz) failed: usb_control_msg error %d', [Value, rc]));
end;


procedure TSi570Device.Calibrate(NominalFreq, TrueFreq: integer);
begin
  CalibrationFactor := CalibrationFactor * NominalFreq / TrueFreq;
  SetFrequency(NominalFreq);
end;


procedure TSi570Device.SetPTT(Value: boolean);
var
  rc: integer;
begin
  if not IsRunning then OpenDevice;

  rc := FunUsbControlMsg(FHandle, REQUEST_TYPE_IN, REQUEST_SET_PTT, Ord(Value), 0, Value, 1, 500);
  if rc <> 1 then Err(Format('SetPTT failed: usb_control_msg error %d', [rc]));
end;


function TSi570Device.ReadPaddleState: TPaddleState;
const
  DOT_BIT = $20;
  DASH_BIT = $01;
  PADDLE_BITS = DOT_BIT or DASH_BIT;
var
  rc: integer;
  b: Byte;
begin
  b := 0;
  if not IsRunning then OpenDevice;
  rc := FunUsbControlMsg(FHandle, REQUEST_TYPE_IN, REQUEST_GET_CWKEY, 0, 0, b, 1, 500);
  if rc <> 1 then Err(Format('ReadPaddleState failed: usb_control_msg error %d', [rc]));

  case (not b) and PADDLE_BITS of
    DOT_BIT:     Result := psDotClosed;
    DASH_BIT:    Result := psDashClosed;
    PADDLE_BITS: Result := psBothClosed;
    else         Result := psNoneClosed;
  end;
end;



end.
