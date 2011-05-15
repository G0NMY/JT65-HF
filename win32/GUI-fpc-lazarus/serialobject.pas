unit serialobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, synaser, CTypes;

Const
  JT_DLL = 'jt65.dll';

Type
    // Encapsulates all the possible serial port PTT routines/methods/variants
    // to a single unified interface.
    TSerial = Class
       private
              // Control values
              prPort        : String;  // Serial Port value either COM### or just ###
              prLines       : String;  // Lines to control
              prAlternate   : Boolean; // Use alternate ptt code
              prPTT         : Boolean; // PTT State
              // PTT Line control is as follows:
              // If string is DTRRTS then PTT toggles both DTR and RTS lines to follow PTT state.
              // If string is RTS then PTT toggles RTS but DTR is always on
              // If string is DTR then PTT toggles DTR but RTS is always on
              prPortString  : String;  // Port as string as in COM1 or COM31 or COM192
              prPortNumeral : Integer; // Port as integer as in 1 or 31 or 192
              prpttSerial   : TBlockSerial;
              prpttOpened   : Boolean;

              function  portValid() : Boolean;
              function  portList() : String;
              procedure altPTT(stat : Boolean);
              procedure regPTT(stat : Boolean);

       public
             Constructor create();
             procedure togglePTT();

             property port : String
                read  prPort
                write prPort;
             property lines : String
                read  prLines
                write prLines;
             property useAltPTT : Boolean
                read  prAlternate
                write prAlternate;
             property ptt : Boolean
                read  prPTT
                write prPTT;
             property serialList : String
                read  portList;
       end;

       function  jtptt(nport : Pointer; msg : Pointer; ntx : Pointer; iptt : Pointer) : CTypes.cint; cdecl; external JT_DLL name 'ptt_';

implementation

constructor TSerial.Create();
Begin
      prPort        := '';
      prLines       := '';
      prAlternate   := false;
      prPTT         := false;
End;

function TSerial.portList() : String;
Begin
     result := synaser.GetSerialPortNames;
end;

function TSerial.portValid() : Boolean;
var
   i : integer;
Begin
      i := -1;
      if length(prPort)>0 Then
      Begin
           // Port is set to something... lets see if it makes sense
           prPort := upCase(prPort);
           if prPort[1..3] = 'COM' Then
           Begin
                // It starts with COM, now does it have some numbers?
                if length(prPort) = 4 then
                begin
                     // Seems to be COM#
                     // Fourth character should be a integer in range of 1 ... 9
                     If TryStrToInt(prPort[4], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := prPort;
                     End
                     else
                     begin
                          i := -1
                     end;
                end;
                if length(prPort) = 5 then
                begin
                     // Seems to be COM##
                     // Fourth and fifth characters should be a integer in range of 10 ... 99
                     If TryStrToInt(prPort[4..5], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := prPort;
                     End
                     else
                     begin
                          i := -1
                     End;
                end;
                if length(prPort) = 6 then
                begin
                     // Seems to be COM###
                     // Fourth fifth and sixth characters should be a integer in range of 100 to 999 or (really) 255
                     If TryStrToInt(prPort[4..6], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := prPort;
                     End
                     else
                     begin
                          i := -1
                     End;
                end;
                if length(prPort) > 6 then
                begin
                     // Not sure what it is.  :)
                     // Try looking for an 3 digit integer and discard last character(s)
                     prPort := prPort[1..6];
                     If TryStrToInt(prPort[4..6], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := prPort;
                     End
                     else
                     begin
                          i := -1
                     End;
                end;
                if prPortNumeral > 0 then result := True else result := false;
           end
           else
           begin
                if length(prPort) = 1 then
                begin
                     // Seems to be #
                     If TryStrToInt(prPort[1], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := 'COM' + prPort;
                     end
                     else
                     begin
                          i := -1;
                     end;
                end;
                if length(prPort) = 2 then
                begin
                     // Seems to be ##
                     If TryStrToInt(prPort[1..2], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := 'COM' + prPort;
                     end
                     else
                     begin
                          i := -1;
                     end;
                end;
                if length(prPort) = 3 then
                begin
                     // Seems to be ###
                     If TryStrToInt(prPort[1..3], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := 'COM' + prPort;
                     end
                     else
                     begin
                          i := -1;
                     end;
                end;
                if length(prPort) > 4 then
                begin
                     // Not sure what it is. :)
                     prPort := prPort[1..3];
                     If TryStrToInt(prPort[1..3], i) Then
                     Begin
                          prPortNumeral := i;
                          prPortString := 'COM' + prPort;
                     end
                     else
                     begin
                          i := -1;
                     end;
                end;
                if prPortNumeral > 0 then result := True else result := false;
           end;
      end
      else
      begin
           result := False;
      end;
end;

procedure TSerial.togglePTT();
begin
      if portValid then
      begin
           if prAlternate then
           begin
                if prPTT then altPTT(false) else altPTT(true);
           end
           else
           begin
                if prPTT then regPTT(false) else regPTT(true);
           end;
      end;
end;

procedure TSerial.altPTT(stat : Boolean);
begin
     if stat then
     begin
          // Working with alternate PTT routines (synaser)
          // prPort holds a validated string value for com port to open
          if Length(prPortString) > 3 Then
          Begin
               try
                  prpttSerial := TBlockSerial.Create;
                  prpttSerial.RaiseExcept := True;
                  prpttSerial.Connect(prPortString);
                  prpttSerial.Config(9600,8,'N',0,false,true);
                  prpttOpened := True;
               except
                  //dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
               end;
               prPTT := True;
          end;
     end
     else
     begin
          if prpttOpened Then
          Begin
               prpttOpened := False;
               prpttSerial.Free;
          End;
          prPTT := False;
     end;
end;

procedure TSerial.regPTT(stat : Boolean);
var
   ntx, iptt, ioresult : CTypes.cint;
   msg                 : CTypes.cschar;
begin
     if stat then
     begin
          ioresult := 0;
          msg      := 0;
          ntx      := 1;
          iptt     := 0;
          prPTT    := False;
          // prPortNumeral already holds a valid integer (>0 <256)
          if prPortNumeral > 0 Then ioresult := jtptt(@prPortNumeral, @msg, @ntx, @iptt);
          //if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
          if ioresult = 0 Then prPTT := True else prPTT := False;
     end
     else
     begin
          ioresult := 0;
          msg      := 0;
          ntx      := 1;
          iptt     := 0;
          prPTT    := True;
          // prPortNumeral already holds a valid integer (>0 <256)
          if prPortNumeral > 0 Then ioresult := jtptt(@prPortNumeral, @msg, @ntx, @iptt);
          //if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key down.');
          if ioresult = 0 Then prPTT := False;
     end;
end;
end.
