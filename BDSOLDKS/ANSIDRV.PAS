Unit ANSIDRV;

interface
USES
     CRT;

Procedure ANSI(Fname:String; time:Integer);

implementation
{////////////////////////////////////////////////////////////////////}
Procedure ANSI(Fname:String;time:Integer);
     Var
          TamperCheck: String[11];
          F: Text;
          num: Array[1..4] of Integer;
          lcv, lcv2: Integer;
          chrr: Char;
          X, Y: Integer;
          high, stop, first: Boolean;
          lstcolor: Integer;
{///////////////////////////////////////////}
  Procedure skipchar(var F:Text);
       Var
            skip: Char;
       Begin
            Read(F, skip);
       End;
{///////////////////////////////////////////}
Procedure ReNum;
     Var
          lcv: Integer;
     Begin
          For lcv := 1 to 4 do
               num[lcv] := 0;
     End;
{///////////////////////////////////////////}
Procedure FindColor(lcv: Integer;var high:Boolean);
     Var
          lcv2: Integer;
{//////////////////}
Procedure ReRun(lstcolor:Integer);
     Begin
          Case lstcolor of
               30:  TextColor(8);
               31:  TextColor(Lightred);
               32:  TextColor(Lightgreen);
               33:  TextColor(yellow);
               34:  TextColor(Lightblue);
               35:  TextColor(Lightmagenta);
               36:  TextColor(Lightcyan);
               37:  TextColor(white);
          End;
     End;
{//////////////////}
     Begin
          For lcv2 := 1 to lcv do
               Begin
                    If high then
                      Case num[lcv2] of
                          0:  Begin
                                   high := false;
                                   TextColor(white);
                                   TextBackground(black);
                                   lstcolor := 37;
                              End;
                          1:  Begin
                                   high := true;
                                   ReRun(lstcolor);
                              End;
                         30:  TextColor(8);
                         31:  TextColor(Lightred);
                         32:  TextColor(Lightgreen);
                         33:  TextColor(yellow);
                         34:  TextColor(Lightblue);
                         35:  TextColor(Lightmagenta);
                         36:  TextColor(Lightcyan);
                         37:  TextColor(white);
                         40:  TextBackground(black);
                         41:  TextBackground(red);
                         42:  TextBackground(green);
                         43:  TextBackground(yellow);
                         44:  TextBackground(blue);
                         45:  TextBackground(magenta);
                         46:  TextBackground(cyan);
                         47:  TextBackground(white);
                      End;
                    If NOT high then
                      Case num[lcv2] of
                          0:  Begin
                                   high := false;
                                   TextColor(7);
                                   TextBackground(black);
                                   lstcolor := 37;
                              End;
                          1:  Begin
                                   high := true;
                                   ReRun(lstcolor);
                              End;
                         30:  TextColor(black);
                         31:  TextColor(red);
                         32:  TextColor(green);
                         33:  TextColor(brown);
                         34:  TextColor(blue);
                         35:  TextColor(magenta);
                         36:  TextColor(cyan);
                         37:  TextColor(7);
                         40:  TextBackground(black);
                         41:  TextBackground(red);
                         42:  TextBackground(green);
                         43:  TextBackground(yellow);
                         44:  TextBackground(blue);
                         45:  TextBackground(magenta);
                         46:  TextBackground(cyan);
                         47:  TextBackground(white);
                      End;
                      If (num[lcv2] >= 30) and (num[lcv2] <= 37) then
                           lstcolor := num[lcv2];
               End;
     End;
{///////////////////////////////////////////}
     Begin
          stop := false;
          Assign(F, Fname);
          {$I-}
          ReSet(F);
          Close(F);
          {$I+}
          If IOResult <> 0 then stop := true;
          If NOT stop then
          Begin
          ReSet(F);
          high := false;
          lcv := 1;
          lstcolor := 37;
          first := true;
          ReNum;
          While NOT EOF(F) do
            Begin
              Read(F, chrr);
              If Ord(chrr) = 27 then
                Begin
                  skipchar(F);
                  Repeat
                    Read(F, chrr);
                    Case Ord(chrr) of
                      48..57:  Begin
                                 num[lcv] := num[lcv] * 10;
                                 num[lcv] := num[lcv] + Ord(chrr) - 48;
                                 first := false;
                               End;
                          59:  Begin
                                 If first then
                                   Begin
                                     num[lcv] := 1;
                                     first := false;
                                   End;
                                 inc(lcv, 1);
                               End;
                    End;
                  Until ((Ord(chrr) < 48) or (Ord(chrr) > 57)) and
                        (Ord(chrr) <> 59);
                  chrr := UpCase(chrr);
                  Case chrr of
                    'J':  ClrScr;
                    'H':  Begin
                            If num[2] = 0 then
                              GotoXY(1, num[1])
                            Else GotoXY(num[2], num[1]);
                          End;
                    'F':  GotoXY(num[1], num[2]);
                    'A':  Begin
                            If num[1] = 0 then
                              GotoXY(WhereX, WhereY - 1)
                            Else GotoXY(WhereX, WhereY - num[1]);
                          End;
                    'B':  Begin
                            If num[1] = 0 then
                              GotoXY(WhereX, WhereY + 1)
                            Else GotoXY(WhereX, WhereY + num[1]);
                          End;
                    'C':  Begin
                            If num[1] = 0 then
                              GotoXY(WhereX + 1, WhereY)
                            Else GotoXY(WhereX + num[1], WhereY);
                          End;
                    'D':  Begin
                            If num[1] = 0 then
                              GotoXY(WhereX - 1, WhereY)
                            Else GotoXY(WhereX - num[1], WhereY);
                          End;
                    'S':  Begin
                            X := WhereX;
                            Y := WhereY;
                          End;
                    'U':  GotoXY(X, Y);
                    'K':  Begin
                            For lcv2 := WhereX to 80 do
                              Write(' ');
                          End;
                    'M':  FindColor(lcv, high);
                  End;
                  lcv := 1;
                  ReNum;
                  first := true;
                End
              Else Write(chrr);
              Delay(time);
            End;
          Close(F);
          NormVideo;
          TextColor(7);
          TextBackground(0);
          End;
     End;
{////////////////////////////////////////////////////////////////////}
Var
     TamperCheck: String[11];
     chk: Integer;
     lcv: Integer;
Begin
     TamperCheck := 'Kpzq{' + chr(40) + '[wpv{';
     WriteLn;
     GotoXY(25,WhereY);
     TextColor(LightRed);
     Write('A');
     TextColor(Yellow);
     Write('ù');
     TextColor(LightMagenta);
     Write('N');
     TextColor(Yellow);
     Write('ù');
     TextColor(LightBlue);
     Write('S');
     TextColor(Yellow);
     Write('ù');
     TextColor(LightGreen);
     Write('I');
     TextColor(7);
     Write(' protocol by ');
     TextColor(Yellow);
     TextBackGround(Blue);
     For lcv := 1 to 11 do
          Begin
               chk := Ord(TamperCheck[lcv]);
               dec(chk, 8);
               Write(Chr(chk));
          End;
     TextColor(7);
     TextBackGround(0);
     TextColor(black);
     Write(' ');
     GotoXY(WhereX - 1, WhereY);
     Delay(2000);
     TextColor(7);
     TextBackGround(0);
     WriteLn;
End.