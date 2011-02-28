unit parseCallSign;
//
// Copyright (c) 2008,2009 J C Large - W6CQZ
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
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StrUtils, dlog;

Const
    WordDelimiter = [' '];
    CsvDelim = [','];

    function valQRG( qrg : Integer ) : Boolean;
    function validateCallsign(callsign : String) : Boolean;
    function isGrid( gridloc : String ): Boolean;

implementation
function isSlashedCall(callsign : String) : Boolean;
Begin
     Result := False;
     If PosEx('/', callsign, 1) > 0 Then Result := True Else Result := False;
End;

function isPrefixedCall(callsign : String) : Boolean;
Var
   i : Integer;
Begin
     Result := False;
     i := PosEx('/', callsign, 1);
     If i > 0 Then
     Begin
          // This is an imperfect test as it is possible (but so rarely!) for the prefix to be 4
          // characters+/ for 5 but, being so rare that it could happen it's not worth the bother
          // to handle.
          If I > 4 Then Result := False Else Result := True;
     End
     Else
     Begin
          Result := False;
     End;
End;

function isSuffixedCall(callsign : String) : Boolean;
Var
   i : Integer;
Begin
     Result := False;
     i := PosEx('/', callsign, 1);
     If i > 0 Then
     Begin
          // This is an imperfect test as it is possible (but so rarely!) for the prefix to be 4
          // characters+/ for 5 but, being so rare that it could happen it's not worth the bother
          // to handle.
          If I > 4 Then Result := True Else Result := False;
     End
     Else
     Begin
          Result := False;
     End;
End;

function isSingleLetterOK(callsign : String) : Boolean;
Begin
     // Calls that can have a single letter followed by a digit begin ONLY with the following letters;
     // B, F, G, I, K, M, N, R, U, W
     // Now.. I'm not so sure about U and B, but the references I have found indicate both to be valid
     // in this context...
     Result := False;
     case  callsign[1]  of
           'B' : Result := True;
           'F' : Result := True;
           'G' : Result := True;
           'I' : Result := True;
           'K' : Result := True;
           'M' : Result := True;
           'N' : Result := True;
           'R' : Result := True;
           'U' : Result := True;
           'W' : Result := True;
     end;
End;

function isSingleLetterCall(callsign : String) : Boolean;
Var
   step1 : Boolean;
Begin
     step1 := False;
     Result := False;
     case callsign[1] of
          'A'..'Z' : step1 := True;
     End;
     If step1 Then
     Begin
          case callsign[2] of
               '0'..'9' : Result := True;
          End;
     End
     Else
     Begin
          Result := False;
     End;
End;

function getPrefixLength(callsign : String) : Integer;
Var
   i : Integer;
   isSingleOK, isValid, bool1, bool2, bool3, bool4 : Boolean;
