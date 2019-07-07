Program Battle_Ship;

Uses CRT;

Type
     Group1= Array['A'..'T', 1..9] of Integer;
     Group2 = Array['A'..'T', 1..9] of Integer;

Var
     P1: Group1;
     P2: Group2;

{//////////////////////////////////////////////////////////////////////////}
Procedure c(col, int, back: Integer);
     Begin                      {Changes text color}
          If (col > 0) and (col < 32) then
               TextColor(col)
          Else TextColor(7);
          Case int of
               0: NormVideo;
               1: LowVideo;
               2: HighVideo;
          End;
          If (back > -1) and (back < 9) then
               TextBackground(back);
     End;
{////////////////////////////////////////////////////////////////}
Procedure InitField(var P1:Group1;var P2:Group2);
     Var
          lcv1: Char;
          lcv2: Integer;
     Begin
          For lcv1 := 'A' to 'T' do
               For lcv2 := 1 to 9 do
                    Begin
                         P1[lcv1,lcv2] := 0;
                         P2[lcv1,lcv2] := 0;
                    End;
     End;
{//////////////////////////////////////////////////////////////////////////}
Procedure DisplayField(P1:Group1; P2:Group2);
     Var
          lcv1: Char;
          lcv2: Integer;
     Begin
          c(7,1,0);
          ClrScr;
          c(4,1,1);
          WriteLn(' ABCDEFGHIJKLMNOPQRST');
          For lcv2 := 1 to 9 do
               Begin
                    WriteLn(lcv2);
               End;
          GotoXY(2,2);
          For lcv2 := 1 to 9 do
               Begin
                    GotoXY(2,WhereY);
                    For lcv1 := 'A' to 'T' do
                         Begin
                              Case P1[lcv1,lcv2] of
                                   0: Begin
                                           c(1,2,0);
                                           Write('А');
                                      End;
                                   1: Begin
                                           c(7,1,0);
                                           Write('В');
                                      End;
                                   2: Begin
                                           c(8,2,0);
                                           Write('л');
                                      End;
                                   3: Begin
                                           c(4,2,0);
                                           Write('л');
                                      End;
                              End;
                         End;
                    WriteLn;
               End;
          WriteLn;
          c(14,2,0);
          WriteLn('лллллллллллллллллллллл');
          WriteLn;
          c(4,1,1);
          WriteLn(' ABCDEFGHIJKLMNOPQRST');
          For lcv2 := 1 to 9 do
               Begin
                    WriteLn(lcv2);
               End;
          c(7,2,0);
          GotoXY(23,3);
          WriteLn('C');
          GotoXY(23,4);
          WriteLn('o');
          GotoXY(23,5);
          WriteLn('m');
          GotoXY(23,6);
          WriteLn('p');
          GotoXY(23,7);
          WriteLn('u');
          GotoXY(23,8);
          WriteLn('t');
          GotoXY(23,9);
          WriteLn('e');
          GotoXY(23,10);
          WriteLn('r');
          GotoXY(2,15);
          For lcv2 := 1 to 9 do
               Begin
                    GotoXY(2,WhereY);
                    For lcv1 := 'A' to 'T' do
                         Begin
                              Case P2[lcv1,lcv2] of
                                   0: Begin
                                           c(1,2,0);
                                           Write('А');
                                      End;
                                   1: Begin
                                           c(7,1,0);
                                           Write('В');
                                      End;
                                   2: Begin
                                           c(8,2,0);
                                           Write('л');
                                      End;
                                   3: Begin
                                           c(4,2,0);
                                           Write('л');
                                      End;
                              End;
                         End;
                    WriteLn;
               End;
          c(7,2,0);
          GotoXY(23,16);
          WriteLn('P');
          GotoXY(23,17);
          WriteLn('l');
          GotoXY(23,18);
          WriteLn('a');
          GotoXY(23,19);
          WriteLn('y');
          GotoXY(23,20);
          WriteLn('e');
          GotoXY(23,21);
          WriteLn('r');
          c(7,1,0);
     End;
{//////////////////////////////////////////////////////////////////////////}
Begin
     InitField(P1, P2);
     DisplayField(P1, P2);
     ReadLn;
End.