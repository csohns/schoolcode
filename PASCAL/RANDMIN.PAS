USES
     CRT, DOS, MENU, {CREDITS,} ANSWERS{, PONG, SCRSAV};

CONST
     recmax = 110;  (*recmax = 110*)
     STR = 26;

TYPE
     CardStats = record
                      Hard: ST11;
                      Luster: Array[1..20] of Boolean;
                      Color: Array[1..43] of Boolean;
                      Streak: Array[1..29] of Boolean;
                      Cleav: Array[1..20] of Boolean;
                      SpecGrav: ST11;
                      Prop1,
                      Prop2,
                      Prop3: ST76;
                      Name: ST20;
                      Comp: ST40;
                      Use1,
                      Use2: ST76;
                      Origin: Array[1..4] of Boolean;
                End;
     StringValue = String[STR];
     Group = Array[1..recmax] of CardStats;

VAR
     List: Group;
     max: Integer;
     f: File of CardStats;

Procedure InitArray(var List: Group);  {Set all array com-}
     Var                               {ponents to 0}
          lcv,lcv2: Integer;

     Begin
          For lcv := 1 to max do
               Begin
                      Write(lcv);
                      GotoXY(33,WhereY);
                      List[lcv].Hard := '';
                      For lcv2 := 1 to 20 do
                        List[lcv].Luster[lcv2] := FALSE;
                      For lcv2 := 1 to 43 do
                        List[lcv].Color[lcv2] := FALSE;
                      For lcv2 := 1 to 29 do
                        List[lcv].Streak[lcv2] := FALSE;
                      For lcv2 := 1 to 20 do
                        List[lcv].Cleav[lcv2] := FALSE;
                      List[lcv].SpecGrav := '';
                      List[lcv].Prop1 := '';
                      List[lcv].Prop2 := '';
                      List[lcv].Prop3 := '';
                      List[lcv].Name := '';
                      List[lcv].Comp := '';
                      List[lcv].Use1 := '';
                      List[lcv].Use2 := '';
                      For lcv2 := 1 to 4 do
                        List[lcv].Origin[lcv2] := FALSE;
               End;
     End; {InitArray}

Procedure RandData(var List: Group);
     Var
          lcv,lcv2,lcv3: Integer;
          RndC: Char;
          RndB: Integer;

     Begin
          Randomize;
          For lcv := 1 to max do
               Begin
                      Write(lcv);
                      GotoXY(45,WhereY);
                      With List[lcv] do
                      Begin
                        For lcv3 := 1 to 11 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Hard := Hard + RndC;
                          End;
                        For lcv2 := 1 to 20 do
                          Begin
                          RndB := Random(2);
                          If RndB = 0 then Luster[lcv2] := FALSE
                            Else Luster[lcv2] := TRUE;
                          End;
                        For lcv2 := 1 to 43 do
                          Begin
                          RndB := Random(2);
                          If RndB = 0 then Color[lcv2] := FALSE
                            Else Color[lcv2] := TRUE;
                          End;
                        For lcv2 := 1 to 29 do
                          Begin
                          RndB := Random(2);
                          If RndB = 0 then Streak[lcv2] := FALSE
                            Else Streak[lcv2] := TRUE;
                          End;
                        For lcv2 := 1 to 20 do
                          Begin
                          RndB := Random(2);
                          If RndB = 0 then Cleav[lcv2] := FALSE
                            Else Cleav[lcv2] := TRUE;
                          End;
                        For lcv3 := 1 to 11 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            SpecGrav := SpecGrav + RndC;
                          End;
                        For lcv3 := 1 to 76 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Prop1 := Prop1 + RndC;
                          End;
                        For lcv3 := 1 to 76 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Prop2 := Prop2 + RndC;
                          End;
                        For lcv3 := 1 to 76 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Prop3 := Prop3 + RndC;
                          End;
                        For lcv3 := 1 to 20 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Name := Name + RndC;
                          End;
                        For lcv3 := 1 to 40 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Comp := Comp + RndC;
                          End;
                        For lcv3 := 1 to 76 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Use1 := Use1 + RndC;
                          End;
                        For lcv3 := 1 to 76 do
                          Begin
                            RndC := chr(Random(26) + 65);
                            Use2 := Use2 + RndC;
                          End;
                        For lcv2 := 1 to 4 do
                          Begin
                          RndB := Random(2);
                          If RndB = 0 then Origin[lcv2] := FALSE
                            Else Origin[lcv2] := TRUE;
                          End;
                      End;
               End;
     End;

Procedure Save(var List:Group);
  Var
    lcv: Integer;
  Begin
    ReWrite(f);
    For lcv := 1 to 110 do
      Begin
        Write(lcv);
        GotoXY(27,WhereY);
        Write(f,List[lcv]);
      End;
    Close(f);
  End;

Begin
  ClrScr;
  Assign(f, 'minerals.dat');
  WriteLn('Creating random data file for MINERAL MASTER. . .');
  max := 110;
  Write('  Initalizing array location :  ');
  InitArray(List);
  WriteLn;
  WriteLn;
  Write('  Creating random data for array location:  ');
  RandData(List);
  WriteLn;
  WriteLn;
  Write('  Saving array location:  ');
  Save(List);
  WriteLn;
  WriteLn;
  WriteLn('Finished!');
  ReadLn;
End.