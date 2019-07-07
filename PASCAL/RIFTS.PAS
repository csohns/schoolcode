Program RIFTS_charactor_creation;

Uses CRT, DOS, MENU, ROLLDIE;

Var
  sel: Char;

Procedure MID(sup:String; start:Integer; length:Integer);
  Var adof:Integer;
  Begin
    For adof := 0 to length do
      Begin
        Write(sup[start + adof]);
      End;
  End;

Procedure SparklePause;
  Var
     sup : String;
     tap: String;
     a, b, c, cntr : Integer;
  Begin
    TextColor(4);
    cntr := 0;
    sup := ('*    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    *    ');
    tap := '';
    WHILE tap = '' do
      Begin
        inc(cntr, 1);
        FOR a := 1 TO 5 do
          Begin
            GotoXY(1, 1);
            MID(sup, a, 80);
            GotoXY(1, 22);
            MID(sup, 6 - a, 80);

            FOR b := 2 TO 21 do
              Begin
                c := (a + b) MOD 5;
                IF c = 1 THEN
                  Begin
                    GotoXY(80,b);
                    Write('*');
                    GotoXY(1,23 - b);
                    Write('*');
                  End
                ELSE
                  Begin
                    GotoXY(80,b);
                    Write(' ');
                    GotoXY(1,23 - b);
                    Write(' ');
                  End;
            End;  (*b*)
          End;  (*a*)
        If cntr = 40 then tap := 'STOP';
    End;  (*while*)
  End;

Procedure Start;
  Begin
  End;

Begin
  ClrScr;
  Box(26,10,26,'RIFTS - charector creation','O');
  SparklePause;
  ClrScr;
  Repeat
    BackDrop;
    MenuCreator(30,11,14,'S','Start creation','B');
    MenuCreator(30,12,14,'Q','Quit','E');
    GotoXY(1,1);
    Repeat
      Repeat
        sel := ReadKey;
      Until sel <> '';
      sel := UpCase(sel);
      Case sel of
        'S':  Start;
      End;
    Until (sel = 'S') or (sel = 'Q');
  Until sel = 'Q';
End.