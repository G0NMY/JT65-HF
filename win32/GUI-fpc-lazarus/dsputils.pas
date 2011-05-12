unit dsputils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils; 

type
     TSingleArray = Array of Single;

implementation
     // Gaussian random numbers
     // This algorithm (adapted from "Natur als fraktale Grafik" by
     // Reinhard Scholl) implements a generation method for gaussian
     // distributed random numbers with mean=0 and variance=1
     // (standard gaussian distribution) mapped to the range of
     // -1 to +1 with the maximum at 0.
     // For only positive results you might abs() the return value.
     // The q variable defines the precision, with q=15 the smallest
     // distance between two numbers will be 1/(2^q div 3)=1/10922
     // which usually gives good results.

     // Note: the random() function used is the standard random
     // function from Delphi/Pascal that produces *linear*
     // distributed numbers from 0 to parameter-1, the equivalent
     // C function is probably rand().

     function GRandom:single;
     const
          q=15;
          c1=(1 shl q)-1;
          c2=(c1 div 3)+1;
          c3=1/c1;
     begin
          result:=(2*(random(c2)+random(c2)+random(c2))-3*(c2-1))*c3;
     end;

// Hilbert Filter Coefficient Calculation
//
// Type : Uncle Hilbert
// References : Posted by Christian[at]savioursofsoul[dot]de
//
// Notes :
// This is the delphi code to create the filter coefficients, which are needed
// to phaseshift a signal by 90°
//
// This may be useful for an evelope detector...
//
// By windowing the filter coefficients you can trade phase response flatness
// with magnitude response flatness.
//
// I had problems checking its response by using a dirac impulse. White noise
// works fine.
//
// Also this introduces a latency of N/2!
//

procedure UncleHilbert(var FilterCoefficients: TSingleArray; N : Integer);
var
     i : Integer;
begin
     SetLength(FilterCoefficients,N);
     for i:=0 to (N div 4) do
     begin
          FilterCoefficients[(N div 2)+(2*i-1)]:=+2/(PI*(2*i-1));
          FilterCoefficients[(N div 2)-(2*i-1)]:=-2/(PI*(2*i-1));
     end;
end;

end.

