Program CyberSpace_II__INIT;

Const
  max = 1437;  (*MAX w/o keys 1576*)  (*MAX w/ keys 1437*)

Type
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
{  AnsiList = Record
               Name: String[11];
             End;}
  Group = Array[0..max] of Objects;

Var
  List: Group;
{  AList: AnsiList;}
  f: File of Objects;
  lcv: Integer;

Begin
  WriteLn;
  WriteLn;
  Write('Creating object file: ');
  Assign(f,'universe.dat');
  ReWrite(f);
  For lcv := 0 to max do
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
  List[1].Name := 'THE VOID';
  List[1].Bto := 2;
  List[1].Cby := 2;
  List[1].OType := 3;
  For lcv:= 0 to max do
    Write(f, List[lcv]);
  Close(f);
  WriteLn('DONE');
  WriteLn;
  WriteLn;
End.