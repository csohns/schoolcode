{.}
                                                                 {Chris Sohns}
                                                                      {Arrays}
                                                                      {9/7/95}



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

{/////////////////////////////P R O C E D U R E S////////////////////////}

Procedure PrintList(Array_Name :ArrayType);
     Var
          LOC :Integer;
     Begin
          For LOC := Min to Max do
               WriteLn(LOC, '--', Array_Name[LOC]);
          ReadLn;
     End;

Procedure EnterList(var Array_Name :ArrayType);
     Var
          Loc :Integer;
     Begin
          For Loc := Min to Max do Begin
               Write('Please enter a value for bax #', Loc, ': ');
               ReadLn(Array_Name[Loc]);
          End; {loop}
     End;

{/////////////////////////////F U N C T I O N S//////////////////////////}

Function SumList(Array_Name :ArrayType) :Integer;
     Var
          Total, Loc :Integer;
     Begin
          Total := 0;
          For Loc := Min to Max do
               Total := Total + Array_Name[Loc];
          SumList := Total;
     End;

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin
     ClrScr;
     PrintList(List);
     For LCV := Min to Max do
          List[LCV] := 0;
     PrintList(List);
     Sum := SumList(List);
     WriteLn('The Sum is ', Sum);
     ReadLn;
     EnterList(List);
     PrintList(List);
     WriteLn('The Sum of your personal list is ', SumList(List));
     ReadLn;
End.