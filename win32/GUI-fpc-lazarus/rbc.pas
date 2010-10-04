unit rbc;
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
  Classes, SysUtils, httpsend, Windows, parseCallSign, StrUtils, globalData, dlog;

Type
    rbcReport = Record
      rbTimeStamp : String;
      rbNumSync   : String;
      rbSigLevel  : String;
      rbDeltaTime : String;
      rbDeltaFreq : String;
      rbSigW      : String;
      rbCharSync  : String;
      rbDecoded   : String;
      rbFrequency : String;
      rbMode      : Integer;
      rbProcessed : Boolean;
      rbCached    : Boolean;
    end;

procedure processRB();
procedure doLogin();
procedure doLogout();
procedure sendCached();
function  sendReport(Const url : String; Const i : Integer): Boolean;
function  sendCReport(Const url : String): Boolean;
procedure fileCache(Const url : String);
procedure fileReport(Const i: Integer);
function  stToString() : String;
function  trimDecoded(i : Integer) : String;
function  resolveType1(Const Word2: String; Const Word3: String; Const i: Integer;
                       Var callsign: String; Var Grid: String): Boolean;
function  resolveType0(Const Word1: String; Const Word2: String; Const Word3: String;
                       Const i: Integer; Var callsign: String; Var Grid: String): Boolean;

var
   //glrblog                : TextFile;
   glrbReports            : Array[0..499] of rbcReport;
   glrbActive             : Boolean;
   glrbNoInet             : Boolean;
   glrbEnterTS            : TDateTime;
   glrbCallsign           : String;
   //rbID                 : String;
   glrbQRG                : String;
   glrbGrid               : String;
   glrbsLastCall          : Array[0..499] Of String;
   glrbsSentCount         : Integer;
   glrbAlwaysSave         : Boolean;

implementation

procedure doLogin();
Var
   foo, foo2     : String;
   HTTP          : THTTPSend;
   fvar          : Single;
   ivar          : Integer;
   rbResult      : TStringList;
Begin
     // Save entry point TimeStamp
     glrbEnterTS := Now;
     glrbActive := True;
     If not glrbNoInet Then
     Begin
          Try
             fvar := 0.0;
             ivar := 0;
             if globalData.gmode = 4 then foo2 := '4B';
             if globalData.gmode = 65 then foo2 := '65A';
             if globalData.gmode = 0 then foo2 := '65A/4B';
             foo2 := foo2 + globalData.mtext;
             If TryStrToFloat(glrbQRG, fvar) Then ivar := trunc(fvar) Else ivar := 0;
             If (ivar > 0) And parseCallSign.valQRG(ivar) Then
             Begin
                  foo := 'http://jt65.w6cqz.org/dbb.php?func=JLOGIN&value1=' +
                         glrbCallsign + '&value2=' + glrbQRG + '&value3=' + foo2 +
                         '&value4=' + glrbGrid;
                  HTTP := THTTPSend.Create;
                  HTTP.Timeout := 10000;  // Is this correct?
                  HTTP.Headers.Add('Accept: text/html');
                  // I think it wants ms for timeout value...
                  if not HTTP.HTTPMethod('GET', foo) Then
                  begin
                       globalData.rbLoggedIn := False;
                  end
                  else
                  begin
                       rbResult := TStringList.Create;
                       rbResult.Clear;
                       rbResult.LoadFromStream(HTTP.Document);
                       If TrimLeft(TrimRight(rbResult.Text)) = 'BADQRG' Then
                       Begin
                            rbLoggedIn := False;
                            dlog.fileDebug('RB Login Fails.  Error:  ' + TrimLeft(TrimRight(rbResult.Text)));
                       End;
                       If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then
                       Begin
                            globalData.rbLoggedIn := True;
                       End;
                       if not globalData.rbLoggedIn  And (TrimLeft(TrimRight(rbResult.Text))<>'BADQRG') Then dlog.fileDebug('RB Login Fails.  Unknown Error.');
                       rbResult.Free;
                  end;
                  HTTP.Free;
             end
             else
             begin
                  globalData.rbLoggedIn := False;
             end;
          Except
             dlog.fileDebug('Exception in doLogin');
             glrbActive := False;
          End;
     End
     Else
     Begin
          glrbActive := False;
     End;
     glrbActive := False;
End;

procedure doLogout();
Var
   foo           : String;
   HTTP          : THTTPSend;
   rbResult      : TStringList;
