Program DECOMRESTION_TEST;

Type
     compress = record
                     Val: Integer;
                     Ch : Char;
                End;

Var
     SOURCE, DESTATION: String;
     I: file of compress;
     O: file of Char;
     TempCh: Char;
     first: Boolean;
     lcv: Integer;
     Comp: compress;

Begin
     Comp.Val := 0;
     Write('Enter in SOURCE file name:  ');
     ReadLn(SOURCE);
     Write('Enter in DESATAION file name:  ');
     ReadLn(DESTATION);
     Assign(I, SOURCE);
     Assign(O, DESTATION);
     ReSet(I);
     ReWrite(O);
     While NOT EOF(I) do
          Begin
               Read(I, Comp);
               For lcv := 1 to Comp.Val do
                    Write(O, Comp.Ch);
          End;
     Close(I);
     Close(O);
End.