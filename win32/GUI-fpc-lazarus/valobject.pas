unit valobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils;
type
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
        function asciiValidate(msg : String) : Boolean;

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

   function TValidator.asciiValidate(msg : String) : Boolean;
   begin
        If (AnsiContainsText(msg,'/')) Or (AnsiContainsText(msg,'.')) Or
           (AnsiContainsText(msg,'-')) Or (AnsiContainsText(msg,'\')) Or
           (AnsiContainsText(msg,',')) Or (AnsiContainsText(msg,' ')) Or
           (AnsiContainsText(msg,'Ø')) Then
        Begin
             result := False;
             // Contains bad character
             prCallError := 'May not contain the characters / . - \ , Ø or space.';
        end
        else
        begin
             prCallError := '';
             result := True;
        end;
   end;

//   function TConfiguration.validate() : Boolean;
   //Var
   //     valid : Boolean;
   //Begin
   //     valid := True;
   //     if length(stCallsign) > 0 then valid := True else valid := False;
   //     if length(spCallsign) > 0 then valid := True else valid := False;
   //     if length(stGrid) > 0 then valid := True else valid := False;
   //     result := valid;
   //end;

end.
