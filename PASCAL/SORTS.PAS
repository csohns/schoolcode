{.}
                                                                 {Chris Sohns}
                                                                  {Many Sorts}
                                                                     {10/3/95}
                     {This program generates 100, 4 letter}
                     {words.  Then it sorts the words}
                     {alphabeticaly.}


Program Sorts;

Uses
     CRT;

Const
     min = 1;

{You can set these constents to anything you like}

     max = 100;                     {number of words}
     WordLength = 16;                {length of word}
     FileName = 'P:NAMES.AVE';      {file name to read from}
     (*FileName = 'C:\WORDS.LST';*)      {file name to read from}
     DataFileName = 'C:\SORTALL.DAT';  {file where the sort results are stored}

Type
     Group = Array [min..max] of String[WordLength];
     Str = String[WordLength];
     Str6 = String[6];

Var
     Master  :Group;
     Word    :Str;
     chos    :Boolean;
     cntrA1,
     cntrW1,
     cntrB1,
     cntrA2,
     cntrW2,
     cntrB2 :Integer;

{////////////////////////////P R O C E D U R E S/////////////////////////}

Procedure InitArray(var List: Group; var Word: Str);  {Set all array com-}
     Var                                               {ponents to 0}
          lcv: Integer;

     Begin
          Word := '';
          For lcv := min to max do
               List[lcv] := '';
     End; {InitArray}

{////////////////////////////////////////////////////////////////////////}

Procedure WordGen(var List: Group; var Word: Str);  {Generates four letter}
     Var                                             {words and stores them}
          lcv, lcv2, number :Integer;                {in the array}
     Begin
          ClrScr;
          For lcv := min to max do
               Begin
                    For lcv2 := 1 to WordLength do
                         Begin
                              Number := Random(25)+65;
                              Word := Word + CHR(Number);
                         End; {loop}
                    List[lcv] := Word;
                    Word := '';
               End; {loop}
     End; {WordGen}

{////////////////////////////////////////////////////////////////////////}
Procedure FileWordGen(var List: Group; var Word: Str);  {Generates four letter}
     Var                                             {words and stores them}
          lcv, lcv2, number: Integer;                {in a file }
          F: text;
     Begin
          ClrScr;
          Assign(F, FileName);
          ReWrite(F);
          For lcv := min to max do
               Begin
                    For lcv2 := 1 to WordLength do
                         Begin
                              Number := Random(25)+65;
                              Word := Word + CHR(Number);
                         End; {loop}
                    List[lcv] := Word;
                    WriteLn(F, Word);
                    Word := '';
               End; {loop}
          Close(F);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure ReadWords(var List: Group; var Word: Str);
     Var                             {Reads words fome file}
          lcv     :Integer;
          answer  :Char;
          F       :Text;
     Begin
          ClrScr;
          {$I-}
          Assign(F, FileName);
          ReSet(F);
          If IOResult = 0 then
               Begin
                    Write('Would you like to create a new word list?  ');
                    ReadLn(answer);
                    If UpCase(answer) = 'Y' then
                         FileWordGen(List, Word)
                    Else
                         Begin
                              While (lcv < max) or (not EOF(F)) do
                                   Begin
                                        ReadLn(F, Word);
                                        List[lcv] := Word;
                                   End;
                              Close(F);
                         End;
               End
               Else Begin
                         {$I+}
                         FileWordGen(List, Word);
                    End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure DumbSort(var Avg_List, Wrst_List, Bst_List: Group; var cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2: Integer);
{////////////////////////////////////////////////////////////////}
  Procedure InitDumbSort(var Wrst_List: Group);
     Var                              {Sorts the words backwards}
          top,                        {in the array}
          bottom: Integer;
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         If Wrst_List[top] > Wrst_List[bottom] then
                              Begin
                                   temp := Wrst_List[top];
                                   Wrst_List[top] := Wrst_List[bottom];
                                   Wrst_List[bottom] := temp;
                              End; {loop}
               End;
     End;
{////////////////////////////////////////////////////////////////}
  Procedure DumbSorts(var List: Group; var cntr1, cntr2: Integer);
     Var                              {Sorts the words and replaces them in}
          top, bottom: Integer;       {the array}
          temp       : String[WordLength];
     Begin
          cntr1 := 0;
          cntr2 := 0;
          For top := min to max do
               Begin
                    GotoXY(1,1);
                    WriteLn('WORD SORT. . .');
                    Write('Have finished sorting ', top, ' of ', max, ' words.');
                    For bottom := min to max do
                         Begin
                              inc(cntr2, 1);
                              If List[top] < List[bottom] then
                                   Begin
                                        temp := List[top];
                                        List[top] := List[bottom];
                                        List[bottom] := temp;
                                        inc(cntr1, 1);
                                   End; {loop}
                         End;
               End;
     End;
{////////////////////////////////////////////////////////////////}
     Begin
          InitDumbSort(Wrst_List);
          DumbSorts(Avg_List, cntrA1, cntrA2);
          DumbSorts(Wrst_List, cntrW1, cntrW2);
          Bst_List := Avg_List;
          DumbSorts(Bst_List, cntrB1, cntrB2);
     End; {DumbSort}

{////////////////////////////////////////////////////////////////////////}
Procedure BubbleSort(var Avg_List, Wrst_List, Bst_List: Group; var cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2: Integer);
{////////////////////////////////////////////////////////////////}
  Procedure InitBubbleSort(var Wrst_List: Group);
     Var                              {Sorts the words backwards}
          top,                        {in the array}
          bottom: Integer;
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         If Wrst_List[top] > Wrst_List[bottom] then
                              Begin
                                   temp := Wrst_List[top];
                                   Wrst_List[top] := Wrst_List[bottom];
                                   Wrst_List[bottom] := temp;
                              End; {loop}
               End;
     End;
{////////////////////////////////////////////////////////////////}
  Procedure BubbleSorts(var List: Group; var cntr1, cntr2: Integer);
     Var                                {Sorts the words and replaces them in}
          loc,                          {the array}
          maxNum : Integer;
          temp   : String[WordLength];
          change : Boolean;
     Begin
          ClrScr;
          maxNum := max;
          cntr1 := 0;
          cntr2 := 0;
          Repeat
               change := false;
               For loc := min to pred(maxNum) do
                    Begin
                         inc(cntr2, 1);
                         If List[loc] > List[loc + 1]
                              then Begin
                                        temp := List[loc];
                                        List[loc] := List[loc + 1];
                                        List[loc + 1] := temp;
                                        inc(cntr1, 1);
                                        change := true;
                                   End;
                    End;
               Dec(maxNum);
          Until change = false;
     End;

{////////////////////////////////////////////////////////////////}
     Begin
          InitBubbleSort(Wrst_List);
          BubbleSorts(Avg_List, cntrA1, cntrA2);
          BubbleSorts(Wrst_List, cntrW1, cntrW2);
          Bst_List := Avg_List;
          BubbleSorts(Bst_List, cntrB1, cntrB2);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure ShellSort(var Avg_List, Wrst_List, Bst_List: Group; var cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2: Integer);
{////////////////////////////////////////////////////////////////}
  Procedure InitShellSort(var Wrst_List: Group);
     Var                              {Sorts the words backwards}
          top,                        {in the array}
          bottom: Integer;
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         If Wrst_List[top] > Wrst_List[bottom] then
                              Begin
                                   temp := Wrst_List[top];
                                   Wrst_List[top] := Wrst_List[bottom];
                                   Wrst_List[bottom] := temp;
                              End; {loop}
               End;
     End;
{////////////////////////////////////////////////////////////////}
  Procedure ShellSorts(var List: Group; var cntr1, cntr2: Integer);
     Var                                {Sorts the words and replaces them in}
          loc,                          {the array}
          maxNum,
          gap    : Integer;
          temp   : String[WordLength];
          change : Boolean;
     Begin
          ClrScr;
          maxNum := max;
          cntr1 := 0;
          cntr2 := 0;
          gap := Trunc(max div 2);
          While gap > 0 do
               Begin
                    Repeat
                         change := false;
                         For loc := min to max - gap do
                              Begin
                                   inc(cntr2, 1);
                                   If List[loc] > List[loc + gap]
                                        then Begin
                                                  temp := List[loc];
                                                  List[loc] := List[loc + gap];
                                                  List[loc + gap] := temp;
                                                  inc(cntr1, 1);
                                                  change := true;
                                             End;
                              End;
                    Until change = false;
                    gap := Trunc(gap div 2);
               End;
     End;
{////////////////////////////////////////////////////////////////}
     Begin
          InitShellSort(Wrst_List);
          ShellSorts(Avg_List, cntrA1, cntrA2);
          ShellSorts(Wrst_List, cntrW1, cntrW2);
          Bst_List := Avg_List;
          ShellSorts(Bst_List, cntrB1, cntrB2);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure QuickSort(var Avg_List, Wrst_List, Bst_List: Group; var cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2: Integer);
     Var
          FirstNum, LastNum: Integer;
{////////////////////////////////////////////////////////////////}
  Procedure InitQuickSort(var Wrst_List: Group);
     Var                              {Sorts the words backwards}
          top,                        {in the array}
          bottom: Integer;
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         If Wrst_List[top] > Wrst_List[bottom] then
                              Begin
                                   temp := Wrst_List[top];
                                   Wrst_List[top] := Wrst_List[bottom];
                                   Wrst_List[bottom] := temp;
                              End; {if}
               End; {for}
     End;
{////////////////////////////////////////////////////////////////}
  Procedure QuickSorts(var List: Group; var First, Last, cntr1, cntr2: Integer);
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
               inc(cntr2, 1);
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
                         inc(cntr1, 1);
                    End; {IF}
          Until Left > Right;
          If First < Right then Quicksorts(List, First, Right, cntr1, cntr2);
          If Left < Last then Quicksorts(List, Left, Last, cntr1, cntr2);
     End;
{////////////////////////////////////////////////////////////////}
     Begin
          FirstNum := min;
          LastNum := max;
          cntrA1 := 0;
          cntrA2 := 0;
          cntrW1 := 0;
          cntrW2 := 0;
          cntrB1 := 0;
          cntrB2 := 0;
          InitQuickSort(Wrst_List);
          QuickSorts(Avg_List, FirstNum, LastNum, cntrA1, cntrA2);
          QuickSorts(Wrst_List, FirstNum, LastNum, cntrW1, cntrW2);
          Bst_List := Avg_List;
          QuickSorts(Bst_List, FirstNum, LastNum, cntrB1, cntrB2);
     End;
{////////////////////////////////////////////////////////////////////////}
  Procedure InsertSort(var Avg_List, Wrst_List, Bst_List: Group; var cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2: Integer);
{////////////////////////////////////////////////////////////////}
  Procedure InitInsertSort(var Wrst_List: Group);
     Var                              {Sorts the words backwards}
          top,                        {in the array}
          bottom: Integer;
          temp       : String[WordLength];
     Begin
          For top := min to max do
               Begin
                    For bottom := min to max do
                         If Wrst_List[top] > Wrst_List[bottom] then
                              Begin
                                   temp := Wrst_List[top];
                                   Wrst_List[top] := Wrst_List[bottom];
                                   Wrst_List[bottom] := temp;
                              End; {if}
               End; {for}
     End;
{////////////////////////////////////////////////////////////////}
  Procedure InsertSorts(var List: Group; var cntr1, cntr2: Integer);
       Var                    {Sorts the words and replaces them in the array}
            last,
            I, J        :Integer;
            Place_Found :Boolean;
            temp        :Str;
       Begin
            cntr1 := 0;
            cntr2 := 0;
            last := max;
            I := 2;
            While I <= last do
                 Begin
                      Place_Found := FALSE;
                      J := I;
                      While (J > 1) and (not Place_Found) do
                           Begin
                                inc(cntr2, 1);
                                If List[J] < List[J - 1] then
                                     Begin
                                          temp := List[J];
                                          List[J] := List[J - 1];
                                          List[J - 1] := temp;
                                          inc(cntr1, 1);
                                     End {while}
                                Else Place_Found := TRUE;
                                Dec(J, 1);
                           End;
                      I := I + 1;
                 End; {while}
       End; {InsertFirstSort}
{////////////////////////////////////////////////////////////////}
     Begin
          InitInsertSort(Wrst_List);
          InsertSorts(Avg_List, cntrA1, cntrA2);
          InsertSorts(Wrst_List, cntrW1, cntrW2);
          Bst_List := Avg_List;
          InsertSorts(Bst_List, cntrB1, cntrB2);
     End;
{////////////////////////////////////////////////////////////////////////}


Procedure menu(var Master: Group; var chos: Boolean);
     Var                      {menu of the sesections}
          Avg_List,
          Wrst_List,
          Bst_List   :Group;
          OK         :Boolean;
          F          :Text;
          kind       :String[6];
          cntrA1,
          cntrW1,
          cntrB1,
          cntrA2,
          cntrW2,
          cntrB2,
          selection  :Integer;
{////////////////////////////////////////////////////////////////}
  Procedure skip(num: Integer);
       Var               {skips a specifyed number if lines}
            lcv: Integer;
       Begin
            For lcv := 1 to num do
                 WriteLn;
       End;

{////////////////////////////////////////////////////////////////}
  Procedure CompDisplay(kind: Str6; cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB3: Integer);
     Var                            {displayes resulys}
          OK     :Boolean;
          answer :Char;
          F      :text;
{////////////////////////////////////////////////////////////////}
    Procedure DataFileInit(var F: Text);
     Begin                     {Creates result data file}
          Assign(F, DataFileName);
          ReWrite(F);
          WriteLn(F, 'Sort Result Tables');
          WriteLn(F, '');
          Close(F);
     End;
{////////////////////////////////////////////////////////////////}
    Procedure FileReWrite(var F: Text);
{Erase/Write to data file begins}
       Begin
          Repeat;
               OK := TRUE;
               Assign(F, DataFileName);
               {$I-}
               ReSet(F);
               {$I+}
               If IOResult <> 0 then
                    Begin
                         OK := FALSE;
                         DataFileInit(F);
                    End;
          Until OK;
          Append(F);
          WriteLn(F, '    ', kind, ' Sort');
          WriteLn(F, '');
          WriteLn(F,'Best case scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrB2);
          WriteLn(F,'Switiches   :  ', cntrB1);
          WriteLn(F, '');
          WriteLn(F, '');
          WriteLn(F,'Worst case scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrW2);
          WriteLn(F,'Switiches   :  ', cntrW1);
          WriteLn(F, '');
          WriteLn(F, '');
          WriteLn(F,'Average scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrA2);
          WriteLn(F,'Switiches   :  ', cntrA1);
          WriteLn(F, '');
          WriteLn(F, '');
          Close(F);
       End;
{Write to data file ends}
{////////////////////////////////////////////////////////////////}
    Procedure FileAppend(var F: Text);
{Append to data file begins}
       Begin
          Assign(F, DataFileName);
          Append(F);
          WriteLn(F, '    ', kind, ' Sort');
          WriteLn(F, '');
          WriteLn(F,'Best case scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrB2);
          WriteLn(F,'Switiches   :  ', cntrB1);
          WriteLn(F, '');
          WriteLn(F, '');
          WriteLn(F,'Worst case scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrW2);
          WriteLn(F,'Switiches   :  ', cntrW1);
          WriteLn(F, '');
          WriteLn(F, '');
          WriteLn(F,'Average scenerio. . .');
          WriteLn(F,'Comparasins:  ', cntrA2);
          WriteLn(F,'Switiches   :  ', cntrA1);
          WriteLn(F, '');
          WriteLn(F, '');
          Close(F);
       End;
{Write to data file ends}
{////////////////////////////////////////////////////////////////}
  Procedure Save(var F:Text);
      Var              {saves the results of last sort}
          answer  :Char;
      Begin
          WriteLn('Do you want to save the results?  ');
          ReadLn(answer);
          Assign(F, DataFileName);
          If UpCase(answer) = 'Y' then
               Begin
                    {$I-}
                    ReSet(F);
                    {$I+}
                    If IOResult = 0 then
                         Begin
                              Close(F);
                              WriteLn('There is a pereviously saves result file.');
                              WriteLn('Do you want to (S)ave over the old one, or (A)ppend to the old one?  ');
                              ReadLn(answer);
                              If UpCase(answer) = 'S' then
                                  FileReWrite(F)
                              Else If UpCase(answer) = 'A' then
                                   FileAppend(F)
                         End
                    Else FileReWrite(F);
               End
          Else Begin
                    {$I-}
                    ReSet(F);
                    {$I+}
                    If IOResult = 0 then
                         Begin
                              Write('Do you want to delete ', DataFileName, '?  ');
                              ReadLn(answer);
                              If UpCase(answer) = 'Y' then
                                   Erase(F);
                         End;
               End;
      End;
{////////////////////////////////////////////////////////////////}
     Begin
          ClrScr;
          WriteLn('    ', kind, ' Sort');
          skip(1);
          WriteLn('Best case scenerio. . .');
          WriteLn('Comparensins:  ', cntrB2);
          WriteLn('Switiches   :  ', cntrB1);
          skip(2);
          WriteLn('Worst case scenerio. . .');
          WriteLn('Comparensins:  ', cntrW2);
          WriteLn('Switiches   :  ', cntrW1);
          skip(2);
          WriteLn('Average scenerio. . .');
          WriteLn('Comparensins:  ', cntrA2);
          WriteLn('Switiches   :  ', cntrA1);
          skip(2);
          Save(F);
          Write('Press [ENTER] to retuen to the main menu. . .');
          ReadLn;
     End; {CompDisplay}
{////////////////////////////////////////////////////////////////}
  Procedure PrintList(var List: Group);
     Var                  {displayes results to screen}
          lcv: Integer;
     Begin
          ClrScr;
          For lcv := min to max do
               WriteLn(List[lcv]);
          WriteLn('Press [ENTER] to retuen to the main menu. . .');
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////}
  Procedure DataDisplay(var F: Text);
     Var                    {displayes results from file}
          Charector :Char;
     Begin
          Assign(F, DataFileName);
          ReSet(F);
          Repeat;
               Read(F, Charector);
               Write(Charector);
          Until EOF(F);
          Close(F);
          skip(2);
          WriteLn('Press [ENTER] to retuen to the main menu. . .');
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////}
     Begin
          Repeat;
          OK := TRUE;
          {$I-}
          Assign(F, DataFileName);
          ReSet(F);
          If IOResult = 0 then
               Close(F)
          Else OK := FALSE;
          {$I+}
          ClrScr;
          TextColor(White);
          WriteLn('1.)    Dumb   Sort');
          skip(1);
          WriteLn('2.)    Bubble Sort');
          skip(1);
          WriteLn('3.)    Shell  Sort');
          skip(1);
          WriteLn('4.)    Quick Sort');
          skip(1);
          WriteLn('5.)    Insert Sort');
          If OK then
               Begin
                    skip(1);
                    WriteLn('6.)    Display pervisoly saved results');
               End;
          If chos = TRUE then
               Begin
                    skip(1);
                    WriteLn('7.)    Display sorted list');
                    skip(1);
                    WriteLn('8.)    Print results of last sort');
               End;
          skip(1);
          WriteLn('9.)    Quit');
          skip(2);
          Write('Enter in your selection:  ');
          ReadLn(selection);
          Case selection of
               1:
                   Begin
                        chos := TRUE;
                        kind := 'DUMB';
                        ClrScr;
                        Avg_List := Master;
                        Wrst_List := Master;
                        DumbSort(Avg_List, Wrst_List, Bst_List, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
                   End;
               2:
                   Begin
                        chos := TRUE;
                        kind := 'BUBBLE';
                        ClrScr;
                        Avg_List := Master;
                        Wrst_List := Master;
                        BubbleSort(Avg_List, Wrst_List, Bst_List, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
                   End;
               3:
                   Begin
                        chos := TRUE;
                        kind := 'SHELL';
                        ClrScr;
                        Avg_List := Master;
                        Wrst_List := Master;
                        ShellSort(Avg_List, Wrst_List, Bst_List, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
                   End;
               4:
                   Begin
                        chos := TRUE;
                        kind := 'QUICK';
                        ClrScr;
                        Avg_List := Master;
                        Wrst_List := Master;
                        QuickSort(Avg_List, Wrst_List, Bst_List, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
                   End;
               5:
                   Begin
                        chos := TRUE;
                        kind := 'INSERT';
                        ClrScr;
                        Avg_List := Master;
                        Wrst_List := Master;
                        InsertSort(Avg_List, Wrst_List, Bst_List, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
                   End;
          End;
          If OK and (selection = 6) then
               DataDisplay(F);
          If (chos = TRUE) and (selection = 7) then
               PrintList(Avg_List);
          If (chos = TRUE) and (selection = 8) then
               CompDisplay(kind, cntrA1, cntrW1, cntrB1, cntrA2, cntrW2, cntrB2);
          Until selection = 9;
     End;


{//////////////////////////M A I N///P R O G R A M///////////////////////}

Begin  (*MAIN*)
     ClrScr;                 (*cleares screen*)
     Randomize;              (*randomizes Random selection process*)
     InitArray(Master, Word);
     {WordGen(Master, Word);}
     ReadWords(Master, Word);
     chos := FALSE;
     menu(Master, chos);
End.   (*END PROGRAM*)