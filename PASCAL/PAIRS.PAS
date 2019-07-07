Program Fibonacci;
(*Chris Sohns
  Period 7
  Row 2*)

VAR
     pairs,
     fertilepairs,
     pairsnextmonth,
     months,
     i: integer;

Begin
     Write('Starting number of pairs?  ');
     ReadLn(pairs);
     Write('Starting number of fertile pairs?  ');
     ReadLn(fertilepairs);
     Write('Number of munths?  ');
     ReadLn(months);
     for i := 1 to months do
          Begin
               pairsnextmonth := pairs + fertilepairs;
               fertilepairs := pairs;
               pairs := pairsnextmonth
          End;
     WriteLn('After ', months, ' months you will have ', pairs, ' pairs');
     ReadLn;
End.