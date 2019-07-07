Program Cylinder;

CONST
     PI=3.141593;
VAR
     diameter, height, volume:real;

Begin
     write('Diameter?  ');
     readln(diameter);
     write('Height?  ');
     readln(height);
     volume:=pi*sqr(diameter)*height/4.0;
     writeln('Volume is ',volume:8:3);
     readln;
end.