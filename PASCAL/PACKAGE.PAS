Program package;
(*Chris Sohns*)

USES
     CRT;

VAR
     l,
     w,
     h,
     girth: real;

Begin
     Write('Enter in the length of the package:  ');
     ReadLn(l);
     Write('Enter in the width of the package:  ');
     ReadLn(w);
     Write('Enter in the higth of the package:  ');
     ReadLn(h);
     girth := h + h + w + w;
     WriteLn(l + girth <= 100);
     ReadLn;
End.