Begin
     // Save entry point TimeStamp
     glrbEnterTS := Now;
     glrbActive := True;
     If not glrbNoInet Then
     Begin
          Try
             foo := 'http://jt65.w6cqz.org/dbb.php?func=LOGOUT&value1=' + glrbCallsign;
             HTTP := THTTPSend.Create;
             HTTP.Timeout := 10000;  // Is this correct?
             HTTP.Headers.Add('Accept: text/html');
             // I think it wants ms for timeout value...
             if not HTTP.HTTPMethod('GET', foo) Then
             begin
                  globalData.rbLoggedIn := True;
             end
             else
             begin
                  rbResult := TStringList.Create;
                  rbResult.Clear;
                  rbResult.LoadFromStream(HTTP.Document);
                  globalData.rbLoggedIn := False;
                  rbResult.Free;
             end;
             HTTP.Free;
             glrbActive := False;
          Except
                dlog.fileDebug('Exception in doLogout');
                glrbActive := False;
          End;
     End
     Else
     Begin
          glrbActive := False;
          globalData.rbLoggedIn := False;
     End;
     glrbActive := False;
End;

function stToString() : String;
var
   st : TSYSTEMTIME;
   {$IFDEF linux}
    dt : TDateTime;
   {$ENDIF}
   sTime : String;
begin
     st.Day := 0;
     {$IFDEF win32}
       GetSystemTime(st);
     {$ENDIF}
     {$IFDEF linux}
       dt := synaUtil.GetUTTime;
       DateTimeToSystemTime(GetUTTime,st);
     {$ENDIF}
     sTime := IntToStr(st.Year) + '-';
     If st.Month < 10 Then sTime := sTime + '0' + IntToStr(st.Month) + '-' else
     sTime := sTime + IntToStr(st.Month) + '-';
     If st.Day < 10 Then sTime := sTime + '0' + IntToStr(st.Day) + '-' else
     sTime := sTime + IntToStr(st.Day) + '  ';
     if st.Hour < 10 Then sTime := sTime + '0' + IntToStr(st.Hour) + ':' else
     sTime := sTime + IntToStr(st.Hour) + ':';
     If st.Minute < 10 Then sTime := sTime + '0' + IntToStr(st.Minute) + ':' else
     sTime := sTime + IntToStr(st.Minute) + ':';
     If st.Second < 10 Then sTime := sTime + '0' + IntToStr(st.Second) + ':' else
     sTime := sTime + IntToStr(st.Second) + ':';
     If st.Millisecond < 10 Then sTime := sTime + '00' + IntToStr(st.Millisecond);
     If (st.Millisecond < 100) And (st.Millisecond > 9) Then
     sTime := sTime + '0' + IntToStr(st.Millisecond);
     if st.Millisecond > 99 Then sTime := sTime + IntToStr(st.Millisecond);
     Result := sTime;
end;

function trimDecoded(i : Integer) : String;
Var
   foo : String;
Begin
     // Trim rbDecoded of any extra whitespace
     foo := TrimLeft(TrimRight(glrbReports[i].rbDecoded));
     // Make sure there's only 1 space between 'words'
     foo := DelSpace1(foo);
     Result := foo;
End;

function resolveType1(Const Word2: String; Const Word3: String; Const i: Integer;
                      Var callsign: String; Var Grid: String): Boolean;
Var
   resolved : Boolean;
