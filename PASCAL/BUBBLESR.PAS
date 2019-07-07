{.}
                                                                 {Chris Sohns}
                                                                 {Bubble Sort}
                                                                     {10/3/95}
                     {This program generates 100, 4 letter}
                     {words.  Then it sorts the words}
                     {alphabeticaly.}


Program Bubble_Sort;

Uses
     CRT;

Const
     min = 1;
     max = 100;

Type
     Group = Array [min..max] of String[4];
     Str4 = String[4];

Var
     Master,
     List   :Group;
     Word   :Str4;
     cntr   :Integer;

{////////////////////////////P R O C E D U R E S/////////////////////////}

Procedure InitArray(var List: Group; var Word: Str4);  {Set all array com-}
     Var                                               {ponents to 0}
          lcv: Integer;

     Begin
          Word := '';
          For lcv := min to max do
               List[lcv] := '';
     End; {InitArray}

{////////////////////////////////////////////////////////////////////////}

Procedure WordGen(var List: Group; var Word: Str4);  {Generates four letter}
     Var                                             {words and stores them}
          lcv, lcv2, number: Integer;                {in the array}
     Begin
          ClrScr;
          For lcv := min to max do
               Begin
                    GotoXY(1,1);
                    WriteLn('WORD GENERATION. . .');
                    Write('Have finished generating ', lcv, ' of ', max, ' words.');
                    For lcv2 := 1 to 4 do
                         Begin
                              Number := Random(25)+65;
                              Word := Word + CHR(Number);
                         End; {loop}
                    List[lcv] := Word;
                    Word := '';
               End; {loop}
     End; {WordGen}

{////////////////////////////////////////////////////////////////////////}

Procedure BubbleSort(var List: Group; var cntr: Integer);
     Var                                {Sorts the words and replaces them in}
          loc,                          {the array}
          maxNum : Integer;
          temp   : String[4];
          change : Boolean;
     Begin
          ClrScr;
          maxNum := max;
          cntr := 0;
          Repeat
               change := false;
               For loc := min to pred(maxNum) do
                    If List[loc] > List[loc + 1]
                         then Begin
                                   temp := List[loc];
                                   List[loc] := List[loc + 1];
                                   List[loc + 1] := temp;
                                   inc(cntr);
                                   change := true;
                              End;
               Dec(maxNum);
          Until change = false;
     End; {WordSort}

{////////////////////////////////////////////////////////////////////////}

Procedure WordDisplay(var List: Group; var cntr: Integer);
     Var                                 {Displayes the words in the array}
          lcv: Integer;                  {in order}
     Begin
          ClrScr;
          {WriteLn('Comparensins:  ', Num + 1);}
          WriteLn('Switiches   :  ', cntr);
          WriteLn;
          WriteLn;
          Write('Press [ENTER] to display the SORTED list. . .');
          ReadLn;
          ClrScr;
          For lcv := min to max do
               Begin
                    WriteLn(List[lcv]);
                    {Delay(80);}
               End; {loop}
          Write('Press [ENTER] to CONITNUE. . .');
          ReadLn;
     End; {WordDisplay}

{//////////////////////////M A I N///P R O G R A M///////////////////////}

Begin  (*MAIN*)
     ClrScr;                 (*cleares screen*)
     Randomize;              (*randomizes Random selection process*)
     InitArray(Master, Word);
     WordGen(Master, Word);
     List := Master;
     BubbleSort(List, cntr);
     WordDisplay(List, cntr);
End.   (*END PROGRAM*)