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
  Classes, SysUtils, httpsend, synacode, valobject, StrUtils, CTypes,
  PSKReporter, DateUtils, Windows;

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
      dbfsent  : Boolean;
    end;

    spotsArray = Array of spotRecord;

    spotDBRec  = record
      callsign : Array[0..16] of Char;
      grid1    : Array[0..6] of Char;
      grid2    : Array[0..6] of Char;
      grid3    : Array[0..6] of Char;
      grid4    : Array[0..6] of Char;
      count    : CTypes.cuint32;
      first    : TDateTime;
      last     : TDateTime;
      b160     : Boolean;
      b80      : Boolean;
      b40      : Boolean;
      b30      : Boolean;
      b20      : Boolean;
      b17      : Boolean;
      b15      : Boolean;
      b12      : Boolean;
      b10      : Boolean;
      b6       : Boolean;
      b2       : Boolean;
      wb160    : Boolean;
      wb80     : Boolean;
      wb40     : Boolean;
      wb30     : Boolean;
      wb20     : Boolean;
      wb17     : Boolean;
      wb15     : Boolean;
      wb12     : Boolean;
      wb10     : Boolean;
      wb6      : Boolean;
      wb2      : Boolean;
    end;

    spotDB     = File Of spotDBRec;

    spotDBIdx  = Record
      id       : CTypes.cuint32;
      callsign : Array[0..16] of Char;
    end;

    spotIDX    = File of spotDBIdx;

    // Encapsulates all the possible spotting methods to a single unified interface.
    // Handles (for now) RB and PSKR spotting.
    TSpot = Class
       private
              // Control values
              prMyCall      : String;
              prMyGrid      : String;
              prMyQRG       : Integer;
              prUseRB       : Boolean;
              prUsePSKR     : Boolean;
              prUseDBF      : Boolean;
              prRBOn        : Boolean;
              prRBError     : String;
              prPSKROn      : Boolean;
              prBusy        : Boolean;
              prVersion     : String;
              prSpots       : spotsArray;
              prVal         : valobject.TValidator;
              prRBCount     : CTypes.cuint64;
              prRBFail      : CTypes.cuint64;
              prRBDiscard   : CTypes.cuint64;
              prPRCount     : CTypes.cuint64;
              prDBFCount    : CTypes.cuint64;
              prDBFUCount   : CTypes.cuint64;
              prDBLock      : Boolean;
              pskrStats     : PSKReporter.REPORTER_STATISTICS;
              pskrstat      : DWORD;
              prInfo        : String;
              prLogDir      : String;
              prErrDir      : String;
              prhttp        : THTTPSend;
              rbResult      : TStringList;
              // Private functions to format data for PSK Reporter
              function BuildRemoteString (call, mode, freq, date, time : String) : WideString;
              function BuildRemoteStringGrid (call, mode, freq, grid, date, time : String) : WideString;
              function BuildLocalString (station_callsign, my_gridsquare, programid, programversion, my_antenna : String) : WideString;
              // Private function to parse exchange text for RB/PSKR
              function parseExchange(const exchange : String; var callheard : String; var gridheard : String) : Boolean;
              // Private functions for internal DB handling
              procedure dbCallsign(const str : String; var dbstr : Array of Char);
              procedure dbGrid(const str : String; var dbstr : Array of Char);
              procedure callsignDB(const db : Array of Char; var str : String);
              procedure gridDB(const db : Array of Char; var str : String);
              function  createDB : Boolean;
              function  addToDB(const callsign : String; const grid : String; const band : String; const wband : String) : Boolean;

       public
             Constructor create;
             Destructor  endspots;
             function    addSpot(const spot : spotRecord) : Boolean;
             function    loginRB    : Boolean;
             function    loginPSKR  : Boolean;
             function    logoutRB   : Boolean;
             function    logoutPSKR : Boolean;
             function    pushSpots  : Boolean;
             function    RBCountS   : String;
             function    RBFailS    : String;
             function    RBDiscardS : String;
             function    PRcountS   : String;
             function    DBFcountS  : String;
             function    DBFUcountS : String;
             function    pskrTickle : DWORD;
             // Public db functions
             function findDB(const callsign : String) : CTypes.cuint32;
             function getDBREC(rec : CTypes.cuint32) : SpotDBRec;
             function getDBAll(const callsign : String; var g1,g2,g3,g4 : String; var count : CTypes.cuint32; var first, last : TDateTime;
                               var b160,b80,b40,b30,b20,b17,b15,b12,b10,b6,b2,wb160,wb80,wb40,wb30,wb20,wb17,wb15,wb12,wb10,wb6,wb2 : Boolean) : Boolean;
             function getDB(const callsign : String; var ret : String) : Boolean;
             function dbToCSV(const fname : String) : Boolean;

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
             property rbDiscard : String
                read  rbDiscardS;
             property rbFail    : String
                read  RBFailS;
             property pskrCount : String
                read  PRCountS;
             property dbfCount  : String
                read  DBFCountS;
             property dbfUCount : String
                read  DBFUCountS;
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
             property logDir : String
                read  prLogDir
                write prLogDir;
             property errDir : String
                read  prErrDir
                write prErrDir;
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
         prMyCall    := '';
         prMyGrid    := '';
         prMyQRG     := 0;
         prUseRB     := false;
         prUsePSKR   := False;
         prUseDBF    := False;
         prRBOn      := False;
         prRBError   := '';
         prPSKROn    := False;
         prVersion   := '2000';
         prRBCount   := 0;
         prPRCount   := 0;
         prRBFail    := 0;
         prDBFCount  := 0;
         prDBFUCount := 0;
         prRBDiscard := 0;
         prDBLock    := False;
         prInfo      := '';
         prLogDir    := '';
         prErrDir    := '';
         setlength(prSpots,8192);
         for i := 0 to 8191 do
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
              prspots[i].dbfsent  := true;
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
         pskrstat := 1;
    End;

    Destructor TSpot.endspots;
    Begin
         prHTTP.Free;                       // Release HTTP object
         PSKReporter.ReporterUninitialize;  // Release PSK Reporter
         setlength(prSpots,0);              // Free spots array
    end;

    // Some background on the database and why I'm doing it this way....
    // Lazarus and FPC have several formal database routines along with various
    // data aware controls.  DB methods range from simple in memory DB all the
    // way up to using complex SQL systems like MySQL.  After looking at all the
    // options I came to the conclusion that no built in option really offer what
    // I'm looking for.  Thus rolling my own.
    // Back in the 1980s I wrote a primitive DB system that ran on a 8086 DOS
    // platform using Turbo Pascal and, believe it or not, what I need to do here
    // is similar in its requirements.  So, unlike way back when, I choose to do
    // this rather than be forced to do it as I was before... after all.. back
    // then there were no built in DB functions to TP.  :)

    // Database record format
    {
    spotDBRec  = record
      callsign : Array[0..16] of Char;
      grid1    : Array[0..6] of Char;
      grid2    : Array[0..6] of Char;
      grid3    : Array[0..6] of Char;
      grid4    : Array[0..6] of Char;
      count    : CTypes.cuint32;
      first    : TDateTime;
      last     : TDateTime;
      b160     : Boolean;
      b80      : Boolean;
      b40      : Boolean;
      b30      : Boolean;
      b20      : Boolean;
      b17      : Boolean;
      b15      : Boolean;
      b12      : Boolean;
      b10      : Boolean;
      b6       : Boolean;
      b2       : Boolean;
      wb160    : Boolean;
      wb80     : Boolean;
      wb40     : Boolean;
      wb30     : Boolean;
      wb20     : Boolean;
      wb17     : Boolean;
      wb15     : Boolean;
      wb12     : Boolean;
      wb10     : Boolean;
      wb6      : Boolean;
      wb2      : Boolean;
    end;

    spotDB     = File Of spotDBRec;

    spotDBIdx  = Record
      id       : CTypes.cuint32;
      callsign : Array[0..16] of Char;
    end;

    spotIDX    = File of spotDBIdx;
    }
    // The record format should be reasonably self explanatory except for, maybe,
    // gridX entries and the b##/wb##.  grid# alows recording having heard a
    // callsign in up to 4 grids.  The b# booleans indicate having heard
    // the referenced callsign on the 160 ... 2 M bands.  wb# will eventually
    // tie to the logging function to record having worked referenced callsign
    // on a specific band.
    //
    // Each entry to the database is via a spotDBRec record.  The process is to
    // examing the index file for presence of the callsign to add and, if found,
    // update the existing entry or create a new entry if not.

    procedure TSpot.dbCallsign(const str : String; var dbstr : Array of Char);
    var
       i,ii : Byte;
    begin
         // Takes string in str and places in dbstr array (Array[0..16] of Char)
         for i := 0 to 16 do
         begin
              dbstr[i] := chr(0);
         end;
         ii := Length(str);
         if ii > 16 then ii := 16;
         dbstr[0] := chr(ii);
         for i := 1 to ii do
         begin
              dbstr[i] := str[i];
         end;
    end;

    procedure TSpot.dbGrid(const str : String; var dbstr : Array of Char);
    var
       i,ii : Byte;
    begin
         // Takes string in str and places in dbstr array (Array[0..6] of Char)
         for i := 0 to 6 do
         begin
              dbstr[i] := chr(0);
         end;
         ii := Length(str);
         if ii > 6 then ii := 6;
         dbstr[0] := chr(ii);
         for i := 1 to ii do
         begin
              dbstr[i] := str[i];
         end;
    end;

    procedure TSpot.callsignDB(const db : Array of Char; var str : String);
    var
       i : Byte;
    begin
         // Takes a db record array (string) and converts to string
         // returns empty string on error
         str := '';
         i := ord(db[0]);
         if i < 17 then
         begin
              for i := 1 to ord(db[0]) do
              begin
                   str := str + db[i];
              end;
         end
         else
         begin
              str := '';
         end;
    end;

    procedure TSpot.gridDB(const db : Array of Char; var str : String);
    var
       i : Byte;
    begin
         // Takes a db record array (string) and converts to string
         // returns empty string on error
         str := '';
         i := ord(db[0]);
         if i < 7 then
         begin
              for i := 1 to ord(db[0]) do
              begin
                   str[i] := db[i];
              end;
         end
         else
         begin
              str := '';
         end;
    end;

    function TSpot.createDB : Boolean;
    var
       sp : SpotDBRec;
       id : SpotDBIdx;
       fn : String;
       f1 : SpotDB;
       f2 : SpotIDX;
    begin
         // Creates DB and its index files
         if not fileExists(prLogDir + 'jt65hf.db') then
         begin
              fn := prLogDir + 'jt65hf.db';
              AssignFile(f1, fn);
              Rewrite(f1);
              seek(f1,0);
              dbCallsign('KC4NGO',sp.callsign);
              dbGrid('NILL',sp.grid1);
              dbGrid('NILL',sp.grid2);
              dbGrid('NILL',sp.grid3);
              dbGrid('NILL',sp.grid4);
              sp.count := 47;
              if not TryEncodeDateTime(1963,7,3,0,0,0,0,sp.first) then sp.first := now;
              sp.last  := Now;
              sp.b160  := True;
              sp.wb160 := True;
              sp.b80   := True;
              sp.wb80  := True;
              sp.b40   := True;
              sp.wb40  := True;
              sp.b30   := True;
              sp.wb30  := True;
              sp.b20   := True;
              sp.wb20  := True;
              sp.b17   := True;
              sp.wb17  := True;
              sp.b15   := True;
              sp.wb15  := True;
              sp.b12   := True;
              sp.wb12  := True;
              sp.b10   := True;
              sp.wb10  := True;
              sp.b6    := True;
              sp.wb6   := True;
              sp.b2    := True;
              sp.wb2   := True;
              write(f1,sp);
              CloseFile(f1);
         end;
         if not fileExists(prLogDir + 'jt65hf.id') then
         begin
              id.id := 0;
              dbCallsign('KC4NGO',id.callsign);
              fn := prLogDir + 'jt65hf.id';
              AssignFile(f2, fn);
              Rewrite(f2);
              seek(f2,0);
              write(f2,id);
              CloseFile(f2);
         end;
         result := true;
    end;

    function TSpot.dbToCSV(const fname : String) : Boolean;
    var
       go  : Boolean;
       foo : String;
       csv : String;
       fn  : TextFile;
       sp  : SpotDBRec;
       f1  : SpotDB;
       res : Boolean;
       i,j : CTypes.cuint32;
    begin
         go  := False;
         res := False;
         while prDBLock do
         begin
              // If DB is locked I wait a reasonable time for it to unlock.
              // If it does not become available I move on to other things.
              for i := 1 to 100 do
              begin
                   sleep(20);
              end;
         end;
         if prDBLock then go := false else go := true;
         if go then prDBLock := True;
         if go then
         begin
              // Lock achieved, export records.
              if fileExists(prLogDir + 'jt65hf.db') then go := true else go := false;
              if not (trimleft(trimright(fname)) = '') then foo := fname else foo := prLogDir + 'jt65hfdb.csv';
              if go then
              begin
                   AssignFile(fn, foo);
                   Rewrite(fn);
                   WriteLn(fn,'"ID","Callsign","Grid1","Grid2","Grid3","Grid4","Count","YYYY-MM-DD","HH:MM","YYYY-MM-DD","HH:MM","B160","B80","B40","B30","B20","B17","B15","B12","B10","B6","B2","WB160","WB80","WB40","WB30","WB20","WB17","WB15","WB12","WB10","WB6","WB2"');
                   // Loop the DB and export
                   AssignFile(f1, prLogDir + 'jt65hf.db');
                   Reset(f1);
                   seek(f1,1);  // Skipping record 0 the initial 'dummy' record
                   i := 1;
                   while not EOF(f1) do
                   begin
                        csv := '';
                        foo := '';
                        csv := csv + '"' + intToStr(i) + '",';  // Record number
                        read(f1,sp);  // Read record
                        // Translate record data to string for CSV
                        // Callsign
                        for j := 1 to 16 do
                        begin
                             foo := foo + sp.callsign[j];
                        end;
                        csv := csv + '"' + trimleft(trimright(foo)) + '",'; // Callsign
                        // Grid 1
                        foo := '';
                        for j := 1 to 6 do
                        begin
                             foo := foo + sp.grid1[j];
                        end;
                        foo := trimleft(trimright(foo));
                        if foo = 'NILL' then foo := '';
                        csv := csv + '"' + foo + '",'; // Grid 1
                        // Grid 2
                        foo := '';
                        for j := 1 to 6 do
                        begin
                             foo := foo + sp.grid2[j];
                        end;
                        foo := trimleft(trimright(foo));
                        if foo = 'NILL' then foo := '';
                        csv := csv + '"' + foo + '",'; // Grid 2
                        // Grid 3
                        foo := '';
                        for j := 1 to 6 do
                        begin
                             foo := foo + sp.grid3[j];
                        end;
                        foo := trimleft(trimright(foo));
                        if foo = 'NILL' then foo := '';
                        csv := csv + '"' + foo + '",'; // Grid 3
                        // Grid 4
                        foo := '';
                        for j := 1 to 6 do
                        begin
                             foo := foo + sp.grid4[j];
                        end;
                        foo := trimleft(trimright(foo));
                        if foo = 'NILL' then foo := '';
                        csv := csv + '"' + foo + '",'; // Grid 4
                        // Count
                        csv := csv + '"' + intTostr(sp.count) + '",'; // Count
                        // First heard date (YYYY-MM-DD)
                        csv := csv + '"' + FormatDateTime('yyyy-mm-dd',sp.first) + '",'; // First date
                        // First heard time (HH:MM)
                        csv := csv + '"' + FormatDateTime('hh:nn',sp.first) + '",'; // First time
                        // Last heard date (YYYY-MM-DD)
                        csv := csv + '"' + FormatDateTime('yyyy-mm-dd',sp.last) + '",'; // First date
                        // Last heard time (HH:MM)
                        csv := csv + '"' + FormatDateTime('hh:nn',sp.last) + '",'; // First time
                        if sp.b160 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b80 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b40 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b30 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b20 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b17 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b15 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b12 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b10 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b6 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.b2 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb160 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb80 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb40 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb30 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb20 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb17 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb15 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb12 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb10 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb6 then csv := csv + '"T",' else csv := csv + '"F",';
                        if sp.wb2 then csv := csv + '"T"' else csv := csv + '"F"';
                        WriteLn(fn,csv);
                        inc(i);
                   end;
                   closeFile(f1);
                   CloseFile(fn);
                   res := true;
              end
              else
              begin
                   res := False;
              end;
         end
         else
         begin
              // Could not achieve lock or db not present or no records, bailing out.
              result := res;
         end;
         prDBLock := False;
    end;

    function TSpot.addToDB(const callsign : String; const grid : String; const band : String; const wband : String) : Boolean;
    var
       idx, idy    : CTypes.cuint32;
       fn          : String;
       sp          : SpotDBRec;
       id          : SpotDBIdx;
       go, g       : Boolean;
       g1,g2,g3,g4 : String;
       t           : String;
       g1set,g2set : Boolean;
       g3set,g4set : Boolean;
       gfull       : Boolean;
       same        : Boolean;
       f1          : SpotDB;
       f2          : SpotIDX;
       i           : Integer;
       st          : TSystemTime;
    begin
         go := False;
         while prDBLock do
         begin
              // If DB is locked I wait a reasonable time for it to unlock.
              // If it does not become available I move on to other things.
              for i := 1 to 100 do
              begin
                   sleep(20);
              end;
         end;
         if prDBLock then go := false else go := true;
         if go then prDBLock := True;
         g1 := '';
         g2 := '';
         g3 := '';
         g4 := '';
         st.Hour := 0;
         result := false;
         // First attempt to find the callsign in the idx
         if go then
         begin
              idx := findDB(upcase(callsign));
              if idx > 0 then
              begin
                   // Found callsign, doing update
                   // Read in existing record
                   sp := getDBREC(idx);
                   inc(sp.count);  // Increment heard count
                   GetSystemTime(st);
                   sp.Last := SystemTimeToDateTime(st); // Update last heard time... This sets to current UTC time
                   // Update band markers
                   if band = '160' then sp.b160 := true;
                   if band = '080' then sp.b80  := true;
                   if band = '040' then sp.b40  := true;
                   if band = '030' then sp.b30  := true;
                   if band = '020' then sp.b20  := true;
                   if band = '017' then sp.b17  := true;
                   if band = '015' then sp.b15  := true;
                   if band = '012' then sp.b12  := true;
                   if band = '010' then sp.b10  := true;
                   if band = '006' then sp.b6   := true;
                   if band = '002' then sp.b2   := true;
                   // Update worked band markers
                   if wband = '160' then sp.wb160 := true;
                   if wband = '080' then sp.wb80  := true;
                   if wband = '040' then sp.wb40  := true;
                   if wband = '030' then sp.wb30  := true;
                   if wband = '020' then sp.wb20  := true;
                   if wband = '017' then sp.wb17  := true;
                   if wband = '015' then sp.wb15  := true;
                   if wband = '012' then sp.wb12  := true;
                   if wband = '010' then sp.wb10  := true;
                   if wband = '006' then sp.wb6   := true;
                   if wband = '002' then sp.wb2   := true;
                   // Convert DB grid entries to string
                   g1 := '';
                   g2 := '';
                   g3 := '';
                   g4 := '';
                   g1set := false;
                   g2set := false;
                   g3set := false;
                   g4set := false;
                   for i := 1 to 6 do
                   begin
                        g1 := g1 + sp.grid1[i];
                        g2 := g2 + sp.grid2[i];
                        g3 := g3 + sp.grid3[i];
                        g4 := g4 + sp.grid4[i];
                   end;
                   // This is so annoying, but necessary since a direct compare
                   // between g# and other var or literal string always resolves
                   // FALSE.  It's probably some typecasting issue (most likely
                   // an error on MY part) or (less likely) an FPC bug. SO....
                   // First check to see if the currently reported grid = 'NILL'
                   t := 'NILL';
                   g := false;
                   for i := 1 to length(grid) do
                   begin
                        if t[i] = grid[i] then g := false else g := true;  // Remember, I'm looking to see if grid = 'NILL'
                   end;
                   if g then
                   begin
                        // reported grid != 'Nill'  Look for an "empty" slot
                        if grid = 'NILL' Then
                        t := 'NILL';
                        same := false;
                        for i := 1 to length(t) do
                        begin
                             if t[i] = g1[i] then same := true else same := false;
                        end;
                        if same then g1Set := false else g1Set := true;
                        t := 'NILL';
                        same := false;
                        for i := 1 to length(t) do
                        begin
                             if t[i] = g2[i] then same := true else same := false;
                        end;
                        if same then g2Set := false else g2Set := true;
                        t := 'NILL';
                        same := false;
                        for i := 1 to length(t) do
                        begin
                             if t[i] = g3[i] then same := true else same := false;
                        end;
                        if same then g3Set := false else g3Set := true;
                        t := 'NILL';
                        same := false;
                        for i := 1 to length(t) do
                        begin
                             if t[i] = g4[i] then same := true else same := false;
                        end;
                        if same then g4Set := false else g4Set := true;
                        gfull := False;
                        if g1set and g2set and g3set and g4set then gfull := true else gfull := false;
                        if not gfull then
                        begin
                             // Have a spot lets does it need to be filled?  Look to see if g# is
                             // already set = grid
                             // Is current grid same as grid1?
                             same := false;
                             for i := 1 to length(grid) do
                             begin
                                  if grid[i] = sp.grid1[i] then same := true else same := false;
                             end;
                             // Is current grid same as grid2?
                             if not same then
                             begin
                                  same := false;
                                  for i := 1 to length(grid) do
                                  begin
                                       if grid[i] = sp.grid2[i] then same := true else same := false;
                                  end;
                             end;
                             // Is current grid same as grid3?
                             if not same then
                             begin
                                  same := false;
                                  for i := 1 to length(grid) do
                                  begin
                                       if grid[i] = sp.grid3[i] then same := true else same := false;
                                  end;
                             end;
                             // Is current grid same as grid4?
                             if not same then
                             begin
                                  same := false;
                                  for i := 1 to length(grid) do
                                  begin
                                       if grid[i] = sp.grid4[i] then same := true else same := false;
                                  end;
                             end;
                             if not same then
                             begin
                                  // Grid does match any known entry in record, stuff it
                                  // in first available spot and be done with this mess.
                                  same := false;  // Recycle same for now
                                  if not same and not g1Set then
                                  begin
                                       // Grid1 is empty (or 'NILL') so shove it
                                       i := length(grid);
                                       sp.grid1[0] := chr(i);
                                       for i := 1 to length(grid) do
                                       begin
                                            sp.grid1[i] := grid[i];
                                       end;
                                       same := true;
                                  end;
                                  if not same and not g2Set then
                                  begin
                                       // Grid2 is empty (or 'NILL') so shove it
                                       i := length(grid);
                                       sp.grid2[0] := chr(i);
                                       for i := 1 to length(grid) do
                                       begin
                                            sp.grid2[i] := grid[i];
                                       end;
                                       same := true;
                                  end;
                                  if not same and not g3Set then
                                  begin
                                       // Grid3 is empty (or 'NILL') so shove it
                                       i := length(grid);
                                       sp.grid3[0] := chr(i);
                                       for i := 1 to length(grid) do
                                       begin
                                            sp.grid3[i] := grid[i];
                                       end;
                                       same := true;
                                  end;
                                  if not same and not g4Set then
                                  begin
                                       // Grid4 is empty (or 'NILL') so shove it
                                       i := length(grid);
                                       sp.grid4[0] := chr(i);
                                       for i := 1 to length(grid) do
                                       begin
                                            sp.grid4[i] := grid[i];
                                       end;
                                       same := true;
                                  end;

                             end;
                        end;
                   end;
                   // Record updated.  Lets try to write it back.
                   fn := prLogDir + 'jt65hf.db';
                   AssignFile(f1, fn);
                   Reset(f1);
                   seek(f1,idx);
                   write(f1,sp);
                   CloseFile(f1);
                   inc(prDBFUCount);
                   result := true;
              end
              else
              begin
                   // Did not find callsign, doing add
                   dbCallsign(callsign,sp.callsign); // Set the callsign :) I forgot this first time around and that was fun (not) to diagnose!
                   sp.count := 1;  // Set initial heard count
                   GetSystemTime(st);
                   sp.First := SystemTimeToDateTime(st); // Update last heard time... This sets to current UTC time
                   sp.last  := sp.first;
                   // Initialize band markers
                   sp.b160  := False;
                   sp.wb160 := False;
                   sp.b80   := False;
                   sp.wb80  := False;
                   sp.b40   := False;
                   sp.wb40  := False;
                   sp.b30   := False;
                   sp.wb30  := False;
                   sp.b20   := False;
                   sp.wb20  := False;
                   sp.b17   := False;
                   sp.wb17  := False;
                   sp.b15   := False;
                   sp.wb15  := False;
                   sp.b12   := False;
                   sp.wb12  := False;
                   sp.b10   := False;
                   sp.wb10  := False;
                   sp.b6    := False;
                   sp.wb6   := False;
                   sp.b2    := False;
                   sp.wb2   := False;
                   // Update band markers
                   if band = '160' then sp.b160 := true;
                   if band = '080' then sp.b80  := true;
                   if band = '040' then sp.b40  := true;
                   if band = '030' then sp.b30  := true;
                   if band = '020' then sp.b20  := true;
                   if band = '017' then sp.b17  := true;
                   if band = '015' then sp.b15  := true;
                   if band = '012' then sp.b12  := true;
                   if band = '010' then sp.b10  := true;
                   if band = '006' then sp.b6   := true;
                   if band = '002' then sp.b2   := true;
                   // Update worked band markers
                   if wband = '160' then sp.wb160 := true;
                   if wband = '080' then sp.wb80  := true;
                   if wband = '040' then sp.wb40  := true;
                   if wband = '030' then sp.wb30  := true;
                   if wband = '020' then sp.wb20  := true;
                   if wband = '017' then sp.wb17  := true;
                   if wband = '015' then sp.wb15  := true;
                   if wband = '012' then sp.wb12  := true;
                   if wband = '010' then sp.wb10  := true;
                   if wband = '006' then sp.wb6   := true;
                   if wband = '002' then sp.wb2   := true;
                   // Determine if the currecnt reported grid has been saved (if grid is available to record).
                   if not (grid = 'NILL') then
                   begin
                        // New record so set grid1 if necessary
                        DBGrid(trimleft(trimright(grid)),sp.grid1);
                        DBGrid(trimleft(trimright('NILL')),sp.grid2);
                        DBGrid(trimleft(trimright('NILL')),sp.grid3);
                        DBGrid(trimleft(trimright('NILL')),sp.grid4);
                   end
                   else
                   begin
                        // New record with no grid so set all to NILL
                        DBGrid(trimleft(trimright('NILL')),sp.grid1);
                        DBGrid(trimleft(trimright('NILL')),sp.grid2);
                        DBGrid(trimleft(trimright('NILL')),sp.grid3);
                        DBGrid(trimleft(trimright('NILL')),sp.grid4);
                   end;
                   // Record ready.  Lets try to write it.
                   // Get to last record
                   idx := 0;
                   fn := prLogDir + 'jt65hf.db';
                   AssignFile(f1, fn);
                   Reset(f1);
                   while not eof(f1) do
                   begin
                        seek(f1,idx);
                        inc(idx);
                   end;
                   write(f1,sp);
                   CloseFile(f1);
                   // If I've got this right idx will be the new record number
                   // Update the index file with callsign/idx
                   id.id := idx;
                   dbCallsign(callsign,id.callsign);
                   fn := prLogDir + 'jt65hf.id';
                   AssignFile(f2, fn);
                   Reset(f2);
                   idy := 0;
                   while not eof(f2) do
                   begin
                        seek(f2,idy);
                        inc(idy);
                   end;
                   write(f2,id);
                   CloseFile(f2);
                   inc(prDBFCount);
                   result := true;
              end;
              // Unlock DB
              prDBLock := False;
         end
         else
         begin
              // Could not get unlock on db
              result := false;
         end;
    end;

    function TSpot.findDB(const callsign : String) : CTypes.cuint32;
    var
       fidx  : SpotIDX;
       id    : SpotDBIdx;
       fn    : String;
       idx   : CTypes.cuint32;
       foo   : String;
       found : Boolean;
    begin
         // Find record number for callsign.  Returns 0 if not found
         // First attempt to find the callsign in the idx
         idx := 0;
         foo := '';
         fn := prLogDir + 'jt65hf.id';
         AssignFile(fidx, fn);
         Reset(fidx);
         seek(fidx,idx);
         while not EOF(fidx) do
         begin
              read(fidx,id);
              callsignDB(id.callsign,foo);
              foo := trimleft(trimright(foo));
              if callsign = foo then
              begin
                   found := true;
                   break;
              end
              else
              begin
                   inc(idx);
                   found := false;
              end;
         end;
         if found then result := idx else result := 0;
         closeFile(fidx);
    end;

    function TSpot.getDBAll(const callsign : String; var g1,g2,g3,g4 : String; var count : CTypes.cuint32; var first, last : TDateTime;
                   var b160,b80,b40,b30,b20,b17,b15,b12,b10,b6,b2,wb160,wb80,wb40,wb30,wb20,wb17,wb15,wb12,wb10,wb6,wb2 : Boolean) : Boolean;
    Begin
         // Returns info for call in callsign setting data in a ton of vars.
         // Overall return false if callsign not found.
         result := false;
    end;

    function TSpot.getDBREC(rec : CTypes.cuint32) : SpotDBRec;
    var
       sp : SpotDBRec;
       fn : String;
       f1 : SpotDB;
    begin
         // Returns a SpotDBRec record for record # in rec
         dbCallsign(' ',sp.callsign);
         dbGrid('NILL',sp.grid1);
         dbGrid('NILL',sp.grid2);
         dbGrid('NILL',sp.grid3);
         dbGrid('NILL',sp.grid4);
         sp.count := 0;
         sp.first := now;
         sp.last  := Now;
         sp.b160  := False;
         sp.wb160 := False;
         sp.b80   := False;
         sp.wb80  := False;
         sp.b40   := False;
         sp.wb40  := False;
         sp.b30   := False;
         sp.wb30  := False;
         sp.b20   := False;
         sp.wb20  := False;
         sp.b17   := False;
         sp.wb17  := False;
         sp.b15   := False;
         sp.wb15  := False;
         sp.b12   := False;
         sp.wb12  := False;
         sp.b10   := False;
         sp.wb10  := False;
         sp.b6    := False;
         sp.wb6   := False;
         sp.b2    := False;
         sp.wb2   := False;
         fn := prLogDir + 'jt65hf.db';
         AssignFile(f1, fn);
         Reset(f1);
         seek(f1,rec);
         read(f1,sp);
         CloseFile(f1);
         result := sp;
    end;

    function TSpot.getDB(const callsign : String; var ret : String) : Boolean;
    var
       sp : SpotDBRec;
       rn : CTypes.cuint32;
       foo : String;
    begin
         // Returns a string filled with info about callsign and true or an
         // empty string and false
         foo := '';
         rn := findDB(upcase(callsign));
         if rn > 0 then
         begin
              sp := getDBREC(rn);
              callsignDB(sp.callsign,foo);
              ret := 'Callsign ' + foo + ' was first heard on ' + FormatDateTime('dddd mmmm d, yyyy',sp.first) + ' at ' + formatDateTime('hh:nn:ss',sp.first) + ' UTC and last heard on ' + FormatDateTime('dddd mmmm d, yyyy',sp.last) + ' at ' + formatDateTime('hh:nn:ss',sp.last) + ' UTC.  Callsign has beed heard ' + IntToStr(sp.count) + ' times.';
              result := true;
         end
         else
         begin
              ret := '';
              result := false;
         end;
    end;

    function  TSpot.pskrTickle : DWORD;
    begin
         If pskrstat = 0 Then
         Begin
              PSKReporter.ReporterGetStatistics(pskrStats,sizeof(pskrStats));
              result := PSKReporter.ReporterTickle;
         end;
    end;

    function  TSpot.RBcountS : String;
    begin
         result := IntToStr(prRBCount);
    end;

    function  TSpot.RBDiscardS : String;
    begin
         result := IntToStr(prRBDiscard);
    end;

    function  TSpot.RBFailS : String;
    begin
         result := IntToStr(prRBFail);
    end;

    function  TSpot.PRcountS : String;
    begin
         result := IntToStr(prPRCount);
    end;

    function  TSpot.DBFcountS  : String;
    begin
         result := IntToStr(prDBFCount);
    end;

    function  TSpot.DBFUcountS  : String;
    begin
         result := IntToStr(prDBFUCount);
    end;

    function  TSpot.addSpot(const spot : spotRecord) : Boolean;
    var
       i         : Integer;
       inserted  : Boolean;
    begin
         inserted := false;
         for i := 0 to 8191 do
         begin
              if prSpots[i].rbsent and prSpots[i].pskrsent and prSpots[i].dbfsent then
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
                   prspots[i].dbfsent  := false;
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
         prhttp.Clear;
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
                 prRBOn := False;
                 If TrimLeft(TrimRight(rbResult.Text)) = 'QSL'      Then prRBOn := true;
                 //If TrimLeft(TrimRight(rbResult.Text)) = 'BAD QRG'  Then prRBOn := false;
                 //If TrimLeft(TrimRight(rbResult.Text)) = 'BAD GRID' Then prRBOn := false;
                 //If TrimLeft(TrimRight(rbResult.Text)) = 'BAD CALL' Then prRBOn := false;
                 //If TrimLeft(TrimRight(rbResult.Text)) = 'BAD MODE' Then prRBOn := false;
                 //If TrimLeft(TrimRight(rbResult.Text)) = 'NO'       Then prRBOn := false;
                 prRBError := TrimLeft(TrimRight(rbresult.Text));
            end;
         Except
            prRBError := 'EXCEPTION';
            prRBOn    := False;
         End;
         prBusy := False;
         prBusy := False;
         result := prRBOn;
    end;

    function TSpot.logoutRB : Boolean;
    var
       url      : String;
       band     : String;
       go       : Boolean;
    Begin
         prBusy       := True;
         band := '';
         if prVal.evalIQRG(prMyQRG,'LAX',band) then go := true else go := false;
         if go then
         begin
              rbResult.Clear;
              prRBError    := '';
              url          := 'http://jt65.w6cqz.org/rb.php?func=LO&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prMyQRG) + '&rbversion=' + prVersion;
              prhttp.Clear;
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
                      If TrimLeft(TrimRight(rbResult.Text[1..3])) = 'QSL' Then prRBOn := false;
                      If TrimLeft(TrimRight(rbResult.Text[1..2])) = 'NO'  Then prRBOn := true;
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
         result := true;
         prBusy := False;
    end;

    function TSpot.loginPSKR : Boolean;
    Begin
         pskrstat := PSKReporter.ReporterInitialize('report.pskreporter.info','4739');
         if pskrstat = 0 then
         begin
              result := True;
              prPSKROn := True;
         end
         else
         begin
              result := False;
              prPSKROn := False;
         end;
    End;

    function TSpot.logoutPSKR : Boolean;
    Begin
         PSKReporter.ReporterUninitialize;
         pskrStat := 1;
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
              for i := 0 to 8191 do
              begin
                   if not prSpots[i].rbsent then
                   begin
                        // OK.  Found an entry not marked as sent.  Is it something to send or not?
                        rbResult.Clear;
                        url       := '';
                        foo       := '';
                        resolved  := false;
                        callheard := '';
                        gridheard := '';
                        if parseExchange(prSpots[i].exchange, callheard, gridheard) and prVal.evalIQRG(prSpots[i].qrg,'LAX',band) then
                        begin
                             prhttp.Clear;
                             prhttp.Timeout := 10000;  // 10K ms = 10 s
                             prhttp.Headers.Add('Accept: text/html');
                             url := synacode.EncodeURL('http://jt65.w6cqz.org/rb.php?func=RR&callsign=' + prMyCall + '&grid=' + prMyGrid + '&qrg=' + IntToStr(prSpots[i].qrg) + '&rxdate=' + prSpots[i].date + '&callheard=' + callheard + '&gridheard=' + gridheard + '&siglevel=' + IntToStr(prSpots[i].db) + '&deltaf=' + IntToStr(prSpots[i].df) + '&deltat=' + floatToStrF(prSpots[i].dt,ffFixed,0,1) + '&decoder=' + prSpots[i].decoder + '&mode=' + prSpots[i].mode + '&exchange=' + prSpots[i].exchange + '&rbversion=' + prVersion);
                             Try
                                if prHTTP.HTTPMethod('GET', url) Then
                                begin
                                     rbResult.LoadFromStream(prHTTP.Document);
                                     // Messages RB login can return:
                                     // QSL - All good, spot saved.
                                     // NO - Indicates spot failed and safe to retry. (Probably RB Server busy)
                                     // ERR - Indicates RB Server has an issue with the data and not allowed to retry.
                                     // QRG - Indicates RB Server will no accept the current QRG
                                     If Length(rbResult.Text) > 1 then
                                     begin
                                          If TrimLeft(TrimRight(rbResult.Text)) = 'QSL' Then resolved := true;
                                          If TrimLeft(TrimRight(rbResult.Text)) = 'QRG' Then resolved := false;
                                          If TrimLeft(TrimRight(rbResult.Text)) = 'NO'  Then resolved := false;
                                          If TrimLeft(TrimRight(rbResult.Text)) = 'ERR' Then resolved := false;
                                          foo := TrimLeft(TrimRight(rbresult.Text));
                                     end
                                     else
                                     begin
                                          // Unexpected return value from URL call
                                          foo := 'EXC';
                                     end;
                                end
                                else
                                begin
                                     foo := 'EXC';
                                     resolved := False;
                                end;
                             Except
                                foo := 'EXC';
                                resolved := false;
                             End;
                             // Wrap up by checking for status of spot and clearing its place in the list as appropriate.
                             if resolved then
                             begin
                                  prSpots[i].rbsent := true;
                                  inc(prRBCount);
                             end
                             else
                             begin
                                  { TODO [1.0.9] Pass back error to main code so user can be notified of problem }
                                  { TODO [1.0.9] This is a hard fail.. even in the case where a retry is warranted the spot is discarded. }
                                  //if length(foo) < 2 then foo := 'EXC';
                                  //prSpots[i].rbsent:= true;
                                  //if foo[1..3] = 'QRG' then prSpots[i].rbsent := true;  // RB Server says bad QRG so don't try to send this again...
                                  //if foo[1..2] = 'NO' then prSpots[i].rbsent  := true; { TODO : Fix this (Set back to true) once I decide how to better handle retries }
                                  //if foo[1..3] = 'EXC' then prSpots[i].rbsent := true; { TODO : Fix this (Set back to true) once I decide how to better handle retries }
                                  //if foo[1..3] = 'ERR' then prSpots[i].rbsent := true;
                                  //if foo[1..3] = 'BAD' then prSpots[i].rbsent := true;  // RB Server doesn't like some of the data (probably big DT) so no resend
                                  inc(prRBFail);
                             end;
                        end
                        else
                        begin
                             inc(prRBDiscard);
                             // Excahnge did not parse to something of use or qrg invalid.  Mark it sent so it can be cleared.
                             prSpots[i].rbsent   := true;
                             prSpots[i].pskrsent := true;
                        end;
                        sleep(100); // Lets not overload the RB server with little or no delay between spot posts.
                   end;
              end;
         end
         else
         begin
              // Process any spots marked as not sent for RB lest the array fills with unsent entries. This is only called
              // when RB spotting is not enabled as it is otherwise cleared above.
              for i := 0 to 8191 do if not prSpots[i].rbsent then prSpots[i].rbsent := true;
         end;
         if prUsePSKR then
         begin
              // Do PSKR work
              // pskrstat is set at PSKR initialization time.
              if pskrstat = 0 then
              begin
                   for i := 0 to 8191 do
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
                                  pskrloc := BuildLocalString(prMyCall,prMyGrid,'JT65-HF','200',prInfo);
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
                                  prSpots[i].pskrsent := true;
                                  inc(prPRCount);
                             end;
                        end;
                   end;
              end
              else
              begin
                   // PSKR is not available.  Clear the entries needing PSKR service lest the list fills.
                   for i := 0 to 8191 do if not prSpots[i].pskrsent then prSpots[i].pskrsent := true;
              end;
         end
         else
         begin
              // Process any spots marked as not sent for PSKR lest the array fills with unsent entries. This is only called
              // when PSKR spotting is not enabled as it is otherwise cleared above.
              for i := 0 to 8191 do if not prSpots[i].pskrsent then prSpots[i].pskrsent := true;
         end;
         if prUseDBF then
         begin
              if not fileExists(prLogDir + 'jt65hf.db') then createDB; // This sets up the tracking DB
              for i := 0 to 8191 do
              begin
                   if not prSpots[i].dbfsent then
                   begin
                        resolved  := false;
                        callheard := '';
                        gridheard := '';
                        if parseExchange(prSpots[i].exchange, callheard, gridheard) and prVal.evalIQRG(prSpots[i].qrg,'LAX',band) then
                        begin
                             foo := '';
                             if (prSpots[i].qrg >   1799999) and (prSpots[i].qrg <   2000001) then foo := '160';
                             if (prSpots[i].qrg >   3499999) and (prSpots[i].qrg <   4000001) then foo := '080';
                             if (prSpots[i].qrg >   6999999) and (prSpots[i].qrg <   7300001) then foo := '040';
                             if (prSpots[i].qrg >  10099999) and (prSpots[i].qrg <  10150001) then foo := '030';
                             if (prSpots[i].qrg >  13999999) and (prSpots[i].qrg <  14350001) then foo := '020';
                             if (prSpots[i].qrg >  18067999) and (prSpots[i].qrg <  18168001) then foo := '017';
                             if (prSpots[i].qrg >  20999999) and (prSpots[i].qrg <  21450001) then foo := '015';
                             if (prSpots[i].qrg >  24889999) and (prSpots[i].qrg <  24990001) then foo := '012';
                             if (prSpots[i].qrg >  27999999) and (prSpots[i].qrg <  29700001) then foo := '010';
                             if (prSpots[i].qrg >  49999999) and (prSpots[i].qrg <  54000001) then foo := '006';
                             if (prSpots[i].qrg > 143999999) and (prSpots[i].qrg < 148000001) then foo := '002';
                             if not addToDB(callHeard,gridHeard,foo,'') then
                             begin
                                  // Didn't add spot, probably couldn't get lock
                                  // so queue it for another try.  Probably need
                                  // to look at this as over a (very) long period
                                  // of repeated fails the spots array could become
                                  // filled with unlogged db entries.
                                  {TODO [1.0.9] Review above }
                                  prSpots[i].dbfsent := false;
                             end
                             else
                             begin
                                  prSpots[i].dbfsent := true;
                             end;
                        end;
                   end;
              end;
         end
         else
         begin
              // Process any spots marked as not sent for DBF lest the array fills with unsent entries. This is only called
              // when DB save is not enabled as it is otherwise cleared above.
              for i := 0 to 8191 do if not prSpots[i].dbfsent then prSpots[i].dbfsent := true;
         end;
         result := true;
         prBusy := false;
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
                        // w1           w2
                        // CQ           CALLSIGN
                        // QRZ          CALLSIGN
                        resolved  := true;
                        result    := true;
                        callheard := w2;
                        gridheard := 'NILL';
                   end;
                   if not resolved and prVal.evalCSign(w1) and prVal.evalCSign(w2) and (w3 = '   ') then
                   begin
                        // Tentative on this one...
                        // w1           w2
                        // CALLSIGN     CALLSIGN
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

