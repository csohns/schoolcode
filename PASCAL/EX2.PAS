Program Pay_Roll;
(*Chris Sohns*)
(*Period 4*)
(*Row  #2*)

VAR
     hours: real;        (*Number of hours worked*)
     pay: real;          (*Ammount payed per hour*)
     total: real;        (*hours * pay*)

Begin
  (* hours:= 8.0;
  pay:= 1.5;
  total:= 8 * 1.5; *)
  Write('Enter in the number of hours worked:  ');
  ReadLn(hours);
  Write('Enter in the ammount of pay you recive per hour:  ');
  ReadLn(pay);
  total:= hours * pay;
  WriteLn;
  WriteLn('You worked for ',hours:0:2,' hours, for $',pay:0:2,' per hour.');
  WriteLn('The total is $',total:0:2);
  ReadLn;
End.