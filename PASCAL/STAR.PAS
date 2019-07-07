                                {Chris Sohns}
                                {p. 88  #7-9}
                                 {Period  4}
                                  {Row  #2}



Program Doh;

USES
     CRT;

VAR
     for1, for2, counter: Integer;

Begin
     ClrScr;
     counter := 5;
     For for1 := 1 to 5 do
          Begin
               For for2 := 1 to counter do
                    Begin
                         Write('*');
                    End;
               WriteLn;
               counter := counter - 1;
          End;
     ReadLn;
End.

{////////////////////////////////////////////////////////////////////////}

Program Doh2;

USES
     CRT;

VAR
     for1, for2, for3, counter, spa_ctr: Integer;
     spa: char;

Begin
     ClrScr;
     counter := 1;              (*Star Counter*)
     spa := ' ';                (*Space*)
     spa_ctr := 4;              (*Space Counter*)
     For for1 := 1 to 5 do
          Begin
               For for2 := 1 to spa_ctr do
                    Begin
                         Write(spa);
                    End; {For2}
               For for3 := 1 to counter do
                    Begin
                         Write('*');
                    End; {For3}
               WriteLn;
               spa_ctr := spa_ctr - 1;
               counter := counter + 2;
          End; {For1}
     ReadLn;
End.

{///////////////////////////////////////////////////////////////////////////}

Program Doh3;

USES
     CRT;

VAR
     for1, for2, for3, for4, for5, for6, counter, spa_ctr: Integer;
     spa: char;

Begin
     ClrScr;
     counter := 1;
     spa := ' ';
     spa_ctr := 4;
          For for1 := 1 to 5 do
               Begin
                    For for2 := 1 to spa_ctr do
                         Begin
                              Write(spa);
                         End;
                    For for3 := 1 to counter do
                         Begin
                              Write('*');
                         End;
                    WriteLn;
                    spa_ctr := spa_ctr - 1;
                    counter := counter + 2;
               End;
          spa_ctr := 1;
          counter := 7;
          For for4 := 1 to 4 do
               Begin
                    For for5 := 1 to spa_ctr do
                         Begin
                              Write(spa);
                         End;
                    For for6 := 1 to counter do
                         Begin
                              Write('*');
                         End;
                    WriteLn;
                    spa_ctr := spa_ctr + 1;
                    counter := counter - 2;
               End;
     ReadLn;
End.