Begin
     Try
        // It's looking like a CQ/QRZ/TEST + some_call +
        // (maybe) some_grid, CQ DX + some_call.
        callsign := '';
        grid := '';
        resolved := False;
        // Now word 2 must be a callsign or (GROAN) DX
        if word2 = 'DX' Then
        Begin
             // Because word2 = DX callsign will now be in word3
             // and no grid can exist reliably since this is a
             // plain text message.
             if length(word3) >=3 Then
             Begin
                  if parseCallSign.validateCallsign(word3) Then
                  Begin
                       // Have a callsign in the right place.  This is a
                       // valid report that will be sent/saved.
                       callsign := word3;
                       resolved := True;
                  end
                  else
                  begin
                       // Entry was invalid, but it still needs to be marked processed.
                       // Text in callsign position did not validate.
                       //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                       //inc(globalData.rbsFailIdx);
                       //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                       glrbReports[i].rbProcessed := True;
                       grid := '';
                       callsign := '';
                       Resolved := False;
                  end;
             End
             Else
             Begin
                  // Entry was invalid, but it still needs to be marked processed.
                  // Text in callsign position was too short to validate.
                  //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                  //inc(globalData.rbsFailIdx);
                  //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                  glrbReports[i].rbProcessed := True;
                  grid := '';
                  callsign := '';
                  resolved := False;
             End;
        End
        Else
        Begin
             // Now depending upon whether this is a properly formed message I may see
             // a call in word2 and a grid in word3 or just a call and a truncated
             // grid.  Will check for both cases.  Need a callsign to begin with.
             if length(word2) >=3 Then
             Begin
                  if parseCallSign.validateCallsign(word2) Then
                  Begin
                       callsign := word2;
                       // word2 validates as call.  This is a valid report and
                       // will be sent/saved.  Check for grid in word3
                       if length(word3) >3 Then
                       Begin
                            if parseCallSign.isGrid(word3) Then grid := word3 else grid := '';
                       End
                       Else
                       Begin
                            // word3 is too short to be a grid.
                            grid := '';
                       End;
                       resolved := True;
                  end
                  else
                  begin
                       // Entry was invalid, but it still needs to be marked processed.
                       // Text in callsign position did not validate.
                       //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                       //inc(globalData.rbsFailIdx);
                       //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                       glrbReports[i].rbProcessed := True;
                       grid := '';
                       callsign := '';
                       resolved := False;
                  end;
             end
             else
             begin
                  // Entry was invalid, but it still needs to be marked processed.
                  // Text in callsign position was too short to validate.
                  //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                  //inc(globalData.rbsFailIdx);
                  //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                  glrbReports[i].rbProcessed := True;
                  grid := '';
                  callsign := '';
                  resolved := False;
             end;
        End;
        Result := resolved;
     Except
           dlog.fileDebug('Exception in resolveType1');
           glrbReports[i].rbProcessed := True;
           result := False;
     End;
End;

function resolveType0(Const Word1: String; Const Word2: String; Const Word3: String;
                      Const i: Integer; Var callsign: String; Var Grid: String): Boolean;
Var
   resolved : Boolean;
Begin
     Try
        resolved := False;
        // At this point word1 MUST be a callsign to proceed as I've handled
        // all other valid forms of word1 above.
        if length(word1) >=3 Then
        Begin
             //globalData.debugLine1 := 'Calling validateCallsign(), timestamp:  ' + stToString();
             if parseCallSign.validateCallsign(word1) Then
             Begin
                  // Now... I could have another call in word2
                  // with a grid or a report/ack in word3 or
                  // I could have a grid in word2 and no word3
                  // Check for a call in word2
                  if length(word2) >= 3 Then
                  Begin
                       if parseCallSign.validateCallsign(word2) Then
                       Begin
                            callsign := word2;
                            resolved := True;
                            // OK.. this is call in word1 being called by call in word2
                            // and should have a grid or report/ack in word3. Check word3
                            if length(word3) >3 Then
                            Begin
                                 if parseCallSign.isGrid(word3) Then grid := word3 else grid := '';
                            End
                            Else
                            Begin
                                 grid := '';
                            End;
                       End
                       Else
                       Begin
                            // since word2 is not a call I can check to see if word2
                            // is a grid or the word TEST which will validate word1
                            // as the sender's callsign.
                            If word2 = 'TEST' Then
                            Begin
                                 callsign := word1;
                                 grid := '';
                                 resolved := True;
                                 // some_call + TEST
                            End
                            Else
                            Begin
                                 if length(word2) > 3 Then
                                 Begin
                                      if parseCallSign.isGrid(word2) Then
                                      Begin
                                           grid := word2;
                                           resolved := True;
                                      End
                                      Else
                                      Begin
                                           // Entry was invalid, but it still needs to be marked processed.
                                           //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                                           //inc(globalData.rbsFailIdx);
                                           //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                                           glrbReports[i].rbProcessed := True;
                                           grid := '';
                                           callsign := '';
                                      End;
                                 End
                                 Else
                                 Begin
                                      // Entry was invalid, but it still needs to be marked processed.
                                      //globalData.rbsFailLog[globalData.rbsFailIdx] := 'No TX call found in correct position.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                                      //inc(globalData.rbsFailIdx);
                                      //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                                      glrbReports[i].rbProcessed := True;
                                      grid := '';
                                      callsign := '';
                                 End;
                            End;
                       End;
                  End
                  Else
                  Begin
                       // Word2 too short to be callsign
                  End;
             End
             Else
             Begin
                  // Entry was invalid, but it still needs to be marked processed.
                  // Does not start with a valid callsign.
                  //globalData.rbsFailLog[globalData.rbsFailIdx] := 'Could not resolve message.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
                  //inc(globalData.rbsFailIdx);
                  //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                  glrbReports[i].rbProcessed := True;
                  grid := '';
                  callsign := '';
             End;
             //globalData.debugLine2 := 'validateCallsign() returned, timestamp:  ' + stToString();
        End
        Else
        Begin
             // Entry was invalid, but it still needs to be marked processed.
             // First word too short to be callsign.
             //globalData.rbsFailLog[globalData.rbsFailIdx] := 'Could not resolve message.  Exchange was:  ' + globalData.rbReports[i].rbDecoded;
             //inc(globalData.rbsFailIdx);
             //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
             glrbReports[i].rbProcessed := True;
             grid := '';
             callsign := '';
        End;
        Result := resolved;
     Except
           dlog.fileDebug('Exception in resolveType0');
           glrbReports[i].rbProcessed := True;
           Result := False;
     End;
