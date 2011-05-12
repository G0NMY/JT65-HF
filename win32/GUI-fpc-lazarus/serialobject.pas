unit serialobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, synaser;

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

              function  portValid() : Boolean;

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
       end;
var
   mnpttSerial : TBlockSerial;

implementation

constructor TSerial.Create();
Begin
      prPort        := '';
      prLines       := '';
      prAlternate   := false;
      prPTT         := false;
End;

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
      if prAlternate then
      begin
           // Working with alternate PTT routines (synaser)
      end
      else
      begin
           // Working with WSJT (libWSJT) routines
      end;
end;
//procedure TForm1.altRaisePTT();
//var
//   np : Integer;
//Begin
//     mnpttOpened := False;
//     if not mnpttOpened Then
//     Begin
//          mnnport := '';
//          mnnport := cfgvtwo.Form6.editUserDefinedPort1.Text;
//          if mnnport = 'None' Then mnnport := '';
//          if mnnport = 'NONE' Then mnnport := '';
//          if Length(mnnport) > 3 Then
//          Begin
//               try
//                  mnpttSerial := TBlockSerial.Create;
//                  mnpttSerial.RaiseExcept := True;
//                  mnpttSerial.Connect(mnnport);
//                  mnpttSerial.Config(9600,8,'N',0,false,true);
//                  mnpttOpened := True;
//               except
//                  dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
//               end;
//          End
//          Else
//          Begin
//               np := 0;
//               if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
//               Begin
//                    Try
//                       mnpttSerial := TBlockSerial.Create;
//                       mnpttSerial.RaiseExcept := True;
//                       mnpttSerial.Connect('COM' + IntToStr(np));
//                       mnpttSerial.Config(9600,8,'N',0,false,true);
//                       mnpttOpened := True;
//                    Except
//                       dlog.fileDebug('PTT Port [COM' + IntToStr(np) + '] failed to key up.');
//                    End;
//               End
//               Else
//               Begin
//                    mnpttOpened := False;
//               End;
//          End;
//     End;
//End;

//procedure TForm1.altLowerPTT();
//Begin
//     if mnpttOpened Then
//     Begin
//          mnpttOpened := False;
//          mnpttSerial.Free;
//     End
//     Else
//     Begin
//          mnpttOpened := False;
//     End;
//End;

//procedure TForm1.raisePTT();
//var
//   np, ntx, iptt, ioresult : CTypes.cint;
//   msg                     : CTypes.cschar;
//   tmp                     : String;
//Begin
//     ioresult := 0;
//     msg := 0;
//     np := 0;
//     ntx := 1;
//     iptt := 0;
//     tmp := '';
//     mnpttOpened := False;
//     if not mnpttOpened Then
//     Begin
//          mnnport := '';
//
//          mnnport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);
//
//          if mnnport = 'None' Then mnnport := '';
//          if mnnport = 'NONE' Then mnnport := '';
//
//          if Length(mnnport) > 3 Then
//          Begin
//               if Length(mnnport) = 4 Then
//               Begin
//                    // Length = 4 = COM#
//                    tmp := '';
//                    tmp := mnnport[4];
//               End;
//               if Length(mnnport) = 5 Then
//               Begin
//                    // Length = 5 = COM##
//                    tmp := '';
//                    tmp := mnnport[4..5];
//               End;
//               If Length(mnnport) = 6 Then
//               Begin
//                    // Length = 6 = COM###
//                    tmp := '';
//                    tmp := mnnport[4..6];
//               End;
//               np := StrToInt(tmp);
//               if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
//               if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
//               if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
//          End
//          Else
//          Begin
//               np := 0;
//               if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
//               Begin
//                    if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
//                    if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key up.');
//                    if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
//               End
//               Else
//               Begin
//                    mnpttOpened := False;
//               End;
//          End;
//     End;
//End;

//procedure TForm1.lowerPTT();
//var
//   np, ntx, iptt, ioresult : CTypes.cint;
//   msg                     : CTypes.cschar;
//   tmp                     : String;
//Begin
//     ioresult := 0;
//     msg := 0;
//     np := 0;
//     ntx := 0;
//     iptt := 0;
//     tmp := '';
//     mnpttOpened := False;
//     mnnport := '';
//
//     mnnport := UpperCase(cfgvtwo.Form6.editUserDefinedPort1.Text);
//
//     if mnnport = 'None' Then mnnport := '';
//     if mnnport = 'NONE' Then mnnport := '';
//
//     if Length(mnnport) > 3 Then
//     Begin
//          if Length(mnnport) = 4 Then
//          Begin
//               // Length = 4 = COM#
//               tmp := '';
//               tmp := mnnport[4];
//          End;
//          if Length(mnnport) = 5 Then
//          Begin
//               // Length = 5 = COM##
//               tmp := '';
//               tmp := mnnport[4..5];
//          End;
//          If Length(mnnport) = 6 Then
//          Begin
//               // Length = 6 = COM###
//               tmp := '';
//               tmp := mnnport[4..6];
//          End;
//          np := StrToInt(tmp);
//          if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
//          if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key down.');
//          if ioresult = 0 Then mnpttOpened := True else mnpttOpened := False;
//     End
//     Else
//     Begin
//          np := 0;
//          if tryStrToInt(cfgvtwo.Form6.editUserDefinedPort1.Text,np) Then
//          Begin
//               if np > 0 Then ioresult := ptt(@np, @msg, @ntx, @iptt);
//               if ioresult = 1 Then dlog.fileDebug('PTT Port [' + mnnport + '] failed to key down.');
//               if ioresult = 0 Then mnpttOpened := False;
//          End;
//     End;
//End;

end.

