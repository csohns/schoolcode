Program Pressure;

Type
     Altitude = Array[-273..200] of Integer;

Var
     Alti       :altitude;
     Press, num :Integer;

Begin
     Write('Enter an altitude: ');
     ReadLn(num);
     While (num > 200) or (num < -273) do
          Begin
               WriteLn('An altitude between -273 and 200!!');
               WriteLn;
               Write('Enter an altitude: ');
               ReadLn(num);
          End;
     Write('Enter the pressure: ');
     ReadLn(Press);
     Alti[num] := Press;
End.