unit valobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;

Const
     JT65delimiter = ['A'..'Z','0'..'9','+','-','.','/','?',' '];

type
  JT65Characters = Set Of Char;

  TValidator = Class
     private
        // Station callsign and grid
        prCall        : String;
        prCWCall      : String;
        prGrid        : String;
        prPrefix      : Integer;
        prSuffix      : Integer;
        prRBCall      : String;
        prRBInfo      : String;
        prCallValid   : Boolean;
        prCWCallValid : Boolean;
        prRBCallValid : Boolean;
        prGridValid   : Boolean;
        prPrefixValid : Boolean;
        prSuffixValid : Boolean;
        prRBInfoValid : Boolean;
        prCallError   : String;
        prGridError   : String;
        prRBCallError : String;
        prRBInfoError : String;
        prSuffixError : String;
        prPrefixError : String;

     public
        Constructor create();
        procedure setCallsign(msg : String);
        procedure setCWCallsign(msg : String);
        procedure setRBCallsign(msg : String);
        procedure setGrid(msg : String);
        //procedure setPrefix(msg : Integer);
        //procedure setSuffix(msg : Integer);
        //procedure setRBInfo(msg : String);
        //procedure validate();
        function asciiValidate(msg : Char; mode : String) : Boolean;
        function testQRG(const qrg : String; var qrgk : single; var qrghz : Integer) : Boolean;

     property callsign      : String
        read  prCall
        write setCallsign;
     property cwCallsign    : String
        read  prCWCall
        write setCWCallsign;
     property rbCallsign    : String
        read  prRBCall
        write setRBCallsign;

     property grid          : String
        read  prGrid
        write setGrid;

     //property prefix        : Integer
     //   write setPrefix;
     //property suffix        : Integer
     //   write setSuffix;
     //property rbInfo        : String
     //   write setRBInfo;

     property callsignValid : Boolean
        read  prCallValid;
     property rbCallSignValid   : Boolean
        read  prRBCallValid;
     property cwCallsignValid : Boolean
        read  prCWCallValid;

     property gridValid     : Boolean
        read  prGridValid;

     property prefixValid   : Boolean
        read  prPrefixValid;
     property suffixValid   : Boolean
        read  prSuffixValid;

     property rbInfoValid   : Boolean
        read  prRBInfoValid;

     property callError     : String
        read  prCallError;

     property gridError     : String
        read  prGridError;

     property rbInfoError   : String
        read  prRBInfoError;

     property suffixError   : String
        read  prSuffixError;

     property prefixError   : String
        read  prPrefixError;
  end;

