Program convert;
(*Chris Sohns*)

VAR
     i:integer;
     fahrenheit, celsius:real;
Begin
     Write('Fahrenheit temperture?  ');
     ReadLn(fahrenheit);
     celsius:= (5.0/9.0)*(fahrenheit-32.0);
     WriteLn('Celsius tempture is ', celsius:6:1);
     ReadLn;
End.