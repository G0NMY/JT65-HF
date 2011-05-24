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
unit spot;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, httpsend, synacode, valobject, StrUtils, CTypes, PSKReporter;

Type
    spotRecord = record
      qrg      : Integer;
      date     : String;
      time     : String;
      sync     : Integer;
      db       : Integer;
      dt       : Double;
      df       : Integer;
      decoder  : String;
      exchange : String;
      mode     : String;
      rbsent   : Boolean;
      pskrsent : Boolean;
    end;

    spotsArray = Array of spotRecord;

    // Encapsulates all the possible spotting methods to a single unified interface.
    // Handles (for now) RB and PSKR spotting.
    TSpot = Class
       private
              // Control values
              prMyCall  : String;
              prMyGrid  : String;
              prMyQRG   : Integer;
              prUseRB   : Boolean;
              prUsePSKR : Boolean;
              prUseDBF  : Boolean;
              prRBOn    : Boolean;
              prRBError : String;
              prPSKROn  : Boolean;
              prBusy    : Boolean;
              prVersion : String;
              prSpots   : spotsArray;
              prVal     : valobject.TValidator;
              prRBCount : CTypes.cuint64;
              prPRCount : CTypes.cuint64;
              pskrStats : PSKReporter.REPORTER_STATISTICS;
              pskrstat  : DWORD;
              prInfo    : String;
              prhttp    : THTTPSend;
              rbResult  : TStringList;
              // Private functions to format data for PSK Reporter
              function BuildRemoteString (call, mode, freq, date, time : String) : WideString;
              function BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
              function BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
              // Private function to parse exchange text for RB/PSKR
              function  parseExchange(const exchange : String; var callheard : String; var gridheard : String) : Boolean;
       public
             Constructor create;
             Destructor  endspots;
             function    addSpot(const spot : spotRecord) : Boolean;
             function    loginRB    : Boolean;
             function    loginPSKR  : Boolean;
             function    logoutRB   : Boolean;
             function    logoutPSKR : Boolean;
             function    pushSpots  : Boolean;
             function    RBcountS   : String;
             function    PRcountS   : String;
             function    pskrTickle : DWORD;

             property myCall    : String
                read  prMyCall
                write prMyCall;
             property myGrid    : String
                read  prMyGrid
                write prMyGrid;
             property myQRG     : Integer
                read  prMyQRG
                write prMyQRG;
             property useRB     : Boolean
                read  prUseRB
                write prUseRB;
             property usePSKR   : Boolean
                read  prUsePSKR
                write prUsePSKR;
             property useDBF    : Boolean
                read  prUseDBF
                write prUseDBF;
             property rbOn      : Boolean
                read  prRBOn;
             property pskrOn    : Boolean
                read  prPSKROn;
             property busy      : Boolean
                read  prBusy;
             property rbError   : String
                read  prRBError;
             property version   : String
                read  prVersion
                write prVersion;
             property rbCount   : String
                read  RBCountS;
             property pskrCount : String
                read  PRCountS;
             property rbInfo    : String
                read  prInfo
                write prInfo;
             property rbVersion : String
                read  prVersion
                write prVersion;
             property pskrCallsSent : Word
                read  pskrStats.callsigns_sent;
             property pskrCallsBuff : Word
                read  pskrStats.callsigns_discarded;  // I know this looks WRONG but, so far, it's not.  See notes in constructor code.
             property pskrCallsDisc : Word
                read  pskrStats.next_send_time;
             property pskrConnected : LongBool
                read  pskrStats.connected;
       end;

