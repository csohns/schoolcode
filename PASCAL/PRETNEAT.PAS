{Adam Farley}
uses
  Crt, Graph;
var
  Gd, X, Y, Gm : Integer;
  radius       : Integer;

begin
  clrscr;
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
  Randomize;
  repeat
  For X := 0 to 639 do
    Begin
     X:=X+1;
     Setcolor(random(getmaxcolor)+1);
     Line(319, 239, X, 0);
    end;
  For Y := 0 to 479 do
    Begin
       Y:=Y+1;
       Setcolor(random(getmaxcolor)+1);
       Line(319, 239, 639, Y);
    end;

  For X := 639 downto 0 do
    Begin
       X:=X-1;
       Setcolor(random(getmaxcolor)+1);
       Line(319, 239, X, 479);
    end;
  For Y := 479 downto 0 do
    Begin
       Y:=Y-1;
       Setcolor(random(getmaxcolor)+1);
       Line(319, 239, 0, y);
   end;
   repeat
   For Radius := 1 to 78 do
     Begin
        setcolor(random(getmaxcolor)+1);
        Circle(319, 239, radius*3);
     end;
   For Radius := 78 downto 1 do
     Begin
        Setcolor (random(getmaxcolor)+1);
        Circle(319, 239, Radius*3);
     end;
    until keypressed;
  until KeyPressed;
  CloseGraph;
end.
