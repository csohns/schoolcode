Program  volume;
(*Chris Sohns*)

USES
     CRT;

CONST
     PI = 3.1415;

VAR
     v,
     r: real;

Begin
     Write('Enter in the radius of the sphere:  ');
     ReadLn(r);
     r := sqr(r) * r;
     v := (4 / 3) * PI * r;
     WriteLn('The volume is:  ',v:0:2);
     ReadLn;
End.