Procedure Quicksort(var List:Group; var First, Last:Integer);
     Var
          Left, Right: Integer;
          Fence, temp: Str;
     Begin
          Fence := List[(First + Last) div 2];
          Left := First;
          Right := Last;
          Repeat;
               While List[Left] < Fence do
                    Left := Succ(Left);
               While List[Right] > Fence do
                    Right := Pred(Right);
               If Left <= Right then
                    Begin
                         Temp := List[Left];
                         List[Right] := List[Left];
                         List[Left] := temp;
                         Left := Succ(Left);
                         Right := Pred(Right);
                    End; {IF}
          Until Left > Right;
          If First < Right then Quicksort(List, First, Right);
          If Left < Last then Quicksort(List, Left, Last);
     End; {Quicksort}