Begin
     Result := 0;
     i := 0;
     isSingleOK := False;
     isValid := False;
     // Ok... getting complicated now.  To compute the prefix length I need to determine
     // if it is a call that is in the single letter ok group, and if so, is it indeed such
     // a call.  If not then it must be a 2 or 3 character prefix, if so it could be either
     // single or multi character.
     If isSingleLetterOK(callsign) Then
     Begin
          // First letter of passed callsign qualifies to be in the single letter group.
          If TryStrToInt(callsign[2], i) Then
          Begin
               // Since the first character was a single character call type and the second
               // character is a valid integer of 0..9 we are safe to say this is a 2 character
               // prefix.
               Result := 2;
               isSingleOK := True;
               isValid := True;
          End;
          // I think I have a valid 2 character prefixed call.
     End;
     If not isSingleOK Then
     Begin
          // Call did not validate as a single letter ok + valid # call.  Now to the > 2 character prefixes.
          If TryStrToInt(callsign[1], i) Then
          Begin
               // Callsign begins with a number so I will be looking in the list of prefixes with numeral
               // as first character.  Numeral must be 1..9, no such thing as a call starting with 0
               // or > 9
               If (i > 0) And (i < 10) Then
               Begin
                    // passed the first check.
                    If i=1 Then
                    Begin
                         // for 1 the next letter must be A or S
                         If (callsign[2] = 'A') Or (callsign[2] = 'S') Then
                         Begin
                              // We have a 1A or 1S call.. next character should be a numeral.
                              case callsign[3] of
                                   '0'..'9' : isValid := True;
                              End;
                              If isValid Then Result := 3 Else Result := 0;
                         End
                         Else
                         Begin
                              isValid := False;
                              Result := 0;
                         End;
                    End;
                    If i>1 Then
                    Begin
                         // for 2,3,4,5,6,7,8 and 9 the next letter is A..Z
                         case callsign[2] of
                              'A'..'Z' : isValid := True;
                         End;
                         if isValid Then
                         Begin
                              isValid := False;
                              // since the letter was ok we now need a #
                              case callsign[3] of
                                   '0'..'9' : isValid := True;
                              end;
                              If isValid Then Result := 3 Else Result :=0;
                         End;
                    End;
               End
               Else
               Begin
                    // Call can not begin with < 1 or > 9 which is the case if I get here.
                    isValid := False;
                    Result := 0;
               End;
               // I think (famous last words!) I have handled all the case of a call starting with a numeral.
          End
          Else
          Begin
               // Callsign begins with a letter so I will be looking and this callsign did not validate as a single
               // letter/single number prefix so I need to see something in the following list;
               //
               // letter letter number letter
               // letter number number letter
               // letter letter letter number letter (does this REALLY exist on the air) If so then it would be SS[A..Z][0..9][A..Z]
               // letter number number number letter (does this REALLY exist on the air) If so then it would be T3[0..3][0..9][A..Z]
               //
               // This will be messy.
               isValid := False;
               bool1 := False;
               bool2 := False;
               bool3 := False;
               bool4 := False;
               if length(callsign)>3 Then
               Begin
                  case callsign[1] of
                       'A'..'Z' : bool1 := True;
                  end;
                  case callsign[2] of
                       'A'..'Z' : bool2 := True;
                  end;
                  case callsign[3] of
                       '0'..'9' : bool3 := True;
                  end;
                  case callsign[4] of
                       'A'..'Z' : bool4 := True;
                  end;
               End;
               If bool1 And bool2 And bool3 And bool4 Then
               Begin
                    // this seems to pass letter letter number letter.
                    isValid := True;
                    Result := 3;
               End;
               if (not isValid) And (Length(callsign)>4) Then
               Begin
                    bool1 := False;
                    bool2 := False;
                    bool3 := False;
                    bool4 := False;
                    case callsign[1] of
                         'A'..'Z' : bool1 := True;
                    end;
                    case callsign[2] of
                         '0'..'9' : bool2 := True;
                    end;
                    case callsign[3] of
                         '0'..'9' : bool3 := True;
                    end;
                    case callsign[4] of
                         'A'..'Z' : bool4 := True;
                    end;
                    If bool1 And bool2 And bool3 And bool4 Then
                    Begin
                         // this seems to pass letter number number letter.
                         isValid := True;
                         Result := 3;
                    End;
               End;

               If (not isValid) And (Length(callsign)>4) Then
               Begin
                    bool1 := False;
                    bool2 := False;
                    bool3 := False;
                    bool4 := False;
                    if callsign[1..2] = 'SS' Then bool1 := True;
                    case callsign[3] of
                         'A'..'Z' : bool2 := True;
                    end;
                    case callsign[4] of
                         '0'..'9' : bool3 := True;
                    end;
                    case callsign[5] of
                         'A'..'Z' : bool4 := True;
                    end;
                    If bool1 And bool2 And bool3 And bool4 Then
                    Begin
                         // this seems to pass letter letter letter number letter.
                         isValid := True;
                         Result := 4;
                    End;
               End;

               If (not isValid) And (Length(callsign)>4) Then
               Begin
                    bool1 := False;
                    bool2 := False;
                    bool3 := False;
                    bool4 := False;
                    If callsign[1..2] = 'T3' Then bool1 := True;
                    case callsign[3] of
                         '0'..'3' : bool2 := True;
                    end;
                    case callsign[4] of
                         '0'..'9' : bool3 := True;
                    end;
                    case callsign[5] of
                         'A'..'Z' : bool4 := True;
                    end;
                    If bool1 And bool2 And bool3 And bool4 Then
                    Begin
                         // this seems to pass letter number number number letter.
                         isValid := True;
                         Result := 4;
                    End;
               End;
          End;
     End;
     If not isValid Then Result := 0;
     // Oddly enough, I think I have now validated the callsign as having a valid
     // prefix and given the length of it in the return.  0 = Invalid > 0 = Ok.
     // It does not handle some calls that would be valid, i.e. special event
     // calls like DL2000ABC etc.  The programming required to parse those seems
     // not worth the effort.
     //
     // [TODO] Have I corrected 9A3ADE not validating???
     // I think so but not sure yet...
     //
     // [TODO] Handle calls with CALLSIGN-# correctly.
     //
