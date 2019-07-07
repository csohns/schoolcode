Program feet_inches;
(*Chris Sohns*)

USES
     CRT;

VAR
     feet,
     inches: integer;
     centa: real;

Begin
     ClrScr;
     Write('Enter in amount of feet ');
     ReadLn(feet);
     WriteLn;
     Write('Enter in amount of inches ');
     ReadLn(inches);
     WriteLn;
     inches:= feet * 12 + inches;
     centa:= inches * 2.54;
     WriteLn;
     WriteLn('Centimeters => ',centa:0:2);
     ReadLn;
End.