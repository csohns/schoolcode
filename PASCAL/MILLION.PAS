Program Millianaire;

USES CRT;

CONST
     milliondollars = 1e8;

VAR
     Dailywages, Totalwages: REAL;
     Daysworked: INTEGER;
Begin
     ClrScr;
     (*Dailywages := 1.0;*)
     Daysworked := 0;
     Totalwages := 0.0;
     Write('How many dollars for you earn a day?  ');
     ReadLn(Dailywages);
     while Totalwages < milliondollars do
          Begin
               Totalwages := Totalwages + Dailywages;
               Daysworked := Daysworked + 1;
               Dailywages := 2.0 * Dailywages
          End;
     WriteLn('After ', Daysworked, ' days you will have ', Totalwages / 100.0:0:2, ' dollars');
     ReadLn;
End.