End;

function validateCallsign(callsign : String) : Boolean;
Var
   i, j : Integer;
   isValid : Boolean;
   hasLetter, hasNumber : Boolean;
   three1, three2, three3 : Boolean;
   foo : String;
Begin
     try
        Result := False;
        isValid := False;
        // I think I've found a long standing issue with this routine that has
        // caused me no end of grief.  When evaluating callsigns I have only made
        // one check before parsing it, that being its length >=3...  In the case
        // of length =3 and word being (for example) QSO I crash... now... is this
        // due to the word being all letters or some other more subtle error? Checking...
        // Filtering to pass it being alpha-numeric vs only alpha or numeric seems
        // to have cleared the bug.  Time will tell if this is the final answer to
        // a problem that's been dogging me for close to a year.
        hasLetter := False;
        hasNumber := False;
        For i := 1 to Length(callsign) do
        Begin
             case callsign[i] of
                  'A'..'Z' : hasLetter := True;
                  '0'..'9' : hasNumber := True;
             end;
        End;
        If (not hasLetter) or (not hasNumber) Then callsign := '';
        // Making another change here I should have thought of long ago.  If callsign
        // = 3 characters then I don't need to go through the full loop.  I can use
        // a simplified eval of the word needing to be LETTER NUMBER LETTER to pass.
        // I can refine this by looking at how 3 character calls are allocated, but,
        // for now I'm going to assume that those are rare to see and that I can
        // scrape by looking for USA only format 3 character calls.  I.E. W#LETTER,
        // K#LETTER or N#LETTER.  If I find that other 3 character calls exist and
        // actually appear on the air I'll expand the routine to handle those.
        If Length(callsign) = 3 Then
        Begin
             three1 := False;
             three2 := False;
             three3 := False;
             case callsign[1] of
                  'K','N','W' : three1 := True;
             end;
             case callsign[2] of
                  '0'..'9' : three2 := True;
             end;
             case callsign[3] of
                  'A'..'Z' : three3 := True;
             end;
             If three1 And three2 And three3 Then Result := True Else Result := False;
        End;
        If Length(callsign) > 3 Then
        Begin
             // Here is how to validate a callsign;
             // 1.  Check to see if it's slashed (callsign/something or something/callsign)
             //     1a.  If slashed then only pass the callsign portion to the validator
             //          (Maybe I should think about validation of the prefix/suffix in a slashed call (Maybe? NO.
             //           Certainly I should, so TODO here.)
             // 2.  Pass callsign to getPrefixLength(callsign)
             //     2a.  If getPrefixLength(callsign)>0 Then we have a potentially valid call, just need to see if
             //          it's all letters after the prefix which has the length returned by getPrefixLength.
             // 3.  Validate that the callsign after the prefix is all letters and not too many of them.
             Result := False;
             isValid := False;
             i := 0;
             j := 0;
             If isSlashedCall(callsign) Then
             Begin
                  // This call has a / in it.  Need to extract the actual callsign.
                  If isPrefixedCall(callsign) Then callsign := ExtractWord(2, callsign, ['/']) Else callsign := ExtractWord(1, callsign, ['/']);
             End;
             if length(callsign)>3 Then i := getPrefixLength(callsign) else i := 0;
             If i > 0 Then
             Begin
                  // Seems to be valid so far... now I need to look at the rest of the call for potential garbage.
                  // basically look at the part of the string from i+1..End of string for length and being all letters.
                  inc(i);
                  j := Length(callsign);
                  foo := callsign[i..j];
                  // foo needs to be all letters and not longer than 3 characters.
                  if Length(foo) < 4 Then
                  Begin
                       j := Length(foo);
                       i := 1;
                       isValid := False;
                       Repeat
                             case foo[i] Of
                                  'A'..'Z' : isValid := True Else isValid := False;
                             end;
                             inc(i);
                       Until i>=j;
                       if isValid Then Result := True Else Result := False;
                  End
                  Else
                  Begin
                       isValid := False;
                       Result := False;
                  End;
             End;
        End;
     Except
        dlog.fileDebug('Exception raised in validateCallsign');
        Result := False;
     End;
