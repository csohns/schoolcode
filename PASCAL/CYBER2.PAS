Program CyberSpace_II;

Uses
  CRT, DOS, ANSIDRV, NovApi;

Const
     STRI76 = 76;
     MAX = 800;
Type
  ST76 = String[STRI76];
  String20 = String[20];
  String40 = String[40];
(*  String47 = String[47];   {Only for LOCAL TESTING!!!!!!!!!!}*)
(*  UserRights = Record
                 User: String20;
                 Rights: Array[1..8] of Byte;
               End;*)
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
(*             URights: Array[1..10] of UserRights;*)
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
  Group = Array[0..MAX] of Objects;  (*MAX w/o keys 1576*)  (*MAX w/ keys 1437*)

Var
  List: Group;
  Ans: AnsiList;
  Des: DesList;
  Mes: MesList;
  num: Integer;
  Ploc: Integer;
  command: String40;
  accepted: Boolean;
  Rate: Integer;
  sel: Char;
  ObjectID    : longint;
  ObjectType  : integer;
  ObjectName  : String47;
  ObjectLogin : NetworkTimeRecord;

{/////////////////////////////////////////////////////////////////////////}
Procedure c(col, int, back: Integer);
     Begin                      {Changes text color}
          If (col > 0) and (col < 32) then
               TextColor(col)
          Else TextColor(7);
          Case int of
               0: NormVideo;
               1: LowVideo;
               2: HighVideo;
          End;
          If (back > -1) and (back < 9) then
               TextBackground(back);
     End;
{/////////////////////////////////////////////////////////////////////////}
Procedure LoadObjects(var List:Group; var num:Integer);
  Var
    lcv: Integer;
    f: File of Objects;
  Begin
    Assign(f, 'UNIVERSE.DAT');
    ReSet(f);
    For lcv := 0 to MAX do
      Begin
        Read(f, List[lcv]);
        inc(num,1);
      End;
    Close(f);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure SaveObjects(var List:Group; var num:Integer);
  Var
    lcv: Integer;
    f: File of Objects;
  Begin
    Assign(f, 'UNIVERSE.DAT');
    ReSet(f);
    For lcv := 0 to MAX do
      Write(f, List[lcv]);
    Close(f);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure UpStr(var name:String40);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(name) do
      name[lcv] := UpCase(name[lcv]);
  End;
{/////////////////////////////////////////////////////////////////////////}
Function Find(name:String20; OType:Integer): Integer;
  Var
    lcv: Integer;
    cntr: Integer;
    found: Boolean;
  Begin
    cntr := 0;
    found := FALSE;
    Repeat
      inc(cntr,1);
      If (List[cntr].Name = name) and (List[cntr].OType = OType) and
         ((List[cntr].RLoc = Ploc) or (List[cntr].RLoc = List[Ploc].RLoc) or
          (List[Ploc].RLoc = cntr))
           then found := TRUE;
    Until (found) or (cntr = num);
    If found then Find := cntr
      Else Find := -1;
  End;
{/////////////////////////////////////////////////////////////////////////}
Function FindAll(name:String20): Integer;
  Var
    lcv: Integer;
    cntr: Integer;
    found: Boolean;
  Begin
    cntr := 0;
    found := FALSE;
    Repeat
      inc(cntr,1);
      If (List[cntr].Name = name) and ((List[cntr].RLoc = Ploc) or
         (List[cntr].RLoc = List[Ploc].RLoc) or (List[Ploc].RLoc = cntr))
           then found := TRUE;
    Until (found) or (cntr = num);
    If found then FindAll := cntr
      Else FindAll := -1;
  End;
{/////////////////////////////////////////////////////////////////////////}
Function FindU(name:String20; OType:Integer): Integer;
  Var
    lcv: Integer;
    cntr: Integer;
    found: Boolean;
  Begin
    cntr := 0;
    found := FALSE;
    Repeat
      inc(cntr,1);
      If (List[cntr].Name = name) and (List[cntr].OType = OType) then found := TRUE;
    Until (found) or (cntr = num);
    If found then FindU := cntr
      Else FindU := -1;
  End;
{/////////////////////////////////////////////////////////////////////////}
Function EFind: Integer;
  Var
    lcv: Integer;
    cntr: Integer;
    found: Boolean;
  Begin
    cntr := 0;
    found := FALSE;
    Repeat
      inc(cntr,1);
      If List[cntr].Name = '' then found := TRUE;
    Until (found) or (cntr = num);
    If found then EFind := cntr
      Else EFind := -1;
  End;
{/////////////////////////////////////////////////////////////////////////}
Function EFindM: Integer;
  Var
    lcv: Integer;
    cntr: Integer;
    found: Boolean;
    m: File of MesList;
    mm: MesList;
  Begin
    Assign(m,'MESSAGE.DAT');
    ReSet(m);
    cntr := 0;
    found := FALSE;
    Repeat
      inc(cntr,1);
      Seek(m,cntr);
      Read(m,mm);
      If mm.ToUser = '' then found := TRUE;
    Until (found) or (cntr = num);
    Close(m);
    If found then EFindM := cntr
      Else EFindM := -1;
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure OutofSpace;
  Begin
    WriteLn('Sorry, but CyberSpace II has run out of object space.');
    WriteLn;
    c(7,1,0);
    Halt;
  End;
{/////////////////////////////////////////////////////////////////////////}
Function NewUser(TmpName:String20;var List:Group; var num:Integer): Integer;
  Var
    lcv,loc: Integer;
  Begin
    c(15,2,0);
    loc := EFind;
    If loc = -1 then OutofSpace;
    With List[loc] do
      Begin
        Name := TmpName;
        Bto := loc;
        Cby := loc;
        RLoc := 1;
        OType := 4;
        Price := List[0].Price;
      End;
    NewUser := loc;
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure SignOn(var List:Group; var num:Integer; var Ploc:Integer);
  Var
    lcv: Integer;
    TmpName: String47;
    loc: Integer;
{    f: Text;}
  Begin
    WriteLn;
{
    Assign(f,'DORINFO.DEF');
    ReSet(f);
    ReadLn(f,TmpName);
    Close(f);
    Erase(f);
}
    c(10,2,0);
    Write('Novel NetWare ');
    c(12,2,0);
    Write('IPX');
    c(10,2,0);
    Write('/');
    c(12,2,0);
    Write('SPX');
    c(10,2,0);
    Write(' Interface installed');
    c(14,2,0);
    Write(' - ');
    c(9,2,0);
    GetConnectionInformation(connectionnumber,ObjectID,ObjectType,ObjectName,ObjectLogin);
    TmpName := '';
    For lcv := 1 to Length(ObjectName) do
      TmpName := TmpName + ObjectName[lcv];
    Write(TmpName);
    c(8,1,0);
    Write(' ');
    GotoXY(WhereX-1,WhereY);
    Delay(2000);
    c(15,2,0);
    WriteLn;
{
    c(15,2,0);
    WriteLn('Local user entering cyberspace');
    Write('Who do you wish to be? ');
    ReadLn(TmpName);
    If TmpName = '' then TmpName := 'LOCAL USER';
    UpStr(TmpName);
}
    loc := FindU(TmpName,5);
    If loc = -1 then loc := FindU(TmpName,4);
    If loc = -1 then loc := NewUser(TmpName,List,num);
    Ploc := loc;
    List[Ploc].LtDk := FALSE;
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure Status(Ploc:Integer);
  Var
    lcv: Integer;
  Begin
    c(7,1,0);
    ClrScr;
    c(8,1,7);
    For lcv := 1 to 160 do
      Write(' ');
    GotoXY(1,1);
    Write('Person  :  ',List[Ploc].Name, ' #(',Ploc,')');
    GotoXY(60,WhereY);
    WriteLn('Credits :  $',List[Ploc].Price);
    WriteLn('Location:  ',List[List[Ploc].RLoc].Name, ' #(',List[Ploc].RLoc,')');
    c(7,1,0);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure Display(Ploc:Integer; var List:Group; num:Integer);
  Var
    lcv: Integer;
    d: File of DesList;
    a: File of AnsiList;
{/////////////////////////////////////////////////////////////////}
  Procedure spa(num:Integer);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to num do
        Write(' ');
    End;
{/////////////////////////////////////////////////////////////////}
  Function See(lcv:Integer): Boolean;
    Begin
      If (List[lcv].Bto = Ploc) or (List[lcv].Cby = Ploc) or (List[Ploc].OType = 5) then
        See := TRUE
      Else See := FALSE;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure ObjDisp(var List:Group; num:Integer);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to num do
        Begin
          If List[lcv].RLoc = List[Ploc].RLoc then
            Begin
              Case List[lcv].OType of
                0: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         If (See(lcv)) then
                           Begin
                             c(8,2,0);
                             Write('*DARK* :',List[lcv].Name);
                           End;
                       End
                     Else Begin
                            c(10,2,0);
                            Write('Room   :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) and (See(lcv)) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else If (See(lcv)) then spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                2: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         If (See(lcv)) then
                           Begin
                             c(8,2,0);
                             Write('*DARK* :',List[lcv].Name);
                           End;
                       End
                     Else Begin
                            c(15,2,0);
                            Write('Object :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) and (See(lcv)) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else If (See(lcv)) then spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                4: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         If (See(lcv)) then
                           Begin
                             c(8,2,0);
                             Write('*DARK* :',List[lcv].Name);
                           End;
                         End
                     Else Begin
                            c(15,2,1);
                            Write('Person :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) and (See(lcv)) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else If (See(lcv)) then spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                5: Begin
                     If (List[lcv].LtDk) then
                       Begin
                        If (See(lcv)) then
                          Begin
                            c(8,2,0);
                            Write('*DARK* :',List[lcv].Name);
                          End;
                        End
                     Else Begin
                            c(12,2,0);
                            Write('Wizard :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) and (See(lcv)) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else If (See(lcv)) then spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
              End;
            End;
        End;
      WriteLn;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure ExitDisp(var List:Group; num:Integer);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to num do
        Begin
          If List[lcv].RLoc = List[Ploc].RLoc then
            Begin
              Case List[lcv].OType of
                6: Begin
                     If List[lcv].LtDk then
                       Begin
                         If See(lcv) then
                           Begin
                             c(15,2,0);
                             Write(List[lcv].Name, '  ');
                           End;
                       End
                     Else Begin
                            c(7,1,0);
                            Write(List[lcv].Name, '  ');
                          End;
                     c(11,2,0);
                   End;
              End;
            End;
        End;
      WriteLn;
    End;
{/////////////////////////////////////////////////////////////////}
  Begin             (*Display*)
    Assign(d,'DESCRIPT.DAT');
    ReSet(d);
    Seek(d,List[Ploc].RLoc);
    Read(d,Des);
    Close(d);
    Assign(a,'ANSILIST.DAT');
    ReSet(a);
    Seek(a,List[Ploc].RLoc);
    Read(a,Ans);
    Close(a);
    c(14,2,0);
    If (List[List[Ploc].RLoc].Bto = Ploc) or
       (List[List[Ploc].RLoc].Cby = Ploc) or
       (List[List[Ploc].RLoc].Magic) or
       (List[Ploc].OType = 5) then
      Begin
        Write(List[List[Ploc].RLoc].Name);
        c(7,1,0);
        WriteLn('  [You can /DIG here]');
      End
    Else WriteLn(List[List[Ploc].RLoc].Name);
    c(11,2,0);
    Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
    c(12,2,0);
    Write('Description');
    c(11,2,0);
    Write('Í');
    c(7,1,0);
    If Des.Des1 <> '' then
      Begin
        WriteLn(Des.Des1);
        If Des.Des2 <> '' then
          Begin
            WriteLn(Des.Des2);
          End;
            If Des.Des3 <> '' then
              Begin
                WriteLn(Des.Des3);
              End;
                If Des.Des4 <> '' then
                  Begin
                    WriteLn(Des.Des4);
                  End;
      End;
    c(11,2,0);
    Write('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
    c(12,2,0);
    Write('Objects');
    c(11,2,0);
    Write('Ä');
    ObjDisp(List,num);
    Write('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
    c(12,2,0);
    Write('Room exits');
    c(11,2,0);
    Write('Ä');
    ExitDisp(List,num);
    Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
    If Ans.Name <> '' then
     Begin
       c(4,1,0);
       Write('/VIEW');
       c(11,2,0);
       Write('Í');
     End
    Else Write('ÍÍÍÍÍÍ');
    c(7,1,0);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure RMove(var command:String40; Ploc:Integer; var List:Group; var accepted:Boolean);
  Var
    lcv,loc: Integer;
  Begin
    loc := Find(command,6);
    If (loc <> -1) and (List[loc].RLoc = List[Ploc].RLoc) then
      Begin
        If List[loc].keyOK <> -1 then
          Begin
            If List[List[loc].keyOK].RLoc = Ploc then
              Begin
                List[Ploc].RLoc := List[loc].goOK;
                accepted := TRUE;
                command := 'LOOK';
              End
            Else If List[Ploc].OType = 5 then
                   Begin
                     c(11,2,0);
                     Write('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
                     c(12,2,0);
                     Write('Error');
                     c(11,2,0);
                     Write('Ä');
                     WriteLn('This exit has been /KEYED to a specific object.  This restriction');
                     WriteLn('is over-ridden because you created the object. Press [ENTER] to continue.');
                     Write('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
                     c(7,1,0);
                     WriteLn;
                     Write('Exit is keyed for ');
                     WriteLn(List[List[loc].keyOK].Name, ' #(', List[loc].keyOK, ')');
                     c(11,2,0);
                     Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
                     c(7,1,0);
                     List[Ploc].RLoc := List[loc].goOK;
                     accepted := TRUE;
                     command := 'LOOK';
                     ReadLn;
                   End Else
                 Begin
                   If List[loc].keyFAIL <> -1 then
                    Begin
                      List[Ploc].RLoc := List[loc].keyFAIL;
                      accepted := TRUE;
                      command := 'LOOK';
                    End
                   Else Begin
                          c(3,1,0);
                          Write(List[loc].Name);
                          c(7,1,0);
                          WriteLn(' has been keyed to an object.');
                          accepted := TRUE;
                        End;
                 End;
          End
        Else Begin
               List[Ploc].RLoc := List[loc].goOK;
               accepted := TRUE;
               command := 'LOOK';
             End;
      End;
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure ErrMsg(texts:String);
  Var
    lcv: Integer;
  Begin
    c(11,2,0);
    For lcv := 1 to Length(texts) do
      Write('Ä');
    WriteLn;
    c(7,1,0);
    WriteLn(texts);
    c(11,2,0);
    For lcv := 1 to Length(texts) do
      Write('Ä');
    WriteLn;
    c(7,1,0);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure RateChk(var Rate:Integer; var List:Group);
  Begin
    inc(Rate,1);
    If Rate = List[0].goOK then
      Begin
        Rate := 0;
        inc(List[Ploc].Price,1);
      End;
    If Rate > List[0].goOK then Rate := 0;
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure CommandCode(command:String40; Ploc:Integer; var List:Group; var accepted:Boolean);
  Var
    lcv: Integer;
    Cmand: String20;
    Parm1: String20;
{/////////////////////////////////////////////////////////////////}
  Procedure Center(texts:String);
    Begin
      GotoXY(40-(Length(texts) div 2),WhereY);
      WriteLn(texts);
    End;
{/////////////////////////////////////////////////////////////////}
  Function Crunch(Parm1_40:String40): String20;
    Var
      lcv: Integer;
      TmpParm:String20;
    Begin
      TmpParm := '';
      For lcv := 1 to Length(Parm1_40) do
        TmpParm := TmpParm + Parm1_40[lcv];
      Crunch := TmpParm;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Dig(Parm1:String20; var List:Group);
    Var
      loc,loc2,loc3: Integer;
      Parm1_40: String40;
    Begin
      If (List[List[Ploc].RLoc].Bto = Ploc) or
         (List[List[Ploc].RLoc].Cby = Ploc) or
         (List[List[Ploc].RLoc].Magic) or
         (List[Ploc].OType = 5) then
        Begin
          WriteLn;
          WriteLn;
          loc := EFind;
          If loc = -1 then OutofSpace;
          List[loc].Name := Parm1;
          List[loc].Bto := Ploc;
          List[loc].Cby := Ploc;
          List[loc].OType := 3;
          WriteLn('The digging of a room is no small feat and your powers are tested');
          WriteLn('to their very limits, when finally the void gives way as you impose');
          WriteLn('you will upon it.');
          WriteLn;
          WriteLn('You are in: ',List[List[Ploc].RLoc].Name);
          WriteLn('You create: ',List[loc].Name);
          WriteLn;
          WriteLn;
          WriteLn;
          Write('What would you call the exit from the ',List[List[Ploc].RLoc].Name,': ');
          ReadLn(Parm1_40);
          UpStr(Parm1_40);
          Parm1 := Crunch(Parm1_40);
          loc2 := EFind;
          If loc2 = -1 then OutofSpace;
          List[loc2].Name := Parm1;
          List[loc2].Bto := Ploc;
          List[loc2].Cby := Ploc;
          List[loc2].RLoc := List[Ploc].RLoc;
          List[loc2].OType := 6;
          List[loc2].goOK := loc;
          WriteLn;
          Write('What would you call the exit from the ',List[loc].Name,': ');
          ReadLn(Parm1_40);
          UpStr(Parm1_40);
          Parm1 := Crunch(Parm1_40);
          loc2 := EFind;
          If loc2 = -1 then OutofSpace;
          List[loc2].Name := Parm1;
          List[loc2].Bto := Ploc;
          List[loc2].Cby := Ploc;
          List[loc2].RLoc := loc;
          List[loc2].OType := 6;
          List[loc2].goOK := List[Ploc].RLoc;
          WriteLn;
          WriteLn;
          WriteLn('Tired, but satisfied with a job well done, you sit back to admire your');
          WriteLn('handicraft....  However you still need to describe your new room...');
          WriteLn;
        End
      Else Begin
             c(11,2,0);
             Center('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(7,1,0);
             Center('You do not have rights to /DIG here.');
             c(11,2,0);
             Center('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(7,1,0);
           End;
    End;
{/////////////////////////////////////////////////////////////////////////}
Procedure PersonalDisplay(Ploc:Integer; var List:Group);
  Var
    lcv: Integer;
    d: File of DesList;
{/////////////////////////////////////////////////////////////////}
  Procedure spa(num:Integer);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to num do
        Write(' ');
    End;
{/////////////////////////////////////////////////////////////////}
  Function See(lcv:Integer): Boolean;
    Begin
      If (List[lcv].Bto = Ploc) or (List[lcv].Cby = Ploc) or (List[Ploc].OType = 5) then
        See := TRUE
      Else See := FALSE;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure ObjDisp(var List:Group; num:Integer);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to num do
        Begin
          If List[lcv].RLoc = Ploc then
            Begin
              Case List[lcv].OType of
                0: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         c(8,2,0);
                         Write('*DARK* :',List[lcv].Name);
                       End
                     Else Begin
                            c(10,2,0);
                            Write('Room   :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                2: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         c(8,2,0);
                         Write('*DARK* :',List[lcv].Name);
                       End
                     Else Begin
                            c(15,2,0);
                            Write('Object :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                4: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         c(8,2,0);
                         Write('*DARK* :',List[lcv].Name);
                         End
                     Else Begin
                            c(15,2,1);
                            Write('Person :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
                5: Begin
                     If (List[lcv].LtDk) then
                       Begin
                         c(8,2,0);
                         Write('*DARK* :',List[lcv].Name);
                        End
                     Else Begin
                            c(12,2,0);
                            Write('Wizard :',List[lcv].Name);
                          End;
                     If (List[lcv].LtDk) then
                       Begin
                         If (List[lcv].Magic) then
                           Begin
                             Write('  <s>');
                             spa(40 - (Length(List[lcv].Name) + 13));
                           End
                         Else spa(40 - (Length(List[lcv].Name) + 8));
                       End
                     Else Begin
                            If List[lcv].Magic then
                              Begin
                                Write('  <s>');
                                spa(40 - (Length(List[lcv].Name) + 13));
                              End
                            Else spa(40 - (Length(List[lcv].Name) + 8));
                          End;
                     c(11,2,0);
                   End;
              End;
            End;
        End;
      WriteLn;
    End;
{/////////////////////////////////////////////////////////////////}
  Begin             (*PersonalDisplay*)
    Assign(d,'DESCRIPT.DAT');
    c(14,2,0);
    WriteLn(List[Ploc].Name);
    c(11,2,0);
    Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
    c(12,2,0);
    Write('Description');
    c(11,2,0);
    Write('Í');
    c(7,1,0);
    ReSet(d);
    Seek(d,Ploc);
    Read(d,Des);
    Close(d);
    If Des.Des1 <> '' then WriteLn(Des.Des1);
    If Des.Des2 <> '' then WriteLn(Des.Des2);
    If Des.Des3 <> '' then WriteLn(Des.Des3);
    If Des.Des4 <> '' then WriteLn(Des.Des4);
    c(11,2,0);
    Write('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
    c(12,2,0);
    Write('Objects');
    c(11,2,0);
    Write('Ä');
    ObjDisp(List,num);
    Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
    c(7,1,0);
  End;
{/////////////////////////////////////////////////////////////////}
  Procedure Create(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := EFind;
      If loc = -1 then OutofSpace;
      List[loc].Name := Parm1;
      List[loc].Bto := Ploc;
      List[loc].Cby := Ploc;
      List[loc].RLoc := Ploc;
      List[loc].OType := 2;
      WriteLn('You casts your spell and ', Parm1, ' appears in your hands.');
      WriteLn;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Take(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If (loc = -1) or (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not take what is not here')
      Else Begin
             If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or
                (List[Ploc].OType = 5) or (List[loc].Magic) then
               Begin
                 List[loc].RLoc := Ploc;
                 WriteLn('You now posess ', Parm1,'.');
                 WriteLn;
               End
             Else ErrMsg('You can not take what is not yours.');
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Drop(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If (loc = -1) or (List[loc].RLoc <> Ploc) then
        ErrMsg('You can not drop what you do not have')
      Else Begin
             List[loc].RLoc := List[Ploc].RLoc;
             WriteLn('You drop ', Parm1,'.');
             WriteLn;
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Kill(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then loc := Find(Parm1,6);
      If loc = -1 then
        ErrMsg('You can not kill what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not kill what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
             Begin
               List[loc].Name := '';
               List[loc].Bto := -1;
               List[loc].Cby := -1;
               List[loc].RLoc := -1;
               List[loc].OType := 0;
               List[loc].goOK := -1;
               List[loc].goFAIL := -1;
               List[loc].goDROP := -1;
               List[loc].keyOK := -1;
               List[loc].keyFAIL := -1;
               List[loc].Price := 0;
               List[loc].LtDk := FALSE;
               List[loc].Shadow := FALSE;
               List[loc].Magic := FALSE;
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(9,2,3);
               Write(Parm1);
               c(1,1,0);
               Write(' is consumed in a ');
               c(4,1,0);
               Write('fiery blaze');
               c(1,1,0);
               WriteLn(', never to be seen again.');
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(7,1,0);
             End
           Else ErrMsg('You can not kill what is not yours!')
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure KillR(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,3);
      If loc = -1 then
        ErrMsg('You can not kill what is not here') Else
      If (List[Ploc].RLoc <> loc) then
        ErrMsg('You can not kill what is not here')
      Else Begin
             List[loc].Name := '';
             List[loc].Bto := -1;
             List[loc].Cby := -1;
             List[loc].RLoc := -1;
             List[loc].OType := 0;
             List[loc].goOK := -1;
             List[loc].goFAIL := -1;
             List[loc].goDROP := -1;
             List[loc].keyOK := -1;
             List[loc].keyFAIL := -1;
             List[loc].Price := 0;
             List[loc].LtDk := FALSE;
             List[loc].Shadow := FALSE;
             List[loc].Magic := FALSE;
             c(11,2,0);
             WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(9,2,3);
             Write(Parm1);
             c(1,1,0);
             Write(' is consumed in a ');
             c(4,1,0);
             Write('fiery blaze');
             c(1,1,0);
             WriteLn(', never to be seen again.');
             c(11,2,0);
             WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(7,1,0);
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure KillU(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,4);
      If loc = -1 then loc := Find(Parm1,5);
      If loc = -1 then
        ErrMsg('You can not kill what does not exist')
      Else Begin
             List[loc].Name := '';
             List[loc].Bto := -1;
             List[loc].Cby := -1;
             List[loc].RLoc := -1;
             List[loc].OType := 0;
             List[loc].goOK := -1;
             List[loc].goFAIL := -1;
             List[loc].goDROP := -1;
             List[loc].keyOK := -1;
             List[loc].keyFAIL := -1;
             List[loc].Price := 0;
             List[loc].LtDk := FALSE;
             List[loc].Shadow := FALSE;
             List[loc].Magic := FALSE;
             c(11,2,0);
             WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(9,2,3);
             Write(Parm1);
             c(1,1,0);
             Write(' is consumed in a ');
             c(4,1,0);
             Write('fiery blaze');
             c(1,1,0);
             WriteLn(', never to be seen again.');
             c(11,2,0);
             WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
             c(7,1,0);
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Home(var List:Group);
    Var
      loc: Integer;
    Begin
      List[Ploc].RLoc := 1;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure ReName(Parm1:String20; var List:Group);
    Var
      lcv,loc: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      loc := FindAll(PM1);
      If loc = -1 then
        ErrMsg('You can not rename what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not rename what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
             Begin
               If (List[loc].OType = 4) or (List[loc].OType = 5) then
                 ErrMsg('You can not rename people!!')
               Else Begin
                      List[loc].Name := Parm2;
                      WriteLn(PM1, ' has been renamed to ', Parm2);
                      WriteLn;
                    End;
             End
           Else ErrMsg('You can not rename what is not yours!')
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Wizard(var List:Group);
    Var
      pass: String20;
      pass40: String40;
    Begin
      If List[Ploc].OType = 4 then
        Begin
          c(14,2,0);
          Write('Enter in Wizard password: ');
          ReadLn(pass40);
          UpStr(pass40);
          pass := Crunch(pass40);
          If pass = List[0].Name then
            Begin
              c(7,1,0);
              List[Ploc].OType := 5;
              Write('You may now manipulate ');
              c(12,2,0);
              Write('ANYTHING');
              c(7,1,0);
              WriteLn(' in Cyberspace.');
            End;
        End
      Else Begin
             List[Ploc].OType := 4;
             c(8,2,0);
             WriteLn('You are now a lowly apprentice.');
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Password(var List:Group);
    Var
      pass: String20;
      pass40: String40;
    Begin
      c(14,2,0);
      Write('Enter in NEW Wizard password: ');
      ReadLn(pass40);
      UpStr(pass40);
      pass := Crunch(pass40);
      List[0].Name := pass;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Generate(Parm1:String20; var List:Group);
    Var
      Credits: LongInt;
      lcv: Integer;
    Begin
      Credits := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          Credits := Credits + (Ord(Parm1[lcv]) - 48);
          Credits := Credits * 10;
        End;
      Credits := Credits DIV 10;
      List[Ploc].Price := List[Ploc].Price + Credits;
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
      Write('You have an addition of ');
      c(4,2,0);
      Write(Parm1);
      c(7,1,0);
      WriteLn(' to your account.');
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Give(Parm1:String20; var List:Group);
    Var
      Credits: LongInt;
      lcv,loc: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      loc := Find(PM1,5);
      If loc = -1 then loc := Find(PM1,4);
      If loc = -1 then
        ErrMsg('You can not give credits to a non existant person') Else
      Begin
        Credits := 0;
        For lcv := 1 to Length(Parm1) do
          Begin
            Credits := Credits + (Ord(Parm1[lcv]) - 48);
            Credits := Credits * 10;
          End;
        Credits := Credits DIV 10;
        List[loc].Price := List[loc].Price + Credits;
        c(11,2,0);
        WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
        c(7,1,0);
        Write('You have an addition of ');
        c(4,2,0);
        Write(Parm2);
        c(7,1,0);
        Write(' to ');
        c(14,2,0);
        Write(PM1);
        c(7,1,0);
        WriteLn('''s account.');
        c(11,2,0);
        WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
        c(7,1,0);
      End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Exit(Parm1:String20; var List:Group);
    Var
      EndUp,lcv,loc: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      EndUp := 0;
      For lcv := 1 to Length(Parm2) do
        Begin
          EndUp := EndUp + (Ord(Parm2[lcv]) - 48);
          EndUp := EndUp * 10;
        End;
      EndUp := EndUp DIV 10;
      WriteLn('Parm1: ',Parm1,'  ','Parm2: ',Parm2,'  ','PM1: ',PM1,'  ','EndUp:  ',Endup);
      If (List[Ploc].Bto = Ploc) or (List[Ploc].Cby = Ploc) or (List[Ploc].OType = 5) then
             Begin
               If (EndUp > 0) and (EndUp <= MAX) and
                  (List[EndUp].OType = 3) and ((List[EndUp].Bto = Ploc) or
                  (List[EndUp].Cby = Ploc) or (List[Ploc].OType = 5)) then
                 Begin
                   loc := EFind;
                   If loc = -1 then OutofSpace;
                   List[loc].Name := PM1;
                   List[loc].Bto := Ploc;
                   List[loc].Cby := Ploc;
                   List[loc].RLoc := List[Ploc].RLoc;
                   List[loc].OType := 6;
                   List[loc].goOK := EndUp;
                   c(11,2,0);
                   WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
                   c(7,1,0);
                   WriteLn(PM1,' now links to ', List[EndUp].Name);
                   c(11,2,0);
                   WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
                   c(7,1,0);
                 End
               Else ErrMsg('You can not create an exit to a room that is not yours!')
             End
           Else ErrMsg('You can not create an exit in a room that is not yours!')
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Cost(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then ErrMsg('You can not examine the cost of what is not here') Else
      If (List[loc].RLoc <> List[Ploc].RLoc) and (List[loc].RLoc <> Ploc) then
        ErrMsg('You can not examine the cost of what is not here')
      Else Begin
             If List[loc].Price = 0 then
               Begin
                 c(14,2,0);
                 Write(Parm1);
                 c(7,1,0);
                 WriteLn(' is not for sale.');
               End
             Else Begin
                    c(14,2,0);
                    Write(Parm1);
                    c(7,1,0);
                    Write(' costs $');
                    c(10,2,0);
                    Write(List[loc].Price);
                    c(7,1,0);
                    WriteLn(' to purchase.');
                  End;
           End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Price(Parm1:String20; var List:Group);
    Var
      EndUp,lcv,loc: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      EndUp := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          EndUp := EndUp + (Ord(Parm1[lcv]) - 48);
          EndUp := EndUp * 10;
        End;
      EndUp := EndUp DIV 10;
      loc := Find(PM1,2);
      If loc = -1 then ErrMsg('You can not price what is not here.') Else
      If (List[loc].RLoc <> List[Ploc].RLoc) and (List[loc].RLoc <> Ploc) then
        ErrMsg('You can not price what is not here.')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
             Begin
               List[loc].Price := EndUp;
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(7,1,0);
               WriteLn(PM1,' now costs $', EndUp);
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(7,1,0);
             End
           Else ErrMsg('You can not price what is not yours!');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Buy(Parm1:String20; var List:Group);
    Var
      EndUp,lcv,loc: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      EndUp := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          EndUp := EndUp + (Ord(Parm1[lcv]) - 48);
          EndUp := EndUp * 10;
        End;
      EndUp := EndUp DIV 10;
      loc := Find(PM1,2);
      If loc = -1 then ErrMsg('You can not buy what is not here.') Else
      If (List[loc].RLoc <> List[Ploc].RLoc) and (List[loc].RLoc <> Ploc) then
        ErrMsg('You can not buy what is not here.') Else
      If List[loc].Price > 1 then
      Begin
           If List[Ploc].Price - List[loc].Price > 0 then
             Begin
               List[Ploc].Price := List[Ploc].Price - List[loc].Price;
               List[loc].Bto := Ploc;
               List[loc].Price := 0;
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(7,1,0);
               WriteLn(PM1,' now belongs to you!');
               c(11,2,0);
               WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
               c(7,1,0);
             End
           Else ErrMsg('You do not have enough money!');
      End
      Else ErrMsg('This item is not for sale!!');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Share(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      If Parm1 <> '' then loc := Find(Parm1,2)
        Else loc := List[Ploc].RLoc;
      If loc = -1 then ErrMsg('You can not share what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) and (Parm1 <> '') then
        ErrMsg('You can not share what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
             If List[loc].Magic = FALSE then
               Begin
                 List[loc].Magic := TRUE;
                 If Parm1 = '' then
                   Begin
                     Parm1 := List[List[Ploc].RLoc].Name;
                     c(7,1,0);
                     Write('Now anyone can dig in ');
                     c(14,2,0);
                     Write(Parm1);
                     c(7,1,0);
                     WriteLn('.');
                   End
                 Else Begin
                        c(14,2,0);
                        Write(Parm1);
                        c(7,1,0);
                        WriteLn(' can now be carried by everyone.');
                      End;
               End
             Else Begin
                    List[loc].Magic := FALSE;
                    If Parm1 = '' then
                      Begin
                        Parm1 := List[List[Ploc].RLoc].Name;
                        Write('Now only you can dig in ');
                        c(14,2,0);
                        Write(Parm1);
                        c(7,1,0);
                        WriteLn('.');
                      End
                    Else Begin
                           Write('Now only you can carry ');
                           c(14,2,0);
                           Write(Parm1);
                           c(7,1,0);
                           WriteLn('.');
                         End;
                  End;
            End
           Else ErrMsg('You can not mark share for an object you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Key(Parm1:String20; var List:Group);
    Var
      KeyObj,lcv,loc,loc2: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      KeyObj := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          KeyObj := KeyObj + (Ord(Parm1[lcv]) - 48);
          KeyObj := KeyObj * 10;
        End;
      KeyObj := KeyObj DIV 10;
      loc := Find(PM1,6);
      If loc = -1 then ErrMsg('You can not key an exit that is not here.') Else
      If List[loc].RLoc <> List[Ploc].RLoc then
        ErrMsg('You can not key an exit that is not here.') Else
      If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
        Begin
          If KeyObj = 0 then
            Begin
              List[loc].keyOK := -1;
              c(3,1,0);
              Write(PM1);
              c(7,1,0);
              WriteLn(' is no longer keyed.');
            End
          Else If List[KeyObj].Name = '' then ErrMsg('You can not use an object that is not here.') Else
          If List[KeyObj].OType = 2 then
            Begin
              If (List[KeyObj].RLoc <> List[Ploc].RLoc) and (List[KeyObj].RLoc <> Ploc) then
                ErrMsg('You can not use an object that is not here.') Else
              If (List[KeyObj].Bto = Ploc) or (List[KeyObj].Cby = Ploc) or (List[Ploc].OType = 5) then
                Begin
                  List[loc].keyOK := KeyObj;
                  c(3,1,0);
                  Write(PM1);
                  c(7,1,0);
                  Write(' is now keyed to ');
                  c(14,2,0);
                  WriteLn(List[KeyObj].Name);
                  c(7,1,0);
                End
              Else ErrMsg('You can not use an object that you do not own.');
            End
          Else ErrMsg('You can only use OBJECTS as keys.');
        End
      Else ErrMsg('You can not key an exit that you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Light(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then loc := Find(Parm1,6);
      If loc = -1 then ErrMsg('You can not turn light what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not turn light what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
              List[loc].LtDk := FALSE;
              c(14,2,0);
              Write(List[loc].Name);
              c(7,1,0);
              WriteLn(' is now light.');
            End
           Else ErrMsg('You can not turn light what you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Dark(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then loc := Find(Parm1,6);
      If loc = -1 then ErrMsg('You can not turn dark what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not turn dark what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
              List[loc].LtDk := TRUE;
              c(14,2,0);
              Write(List[loc].Name);
              c(7,1,0);
              WriteLn(' is now dark.');
            End
           Else ErrMsg('You can not turn dark what you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Trade(Parm1:String20; var List:Group);
    Var
      lcv,loc,loc2: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      loc := Find(PM1,2);
      If loc = -1 then loc := Find(PM1,6);
      If loc = -1 then loc := Find(PM1,3);
      If loc = -1 then ErrMsg('You can not trade ownership for something that is not here.') Else
      If (List[loc].RLoc <> List[Ploc].RLoc) and (List[loc].RLoc <> Ploc) then
        ErrMsg('You can not trade ownership for something that is not here.')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
             Begin
               loc2 := Find(Parm2,5);
               If loc2 = -1 then loc2 := Find(Parm2,4);
               If loc2 = -1 then ErrMsg('You can not trade ownership for something to a non-existant person.') Else
                 Begin
                   List[loc].Bto := loc2;
                   WriteLn(List[loc].Name,' now belongs to ', List[loc2].Name);
                 End;
             End
           Else ErrMsg('You can not trade ownership for something that is not yours!');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure ObjNum(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then loc := Find(Parm1,6);
      If loc = -1 then ErrMsg('You can not look at an object that is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) then
        ErrMsg('You can not look at an object that is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
              WriteLn(List[loc].Name, '  #(', loc, ')');
            End
           Else ErrMsg('You can not look at an object that you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure KeyFail(Parm1:String20; var List:Group);
    Var
      KeyObj,lcv,loc,loc2: Integer;
      PM1,Parm2: String20;
    Begin
      lcv := 0;
      PM1 := '';
      Parm2 := '';
      Repeat
        inc(lcv,1);
        PM1 := PM1 + Parm1[lcv];
      Until (Parm1[lcv+1] = ' ') or (lcv = Length(Parm1));
      Delete(Parm1,1,Length(PM1)+1);
      Parm2 := Parm1;
      KeyObj := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          KeyObj := KeyObj + (Ord(Parm1[lcv]) - 48);
          KeyObj := KeyObj * 10;
        End;
      KeyObj := KeyObj DIV 10;
      loc := Find(PM1,6);
      If loc = -1 then ErrMsg('You can not key-fail an exit that is not here.') Else
      If List[loc].RLoc <> List[Ploc].RLoc then
        ErrMsg('You can not key-fail an exit that is not here.') Else
      If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
        Begin
          If KeyObj = 0 then
            Begin
              List[loc].keyFAIL := -1;
              c(3,1,0);
              Write(PM1);
              c(7,1,0);
              WriteLn(' is no longer key-failed.');
            End
          Else If List[KeyObj].Name = '' then ErrMsg('You can not key-fail to a room that does not exist.') Else
          If List[KeyObj].OType = 3 then
               Begin
                 If (List[KeyObj].Bto = Ploc) or (List[KeyObj].Cby = Ploc) or (List[Ploc].OType = 5) then
                   Begin
                     List[loc].keyFAIL := KeyObj;
                     c(3,1,0);
                     Write(PM1);
                     c(7,1,0);
                     Write(' is now key-failed to ');
                     c(2,1,0);
                     Write(List[KeyObj].Name);
                     c(7,1,0);
                     WriteLn('.');
                   End
                 Else ErrMsg('You can not key-fail to a room that you do not own.');
               End;
        End
      Else ErrMsg('You can not key-fail an exit that you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Info(Parm1:String20; var List:Group);
    Var
      loc: Integer;
    Begin
      loc := Find(Parm1,2);
      If loc = -1 then loc := Find(Parm1,6);
      If loc = -1 then loc := Find(Parm1,3);
      If loc = -1 then ErrMsg('You can not look at the info on what is not here') Else
      If (List[loc].RLoc <> Ploc) and (List[loc].RLoc <> List[Ploc].RLoc) and
         (List[Ploc].RLoc <> loc) then
        ErrMsg('You can not look at the info on what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
              WriteLn;
              c(15,2,0);
              Write('#');
              c(10,2,0);
              WriteLn(loc);
              c(7,1,0);
              Write('Name      : ');
              c(14,2,0);
              WriteLn(List[loc].Name);
              c(7,1,0);
              Write('Created by: ');
              c(13,2,0);
              WriteLn(List[List[loc].Cby].Name);
              c(7,1,0);
              Write('Belongs to: ');
              c(12,2,0);
              WriteLn(List[List[loc].Bto].Name);
              c(7,1,0);
              Write('Object is a ');
              Case List[loc].OType of
                  0: Begin
                       c(10,2,0);
                       WriteLn('Room');
                     End;
                  2: Begin
                       c(15,2,0);
                       WriteLn('Object');
                     End;
                  3: Begin
                       c(14,2,0);
                       WriteLn('Place');
                     End;
                  4: Begin
                       c(15,2,1);
                       Write('Person');
                       c(7,1,0);
                       WriteLn;
                     End;
                  5: Begin
                       c(12,2,0);
                       WriteLn('! WIZARD !');
                     End;
                  6: Begin
                       c(9,2,0);
                       WriteLn('Exit');
                     End;
              End;
              c(7,1,0);
              Write('This ');
              Case List[loc].OType of
                0..3: Begin
                        Write('object ');
                        If List[loc].Price < 1 then
                          WriteLn('has no price')
                        Else Begin
                               Write('is for sale at $');
                               c(10,2,0);
                               WriteLn(List[loc].Price);
                             End;
                      End;
                4..5: Begin
                        Write('person has $');
                        c(10,2,0);
                        WriteLn(List[loc].Price);
                      End;
               6..10: Begin
                        Write('object ');
                        If List[loc].Price < 1 then
                          WriteLn('has no price')
                        Else Begin
                               Write('is for sale at $');
                               c(10,2,0);
                               WriteLn(List[loc].Price);
                             End;
                      End;
              End;
              c(7,1,0);
              Write('Object is ');
              If List[loc].LtDk then
                Begin
                  c(8,2,0);
                  WriteLn('*DARK*');
                End
              Else Begin
                     c(15,2,0);
                     WriteLn('Light');
                   End;
              c(7,1,0);
              Write('Object is ');
              If List[loc].Magic then
                WriteLn('shareable')
              Else WriteLn('not shareable');
              WriteLn;
            End
           Else ErrMsg('You can not look at the info on what you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Help;
    Begin
      ansi('HELP.ANS',0);
      Write(' Press [ENTER] to continue. . .');
      ReadLn;
      GotoXY(1,WhereY-1);
      ansi('HELP2.ANS',0);
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Describe(Parm1:String20; var List:Group);
    Var
      loc: Integer;
      d: File of DesList;
    Begin
      Des.Des1 := '';
      Des.Des2 := '';
      Des.Des3 := '';
      Des.Des4 := '';
      loc := FindAll(Parm1);
      If loc = -1 then ErrMsg('You can not describe what is not here')
      Else If (List[loc].Bto = Ploc) or (List[loc].Cby = Ploc) or (List[Ploc].OType = 5) then
            Begin
              WriteLn;
              WriteLn;
              WriteLn('Begin Describing ',List[loc].Name,' you have 4 lines.  A blank line');
              WriteLn('will terminate your description.  *WARNING* your description');
              WriteLn('will not *wordwrap* at this time so hit return when you get');
              WriteLn('close to the right hand of the screen');
              WriteLn;
              Write('1:');
              ReadLn(Des.Des1);
              If Des.Des1 <> '' then
                Begin
                  Write('2:');
                  ReadLn(Des.Des2);
                  If Des.Des2 <> '' then
                    Begin
                      Write('3:');
                      ReadLn(Des.Des3);
                    End;
                      If Des.Des3 <> '' then
                        Begin
                          Write('4:');
                          ReadLn(Des.Des4);
                        End;
                End;
              Assign(d,'DESCRIPT.DAT');
              ReSet(d);
              Seek(d,loc);
              Write(d,Des);
              Close(d);
              WriteLn;
              c(2,1,0);
              WriteLn(List[loc].Name,' has now been described as such.');
              c(7,1,0);
            End
           Else ErrMsg('You can not describe what you do not own.');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Look(Parm1:String20; var List:Group);
    Var
      loc: Integer;
      d: File of DesList;
    Begin
      If Parm1 = '' then
        Begin
          Status(Ploc);
          Display(Ploc,List,num);
        End Else
      Begin
        loc := FindAll(Parm1);
        If loc = -1 then ErrMsg('You can not look at what is not here')
          Else Begin
                 Assign(d,'DESCRIPT.DAT');
                 Status(Ploc);
                 c(14,2,0);
                 WriteLn(List[loc].Name);
                 c(11,2,0);
                 Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
                 c(12,2,0);
                 Write('Description');
                 c(11,2,0);
                 Write('Í');
                 c(7,1,0);
                 ReSet(d);
                 Seek(d,loc);
                 Read(d,Des);
                 Close(d);
                 If Des.Des1 <> '' then WriteLn(Des.Des1);
                 If Des.Des2 <> '' then WriteLn(Des.Des2);
                 If Des.Des3 <> '' then WriteLn(Des.Des3);
                 If Des.Des4 <> '' then WriteLn(Des.Des4);
                 c(11,2,0);
                 Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
                 c(7,1,0);
                 WriteLn;
               End;
      End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure UpView(Parm1:String20; var List:Group);
    Var
      f: Text;
      a: File of AnsiList;
      fname: String[11];
      lcv: Integer;
      ch: Char;
    Begin
      WriteLn;
      WriteLn;
      WriteLn('The file you wish to upload must be in the current directory to work.');
      WriteLn;
      Write('Enter in the file name of your ANSI file: ');
      ReadLn(fname);
      Assign(f,fname);
      {$I-}
      ReSet(f);
      Close(f);
      {$I+}
      If IOResult = 0 then
        Begin
          WriteLn;
          c(15,2,0);
          Write('Checking for ANSI bombs: ');
          c(2,1,0);
          For lcv := 1 to 8 do
            Begin
              ReSet(f);
              Repeat
                Read(f,ch);
              Until EOF(f);
              Close(f);
            End;
          WriteLn('CLEAN');
          c(7,1,0);
          Ans.Name := fname;
          Assign(a,'ANSILIST.DAT');
          ReSet(a);
          Seek(a,List[Ploc].RLoc);
          Write(a,Ans);
          Close(a);
        End
      Else ErrMsg('This file does not exist!');
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure View(Parm1:String20; var List:Group);
    Var
      a: File of AnsiList;
    Begin
      Assign(a,'ANSILIST.DAT');
      ReSet(a);
      Seek(a,List[Ploc].RLoc);
      Read(a,Ans);
      Close(a);
      If Ans.Name <> '' then
        Begin
          ansi(Ans.Name,1);
          WriteLn;
        End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Send(Parm1:String20; var List:Group);
    Var
      loc,loc2: Integer;
      m: File of MesList;
    Begin
      Mes.FromUser := List[Ploc].Name;
      Mes.Line1 := '';
      Mes.Line2 := '';
      Mes.Line3 := '';
      Mes.Line4 := '';
      Mes.Line5 := '';
      Mes.Line6 := '';
      Mes.Line7 := '';
      Mes.Line8 := '';
      Mes.Seen := FALSE;
      loc := FindU(Parm1,5);
      If loc = -1 then loc := FindU(Parm1,4);
      If loc = -1 then ErrMsg('You can not send a message to a non-existant person.') Else
      Begin
      loc2 := EFindM;
      If loc2 = -1 then ErrMsg('Message data base to too large, please erase your old messages.')
      Else If List[Ploc].Price - 5 >= 0 then
            Begin
              Mes.ToUser := List[loc].Name;
              List[Ploc].Price := List[Ploc].Price - 5;
              WriteLn;
              WriteLn;
              WriteLn('Begin sending ',List[loc].Name,' a message, you have 8 lines.  A blank line');
              WriteLn('will terminate your description.  *WARNING* your description');
              WriteLn('will not *wordwrap* at this time so hit return when you get');
              WriteLn('close to the right hand of the screen');
              WriteLn;
              Write('1:');
              ReadLn(Mes.Line1);
              If Mes.Line1 <> '' then
                Begin
                  Write('2:');
                  ReadLn(Mes.Line2);
                End;
              If Mes.Line2 <> '' then
                Begin
                  Write('3:');
                  ReadLn(Mes.Line3);
                End;
              If Mes.Line3 <> '' then
                Begin
                  Write('4:');
                  ReadLn(Mes.Line4);
                End;
              If Mes.Line4 <> '' then
                Begin
                  Write('5:');
                  ReadLn(Mes.Line5);
                End;
              If Mes.Line5 <> '' then
                Begin
                  Write('6:');
                  ReadLn(Mes.Line6);
                End;
              If Mes.Line6 <> '' then
                Begin
                  Write('7:');
                  ReadLn(Mes.Line7);
                End;
              If Mes.Line7 <> '' then
                Begin
                  Write('8:');
                  ReadLn(Mes.Line8);
                End;
              Assign(m,'MESSAGE.DAT');
              ReSet(m);
              Seek(m,loc2);
              Write(m,Mes);
              Close(m);
              WriteLn;
              c(2,1,0);
              WriteLn('You message has been sent to ',List[loc].Name);
              c(7,1,0);
            End
           Else ErrMsg('You do not have enough credits.');
      End;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Mail(Parm1:String20; var List:Group);
    Var
      loc,cntr: Integer;
      m: File of MesList;
      found: Boolean;
      ans: Char;
      NewMess, OldMess: Integer;
    Begin
      cntr := 0;
      NewMess := 0;
      OldMess := 0;
      Assign(m,'MESSAGE.DAT');
      Repeat
      ReSet(m);
      Repeat
        found := FALSE;
        inc(cntr,1);
        Seek(m,cntr);
        Read(m,Mes);
        If Parm1 = 'NEW' then
          Begin
            If (Mes.ToUser = List[Ploc].Name) and (NOT Mes.Seen) then found := TRUE
          End
        Else If (Mes.ToUser = List[Ploc].Name){ and (NOT Mes.Seen)} then found := TRUE;
        If found then
          Begin
            If Mes.Seen then inc(OldMess, 1)
              Else inc(NewMess, 1);
          End;
        If Parm1 = 'NUMBER' then found := FALSE;
      Until (found) or (cntr = MAX);
      Close(m);
      If found then
        Begin
          ClrScr;
          If NOT Mes.Seen then
            Begin
              c(10,2,0);
              WriteLn('NEW MESSAGE');
              c(15,2,0);
            End;
          Mes.Seen := TRUE;
          ReSet(m);
          Seek(m,cntr);
          Write(m,Mes);
          Close(m);
          c(15,2,0);
          Write('To  : ');
          c(14,2,0);
          WriteLn(Mes.ToUser);
          c(15,2,0);
          Write('From: ');
          c(13,2,0);
          WriteLn(Mes.FromUser);
          c(7,1,0);
          WriteLn(Mes.Line1);
          If Mes.Line2 <> '' then WriteLn(Mes.Line2);
          If Mes.Line3 <> '' then WriteLn(Mes.Line3);
          If Mes.Line4 <> '' then WriteLn(Mes.Line4);
          If Mes.Line5 <> '' then WriteLn(Mes.Line5);
          If Mes.Line6 <> '' then WriteLn(Mes.Line6);
          If Mes.Line7 <> '' then WriteLn(Mes.Line7);
          If Mes.Line8 <> '' then WriteLn(Mes.Line8);
          WriteLn;
          WriteLn;
          Write('Options: <R>eply, <D>elete, or <N>ext to save & continue  ');
          ReadLn(ans);
          WriteLn;
          ans := UpCase(ans);
          Case ans of
            'R': Begin
                   Send(Mes.FromUser,List);
                 End;
            'D': Begin
                   ReSet(m);
                   Mes.ToUser := '';
                   Seek(m,cntr);
                   Write(m,Mes);
                   Close(m);
                 End;
          End;
        End
      Else Begin
             If Parm1 = 'NUMBER' then
               Begin
                 WriteLn('You have ', NewMess, ' new messages & ', OldMess, ' old messages.');
               End
             Else If (Parm1 = 'NEW') AND (NewMess = 0) then ErrMsg('No new mail for you today!')
                    Else If (NewMess = 0) AND (OldMess = 0) then ErrMsg('No mail is in your mail box!');
           End;
      Until cntr = MAX;
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Rate(Parm1:String20; var List:Group);
    Var
      Cash,lcv: Integer;
    Begin
      Cash := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          Cash := Cash + (Ord(Parm1[lcv]) - 48);
          Cash := Cash * 10;
        End;
      Cash := Cash DIV 10;
      If (Cash > 32767) or (Cash < 0) then List[0].goOK := 0
        Else List[0].goOK := Cash;
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
      WriteLn('Users now gain 1 credit for every ',Cash,' truns.');
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
    End;
{/////////////////////////////////////////////////////////////////}
  Procedure Default(Parm1:String20; var List:Group);
    Var
      Cash,lcv: Integer;
    Begin
      Cash := 0;
      For lcv := 1 to Length(Parm1) do
        Begin
          Cash := Cash + (Ord(Parm1[lcv]) - 48);
          Cash := Cash * 10;
        End;
      Cash := Cash DIV 10;
      If (Cash > 32767) or (Cash < 0) then List[0].Price := 0
        Else List[0].Price := Cash;
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
      WriteLn('Users now start out with ',Cash,' credits.');
      c(11,2,0);
      WriteLn('ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ');
      c(7,1,0);
    End;
{/////////////////////////////////////////////////////////////////}
  Begin           (*CommandCode*)
    lcv := 0;
    Cmand := '';
    Parm1 := '';
    Repeat
      inc(lcv,1);
      Cmand := Cmand + command[lcv];
    Until (command[lcv+1] = ' ') or (lcv = Length(command));
    Delete(command,1,Length(Cmand)+1);
    Parm1 := command;
    accepted := TRUE;
    If (Cmand = '/DIG') and (Parm1 <> '') then
      Begin
        If List[Ploc].Price - 60 < 0 then
          ErrMsg('You do not have enough credits to /DIG')
        Else Begin
               Dig(Parm1,List);
               List[Ploc].Price := List[Ploc].Price - 60;
             End;
      End Else
    If (Cmand = '/CREATE') and (Parm1 <> '') then
      Begin
        If List[Ploc].Price - 30 < 0 then
          ErrMsg('You do not have enough credits to /CREATE')
        Else Begin
               Create(Parm1, List);
               List[Ploc].Price := List[Ploc].Price - 30;
             End;
      End Else
    If (Cmand = '/INV') then
      Begin
        Status(Ploc);
        PersonalDisplay(Ploc,List);
      End Else
    If (Cmand = '/TAKE') then Take(Parm1,List) Else
    If (Cmand = '/DROP') then Drop(Parm1,List) Else
    If (Cmand = '/KILL') then Kill(Parm1,List) Else
    If (Cmand = '/KILLR') and (List[Ploc].OType = 5) then KillR(Parm1,List) Else
    If (Cmand = '/KILLU') and (List[Ploc].OType = 5) then KillU(Parm1,List) Else
    If (Cmand = '/HOME') and (List[Ploc].OType = 5) then Home(List) Else
    If (Cmand = '/RENAME') then ReName(Parm1,List) Else
    If (Cmand = '/WIZARD') then Wizard(List) Else
    If (Cmand = '/PASSWORD') and (List[Ploc].OType = 5) then Password(List) Else
    If (Cmand = '/GENERATE') and (Parm1 <> '') and (List[Ploc].OType = 5) then Generate(Parm1,List) Else
    If (Cmand = '/GIVE') and (Parm1 <> '') and (List[Ploc].OType = 5) then Give(Parm1,List) Else
    If (Cmand = '/EXIT') and (Parm1 <> '') then Exit(Parm1,List) Else
    If (Cmand = '/COST') then Cost(Parm1,List) Else
    If (Cmand = '/PRICE') then Price(Parm1,List) Else
    If (Cmand = '/BUY') then Buy(Parm1,List) Else
    If (Cmand = '/SHARE') then Share(Parm1,List) Else
    If (Cmand = '/KEY') then Key(Parm1,List) Else
    If (Cmand = '/LIGHT') then Light(Parm1,List) Else
    If (Cmand = '/DARK') then Dark(Parm1,List) Else
    If (Cmand = '/TRADE') then Trade(Parm1,List) Else
    If (Cmand = '/OBJNUM') then ObjNum(Parm1,List) Else
    If (Cmand = '/KEY-FAIL') then KeyFail(Parm1,List) Else
    If (Cmand = '/INFO') then Info(Parm1,List) Else
    If (Cmand = '/?') then Help Else
    If (Cmand = '/DESCRIBE') then Describe(Parm1,List) Else
    If (Cmand = '/LOOK') then Look(Parm1,List) Else
    If (Cmand = '/UPVIEW') then UpView(Parm1,List) Else
    If (Cmand = '/VIEW') then View(Parm1,List) Else
    If (Cmand = '/SEND') and (Parm1 <> '') then Send(Parm1,List) Else
    If (Cmand = '/MAIL') then Mail(Parm1,List) Else
    If (Cmand = '/RATE') and (List[Ploc].OType = 5) then Rate(Parm1,List) Else
    If (Cmand = '/DEFAULT') and (List[Ploc].OType = 5) then Default(Parm1,List) Else
      accepted := FALSE;
  End;
{/////////////////////////////////////////////////////////////////////////}
Begin
  ansi('CYBER2.ANS',0);
  num := 0;
  command := '';
  Rate := 0;
  LoadObjects(List,num);
  SignOn(List,num,Ploc);
  Status(Ploc);
  Display(Ploc,List,num);
  CommandCode('/MAIL NUMBER',Ploc,List,accepted);
  Repeat
    If command = 'LOOK' then
      Begin
        Status(Ploc);
        Display(Ploc,List,num);
      End;
    accepted := FALSE;
    WriteLn;
    Repeat
      accepted := FALSE;
      c(10,2,0);
      Write('> ');
      c(7,1,0);
      ReadLn(command);
      UpStr(command);
      If command = '' then accepted := FALSE;
      If (command[1] = 'L') and (command[2] = 'O') and
         (command[3] = 'O') and (command[4] = 'K') then Insert('/',command,1);
      If command[1] = '/' then CommandCode(command,Ploc,List,accepted)
        Else RMove(command,Ploc,List,accepted);
      If command = '/QUIT' then accepted := TRUE;
      If NOT accepted then
        Begin
          c(15,2,0);
          WriteLn('Invalid command');
          c(7,1,0);
          Write('Type ');
          c(10,2,0);
          Write('/?');
          c(7,1,0);
          Write(' or read ');
          c(3,2,0);
          Write('handbook.doc');
          c(7,1,0);
          WriteLn(' for help.');
        End
      Else RateChk(Rate,List);
    Until {accepted} (command = 'LOOK') or (command = '/QUIT');
  Until command = '/QUIT';
  c(11,2,0);
  Write('ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ');
  c(12,2,0);
  Write('Terminate');
  c(11,2,0);
  Write('Í');
  c(7,1,0);
  If List[Ploc].OType = 5 then
    Begin
      Write('Do you wish to remain visible, so other players can see you? ');
      Repeat
        sel := ReadKey;
      Until sel <> '';
      sel := UpCase(sel);
      If sel = 'N' then List[Ploc].LtDk := TRUE;
    End;
  SaveObjects(List,num);
End.