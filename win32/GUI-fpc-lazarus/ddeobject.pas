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
unit ddeobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Windows, CTypes;

type
  // Using this:
  // Set Service name   [ddeService]
  // Set Topic name     [ddeTopic]
  // Set Item name      [ddeItem]
  // Get Item value     [ddeGetItem] or Set Item value [ddeSetItem]
  // Get Result code    [ddeResult] (Optional)
  TDDEConversation = Class
     private
        // DDE Conversational Variables
        prddeInst            : DWORD;
        prhszCallback        : PFNCALLBACK;
        prddeTemp            : DWORD;
        prddeMode            : DWORD;
        prhszService         : HSZ;
        prhszTopic           : HSZ;
        prhszResult          : HDDEDATA;
        prddeService         : PChar;
        prddeTopic           : PChar;
        prddeItem            : PChar;
        prhszItem            : HSZ;
        prddeData            : String;
        prhszData            : HSZ;
        prdataBuff           : array[0..4095] of ctypes.cuint8;
        prddehConv           : HCONV;
        prddePContext        : CONVCONTEXT;
        prddeConnected       : Boolean;
        prddeError           : String;
        prddeCommand         : String;

        function errorToStr(err : UINT) : String;

     public
        Constructor create();
        // Set/Get DDE Service name
        procedure setDDEService(msg : String);
        function  getDDEService() : String;
        // Set/Get DDE Topic name
        procedure setDDETopic(msg : String);
        function  getDDETopic() : String;
        // Set/Get DDE Item name
        procedure setDDEItem(msg : String);
        function  getDDEItem() : String;
        // With the Service Name, Topic and Item create an instance then,
        // connect, read item, disconnect and cleanup.
        function  doDDERdTransaction() : String;
        // With the Service Name, Topic and Item create an instance then,
        // connect, write item, disconnect and cleanup.
        procedure doDDEWrTransaction();
        // With the Service Name, Topic and Item create an instance then,
        // connect, write value to item, disconnect and cleanup.
        procedure doDDEPokeTransaction();
        // Get last DDE transaction error code
        //function  getDDEError() : String;
        // Call validate to return an overall status of configuration object.
        // Anything critical that is incorrect will lead to a false result.
        //function  validate() : Boolean;

        property ddeService   : String
           read  getDDEService
           write setDDEService;
        property ddeTopic     : String
           read  getDDETopic
           write setDDETopic;
        property ddeItem      : String
           read  getDDEItem
           write setDDEItem;
        property ddeData      : String
           write prddeData;
        property ddeGetItem   : String
           read  doDDERdTransaction;
        property ddeResult    : String
           read  prddeError;
        property ddeCommand   : String
           write prddeCommand;
  end;

implementation
constructor TDDEConversation.Create();
var
     i : Integer;
begin
     prddeInst     := 0;
     prhszCallback := Nil;
     prddeTemp     := 0;
     prddeMode     := 0;
     prhszService  := 0;
     prhszTopic    := 0;
     prhszResult   := 0;
     prddeService  := StrAlloc(256);
     prddeTopic    := StrAlloc(256);
     prddeItem     := StrAlloc(256);
     prhszItem     := 0;
     prddehConv    := 0;
     for i := 0 to 4095 do
     begin
          prdataBuff[i] := 0;
     end;
     prddePContext.cb := 0;
     prddePContext.wFlags := 0;
     prddePContext.wCountryID := 0;
     prddePContext.iCodePage := CP_WINANSI;
     prddePContext.dwLangID := LANG_SYSTEM_DEFAULT;
     prddePContext.dwSecurity := 0;
     prddePContext.qos.Length := 0;
     prddePContext.qos.ImpersonationLevel := SecurityAnonymous;
     prddePContext.qos.ContextTrackingMode := False;
     prddePContext.qos.EffectiveOnly := False;
     prddeConnected := False;
     prddeError := '';
     prddeCommand := '';