End;

function sendReport(Const url : String; Const i : Integer): Boolean;
Var
   rbErrorCode   : Integer;
   rbErrorString : String;
   foo           : String;
   HTTP          : THTTPSend;
   rbResult      : TStringList;
begin
     If not glrbNoInet Then
     Begin
          Try
             Result := False;
             // Save entry point TimeStamp
             HTTP := THTTPSend.Create;
             // I think it wants ms for timeout value...
             HTTP.Timeout := 10000;  // Is this correct?
             HTTP.Headers.Add('Accept: text/html');
             if not HTTP.HTTPMethod('GET', url) Then
             begin
                  rbErrorCode := HTTP.ResultCode;
                  rbErrorString := HTTP.ResultString;
                  // Cache the report in case of error.
                  glrbReports[i].rbCached := True;
                  foo := 'Report cached.  Error:  ';
                  if rbErrorCode = 500 Then foo := foo + 'Network com fail' + '(' + IntToStr(rbErrorCode) + ')  Exchange was:  ' + glrbReports[i].rbDecoded Else
                  foo := foo + rbErrorString + '(' + IntToStr(rbErrorCode) + ')  Exchange was:  ' + glrbReports[i].rbDecoded;
                  //globalData.rbsFailLog[globalData.rbsFailIdx] :=  foo;
                  //inc(globalData.rbsFailIdx);
                  //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                  Result := False;
             end
             else
             begin
                  rbResult := TStringList.Create;
                  rbResult.Clear;
                  rbResult.LoadFromStream(HTTP.Document);
                  glrbReports[i].rbCached := False;
                  Result := True;
                  rbResult.Free;
             end;
             HTTP.Free;
          Except
             dlog.fileDebug('Exception in sendReport');
          End;
     End
     Else
     Begin
          glrbReports[i].rbCached := False;
          Result := True;
     End;
end;

function sendCReport(Const url : String): Boolean;
Var
   HTTP          : THTTPSend;
begin
     If not glrbNoInet Then
     Begin
          Try
             // Save entry point TimeStamp
             HTTP := THTTPSend.Create;
             // I think it wants ms for timeout value...
             HTTP.Timeout := 10000;  // Is this correct?
             HTTP.Headers.Add('Accept: text/html');
             if not HTTP.HTTPMethod('GET', url) Then
             begin
                  Result := False;
             end
             else
             begin
                  Result := True;
             end;
             HTTP.Free;
          Except
             dlog.fileDebug('Exception in sendCReport');
             Result := False;
          End;
     End
     Else
     Begin
          Result := False;
     End;
end;

procedure sendCached();
Var
   haveCache          : Boolean;
   validLine          : Boolean;
   cacheFile          : TextFile;
   foo, word1, word2  : String;
   ecount, lcount, i  : Integer;
   lArray             : Array of String;
   //cacheLcount        : Integer;
   //cacheLproc         : Integer;
