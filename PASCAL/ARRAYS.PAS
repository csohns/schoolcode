Program dsfg;

uses CRT;

Type
     Array_Type = Array[1..5] of integer;

Var
     A, B: Array_Type;

Begin
     ClrScr;
     A[1] := 10;
     A[2] := 25;
     WriteLn(A[1]:10, A[2]:10);
     A[3] := A[1] + A[2];
     Write('Enter a value for A[4]...');
     ReadLn(A[4]);
     A[5] := A[4] * 10;
     WriteLn(A[1]:5, A[2]:5, A[3]:5, A[4]:5, A[5]:5);
     WriteLn;
     Write('Enter the values for ARRAY B...');
     ReadLn(B[1], B[2], B[3], B[4], B[5]);
     WriteLn;
     WriteLn(B[1]:5, B[2]:5, B[3]:5, B[4]:5, B[5]:5);
     WriteLn;
     B := A;
     WriteLn(B[1]:5, B[2]:5, B[3]:5, B[4]:5, B[5]:5);
     ReadLn;
End.