end;

    // Set/Get DDE Service name
    procedure TDDEConversation.setDDEService(msg : String);
    var
         foo : String;
    begin
         foo := trimleft(trimright(msg));
         strpcopy(prddeservice,foo);
    end;

    function  TDDEConversation.getDDEService() : String;
    begin
         result := strpas(prddeservice);
    end;

    // Set/Get DDE Topic name
    procedure TDDEConversation.setDDETopic(msg : String);
    var
         foo : String;
    begin
         foo := trimleft(trimright(msg));
         strpcopy(prddetopic,foo);
    end;

    function  TDDEConversation.getDDETopic() : String;
    begin
         result := strpas(prddetopic);
    end;

    // Set/Get DDE Item name
    procedure TDDEConversation.setDDEItem(msg : String);
    var
         foo : String;
    begin
         foo := trimleft(trimright(msg));
         strpcopy(prddeitem,foo);
    end;

    function  TDDEConversation.getDDEItem() : String;
    begin
         result := strpas(prddeitem);
    end;

    // Do the DDE with the set Service, Topic and item returning the item's
    // value as string
    function  TDDEConversation.doDDERdTransaction() : String;
    var
         foo : String;
         i   : integer;
    Begin
         try
            prddeInst := 0;
            result := '';
            if windows.DdeInitialize(@prddeInst,prhszCallback,prddeMode,0) = 0 then
            begin
                 prddeError := 'No Error';
                 prhszService := windows.DdeCreateStringHandle(prddeInst, prddeService, CP_WINANSI);
                 prhszTopic   := windows.DdeCreateStringHandle(prddeInst, prddeTopic, CP_WINANSI);
                 prhszItem    := windows.DdeCreateStringHandle(prddeInst, prddeItem, CP_WINANSI);
                 if (prhszService = 0) or (prhszTopic = 0) or (prhszItem = 0) then
                 begin
                      result := '';
                      prddeError := 'DDE String Alloc Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                 end
                 else
                 begin
                      prddeError := 'No Error';
                      prddehConv := windows.DdeConnect(prddeInst, prhszService, prhszTopic, prddePContext);
                      if prddehConv < 1 Then
                      begin
                           result := '';
                           prddeError := 'Connect DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                      end
                      else
                      Begin
                           prddeError := 'No Error';
                           // We're talking...
                           prhszResult := windows.DdeClientTransaction(nil, 0, prddehConv, prhszItem, CF_TEXT, XTYP_REQUEST, 5000, Nil);
                           if prhszResult > 0 then
                           begin
                                prddeError := 'No Error';
                                foo := '';
                                for i := 0 to 4095 do begin prdataBuff[i] := 0; end;
                                prddeTemp := windows.DdeGetData(prhszResult,@prdataBuff[0],SizeOf(prdataBuff),0);
                                for i := 0 to prddeTemp-1 do begin foo := foo + chr(prdataBuff[i]); end;
                                result := foo;
                           end
                           else
                           begin
                                result := '';
                                prddeError := 'DDE Client Transaction Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                           end;
                      end;
                      windows.DdeDisconnect(prddehConv);
                      windows.DdeFreeStringHandle(prddeInst,prhszService);
                      windows.DdeFreeStringHandle(prddeInst,prhszTopic);
                      windows.DdeFreeStringHandle(prddeInst,prhszItem);
                      windows.DdeUninitialize(prddeInst);
                 end;
            end
            else
            begin
                 result := '';
                 prddeError := 'Initialize DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
            end;
         except
           halt;
         end;
    end;

    procedure TDDEConversation.doDDEWrTransaction();
    var
         foo  : String;
         bfoo : Array[0..2047] Of Byte;
         dlen : DWORD;
         i    : integer;
    Begin
         prddeInst := 0;
         if windows.DdeInitialize(@prddeInst,prhszCallback,prddeMode,0) = 0 then
         begin
              prhszService := windows.DdeCreateStringHandle(prddeInst, prddeService, CP_WINANSI);
              prhszTopic   := windows.DdeCreateStringHandle(prddeInst, prddeTopic, CP_WINANSI);
              if (prhszService = 0) or (prhszTopic = 0) then
              begin
                   prddeError := 'DDE String Alloc Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
              end
              else
              begin
                   prddehConv := windows.DdeConnect(prddeInst, prhszService, prhszTopic, prddePContext);
                   if prddehConv < 1 Then
                   begin
                        prddeError := 'Connect DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                   end
                   else
                   Begin
                        // We're talking...
                        foo := trimleft(trimright(prddeCommand));
                        for i := 0 to 2047 do begin bfoo[i] := 0; end;
                        for i := 1 to length(foo) do
                        begin
                             bfoo[i-1] := ord(foo[i]);
                        end;
                        dlen := length(foo)+1;

                        prhszResult := windows.DdeClientTransaction(@bfoo[0],dlen,prddehConv,0,0,XTYP_EXECUTE,0,nil);
                        if prhszResult > 0 then
                        begin
                             prddeError := 'No Error';
                        end
                        else
                        begin
                             prddeError := 'DDE Client Transaction Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                        end;
                        windows.DdeDisconnect(prddehConv);
                        windows.DdeFreeStringHandle(prddeInst,prhszService);
                        windows.DdeFreeStringHandle(prddeInst,prhszTopic);
                   end;
                   windows.DdeUninitialize(prddeInst);
              end;
         end
         else
         begin
              prddeError := 'Initialize DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
         end;
    end;
    // This pokes the value in prddeData to item in prddeItem
    procedure TDDEConversation.doDDEPokeTransaction();
    var
         foo  : String;
         bfoo : Array[0..2047] Of Byte;
         dlen : DWORD;
         i    : integer;
    Begin
         prddeInst := 0;
         if windows.DdeInitialize(@prddeInst,prhszCallback,prddeMode,0) = 0 then
         begin
              prhszService := windows.DdeCreateStringHandle(prddeInst, prddeService, CP_WINANSI);
              prhszTopic   := windows.DdeCreateStringHandle(prddeInst, prddeTopic, CP_WINANSI);
              prhszItem    := windows.DdeCreateStringHandle(prddeInst, prddeItem, CP_WINANSI);
              if (prhszService = 0) or (prhszTopic = 0) or (prhszItem = 0) then
              begin
                   prddeError := 'DDE String Alloc Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
              end
              else
              begin
                   prddehConv := windows.DdeConnect(prddeInst, prhszService, prhszTopic, prddePContext);
                   if prddehConv < 1 Then
                   begin
                        prddeError := 'Connect DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                   end
                   else
                   Begin
                        // We're talking...
                        foo := trimleft(trimright(prddeData));
                        for i := 0 to 2047 do begin bfoo[i] := 0; end;
                        for i := 1 to length(foo) do
                        begin
                             bfoo[i-1] := ord(foo[i]);
                        end;
                        dlen := length(foo)+1;
                        prhszResult := windows.DdeClientTransaction(@bfoo[0],dlen,prddehConv,prhszItem,CF_TEXT,XTYP_POKE,0,nil);
                        if prhszResult > 0 then
                        begin
                             prddeError := 'No Error';
                        end
                        else
                        begin
                             prddeError := 'DDE Client Transaction Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
                        end;
                        windows.DdeDisconnect(prddehConv);
                        windows.DdeFreeStringHandle(prddeInst,prhszService);
                        windows.DdeFreeStringHandle(prddeInst,prhszTopic);
                   end;
                   windows.DdeUninitialize(prddeInst);
              end;
         end
         else
         begin
              prddeError := 'Initialize DDE Error:  ' + errorToStr(windows.DdeGetLastError(prddeInst));
         end;
    end;

    function TDDEConversation.errorToStr(err : UINT) : String;
    begin
         result := 'Unknown';
         case  err  of
               0 : Result := 'No Error';
           16384 : Result := 'DMLERR_ADVACKTIMEOUT';
           16385 : Result := 'DMLERR_BUSY';
           16386 : Result := 'DMLERR_DATAACKTIMEOUT';
           16387 : Result := 'DMLERR_DLL_NOT_INITIALIZED';
           16388 : Result := 'DMLERR_DLL_USAGE';
           16389 : Result := 'DMLERR_EXECACKTIMEOUT';
           16390 : Result := 'DMLERR_INVALIDPARAMETER';
           16391 : Result := 'DMLERR_LOW_MEMORY';
           16392 : Result := 'DMLERR_MEMORY_ERROR';
           16393 : Result := 'DMLERR_NOTPROCESSED';
           16394 : Result := 'DMLERR_NO_CONV_ESTABLISHED';
           16395 : Result := 'DMLERR_POKEACKTIMEOUT';
           16396 : Result := 'DMLERR_POSTMSG_FAILED';
           16397 : Result := 'DMLERR_REENTRANCY';
           16398 : Result := 'DMLERR_SERVER_DIED';
           16399 : Result := 'DMLERR_SYS_ERROR';
           16400 : Result := 'DMLERR_UNADVACKTIMEOUT';
           16401 : Result := 'DMLERR_UNFOUND_QUEUE_ID';
         end;
    end;

end.