implementation
    constructor TSpot.Create;
    var
       i : Integer;
    Begin
         // Setup validation utility object
         prVal     := valobject.TValidator.create();
         // Setup http object for RB use
         prhttp         := THTTPSend.Create;
         prhttp.Timeout := 10000;  // 10K ms = 10 s
         prhttp.Headers.Add('Accept: text/html');

         prMyCall  := '';
         prMyGrid  := '';
         prMyQRG   := 0;
         prUseRB   := false;
         prUsePSKR := False;
         prUseDBF  := False;
         prRBOn    := False;
         prRBError := '';
         prPSKROn  := False;
         prVersion := '';
         prRBCount := 0;
         prPRCount := 0;
         prInfo    := '';
         setlength(prSpots,4096);
         for i := 0 to 4095 do
         begin
              prspots[i].qrg      := 0;
              prspots[i].date     := '';
              prspots[i].time     := '';
              prspots[i].sync     := 0;
              prspots[i].db       := 0;
              prspots[i].dt       := 0.0;
              prspots[i].df       := 0;
              prspots[i].decoder  := '';
              prspots[i].exchange := '';
              prspots[i].mode     := '65A';
              prspots[i].rbsent   := true;
              prspots[i].pskrsent := true;
         end;
         rbResult := TStringList.Create;
         rbResult.Clear;
         // pskrStats variables
         {
         hostname: array[0..256-1] of WideChar;
         port: array[0..32-1] of WideChar;
         connected : Bool;
         callsigns_sent : Word;
         callsigns_buffered : Word;
         callsigns_discarded : Word;
         last_send_time : Word;
         next_send_time : Word;
         last_callsign_queued: array[0..24-1] of WideChar;
         bytes_sent : Word;
         bytes_sent_total : Word;
         packets_sent : Word;
         packets_sent_total : Word;
         }
         // I don't care what the above says.  It's screwed up!
         // Sent is correct but
         // Buffered is held in discarded
         // Discarded is held in next_send_time
         pskrstats.connected           := False;
         pskrstats.callsigns_sent      := 0;
         pskrstats.callsigns_buffered  := 0;
         pskrstats.callsigns_discarded := 0;
         pskrstats.last_send_time      := 0;
         pskrstats.next_send_time      := 0;

         pskrstat := PSKReporter.ReporterInitialize('report.pskreporter.info','4739');
    End;

    Destructor TSpot.endspots;
    Begin
         prHTTP.Free;                       // Release HTTP object
         PSKReporter.ReporterUninitialize;  // Release PSK Reporter
         setlength(prSpots,0);              // Free spots array
    end;

    function  TSpot.pskrTickle : DWORD;
    begin
         PSKReporter.ReporterGetStatistics(pskrStats,sizeof(pskrStats));
         result := PSKReporter.ReporterTickle;
    end;

    function  TSpot.RBcountS : String;
    begin
         result := IntToStr(prRBCount);
    end;

    function  TSpot.PRcountS : String;
    begin
         result := IntToStr(prPRCount);
    end;

    function  TSpot.addSpot(const spot : spotRecord) : Boolean;
    var
       i         : Integer;
       inserted  : Boolean;
    begin
         inserted := false;
         for i := 0 to 4095 do
         begin
              if prSpots[i].rbsent and prSpots[i].pskrsent then
              begin
                   // Found a spot to insert a new report
                   prspots[i].qrg      := spot.qrg;
                   prspots[i].date     := spot.date;
                   prspots[i].time     := spot.time;
                   prspots[i].sync     := spot.sync;
                   prspots[i].db       := spot.db;
                   prspots[i].dt       := spot.dt;
                   prspots[i].df       := spot.df;
                   prspots[i].decoder  := spot.decoder;
                   prspots[i].exchange := spot.exchange;
                   prspots[i].mode     := '65A';
                   prspots[i].rbsent   := false;
                   prspots[i].pskrsent := false;
                   inserted := true;
                   break;
              end;
         end;
         result := inserted;
    end;

    function TSpot.loginRB : Boolean;
    var
       url      : String;
    Begin
         prRBError    := '';
         prBusy       := True;
         url          := 'http://jt65.w6cqz.org/rb.php?func=LI&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG) + '&rbversion=' + prVersion;
         prhttp.Timeout := 10000;  // 10K ms = 10 s
         prhttp.Headers.Add('Accept: text/html');
         rbResult.Clear;
         Try
            // This logs in to the RB System using parameters set in the object class
            if not prHTTP.HTTPMethod('GET', url) Then
            begin
                 prRBOn := False;
                 result := False;
            end
            else
            begin
                 rbResult.LoadFromStream(prHTTP.Document);
                 // Messages RB login can return:
                 // QSL - All good, logged in.
                 // NO - Indicates login failed but not due to bad RB data, so it's safe to try again. (Probably RB Server busy)
                 // BAD QRG - Fix the RB's QRG error before trying again.
                 // BAD GRID - Invalid Grid value, fix before trying again.
                 // BAD CALL - RB Call too short/long, fix before trying again.
                 // BAD MODE - RB Mode not 65A or 4B, fix before trying again.
                 If TrimLeft(TrimRight(rbResult.Text)) = 'QSL'      Then prRBOn := true;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'BAD QRG'  Then prRBOn := false;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'BAD GRID' Then prRBOn := false;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'BAD CALL' Then prRBOn := false;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'BAD MODE' Then prRBOn := false;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'NO'       Then prRBOn := false;
                 prRBError := TrimLeft(TrimRight(rbresult.Text));
            end;
         Except
            prRBError := 'EXCEPTION';
            prRBOn    := False;
         End;
         result := prRBOn;
         prBusy := False;
    end;

    function TSpot.logoutRB : Boolean;
    var
       url      : String;
       band     : String;
       go       : Boolean;
    Begin
         band := '';
         if prVal.evalIQRG(prMyQRG,'LAX',band) then go := true else go := false;
         if go then
         begin
              rbResult.Clear;
              prRBError    := '';
              prBusy       := True;
              url          := 'http://jt65.w6cqz.org/rb.php?func=LO&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG) + '&rbversion=' + prVersion;
              prhttp.Timeout := 10000;  // 10K ms = 10 s
              prhttp.Headers.Add('Accept: text/html');
              Try
                 // This logs out the RB using parameters set in the object class
                 if not prHTTP.HTTPMethod('GET', url) Then
                 begin
                      prRBOn := False;
                      result := False;
                 end
                 else
                 begin
                      rbResult.LoadFromStream(prHTTP.Document);
                      // Messages RB login can return:
                      // QSL - All good, logged out.
                      // NO - Indicates logout failed. (Probably RB Server busy)
                      If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then prRBOn := false;
                      If TrimLeft(TrimRight(rbResult.Text)) = 'NO'  Then prRBOn := true;
                      prRBError := TrimLeft(TrimRight(rbresult.Text));
                 end;
              Except
                 prRBError := 'EXCEPTION';
                 prRBOn    := True;
              End;
              if prRBOn then result := false else result := true;
         end
         else
         begin
              prRBError := 'QRG';
              prRBOn    := false;
              result    := false;
         end;
         prBusy := False;
    end;

    function TSpot.loginPSKR : Boolean;
    Begin
         result := False;
         prRBOn := False;
    End;

    function TSpot.logoutPSKR : Boolean;
    Begin
         result := False;
         prPSKROn := False;
    end;

    function TSpot.pushSpots : Boolean;
    var
       url, foo  : String;
       i         : Integer;
       resolved  : Boolean;
       callheard : String;
       gridheard : String;
       band      : String;
       debugf    : TextFile;
       fname     : String;
       pskrerr   : WideString;
       pskrrep   : WideString;
       pskrloc   : WideString;
    Begin
         prRBError := '';
         band      := '';
         prBusy    := True;
         // This function handles sending spots to RB Network, PSK Reporter or Internal Database
         if prUseRB then
         begin
              // Do RB work
              for i := 0 to 4095 do
              begin
                   if not prSpots[i].rbsent then
                   begin
                        // OK.  Found an entry not marked as sent.  Is it something to send or not?
                        rbResult.Clear;
                        resolved  := false;
                        callheard := '';
                        gridheard := '';
                        if parseExchange(prSpots[i].exchange, callheard, gridheard) and prVal.evalIQRG(prSpots[i].qrg,'LAX',band) then
                        begin
{ TODO : Server code is not live... at this point it will always return QSL when called. }
                             url := synacode.EncodeURL('http://jt65.w6cqz.org/rb.php?func=RR&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prSpots[i].qrg) + '&rxtime=' + prSpots[i].time + '&rxdate=' + prSpots[i].date + '&callheard=' + callheard + '&gridheard=' + gridheard + '&siglevel=' + IntToStr(prSpots[i].db) + '&deltaf=' + IntToStr(prSpots[i].df) + '&deltat=' + floatToStrF(prSpots[i].dt,ffFixed,0,1) + '&decoder=' + prSpots[i].decoder + '&mode=' + prSpots[i].mode + '&exchange=' + prSpots[i].exchange + '&rbversion=' + prVersion);
                             //url := 'http://jt65.w6cqz.org/rb.php?func=RR&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prSpots[i].qrg) + '&rxtime=' + prSpots[i].time + '&rxdate=' + prSpots[i].date + '&callheard=' + callheard + '&gridheard=' + gridheard + '&siglevel=' + IntToStr(prSpots[i].db) + '&deltaf=' + IntToStr(prSpots[i].df) + '&deltat=' + floatToStrF(prSpots[i].dt,ffFixed,0,1) + '&decoder=' + prSpots[i].decoder + '&mode=' + prSpots[i].mode + '&rbversion=' + prVersion;

                             fname := 'C:\spotdebug.txt';
                             AssignFile(debugf, fname);
                             If FileExists(fname) Then Append(debugf) Else Rewrite(debugf);
                             writeln(debugf,'URL:  ' + url);
                             CloseFile(debugf);
                             Try
                                if prHTTP.HTTPMethod('GET', url) Then
                                begin
                                     rbResult.LoadFromStream(prHTTP.Document);
                                     // Messages RB login can return:
                                     // QSL - All good, spot saved.
                                     // NO - Indicates spot failed and safe to retry. (Probably RB Server busy)
                                     // ERR - Indicates RB Server has an issue with the data and not allowed to retry.
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then resolved := true;
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then inc(prRBCount);
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'NO'  Then resolved := false;
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'ERR' Then resolved := false;
                                     foo := TrimLeft(TrimRight(rbresult.Text));
                                end
                                else
                                begin
                                     //foo := 'EXCEPTION';
                                     resolved := False;
                                     result   := False;
                                end;
                             Except
                                foo := 'EXCEPTION';
                                resolved := false;
                             End;
                             if resolved then
                             begin
                                  result := true;
                                  prSpots[i].rbsent := true;
                                  inc(prRBCount);
                             end
                             else
                             begin
                                  if foo = 'NO' then prSpots[i].rbsent        := false;
                                  if foo = 'EXCEPTION' then prSpots[i].rbsent := false;
                                  if foo = 'ERR' then prSpots[i].rbsent       := true;
                             end;
                        end
                        else
                        begin
                             fname := 'C:\spotdebug.txt';
                             AssignFile(debugf, fname);
                             If FileExists(fname) Then Append(debugf) Else Rewrite(debugf);
                             writeln(debugf,'Failed exchange:  ' + prSpots[i].exchange);
                             CloseFile(debugf);
                             // Excahnge did not parse to something of use or qrg invalid.  Mark it sent so it can be cleared.
                             prSpots[i].rbsent   := true;
                             prSpots[i].pskrsent := true;
                        end;
                   end;
              end;
         end;
         if prUsePSKR then
         begin
              // Do PSKR work
              pskrstat := 0;
              if pskrstat = 0 then
              begin
                   for i := 0 to 4095 do
                   begin
                        if not prSpots[i].pskrsent then
                        begin
                             // OK.  Found an entry not marked as sent.  Is it something to send or not?
                             setlength(pskrerr,1025);
                             resolved  := false;
                             callheard := '';
                             gridheard := '';
                             if parseExchange(prSpots[i].exchange, callheard, gridheard) and prVal.evalIQRG(prSpots[i].qrg,'LAX',band) then
                             begin
                                  // Init was good, lets do some work
                                  //function TSpot.BuildRemoteString (call, mode, freq, date, time : String) : WideString;
                                  //function TSpot.BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
                                  //function TSpot.BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
                                  // BuildRemoteString     constructs the string for reporting to PSKR when a grid was not detected
                                  // BuildRemoteStringGrid constructs the string for reporting to PSKR when a grid was detected
                                  // BuildLocalString      constructs the string holding local information for station reporting to PSKR
{ TODO : Tie this to vairable rather than hard coded to my data! }
                                  pskrloc := BuildLocalString(prMyCall,prMyGrid,'JT65-HF','2000',prInfo);
                                  If not (gridheard='NILL') then
                                  begin
                                       pskrrep := BuildRemoteStringGrid(callheard,'JT65',IntToStr(prSpots[i].qrg),gridHeard,prSpots[i].date[1..8],prSpots[i].date[9..12]+'00');
                                       pskrstat := PSKReporter.ReporterSeenCallsign(pskrrep,pskrloc,PSKReporter.REPORTER_SOURCE_AUTOMATIC);
                                       resolved := true;
                                       foo := 'QSL';
                                  end
                                  else
                                  begin
                                       pskrrep := BuildRemoteString(callheard,'JT65',IntToStr(prSpots[i].qrg),prSpots[i].date[1..8],prSpots[i].date[9..12]+'00');
                                       pskrstat := PSKReporter.ReporterSeenCallsign(pskrrep,pskrloc,PSKReporter.REPORTER_SOURCE_AUTOMATIC);
                                       resolved := true;
                                       foo := 'QSL';
                                  end;
                                  result := true;
                                  prSpots[i].pskrsent := true;
                                  inc(prPRCount);
                             end;
                        end;
                   end;
              end;
         end;
         if prUseDBF then
         begin
              // Do Internal DB (dbf) work
         end;
         result := resolved;
         prBusy := False;
    end;

    function  TSpot.parseExchange(const exchange : String; var callheard : String; var gridheard : String) : Boolean;
    var
       w1,w2,w3  : String;
       w4,w5,w6  : String;
       resolved  : Boolean;
    Begin
         // I'm probably going to annoy some, but, as of 2.0.0 the RB/PSK Reporter
         // spots will only spot callsigns using JT65 frames that are strictly valid
         // in the sense of JT65 structured messages.
         // Those being:
         //
         // 2 Word frames
         //
         // CQ           PFX/CALLSIGN
         // CQ           CALLSIGN/SFX
         // QRZ          PFX/CALLSIGN
         // QRZ          CALLSIGN/SFX
         // CALLSIGN     PFX/CALLSIGN
         // CALLSIGN     CALLSIGN/SFX
         // PFX/CALLSIGN CALLSIGN
         // CALLSIGN/SFX CALLSIGN
         //
         // And I will allow the following messages that are not structured,
         // but, are safe enough to deal with in free text mode and not, in
         // general, abused.
         //
         // Non-structured 2 word frames
         //
         // TEST         CALLSIGN
         // CALLSIGN     TEST
         // CALLSIGN     GRID6
         // CALLSIGN     GRID4
         //
         // 3 Word frames
         //
         // CQ           CALLSIGN GRID
         // QRZ          CALLSIGN GRID
         // CALLSIGN     CALLSIGN GRID
         // CALLSIGN     CALLSIGN -##
         // CALLSIGN     CALLSIGN R-##
         // CALLSIGN     CALLSIGN RRR
         // CALLSIGN     CALLSIGN 73
         //
         // OK.  Those are what I'll allow.  This means stations using something
         // like CQ DX CALLSIGN or CQDX CALLSIGN or whatever of the endless things
         // people think to try will not be spotted.  Since the RB system is mine
         // I get to make the rules.  :)
         //
         //
         // If the word count is < 2 or > 3 then I'm not interested in trying
         // to extract anything from it.
         //
         resolved := false;
         result    := false;
         if (wordcount(exchange,[' ']) = 2) or (wordcount(exchange,[' ']) = 3) then resolved := true else resolved := false;
         if resolved then
         begin
              if(wordcount(exchange,[' ']) = 2) then
              begin
                   w1 := ExtractWord(1,exchange,[' ']);
                   w2 := ExtractWord(2,exchange,[' ']);
                   w3 := '   ';
              end;
              if(wordcount(exchange,[' ']) = 3) then
              begin
                   w1 := ExtractWord(1,exchange,[' ']);
                   w2 := ExtractWord(2,exchange,[' ']);
                   w3 := ExtractWord(3,exchange,[' ']);
              end;
         end;
         if resolved then
         begin
              // Have an exchange with 2 or 3 words so it is safe to proceed.
              // Evaluate excahnge for slashed callsign in a 3 word frame
              if (wordcount(exchange,[' '])=3) and (ansiContainsText(exchange,'/')) then resolved := false else resolved := true;
              if resolved then
              begin
                   // Passed the check for no slash in 3 word frame
                   // Doing the 3 word frame types first
                   resolved := false;
                   if not resolved and (w1='CQ') and prVal.evalCSign(w2) and prVal.evalGrid(w3) then
                   begin
                        // w1           w2       w3
                        // CQ           CALLSIGN GRID
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := w3;
                   end;
                   if not resolved and (w1='QRZ') and prVal.evalCSign(w2) and prVal.evalGrid(w3) then
                   begin
                        // w1           w2       w3
                        // QRZ          CALLSIGN GRID
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := w3;
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalCSign(w2) and prVal.evalGrid(w3) then
                   begin
                        // w1           w2       w3
                        // CALLSIGN     CALLSIGN GRID
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := w3;
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalCSign(w2) and (w3[1]='-') then
                   begin
                        // w1           w2       w3
                        // CALLSIGN     CALLSIGN -##
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalCSign(w2) and (w3[1]='R') then
                   begin
                        // w1           w2       w3
                        // CALLSIGN     CALLSIGN R-##
                        // CALLSIGN     CALLSIGN RRR
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalCSign(w2) and (w3[1]='7') then
                   begin
                        // w1           w2       w3
                        // CALLSIGN     CALLSIGN 73
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
              end;
              //
              // 3 word frames handled now on to 2 word frames
              //
              if not resolved then
              begin
                   if not resolved and (w1='TEST') and prVal.evalCSign(w2) and (w3 = '   ') then
                   begin
                        // w1           w2
                        // TEST         CALLSIGN
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
                   if not resolved and prVal.evalCSign(w1) and (w1='TEST') and (w3 = '   ') then
                   begin
                        // w1           w2
                        // CALLSIGN     TEST
                        resolved  := true;
                        result    := true;
                        callheard := w1;
                        gridheard := 'NILL';
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalGrid(w2) and (w3 = '   ') then
                   begin
                        // w1           w2
                        // CALLSIGN     GRID6
                        // CALLSIGN     GRID4
                        resolved  := true;
                        result    := true;
                        callheard := w1;
                        gridheard := w2;
                   end;
                   if not resolved and ((w1='CQ') or (w1='QRZ')) and prVal.evalCSign(w2) and (w3 = '   ') then
                   begin
                        { TODO : Case of exchange = QRZ CALLSIGN (with no grid) is being rejected.  Fix. }
                        { FIXED, I Think }
                        // w1           w2
                        // CQ           CALLSIGN
                        // QRZ          CALLSIGN
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
                   if not resolved and (ansiContainsText(w1,'/') or ansiContainsText(w2,'/')) then
                   begin
                        if not resolved and ((w1='CQ') or (w1='QRZ')) then
                        Begin
                             // The slash has to be in the second word...
                             if ansiContainsText(w2,'/') then
                             begin
                                  w4 := ExtractWord(1,w2,['/']);
                                  w5 := ExtractWord(2,w2,['/']);
                                  if length(w4) > length(w5) then w6 := w4;
                                  if length(w5) > length(w4) then w6 := w5;
                                  if prVal.evalCSign(w6) then
                                  begin
                                       // w1           w2
                                       // CQ           PFX/CALLSIGN
                                       // CQ           CALLSIGN/SFX
                                       // QRZ          PFX/CALLSIGN
                                       // QRZ          CALLSIGN/SFX
                                       resolved  := True;
                                       result    := true;
                                       callheard := w2;  // Remember, w2 contains the full callsign where w6 only contains the base call
                                       gridheard := 'NILL';
                                  end;
                             end;
                        end;
                        if not resolved and prVal.evalCSign(w1) then
                        begin
                             // w2 must be the slashed callsign
                             if ansiContainsText(w2,'/') then
                             begin
                                  w4 := ExtractWord(1,w2,['/']);
                                  w5 := ExtractWord(2,w2,['/']);
                                  if length(w4) > length(w5) then w6 := w4;
                                  if length(w5) > length(w4) then w6 := w5;
                                  if prVal.evalCSign(w6) then
                                  begin
                                       // w1           w2
                                       // CALLSIGN     PFX/CALLSIGN
                                       // CALLSIGN     CALLSIGN/SFX
                                       resolved  := True;
                                       result    := true;
                                       callheard := w2;  // Remember, w2 contains the full callsign where w6 only contains the base call
                                       gridheard := 'NILL';
                                  end;
                             end;
                        end;
                        if not resolved and prVal.evalCSign(w2) then
                        begin
                             // w1 must be the slashed callsign and it doesn't matter so this is easy
                             // w1           w2
                             // PFX/CALLSIGN CALLSIGN
                             // CALLSIGN/SFX CALLSIGN
                             resolved  := True;
                             result    := true;
                             callheard := w2;
                             gridheard := 'NILL';
                        end;
                   end;
              end;
         end;
    end;

    function TSpot.BuildRemoteString (call, mode, freq, date, time : String) : WideString;
    begin
         If freq='0' Then
            result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0
         else
            result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'freq' + #0 + freq + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0;
    end;

    function TSpot.BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
    begin
         If freq='0' Then
            result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'gridsquare' + #0 + grid + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0
         else
            result := 'call' + #0 + call + #0 + 'mode' + #0 + mode + #0 + 'freq' + #0 + freq + #0 + 'gridsquare' + #0 + 'QSO_DATE' + #0 + date + #0 + 'TIME_ON' + #0 + time + #0 + #0;
    end;

    function TSpot.BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
    begin
         result := 'station_callsign' + #0 + station_callsign + #0 + 'my_gridsquare' + #0 + my_gridsquare + #0 +
                   'programid' + #0 + programid + #0 +
                   'programversion' + #0 + programversion + #0 +
                   'my_antenna' + #0 + my_antenna + #0 + #0;
    end;

end.