Begin
     glrbEnterTS := Now;
     glrbActive := True;
     // Need to read in cache either sending all, some or none.  Remove sent
     // items from cache file and if all sent no cache file will be left.
     //
     // cache file rbcache.txt
     // format
     // url (example follows)
     // http://jt65.w6cqz.org/dbb.php?func=CPUTQSL&value1=W6CQZ-1&value2=14076&value3=-25&value4=DU1GM&value5=PK04&value6=-393&value7=65A&value8=09:54:00&value9=2009-05-28&value10=400,F
     try
        haveCache := False;
        ecount := 0;
        lcount := 0;
        //globalData.cacheInProc := False;
        If FileExists('rbcache.txt') Then haveCache := True;
        if haveCache Then
        Begin
             //globalData.cacheInProc := True;
             assignFile(cacheFile,'rbcache.txt');
             reset(cacheFile);
             While not EOF(cacheFile) do
             Begin
                  ReadLn(cacheFile,foo);
                  inc(lcount);
             End;
             //cacheLcount := lcount;
             //cacheLproc  := 0;
             SetLength(lArray,lcount+1);
             reset(cacheFile);
             i := 0;
             While not EOF(cacheFile) do
             Begin
                  ReadLn(cacheFile,lArray[i]);
                  inc(i);
             End;
             i := 0;
             while i < Length(lArray) do
             begin
                  // Cache file structure
                  //Report,Processed
                  word1 := ExtractWord(1,lArray[i],parseCallSign.CsvDelim); // URL
                  word2 := ExtractWord(2,lArray[i],parseCallSign.CsvDelim); // Processed
                  validLine := True;
                  if word2 <> 'F' Then validLine := False;
                  if validLine Then
                  Begin
                       if word1[1..4] = 'http' Then
                       Begin
                            if sendCReport(word1) Then
                            Begin
                                 word2 := 'T';
                                 lArray[i] := word1 + ',' + word2;
                            End;
                       End;
                  End;
                  // Try not to overload the RB Server with too many rapid reportings.
                  sleep(250);
                  inc(i);
             end;
             closeFile(cacheFile);
             i := 0;
             while i < Length(lArray) do
             begin
                  word1 := ExtractWord(1,lArray[i],parseCallSign.CsvDelim); // URL
                  word2 := ExtractWord(2,lArray[i],parseCallSign.CsvDelim); // Processed
                  if word2 = 'F' Then inc(ecount);
                  inc(i);
             end;
             if ecount > 0 Then
             Begin
                  deleteFile('rbcache.txt');
                  assignFile(cacheFile,'rbcache.txt');
                  rewrite(cacheFile);
                  i := 0;
                  while i < Length(lArray) do
                  Begin
                       word1 := ExtractWord(1,lArray[i],parseCallSign.CsvDelim); // URL
                       word2 := ExtractWord(2,lArray[i],parseCallSign.CsvDelim); // Processed
                       if word2 = 'F' Then writeLn(cacheFile,lArray[i]);
                       inc(i);
                  End;
                  closeFile(cacheFile);
             End;
        End;
     Except
           dlog.fileDebug('Exception in sendCached');
     End;
     //globalData.cacheInProc := False;
     glrbActive := False;
End;

procedure fileReport(Const i: Integer);
Var
   rbCache           : TextFile;
   foo2              : String;
Begin
     Try
        if globalData.gmode = 4 then foo2 := '4B';
        if globalData.gmode = 65 then foo2 := '65A';
        if globalData.gmode = 0 Then
        Begin
             if glrbReports[i].rbmode = 65 then foo2 := '65A';
             if glrbReports[i].rbmode = 65 then foo2 := '4B';
        End;
        // User has selected offline mode (or report failed to
        // transmit in live mode), so I save to file.
        // Set cached to false before writing so it can be
        // processed again later.
        glrbReports[i].rbCached := False;
        // What I will do here is add the entire record (rbReports[i])
        // Test for existance of rbcache.csv
        AssignFile(rbCache, 'decodes.csv');
        If FileExists('decodes.csv') Then
        Begin
             Append(rbCache);
        End
        Else
        Begin
             Rewrite(rbCache);
             WriteLn(rbCache,'"MYCALL","QRGKHZ","YYYYMMDDHHMMSS","DB","DF","EXCHANGE","MODE"');
        End;
        // Write the record
        WriteLn(rbCache, '"' + glrbCallsign + '","' +
                glrbReports[i].rbFrequency + '","' +
                glrbReports[i].rbTimeStamp + '","' +
                glrbReports[i].rbSigLevel + '","' +
                glrbReports[i].rbDeltaFreq + '","' +
                glrbReports[i].rbDecoded + '","' + foo2 + '"');
        // Close the file
        CloseFile(rbCache);
     Except
        dlog.fileDebug('Exception in fileReport');
     End;
