

{ Example for Bar3D }

uses
  Graph;
var
  Gd, Gm: Integer;
  y0, y1, y2, x1, x2: Integer;
  col, k: Integer;
begin
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
  SetGraphMode(9);
  Randomize;
  col := 0;
  y0 := 10;
  y1 := 60;
  y2 := 110;
  x1 := 0;
  x2 := 40;
  For k := 0 to 15 do
       Begin
            SetColor(col);
            rectangle(x1, y0, x2, y1);
            col := col + 1;
            x1 := x1 + 42;
            x2 := x2 + 42;
       End;
  ReadLn;
  CloseGraph;
end.


