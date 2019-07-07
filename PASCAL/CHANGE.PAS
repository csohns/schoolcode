Program make_change;

USES
     CRT;
CONST
     halfdollar = 50;
     quarter    = 25;
     dime       = 10;
     nickel     = 5;
VAR
     change: integer;

Begin
     ClrScr;
     Write('Amount of change in cents?  ');
     ReadLn(change);
     WriteLn;
     WriteLn('Halves    ', change div halfdollar);
     change:= change mod halfdollar;
     WriteLn('Quarters  ', change div quarter);
     change:= change mod quarter;
     WriteLn('Dimes     ', change div dime);
     change:= change mod dime;
     WriteLn('Nickels   ', change div nickel);
     change:= change mod nickel;
     WriteLn('Pennies   ', change);
     ReadLn;
End.