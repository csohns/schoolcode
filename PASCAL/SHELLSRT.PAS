{.}
                                                                 {Chris Sohns}
                                                                  {Shell Sort}
                                                                     {10/3/95}
                     {This program generates 100, 4 letter}
                     {words.  Then it sorts the words}
                     {alphabeticaly.}


Program Shell_Sort;

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
     cntr,
     cntr2  :Integer;

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

Procedure ShellSort(var List: Group; var cntr, cntr2: Integer);
     Var                                {Sorts the words and replaces them in}
          loc,
          gap,                          {the array}
          maxNum : Integer;
          temp   : String[4];
          change : Boolean;
     Begin
          ClrScr;
          cntr := 0;
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
                                                  inc(cntr, 1);
                                                  change := true;
                                             End;
                              End;
                    Until change = false;
                    gap := Trunc(gap div 2);
               End;
     End;

{////////////////////////////////////////////////////////////////////////}

Procedure WordDisplay(var List: Group; var cntr, cntr2: Integer);
     Var                                 {Displayes the words in the array}
          lcv: Integer;                  {in order}
     Begin
          ClrScr;
          WriteLn('Comparensins:  ', cntr2);
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
     ShellSort(List, cntr, cntr2);
     WordDisplay(List, cntr, cntr2);
End.   (*END PROGRAM*)