End;

function isGrid( gridloc : String ): Boolean;
Var
   foo  : String;
   vmsg : Boolean;
Begin
     Try
        Result := True;
        If (Length(gridloc)=4) Or (Length(gridloc)=6) Then
        Begin
             // Validate grid
             // Grid format:
             // Length = 4 or 6
             // characters 1 and 2 range of A ... R, upper case, alpha only.
             // characters 3 and 4 range of 0 ... 9, numeric only.
             // characters 5 and 6 range of a ... x, lower case, alpha only, optional.
             // Validate grid
             foo := gridloc;
             if length(foo) = 6 then
             begin
                  foo[1] := upcase(foo[1]);
                  foo[2] := upcase(foo[2]);
                  foo[5] := lowercase(foo[5]);
                  foo[6] := lowercase(foo[6]);
                  vmsg := false;
                  case foo[1] of 'A'..'R': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[2] of 'A'..'R': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[3] of '0'..'9': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[4] of '0'..'9': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[5] of 'a'..'x': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[6] of 'a'..'x': vmsg := True else vmsg := False; end;
             end
             else
             begin
                  foo[1] := upcase(foo[1]);
                  foo[2] := upcase(foo[2]);
                  vmsg := false;
                  case foo[1] of 'A'..'R': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[2] of 'A'..'R': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[3] of '0'..'9': vmsg := True else vmsg := False; end;
                  if vmsg then case foo[4] of '0'..'9': vmsg := True else vmsg := False; end;
             end;
             result := vmsg;
        End
        Else
        Begin
             Result := False;
        End;
     Except
           Result := False;
     End;
End;

function valQRG( qrg : Integer ) : Boolean;
Begin
     Try
        Result := False;
        //If qrg < 1800 Then qrg := qrg * 1000; // If it's in MHz convert to KHz
        Case qrg of
             1800..2000         : Result := True;
             3500..4000         : Result := True;
             7000..7300         : Result := True;
             10100..10150       : Result := True;
             14000..14350       : Result := True;
             18068..18168       : Result := True;
             21000..21450       : Result := True;
             24890..24990       : Result := True;
             28000..29700       : Result := True;
             50000..54000       : Result := True;
             144000..148000     : Result := True;
             222000..225000     : Result := True;
             420000..450000     : Result := True;
             902000..928000     : Result := True;
             1240000..1300000   : Result := True;
             2300000..2310000   : Result := True;
             2390000..2450000   : Result := True;
             3300000..3500000   : Result := True;
             5650000..5925000   : Result := True;
             10000000..10500000 : Result := True;
             24000000..24250000 : Result := True;
             47000000..47200000 : Result := True;
        End;
     Except
           dlog.fileDebug('Exception raised in valQRG');
           Result := False;
     End;
End;
end.

