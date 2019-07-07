Program Screen_Saver;

USES
  Crt, Graph;

VAR
  Gd, Gm : Integer;
  x, k, x1, y1, x2, y2, Radius, col, col2, Graph_Text, Text_Print: Integer;


Begin
  Gd := Detect; InitGraph(Gd, Gm, '');
  if GraphResult <> grOk then Halt(1);
  SetGraphMode(9);
  Randomize;
  col := 0;
  col2 := 0;
  Graph_Text := 0;
  Repeat
       Begin
            x1 := Random(639);
            y1 := Random(479);
            x2 := Random(639);
            y2 := Random(479);
            Graph_Text := Random(2);
            If Graph_Text = 1 then
                 Begin
                      SetTextStyle(DefaultFont, VertDir, 2);
                 End
            Else
                 Begin
                      SetTextStyle(DefaultFont, HorizDir, 2);
                 End;
            For x := 0 To 639 Do
                 Begin
                      col := col + 1;
                      SetColor(col);
                      Line(x1, y1, x, 0);
                 End;
            For x := 0 To 479 Do
                 Begin
                      col := col + 1;
                      SetColor(col);
                      Line(x1, y1, 639, x);
                 End;
            For x := 639 DownTo 0 Do
                 Begin
                      col := col + 1;
                      SetColor(col);
                      Line(x1, y1, x, 479);
                 End;
            For x := 479 DownTo 0 Do
                 Begin
                      col := col + 1;
                      SetColor(col);
                      Line(x1, y1, 0, x);
                 End;
            For Text_Print := 1 to 200 do
                 Begin
                      col2 := Random(16);
                      SetColor(col2);
                      OutTextXY(200, 200, 'Force Command');
                 End;
            ClearViewPort;
            NoSound;
       End;
  Until Keypressed;
  ReadLn;
  CloseGraph;
End.