End;

procedure fileCache(Const url : String);
Var
   rbCache : TextFile;
   fname   : String;
Begin
     Try
        fname := GetAppConfigDir(False)+'rbcache.txt';
        AssignFile(rbCache,fname);
        If FileExists(fname) Then Append(rbCache) Else Rewrite(rbCache);
        WriteLn(rbCache,url+',F');
        CloseFile(rbCache);
     Except
           dlog.fileDebug('Exception in fileCache');
     End;
End;

procedure processRB();
var
   i, msgtype, intvar  : Integer;
   looper              : Integer;
   floatvar            : Single;
   callsign, grid, foo : String;
   word1, word2, word3 : String;
   foo2                : String;
   resolved            : Boolean;
begin
     // Save entry point TimeStamp
        glrbEnterTS := Now;
        glrbActive := True;
        if globalData.gmode = 4 then foo2 := '4B';
        if globalData.gmode = 65 then foo2 := '65A';
        // I need to walk rbReports array processing any unprocessed records.
        // Processing = validate text to see if it's a sendable report, if so,
        // send it to rb server unlesss in offline mode.  If in offline mode
        // save record to cache marking processed in memory not processed in
        // file.
        for i := 0 to 499 do
        begin
             if not glrbReports[i].rbProcessed then
             begin
                  // Found a record that has not been processed.
                  // Check QRG
                  resolved := False;
                  floatvar := 0;
                  if globalData.gmode = 0 Then
                  Begin
                       if glrbReports[i].rbMode = 65 then foo2 := '65A';
                       if glrbReports[i].rbMode = 4 then foo2 := '4B';
                  End;
                  If TryStrToFloat(glrbReports[i].rbFrequency, floatvar) Then intvar := trunc(floatvar) Else intvar := 0;
                  If parseCallSign.valQRG(intvar) Then
                  Begin
                       // QRG Validates
                       // Attempt to determine form of rbDecoded.
                       // Remove any excess space characters.
                       glrbReports[i].rbDecoded := trimDecoded(i);
                       // Break rbDecoded into individual words. I could do this into an array,
                       // but I know I'm going to ONLY have 1, 2 or 3 words in ANY sequence
                       // which will validate so I'll assign them to 3 string vars.
                       word1 := ExtractWord(1,glrbReports[i].rbDecoded,parseCallSign.WordDelimiter);
                       word2 := ExtractWord(2,glrbReports[i].rbDecoded,parseCallSign.WordDelimiter);
                       word3 := ExtractWord(3,glrbReports[i].rbDecoded,parseCallSign.WordDelimiter);
                       // If I couldn't extract any of the 3 words above it will = ''
                       resolved := False;
                       callsign := '';
                       grid := '';
                       msgtype := 0;
                       // If callsign or grid not = '' after all the evaluations then
                       // I'll need to send/save report.
                       // Determine 'form' of message.
                       if word1 = 'CQ' then msgtype := 1;
                       if word1 = 'QRZ' then msgtype := 1;
                       if word1 = 'TEST' then msgtype := 1;
                       if word1 = 'CQDX' then msgtype := 1;
                       // Handle message format 1.
                       If msgtype = 1 Then
                       Begin
                            if resolveType1(word2, word3, i, callsign, grid) Then resolved := True else resolved := False;
                       End;
                       // Handle not message format 1.
                       If msgtype = 0 Then
                       Begin
                            if resolveType0(word1, word2, word3, i, callsign, grid) Then resolved := True else resolved := False;
                       end;
                  End
                  Else
                  Begin
                       // Entry was invalid, but it still needs to be marked processed.
                       //globalData.rbsFailLog[globalData.rbsFailIdx] := 'Invalid QRG.  QRG = ' + globalData.rbReports[i].rbFrequency;
                       //Inc(globalData.rbsFailIdx);
                       //if globalData.rbsFailIdx > 499 Then globalData.rbsFailIdx := 0;
                       glrbReports[i].rbProcessed := True;
                       grid := '';
                       callsign := '';
                       resolved := False;
                  End;
                  // At this point if resolved then I have something to report and/
                  // or save to disk.

                  if resolved and not globalData.rbCacheOnly Then
                  Begin
                       // Handle sending of report live
                       foo := 'http://jt65.w6cqz.org/dbb.php?func=PUTQSL' +
                              '&value1=' + glrbCallSign +
                              '&value2=' + glrbReports[i].rbFrequency +
                              '&value3=' + glrbReports[i].rbSigLevel +
                              '&value4=' + callsign +
                              '&value5=' + grid +
                              '&value6=' + glrbReports[i].rbDeltaFreq +
                              '&value7=' + foo2 +
                              '&value8=' + glrbReports[i].rbTimeStamp[9..10] + ':'
                                         + glrbReports[i].rbTimeStamp[11..12] + ':'
                                         + glrbReports[i].rbTimeStamp[13..14] +
                              '&value9=' + glrbReports[i].rbTimeStamp[1..4] + '-'
                                         + glrbReports[i].rbTimeStamp[5..6] + '-'
                                         + glrbReports[i].rbTimeStamp[7..8] +
                              '&value10=504';
                       // Now I need to send the RB spot.
                       // sendReport will return true on success.
                       if length(callsign) > 0 Then
                       Begin
                            If sendReport(foo, i) Then
                            Begin
                                 // Find a space in globalData.lastCall to insert callsign heard this round.
                                 looper := 0;
                                 while looper < 500 do
                                 begin
                                      if glrbsLastCall[looper] = '' Then
                                      Begin
                                           glrbsLastCall[looper] := callsign;
                                           looper := 501;
                                      End;
                                      inc(looper);
                                 end;
                                 //globalData.rbsSentLog[globalData.rbsSentIdx] := globalData.rbReports[i].rbDecoded;
                                 //inc(globalData.rbsSentIdx);
                                 //if globalData.rbsSentIdx > 499 Then globalData.rbsSentIdx := 0;
                                 inc(glrbsSentCount);
                            End
                            Else
                            Begin
                                 // RB report should have been sent live but failed so cache
                                 // to rbcache.txt with format;
                                 // url,processed
                                 // url generated above,'F'
                                 foo := 'http://jt65.w6cqz.org/dbb.php?func=CPUTQSL' +
                                        '&value1=' + glrbCallSign +
                                        '&value2=' + glrbReports[i].rbFrequency +
                                        '&value3=' + glrbReports[i].rbSigLevel +
                                        '&value4=' + callsign +
                                        '&value5=' + grid +
                                        '&value6=' + glrbReports[i].rbDeltaFreq +
                                        '&value7=' + foo2 +
                                        '&value8=' + glrbReports[i].rbTimeStamp[9..10] + ':'
                                                   + glrbReports[i].rbTimeStamp[11..12] + ':'
                                                   + glrbReports[i].rbTimeStamp[13..14] +
                                        '&value9=' + glrbReports[i].rbTimeStamp[1..4] + '-'
                                                   + glrbReports[i].rbTimeStamp[5..6] + '-'
                                                   + glrbReports[i].rbTimeStamp[7..8] +
                                        '&value10=504';
                                 fileCache(foo);
                            End;
                       End;
                  End;

                  // Handling cache only mode.
                  if resolved and globalData.rbCacheOnly Then
                  Begin
                       // Form RB report for inet cache
                       foo := 'http://jt65.w6cqz.org/dbb.php?func=CPUTQSL' +
                              '&value1=' + glrbCallSign +
                              '&value2=' + glrbReports[i].rbFrequency +
                              '&value3=' + glrbReports[i].rbSigLevel +
                              '&value4=' + callsign +
                              '&value5=' + grid +
                              '&value6=' + glrbReports[i].rbDeltaFreq +
                              '&value7=' + foo2 +
                              '&value8=' + glrbReports[i].rbTimeStamp[9..10] + ':'
                                         + glrbReports[i].rbTimeStamp[11..12] + ':'
                                         + glrbReports[i].rbTimeStamp[13..14] +
                              '&value9=' + glrbReports[i].rbTimeStamp[1..4] + '-'
                                         + glrbReports[i].rbTimeStamp[5..6] + '-'
                                         + glrbReports[i].rbTimeStamp[7..8] +
                              '&value10=504';
                       // Now I need to save the RB spot.
                       if length(callsign) > 0 Then fileCache(foo);
                  End;

                  // Handling save all spots mode
                  if resolved And glrbAlwaysSave Then fileReport(i);
                  resolved := False;
             end;
             // And no matter what else, at this point I must... even though it
             // should have already been set true above it doesn't hurt to be sure.
             glrbReports[i].rbProcessed := True;
        end;
        glrbActive := False;
end;
end.
