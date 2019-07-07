USES
     CRT, DOS, ANSWERS;

CONST
     recmax = 163;
     STR = 26;

TYPE
     CardStats = record
                      name  : ST26;
                      colors: ST1;
                      ctype  : ST1;
                      Off,
                      Deff  : ST2;
                      texts,
                      texts2: ST76;
                      price : ST6;
                End;
     CardStats2 = record
                      name  : ST26;
                      colors: ST1;
                      Off,
                      Deff  : ST2;
                      texts,
                      texts2: ST76;
                      price : ST6;
                End;
     StringValue = String[STR];
     FOCS1 = File of CardStats;
     FOCS2 = File of CardStats2;
     Group = Array[1..recmax] of CardStats;
     Group2 = Array[1..recmax] of CardStats2;

VAR
     List: Group;
     List2:Group2;
     cntr,
     max: Integer;
     DataFile,
     DataFile2: ST20;
     sel: Char;
     F: FOCS1;
     T: FOCS2;


{////////////////////////////////////////////////////////////////}
  Procedure Vert(var List:Group; Var List2:Group2; DataFile:ST20; var cntr:Integer; var F:FOCS1);
       Var
            lcv: Integer;
       Begin
            Write('Enter in destation data file:  ');
            ReadLn(DataFile);
            {answer20(DataFile, WhereX, WhereY);}
            For lcv := 1 to cntr do
                 Begin
                      List[lcv].name := '';
                      List[lcv].colors := '';
                      List[lcv].ctype := '';
                      List[lcv].Off := '';
                      List[lcv].Deff := '';
                      List[lcv].texts := '';
                      List[lcv].texts2 := '';
                      List[lcv].price := '';
                 End;
            For lcv := 1 to cntr do
                 Begin
                      List[lcv].name := List2[lcv].name;
                      List[lcv].colors := List2[lcv].colors;
                      List[lcv].Off := List2[lcv].Off;
                      List[lcv].Deff := List2[lcv].Deff;
                      List[lcv].texts := List2[lcv].texts;
                      List[lcv].texts2 := List2[lcv].texts2;
                      List[lcv].price := List2[lcv].price;
                 End;
            Assign(F, DataFile);
            {$I-}
            ReWrite(F);
            Close(F);
            {$I+}
            If IOResult = 0 then
                 Begin
                      ReWrite(F);
                      For lcv := 1 to cntr do
                           Write(F, List[lcv]);
                      Close(F);
                 End;
            WriteLn('I''m done converting the Beta 3-5 file to a Beta 6 file.');
            Delay(4000);
       End;
{////////////////////////////////////////////////////////////////}
  Procedure Load(Var List2:Group2; DataFile:ST20; Var cntr:Integer; var T:FOCS2);
       Var
            lcv:Integer;
       Begin
            Write('Enter in source data file:  ');
            ReadLn(DataFile2);
            {answer20(DataFile2, WhereX, WhereY);}
            Assign(T, DataFile2);
            {$I-}
            ReSet(T);
            Close(T);
            If IOResult = 0 then
                 Begin
                      ReSet(T);
                      cntr := 0;
                      While not EOF(T) do
                           Begin
                                inc(cntr, 1);
                                Read(T, List2[cntr]);
                           End;
                      Close(T);
                 End;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure ReadNew(var List:Group; DataFile:ST20; cntr:Integer; var F:FOCS1);
       Var
            lcv: Integer;
       Begin
            {$I-}
            ReSet(F);
            Close(F);
            If IOResult = 0 then
                 Begin
                      ReSet(F);
                      cntr := 0;
                      While not EOF(F) do
                           Begin
                                inc(cntr, 1);
                                Read(F, List[cntr]);
                           End;
                      Close(F);
                 End;
            For lcv := 1 to cntr do
                 Begin
                      With List[lcv] do
                           Begin
                                WriteLn(name);
                                WriteLn(colors);
                                WriteLn(ctype);
                                WriteLn(Off);
                                WriteLn(Deff);
                                WriteLn(texts);
                                WriteLn(texts2);
                                WriteLn(price);
                                WriteLn('[PAUSE]');
                                ReadLn;
                           End;
                 End;
       End;
{////////////////////////////////////////////////////////////////}
Begin
     max := 164;
     ClrScr;
     Repeat
          Repeat
               Write('-');
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               WriteLn;
               sel := UpCase(sel);
               If DataFile <> '' then
                    If sel = 'R' then ReadNew(List, DataFile, cntr, F);
               Case sel of
                    'L': Load(List2, DataFile2, cntr, T);
                    'V': Vert(List, List2, DataFile, cntr, F);
                    '?': Begin
                              WriteLn;
                              WriteLn('L = Load');
                              WriteLn('V = conVert');
                              WriteLn('R = Read converted file');
                              WriteLn('Q = Quit');
                              WriteLn;
                              WriteLn;
                         End;
               End;
          Until (sel = 'L') or (sel = 'V') or (sel = 'Q');
     Until sel = 'Q';
End.