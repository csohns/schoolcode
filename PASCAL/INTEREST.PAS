Program Investment;
(*Chris Sohns
  Period 7
  Row 2*)

VAR
     amount,
     deposit,
     yearlyrate,
     monthlyrate,
     interest: real;

     months,
     i: integer;

Begin
     Write('Amount in your account now?  ');
     ReadLn(amount);
     Write('Monthly deposit?  ');
     ReadLn(deposit);
     Write('Yearly interest rate as percent?  ');
     ReadLn(yearlyrate);
     Write('Number of months?  ');
     ReadLn(months);
     monthlyrate := yearlyrate / 1200.0;
     for i := 1 to months do
          Begin
               amount := amount + deposit;
               interest := amount * monthlyrate;
               amount := amount + interest
          end;
     WriteLn('After ', months, ' months you will have', amount:8:2, ' dollars');
     ReadLn;
End.