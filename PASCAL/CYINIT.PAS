Program CyberSpace_II__INIT;

Const
     STRI76 = 76;
     MAX = 1000;
Type
  String20 = String[20];
  ST76 = String[STRI76];
  String47 = String[47];
  Objects = Record
             Name: String20;
             Bto: Integer;
             Cby: Integer;
             RLoc: Integer;
             OType: Byte;
             goOK: Integer;
             goFAIL: Integer;
             goDROP: Integer;
             keyOK: Integer;
             keyFAIL: Integer;
             Price: LongInt;
             LtDk: Boolean;
             Shadow: Boolean;
             Magic: Boolean;
           End;
  AnsiList = Record
               Name: String[11];
             End;
  DesList = Record
              Des1: ST76;
              Des2: ST76;
              Des3: ST76;
              Des4: ST76;
            End;
  MesList = Record
              ToUser,FromUser: String47;
              Line1,Line2,Line3,Line4,Line5,Line6,Line7,Line8: ST76;
              Seen: Boolean;
            End;
  Group = Array[0..MAX] of Objects;  (*MAX w/o keys 1576*)  (*MAX w/ keys 1437*)

Var
  List: Group;
  Ans: AnsiList;
  Des: DesList;
  Mes: MesList;
  f: File of Objects;
  a: File of AnsiList;
  d: File of DesList;
  m: File of MesList;
  lcv: Integer;

Begin
  WriteLn;
  WriteLn('Cyber Space II Initalization. . .');
  WriteLn;
  WriteLn;
  Write('Creating object index: ');
  Assign(f,'UNIVERSE.DAT');
  ReWrite(f);
  For lcv := 0 to MAX do
    Begin
      List[lcv].Name := '';
      List[lcv].Bto := -1;
      List[lcv].Cby := -1;
      List[lcv].RLoc := -1;
      List[lcv].OType := 0;
      List[lcv].goOK := -1;
      List[lcv].goFAIL := -1;
      List[lcv].goDROP := -1;
      List[lcv].keyOK := -1;
      List[lcv].keyFAIL := -1;
      List[lcv].Price := 0;
      List[lcv].LtDk := FALSE;
      List[lcv].Shadow := FALSE;
      List[lcv].Magic := FALSE;
    End;
  List[0].Name := 'DEFAULT';
  List[0].Bto := 2;
  List[0].Cby := 2;
  List[0].OType := 3;
  List[0].goOK := 0;
  List[0].Price := 0;
  List[1].Name := 'THE VOID';
  List[1].Bto := 2;
  List[1].Cby := 2;
  List[1].OType := 3;
  For lcv:= 0 to MAX do
    Write(f, List[lcv]);
  Close(f);
  WriteLn('DONE');
  Write('Creating description index: ');
  Assign(d,'DESCRIPT.DAT');
  ReWrite(d);
  Des.Des1 := '';
  Des.Des2 := '';
  Des.Des3 := '';
  Des.Des4 := '';
  For lcv := 0 to MAX do
    Write(d,Des);
  Close(d);
  WriteLn('DONE');
  Write('Creating ansi index: ');
  Assign(a,'ANSILIST.DAT');
  ReWrite(a);
  Ans.Name := '';
  For lcv := 0 to MAX do
    Write(a,Ans);
  Close(a);
  WriteLn('DONE');
  Write('Creating message index: ');
  Assign(m,'MESSAGE.DAT');
  ReWrite(m);
  Mes.ToUser := '';
  Mes.FromUser := '';
  Mes.Line1 := '';
  Mes.Line2 := '';
  Mes.Line3 := '';
  Mes.Line4 := '';
  Mes.Line5 := '';
  Mes.Line6 := '';
  Mes.Line8 := '';
  Mes.Seen := TRUE;
  For lcv := 0 to MAX do
    Write(m,Mes);
  Close(m);
  WriteLn('DONE');
  WriteLn;
  WriteLn;
  WriteLn('Complete.');
  WriteLn;
End.