unit paobject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, CTypes, portaudio, adclite, daclite;

type
  tdsparray   = array of CTypes.cint16;
  tdevicelist = array of String;

  // This class encapsulates all the things related to audio devices
  TpaDSP = Class
     private
        // Buffers
        prRXBuffer    : tdsparray;
        prTXBuffer    : tdsparray;
        prADCList     : tdevicelist;
        prDACList     : tdevicelist;
        // PA Input Device Parameters
        prInParams    : TPaStreamParameters;
        prpInParams   : PPaStreamParameters;
        // PA Output Device Parameters
        prOutParams   : TPaStreamParameters;
        prpOutParams  : PPaStreamParameters;
        // PA Result
        prResult      : TPaError;
        prHostApi     : TPaHostApiIndex;
        prAPIName     : String;
        prDevCount    : cint;
        prDefInput    : TPaDeviceIndex;
        prDefOutput   : TPaDeviceIndex;
        prDefInputS   : String;
        prDefOutputS  : String;
        prSampleRate  : CDouble;
        prADCRunning  : Boolean;
        prDACRunning  : Boolean;
        // Streams
        prInStream    : PPaStream;
        prOutStream   : PPaStream;

     public
        // Setup buffers, initialize PA and populate device lists
        Constructor create();
        Destructor  terminate();
        procedure testInputDevice();
        procedure testOutputDevice();
        function  getLastError()  : String;
        function  getDefaultAPI() : String;
        procedure adcOn();
        procedure adcOff();
        procedure dacOn();
        procedure dacOff();
        function  getAUChannel() : Integer;
        procedure setAUChannel(chan : Integer);
        function  getAULevel1() : Integer;
        function  getAULevel2() : Integer;
        function  getADCCount() : Integer;
        function  getADCErate() : CDouble;
        function  getADCOverrun() : Integer;
        function  getDACErate() : CDouble;
        function  getDACUnderrun() : Integer;

        property rxBuffer : tdsparray
           read  prRXBuffer
           write prRXBuffer;
        property txBuffer : tdsparray
           read  prTXBuffer
           write prTXBuffer;
        property adcList  : tdevicelist
           read  prADCList
           write prADCList;
        property dacList  : tdevicelist
           read  prDACList
           write prDACList;
        property paInputDevice : TPaDeviceIndex
           read  prInParams.device
           write prInParams.device;
        property inputChannels : cint
           read  prInParams.channelCount
           write prInParams.channelCount;
        property paOutputDevice : TPaDeviceIndex
           read  prOutParams.device
           write prOutParams.device;
        property outputChannels : cint
           read  prOutParams.channelCount
           write prOutParams.channelCount;
        property lastResult : TPaError
           read  prResult;
        property lastError  : String
           read  getLastError;
        property apiName    : String
           read  prAPIName;
        property defaultInput : TPaDeviceIndex
           read  prDefInput;
        property defaultOutput : TPaDeviceIndex
           read  prDefOutput;
        property defaultInputName : String
           read  prDefInputS;
        property defaultOutputName : String
           read  prDefOutputS;
        property sampleRate   : CDouble
           read  prSampleRate
           write prSampleRate;
        property adcRunning : Boolean
           read  prADCRunning;
        property dacRunning : Boolean
           read  prDACRunning;
        property auChannel : Integer
           read  getAUChannel
           write setAUChannel;
        property auLevel1  : Integer
           read  getAULevel1;
        property auLevel2  : Integer
           read  getAULevel2;
        property adcCount  : Integer
           read  getADCCount;
        property adcErate : CDouble
           read  getADCErate;
        property adcOverrun : Integer
           read  getADCOverrun;
        property dacErate : CDouble
           read  getDACErate;
        property dacUnderrun : Integer
           read  getDACUnderrun;
  end;

