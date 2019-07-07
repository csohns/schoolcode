Program COMRESTION_TEST;

Type
     compress = record
                     Val: Integer;
                     Ch : Char;
                End;

Var
     SOURCE, DESTATION: String;
     I: file of Char;
     O: file of compress;
     TempCh: Char;
     first: Boolean;
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
     first := TRUE;
     While NOT EOF(I) do
          Begin
               If first then
                    Begin
                         Read(I, Comp.Ch);
                         inc(Comp.Val, 1);
                         first := FALSE;
                    End;
               Repeat
                    Read(I, TempCh);
                    If TempCh = Comp.Ch then
                         inc(Comp.Val, 1);
               Until (TempCh <> Comp.Ch) OR (EOF(I));
               Write(O, Comp);
               Comp.Val := 0;
               Comp.Ch := TempCh;
               inc(Comp.Val, 1);
          End;
     Close(I);
     Close(O);
End.