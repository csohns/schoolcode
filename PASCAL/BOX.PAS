Program rect;
(*Chris Sohns
  Period 4
  Roe #2*)

USES
     CRT;

VAR
     l,          (*The length of the box*)
     h,          (*The height of the box*)
     w,          (*The width of the box*)
     v,          (*The volume of the box*)
     sa: real;   (*The surface area of the box*)

Begin
     ClrScr;
     Write('Length:  ');
     ReadLn(l);
     Write('Height:  ');
     ReadLn(h);
     Write('Width:   ');
     ReadLn(w);
     WriteLn;
     WriteLn;
     v := l * w * h;
     sa := ((l + w) * 4) + ((w + h) * 2);
     WriteLn('Volume        =    ', v:0:0);
     WriteLn('Surface Area  =    ', sa:0:0);
     ReadLn;
End.