Program Cyber2_Edit;

Uses CRT, DOS;

Const
     STRI76 = 76;
     MAX = 800;
Type
  ST76 = String[STRI76];
  String20 = String[20];

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
              ToUser,FromUser: String20;
              Line1,Line2,Line3,Line4,Line5,Line6,Line7,Line8: ST76;
              Seen: Boolean;
            End;

  Group = Array[0..MAX] of Objects;

Var
  List: Group;
  Ans: AnsiList;
  Des: DesList;
  Mes: MesList;
  num: Integer;
  sel: Char;
  f: File of Objects;
{/////////////////////////////////////////////////////////////////////////}
Procedure LoadObjects(var List:Group);
  Var
    lcv: Integer;
    f: File of Objects;
  Begin
    Assign(f, 'UNIVERSE.DAT');
    ReSet(f);
    For lcv := 0 to MAX do
      Begin
        Read(f, List[lcv]);
      End;
    Close(f);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure SaveObjects(var List:Group);
  Var
    lcv: Integer;
    f: File of Objects;
  Begin
    Assign(f, 'UNIVERSE.DAT');
    ReSet(f);
    For lcv := 0 to MAX do
      Begin
        Write(f, List[lcv]);
      End;
    Close(f);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure Other(var List:Group;num:Integer);
  Var
    a: File of AnsiList;
    d: File of DesList;
    sel: Char;
  Begin
    Assign(a,'ANSILIST.DAT');
    Assign(d,'DESCRIPT.DAT');
    ReSet(a);
    Seek(a,num);
    Read(a,Ans);
    Close(a);
    ReSet(d);
    Seek(d,num);
    Read(d,Des);
    Close(d);
    Repeat
      ClrScr;
      Write('Record #',num);
      If (List[num].Name = '')  AND (List[num].RLoc = -1) then WriteLn('    DELETED')
        Else WriteLn;
      GotoXY(35,WhereY);
      WriteLn('DECRIPTIONS');
      WriteLn('1]  Line(1): ',Des.Des1);
      WriteLn('2]  Line(2): ',Des.Des3);
      WriteLn('3]  Line(3): ',Des.Des4);
      WriteLn('4]  Line(4): ',Des.Des4);
      WriteLn;
      GotoXY(35,WhereY);
      WriteLn('ANSI FILE');
      WriteLn('A]  ANSI file: ',Ans.Name);
      WriteLn;
      WriteLn('$]  Delete entry');
      WriteLn('R]  Return to main menu');
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        Case sel of
          '1': Begin
                 WriteLn('Enter in the first line of ',List[num].Name,'''s discription:');
                 ReadLn(Des.Des1);
               End;
          '2': Begin
                 WriteLn('Enter in the second line of ',List[num].Name,'''s discription:');
                 ReadLn(Des.Des2);
               End;
          '3': Begin
                 WriteLn('Enter in the third line of ',List[num].Name,'''s discription:');
                 ReadLn(Des.Des3);
               End;
          '4': Begin
                 WriteLn('Enter in the fourth line of ',List[num].Name,'''s discription:');
                 ReadLn(Des.Des4);
               End;
          'A': Begin
                 Write('Enter in the ANSI file for this object: ');
                 ReadLn(Ans.Name);
               End;
          '$': Begin
                 List[num].Name := '';
                 List[num].Bto := -1;
                 List[num].Cby := -1;
                 List[num].RLoc := -1;
                 List[num].OType := 0;
                 List[num].goOK := -1;
                 List[num].goFAIL := -1;
                 List[num].goDROP := -1;
                 List[num].keyOK := -1;
                 List[num].keyFAIL := -1;
                 List[num].Price := 0;
                 List[num].LtDk := FALSE;
                 List[num].Shadow := FALSE;
                 List[num].Magic := FALSE;
                 Des.Des1 := '';
                 Des.Des3 := '';
                 Des.Des4 := '';
                 Des.Des4 := '';
                 Ans.Name := '';
               End;
        End;
      Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = '4') or
            (sel = 'A') or (sel = '$') or (sel = 'R');
    Until sel = 'R';
    ReSet(a);
    Seek(a,num);
    Write(a,Ans);
    Close(a);
    ReSet(d);
    Seek(d,num);
    Write(d,Des);
    Close(d);
  End;
{/////////////////////////////////////////////////////////////////////////}
Begin
  LoadObjects(List);
  num := 0;
  Repeat
    ClrScr;
    Write('Record #',num);
    If (List[num].Name = '') AND (List[num].RLoc = -1) then WriteLn('    DELETED')
      Else WriteLn;
    WriteLn('A]  Name: ',List[num].Name);
    WriteLn('B]  Belongs to: ',List[num].Bto);
    WriteLn('C]  Created by: ',List[num].Cby);
    WriteLn('D]  Location: ',List[num].RLoc);
    WriteLn('E]  Type: ',List[num].OType);
    WriteLn('F]  Go-OK: ',List[num].goOK);
    WriteLn('G]  GO-FAIL: ',List[num].goFAIL);
    WriteLn('H]  GO-DROP: ',List[num].goDROP);
    WriteLn('I]  KEY-OK: ',List[num].keyOK);
    WriteLn('J]  KEY-FAIL: ',List[num].keyFAIL);
    WriteLn('K]  Price: ',List[num].Price);
    WriteLn('L]  Object is light: ',List[num].LtDk);
    WriteLn('M]  Object is shadow: ',List[num].Shadow);
    WriteLn('N]  Object is shareable: ',List[num].Magic);
    WriteLn;
    WriteLn('O]  Other options');
    WriteLn('Q]  Quit');
    WriteLn;
    WriteLn('Enter command or "]" to advance one record and "[" to go back a record');
    Repeat
      Repeat
        sel := ReadKey;
      Until sel <> '';
      sel := UpCase(sel);
      Case sel of
        'A': Begin
               WriteLn;
               Write('Enter a NEW name: ');
               ReadLn(List[num].Name);
             End;
        'B': Begin
               WriteLn;
               Write('Enter the NEW owner''s ID number: ');
               ReadLn(List[num].Bto);
               If (List[num].Bto < 2) or (List[num].Bto > MAX) then
                 List[num].Bto := -1;
             End;
        'C': Begin
               WriteLn;
               Write('Enter the NEW creators''s ID number: ');
               ReadLn(List[num].Cby);
               If (List[num].Cby < 2) or (List[num].Cby > MAX) then
                 List[num].Cby := -1;
             End;
        'D': Begin
               WriteLn;
               Write('Enter the NEW location ID number for this object: ');
               ReadLn(List[num].RLoc);
               If (List[num].RLoc < 1) or (List[num].RLoc > MAX) then
                 List[num].RLoc := 1;
             End;
        'E': Begin
               WriteLn;
               Write('Enter the NEW object type: ');
               ReadLn(List[num].OType);
               If (List[num].OType < 0) or (List[num].OType > 10) then
                 List[num].OType := 0;
             End;
        'F': Begin
               WriteLn;
               Write('Enter the NEW GO-OK link ID number: ');
               ReadLn(List[num].goOK);
               If (List[num].goOK < 1) or (List[num].goOK > MAX) then
                 List[num].goOK := -1;
             End;
        'G': Begin
               WriteLn;
               Write('Enter the NEW GO-FAIL link ID number: ');
               ReadLn(List[num].goFAIL);
               If (List[num].goFAIL < 1) or (List[num].goFAIL > MAX) then
                 List[num].goFAIL := -1;
             End;
        'H': Begin
               WriteLn;
               Write('Enter the NEW GO-DROP link ID number: ');
               ReadLn(List[num].goDROP);
               If (List[num].goDROP < 1) or (List[num].goDROP > MAX) then
                 List[num].goDROP := -1;
             End;
        'I': Begin
               WriteLn;
               Write('Enter the NEW KEY-OK link ID number: ');
               ReadLn(List[num].keyOK);
               If (List[num].keyOK < 1) or (List[num].keyOK > MAX) then
                 List[num].keyOK := -1;
             End;
        'J': Begin
               WriteLn;
               Write('Enter the NEW KEY-FAIL link ID number: ');
               ReadLn(List[num].keyFAIL);
               If (List[num].keyFAIL < 1) or (List[num].keyFAIL > MAX) then
                 List[num].keyFAIL := -1;
             End;
        'K': Begin
               WriteLn;
               Write('Enter the NEW proce for this object: ');
               ReadLn(List[num].Price);
               If List[num].Price < 0 then
                 List[num].Price := 0;
             End;
        'L': Begin
               If List[num].LtDk then List[num].LtDk := FALSE
                 Else List[num].LtDk := TRUE;
             End;
        'M': Begin
               If List[num].Shadow then List[num].Shadow := FALSE
                 Else List[num].Shadow := TRUE;
             End;
        'N': Begin
               If List[num].Magic then List[num].Magic := FALSE
                 Else List[num].Magic := TRUE;
             End;
        '[': Begin
               dec(num,1);
               If num < 0 then num := 0;
             End;
        ']': Begin
               inc(num,1);
               If num > MAX then num := MAX;
             End;
        'O': Other(List,num);
      End;
    Until (sel = 'A') or (sel = 'B') or(sel = 'C') or(sel = 'D') or
          (sel = 'E') or (sel = 'F') or (sel = 'G') or (sel = 'H') or
          (sel = 'I') or (sel = 'J') or (sel = 'K') or (sel = 'L') or
          (sel = 'M') or (sel = 'N') or (sel = 'O') or (sel = '[') or
          (sel = ']') or (sel = 'Q');
  Until sel = 'Q';
  SaveObjects(List);
End.