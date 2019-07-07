                     (*ASCII Menu Creator/Box Creator*)
                            (*Version  1.00.00*)
                       (*Source Code by Chris Sohns*)
                    (*Turbo Pascal Unit by Chris Sohns*)

UNIT MENU;

interface
TYPE
     MenuString = String[29];

(*Changes text colors*)
Procedure c(col, int, back: Integer);

(*Creates background for menus*)
Procedure BackDrop;

(*Lets the user easily create menus*)
Procedure MenC(X, Y, long:Integer; sel:Char; texts:MenuString; MenVar:Char);

(*Lets the user easily create boxes around text*)
Procedure Box(X, Y, long:Integer; texts:String; BoxVar:Char);
Procedure MenH(X, Y, long: Integer; texts: MenuString);

implementation
uses CRT, DOS;

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
Procedure BackDrop;
         Var                        {Creates menu background}
              lcv, chk: Integer;
              temp: Char;
              tamper: Boolean;
              tamper_check1, control1: String[5];
              tamper_check2, control2: String[7];
         Begin
              tamper := FALSE;
              control1 := 'Force';
              control2 := 'Command';
              tamper_check1 := 'Luxik';
              tamper_check2 := 'O{yymzp';
              For lcv := 1 to 5 do
                   Begin
                        chk := Ord(tamper_check1[lcv]);
                        dec(chk, 6);
                        temp := Chr(chk);
                        tamper_check1[lcv] := temp;
                   End;
              For lcv := 1 to 7 do
                   Begin
                        chk := Ord(tamper_check2[lcv]);
                        dec(chk, 12);
                        temp := Chr(chk);
                        tamper_check2[lcv] := temp;
                   End;
              If (tamper_check1 <> control1) or (tamper_check2 <> control2)
                   then tamper := TRUE;
              If tamper then
                   Begin
                        ClrScr;
                        c(7,1,0);
                        TextBackground(0);
                        WriteLn('MENU.TPU has been tampered with. . .Program halted');
                        halt;
                   End;
          GotoXY(1,1);
          c(14,2,1);
          WriteLn('…ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª');
          For lcv := 2 to 22 do
            Begin
               GotoXY(1, lcv);
               c(14,2,1);
               Write('∫');
               c(3,2,1);
               Write('∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞');
               c(14,2,1);
               Write('∫');
            End;
          Write('»ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ');
          c(7,2,1);
          Write(tamper_check1);
          c(14,2,1);
          Write('Õ');
          c(7,2,1);
          Write(tamper_check2);
          c(14,2,1);
          Write('º');
          c(7,0,0);
     End;
{////////////////////////////////////////////////////////////////}
    Procedure MenC(X, Y, long:Integer; sel:Char; texts:MenuString; MenVar:Char);
         Var
              lcv: Integer;
{////////////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Begin                      {Creates menus}
              If (MenVar = 'B') or (MenVar = 'O') then
                   Begin
                        GotoXY(X, Y);
                        c(14,2,1);
                        Write('…');
                        For lcv := 1 to long + 7 do
                             Write('Õ');
                        WriteLn('ª');
                   End;
              GotoXY(X, Y + 1);
              c(14,2,1);
              Write('∫ ');
              c(2,2,1);
              Write('<');
              c(4,2,1);
              Write(sel);
              c(2,2,1);
              Write('>  ');
              c(7,2,1);
              Write(texts);
              spa(long - Length(texts));
              {spa(24 - Length(texts));}
              c(14,2,1);
              GotoXY(X + (long + 7), Y + 1);
              {GotoXY(X + 31, Y + 1);}
              Write(' ∫');
              If (MenVar = 'E') or (MenVar = 'O') then
                   Begin
                        GotoXY(X, Y + 2);
                        c(14, 2, 1);
                        Write('»');
                        For lcv := 1 to long + 7 do
                             Write('Õ');
                        WriteLn('º');
                        GotoXY(1,1);
                   End;
              c(7,1,0);
         End;
{////////////////////////////////////////////////////////////////}
    Procedure Box(X, Y, long:Integer; texts:String; BoxVar:Char);
{////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Var                        {Creates text boxes}
              lcv, loc: Integer;
         Begin
              loc := 0;
              If (BoxVar = 'B') or (BoxVar = 'O') then
              Begin
                   If X = 0 then
                        Begin
                             X := (Trunc(40 - (Length(texts) div 2)));
                             loc := (X + Length(texts)) + 2;
                             GotoXY(X, Y);
                        End
                   Else GotoXY(X, Y);
                   c(14,2,1);
                   Write('…');
                   For lcv := 1 to long + 2 do
                        Write('Õ');
                   WriteLn('ª');
              End;
              If X = 0 then
                   Begin
                        X := (Trunc(40 - (Length(texts) div 2)));
                        GotoXY(X, Y + 1);
                   End
              Else GotoXY(X, Y + 1);
              c(14,2,1);
              Write('∫ ');
              c(7,2,1);
              Write(texts);
              spa(long - Length(texts));
              c(14,2,1);
              GotoXY(X + (long + 2), Y + 1);
              Write(' ∫');
              If (BoxVar = 'E') or (BoxVar = 'O') then
              Begin
                   GotoXY(X, Y + 2);
                   c(14, 2, 1);
                   Write('»');
                   For lcv := 1 to long + 2 do
                        Write('Õ');
                   WriteLn('º');
              End;
              If loc <> 0 then
                   GotoXY(loc, Y + 1);
              c(7,1,0);
         End;
{////////////////////////////////////////////////////////////////}
    Procedure MenH(X, Y, long:Integer; texts:MenuString);
         Var
              lcv: Integer;
{////////////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Begin                      {Creates menu header}
              GotoXY(X, Y);
              c(14,2,1);
              Write('…');
              For lcv := 1 to long + 7 do
                Write('Õ');
              WriteLn('ª');
              GotoXY(X, Y + 1);
              c(14,2,1);
              Write('∫ ');
              c(7,2,1);
              Write(texts);
              spa(long - Length(texts));
              {spa(24 - Length(texts));}
              c(14,2,1);
              Write(' ∫');
              GotoXY(X, Y + 2);
              c(14, 2, 1);
              Write('»');
              For lcv := 1 to long + 7 do
                   Write('Õ');
              WriteLn('º');
              GotoXY(1,1);
              c(7,1,0);
         End;
{////////////////////////////////////////////////////////////////}
Procedure GotoNew(Y,X:Integer);
     Begin
          GotoXY(X, Y);
     End;
{////////////////////////////////////////////////////////////////}
Begin
(*c(7,0,0);
ClrScr;
Delay(2000);
c(14,2,0);
GotoNew(7, 33);WriteLn('±±±±±±±±±±±±±±±±±±±');
GotoNew(8, 32);WriteLn('±                   ±');
GotoNew(9, 32);WriteLn('±                   ±');
GotoNew(10, 32);WriteLn('±                   ±');
GotoNew(11, 32);WriteLn('±                   ±');
GotoNew(12, 32);WriteLn('±                   ±');
GotoNew(13, 32);WriteLn('±                   ±');
GotoNew(14, 32);WriteLn('±                   ±');
GotoNew(15, 32);WriteLn('±                   ±');
GotoNew(16, 33);WriteLn('±±±±±±±±±±±±±±±±±±±');
GotoNew(1,1);
Delay(800);
c(12,2,0);
GotoNew(9, 36);WriteLn('±±±±±');
GotoNew(10, 36);WriteLn('±');
GotoNew(11, 36);WriteLn('±±±');
GotoNew(12, 36);WriteLn('±');
GotoNew(13, 36);WriteLn('±');
GotoNew(14, 36);WriteLn('±');
GotoNew(1,1);
Delay(200);
GotoNew(11, 44);WriteLn('±±±±±');
GotoNew(12, 44);WriteLn('±');
GotoNew(13, 44);WriteLn('±');
GotoNew(14, 44);WriteLn('±±±±±');
GotoNew(1,1);
Delay(2000);
{PLAY "MB L64O0AABCDEFGABCDEFG"}
c(14,2,0);
GotoNew(8, 31);WriteLn('±±±±±±±±±±±±±±±±±±±');
GotoNew(9, 30);WriteLn('±                   ±');
GotoNew(10, 30);WriteLn('±                   ±');
GotoNew(11, 30);WriteLn('±                   ±');
GotoNew(12, 30);WriteLn('±                   ±');
GotoNew(13, 30);WriteLn('±                   ±');
GotoNew(14, 30);WriteLn('±                   ±');
GotoNew(15, 30);WriteLn('±                   ±');
GotoNew(16, 30);WriteLn('±                   ±');
GotoNew(17, 31);WriteLn('±±±±±±±±±±±±±±±±±±±');
c(12,2,0);
GotoNew(10, 34);WriteLn('±±±±±');
GotoNew(11, 34);WriteLn('±');
GotoNew(12, 34);WriteLn('±±±');
GotoNew(13, 34);WriteLn('±');
GotoNew(14, 34);WriteLn('±');
GotoNew(15, 34);WriteLn('±');
GotoNew(12, 42);WriteLn('±±±±±');
GotoNew(13, 42);WriteLn('±');
GotoNew(14, 42);WriteLn('±');
GotoNew(15, 42);WriteLn('±±±±±');
c(7,1,0);
GotoNew(7, 33);WriteLn('±±±±±±±±±±±±±±±±±±±');
GotoNew(8, 52);WriteLn('±');
GotoNew(9, 32);WriteLn('±');
GotoNew(9, 52);WriteLn('±');
GotoNew(10, 32);WriteLn('±');
GotoNew(10, 52);WriteLn('±');
GotoNew(11, 32);WriteLn('±');
GotoNew(11, 52);WriteLn('±');
GotoNew(12, 32);WriteLn('±');
GotoNew(12, 52);WriteLn('±');
GotoNew(13, 32);WriteLn('±');
GotoNew(13, 52);WriteLn('±');
GotoNew(14, 32);WriteLn('±');
GotoNew(14, 52);WriteLn('±');
GotoNew(15, 32);WriteLn('±');
GotoNew(15, 52);WriteLn('±');
GotoNew(16, 33);WriteLn('±±±±±±±±±±±±±±±±±');
GotoNew(16, 51);WriteLn('±');
GotoNew(9, 36);WriteLn('±±±±±');
GotoNew(11, 36);WriteLn('±±±');
GotoNew(12, 36);WriteLn('±');
GotoNew(13, 36);WriteLn('±');
GotoNew(14, 36);WriteLn('±');
GotoNew(11, 44);WriteLn('±±±±±');
GotoNew(13, 44);WriteLn('±');
GotoNew(14, 44);WriteLn('±±±±±');
GotoNew(1,1);
Delay(2000);
{c(15,2);
GotoNew(23, 20);WriteLn('This has been a Force Command production. . .');
GotoNew(1,1);
Delay(4000);}
c(7,1,0);
ClrScr;*)
End.