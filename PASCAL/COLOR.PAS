

{ Example for Line }

uses
  Crt, Graph;
var
  Gd, Gm : Integer;
  x, k, x1, y1, x2, y2, Radius : integer;
begin
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
  SetGraphMode(9);
  Randomize;
  for k := 1 to 200 do
  Begin
       x1 := Random(639);
       y1 := Random(479);
       x2 := Random(639);
       y2 := Random(479);
       for x := 0 to 639 do
            Begin
                 SetColor(Random(GetMaxColor) +1);
                 line(x1, y1, x, 0);
                 SetColor(Random(GetMaxColor) +1);
                 line(y2, x2, x, 0);
            End;
       for x := 0 to 479 do
            Begin
                 SetColor(Random(GetMaxColor) +1);
                 line(x1, y1, 639, x);
                 SetColor(Random(GetMaxColor) +1);
                 line(y2, x2, 639, x);
            End;
       for x := 639 downto 0 do
            Begin
                 SetColor(Random(GetMaxColor) +1);
                 line(x1, y1, x, 479);
                 SetColor(Random(GetMaxColor) +1);
                 line(y2, x2, x, 479);
            End;
       for x := 479 downto 0 do
            Begin
                 SetColor(Random(GetMaxColor) +1);
                 line(x1, y1, 0, x);
                 SetColor(Random(GetMaxColor) +1);
                 line(y2, x2, 0, x);
            End;
  End;
  ReadLn;
  CloseGraph;
end.