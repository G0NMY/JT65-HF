Unit dds;
{$MODE DELPHI}
{$H+}
Interface
// You set up the desired parameters in the class, call the Reset method once,
// and each time you need a sample, just call the Synthesize method to generate
// a value you can then read using the Amplitude or Phase properties.
Type
TDDS = Class;
TPhaseToAmplitude = Function(Const ADDS : TDDS) : Single;
TNumberOfBits = 2..31;
TWaveType = (wtSawtooth,wtSquare,wtTriangle,wtSine,wtCustom);
TDefinedWaveType = Low(TWaveType)..Pred(High(TWaveType));
TDDS = Class
Private
  FOnPhaseToAmplitude : TPhaseToAmplitude;
  FPhaseRegResolution : TNumberOfBits;
  FPhaseRegMaxPlus1 : LongWord;
  FPhaseRegMax : LongWord;
  FPhaseRegHalfMax : LongWord;
  FPhaseRegQuaterMax : LongWord;
  FWaveType : TWaveType;
  FSampleRate : LongWord;
  FFrequency : Single;
  FPhase : LongWord;
  FPhaseReg : LongWord;
  FPhaseRegIncrement : LongWord;
  FAmplitude : Single;
  Procedure FSetOnPhaseToAmplitude(Const AValue : TPhaseToAmplitude);
  Procedure SetPhaseRegIncrement;
Public
  Constructor Create(Const APhaseRegResolution : TNumberOfBits);
  Procedure SetWaveType (Const AValue : TDefinedWaveType);
  Procedure SetSampleRate(Const AValue : LongWord);
  Procedure SetFrequency (Const AValue : Single);
  Procedure Reset;
  Procedure Synthesize;
  Property PhaseRegResolution : TNumberOfBits Read FPhaseRegResolution;
  Property PhaseRegMaxPlus1 : LongWord Read FPhaseRegMaxPlus1;
  Property PhaseRegMax : LongWord Read FPhaseRegMax;
  Property PhaseRegHalfMax : LongWord Read FPhaseRegHalfMax;
  Property PhaseRegQuaterMax : LongWord Read FPhaseRegQuaterMax;
  Property WaveType : TWaveType Read FWaveType;
  Property SampeRate : LongWord Read FSampleRate;
  Property Frequency : Single Read FFrequency;
  Property Phase : LongWord Read FPhase;
  Property Amplitude : Single Read FAmplitude;
  Property OnPhaseToAmplitude : TPhaseToAmplitude Read FOnPhaseToAmplitude
  Write FSetOnPhaseToAmplitude;
End;

Implementation

Function PhaseToAmplitude_Sawtooth(Const ADDS : TDDS) : Single;
Begin
  Result := 0;
End;

Function PhaseToAmplitude_Square(Const ADDS : TDDS) : Single;
Begin
  If ADDS.Phase <= ADDS.PhaseRegHalfMax Then
    Result := -1
  Else
    Result := +1;
End;

Function PhaseToAmplitude_Triangle(Const ADDS : TDDS) : Single;
Begin
  Result := 0;
End;

Function PhaseToAmplitude_Sine(Const ADDS : TDDS) : Single;
Begin
  Result := Sin(2 * PI * ADDS.Phase/ADDS.PhaseRegMaxPlus1);
End;

Constructor TDDS.Create(Const APhaseRegResolution : TNumberOfBits);
Begin
  Inherited Create;
  FOnPhaseToAmplitude := Nil;
  FPhaseRegResolution := APhaseRegResolution;
  FPhaseRegMaxPlus1 := LongWord((1 Shl FPhaseRegResolution));
  FPhaseRegMax := LongWord((1 Shl FPhaseRegResolution) - 1);
  FPhaseRegHalfMax := LongWord(FPhaseRegMaxPlus1 Shr 1);
  FPhaseRegQuaterMax := LongWord(FPhaseRegMaxPlus1 Shr 2);
  FSampleRate := 44100;
  FFrequency := 100;
  SetPhaseRegIncrement;
  SetWaveType(wtSine);
  Reset;
End;

Procedure TDDS.FSetOnPhaseToAmplitude(Const AValue : TPhaseToAmplitude);
Begin
  If Not Assigned(AValue) Then Exit;
  FOnPhaseToAmplitude := AValue;
  FWaveType := wtCustom;
End;

Procedure TDDS.SetWaveType(Const AValue : TDefinedWaveType);
Begin
  FWaveType := AValue;
  Case FWaveType Of
    wtSawtooth : FOnPhaseToAmplitude := PhaseToAmplitude_Sawtooth;
    wtSquare : FOnPhaseToAmplitude := PhaseToAmplitude_Square;
    wtTriangle : FOnPhaseToAmplitude := PhaseToAmplitude_Triangle;
    wtSine : FOnPhaseToAmplitude := PhaseToAmplitude_Sine;
  End;
End;

Procedure TDDS.SetPhaseRegIncrement;
Begin
  FPhaseRegIncrement := LongWord(Trunc(FPhaseRegMax * FFrequency / FSampleRate)) And FPhaseRegMax;
End;

Procedure TDDS.SetSampleRate(Const AValue : LongWord);
Begin
  FSampleRate := AValue;
  SetPhaseRegIncrement;
End;

Procedure TDDS.SetFrequency(Const AValue : Single);
Begin
  FFrequency := AValue;
  SetPhaseRegIncrement;
End;

Procedure TDDS.Reset;
Begin
  FPhase := 0;
  FPhaseReg := 0;
End;

Procedure TDDS.Synthesize;
Begin
  FPhase := FPhaseReg;
  FAmplitude := FOnPhaseToAmplitude(Self);
  {$R-}
  FPhaseReg := LongWord(FPhaseReg + FPhaseRegIncrement) And FPhaseRegMax;
  {$R+}
End;
End.