implementation
   constructor TpaDSP.Create();
   var
      paInS, paOutS : String;
      i, j, k       : integer;
   begin
        // Constructor initialized portaudio and populates ADC/DAC device
        // lists.  It also allocates buffers and control sturctures.

        // Pointers to PA Device control structures
        prpInParams := @prInParams;
        prpOutParams := @prOutParams;

        // Some default parameters that I don't change
        prInParams.sampleFormat := paInt16;
        prInParams.suggestedLatency := 1;
        prInParams.hostApiSpecificStreamInfo := Nil;
        prOutParams.sampleFormat := paInt16;
        prOutParams.suggestedLatency := 1;
        prOutParams.hostApiSpecificStreamInfo := Nil;

        // This can be changed but defaults to stereo
        prInParams.channelCount := 2;
        prOutParams.channelCount := 2;

        // Sample rate defaults to 11025 but can be changed
        prSampleRate := 11025.0;

        // Set input and output devices to -1 (invalid) devices
        prInParams.device  := -1;
        prOutParams.device := -1;

        // Setup some sane defaults for adc unit
        adclite.adcCount := 0;
        adclite.adcChan  := 1;

        // Setup buffers and device lists.  Will free by destructor call
        setlength(prRXBuffer,661504);
        setlength(prTXBuffer,661504);
        setLength(prADCList,256);
        setLength(prDACList,256);

        for i := 0 to 661503 do
        begin
             prRXBuffer[i] := 0;
             prTXBuffer[i] := 0;
        end;
        for i := 0 to 255 do
        begin
             prADCList[i] := 'NILL';
             prDACList[i] := 'NILL';
        end;

        i := 0;
        j := 0;
        k := 0;

        // Init PA.  If this doesn't work there's no reason to continue.
        prResult := portaudio.Pa_Initialize();
        If prResult = paNoError Then
        Begin
             // Iterate the sound device list to populate ADC/DAC arrays.  First I'm going
             // to get a list of the portaudio API descriptions.  For now I'm going to
             // stick with the default windows interface, but in the future I may look
             // at directsound usage as well.
             prHostApi := portaudio.Pa_GetDefaultHostApi();
             if prHostApi >= 0 Then
             Begin
                  prDevCount := portaudio.Pa_GetHostApiInfo(prHostApi)^.deviceCount;
                  prAPIName := StrPas(portaudio.Pa_GetHostApiInfo(prHostApi)^.name);
                  prDefInput := portaudio.Pa_GetHostApiInfo(prHostApi)^.defaultInputDevice;
                  prDefOutput := portaudio.Pa_GetHostApiInfo(prHostApi)^.defaultOutputDevice;
                  prDefInputS := StrPas(portaudio.Pa_GetDeviceInfo(prDefInput)^.name);
                  prDefOutputS := StrPas(portaudio.Pa_GetDeviceInfo(prDefOutput)^.name);
                  i := prDevCount-1;
                  While i >= 0 do
                  Begin
                       If portaudio.Pa_GetDeviceInfo(i)^.maxInputChannels > 0 Then
                       Begin
                            if i < 10 Then
                               paInS := '0' + IntToStr(i) + '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)
                            else
                               paInS := IntToStr(i) + '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name);
                            prADCList[j] := paInS;
                            inc(j);
                       End;
                       If portaudio.Pa_GetDeviceInfo(i)^.maxOutputChannels > 0 Then
                       Begin
                            if i < 10 Then
                               paOutS := '0' + IntToStr(i) +  '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name)
                            else
                               paOutS := IntToStr(i) +  '-' + StrPas(portaudio.Pa_GetDeviceInfo(i)^.name);
                            prDACList[k] := paOutS;
                            inc(k);
                       End;
                       dec(i);
                  End;
             End
             Else
             Begin
                  prResult := paHostApiNotFound;
             End;
        end;
   end;

   Destructor TpaDSP.terminate();
   begin
        portaudio.Pa_Terminate();
        setlength(prRXBuffer,0);
        setlength(prTXBuffer,0);
        setLength(prADCList,0);
        setLength(prDACList,0);
   end;

   procedure TpaDSP.testInputDevice();
   Begin
        prResult := portaudio.paNoError;

        if prInParams.device > -1 then
        begin
             prResult := portaudio.Pa_IsFormatSupported(prpInParams,Nil,prSampleRate);
        end
        else
        begin
             prResult := portaudio.paInvalidDevice;
        end;
   end;

   procedure TpaDSP.testOutputDevice();
   Begin
        prResult := portaudio.paNoError;

        if prOutParams.device > -1 then
        begin
             prResult := portaudio.Pa_IsFormatSupported(Nil,prpOutParams,prSampleRate);
        end
        else
        begin
             prResult := portaudio.paInvalidDevice;
        end;
   end;

   function  TpaDSP.getLastError() : String;
   begin
        result := 'Unknown Error';
        case prResult of
             paNoError                               : Result := 'No error';
             paNotInitialized                        : Result := 'PA Not Initialized';
             paUnanticipatedHostError                : Result := 'Unanticipated Host Error';
             paInvalidChannelCount                   : Result := 'Invalid Channel Count';
             paInvalidSampleRate                     : Result := 'Invalid Sample Rate';
             paInvalidDevice                         : Result := 'Invalid Device';
             paInvalidFlag                           : Result := 'Invalid Flad';
             paSampleFormatNotSupported              : Result := 'Sample Format Not Supported';
             paBadIODeviceCombination                : Result := 'Bad IO Device Combination';
             paInsufficientMemory                    : Result := 'Insufficient Memory';
             paBufferTooBig                          : Result := 'Buffer Too Big';
             paBufferTooSmall                        : Result := 'Buffer Too Small';
             paNullCallback                          : Result := 'Null Callback';
             paBadStreamPtr                          : Result := 'Bad Stream Pointer';
             paTimedOut                              : Result := 'Timed Out';
             paInternalError                         : Result := 'Internal Error';
             paDeviceUnavailable                     : Result := 'Device Unavailable';
             paIncompatibleHostApiSpecificStreamInfo : Result := 'Incompatible Host API Specific Stream Info';
             paStreamIsStopped                       : Result := 'Stream Is Stopped';
             paStreamIsNotStopped                    : Result := 'Stream Is Not Stopped';
             paInputOverflowed                       : Result := 'Input Overflowed';
             paOutputUnderflowed                     : Result := 'Output Underflowed';
             paHostApiNotFound                       : Result := 'Host API Not Found';
             paInvalidHostApi                        : Result := 'Invalid Host API';
             paCanNotReadFromACallbackStream         : Result := 'Can Not Read From A Callback Stream';
             paCanNotWriteToACallbackStream          : Result := 'Can Not Write To A Callback Stream';
             paCanNotReadFromAnOutputOnlyStream      : Result := 'Can Not Read From An Output Only Stream';
             paCanNotWriteToAnInputOnlyStream        : Result := 'Can Not Write To An Input Only Stream';
             paIncompatibleStreamHostApi             : Result := 'Incompatible Stream Host API';
             paBadBufferPtr                          : Result := 'Bad Buffer Pointer';

        end;
   end;

   function  TpaDSP.getDefaultAPI() : String;
   Begin
        result := 'Unknown API';
        case prHostApi of
             paInDevelopment   : result := 'Alpha Test API';
             paDirectSound     : result := 'Direct Sound';
             paMME             : result := 'MME';
             paASIO            : result := 'ASIO';
             paSoundManager    : result := 'Sound Manager';
             paCoreAudio       : result := 'Core Audio';
             paOSS             : result := 'OSS';
             paALSA            : result := 'ALSA';
             paAL              : result := 'AL';
             paBeOS            : result := 'BeOS';
             paWDMKS           : result := 'WDMKS';
             paJACK            : result := 'Jack';
             paWASAPI          : result := 'WAS API';
             paAudioScienceHPI : result := 'Audio Science HPI';
        end;
   end;

   procedure TpaDSP.adcOn();
   begin
        prInParams.channelCount := 1;
        adclite.adcCount := 0;
        adclite.specLevel1 := 50;
        adclite.specLevel2 := 50;
        adclite.adcLDgain := 0;
        adclite.adcRDgain := 0;
        adclite.adcT := 0;
        adclite.adcErr := 0;
        adclite.adcErate := 1.000;
        adclite.adcOverrun := 0;
        prInStream := Nil;
        if prInParams.channelCount = 1 then
        begin
             prResult := portaudio.Pa_OpenStream(prInStream,prpInParams,Nil,prSampleRate,2048,0,PPaStreamCallback(@adclite.madcCallback),Pointer(Self));
        end;
        if prInParams.channelCount = 2 then
        begin
             prResult := portaudio.Pa_OpenStream(prInStream,prpInParams,Nil,prSampleRate,2048,0,PPaStreamCallback(@adclite.sadcCallback),Pointer(Self));
        end;

        if (prInParams.channelCount < 1) or (prInParams.channelCount > 2) then prResult := paInvalidChannelCount;

        if prResult = paNoError then
        begin
             prResult := portaudio.Pa_StartStream(prInStream);
             if prResult = paNoError then prADCRunning := true else prADCRunning := false;
        end
        else
        begin
             prADCRunning := false;
        end;
   end;

   procedure TpaDSP.adcOff();
   begin
        if portAudio.Pa_IsStreamActive(prInStream) > 0 Then prResult := portAudio.Pa_StopStream(prInStream);
        sleep(100);
        if prResult = paNoError then
        begin
             sleep(100);
             if portAudio.Pa_IsStreamActive(prInStream) > 0 Then prResult := portAudio.Pa_AbortStream(prInStream);
        end;
        if prResult = paNoError then prResult := portaudio.Pa_CloseStream(prInStream);
        if prResult = paNoError then prADCRunning := false else prADCRunning := true;
   end;

   procedure TpaDSP.dacOn();
   begin
        daclite.d65txBufferIdx := 0;
        daclite.d65txBufferPtr := @daclite.d65txBuffer[0];
        daclite.dacT := 0;
        daclite.dacEnTX := false;
        prOutParams.channelCount := 2;
        if prOutParams.channelCount = 1 Then
        begin
             prResult := portaudio.Pa_OpenStream(prOutStream,Nil,prpOutParams,prSampleRate,2048,0,PPaStreamCallback(@daclite.mdacCallback),Pointer(Self));
        end;
        if prOutParams.channelCount = 2 Then
        begin
             prResult := portaudio.Pa_OpenStream(prOutStream,Nil,prpOutParams,prSampleRate,2048,0,PPaStreamCallback(@daclite.sdacCallback),Pointer(Self));
        end;

        if (prOutParams.channelCount < 1) or (prOutParams.channelCount > 2) then prResult := paInvalidChannelCount;

        if prResult = paNoError then
        begin
             prResult := portaudio.Pa_StartStream(prOutStream);
             if prResult = paNoError then prDACRunning := true else prDACRunning := false;
        end
        else
        begin
             prDACRunning := false;
        end;
   end;

   procedure TpaDSP.dacOff();
   begin
        if portAudio.Pa_IsStreamActive(prOutStream) > 0 Then prResult := portAudio.Pa_StopStream(prOutStream);
        sleep(100);
        if prResult = paNoError then
        begin
             sleep(100);
             if portAudio.Pa_IsStreamActive(prOutStream) > 0 Then prResult := portAudio.Pa_AbortStream(prOutStream);
        end;
        if prResult = paNoError then prResult := portaudio.Pa_CloseStream(prOutStream);
        if prResult = paNoError then prDACRunning := false else prDACRunning := true;
   end;

   function  TpaDSP.getAUChannel() : Integer;
   begin
        result := adclite.adcChan;
   end;

   procedure TpaDSP.setAUChannel(chan : Integer);
   begin
        adclite.adcChan := chan;
   end;

   function  TpaDSP.getAULevel1() : Integer;
   begin
        result := adclite.specLevel1;
   end;

   function  TpaDSP.getAULevel2() : Integer;
   begin
        result := adclite.specLevel2;
   end;

   function  TpaDSP.getADCCount() : Integer;
   begin
        result := adclite.adcCount;
   end;

   function  TpaDSP.getADCErate() : CDouble;
   begin
        result := adclite.adcErate;
   end;

   function  TpaDSP.getADCOverrun() : Integer;
   Begin
        result := adclite.adcOverrun;
   end;

   function  TpaDSP.getDACErate() : CDouble;
   begin
        result := daclite.dacErate;
   end;

   function  TpaDSP.getDACUnderrun() : Integer;
   Begin
        result := daclite.dacUnderrun;
   end;
end.

