UNIT ANSWERS;

interface

Const
     STRI26 = 26;
     STRI1 = 1;
     STRI2 = 2;
     STRI76 = 76;
     STRI6 = 6;
     STRI40 = 40;
     STRI60 = 60;
     STRI17 = 17;
     STRI20 = 20;
     STRILOG = 76;
     STRI8 = 8;
     STRI10 = 10;
     STRI11 = 11;
     STRI5 = 5;

Type
     ST26 = String[STRI26];
     ST1 = String[STRI1];
     ST2 = String[STRI2];
     ST76 = String[STRI76];
     ST6 = String[STRI6];
     ST40 = String[STRI40];
     ST60 = String[STRI60];
     ST17 = String[STRI17];
     ST20 = String[STRI20];
     STLOG = String[STRILOG];
     ST8 = String[STRI8];
     ST10 = String[STRI10];
     ST11 = String[STRI11];
     ST5 = String[STRI5];

Procedure answer26(var name2: ST26; X, Y: Integer);
Procedure answer1(var name2: ST1; X, Y: Integer);
Procedure answer2(var name2: ST2; X, Y: Integer);
Procedure answer76(var name2: ST76; X, Y: Integer);
Procedure answer6(var name2: ST6; X, Y: Integer);
Procedure answer40(var name2: ST40; X, Y: Integer);
Procedure answer60(var name2: ST60; X, Y: Integer);
Procedure answer17(var name2: ST17; X, Y: Integer);
Procedure answer20(var name2: ST20; X, Y: Integer);
Procedure answerLOG(var name2: STLOG; X, Y: Integer);
Procedure answerLOGInVis(var name2: STLOG; X, Y: Integer);
Procedure answer8(var name2: ST8; X, Y: Integer);
Procedure answer10(var name2: ST10; X, Y: Integer);
Procedure answer11(var name2: ST11; X, Y: Integer);
Procedure answer5(var name2: ST5; X, Y: Integer);

implementation

Uses CRT, DOS;


Procedure answer26(var name2: ST26; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[26];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 26 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer1(var name2: ST1; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[1];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 1 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer2(var name2: ST2; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[2];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 2 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer76(var name2: ST76; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[76];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 76 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer6(var name2: ST6; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[6];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 6 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer40(var name2: ST40; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[40];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 40 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer60(var name2: ST60; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[60];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 60 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer17(var name2: ST17; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[17];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 17 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              {Write(Char_Temp);}
                              Write('*');
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer20(var name2: ST20; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[20];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 20 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answerLOG(var name2: STLOG; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[255];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 255 then
                         Begin
                              {Sound(900);
                              Delay(200);
                              NoSound;}
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answerLOGInVis(var name2: STLOG; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[255];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 255 then
                         Begin
                              {Sound(900);
                              Delay(200);
                              NoSound;}
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              {Write(Char_Temp);}
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer8(var name2: ST8; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[8];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 8 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer10(var name2: ST10; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[10];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 10 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer11(var name2: ST11; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[11];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 11 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
Procedure answer5(var name2: ST5; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[5];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 5 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;


Begin
End.