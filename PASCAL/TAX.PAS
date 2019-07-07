Program TAX;


USES
     CRT;
VAR
     amount,
     taxrate,
     dcmlrate,
     salestax,
     total: real;
     i:integer;
Begin
     ClrScr;
     Write('Amount of purchase? ');
     ReadLn(amount);
     Write('Sales tax rate (in persent)? ');
     ReadLn(taxrate);
     WriteLn;
     dcmlrate:= taxrate / 100.0;
     salestax:= amount * dcmlrate;
     total:=amount + salestax;
     WriteLn('The sales tax is ', salestax:5:2);
     WriteLn;
     WriteLn('The total amount to be paid is ', total:8:2);
     ReadLn;
End.