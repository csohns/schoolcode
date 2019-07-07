{.}
                                                                 {Chris Sohns}
                                                                   {Dumb Sort}
                                                                     {10/3/95}
                     {This program generates 100, 4 letter}
                     {words.  Then it sorts the words}
                     {alphabeticaly.}


Program Dumb_Sort;

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
                    Write('Have finished generating ', lcv, ' of ', max,
                          ' words.');
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

Procedure DumbSort(var List: Group; var cnrt: Integer);
     Var                              {Sorts the words and replaces them in}
          top, bottom: Integer;       {the array}
          temp       : String[4];
     Begin
          ClrScr;
          cntr := 0;
          For top := min to max do
               Begin
                    GotoXY(1,1);
                    WriteLn('WORD SORT. . .');
                    Write('Have finished sorting ', top, ' of ', max, ' words.');
                    For bottom := min to max do
                         If List[top] < List[bottom] then
                              Begin
                                   temp := List[top];
                                   List[top] := List[bottom];
                                   List[bottom] := temp;
                                   inc(cntr, 1);
                              End; {loop}
               End;
     End; {WordSort}

{////////////////////////////////////////////////////////////////////////}

Procedure WordDisplay(var List: Group; var cntr: Integer);
     Var                                 {Displayes the words in the array}
          lcv: Integer;                  {in order}
     Begin
          ClrScr;
          WriteLn('Comparensins:  ', max / 2:0:0);
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
     DumbSort(List, cntr);
     WordDisplay(List, cntr);
End.   (*END PROGRAM*)