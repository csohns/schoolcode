{.}
                                                                 {Chris Sohns}
                                                                  {2-D Arrays}
                                                                      {9/7/95}
                     {This program is a deminsration of}
                     {2 dimentional arrays.}


Program Arrays;

Uses
     CRT;

Const
     RowNum = 3;
     ColNum = 4;
     DataFile = 'C:\2DARRAY.DAT';

Type
     D2Array = Array[1..RowNum, 1..ColNum] of Integer;

Var
     Group :D2Array;
     sum   :Integer;

{////////////////////////////////////////////////////////////////////////}

Procedure InitArray(var list :D2Array);  {clear out the array}
     Var
          Row, Col :Integer;
     Begin
          For Row := 1 to RowNum do
               For Col := 1 to ColNum do
                    list[Row, Col] := 0;
     End;

{////////////////////////////////////////////////////////////////////////}

Procedure EnterValues(var list :D2Array);  {puts values into the array}
     Var
          Row, Col, cntr :Integer;
     Begin
          cntr := 1;
          For Col := 1 to ColNum do
               For Row := 1 to RowNum do
                    Begin
                         list[Row, Col] := cntr;
                         inc(cntr, 1);
                    End;
     End;

{////////////////////////////////////////////////////////////////////////}

Procedure PrintValues(var list :D2Array);  {prints out the values in the array}
     Var
          Row, Col :Integer;
          F        :Text;
{////////////////////////////////////////////////////////////////}
  Procedure FixFile;  {creates file if one is not present}
       Var
            F: Text;
       Begin
            Assign(F, DataFile);
            ReWrite(F);
            WriteLn(F, '2-D ARRAY DATA FILE');
            WriteLn(F, '');
            WriteLn(F, '');
            Close(F);
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          Assign(F, DataFile);
          {$I-}
          Append(F);
          Close(F);
          If IOResult <> 0 then FixFile;
          {$I+}
          Append(F);
          For Row := 1 to RowNum do
               Begin
                    For Col := 1 to ColNum do
                         Begin
                              Write(list[Row, Col], ' ');
                              Write(F, list[Row, Col], ' ');
                         End;
                    WriteLn;
                    WriteLn(F, '');
               End;
          WriteLn(F, '');
          Close(F);
     End;

{////////////////////////////////////////////////////////////////////////}

Procedure Menu(var List :D2Array);  {selection menu}
     Var
          selection :Integer;
{////////////////////////////////////////////////////////////////}
  Procedure skip(num: Integer); {skips spesefied lines}
    Var lcv :Integer;

    Begin
      For lcv := 1 to num do
        WriteLn;
    End;  {skip}
{////////////////////////////////////////////////////////////////}
  Procedure RowSum(var list :D2Array);  {adds up the sum of a row}
    Var num :Integer;
{/////////////////////////////////////}
   Function RowAdd(var num :Integer; var List :D2Array): Integer;
    Var sum, Col, cntr: Integer;     {outputs the sum of a row}
        F: Text;
    Begin
     Assign(F, DataFile);
     Append(F);
     sum := 0;
     cntr := 1;
     For Col := 1 to ColNum do
      Begin
       Write(List[num, cntr], ' ');
       Write(F, List[num, cntr], ' ');
       sum := sum + List[num, cntr];
       inc(cntr, 1);
      End;
     Write('    ');
     Write(F, '    ');
     {Write(sum);
     skip(1);}
     WriteLn(F, sum);
     Close(F);
     RowAdd := sum;
    End;
{/////////////////////////////////////}
    Begin
      skip(4);
      Write('Enter in a row number from 1 to ', RowNum, ': ');
      ReadLn(num);
      While (num < 1) or (num > RowNum) do
       Begin
        WriteLn('INVALID ENTRY!!');
        Write('Enter in a row number from 1 to ', RowNum, ': ');
        ReadLn(num);
       End;
      skip(2);
      {WriteLn('The sum of the numbers in row ', num, ' is ', RowAdd(num, list), '.');}
      WriteLn(RowAdd(num, list));
      skip(2);
      WriteLn('Press [ENTER] to return to the menu. . .');
      ReadLn;
    End;
{////////////////////////////////////////////////////////////////}
  Procedure ColSum(var list :D2Array);  {adds up the sun of a colum}
    Var num :Integer;
{/////////////////////////////////////}
   Function ColAdd(var num :Integer; var list :D2Array): Integer;
    Var sum, Row, cntr: Integer;     {outputs the sum of a spesefied colum}
        F: Text;
    Begin
     Assign(F, DataFile);
     Append(F);
     sum := 0;
     cntr := 1;
     For Row := 1 to RowNum do
      Begin
       WriteLn(List[cntr, num]);
       WriteLn(F, List[cntr, num]);
       sum := sum + List[cntr, num];
       inc(cntr, 1);
      End;
     skip(1);
     {WriteLn(sum);
     skip(1);}
     WriteLn(F, sum);
     WriteLn(F, '');
     Close(F);
     ColAdd := sum;
    End;
{/////////////////////////////////////}
    Begin
      skip(4);
      Write('Enter in a colum number from 1 to ', ColNum, ': ');
      ReadLn(num);
      While (num < 1) or (num > ColNum) do
       Begin
        WriteLn('INVALID ENTRY!!');
        Write('Enter in a colum number from 1 to ', ColNum, ': ');
        ReadLn(num);
       End;
      skip(2);
      {WriteLn('The sum of the numbers in colum ', num, ' is ', ColAdd(num, list), '.');}
      WriteLn(ColAdd(num, list));
      skip(2);
      WriteLn('Press [ENTER] to return to the menu. . .');
      ReadLn;
    End;

{////////////////////////////////////////////////////////////////}

  Procedure AllSum(var List :D2Array);  {adds up all the rows and culums}
    Var num :Integer;
{//////////////////////////////////////}
   Procedure RowAdd(var Collection :D2Array);
    Var sum, Row, Col, cntr: Integer;  {outputs the sum of a spesefied row}
        F: Text;
    Begin
     Assign(F, DataFile);
     Append(F);
     cntr := 1;
     GotoXY(1, 1);
     For Row := 1 to RowNum do
      Begin
       sum := 0;
       For Col := 1 to ColNum do
        Begin
         Write(Collection[Row, Col], '  ');
         Write(F, Collection[Row, Col], '  ');
         {Delay(400);}
         sum := sum + Collection[Row, Col];
         inc(cntr, 1);
        End;
       WriteLn(' ', sum);
       WriteLn(F, ' ', sum);
       End;
       WriteLn(F, '');
       Close(F);
    End;
{/////////////////////////////////////}
   Procedure ColAdd(var Collection:D2Array);
    Var sum, Row, Col, cntr, numberX, numberY: Integer;
        F: Text;                      {outputs the sum of a spesefied colum}
    Begin
     Assign(F, DataFile);
     Append(F);
     cntr := 1;
     numberX := 1;
     numberY := 1;
     GotoXY(1, 1);
     For Col := 1 to ColNum do
      Begin
       sum := 0;
       For Row := 1 to RowNum do
        Begin
         GotoXY(numberX, numberY);
         WriteLn(Collection[Row, Col]);
         WriteLn(F, Collection[Row, Col]);
         {Delay(400);}
         sum := sum + Collection[Row, Col];
         inc(cntr, 1);
         inc(numberY, 1);
        End;
       skip(1);
       WriteLn(F, '');
       inc(numberY, 1);
       GotoXY(numberX, numberY);
       Write(sum);
       WriteLn(F,sum);
       WriteLn(F, '');
       inc(numberX, 3);
       numberY := 1;
      End;
      Close(F);
    End;
{/////////////////////////////////////}
   Begin
    ClrScr;
    RowAdd(List);
    ColAdd(List);
    ReadLn;
   End;
{/////////////////////////////////////}
     Begin
          Repeat
               skip(4);
               WriteLn('1.)  Sum of a selected row');
               skip(1);
               WriteLn('2.)  Sum of a selected colum');
               skip(1);
               WriteLn('3.)  Sum of a all rows and all colums');
               skip(1);
               WriteLn('4.)  Quit');
               skip(2);
               Write('Enter in a number: ');
               ReadLn(selection);
               If selection = 1 then RowSum(List)
                    Else If selection = 2 then ColSum(List)
                         Else If selection = 3 then AllSum(List);
          Until selection = 4;
     End;

{////////////////////////////////////////////////////////////////////////}

Begin
     ClrScr;
     InitArray(Group);
     EnterValues(Group);
     PrintValues(Group);
     Menu(Group);
End.