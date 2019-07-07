Program InitArray;

Uses
     CRT;

Const
     Min = 1;
     Max = 10;

Type
     ArrayType = Array[Min..Max] of Integer;

Var
     List   :ArrayType;
     Letter :Char;
     Sum,
     LCV    :Integer;

Procedure PrintList;
     Var
          LOC :Integer;
     Begin
          For LOC := Min to Max do
               WriteLn(LOC, '--', List[LOC]);
          ReadLn;
     End;

Procedure EnterList;
     Var
          Loc :Integer;
     Begin
          For Loc := Min to Max do Begin
               Write('Please enter a value for bax #', Loc, ': ');
               ReadLn(List[Loc]);
          End; {loop}
     End;

Function SumList :Integer;
     Var
          Total, Loc :Integer;
     Begin
          Total := 0;
          For Loc := Min to Max do
               Total := Total + List[Loc];
          SumList := Total;
     End;


Begin
     ClrScr;
     PrintList;
     For LCV := Min to Max do
          List[LCV] := 0;
     PrintList;
     Sum := SumList;
     WriteLn('The Sum is ', Sum);
     ReadLn;
     EnterList;
     PrintList;
     WriteLn('The Sum of your personal list is ', SumList);
     ReadLn;
End.