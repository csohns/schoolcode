Program yard_feet_inches;
(*Chris Sohns*)

USES
     CRT;
CONST
     yard=36;
     feet=12;
VAR
     inches: integer;

Begin
     ClrScr;
     Write('Enter in the amount of inches ');
     ReadLn(inches);
     WriteLn;
     WriteLn;
     WriteLn('Yards = ',inches div yard);
     inches:= inches mod yard;
     WriteLn('Feet = ',inches div feet);
     inches:= inches mod feet;
     WriteLn('Inches = ',inches);
     ReadLn;
End.