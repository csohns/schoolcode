Unit PONG;

Interface
Procedure Pong_Game;

Implementation
Uses CRT, DOS;

Var
     X, Y, BX, BY, BM, cntr:Integer;
     loose: Boolean;
     sel: Char;

Procedure BkDr;
     Var
          lcv: Integer;
     Begin
          GotoXY(1,1);
          TextColor(14);
          WriteLn('ษอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
          For lcv := 2 to 24 do
               Begin
                    GotoXY(1, lcv);
                    Write('บ');
                    GotoXY(77,lcv);
                    Write('บ');
               End;
          WriteLn;
          Write('ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ');
          TextColor(7);
     End;
Procedure ball(Var BX, BY:Integer);
     Begin
          GotoXY(BX, BY);
          Write('o');
     End;

Procedure bar(Var X, Y:Integer);
     Begin
          GotoXY(X - 2, Y);
          Write('ฤฤฤฤฤ');
     End;
Procedure barL(Var X, Y:Integer);
     Begin
          GotoXY(X - 2, Y);
          Write('     ');
          X := X - 1;
          If X < 4 then X := 4;
          GotoXY(X - 2, Y);
          Write('ฤฤฤฤฤ');
          GotoXY(X, Y);
     End;
Procedure barR(Var X, Y:Integer);
     Begin
          GotoXY(X - 2, Y);
          Write('     ');
          X := X + 1;
          If X > 74 then X := 74;
          GotoXY(X - 2, Y);
          Write('ฤฤฤฤฤ');
          GotoXY(X, Y);
     End;

Procedure DwRi(Var BX, BY, BM:Integer; Var loose:Boolean);
     Begin
          GotoXY(BX, BY);
          Write(' ');
          BX := BX + 1;
          BY := BY + 1;
          If BY > 23 then loose := TRUE;
          If (BX > (X - 3)) and (BX < (X + 3)) and (BY = 23) then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    dec(BX, 1);
                    dec(BY, 1);
                    BM := 2;
               End;
          If BX > 76 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    dec(BX, 1);
                    dec(BY, 1);
                    BM := 4;
               End;
          GotoXY(BX, BY);
          Write('o');
     End;
Procedure UpRi(Var BX, BY, BM:Integer);
     Begin
          GotoXY(BX, BY);
          Write(' ');
          BX := BX + 1;
          BY := BY - 1;
          If BY < 2 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    dec(BX, 1);
                    inc(BY, 1);
                    BM := 1;
               End;
          If BX > 76 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    dec(BX, 1);
                    inc(BY, 1);
                    BM := 3;
               End;
          GotoXY(BX, BY);
          Write('o');
     End;
Procedure UpLe(Var BX, BY, BM:Integer);
     Begin
          GotoXY(BX, BY);
          Write(' ');
          BX := BX - 1;
          BY := BY - 1;
          If BY < 2 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    inc(BX, 1);
                    inc(BY, 1);
                    BM := 4;
               End;
          If BX < 2 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    inc(BX, 1);
                    inc(BY, 1);
                    BM := 2;
               End;
          GotoXY(BX, BY);
          Write('o');
     End;
Procedure DwLe(Var BX, BY, BM:Integer; Var loose:Boolean);
     Begin
          GotoXY(BX, BY);
          Write(' ');
          BX := BX - 1;
          BY := BY + 1;
          If BY > 23 then loose := TRUE;
          If (BX > (X - 3)) and (BX < (X + 3)) and (BY = 23) then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    inc(BX, 1);
                    dec(BY, 1);
                    BM := 3;
               End;
          If BX < 2 then
               Begin
                    Sound(900);
                    Delay(8);
                    NoSound;
                    inc(BX, 1);
                    dec(BY, 1);
                    BM := 1;
               End;
          GotoXY(BX, BY);
          Write('o');
     End;

Procedure Pong_Game;
Begin
     ClrScr;
     BkDr;
     loose := FALSE;
     cntr := 0;
     X := 40;
     Y := 23;
     BX := 2;
     BY := 2;
     BM := 1;
     ball(BX, BY);
     bar(X,Y);
     Repeat
     Repeat
          inc(cntr, 1);
          If cntr = 800 then
               Begin
                    cntr := 0;
                    Case BM of
                         1: DwRi(BX, BY, BM, loose);
                         2: UpRi(BX, BY, BM);
                         3: UpLe(BX, BY, BM);
                         4: DwLe(BX, BY, BM, loose);
                    End;
               End;
     Until (Keypressed) or (loose);
          If NOT loose then
          Begin
          sel := ReadKey;
          If Ord(sel) = 075 then
               Begin
                    BarL(X,Y);
               End;
          If Ord(sel) = 077 then
               Begin
                    BarR(X,Y);
               End;
          End;
     Until loose;
     ClrScr;
End;

Begin
End.