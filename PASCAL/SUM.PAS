Program For_Loops;
(*Chris Sohns
  Lesson:  Number Avarage
  Period 4
  Row #2*)

VAR
     ctr: integer;     (*Counter*)
     sum,              (*The sum of the numbers*)
     num: real;        (*The number that the user enters in*)

Begin     {Main Program}
     sum := 0;
     ctr := 0;
     num := 0;
     Write('How many numbers do you want to enter?  ');
     ReadLn(ctr);
     For ctr := 1 to ctr do
          Begin
               Write('Enter in number, #', ctr, ':  ');
               ReadLn(num);
               sum := sum + num;
          End;     {For}
     sum := sum / ctr;
     WriteLn('The avarage for the ', ctr, ' number(s), is:  ', sum:0:0);
     ReadLn;
End.     {End Main Program}