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
        function asciiValidate(msg : Char; mode : String) : Boolean;
        function testQRG(const qrg : String; var qrgk : single; var qrghz : Integer) : Boolean;
        function evalQRG(const qrg : String; const mode : string; var qrgk : Double; var qrghz : Integer; var asciiqrg : String) : Boolean;

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

   function TValidator.evalQRG(const qrg : String; const mode : string; var qrgk : Double; var qrghz : Integer; var asciiqrg : String) : Boolean;
   var
        i        : Integer;
        i1,i2,i3 : Integer;
        found    : Boolean;
        resolved : Boolean;
        foo, s1  : String;
        s2       : String;
   begin
        // Returns an integer value in Hz for an input string that may be
        // in MHz, KHz or Hz.  Mode parameter can be lax or strict.  Float QRG
        // in KHz returns in qrgk and Integer QRG in Hz returns in qrghz if
        // valid, otherwise both will be set to 0.  If mode = strict then QRG
        // must resolve to a valid amateur band in range of 160M to 33cm
        // excluding 60M.  If lax then anything that can be converted from a
        // string to integer will do.  If mode = draconian the QRG must be within
        // +/- 5 KHz of any one of the JT65 'designated' frequencies.  This is
        // only used for the RB system as a way to cut down on mislabled spots.

        // OK, this is a nightmare.  Conversion of the string to floating point
        // representation then to integer for Hz value leads to a plethora of FP
        // rounding/imprecision errors.  Feed the routine the string 28076.04 and
        // you get the FP value 28076.0391 which is not good enough.  So.  Since
        // I know the format expected if it's KHz or MHz I must, for better or
        // worse, do a string to FP conversion of my own making.  This will be
        // less than fun.

        // Look for the following characters , . and attempt to determine if
        // I have a single , representing a decimal seperator as in some Euro
        // conventions or a , and a . indicating a thousands demarcation and a
        // decimal demarcation.
        result := false;
        // The following works, temporary comment out
        resolved := false;
        foo := '';
        // Testing for something like 28,076.1 or 14,076.05 or 1,838.155
        if (ansiContainsText(qrg,',')) and (ansiContainsText(qrg,'.')) Then
        begin
             // This seems to be something like ##,###.##
             // Strip the , and leave the .
             s1 := '';
             for i := 1 to length(qrg) do
             begin
                  if not (qrg[i]=',') then
                  begin
                       s1 := s1+qrg[i];
                  end;
                  foo := s1;
             end;
             // Pesky thousands mark removed
             // Now to attempt a conversion to a pair of integers
             // with one representing the left of . portion (whole) and the
             // second representing the right of . portion (fraction)
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(foo) do
             begin
                  if foo[i] = '.' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+foo[i];
                       end
                       else
                       begin
                            s2 := s2+foo[i];
                       end;
                  end;
             end;
             If not TrystrToInt(s1,i1) then i1 := 0;
             i1 := i1 * 1000;
             If not TrystrToInt(s2,i2) then i2 := 0;
             if length(s2) = 2 then i2 := i2*10;
             if length(s2) = 1 then i2 := i2*100;
             i3 := i1+i2;
             resolved := true;
        end;
        // Testing for something like  28076,1 or 14076,05 or 1838,155 or 28,076 or 14,076 or 1,838
        // This is more complex as I could have a case with , demarking thousands or decimal point. <sigh>
        if not resolved and (ansiContainsText(qrg,',')) and  not (ansiContainsText(qrg,'.')) Then
        begin
             // Lets try to figure out what we have.  First look for , as a decimal mark rather than a thousands mark
             // This works for something like 28076,010 or 1838,1 or 7076,05
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = ',' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             if not trystrToInt(s1,i1) then i1 := 0;
             i1 := i1 * 1000;
             if not trystrToInt(s2,i2) then i2 := 0;
             if length(s2) = 1 then i2 := i2*1;
             if length(s2) = 2 then i2 := i2*10;
             if length(s2) = 1 then i2 := i2*100;
             i3 := i1+i2;
             resolved := true;
        end;
        // Testing for something like  28076,1 or 14076,05 or 1838,155 or 28,076 or 14,076 or 1,838
        // This is more complex as I could have a case with , demarking thousands or decimal point. <sigh>
        if not resolved and (ansiContainsText(qrg,',')) and  not (ansiContainsText(qrg,'.')) Then
        begin
             // Lets try to figure out what we have.  First look for , as a decimal mark rather than a thousands mark
             // This works for something like 1,838 or 28,076 or 14,075 BUT It yields KHz :)
             // Now.. if you pass it something like 14,075151 as in 14 Million 75 thousand 151 Hertz it breaks
             // returning 14000 + 89151 Hz so I need to look a little harder.
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = ',' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             if not trystrToInt(s1,i1) then i1 := 0;
             if not trystrToInt(s2,i2) then i2 := 0;
             // OK... if this is a value such as 14,076 that would be either 14.076 MHz or 14,076 KHz which is the same thing :)
             // If this is a value such as 14,07615 I'd have 14.07615 MHz or 14,07615 KHz which is most certainly not the same thing.
             // It looks like I could test length of S2 and if = 3 then it would seem to be a KHz value.  If > 3 then it's probably
             // a MHz value using , as decimal point.
             resolved := false;
             if length(s2) = 3 then
             begin
                  // Looks like it'll be KHz as in 14,076 or 28,077 or 1,835
                  // s2(i2) will be thousands and s1(i1) millions
                  i1 := i1*1000000;
                  i2 := i2*1000;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=4) then
             begin
                  //14,0761 would likely be 14,076,100 Hz
                  //s1(i1) will be millions as in 14M
                  //s2(will be hundreds) as in 76100 in the example 14,0761
                  i1 := i1*1000000;
                  i2 := i2*100;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=5) then
             begin
                  //14,07615 would likely be 14,076,150 Hz
                  //s1(i1) will be millions as in 14M
                  //s2(i2) will be 10 as in 76150
                  i1 := i1*1000000;
                  i2 := i2*10;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if not resolved and (length(s2)=6) then
             begin
                  //14,076155 would likely be 14,076,155 Hz
                  //s1(i1) will be millions
                  //s2(i2) will be ones as in 76155
                  i1:=i1*1000000;
                  i3:=i1+i2;
                  resolved := true;
             end;
             if not resolved then result := false;
        end;
        // OK, I've handled the cases of strings like 14,076.150 or 14,076 (like
        // KHz with , as thousands mark) or 14,076515 (like MHz with , as thousands
        // mark)  Now I need to deal with a nice simple 14.076515 or 14076.515
        if not resolved and (ansiContainsText(qrg,'.')) and not (ansiContainsText(qrg,',')) then
        begin
             // Now only dealing with a string having ####.#### with . as decimal point
             s1 := '';
             s2 := '';
             found := false;
             for i := 1 to length(qrg) do
             begin
                  if qrg[i] = '.' then
                  begin
                       found := true;
                  end
                  else
                  begin
                       if not found then
                       begin
                            s1 := s1+qrg[i];
                       end
                       else
                       begin
                            s2 := s2+qrg[i];
                       end;
                  end;
             end;
             // It will most likely be a KHz value if length(s1) >= 4 with s2 being 3 or less
             if length(s1) > 3 then
             begin
                  //s1(i1) will be thousands as in 1838 for 1838000 or 7076 for 7076000
                  //s2(i2) will be 1s 10s or 100s depending upon length length=3 = 1s length = 2 = 10s length = 1 = 100s
                  if not trystrToInt(s1,i1) then i1 := 0;
                  if not trystrToInt(s2,i2) then i2 := 0;
                  i1 := i1*1000;
                  if length(s2)=3 then i2 := i2*1; // Redundant, but necessary for the logic
                  if length(s2)=2 then i2 := i2*10;
                  if length(s2)=1 then i2 := i2*100;
                  i3 := i1+i2;
                  resolved := true;
             end;
             if length(s1) < 4 then
             begin
                  //This will likely be MHz in s1 and fractional MHz in s2
                  // 1.838    Would be 1 million 838 thousand
                  // 1.8381   Would be 1 million 838 thousand 100
                  // 1.83812  Would be 1 million 838 thousand 120
                  // 1.838123 Would be 1 million 838 thousand 123
                  if not trystrToInt(s1,i1) then i1 := 0;
                  if not trystrToInt(s2,i2) then i2 := 0;
                  i1 := i1*1000000;
                  if length(s2)=6 then i2 := i2*1;
                  if length(s2)=5 then i2 := i2*10;
                  if length(s2)=4 then i2 := i2*100;
                  if length(s2)=3 then i2 := i2*1000;
                  if length(s2)=2 then i2 := i2*10000;
                  if length(s2)=1 then i2 := i2*100000;
                  i3 := i2+i1;
                  resolved := true;
             end;
        end;
        // OK, now I've handled everything I can think of except the case of an
        // integer value being passed.  I would hope that if I do get a value
        // that seems to be an integer it will be Hz, but it could be KHz or Mhz
        // and I'll try to resolve that before finishing this.
        if not resolved and not (ansiContainsText(qrg,',')) and not (ansiContainsText(qrg,'.')) Then
        Begin
             // Seems to have an integer so we'll make it simple
             if not trystrToInt(qrg,i3) then i3 := 0;
             resolved := true;
        end;
        // Now... if resolved = true then i3 will hold an integer value.  Lets
        // see if it seems to make sense.
        if resolved then
        begin
             resolved := false;
             // OK... this is either a hertz value or a value in KHz or MHz.
             // If it's KHz then it needs to be 1838 to 460000.  If it's MHz
             // then I need to see 1 to 460.  Realistically I don't expect
             // to ever see MHz here, but, who knows....
             if not resolved and (i3 < 1838) then
             begin
                  // MHz
                  i3 := i3*1000000;
                  resolved := true;
             end;
             if not resolved and (i3 > 1837) and (i3 < 460000) then
             begin
                  // KHz
                  i3 := i3*1000;
                  resolved := true;
             end;
             if not resolved and (i3 > 1799999) then
             begin
                  // Hz
                  i3 := i3*1;  // Silly, but helps me keep my logic straight.
                  resolved := true;
             end;

             if (mode='lax') and resolved then
             begin
                  //result := i3;
                  result := true;
             end;

             if (mode='strict') and resolved then
             begin
                  // In strict mode QRG must be in the following ranges
                  resolved := false;
                  if (i3 >    1799999) and (i3 <    2000001) then resolved := true;  // 160M
                  if (i3 >    3499999) and (i3 <    4000001) then resolved := true;  //  80M
                  if (i3 >    6999999) and (i3 <    7300001) then resolved := true;  //  40M
                  if (i3 >   10099999) and (i3 <   10150001) then resolved := true;  //  30M
                  if (i3 >   13999999) and (i3 <   14350001) then resolved := true;  //  20M
                  if (i3 >   18067999) and (i3 <   18168001) then resolved := true;  //  17M
                  if (i3 >   20999999) and (i3 <   21450001) then resolved := true;  //  15M
                  if (i3 >   24889999) and (i3 <   24990001) then resolved := true;  //  12M
                  if (i3 >   27999999) and (i3 <   29700001) then resolved := true;  //  10M
                  if (i3 >   49999999) and (i3 <   54000001) then resolved := true;  //   6M
                  if (i3 >  143999999) and (i3 <  148000001) then resolved := true;  //   2M
                  if (i3 >  221999999) and (i3 <  225000001) then resolved := true;  //   1.25M
                  if (i3 >  419999999) and (i3 <  450000001) then resolved := true;  //   70cm
                  if (i3 >  901999999) and (i3 <  928000001) then resolved := true;  //   33cm
                  if (i3 > 1269999999) and (i3 < 1300000001) then resolved := true;  //   23cm
                  //if resolved then result := i3;
                  if resolved then result := true;
             end;

             if not resolved then result := false;
        end
        else
        begin
             result := false;
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
