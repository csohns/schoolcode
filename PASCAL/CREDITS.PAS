Unit credits;

interface
Type String80 = String[80];

Procedure credit(line1, line2, name:String80);

implementation
Uses crt, dos;

Procedure c(col,int,bk:Integer);
     Begin
          TextColor(col);
          Case int of
               0: NormVideo;
               1: LowVideo;
               2: HighVideo;
          End;
          TextBackGround(bk);
     End;

Procedure center(texts:String80; lineNUM:Integer);
     Begin
          GotoXY(40 - (Length(texts) div 2), lineNUM);
     End;

Procedure clear(texts:String80; lineNUM:Integer);
     Var
          lcv: Integer;
     Begin
          center(texts, lineNUM);
          For lcv := 1 to Length(texts) do
               Write(' ');
     End;

Procedure credit(line1, line2, name:String80);
     Var
          lcv: Integer;
     Begin
          center(line1, 11);
          c(7,2,0);
          Write(line1);
          center(line2, 12);
          Write(line2);
          GotoXY(1,1);
          Delay(1500);
          For lcv := 1 to 6 do
               Begin
                    center(name, 14);
                    Case lcv of
                         1,5: c(8,2,0);
                         2,4: c(4,1,0);
                         3: c(12,2,0);
                         6: c(8,1,0);
                    End;
                    Write(name);
                    If lcv = 3 then
                         Begin
                              GotoXY(1,1);
                              Delay(2000);
                         End
                    Else Begin
                              GotoXY(1,1);
                              Delay(500);
                         End;
               End;
          GotoXY(1,1);
          Delay(1500);
          clear(line1, 11);
          clear(line2, 12);
          clear(name, 14);
          c(7,0,0);
     End;

Begin
End.