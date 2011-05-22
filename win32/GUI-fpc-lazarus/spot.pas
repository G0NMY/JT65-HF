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
  Classes, SysUtils, httpsend, valobject, StrUtils;

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
              prSpots   : spotsArray;
              prVal     : valobject.TValidator;
       public
             Constructor create();
             function addSpot(const spot : spotRecord) : Boolean;
             function loginRB    : Boolean;
             function loginPSKR  : Boolean;
             function logoutRB   : Boolean;
             function logoutPSKR : Boolean;
             function pushSpots  : Boolean;
             property myCall  : String
                read  prMyCall
                write prMyCall;
             property myGrid  : String
                read  prMyGrid
                write prMyGrid;
             property myQRG   : Integer
                read  prMyQRG
                write prMyQRG;
             property useOn   : Boolean
                read  prUseRB
                write prUseRB;
             property usePSKR : Boolean
                read  prUsePSKR
                write prUsePSKR;
             property useDBF  : Boolean
                read  prUseDBF
                write prUseDBF;
             property rbOn    : Boolean
                read  prRBOn;
             property pskrOn  : Boolean
                read  prPSKROn;
             property busy    : Boolean
                read  prBusy;
             property rbError : String
                read  prRBError;
       end;

implementation
    constructor TSpot.Create();
    var
       i : Integer;
    Begin
         prVal     := valobject.TValidator.create();
         prMyCall  := '';
         prMyGrid  := '';
         prMyQRG   := 0;
         prUseRB   := false;
         prUsePSKR := False;
         prUseDBF  := False;
         prRBOn    := False;
         prRBError := '';
         prPSKROn  := False;
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
    End;

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
       http     : THTTPSend;
       rbResult : TStringList;
    Begin
         prRBError    := '';
         prBusy       := True;
         http         := THTTPSend.Create;
         url          := 'http://jt65.w6cqz.org/rb.php?func=LI&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG);
         http.Timeout := 10000;  // 10K ms = 10 s
         http.Headers.Add('Accept: text/html');
         Try
            // This logs in to the RB System using parameters set in the object class
            if not HTTP.HTTPMethod('GET', url) Then
            begin
                 prRBOn := False;
                 result := False;
            end
            else
            begin
                 rbResult := TStringList.Create;
                 rbResult.Clear;
                 rbResult.LoadFromStream(HTTP.Document);
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
                 rbResult.Free;
            end;
            HTTP.Free;
         Except
            HTTP.Free;
            prRBError := 'EXCEPTION';
            prRBOn    := False;
         End;
         result := prRBOn;
         prBusy := False;
    end;

    function TSpot.logoutRB : Boolean;
    var
       url      : String;
       http     : THTTPSend;
       rbResult : TStringList;
    Begin
         prRBError    := '';
         prBusy       := True;
         http         := THTTPSend.Create;
         url          := 'http://jt65.w6cqz.org/rb.php?func=LO&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG);
         http.Timeout := 10000;  // 10K ms = 10 s
         http.Headers.Add('Accept: text/html');
         Try
            // This logs in to the RB System using parameters set in the object class
            if not HTTP.HTTPMethod('GET', url) Then
            begin
                 prRBOn := False;
                 result := False;
            end
            else
            begin
                 rbResult := TStringList.Create;
                 rbResult.Clear;
                 rbResult.LoadFromStream(HTTP.Document);
                 // Messages RB login can return:
                 // QSL - All good, logged out.
                 // NO - Indicates logout failed. (Probably RB Server busy)
                 If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then prRBOn := false;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'NO'  Then prRBOn := true;
                 prRBError := TrimLeft(TrimRight(rbresult.Text));
                 rbResult.Free;
            end;
            HTTP.Free;
         Except
            HTTP.Free;
            prRBError := 'EXCEPTION';
            prRBOn    := True;
         End;
         if prRBOn then result := false else result := true;
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
       http      : THTTPSend;
       rbResult  : TStringList;
       i, wc     : Integer;
       w1,w2,w3  : String;
       w4,w5     : String;
       resolved  : Boolean;
       callheard : String;
       gridheard : String;
    Begin
         prRBError    := '';
         prBusy       := True;
         // This function handles sending spots to RB Network, PSK Reporter or Internal Database
         if prUseRB then
         begin
              // Do RB work
              http         := THTTPSend.Create;
              http.Timeout := 10000;  // 10K ms = 10 s
              http.Headers.Add('Accept: text/html');
              for i := 0 to 4095 do
              begin
                   if not prSpots[i].rbsent then
                   begin
                        // Found an entry that hasn't been sent
                        // First thing is to parse the exchange field
                        // Now... exchanges.  The following forms are the only ones I'm interested in.
                        // CQ CALL GRID
                        // QRZ CALL GRID
                        // CQ PFX/CALL
                        // CQ CALL/SFX
                        // CQ DX CALL
                        // CQDX CALL
                        // TEST CALL
                        // CALL TEST
                        // CALL CALL
                        // CALL GRID
                        // CALL CALL GRID
                        // CALL CALL -##
                        // CALL CALL R-##
                        // CALL CALL RRR
                        // CALL CALL 73
                        // And that's it.  If it doesn't fit one of those it doesn't exist.
                        // The methodology for this is to break the exchange into a set of 2 or 3 words
                        // using space character as boundary.  It's clear that to resolve the first word
                        // must be CQ, QRZ, CQDZ, TEST or a valid (by JT65 encoding rules) callsign.
                        // The second word depends upon the first and the third depends upon the first and second.
                        // First get a word count
                        w1 := '';
                        w2 := '';
                        w3 := '';
                        wc := 0;
                        wc := wordCount(prSpots[i].exchange,[' ']);
                        if (wc<2) or (wc>3) then wc := 0;
                        resolved := false;
                        if wc>0 then
                        begin
                             // Ok... I have 2 or 3 words.  Let the fun begin
                             resolved := false;
                             if wc = 2 then
                             begin
                                  resolved := false;
                                  callheard := '';
                                  gridheard := '';
                                  // For wc=2 It must be...
                                  // CQ PFX/CALL      x
                                  // CQ CALL/SFX      x
                                  // CQDX CALL        x
                                  // TEST CALL        x
                                  // CALL TEST        x
                                  // CALL CALL        x
                                  // CALL GRID        x
                                  w1 := ExtractWord(1,prSpots[i].exchange,[' ']);
                                  w2 := ExtractWord(2,prSpots[i].exchange,[' ']);
                                  if prVal.evalCSign(w1) Then
                                  begin
                                       // w1 is a callsign
                                       if w2 = 'TEST' then
                                       begin
                                            // CALL TEST
                                            callheard := w1;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                       if prVal.evalGrid(w2) then
                                       begin
                                            // CALL GRID
                                            callheard := w1;
                                            gridheard := w2;
                                            resolved  := true;
                                       end;
                                       if prVal.evalCSign(w2) then
                                       begin
                                            // CALL CALL
                                            callheard := w2;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                  end;
                                  if w1 = 'CQ' then
                                  begin
                                       // w1 is CQ
                                       // Now this is a special case in that
                                       // I 'SHOULD' have something like CQ PFX/CALL or CQ CALL/SFX
                                       // but, I could have a CQ CALL if someone uses an improper
                                       // message configuration.
                                       // Check for /
                                       if AnsiContainsText(w2,'/') then
                                       begin
                                            // w2 is a string with /
                                            w4 := '';
                                            w5 := '';
                                            w4 := ExtractWord(1,w2,['/']);
                                            w5 := ExtractWord(2,w2,['/']);
                                            // I'm going to assume the longer of the 2 (w4,w5) will
                                            // be the callsign with the shorter being prefix/suffix.
                                            // Will this always be right?  No, but, it'll do as I'm
                                            // not a big fan of using prefix/suffix with JT65 in the
                                            // first place.  :)
                                            if length(w4) > length(w5) then
                                            begin
                                                 // w4 should be the call
                                                 if prVal.evalCSign(w4) then
                                                 begin
                                                      callheard := w2;  // Yes, w2.  :)  I want to spot the callsign with suffix/prefix
                                                      gridheard := 'NILL';
                                                      resolved  := true;
                                                 end;
                                            end;
                                            if length(w5) > length(w4) then
                                            begin
                                                 // w5 should be the call
                                                 // CQ PFX/CALL
                                                 callheard := w2;  // Yes, w2.  :)  I want to spot the callsign with suffix/prefix
                                                 gridheard := 'NILL';
                                                 resolved  := true;
                                            end;

                                       end
                                       else
                                       begin
                                            if prVal.evalCSign(w2) then
                                            begin
                                                 // CQ CALL/SFX
                                                 callheard := w2;
                                                 gridheard := 'NILL';
                                                 resolved  := true;
                                            end;
                                       end;
                                  end;
                                  if w1 = 'CQDX' then
                                  begin
                                       // w1 is CQDX
                                       if prVal.evalCSign(w2) then
                                       begin
                                            // CQDX CALL
                                            callheard := w2;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                  end;
                                  if w1 = 'TEST' then
                                  begin
                                       // w1 is TEST
                                       if prVal.evalCSign(w2) then
                                       begin
                                            // TEST CALL
                                            callheard := w2;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                  end;
                             end;

                             if wc = 3 then
                             begin
                                  callheard := '';
                                  gridheard := '';
                                  resolved  := false;
                                  // For wc=3 It must be...
                                  // CQ CALL GRID          x
                                  // QRZ CALL GRID         x
                                  // CQ DX CALL            x
                                  // CALL CALL GRID        x
                                  // CALL CALL -##         x
                                  // CALL CALL R-##        x
                                  // CALL CALL RRR         x
                                  // CALL CALL 73          x
                                  w1 := ExtractWord(1,prSpots[i].exchange,[' ']);
                                  w2 := ExtractWord(2,prSpots[i].exchange,[' ']);
                                  w3 := ExtractWord(3,prSpots[i].exchange,[' ']);
                                  if w1 = 'CQ' Then
                                  begin
                                       // This will be CQ CALL GRID or CQ DX CALL
                                       if prVal.evalCSign(w2) and prVal.evalGrid(w3) then
                                       begin
                                            // A nice standard CQ message
                                            callheard := w2;
                                            gridheard := w3;
                                            resolved  := true;
                                       end;
                                       if not prVal.evalCSign(w2) and prVal.evalCSign(w3) then
                                       begin
                                            // A CQ some crap CALLSIGN
                                            callheard := w3;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                  end;
                                  if w1 = 'QRZ' then
                                  begin
                                       // This should be QRZ CALL GRID
                                       if prVal.evalCSign(w2) and prVal.evalGrid(w3) then
                                       begin
                                            callheard := w2;
                                            gridheard := w3;
                                            resolved  := true;
                                       end;
                                       if prVal.evalCSign(w2) and not prVal.evalGrid(w3) then
                                       begin
                                            callheard := w2;
                                            gridheard := 'NILL';
                                            resolved  := true;
                                       end;
                                  end;
                                  // Now handling the various CALL CALL SOMETHING forms
                                  if prVal.evalCSign(w1) and prVal.evalCSign(w2) and prVal.evalGrid(w3) Then
                                  Begin
                                       callheard := w2;  // Yes, w2.  w1 is not the transmitting callsign.
                                       gridheard := w3;
                                       resolved  := true;
                                  end;
                                  if prVal.evalCSign(w1) and prVal.evalCSign(w3) and not prVal.evalGrid(w3) Then
                                  begin
                                       callheard := w2;
                                       gridheard := 'NILL';
                                       resolved  := true;
                                  end;
                             end;
                        end
                        else
                        begin
                             resolved := false;
                        end;
                        // OK.  Parsing complete.  Did I get something?
                        if resolved then
                        begin
                             url := 'http://jt65.w6cqz.org/rb.php?func=RR&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG) + '&rxtime=' + prSpots[i].time + '&rxdate=' + prSpots[i].date + '&callheard=' + callheard + '&gridheard=' + gridheard + '&siglevel=' + IntToStr(prSpots[i].db) + '&deltaf=' + IntToStr(prSpots[i].df) + '&deltat=' + floatToStrF(prSpots[i].dt,ffFixed,0,1) + '&decoder=' + prSpots[i].decoder + '&mode=' + prSpots[i].mode + '&exchange=' + prSpots[i].exchange + '&rbversion=' + '2000';
                             Try
                                // This logs in to the RB System using parameters set in the object class
                                if not HTTP.HTTPMethod('GET', url) Then
                                begin
                                     resolved := False;
                                     result   := False;
                                end
                                else
                                begin
                                     rbResult := TStringList.Create;
                                     rbResult.Clear;
                                     rbResult.LoadFromStream(HTTP.Document);
                                     // Messages RB login can return:
                                     // QSL - All good, spot saved.
                                     // NO - Indicates spot failed and safe to retry. (Probably RB Server busy)
                                     // ERR - Indicates RB Server has an issue with the data and not allowed to retry.
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then resolved := true;
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'NO'  Then resolved := false;
                                     If TrimLeft(TrimRight(rbResult.Text)) = 'ERR' Then resolved := false;
                                     foo := TrimLeft(TrimRight(rbresult.Text));
                                     rbResult.Free;
                                end;
                                HTTP.Free;
                             Except
                                HTTP.Free;
                                foo := 'EXCEPTION';
                                resolved := false;
                             End;
                             if resolved then
                             begin
                                  result := true;
                                  prSpots[i].rbsent := true;
                             end
                             else
                             begin
                                  if foo = 'NO' then prSpots[i].rbsent        := false;
                                  if foo = 'EXCEPTION' then prSpots[i].rbsent := false;
                                  if foo = 'ERR' then prSpots[i].rbsent       := true;
                             end;
                        end;
                   end;
              end;
         end;
         if prUsePSKR then
         begin
              // Do PSKR work
         end;
         if prUseDBF then
         begin
              // Do Internal DB (dbf) work
         end;
         result := resolved;
         prBusy := False;
    end;

end.

