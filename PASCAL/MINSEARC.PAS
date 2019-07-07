Program Mineral;

USES
     DOS,CRT,MENU,ANSWERS;

CONST
     recmax = 110;  (*recmax = 110*)
     STR = 26;

TYPE
     CardStats = Record
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
     MenuString = String[29];                  {maximum length of menu text}
     StringValue = String[STR];
     Group = Array[1..recmax] of CardStats;
VAR
     List: Group;
     cntr,
     max: Integer;
{////////////////////////////////////////////////////////////////}
  Function BinFind(var List:Group; name:Stringvalue ;cntr:Integer):Integer;
       Var                          {searches for name and returnes location}
            min, mid, first, last: Integer;
            found: Boolean;
{/////////////////////////////////////}
  Procedure Sort(var List: Group; var First, Last: Integer);
     Var                                {Sorts the words and replaces them in}
          Left,                         {the array}
          Right  : Integer;
          Fence  : StringValue;
          temp   : CardStats;
     Begin
          {ClrScr;}
          Fence := List[(First + Last) div 2].name;
          Left := First;
          Right := Last;
          Repeat
               While List[Left].name < Fence do
                    Left := Succ(Left);
               While List[Right].name > Fence do
                    Right := Pred(Right);
               If Left <= Right then
                    Begin
                         Temp := List[Right];
                         List[Right] := List[Left];
                         List[Left] := temp;
                         Left := Succ(Left);
                         Right := Pred(Right);
                    End; {IF}
          Until Left > Right;
          If First < Right then Sort(List, First, Right);
          If Left < Last then Sort(List, Left, Last);
     End;
{/////////////////////////////////////}
       Begin
            min := 1;
            Sort(List, min, cntr);
            mid := 0;
            first := 1;
            last := cntr;
            found := FALSE;
            While (not found) and (first <= last) do
                 Begin
                      mid := (first + last) div 2;
                      If List[mid].name = name
                           then found := TRUE
                      Else If name < List[mid].name
                                then Last := mid - 1
                           Else first := mid + 1;
                 End; {while}
            If found = TRUE then BinFind := mid
                 Else BinFind := 0
       End;
{////////////////////////////////////////////////////////////////}
    Procedure Load(var List:Group; DataFile:ST20; var cntr:Integer);
         Var                        {loads the names from a file}
              lcv: Integer;
              F  : File of CardStats;
              ans: ST1;
         Begin
              If DataFile <> '' then
              Begin
              Assign(F, DataFile);
              {$I-}
              ReSet(F);
              Close(F);
              {$I+}
              If IOResult = 0 then
                   Begin
                        ReSet(F);
                        {ReadLn(F, cntr);}
                        cntr := 0;
                        {InitArray(List);}
                        While not EOF(F) do
                             Begin
                                  c(15,2,4);
                                  GotoXY(15,24);
                                  {Write(cntr);}
                                  c(7,2,1);
                                  inc(cntr, 1);
                                  Read(F, List[cntr]);
                             End;
                        Close(F);
                   End
              Else Begin
                        Box(30,11,20,'Data Base not found!!','O');
                        GotoXY(1,1);
                        Sound(950);
                        Delay(500);
                        NoSound;
                        Delay(1500);
                        Halt;
                        DataFile := 'MINERALS.DAT';
                   End;
              End;
         End;
{////////////////////////////////////////////////////////////////}
    Procedure MenH(X, Y, long:Integer; texts:MenuString);
         Var               {creates headers for menus}
              lcv: Integer;             {loop control variable}
{////////////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Begin                      {Creates menu header}
              GotoXY(X, Y);
              c(14,2,1);
              Write('É');                    {<==|}
              For lcv := 1 to long + 7 do    {<==|}
                Write('Í');                  {<==|}
              WriteLn('»');                  {<==|----writes upper boarder}
              GotoXY(X, Y + 1);              {        of the menu header  }
              c(14,2,1);
              Write('º ');                   {<==----left wall}
              c(7,2,1);
              spa(long + 5);
              c(14,2,1);
              Write(' º');                   {<==----right wall}
              GotoXY(X + 1, Y + 1);
              GotoXY(((long + 9) div 2) - (Length(texts) div 2) + X, Y + 1);
              c(7,2,1);                      {^==----centers text}
              Write(texts);                  {<==----prints centered text}
              GotoXY(X, Y + 2);
              c(14, 2, 1);
              Write('Ì');                    {<==----left merge character}
              For lcv := 1 to long + 7 do    {<==|}
                   Write('Í');               {<==|----writes lower boarder}
              WriteLn('¹');                  {<==----right merge character}
              GotoXY(1,1);
              c(7,1,0);
         End;
{////////////////////////////////////////////////////////////////}
Procedure BoxWipe(X, Y, X2, Y2: Integer);
  Var
    lcv, lcv2: Integer;                      {loop control variables}
  Begin
    c(3,2,1);
    For lcv := Y to Y2 do                    {clears box along the 'Y' axis}
      Begin
        For lcv2 := X to X2 do               {clears box along the 'X' axis}
          Begin
            GotoXY(lcv2, lcv);
            Write('°');                      {actually clears here}
          End;
      End;
    c(7,1,0);                                {reset text color}
  End;
{////////////////////////////////////////////////////////////////}
Procedure Search(var List:Group; num:Integer);
  Type
    TmpCardStats = Record
                     Name: ST20;
                     loc: Integer;
                   End;
    NameList = Array[1..110] of TmpCardStats;
  Var
    Names: NameList;
    MenuSel: Array[1..9] of String[18];
    cntr,lcv: Integer;
    Csel: Char;
    sel: Integer;
    ListActive: Boolean;
{////////////////////////////////////////////////////////}
  Procedure MenuSelDisp(cntr:Integer);
    Var
      lcv: Integer;
    Begin
      GotoXY(5,cntr+5);
      Write(MenuSel[cntr]);
      For lcv := 1 to 19 - Length(MenuSel[cntr]) do
        Write(' ');
      GotoXY(1,1);
    End;
{////////////////////////////////////////////////////////}
  Function StrChk(name:ST11): Boolean;
    Var
      lcv: Integer;
      TmpSC: Boolean;
    Begin
      TmpSC := TRUE;
      For lcv := 1 to Length(name) do
        Begin
          If ((Ord(name[lcv]) < 48) or (Ord(name[lcv]) > 57)) and
             ((Ord(name[lcv]) < 45) or (Ord(name[lcv]) > 46)) then
            TmpSC := FALSE;
        End;
      StrChk := TmpSC;
    End;
{////////////////////////////////////////////////////////}
  Procedure NameComp(var Names:NameList; var num:Integer);
    Var
      cntr, lcv: Integer;
      TmpNames:NameList;
    Begin
      cntr:= 0;
      For lcv := 1 to 110 do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          If Names[lcv].Name <> '' then
            Begin
              inc(cntr,1);
              TmpNames[cntr] := Names[lcv];
            End;
        End;
      Names := TmpNames;
      num := cntr;
    End;
{////////////////////////////////////////////////////////}
  Procedure NameDisp(var Names:NameList; num:Integer);
    Var
      lcv,cntr,blankcntr: Integer;
      Csel: Char;
      sel: Integer;
    Begin
      Box(28,3,22,'','B');
      Box(28,4,22,'','C');
      Box(28,5,22,'','C');
      Box(28,6,22,'','C');
      Box(28,7,22,'','C');
      Box(28,8,22,'','C');
      Box(28,9,22,'','C');
      Box(28,10,22,'','C');
      Box(28,11,22,'','E');
      GotoXY(33,3);
      c(8,1,3);
      Write('MINERAL  MATCHES');
      GotoXY(1,24);
      c(15,2,4);
      Write('                                                                                ');
      GotoXY(1,24);
      Write('Press ESC to return to the search menu. . .');
      c(14,2,1);
      GotoXY(1,1);
      blankcntr := 0;
      Repeat
        Window(30,4,51,13);
        c(15,2,1);
        Repeat
          inc(blankcntr,1);
          If Names[blankcntr].Name <> '' then
            Begin
              Write(Names[blankcntr].Name);
              For lcv := 1 to 21 - Length(Names[blankcntr].Name) do
                Write(' ');
              WriteLn;
            End;
        Until (WhereY = 10) or (blankcntr = num);
        Window(1,1,80,25);
        GotoXY(50,3);
        c(14,2,1);
        Write('[ ]');
        c(10,2,1);
        GotoXY(51,WhereY);
        If blankcntr - 9 <= 0 then Write(Chr(025))
          Else If blankcntr = num then Write(Chr(024))
                 Else Write(Chr(023));
        GotoXY(WhereX-1,WhereY);
        If num < 10 then Write(Chr(254));
        c(15,2,1);
        GotoXY(1,1);
        Repeat
          Repeat
            Csel := ReadKey;
          Until Csel <> '';
          sel := Ord(Csel);
          Case sel of
            072: Begin
                   If blankcntr > 9 then
                     Begin
                       dec(blankcntr,1);
                       blankcntr := blankcntr - 9;
                     End
                   Else blankcntr := 0;
                 End;
            080: Begin
                   If blankcntr < num then
                     Begin
                       inc(blankcntr,1);
                       blankcntr := blankcntr - 9;
                     End
                   Else blankcntr := num - 9;
                   If blankcntr < 0 then blankcntr := 0;
                 End;
          End;
        Until (sel = 072) or (sel = 080) or (sel = 027);
      Until sel = 027;
      BoxWipe(28,3,53,14);
      GotoXY(1,24);
      c(15,2,4);
      Write('                                                                                ');
      GotoXY(1,24);
      Write('Press ESC to return to the main menu. . .');
      c(14,2,1);
      GotoXY(1,1);
      ListActive := FALSE;
    End;
{////////////////////////////////////////////////////////}
  Procedure Hardness(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Hardness: ST11;
      lcv: Integer;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      Repeat
        Box(23,11,34,'Enter in the hardness:  ','O');
        GotoXY(48,12);
        c(15,2,1);
        answer11(Hardness, WhereX, WhereY);
        If NOT StrChk(Hardness) then
          Begin
            Box(33,11,15,'INVALID ENTRY!!','O');
            GotoXY(1,1);
            Sound(950);
            Delay(200);
            NoSound;
            Delay(1800);
          End;
      Until StrChk(Hardness);
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        If List[TmpNames[lcv].loc].Hard = Hardness then
          Begin
            ListActive := TRUE;
          End
        Else TmpNames[lcv].Name := '';
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
     End;
{////////////////////////////////////////////////////////}
  Procedure Lust(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Luster: Array[1..20] of Boolean;
      lcv,lcv2,loc: Integer;
      sel: Char;
      good: Boolean;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      For lcv := 1 to 20 do
        Luster[lcv] := FALSE;
      Box(9,2,62,'   Metallic                   Waxy','B');
      Box(9,3,62,'','C');
      Box(9,4,62,'   Sub-Metallic               Silky','C');
      Box(9,5,62,'','C');
      Box(9,6,62,'   Dull                       Translucent','C');
      Box(9,7,62,'','C');
      Box(9,8,62,'   Earthy                     Transparent','C');
      Box(9,9,62,'','C');
      Box(9,10,62,'   Greasy                     Dull Earthy','C');
      Box(9,11,62,'','C');
      Box(9,12,62,'   Pearly                     Adamantine','C');
      Box(9,13,62,'','C');
      Box(9,14,62,'   Resinons Pearly            Earthy Vitreous','C');
      Box(9,15,62,'','C');
      Box(9,16,62,'   Resinons                   Resinons Sub-Metallic','C');
      Box(9,17,62,'','C');
      Box(9,18,62,'   Vitreous                   Vitreous Silky','C');
      Box(9,19,62,'','C');
      Box(9,20,62,'   Vitreous nearly pearly     Gray, brown, yellow, white hues','E');
      c(8,1,3);
      GotoXY(37,2);
      Write('LUSTER');
      c(10,2,8);
      For lcv := 3 to 22 do
        Begin
          GotoXY(11,lcv);
          Case WhereY of
            3: loc := 1;
            5: loc := 2;
            7: loc := 3;
            9: loc := 4;
           11: loc := 5;
           13: loc := 6;
           15: loc := 7;
           17: loc := 8;
           19: loc := 9;
           21: loc := 10;
          End;
          If Luster[loc] = TRUE then
            Write('û')
          Else Write(' ');
          inc(lcv,1);
        End;
      For lcv := 3 to 22 do
        Begin
          GotoXY(38,lcv);
          Case WhereY of
            3: loc := 1;
            5: loc := 2;
            7: loc := 3;
            9: loc := 4;
           11: loc := 5;
           13: loc := 6;
           15: loc := 7;
           17: loc := 8;
           19: loc := 9;
           21: loc := 10;
          End;
          Case WhereX of
           38: inc(loc,10);
          End;
          If Luster[loc] = TRUE then
            Write('û')
          Else Write(' ');
          inc(lcv,1);
        End;
      GotoXY(11,3);
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        If sel = #075 then
          Begin
            If WhereX - 27 < 11 then GotoXY(WhereX,WhereY)
              Else GotoXY(WhereX - 27,WhereY);
          End;
        If sel = #077 then
          Begin
            If WhereX + 27 > 38 then GotoXY(WhereX,WhereY)
              Else GotoXY(WhereX + 27,WhereY);
          End;
        If sel = #080 then
          Begin
            If WhereY + 2 > 21 then GotoXY(WhereX,WhereY)
              Else GotoXY(WhereX,WhereY + 2);
          End;
        If sel = #072 then
          Begin
            If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
              Else GotoXY(WhereX,WhereY - 2);
          End;
        If sel = #32 then
          Begin
            Case WhereY of
              3: loc := 1;
              5: loc := 2;
              7: loc := 3;
              9: loc := 4;
             11: loc := 5;
             13: loc := 6;
             15: loc := 7;
             17: loc := 8;
             19: loc := 9;
             21: loc := 10;
            End;
            Case WhereX of
             38: inc(loc,10);
            End;
            If Luster[loc] = TRUE then
              Begin
                Write(' ');
                GotoXY(WhereX - 1,WhereY);
                Luster[loc] := FALSE;
              End
            Else Begin
                   Write('û');
                   GotoXY(WhereX - 1, WhereY);
                   Luster[loc] := TRUE;
                 End;
          End;
      Until sel = #13;
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        Begin
          good := TRUE;
          For lcv2 := 1 to 20 do
            If List[TmpNames[lcv].loc].Luster[lcv2] <> Luster[lcv2] then
              good := FALSE;
          If NOT good then TmpNames[lcv].Name := ''
            Else ListActive := TRUE;
        End;
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
    End;
{////////////////////////////////////////////////////////}
  Procedure Colors(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Color: Array[1..43] of Boolean;
      lcv,lcv2,loc: Integer;
      sel: Char;
      good: Boolean;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      For lcv := 1 to 43 do
        Color[lcv] := FALSE;
                                Box(9,2,62,'   Black             Bronze              Pale Brass','B');
                                Box(9,3,62,'','C');
                                Box(9,4,62,'   Gray              Yellow              Bright Yellow','C');
                                Box(9,5,62,'','C');
                                Box(9,6,62,'   Earthy            Brass-Yellow        White','C');
                                Box(9,7,62,'','C');
                                Box(9,8,62,'   Reddish Brown     Pale Copper-Red     Green','C');
                                Box(9,9,62,'','C');
                                Box(9,10,62,'   Blue-Black        Black Tarnish       Orange','C');
                                Box(9,11,62,'','C');
                                Box(9,12,62,'   Lead-Gray         Dark Gray           Buff','C');
                                Box(9,13,62,'','C');
                                Box(9,14,62,'   Steel Gray        Silver-White        Colorless','C');
                                Box(9,15,62,'','C');
                                Box(9,16,62,'   Gold-Yellow       Iron-Black          Pink','C');
                                Box(9,17,62,'','C');
                                Box(9,18,62,'   Copper-Red        Brown               Dark Green','C');
                                Box(9,19,62,'','C');
                                Box(9,20,62,'   Tarnishes         Dark Brown          Smoky','E');
                                c(8,1,3);
                                GotoXY(33,2);
                                Write('COLOR:  1 of 2');
                                c(10,2,8);
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(11,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(29,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(49,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                GotoXY(11,3);
                                Repeat
                                  Repeat
                                    sel := ReadKey;
                                  Until sel <> '';
                                  If sel = #075 then
                                    Begin
                                      If WhereX = 29 then
                                        If WhereX - 18 < 11 then GotoXY(WhereX,WhereY)
                                          Else GotoXY(WhereX - 18,WhereY)
                                            Else If WhereX = 49 then
                                                   If WhereX - 20 > 49 then GotoXY(WhereX,WhereY)
                                                     Else GotoXY(WhereX - 20,WhereY);
                                    End;
                                  If sel = #077 then
                                    Begin
                                      If WhereX = 11 then
                                        If WhereX + 18 > 49 then GotoXY(WhereX,WhereY)
                                          Else GotoXY(WhereX + 18,WhereY)
                                            Else If WhereX = 29 then
                                                   If WhereX + 20 > 49 then GotoXY(WhereX,WhereY)
                                                     Else GotoXY(WhereX + 20,WhereY);
                                    End;
                                  If sel = #080 then
                                    Begin
                                      If WhereY + 2 > 21 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY + 2);
                                    End;
                                  If sel = #072 then
                                    Begin
                                      If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY - 2);
                                    End;
                                  If sel = #32 then
                                    Begin
                                      Case WhereY of
                                        3: loc := 1;
                                        5: loc := 2;
                                        7: loc := 3;
                                        9: loc := 4;
                                        11: loc := 5;
                                        13: loc := 6;
                                        15: loc := 7;
                                        17: loc := 8;
                                        19: loc := 9;
                                        21: loc := 10;
                                      End;
                                      Case WhereX of
                                        29: inc(loc,10);
                                        49: inc(loc,20);
                                      End;
                                      If Color[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          Color[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             Color[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
                                Box(9,2,62,'   Violet                     Olive Green','B');
                                Box(9,3,62,'','C');
                                Box(9,4,62,'   Deep Red                   Fed','C');
                                Box(9,5,62,'','C');
                                Box(9,6,62,'   Intense Azure              Clear Brown','C');
                                Box(9,7,62,'','C');
                                Box(9,8,62,'   Bright Green','C');
                                Box(9,9,62,'','C');
                                Box(9,10,62,'   Rose Red','C');
                                Box(9,11,62,'','C');
                                Box(9,12,62,'   Light-Green','C');
                                Box(9,13,62,'','C');
                                Box(9,14,62,'   Light Yellow','C');
                                Box(9,15,62,'','C');
                                Box(9,16,62,'   Gray-Blue','C');
                                Box(9,17,62,'','C');
                                Box(9,18,62,'   Flesh-Colored','C');
                                Box(9,19,62,'','C');
                                Box(9,20,62,'   Blackish Green','E');
                                c(8,1,3);
                                GotoXY(33,2);
                                Write('COLOR:  2 of 2');
                                c(10,2,8);
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(11,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                For lcv := 3 to 8 do
                                  Begin
                                    GotoXY(38,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                GotoXY(11,3);
                                Repeat
                                  Repeat
                                    sel := ReadKey;
                                  Until sel <> '';
                                  If sel = #075 then
                                    Begin
                                      If WhereX - 27 < 11 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX - 27,WhereY);
                                    End;
                                  If sel = #077 then
                                    Begin
                                      If WhereX + 27 > 38 then GotoXY(WhereX,WhereY)
                                        Else If WhereY > 7 then GotoXY(WhereX + 27,7)
                                             Else GotoXY(WhereX + 27,WhereY);
                                    End;
                                  If sel = #080 then
                                    Begin
                                      If WhereX = 38 then
                                        If WhereY + 2 > 7 then GotoXY(WhereX,WhereY)
                                          Else GotoXY(WhereX,WhereY + 2)
                                            Else If WhereY + 2 > 21 then GotoXY(WhereX,WhereY)
                                                   Else GotoXY(WhereX,WhereY + 2);
                                    End;
                                  If sel = #072 then
                                    Begin
                                      If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY - 2);
                                    End;
                                  If sel = #32 then
                                    Begin
                                      Case WhereY of
                                        3: loc := 31;
                                        5: loc := 32;
                                        7: loc := 33;
                                        9: loc := 34;
                                        11: loc := 35;
                                        13: loc := 36;
                                        15: loc := 37;
                                        17: loc := 38;
                                        19: loc := 39;
                                        21: loc := 40;
                                      End;
                                      Case WhereX of
                                        38: inc(loc,10);
                                      End;
                                      If Color[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          Color[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             Color[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        Begin
          good := TRUE;
          For lcv2 := 1 to 43 do
            If List[TmpNames[lcv].loc].Color[lcv2] <> Color[lcv2] then
              good := FALSE;
          If NOT good then TmpNames[lcv].Name := ''
            Else ListActive := TRUE;
        End;
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
    End;
{////////////////////////////////////////////////////////}
  Procedure Stre(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Streak: Array[1..29] of Boolean;
      lcv,lcv2,loc: Integer;
      sel: Char;
      good: Boolean;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      For lcv := 1 to 29 do
        Streak[lcv] := FALSE;
                                Box(9,2,62,'   Black                      Dark Blue','B');
                                Box(9,3,62,'','C');
                                Box(9,4,62,'   Yellow-Dark Brown          Purple','C');
                                Box(9,5,62,'','C');
                                Box(9,6,62,'   Brown                      Grayish Black','C');
                                Box(9,7,62,'','C');
                                Box(9,8,62,'   Light Indian Red           Brownish-Black','C');
                                Box(9,9,62,'','C');
                                Box(9,10,62,'   Dark Indian Red            Brown-Red','C');
                                Box(9,11,62,'','C');
                                Box(9,12,62,'   Lead Gray                  Yellow-Black','C');
                                Box(9,13,62,'','C');
                                Box(9,14,62,'   Dark Gray                  Greenish','C');
                                Box(9,15,62,'','C');
                                Box(9,16,62,'   Gold-Yellow                Pale Yellow','C');
                                Box(9,17,62,'','C');
                                Box(9,18,62,'   Copper Red                 White','C');
                                Box(9,19,62,'','C');
                                Box(9,20,62,'   Tarnished                  Yellowish','E');
                                c(8,1,3);
                                GotoXY(33,2);
                                Write('STREAK: 1 of 2');
                                c(10,2,8);
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(11,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(38,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                GotoXY(11,3);
                                Repeat
                                  Repeat
                                    sel := ReadKey;
                                  Until sel <> '';
                                  If sel = #075 then
                                    Begin
                                      If WhereX - 27 < 11 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX - 27,WhereY);
                                    End;
                                  If sel = #077 then
                                    Begin
                                      If WhereX + 27 > 38 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX + 27,WhereY);
                                    End;
                                  If sel = #080 then
                                    Begin
                                      If WhereY + 2 > 21 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY + 2);
                                    End;
                                  If sel = #072 then
                                    Begin
                                      If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY - 2);
                                    End;
                                  If sel = #32 then
                                    Begin
                                      Case WhereY of
                                        3: loc := 1;
                                        5: loc := 2;
                                        7: loc := 3;
                                        9: loc := 4;
                                        11: loc := 5;
                                        13: loc := 6;
                                        15: loc := 7;
                                        17: loc := 8;
                                        19: loc := 9;
                                        21: loc := 10;
                                      End;
                                      Case WhereX of
                                        38: inc(loc,10);
                                      End;
                                      If Streak[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          Streak[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             Streak[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
                                Box(9,2,62,'   Red','B');
                                Box(9,3,62,'','C');
                                Box(9,4,62,'   Orange','C');
                                Box(9,5,62,'','C');
                                Box(9,6,62,'   Greenish White','C');
                                Box(9,7,62,'','C');
                                Box(9,8,62,'   Red Brown','C');
                                Box(9,9,62,'','C');
                                Box(9,10,62,'   Bluish White','C');
                                Box(9,11,62,'','C');
                                Box(9,12,62,'   Colorless','C');
                                Box(9,13,62,'','C');
                                Box(9,14,62,'   Orange-Yellow','C');
                                Box(9,15,62,'','C');
                                Box(9,16,62,'   Greenish-Gray','C');
                                Box(9,17,62,'','C');
                                Box(9,18,62,'   Pale Brown','C');
                                Box(9,19,62,'','C');
                                Box(9,20,62,'','E');
                                c(8,1,3);
                                GotoXY(33,2);
                                Write('STREAK: 2 of 2');
                                c(10,2,8);
                                For lcv := 3 to 20 do
                                  Begin
                                    GotoXY(11,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                GotoXY(11,3);
                                Repeat
                                  Repeat
                                    sel := ReadKey;
                                  Until sel <> '';
                                  If sel = #080 then
                                    Begin
                                      If WhereY + 2 > 19 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY + 2);
                                    End;
                                  If sel = #072 then
                                    Begin
                                      If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY - 2);
                                    End;
                                  If sel = #32 then
                                    Begin
                                      Case WhereY of
                                        3: loc := 21;
                                        5: loc := 22;
                                        7: loc := 23;
                                        9: loc := 24;
                                        11: loc := 25;
                                        13: loc := 26;
                                        15: loc := 27;
                                        17: loc := 28;
                                        19: loc := 29;
                                      End;
                                      If Streak[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          Streak[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             Streak[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        Begin
          good := TRUE;
          For lcv2 := 1 to 29 do
            If List[TmpNames[lcv].loc].Streak[lcv2] <> Streak[lcv2] then
              good := FALSE;
          If NOT good then TmpNames[lcv].Name := ''
            Else ListActive := TRUE;
        End;
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
    End;
{////////////////////////////////////////////////////////}
  Procedure Clea(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Cleav: Array[1..20] of Boolean;
      lcv,lcv2,loc: Integer;
      sel: Char;
      good: Boolean;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      For lcv := 1 to 20 do
        Cleav[lcv] := FALSE;
                                Box(9,2,62,'   Perfect Basal              2 Poor','B');
                                Box(9,3,62,'','C');
                                Box(9,4,62,'   None                       When Pure','C');
                                Box(9,5,62,'','C');
                                Box(9,6,62,'   3 Perfect                  Rhombohedral','C');
                                Box(9,7,62,'','C');
                                Box(9,8,62,'   Cubic                      Indistinct','C');
                                Box(9,9,62,'','C');
                                Box(9,10,62,'   Uneven Fracture            3 Good','C');
                                Box(9,11,62,'','C');
                                Box(9,12,62,'   Prismatic                  1 Imperfect','C');
                                Box(9,13,62,'','C');
                                Box(9,14,62,'   1 Perfect                  6 Perfect','C');
                                Box(9,15,62,'','C');
                                Box(9,16,62,'   Seldom Seen                4 Perfect','C');
                                Box(9,17,62,'','C');
                                Box(9,18,62,'   1 Fair                     Octahedral','C');
                                Box(9,19,62,'','C');
                                Box(9,20,62,'   1 Poor                     Orthorhombic','E');
                                c(8,1,3);
                                GotoXY(36,2);
                                Write('CLEAVAGE');
                                c(10,2,8);
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(11,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                For lcv := 3 to 22 do
                                  Begin
                                    GotoXY(38,lcv);
                                    Write(' ');
                                    inc(lcv,1);
                                  End;
                                GotoXY(11,3);
                                Repeat
                                  Repeat
                                    sel := ReadKey;
                                  Until sel <> '';
                                  If sel = #075 then
                                    Begin
                                      If WhereX - 27 < 11 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX - 27,WhereY);
                                    End;
                                  If sel = #077 then
                                    Begin
                                      If WhereX + 27 > 38 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX + 27,WhereY);
                                    End;
                                  If sel = #080 then
                                    Begin
                                      If WhereY + 2 > 21 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY + 2);
                                    End;
                                  If sel = #072 then
                                    Begin
                                      If WhereY - 2 < 3 then GotoXY(WhereX,WhereY)
                                        Else GotoXY(WhereX,WhereY - 2);
                                    End;
                                  If sel = #32 then
                                    Begin
                                      Case WhereY of
                                        3: loc := 1;
                                        5: loc := 2;
                                        7: loc := 3;
                                        9: loc := 4;
                                        11: loc := 5;
                                        13: loc := 6;
                                        15: loc := 7;
                                        17: loc := 8;
                                        19: loc := 9;
                                        21: loc := 10;
                                      End;
                                      Case WhereX of
                                        38: inc(loc,10);
                                      End;
                                      If Cleav[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          Cleav[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             Cleav[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        Begin
          good := TRUE;
          For lcv2 := 1 to 20 do
            If List[TmpNames[lcv].loc].Cleav[lcv2] <> Cleav[lcv2] then
              good := FALSE;
          If NOT good then TmpNames[lcv].Name := ''
            Else ListActive := TRUE;
        End;
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
    End;
{////////////////////////////////////////////////////////}
  Procedure SpecGrav(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      SpecGrav: ST11;
      lcv: Integer;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      Repeat
        Box(19,11,43,'Enter in the specific gravity:  ','O');
        GotoXY(53,12);
        c(15,2,1);
        answer11(SpecGrav, WhereX, WhereY);
        If NOT StrChk(SpecGrav) then
          Begin
            Box(33,11,15,'INVALID ENTRY!!','O');
            GotoXY(1,1);
            Sound(950);
            Delay(200);
            NoSound;
            Delay(1800);
          End;
      Until StrChk(SpecGrav);
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        If List[TmpNames[lcv].loc].specgrav = SpecGrav then
          Begin
            ListActive := TRUE;
          End
        Else TmpNames[lcv].Name := '';
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
     End;
{////////////////////////////////////////////////////////}
  Procedure Comp(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Comp: ST40;
      lcv: Integer;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      Box(1,11,75,'Enter in the mineral composition:  ','O');
      GotoXY(38,12);
      c(15,2,1);
      answer40(Comp, WhereX, WhereY);
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        If List[TmpNames[lcv].loc].Comp = Comp then
          Begin
            ListActive := TRUE;
          End
        Else TmpNames[lcv].Name := '';
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
     End;
{////////////////////////////////////////////////////////}
  Procedure Ori(var List:Group;var Names:NameList;var ListActive:Boolean);
    Var
      TmpNames: NameList;
      Origin: Array[1..4] of Boolean;
      lcv,lcv2,loc: Integer;
      sel: Char;
      good: Boolean;
    Begin
      For lcv := 1 to max do
        Begin
          TmpNames[lcv].Name := '';
          TmpNames[lcv].loc := 0;
        End;
      For lcv := 1 to num do
        Begin
          TmpNames[lcv].Name := Names[lcv].Name;
          TmpNames[lcv].loc := Names[lcv].loc;
        End;
      For lcv := 1 to 4 do
        Origin[lcv] := FALSE;
      Box(28,12,14,'   Igneous','B');
      Box(28,13,14,'','C');
      Box(28,14,14,'   Metamorphic','C');
      Box(28,15,14,'','C');
      Box(28,16,14,'   Sedimentary','C');
      Box(28,17,14,'','C');
      Box(28,18,14,'   Ore','E');
      c(8,1,3);
      GotoXY(34,12);
      Write('ORIGIN');
      c(10,2,8);
      GotoXY(30,13);
      Write(' ');
      GotoXY(30,15);
      Write(' ');
      GotoXY(30,17);
      Write(' ');
      GotoXY(30,19);
      Write(' ');
      GotoXY(30,13);
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        If sel = #080 then
          Begin
            If WhereY + 2 > 19 then GotoXY(30,WhereY)
              Else GotoXY(30,WhereY + 2);
          End;
        If sel = #072 then
          Begin
            If WhereY - 2 < 13 then GotoXY(30,WhereY)
              Else GotoXY(30,WhereY - 2);
          End;
        If sel = #32 then
          Begin
            Case WhereY of
             13: loc := 1;
             15: loc := 2;
             17: loc := 3;
             19: loc := 4;
            End;
            If Origin[loc] = TRUE then
              Begin
                Write(' ');
                GotoXY(30,WhereY);
                Origin[loc] := FALSE;
              End
            Else Begin
                   Write('û');
                   GotoXY(30, WhereY);
                   Origin[loc] := TRUE;
                 End;
          End;
      Until sel = #13;
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      For lcv := 1 to num do
        Begin
          good := TRUE;
          For lcv2 := 1 to 4 do
            If List[TmpNames[lcv].loc].Origin[lcv2] <> Origin[lcv2] then
              good := FALSE;
          If NOT good then TmpNames[lcv].Name := ''
            Else ListActive := TRUE;
        End;
      BoxWipe(33,11,52,13);
      GotoXY(1,1);
      If NOT ListActive then
        Begin
          Box(31,11,18,'No matches found!!','O');
          GotoXY(1,1);
          Sound(950);
          Delay(200);
          NoSound;
          Delay(1800);
        End
      Else Begin
             For lcv := 1 to num do
               Begin
                 Names[lcv].Name := TmpNames[lcv].Name;
                 Names[lcv].loc := TmpNames[lcv].loc;
               End;
           End;
      NameComp(Names,num);
    End;
{////////////////////////////////////////////////////////}
  Begin
    MenuSel[1] := '³ Hardness';
    MenuSel[2] := '³ Luster';
    MenuSel[3] := '³ Color';
    MenuSel[4] := '³ Streak';
    MenuSel[5] := '³ Cleavage';
    MenuSel[6] := '³ Specific Gravity';
    MenuSel[7] := '³ Composition';
    MenuSel[8] := '³ Origin';
    MenuSel[9] := '³ Prevoius List';
    cntr := 1;
    ListActive := FALSE;
    For lcv := 1 to max do
      Begin
        Names[lcv].Name := '';
        Names[lcv].loc := 0;
      End;
    For lcv := 1 to num do
      Begin
        Names[lcv].Name := List[lcv].Name;
        Names[lcv].loc := lcv;
      End;
    Repeat
      BackDrop;
      c(9,1,4);
      GotoXY(33,1);
      Write('MINERAL MASTER');
      Box(3,5,19,'','B');
      Box(3,6,19,'','C');
      Box(3,7,19,'','C');
      Box(3,8,19,'','C');
      Box(3,9,19,'','C');
      Box(3,10,19,'','C');
      Box(3,11,19,'','C');
      Box(3,12,19,'','C');
      Box(3,13,19,'','E');
      MenH(3,3,14,'SEARCH METHODS');
      c(15,2,1);
      For lcv := 1 to 9 do
        MenuSelDisp(lcv);
      c(15,2,8);
      MenuSelDisp(cntr);
      GotoXY(1,24);
      c(15,2,4);
      Write('                                                                                ');
      GotoXY(1,24);
      Write('Press ESC to return to the main menu. . .');
      c(14,2,1);
      GotoXY(1,1);
      If ListActive then
        Begin
          NameDisp(Names,num);
          ListActive := FALSE;
        End;
      Repeat
        Repeat
          Csel := ReadKey;
        Until Csel <> '';
        sel := Ord(Csel);
        Case sel of
          072:  Begin
                   c(15,2,1);
                   MenuSelDisp(cntr);
                   If cntr > 1 then dec(cntr,1);
                   c(15,2,8);
                   MenuSelDisp(cntr);
                   GotoXY(1,1);
                 End;
          080:  Begin
                   c(15,2,1);
                   MenuSelDisp(cntr);
                   If cntr < 9 then inc(cntr,1);
                   c(15,2,8);
                   MenuSelDisp(cntr);
                   GotoXY(1,1);
                 End;
          13:  Begin
                 Case cntr of
                   1: Hardness(List,Names,ListActive);
                   2: Lust(List,Names,ListActive);
                   3: Colors(List,Names,ListActive);
                   4: Stre(List,Names,ListActive);
                   5: Clea(List,Names,ListActive);
                   6: SpecGrav(List,Names,ListActive);
                   7: Comp(List,Names,ListActive);
                   8: Ori(List,Names,ListActive);
                   9: NameDisp(Names,num);
                 End;
               End;
        End;
      Until (sel = 13) or (sel = 027);
    Until sel = 027;
    GotoXY(1,24);
    c(7,1,0);
    Write('                                                                                ');
  End;
{////////////////////////////////////////////////////////////////}
Procedure PrintList(var List:Group; cntr:Integer);
  Var                        {prints out the names}
    ans:ST1;
    name:ST26;
    loc, lcv, lcv2, cnrt:Integer;
    first: Boolean;
    sel: Char;
  Begin
    c(15,2,1);
    Repeat
      Box(15,11,59,'What rock do you want to print:  ','O');
      GotoXY(50,12);
      c(15,2,1);
      answer26(name, WhereX, WhereY); {ReadLn(name);}
    Until name <> '';
    For loc := 1 to Length(name) do
      name[loc] := UpCase(name[loc]);
    loc := BinFind(List, name, cntr);
    If loc > 0 then
    Begin
    GotoXY(1,1);
    Box(1,3,76,'                                                                          ','B');
    Box(1,4,76,'----------------------------------------------------------------------------','C');
    Box(1,5,76,'Hardness        :  ','C');
    Box(1,6,76,'Luster          :  ','C');
    Box(1,7,76,'Color           :  ','C');
    Box(1,8,76,'Streak          :  ','C');
    Box(1,9,76,'Cleavage        :  ','C');
    Box(1,10,76,'Specific Gravity:  ','C');
    Box(1,11,76,'Properities     :  ','C');
    Box(1,12,76,'','C');
    Box(1,13,76,'','C');
    Box(1,14,76,'','C');
    Box(1,15,76,'Composition     :  ','C');
    Box(1,16,76,'Use             :  ','C');
    Box(1,17,76,'','C');
    Box(1,18,76,'','C');
    Box(1,19,76,'Origin          :  ','E');
    c(15,2,1);
    GotoXY((40 - (Length(List[loc].Name) div 2)),4);
    WriteLn(List[loc].Name);
    GotoXY(21,6);
    WriteLn(List[loc].Hard);
    GotoXY(21,7);
    first := TRUE;
    For lcv := 1 to 20 do
      Begin
        If List[loc].Luster[lcv] then
          Begin
            If NOT first then Write(',')
              Else first := FALSE;
            Case lcv of
              1: Write('Metallic');
              2: Write('Sub-Metallic');
              3: Write('Dull');
              4: Write('Earthy');
              5: Write('Greasy');
              6: Write('Pearly');
              7: Write('Resinous Pearly');
              8: Write('Resinous');
              9: Write('Vitreous');
             10: Write('Vitreous nearly Pearly');
             11: Write('Waxy');
             12: Write('Silky');
             13: Write('Translucent');
             14: Write('Transparent');
             15: Write('Dull Earthy');
             16: Write('Adamantive');
             17: Write('Earth Vitreous');
             18: Write('Resinous Sub-Metallic');
             19: Write('Vitreous Silky');
             20: Write('Gray, brown, yellow, white hues');
            End;
          End;
      End;
    GotoXY(21,8);
    first := TRUE;
    For lcv := 1 to 43 do
      Begin
        If List[loc].Color[lcv] then
          Begin
            If NOT first then Write(',')
              Else first := FALSE;
            Case lcv of
              1: Write('Black');
              2: Write('Gray');
              3: Write('Earthy');
              4: Write('Reddish Brown');
              5: Write('Blue-Black');
              6: Write('Lead-Gray');
              7: Write('Steel Gray');
              8: Write('Gold-Yellow');
              9: Write('Copper-Red');
             10: Write('Tarnish');
             11: Write('Bronze');
             12: Write('Yellow');
             13: Write('Brass-Yellow');
             14: Write('Pale Copper-Red');
             15: Write('Black Tarnish');
             16: Write('Dark Gray');
             17: Write('Silver-White');
             18: Write('Iron-Black');
             19: Write('Brown');
             20: Write('Dark Brown');
             21: Write('Pale Brass');
             22: Write('Bright Yellow');
             23: Write('White');
             24: Write('Green');
             25: Write('Orange');
             26: Write('Buff');
             27: Write('Colorless');
             28: Write('Pink');
             29: Write('Dark Green');
             30: Write('Smoky');
             31: Write('Violet');
             32: Write('Deep Red');
             33: Write('Intense Azure');
             34: Write('Bright Green');
             35: Write('Rose Red');
             36: Write('Light Green');
             37: Write('Light Yellow');
             38: Write('Gray-Blue');
             39: Write('Flesh-Colored');
             40: Write('Blackish Green');
             41: Write('Olive-Green');
             42: Write('Fed');
             43: Write('Clear Brown');
            End;
          End;
      End;
    GotoXY(21,9);
    first := TRUE;
    For lcv := 1 to 29 do
      Begin
        If List[loc].Streak[lcv] then
          Begin
            If NOT first then Write(',')
              Else first := FALSE;
            Case lcv of
              1: Write('Black');
              2: Write('Yellow-Dark Brown');
              3: Write('Brown');
              4: Write('Light Indian Red');
              5: Write('Dark Indian Red');
              6: Write('Lead Gray');
              7: Write('Dark Gray');
              8: Write('Gold-Yellow');
              9: Write('Copper Red');
             10: Write('Tarnished');
             11: Write('Dark Blue');
             12: Write('Purple');
             13: Write('Grayish-Black');
             14: Write('Brownish-Black');
             15: Write('Brown-Red');
             16: Write('Yellow-Brown');
             17: Write('Greenish');
             18: Write('Pale Yellow');
             19: Write('White');
             20: Write('Yellow');
             21: Write('Red');
             22: Write('Orange');
             23: Write('Greenish White');
             24: Write('Red Brown');
             25: Write('Bluish White');
             26: Write('Colorless');
             27: Write('Orange-Yellow');
             28: Write('Greenish-Gray');
             29: Write('Pale Brown');
            End;
          End;
      End;
    GotoXY(21,10);
    first := TRUE;
    For lcv := 1 to 20 do
      Begin
        If List[loc].Cleav[lcv] then
          Begin
            If NOT first then Write(',')
              Else first := FALSE;
            Case lcv of
              1: Write('Perfect Basal');
              2: Write('None');
              3: Write('3 Perfect');
              4: Write('Cubic');
              5: Write('Uneven Fracture');
              6: Write('Prismatic');
              7: Write('1 Perfect');
              8: Write('Seldom Seen');
              9: Write('1 Fair');
             10: Write('1 Poor');
             11: Write('2 Poor');
             12: Write('When Pure');
             13: Write('Rhombohedral');
             14: Write('Indistinct');
             15: Write('3 Good');
             16: Write('1 Imperfect');
             17: Write('6 Perfect');
             18: Write('4 Perfect');
             19: Write('Octahedral');
             20: Write('Orthorhombic');
            End;
          End;
      End;
    GotoXY(21,11);
    WriteLn(List[loc].SpecGrav);
    GotoXY(3,13);
    WriteLn(List[loc].Prop1);
    GotoXY(3,14);
    WriteLn(List[loc].Prop2);
    GotoXY(3,15);
    WriteLn(List[loc].Prop3);
    GotoXY(21,16);
    WriteLn(List[loc].Comp);
    GotoXY(3,18);
    WriteLn(List[loc].Use1);
    GotoXY(3,19);
    WriteLn(List[loc].Use2);
    GotoXY(21,20);
    first := TRUE;
    For lcv := 1 to 4 do
      Begin
        If List[loc].Origin[lcv] then
          Begin
            If NOT first then Write(',')
              Else first := FALSE;
            Case lcv of
              1: Write('I');
              2: Write('M');
              3: Write('S');
              4: Write('O');
            End;
          End;
      End;
    GotoXY(1,24);
    c(15,2,4);
    Write('                                                                                ');
    GotoXY(1,24);
    Write('Press ESC to return to the main menu. . .');
    c(14,2,1);
    GotoXY(1,1);
    Repeat
      sel := ReadKey;
    Until sel = #27;
    c(7,2,0);
    End
    Else Begin
           Box(23,11,41,'                           was not found.', 'O');
           c(15,2,1);
           GotoXY(26, 12);
           Write(name);
           GotoXY(1,1);
           Sound(900);
           Delay(500);
           NoSound;
           Delay(1500);
         End;
    GotoXY(1,24);
    c(7,1,0);
    Write('                                                                                ');
    End;
{////////////////////////////////////////////////////////////////}
Procedure MainMenu;
  Var                           {main menu display}
    sel: Char;
  Begin
    c(7,1,0);
    ClrScr;
    Repeat
      BackDrop;                                {menu background}
      c(9,1,4);
      GotoXY(33,1);
      Write('MINERAL MASTER');
      MenC(27,10,20,'S','Search','B');         {<=======|}
      Menc(27,11,20,'D','Display mineral data','C');{<==|}
      Box(27,12,25,'','C');                    {<=======|}
      MenC(27,13,20,'A','Auditorian','C');     {<=======|}
      MenC(27,14,20,'Q','Quit','E');           {<=======|}
      MenH(27,8,20,'MINERALS');                {<=======|----entire main menu}
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        Case sel of
          'S': Search(List,cntr);
          'D': PrintList(List,cntr);
(*          'A'*)
        End;
      Until (sel = 'S') or (sel = 'D') or (sel = 'A') or (sel = 'Q');
    Until sel = 'Q';
  End;
{////////////////////////////////////////////////////////////////}
Begin
  max := 110;
  Load(List, 'MINERALS.DAT', cntr);
  MainMenu;
  c(7,1,0);
  ClrScr;
End.