UNIT SORTS;

interface

Const
     min = 1;
     max = 100;
     WordLength = 26;

Type
     Group = Array [min..max] of String[WordLength];
     Str = String[WordLength];

Procedure DSort(var List: Group);

Procedure BSort(var List: Group);

Procedure SSort(var List: Group);

Procedure QSort(var List: Group; var First, Last: Integer);

Procedure ISort(var List: Group);

{////////////////////////////////////////////////////////////////////////}
implementation
Uses CRT;

Procedure DSort(var List: Group);
     Var                              {Sorts the words and replaces them in}
          top, bottom: Integer;       {the array}
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         Begin
                              If List[top] < List[bottom] then
                                   Begin
                                        temp := List[top];
                                        List[top] := List[bottom];
                                        List[bottom] := temp;
                                   End; {loop}
                         End;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure BSort(var List: Group);
     Var                                {Sorts the words and replaces them in}
          loc,                          {the array}
          maxNum : Integer;
          temp   : String[WordLength];
          change : Boolean;
     Begin
          ClrScr;
          maxNum := max;
          Repeat
               change := false;
               For loc := min to pred(maxNum) do
                    Begin
                         If List[loc] > List[loc + 1]
                              then Begin
                                        temp := List[loc];
                                        List[loc] := List[loc + 1];
                                        List[loc + 1] := temp;
                                        change := true;
                                   End;
                    End;
               Dec(maxNum);
          Until change = false;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure SSort(var List: Group);
     Var                                {Sorts the words and replaces them in}
          loc,                          {the array}
          maxNum,
          gap    : Integer;
          temp   : String[WordLength];
          change : Boolean;
     Begin
          ClrScr;
          maxNum := max;
          gap := Trunc(max div 2);
          While gap > 0 do
               Begin
                    Repeat
                         change := false;
                         For loc := min to max - gap do
                              Begin
                                   If List[loc] > List[loc + gap]
                                        then Begin
                                                  temp := List[loc];
                                                  List[loc] := List[loc + gap];
                                                  List[loc + gap] := temp;
                                                  change := true;
                                             End;
                              End;
                    Until change = false;
                    gap := Trunc(gap div 2);
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure QSort(var List: Group; var First, Last: Integer);
     Var                                {Sorts the words and replaces them in}
          Left,                         {the array}
          Right  : Integer;
          Fence,
          temp   : Str;
     Begin
          ClrScr;
          Fence := List[(First + Last) div 2];
          Left := First;
          Right := Last;
          Repeat
               While List[Left] < Fence do
                    Left := Succ(Left);
               While List[Right] > Fence do
                    Right := Pred(Right);
               If Left <= Right then
                    Begin
                         Temp := List[Right];
                         List[Right] := List[Left];
                         List[Left] := temp;
                         Left := Succ(Left);
                         Right := Pred(Right);
                    End; {IF}
          Until Left > Right;
          If First < Right then QSort(List, First, Right);
          If Left < Last then QSort(List, Left, Last);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure ISort(var List: Group);
       Var                    {Sorts the words and replaces them in the array}
            last,
            I, J        :Integer;
            Place_Found :Boolean;
            temp        :Str;
       Begin
            last := max;
            I := 2;
            While I <= last do
                 Begin
                      Place_Found := FALSE;
                      J := I;
                      While (J > 1) and (not Place_Found) do
                           Begin
                                If List[J] < List[J - 1] then
                                     Begin
                                          temp := List[J];
                                          List[J] := List[J - 1];
                                          List[J - 1] := temp;
                                     End {while}
                                Else Place_Found := TRUE;
                                Dec(J, 1);
                           End;
                      I := I + 1;
                 End; {while}
       End; {InsertFirstSort}
{////////////////////////////////////////////////////////////////////////}

Begin
End.