implementation
   constructor TValidator.Create();
   begin
        prCall          := '';
        prCWCall        := '';
        prGrid          := '';
        prPrefix        := 0;
        prSuffix        := 0;
        prRBCall        := '';
        prRBInfo        := '';
        prCallValid     := False;
        prCWCallValid   := False;
        prGridValid     := False;
        prPrefixValid   := False;
        prSuffixValid   := False;
        prRBCallValid   := False;
        prRBInfoValid   := False;
        prCallError     := '';
        prGridError     := '';
        prRBCallError   := '';
        prRBInfoError   := '';
        prSuffixError   := '';
        prPrefixError   := '';
   end;

   procedure TValidator.setCWCallsign(msg : String);
   var
        testcall : String;
   begin
        testcall := trimleft(trimright(msg));
        testcall := upcase(testcall);
        If (AnsiContainsText(testcall,'.')) Or
           (AnsiContainsText(testcall,'-')) Or (AnsiContainsText(testcall,'\')) Or
           (AnsiContainsText(testcall,',')) Or (AnsiContainsText(testcall,' ')) Or
           (AnsiContainsText(testcall,'Ø')) Or (length(testcall) < 3) Or
           (length(testcall) > 32) Then
        Begin
             // Contains bad character
             if (length(testcall) > 2) and (length(testcall) < 33) then prCallError := 'May not contain the characters . - \ , Ø or space.' else prCallError := 'Too short';
             prCWCallValid := false;
             prCWCall := '';
        end
        else
        begin
             prCallError := '';
             prCWCallValid := true;
             prCWCall := testcall;
        end;
   end;

   procedure TValidator.setRBCallsign(msg : String);
   var
        testcall : String;
   begin
        testcall := trimleft(trimright(msg));
        testcall := upcase(testcall);
        If (AnsiContainsText(testcall,'.')) Or
           (AnsiContainsText(testcall,'-')) Or (AnsiContainsText(testcall,'\')) Or
           (AnsiContainsText(testcall,',')) Or (AnsiContainsText(testcall,' ')) Or
           (AnsiContainsText(testcall,'Ø')) Or (length(testcall) < 3) Or
           (length(testcall) > 32) Then
        Begin
             // Contains bad character
             if (length(testcall) > 2) and (length(testcall) < 33) then prCallError := 'May not contain the characters . - \ , Ø or space.' else prCallError := 'Too short';
             prRBCallValid := false;
             prRBCall := '';
        end
        else
        begin
             prCallError := '';
             prRBCallValid := true;
             prRBCall := testcall;
        end;
   end;

   procedure TValidator.setCallsign(msg : String);
   var
        valid    : Boolean;
        testcall : String;
   begin
        valid := True;
        testcall := trimleft(trimright(msg));
        testcall := upcase(testcall);
        prCall := testcall;
        // Simple length check
        if (length(testcall) < 3) or (length(testcall) > 6) then
        begin
             prCallValid := False;
             if length(testcall) < 3 then prCallError := 'Callsign too short.';
             if length(testcall) > 6 then prCallError := 'Callsign too long.';
             valid := False;
        end
        else
        begin
             prCallError := '';
             valid := True;
        end;
        // Not too short or too long, now test for presence of 'bad' characters.
        if valid then
        begin
             If (AnsiContainsText(testcall,'/')) Or (AnsiContainsText(testcall,'.')) Or
                (AnsiContainsText(testcall,'-')) Or (AnsiContainsText(testcall,'\')) Or
                (AnsiContainsText(testcall,',')) Or (AnsiContainsText(testcall,' ')) Then
             Begin
                  valid := False;
                  // Contains bad character
                  prCallError := 'May not contain the characters / . - \ , Ø or space.';
             end
             else
             begin
                  prCallError := '';
                  valid := True;
             end;
        end;
        // If length and bad character checks pass on to the full validator
        if valid then
        begin
             valid := False;
             // Callsign rules:
             // Length must be >= 3 and <= 6
             // Must be of one of the following;
             // A = Alpha character A ... Z
             // # = Numeral 0 ... 9
             // Allowing SWL for use as well with SWL ID in RB callsign field
             //
             // A#A A#AA A#AAA or AA#A AA#AA AA#AAA or #A#A #A#AA #A#AAA or
             // A##A A##AA A##AAA
             //
             // All characters must be A...Z or 0...9 or space
             if length(testCall) = 3 Then
             Begin
                  // 3 Character callsigns have only one valid format: A#A
                  valid := False;
                  case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                  if valid then
                  begin
                       case testcall[2] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if not valid then
                  begin
                       if testcall = 'SWL' then valid := true else valid := false;
                  end;
                  if not valid then prCallError := 'Must be A#A or SWL' + sLineBreak + 'Where A = Letter A to Z and # = Digit 0 to 9' else prCallError := '';
             End;
             if length(testCall) = 4 Then
             Begin
                  // 4 Character callsigns can be:  A#AA AA#A #A#A A##A
                  // Testing for A#AA
                  valid := False;
                  case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                  if valid then
                  begin
                       case testcall[2] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  // Testing for AA#A (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  // Testing for #A#A (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of '0'..'9': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  // Testing for A##A (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  if not valid then
                  begin
                       // 4 Character callsigns can be:  A#AA AA#A #A#A A##A
                       prCallError := 'Must be A#AA or AA#A or #A#A or A##A' + sLineBreak + 'Where A = Letter A to Z and # = Digit 0 to 9';
                  end
                  else
                  begin
                       prCallError := '';
                  end;
             End;
             if length(testCall) = 5 Then
             Begin
                  // 5 Character callsigns can be:  A#AAA AA#AA #A#AA A##AA
                  // Testing for A#AAA
                  valid := False;
                  case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                  if valid then
                  begin
                       case testcall[2] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[3] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  // Testing for AA#AA (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  // Testing for #A#AA (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of '0'..'9': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  // Testing for A##AA (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  if not valid then
                  begin
                       // 5 Character callsigns can be:  A#AAA AA#AA #A#AA A##AA
                       prCallError := 'Must be A#AAA or AA#AA or #A#AA or A##AA' + sLineBreak + 'Where A = Letter A to Z and # = Digit 0 to 9';
                  end
                  else
                  begin
                       prCallError := '';
                  end;
             End;
             if length(testCall) = 6 Then
             Begin
                  // 6 Character callsigns can be:  AA#AAA #A#AAA A##AAA
                  // Testing for AA#AAA
                  valid := False;
                  case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                  if valid then
                  begin
                       case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[3] of '0'..'9': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  if valid then
                  begin
                       case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
                  end;
                  // Testing for #A#AAA (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of '0'..'9': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  // Testing for A##AAA (if test above didn't return true)
                  if not valid then
                  begin
                       case testcall[1] of 'A'..'Z': valid := True else valid := False; end;
                       if valid then
                       begin
                            case testcall[2] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[3] of '0'..'9': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[4] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[5] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                       if valid then
                       begin
                            case testcall[6] of 'A'..'Z': valid := True else valid := False; end;
                       end;
                  end;
                  if not valid then
                  begin
                       // 6 Character callsigns can be:  AA#AAA #A#AAA A##AAA
                       prCallError := 'Must be AA#AAA or #A#AAA or A##AAA' + sLineBreak + 'Where A = Letter A to Z and # = Digit 0 to 9';
                  end
                  else
                  begin
                       prCallError := '';
                  end;
             End;
             // All possible 3, 4, 5 and 6 character length callsigns have been tested
             // for conformance to JT65 callsign encoding rules.  If valid = true we're
             // good to go.  Of course, you can still specify a callsign that is not
             // 'real', but, which conforms to the encoding rules...  I make no attempt
             // to validate a callsign to be something that is valid/legal.  Only that it
             // conforms to the encoder rules.
        end;
        if valid then
        begin
             prCallValid := true;
             prCallError := '';
        end
        else
        begin
             prCallValid := false;
        end;
   end;

   procedure TValidator.setGrid(msg : String);
   var
        valid    : Boolean;
        testGrid : String;
   begin
        valid := True;
        testGrid := trimleft(trimright(msg));
        testGrid := upcase(testGrid);
        prGrid := testGrid;
        if (length(testGrid) < 4) or (length(testGrid) > 6) or (length(testGrid) = 5) then
        begin
             if length(testGrid) < 4 then prGridError := 'Must be 4 or 6 characters';
             if length(testGrid) > 6 then prGridError := 'Must be 4 or 6 characters';
             if length(testGrid) = 5 then prGridError := 'Must be 4 or 6 characters';
             valid := False;
        end
        else
        begin
             valid := True;
             prGridError := '';
        end;
        if valid then
        begin
             // Validate grid
             // Grid format:
             // Length = 4 or 6
             // characters 1 and 2 range of A ... R, upper case, alpha only.
             // characters 3 and 4 range of 0 ... 9, numeric only.
             // characters 5 and 6 range of a ... x, lower case, alpha only, optional.
             // Validate grid
             if length(testGrid) = 6 then
             begin
                  testGrid[1] := upcase(testGrid[1]);
                  testGrid[2] := upcase(testGrid[2]);
                  testGrid[5] := lowercase(testGrid[5]);
                  testGrid[6] := lowercase(testGrid[6]);
                  prGrid := testGrid;
                  valid := false;
                  case testGrid[1] of 'A'..'R': valid := True else valid := False; end;
                  if valid then case testGrid[2] of 'A'..'R': valid := True else valid := False; end;
                  if valid then case testGrid[3] of '0'..'9': valid := True else valid := False; end;
                  if valid then case testGrid[4] of '0'..'9': valid := True else valid := False; end;
                  if valid then case testGrid[5] of 'a'..'x': valid := True else valid := False; end;
                  if valid then case testGrid[6] of 'a'..'x': valid := True else valid := False; end;
             end
             else
             begin
                  testGrid[1] := upcase(testGrid[1]);
                  testGrid[2] := upcase(testGrid[2]);
                  prGrid := testGrid;
                  valid := false;
                  case testGrid[1] of 'A'..'R': valid := True else valid := False; end;
                  if valid then case testGrid[2] of 'A'..'R': valid := True else valid := False; end;
                  if valid then case testGrid[3] of '0'..'9': valid := True else valid := False; end;
                  if valid then case testGrid[4] of '0'..'9': valid := True else valid := False; end;
             end;
             if not valid then
             begin
                  prGridError := 'Grid must be in format of RR## or RR##xx' + sLineBreak + 'Where R is letter A to R, # is digit 0 to 9 and ' + sLineBreak + 'x is letter a to x';
             end
             else
             begin
                  prGridError := '';
             end;
        End;
        if valid then
        begin
             prGridValid := True;
        end
        else
        begin
             prGridValid := False;
        end;
   end;

   function TValidator.asciiValidate(msg : Char; mode : String) : Boolean;
   Var
        tstArray1 : Array[0..41] Of String;
        tstArray2 : Array[0..35] Of String;
        tstArray3 : Array[0..36] Of String;
        tstArray4 : Array[0..11] Of String;
   begin
        tstArray1[0] := 'A';
        tstArray1[1] := 'B';
        tstArray1[2] := 'C';
        tstArray1[3] := 'D';
        tstArray1[4] := 'E';
        tstArray1[5] := 'F';
        tstArray1[6] := 'G';
        tstArray1[7] := 'H';
        tstArray1[8] := 'I';
        tstArray1[9] := 'J';
        tstArray1[10] := 'K';
        tstArray1[11] := 'L';
        tstArray1[12] := 'M';
        tstArray1[13] := 'N';
        tstArray1[14] := 'O';
        tstArray1[15] := 'P';
        tstArray1[16] := 'Q';
        tstArray1[17] := 'R';
        tstArray1[18] := 'S';
        tstArray1[19] := 'T';
        tstArray1[20] := 'U';
        tstArray1[21] := 'V';
        tstArray1[22] := 'W';
        tstArray1[23] := 'X';
        tstArray1[24] := 'Y';
        tstArray1[25] := 'Z';
        tstArray1[26] := '0';
        tstArray1[27] := '1';
        tstArray1[28] := '2';
        tstArray1[29] := '3';
        tstArray1[30] := '4';
        tstArray1[31] := '5';
        tstArray1[32] := '6';
        tstArray1[33] := '7';
        tstArray1[34] := '8';
        tstArray1[35] := '9';
        tstArray1[36] := '+';
        tstArray1[37] := '-';
        tstArray1[38] := '.';
        tstArray1[39] := '/';
        tstArray1[40] := '?';
        tstArray1[41] := ' ';

        tstArray2[0] := 'A';
        tstArray2[1] := 'B';
        tstArray2[2] := 'C';
        tstArray2[3] := 'D';
        tstArray2[4] := 'E';
        tstArray2[5] := 'F';
        tstArray2[6] := 'G';
        tstArray2[7] := 'H';
        tstArray2[8] := 'I';
        tstArray2[9] := 'J';
        tstArray2[10] := 'K';
        tstArray2[11] := 'L';
        tstArray2[12] := 'M';
        tstArray2[13] := 'N';
        tstArray2[14] := 'O';
        tstArray2[15] := 'P';
        tstArray2[16] := 'Q';
        tstArray2[17] := 'R';
        tstArray2[18] := 'S';
        tstArray2[19] := 'T';
        tstArray2[20] := 'U';
        tstArray2[21] := 'V';
        tstArray2[22] := 'W';
        tstArray2[23] := 'X';
        tstArray2[24] := 'Y';
        tstArray2[25] := 'Z';
        tstArray2[26] := '0';
        tstArray2[27] := '1';
        tstArray2[28] := '2';
        tstArray2[29] := '3';
        tstArray2[30] := '4';
        tstArray2[31] := '5';
        tstArray2[32] := '6';
        tstArray2[33] := '7';
        tstArray2[34] := '8';
        tstArray2[35] := '9';

        tstArray3[0] := 'A';
        tstArray3[1] := 'B';
        tstArray3[2] := 'C';
        tstArray3[3] := 'D';
        tstArray3[4] := 'E';
        tstArray3[5] := 'F';
        tstArray3[6] := 'G';
        tstArray3[7] := 'H';
        tstArray3[8] := 'I';
        tstArray3[9] := 'J';
        tstArray3[10] := 'K';
        tstArray3[11] := 'L';
        tstArray3[12] := 'M';
        tstArray3[13] := 'N';
        tstArray3[14] := 'O';
        tstArray3[15] := 'P';
        tstArray3[16] := 'Q';
        tstArray3[17] := 'R';
        tstArray3[18] := 'S';
        tstArray3[19] := 'T';
        tstArray3[20] := 'U';
        tstArray3[21] := 'V';
        tstArray3[22] := 'W';
        tstArray3[23] := 'X';
        tstArray3[24] := 'Y';
        tstArray3[25] := 'Z';
        tstArray3[26] := '0';
        tstArray3[27] := '1';
        tstArray3[28] := '2';
        tstArray3[29] := '3';
        tstArray3[30] := '4';
        tstArray3[31] := '5';
        tstArray3[32] := '6';
        tstArray3[33] := '7';
        tstArray3[34] := '8';
        tstArray3[35] := '9';
        tstArray3[36] := '/';

        tstArray4[0]  := '0';
        tstArray4[1]  := '1';
        tstArray4[2]  := '2';
        tstArray4[3]  := '3';
        tstArray4[4]  := '4';
        tstArray4[5]  := '5';
        tstArray4[6]  := '6';
        tstArray4[7]  := '7';
        tstArray4[8]  := '8';
        tstArray4[9]  := '9';
        tstArray4[10] := '.';
        tstArray4[11] := ',';

        if mode = 'csign' then
        begin
             If ansiIndexStr(msg,tstArray2)>-1 then result := true else result := false;
        end;
        if mode = 'gsign' then
        begin
             If ansiIndexStr(upcase(msg),tstArray2)>-1 then result := true else result := false;
        end;
        if mode = 'xcsign' then
        begin
             If ansiIndexStr(msg,tstArray3)>-1 then result := true else result := false;
        end;
        if mode = 'free' then
        begin
             If ansiIndexStr(msg,tstArray1)>-1 then result := true else result := false;
        end;
        if mode = 'numeric' then
        begin
             If ansiIndexStr(msg,tstArray4)>-1 then result := true else result := false;
        end;
   end;

   function TValidator.testQRG(const qrg : String; var qrgk : Single; var qrghz : Integer) : Boolean;
   var
        tstint   : Integer;
        tstflt   : Double;
   begin
        // Takes QRG value as string in qrg if convertable returns qrg in KHz as float in qrgk
        // qrg in Hz as integer in qrghz and true/fale if conversion works.
        // Trying this one last time to streamline it.  According to the RTL docs tryStrToFloat
        // takes into consideration the locale specific decimal seperator.
        // "Description:  TryStrToFloat tries to convert the string S to a floating point value, and stores
        //                the result in Value. It returns True if the operation was succesful, and False if
        //                it failed. This operation takes into account the system settings for floating point
        //                representations."
        tstint := 0;
        tstflt := 0.0;
        if not tryStrToFloat(qrg,tstflt) then tstflt := 0.0;
        if tstflt > 0 then
        begin
             // I now have a float > 0 so lets see if it can be evaluated as being in Hz, KHz or MHz
             // QRG Range of interest for MHz is 1.8 ... 450 (I'll say 500 MHz)
             // QRG Range of interest for KHz is 1800 ... 500000
             // QRG Range of interest for Hz is 1800000 ... 500000000
             if tstflt < 1800.0 then
             begin
                  // Probably MHz
                  tstint := round(tstflt * 1000000);
             end;
             if (tstflt > 500) and (tstflt < 1800000) then
             begin
                  // Probably KHz
                  tstint := round(tstflt * 1000);
             end;
             if tstflt > 500000 then
             begin
                  // Probably Hz
                  tstint := round(tstflt);
             end;
             if tstint > 0 then
             begin
                  // I think I have something in Hz now
                  if (tstint > 1799999) and (tstint < 500000001) then
                  begin
                       qrgk   := tstint/1000;
                       qrghz  := tstint;
                       result := true;
                  end
                  else
                  begin
                       qrgk   := 0.0;
                       qrghz  := 0;
                       result := false;
                  end;
             end;
        end;
   end;

end.
