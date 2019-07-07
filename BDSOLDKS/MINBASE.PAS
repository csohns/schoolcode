{.}
                                                                 {Chris Sohns}
                                                                     {MINERAL}
                                                                    {09/20/96}
                     {This program is a name data base. }
                     {It can store up to 1000 names.  It}
                     {can add, delete, find, print, save}
                     {load name to/from a file.         }


Program MINERAL;

USES
     CRT, DOS, MENU, {CREDITS,} ANSWERS{, PONG, SCRSAV};

CONST
     recmax = 2;  (*recmax = 110*)
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
     cntr,
     max: Integer;
     REG : Boolean;



{////////////////////////////////////////////////////////////////////////}
Procedure Intro;
     Begin
          ClrScr;
{          Box(0,12,17,'The Scroll Keeper','O');
          GotoXY(1,1);
          Sound(200);
          Delay(80);
          Sound(300);
          Delay(80);
          Sound(400);
          Delay(80);
          Sound(500);
          Delay(80);
          NoSound;
          Delay(4000);
          ClrScr;}
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure InitArray(var List: Group);  {Set all array com-}
     Var                               {ponents to 0}
          lcv,lcv2: Integer;

     Begin
          For lcv := 1 to max do
               Begin
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
{////////////////////////////////////////////////////////////////////////}
Procedure MainMenu(var List:Group; var REG:Boolean);
     Var                             {Dysplays main menu}
          sel     : Char;
          cntr    : Integer;
          cntr2   : LongInt;
          DataFile,
          CCFile  : ST20;
          change,
          CC,
          SSed     : Boolean;
          FC       : Text;
{////////////////////////////////////////////////////////////////}
  Procedure Status(cntr:Integer; DataFile:String);
       Begin                        {Dysplays number of records and file name}
            If DataFile = '' then DataFile := 'No Data File Selected';
            GotoXY(1,24);
            c(15,2,4);
            Write('                                                                                ');
            GotoXY(1,24);
            Write('    Records = ', cntr, '        Data File = ', DataFile, '        F2 = MORE');
            If DataFile = 'No Data File Selected' then DataFile := '';
            c(7,2,0);
            GotoXY(1,1);
       End;
{////////////////////////////////////////////////////////////////}
  Procedure More(cntr:Integer; DataFile:String);
       Var                          {Dysplayes number of records, free memory,}
            ch: Char;               {max memory, HD disk space, HD disk space free,}
       Begin                        {dos version, and data file name}
            If DataFile = '' then DataFile := 'No Data File Selected';
            Box(13,9,52,'','B');
            c(15,2,1);
            GotoXY(15,10);
            Write('Records         = ', cntr);
            GotoXY(47,10);
            Write('Free Memory = ', MemAvail);
            Box(13,10,52,'','C');
            c(15,2,1);
            GotoXY(15,11);
            Write('Hard Disk Size  = ', DiskSize(0));
            GotoXY(47, 11);
            Write('Max Memory  = ', MaxAvail);
            Box(13,11,52,'','C');
            c(15,2,1);
            GotoXY(15,12);
            Write('Free Disk Space = ', DiskFree(0));
            GotoXY(47, 12);
            Write('Dos Version = ', DosVersion);
            Box(13,12,52,'','E');
            c(15,2,1);
            GotoXY(15,13);
            Write('Data File       = ', DataFile);
            If DataFile = 'No Data File Selected' then DataFile := '';
            GotoXY(1,1);
            Repeat
                 ch := ReadKey;
                 If Ord(ch) = 060 then ch := 'N';
            Until ch <> '';
       End;
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
  Procedure skip(num: Integer);
       Var                          {skips specifyed number of lines}
            lcv: Integer;
       Begin
            For lcv := 1 to num do
                 WriteLn;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure skipchar;
       Var
            temp: Char;
       Begin
            Read(FC, temp);
       End;
{////////////////////////////////////////////////////////////////}
  Procedure AddName(var List:Group; var cntr:Integer; var change, CC:Boolean);
{////////////////////////////////////////////////////////}
(*    Procedure SplitStr(TempStrSpan:ST10; var HardLo,HardHi:Real);
      Var
        two,
        deci: Boolean;
        lcv,
        loc,
        HLL,HLR: Integer;
        HL,HH:String;
        TempChar: Char;
      Begin
        two := FALSE;
        For lcv := 1 to Length(TempStrSpan) do
          Begin
            loc := lcv;
            If TempStrSpan[loc] = '-' then two := TRUE;
          End;
        If two then
          Begin
            deci := FALSE;
            HL := Copy(TempStrSpan,1,loc-1);
            Delete(TempStrSpan,1,loc);
            HH := TempStrSpan;
          End;
        Else HardLo :=
      End;*)
{////////////////////////////////////////////////////////}
Procedure ReInitArray(var List: Group; loc:Integer);  {Set all array com-}
     Var                                              {ponents to 0}
          lcv: Integer;

     Begin
       List[loc].Hard := '';
       For lcv := 1 to 20 do
         List[loc].Luster[lcv] := FALSE;
       For lcv := 1 to 43 do
         List[loc].Color[lcv] := FALSE;
       For lcv := 1 to 29 do
         List[loc].Streak[lcv] := FALSE;
       For lcv := 1 to 20 do
         List[loc].Cleav[lcv] := FALSE;
       List[loc].SpecGrav := '';
       List[loc].Prop1 := '';
       List[loc].Prop2 := '';
       List[loc].Prop3 := '';
       List[loc].Name := '';
       List[loc].Comp := '';
       List[loc].Use1 := '';
       List[loc].Use2 := '';
       For lcv := 1 to 4 do
         List[loc].Origin[lcv] := FALSE;
     End; {ReInitArray}
{////////////////////////////////////////////////////////}
       Var                          {adds names to list}
            {name: StringValue;}
            name: ST20;
            lcv: Integer;
            sel: Char;
            loc: Integer;
(*            TempStrSpan: ST10;*)
       Begin
            If cntr < max then
                 Begin
                      Box(16,11,48,'Enter in new mineral name:  ','O');
                      GotoXY(46,12);
                      c(15,2,1);
                      If CC then
                           Begin
                                skipchar;
                                ReadLn(FC, name);
                                Write(name);
                           End
                      Else answer20(name, WhereX, WhereY);
                      If name <> '' then
                           Begin
                                For lcv := 1 to Length(name) do
                                  name[lcv] := UpCase(name[lcv]);
                                inc(cntr, 1);
                                ReInitArray(List,cntr);
                                change := TRUE;
                                Box(23,11,34,'Enter in the hardness:  ','O');
                                GotoXY(48,12);
                                c(15,2,1);
                                answer11(List[cntr].Hard, WhereX, WhereY);
(*                               SplitStr(TempStrSpan,List[cntr].HardLo,List[cntr].HardHi);*)
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
                                      If List[cntr].Luster[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Luster[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Luster[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
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
                                      If List[cntr].Color[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Color[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Color[loc] := TRUE;
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
                                      If List[cntr].Color[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Color[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Color[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
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
                                      If List[cntr].Streak[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Streak[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Streak[loc] := TRUE;
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
                                      If List[cntr].Streak[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Streak[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Streak[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
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
                                      If List[cntr].Cleav[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(WhereX - 1,WhereY);
                                          List[cntr].Cleav[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(WhereX - 1, WhereY);
                                             List[cntr].Cleav[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
                                Box(19,11,43,'Enter in the specific gravity:  ','O');
                                GotoXY(53,12);
                                c(15,2,1);
                                answer11(List[cntr].specgrav, WhereX, WhereY);
                                Box(1,11,76,'Enter in the mineral properties:','B');
                                Box(1,12,76,'','E');
                                c(15,2,1);
                                GotoXY(3,13);
                                answer76(List[cntr].Prop1, WhereX, WhereY);
                                If Length(List[cntr].Prop1) > 70 then
                                     Begin
                                          Box(1,11,76,'Enter in the mineral properties:  (LINE 2)','B');
                                          Box(1,12,76,'','E');
                                          c(15,2,1);
                                          GotoXY(3,13);
                                          answer76(List[cntr].Prop2, WhereX, WhereY);
                                  If Length(List[cntr].Prop2) > 70 then
                                       Begin
                                            Box(1,11,76,'Enter in the mineral properties:  (LINE 3)','B');
                                            Box(1,12,76,'','E');
                                            c(15,2,1);
                                            GotoXY(3,13);
                                            answer76(List[cntr].Prop3, WhereX, WhereY);
                                       End;
                                     End;
                                Box(1,11,75,'Enter in the mineral composition:  ','O');
                                GotoXY(38,12);
                                c(15,2,1);
                                answer40(List[cntr].Comp, WhereX, WhereY);
                                Box(1,11,76,'Enter in the mineral use:','B');
                                Box(1,12,76,'','E');
                                c(15,2,1);
                                GotoXY(3,13);
                                answer76(List[cntr].Use1, WhereX, WhereY);
                                If Length(List[cntr].Use1) > 70 then
                                     Begin
                                          Box(1,11,76,'Enter in the mineral use:  (LINE 2)','B');
                                          Box(1,12,76,'','E');
                                          c(15,2,1);
                                          GotoXY(3,13);
                                          answer76(List[cntr].Use2, WhereX, WhereY);
                                     End;
                                Box(28,12,14,'   Igneous','B');
                                Box(28,13,14,'','C');
                                Box(28,14,14,'   Metamorphic','C');
                                Box(28,15,14,'','C');
                                Box(28,16,14,'   Sedimentary','C');
                                Box(28,17,14,'','C');
                                Box(28,18,14,'   Ore','E');
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
                                      If List[cntr].Origin[loc] = TRUE then
                                        Begin
                                          Write(' ');
                                          GotoXY(30,WhereY);
                                          List[cntr].Origin[loc] := FALSE;
                                        End
                                      Else Begin
                                             Write('û');
                                             GotoXY(30, WhereY);
                                             List[cntr].Origin[loc] := TRUE;
                                           End;
                                    End;
                                Until sel = #13;
                                List[cntr].Name := name;
                           End;
                 End
            Else Begin
                      Box(24,11,31,'A      name limit has been set', 'O');
                      GotoXY(28, 12);
                      c(15,2,1);
                      Write(max);
                      GotoXY(1,1);
                      Sound(900);
                      Delay(500);
                      NoSound;
                      Delay(1500);
                 End;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure DeleteName(var List:Group; var cntr:Integer; var change, CC:Boolean);
       Var                          {deletes names from list}
            name: ST20;
            loc,
            lcv : Integer;
       Begin
            Box(18,11,52,'Enter in rock to delete:  ', 'O');
            c(15,2,1);
            GotoXY(46,12);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else answer20(name, WhereX, WhereY); {ReadLn(name);}
            If name <> '' then
                 Begin
                      For lcv := 1 to Length(name) do
                        name[lcv] := UpCase(name[lcv]);
                      loc := BinFind(List, name, cntr);
                      If loc > 0 then
                           Begin
                                For lcv := loc to cntr do
                                     List[lcv] := List[lcv + 1];
                                dec(cntr, 1);
                                change := TRUE;
                           End
                      Else Begin
                                Box(21,11,47, '                           could not be found!!', 'O');
                                GotoXY(23,12);
                                c(15,2,1);
                                Write(name);
                                Sound(900);
                                Delay(500);
                                NoSound;
                                Delay(1500);
                           End;
                 End;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure NameFind(var List:Group;var CC:Boolean);
       Var                          {searches for a names in the list}
            name: ST20;
            loc : Integer;
       Begin
            Box(11,11,56,'Enter in rock to search for:  ', 'O');
            GotoXY(43,12);
            c(15,2,1);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else answer20(name, WhereX, WhereY); {ReadLn(name);}
            If name <> '' then
            Begin
                 For loc := 1 to Length(name) do
                   name[loc] := UpCase(name[loc]);
                 loc := BinFind(List, name, cntr);
                 If loc > 0 then
                      Begin
                           Box(25,11,37,'                           was found.', 'O');
                           c(15,2,1);
                           GotoXY(28, 12);
                           Write(name);
                           Delay(2000);
                      End
                 Else Begin
                           Box(21,11,47, '                           could not be found!!', 'O');
                           c(15,2,1);
                           GotoXY(23,12);
                           Write(name);
                           Sound(900);
                           Delay(500);
                           NoSound;
                           Delay(1500);
                      End;
            End;
       End;
{////////////////////////////////////////////////////////////////}
    Procedure Save(var List:Group; var DataFile:ST20; cntr:Integer; var change, REG, CC:Boolean);
         Var                        {saves the names to a file}
              lcv : Integer;
              temp: ST20;
              ans : ST1;
              F   : File of CardStats;
              oncebefore: Boolean;
         Begin
              oncebefore := FALSE;
              temp := DataFile;
              If REG then
              Begin
              If DataFile <> '' then
                   Begin
                        Box(4,11,70,'','O');
                        GotoXY(6,12);
                        c(15,2,1);
                        Write('Enter in name of file to save to [', DataFile, ']:  ');
                        If CC then
                             Begin
                                  skipchar;
                                  ReadLn(FC, DataFile);
                                  Write(DataFile);
                             End
                        Else ReadLn(DataFile);
                        If DataFile = '' then
                             Begin
                                  DataFile := temp;
                                  oncebefore := TRUE;
                             End;
                   End
              Else Begin
                        Box(14,11,51,'Enter in name of file to save to:  ','O');
                        GotoXY(51,12);
                        c(15,2,1);
                        If CC then
                             Begin
                                  skipchar;
                                  ReadLn(FC, DataFile);
                                  Write(DataFile);
                             End
                        Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
                        (*While DataFile = '' do
                             Begin
                                  Box(30,11,19,'','O');
                                  c(12,2,1);
                                  GotoXY(32,12);
                                  WriteLn('INVALID FILE NAME!!');
                                  Sound(900);
                                  Delay(500);
                                  Nosound;
                                  Delay(1500);
                                  Box(14,11,51,'Enter in name of file to save to:  ','O');
                                  GotoXY(51,12);
                                  c(15,2,1);
                                  If CC then
                                       Begin
                                            skipchar;
                                            ReadLn(FC, DataFile);
                                            Write(DataFile);
                                       End
                                  Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
                             End;*)
                   End;
              End;
              If DataFile <> '' then
              Begin
              Assign(F, DataFile);
              {$I-}
              ReSet(F);
              Close(F);
              If IOResult = 0 then
                   Begin
                        If (oncebefore = FALSE) and (REG) then
                             Begin
                                  Repeat
                                  ans := 'N';
                                  Box(20,11,40,'','B');
                                  c(15,2,1);
                                  GotoXY(22,12);
                                  Write(DataFile,' already exists!!');
                                  Box(20,12,40,'Do you wish to overwrite the old one?  ','E');
                                  GotoXY(60,13);
                                  c(15,2,1);
                                  answer1(ans, WhereX, WhereY); {ReadLn(ans);}
                                  If (ans = 'Y') or (ans = 'y') then ReWrite(F)
                                  Else Begin
                                            Box(14,11,51,'Enter in name of file to save to:  ','O');
                                            GotoXY(51,12);
                                            c(15,2,1);
                                            IF CC then
                                                 Begin
                                                      skipchar;
                                                      ReadLn(FC, DataFile);
                                                      Write(DataFile);
                                                 End
                                            Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
                                            Assign(F, DataFile);
                                            {$I-}
                                            ReSet(F);
                                            Close(F);
                                            {$I+}
                                       End;
                                  (*While DataFile = '' do
                                       Begin
                                            Box(30,11,19,'','O');
                                            TextColor(12);
                                            GotoXY(32,12);
                                            WriteLn('INVALID FILE NAME!!');
                                            Sound(900);
                                            Delay(500);
                                            Nosound;
                                            Delay(1500);
                                            Box(14,11,51,'Enter in name of file to save to:  ','O');
                                            GotoXY(51,12);
                                            c(15,2,1);
                                            IF CC then
                                                 Begin
                                                      skipchar;
                                                      ReadLn(FC, DataFile);
                                                      Write(DataFile);
                                                 End
                                            Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
                                            Assign(F, DataFile);
                                            {$I-}
                                            ReSet(F);
                                            Close(F);
                                            {$I+}
                                       End;*)
                                  Until (ans = 'Y') or (ans = 'y') or (IOResult <> 0);
                             End
                        Else Begin
                                  {$I+}
                                  Assign(F, DataFile);
                                  ReWrite(F);
                             End;
                        {End;}
                   End
              Else Begin
                        {$I+}
                        Assign(F, DataFile);
                        ReWrite(F);
                   End;
              For lcv := 1 to cntr do
                   Write(F, List[lcv]);
              change := FALSE;
              Close(F);
              End;
         End;
{////////////////////////////////////////////////////////////////}
    Procedure Load(var List:Group; var DataFile:ST20; var cntr:Integer; var change, REG, CC:Boolean);
         Var                        {loads the names from a file}
              lcv: Integer;
              F  : File of CardStats;
              ans: ST1;
         Begin
              skip(1);
              If change = TRUE then
               Begin
                    Box(19,11,42,'Your data has changed since your last save','B');
                    Box(19,12,42,'Do you want to save?  ','E');
                    GotoXY(43,13);
                    c(15,2,1);
                    answer1(ans, WhereX, WhereY); {ReadLn(ans);}
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, REG, CC);
               End;
              If REG then
              Begin
              Box(17,11,46,'Enter file name to load:  ','O');
              GotoXY(45,12);
              c(15,2,1);
              If CC then
                   Begin
                        skipchar;
                        ReadLn(FC, DataFile);
                        Write(DataFile);
                   End
              Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
              End;
              (*While DataFile = '' do
                   Begin
                        Box(30,11,19,'','O');
                        c(12,2,1);
                        GotoXY(32,12);
                        WriteLn('INVALID FILE NAME!!');
                        Sound(900);
                        Delay(500);
                        Nosound;
                        Delay(1500);
                        Box(17,11,46,'Enter file name to load:  ','O');
                        GotoXY(45,12);
                        c(15,2,1);
                        If CC then
                             Begin
                                  skipchar;
                                  ReadLn(FC, DataFile);
                                  Write(DataFile);
                             End
                        Else answer20(DataFile, WhereX, WhereY); {ReadLn(DataFile);}
                   End;*)
              If DataFile <> '' then
              Begin
              Assign(F, DataFile);
              {$I-}
              ReSet(F);
              Close(F);
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
                                  Write(cntr);
                                  c(7,2,1);
                                  inc(cntr, 1);
                                  Read(F, List[cntr]);
                             End;
                        Close(F);
                        change := FALSE;
                   End
              Else Begin
                        Box(31,11,16,'File not found!!','O');
                        Sound(900);
                        Delay(500);
                        Nosound;
                        Delay(1500);
                        DataFile := '';
                   End;
              End;
         End;
{////////////////////////////////////////////////////////////////}
    Procedure Quit(var List:Group; var DataFile:ST20; var cntr:Integer; var change, REG, CC:Boolean; var sel:Char);
              Var                   {quit the program}
                   ans: ST1;
              Begin
              skip(1);
              If change = TRUE then
               Begin
                    Box(19,11,42,'Your data has changed since your last save','B');
                    Box(19,12,42,'Do you want to save?  ','E');
                    GotoXY(43,13);
                    c(15,2,1);
                    answer1(ans, WhereX, WhereY); {ReadLn(ans);}
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, REG, CC);               End;
              Box(23,11,33,'Are you sure you want to quit?  ','O');
              GotoXY(57,12);
              c(15,2,1);
              answer1(ans, WhereX, WhereY); {ReadLn(ans);}
              If (ans = 'Y') or (ans = 'y') then sel := 'Q'
                   Else sel := 'N';
              If (CC) and (sel = 'N') then
                   CC := FALSE;
              End;
{////////////////////////////////////////////////////////////////}
    Procedure PrintList(var List:Group; cntr:Integer; var CC:Boolean);
         Var                        {prints out the names}
              ans:ST1;
              name:ST26;
              loc, lcv, lcv2, cnrt:Integer;
              first: Boolean;
              sel: Char;
{////////////////////////////////////////////////////////}
        Procedure Header;
             Begin
                  ClrScr;
                  GotoXY(1,1);
                  c(15,2,1);
                  WriteLn('           NAME             CODE  OFFENSE / DEFENSE   PRICE   TYPE');
                  WriteLn('--------------------------  ----  -------   -------  -------  ----');
             End;
{////////////////////////////////////////////////////////}
         Begin
              Box(17,11,45,'Do you want to print a certian rock (N,y):  ','O');
              GotoXY(63,12);
              c(15,2,1);
              If CC then
                   ans := 'N'
              Else answer1(ans, WhereX, WhereY); {ReadLn(ans);}
              If (ans = 'Y') or (ans = 'y') then
                   Begin
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
    GotoXY(1,1);
(*                                  Header;
                                  c(15,2,1);
                                  Write(List[loc].name);
                                  GotoXY(30,3);
                                  c(13,2,1);
                                  Write(List[loc].colors);
                                  GotoXY(40,3);
                                  c(11,2,1);
                                  Write(List[loc].Deff);
                                  c(15,2,1);
                                  GotoXY(43,3);
                                  Write('/');
                                  GotoXY(45,3);
                                  c(12,2,1);
                                  Write(List[loc].Off);
                                  GotoXY(54,3);
                                  c(14,2,1);
                                  Write('$');
                                  Write(List[loc].price);
                                  GotoXY(64,3);
                                  c(8,1,1);
                                  Write(List[loc].ctype);
                                  GotoXY(1,4);
                                  c(10,2,1);
                                  WriteLn(List[loc].texts);
                                  Write(List[loc].texts2);*)
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
                                  Sound(900);
                                  Delay(500);
                                  NoSound;
                                  Delay(1500);
                             End;
                   End
              Else Begin
                        Header;
                        lcv2 := 0;
                        loc := BinFind(List, '', cntr);
                        cnrt := 3;
                        GotoXY(1,cnrt);
                        For lcv := 1 to cntr do
                             Begin
                                  inc(lcv2, 1);
                                  c(15,2,1);
                                  Write(List[lcv].name,'  ');
                                  GotoXY(30,cnrt);
(*                                  c(13,2,1);
                                  Write(List[lcv].colors,'  ');
                                  GotoXY(40,cnrt);
                                  c(11,2,1);
                                  Write(List[lcv].Deff,'  ');
                                  c(15,2,1);
                                  GotoXY(43,cnrt);
                                  Write('/');
                                  GotoXY(45,cnrt);
                                  c(12,2,1);
                                  Write(List[lcv].Off,'  ');
                                  GotoXY(54,cnrt);
                                  c(14,2,1);
                                  Write('$');
                                  Write(List[lcv].price);
                                  GotoXY(64,cnrt);
                                  c(8,1,1);
                                  WriteLn(List[lcv].ctype);
                                  GotoXY(1,cnrt + 1);
                                  c(10,2,1);
                                  WriteLn(List[lcv].texts);
                                  WriteLn(List[lcv].texts2);*)
                                  c(15,2,1);
                                  inc(cnrt, 3);
                                  If lcv2 = 8 then
                                       Begin
                                            lcv2 := 0;
                                            GotoXY(1,24);
                                            c(15,2,4);
                                            Write('                                                                        ');
                                            Write('        ');
                                            GotoXY(1,24);
                                            Write('Press ENTER to return to the main menu. . .');
                                            c(14,2,1);
                                            GotoXY(1,1);
                                            Repeat
                                              sel := ReadKey;
                                            Until sel = #27;
                                            c(7,2,0);
                                            ClrScr;
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
                        ClrScr;
                   End;
         End;
{////////////////////////////////////////////////////////////////}
    Procedure ConsoleControl(var CCFile:ST20; var CC:Boolean; var FC:Text);
         Var                            {Enables program to be controled}
              lcv: Integer;             {by an external file}
              ans: ST1;
         Begin
              Box(12,11,54,'Are you sure you want to end Console Control (N,y):  ','O');
              GotoXY(67,12);
              c(15,2,1);
              answer1(ans, WhereX, WhereY); {ReadLn(ans);}
              If (ans = 'Y') or (ans = 'y') then
                   Begin
                        Box(16,9,46,'','B');
                        Box(16,10,46,'','C');
                        Box(16,11,46,'','C');
                        Box(16,12,46,'','C');
                        Box(16,13,46,'','E');
                        GotoXY(18,10);
                        c(4,2,1);
                        Write('WARING:  YOU ARE ABOUT TO END CONSOLE CONTROL');
                        GotoXY(18,12);
                        c(2,2,1);
                        Write('This means that this program will be controled');
                        GotoXY(18,13);
                        Write('by an external file. If you choose to continue');
                        GotoXY(18,14);
                        Write('some unexpected side effects may occure!!!!!!!');
                        GotoXY(1,1);
                        Sound(900);
                        Delay(500);
                        NoSound;
                        Delay(3500);
                        Box(20,18,37,'Are you sure you want to continue?  ','O');
                        GotoXY(58,19);
                        c(15,2,1);
                        answer1(ans, WhereX, WhereY); {ReadLn(ans);}
                        If (ans = 'Y') or (ans = 'y') then
                             Begin
                                  Box(17,11,46,'Enter file name to read:  ','O');
                                  GotoXY(45,12);
                                  c(15,2,1);
                                  answer20(CCFile, WhereX, WhereY); {ReadLn(CCFile);}
                                  While CCFile = '' do
                                       Begin
                                            Box(30,11,19,'','O');
                                            TextColor(12);
                                            GotoXY(32,12);
                                            WriteLn('INVALID FILE NAME!!');
                                            Sound(900);
                                            Delay(500);
                                            Nosound;
                                            Delay(1500);
                                            Box(17,11,46,'Enter file name to read:  ','O');
                                            c(15,2,1);
                                            GotoXY(45,12);
                                            answer20(CCFile, WhereX, WhereY); {ReadLn(CCFile);}
                                       End;
                                  Box(27,11,26,'File Control begins in:  ','O');
                                  c(15,2,1);
                                  For lcv := 10 downto 0 do
                                       Begin
                                            GotoXY(53,12);
                                            Write(lcv,' ');
                                            Sound(900);
                                            Delay(500);
                                            NoSound;
                                            Delay(500);
                                       End;
                                  For lcv := 1 to 4 do
                                       Begin
                                            Sound(900);
                                            Delay(500);
                                            NoSound;
                                            Delay(20);
                                       End;
                                  Assign(FC, CCFile);
                                  ReSet(FC);
                                  CC := TRUE;
                             End;
                   End;
         End;
{////////////////////////////////////////////////////////////////}
  Procedure NewList(var List:Group; var DataFile:ST20; var cntr:Integer; var change:Boolean);
       Var                   {starts a new list}
            lcv: Integer;
            ans: ST1;
       Begin
            skip(1);
            If change = TRUE then
                 Begin
                    Box(19,11,42,'Your data has changed since your last save','B');
                    Box(19,12,42,'Do you want to save?  ','E');
                    GotoXY(43,13);
                    c(15,2,1);
                    answer1(ans, WhereX, WhereY); {ReadLn(ans);}
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, REG, CC);
                 End;
            Box(0,11,45,'Are you sure you want to start a new list?  ','O');
            c(15,2,1);
            If CC then ans := 'Y'
                 Else answer1(ans, WhereX, WhereY); {ReadLn(ans);}
            If (ans = 'Y') or (ans = 'y') then
                   For lcv := 1 to max do
                        Begin
(*                             List[lcv].name := '';
                             List[lcv].colors := '';
                             List[lcv].ctype := '';
                             List[lcv].Off := '';
                             List[lcv].Deff := '';
                             List[lcv].texts := '';*)
                             cntr := 0;
                             change := FALSE;
                             DataFile := '';
                        End;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure EditName(Var List:Group; cntr:Integer; Var change:Boolean);
       Var
            name: ST26;
            loc : Integer;
{////////////////////////////////////////////////////////}
    Procedure EditMenu(Var List:Group; loc:Integer; Var change:Boolean);
         Var
              sel: Char;
              lcv: Integer;
{////////////////////////////////////////////////}
      Procedure ChName(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(14,11,51,'Enter in the rock name:  ','O');
                GotoXY(41,12);
                c(15,2,1);
                answer20(List[loc].name, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChColor(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(2,16,27,'KEY:','B');
                Box(2,17,27,'A = Artifact    R = Red','C');
                Box(2,18,27,'G = Green       B = Black','C');
                Box(2,19,27,'L = Blue        G = Gold','C');
                Box(2,20,27,'L = Land        W = White','E');
                Box(0,11,27,'Enter in the card code:  ','O');
                c(15,2,1);
(*                answer1(List[loc].colors, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChType(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(2,18,27,'KEY:','B');
                Box(2,19,27,'S = Summon      S = Spell','C');
                Box(2,20,27,'I = Instant     E = Enchant','E');
                Box(0,11,27,'Enter in the card type:  ','O');
                c(15,2,1);
(*                answer1(List[loc].ctype, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChOff(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,27,'Enter in offence power:  ','O');
                c(15,2,1);
(*                answer2(List[loc].Off, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChDeff(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,27,'Enter in defense power:  ','O');
                c(15,2,1);
(*                answer2(List[loc].Deff, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChTexts(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(1,11,76,'Enter in the card text discription:','B');
                Box(1,12,76,'','E');
                c(15,2,1);
                GotoXY(3,13);
(*                answer76(List[loc].texts, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChTexts2(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(1,11,76,'Enter in the card text discription:  (LINE 2);','B');
                Box(1,12,76,'','E');
                c(15,2,1);
                GotoXY(3,13);
(*                answer76(List[loc].texts2, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChPrice(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,40,'Enter in the price of the card:  $','O');
                c(15,2,1);
(*                answer6(List[loc].price, WhereX, WhereY);*)
                change := TRUE;
           End;
{////////////////////////////////////////////////}
         Begin
              Repeat
              BackDrop;
              c(9,1,4);
              GotoXY(33,1);
              Write('MINERAL MASTER');
              MenC(15,8,43,'N','Name          :','B');
              MenC(15,9,43,'C','Card Code     :','C');
              MenC(15,10,43,'T','Type          :','C');
              MenC(15,11,43,'O','Offence       :','C');
              MenC(15,12,43,'D','Deffence      :','C');
              MenC(15,13,43,'1','Text  (LINE 1):','C');
              MenC(15,14,43,'2','Text  (LINE 2):','C');
              MenC(15,15,43,'P','Price         :','E');
              With List[loc] do
                   Begin
                        GotoXY(39,9);
                        c(15,2,1);
                        Write(name);
(*                        GotoXY(39,10);
                        Write(colors);
                        GotoXY(39,11);
                        Write(ctype);
                        GotoXY(39,12);
                        Write(Off);
                        GotoXY(39,13);
                        Write(Deff);
                        GotoXY(39,14);
                        If Length(texts) > 26 then
                             Begin
                                  For lcv := 1 to 23 do
                                       Write(texts[lcv]);
                                  Write('...');
                             End
                          Else Write(texts);
                        GotoXY(39,15);
                        If Length(texts2) > 26 then
                             Begin
                                  For lcv := 1 to 23 do
                                       Write(texts2[lcv]);
                                  Write('...');
                             End
                          Else Write(texts2);
                        GotoXY(38,16);
                        Write('$');
                        Write(price);
                        GotoXY(1,1);*)
                   End;
              Repeat
                   Repeat
                        sel := ReadKey;
                   Until sel <> '';
                   sel := UpCase(sel);
                   Case sel of
                        'N': ChName(List, loc, change);
                        'C': ChColor(List, loc, change);
                        'T': ChType(List, loc, change);
                        'O': ChOff(List, loc, change);
                        'D': ChDeff(List, loc, change);
                        '1': ChTexts(List, loc, change);
                        '2': ChTexts2(List, loc, change);
                        'P': ChPrice(List, loc, change);
                   End;
(*                   If Ord(sel) = 059 then Help(2);*)
              Until (sel = 'N') or (sel = 'C') or (sel = 'T') or (sel = 'O') or
              (sel = 'D') or (sel = 'T') or (sel = '1') or (sel = '2') or
              (sel = 'P') or (Ord(sel) = 027) or (Ord(sel) = 059);
              Until Ord(sel) = 027;
         End;
{////////////////////////////////////////////////////////}
       Begin
            Box(12,11,56,'Enter in rock to edit:  ', 'O');
            GotoXY(38,12);
            c(15,2,1);
            answer26(name, WhereX, WhereY);
            If name <> '' then
            Begin
                 loc := BinFind(List, name, cntr);
                 If loc > 0 then
                      Begin
                           EditMenu(List, loc, change);
                      End
                 Else Begin
                           Box(21,11,47, '                           could not be found!!', 'O');
                           c(15,2,1);
                           GotoXY(23,12);
                           Write(name);
                           Sound(900);
                           Delay(500);
                           NoSound;
                           Delay(1500);
                      End;
            End;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          {If not REG then credit('','','SHARE WARE');}
          CC := FALSE;
          CCFile := '';
          cntr := 0;
          cntr2 := 0;
          change := FALSE;
          If REG then DataFile := ''
               Else DataFile := 'cards.dat';
          TextBackGround(0);
          ClrScr;
          Repeat
               If NOT REG then DataFile := 'cards.dat';
               SSed := False;
               {ClrScr;}
               TextBackground(0);
               BackDrop;
               c(9,1,4);
               GotoXY(33,1);
               Write('MINERAL MASTER');
               c(15,2,4);
               GotoXY(35, 1);
               Status(cntr, DataFile);
(*               MenC(24,8,25,'N','Start NEW card list', 'B');*)
               MenC(24,9,25,'A','Add rock', 'B');
               MenC(24,10,25,'E','Edit rock', 'C');
               MenC(24,11,25,'D','Delete rock', 'C');
               MenC(24,12,25,'F','Find rock', 'C');
               MenC(24,13,25,'P','Print rock list to screen', 'C');
(*               MenC(24,14,25,'S','Save card list to file', 'C');
               MenC(24,15,25,'L','Load card list from file', 'C');*)
               MenC(24,14,25,'Q','Quit', 'E');
               Repeat
                    If CC = TRUE then Read(FC, sel)
                    Else Repeat
(*                              Repeat
                              inc(cntr2, 1);
                              If cntr2 = 732000 then    {122000 = one minute}
                                   Begin
                                        SSed := TRUE;
                                        {SS;}
                                   End;
                              Until KeyPressed;*)
                              sel := ReadKey;
                         Until sel <> '';
               cntr2 := 0;
               sel := UpCase(sel);
               Case sel of
                    'A': AddName(List, cntr, change, CC);
                    'D': DeleteName(List, cntr, change, CC);
                    'F': NameFind(List, CC);
                    'P': PrintList(List, cntr, CC);
(*                    'S': Save(List, DataFile, cntr, change, REG, CC);
                    'L': Load(List, DataFile, cntr, change, REG, CC);*)
                    'Q': Quit(List, DataFile, cntr, change, REG, CC, sel);
(*                    'C': Begin
                              If not REG then
                                 Begin
                                   Box(0,11,52,'This option in not avaible in the Share Ware version','O');
                                   GotoXY(1,1);
                                   Sound(900);
                                   Delay(500);
                                   NoSound;
                                   Delay(3500);
                                 End
                              Else ConsoleControl(CCFile, CC, FC);
                         End;*)
(*                    'N': NewList(List, DataFile, cntr, change);*)
                    'E': Begin
                              If not REG then
                                 Begin
                                   Box(0,11,52,'This option in not avaible in the Share Ware version','O');
                                   GotoXY(1,1);
                                   Sound(900);
                                   Delay(500);
                                   NoSound;
                                   Delay(3500);
                                 End
                              Else EditName(List, cntr, change);
                         End;
               End;
               If Ord(sel) = 060 then More(cntr, DataFile);
               If Ord(sel) = 027 then
                    Quit(List, DataFile, cntr, change, REG, CC, sel);
               {If (Ord(sel) = 025) and (REG) then Pong_Game;}
(*               If Ord(sel) = 059 then Help(1);*)
               Until (sel = 'A') or (sel = 'D') or (sel = 'F') or (sel = 'P')
                     or (sel = 'S') or (sel = 'L') or (sel = 'Q') or
                     (sel = 'N') or (sel = 'E') or (Ord(sel) = 060) or
                     (sel = 'C') or (Ord(sel) = 027) or (Ord(sel) = 059) or
                     ((REG) and (Ord(sel) = 025)) or (SSed);
          Until (sel = 'Q') or (Ord(sel) = 027);
          If CC then Close(FC);
     End;
{////////////////////////////////////////////////////////////////////////}
Begin                     {main program}
     Intro;
     {CK_REG(REG);}
     REG := TRUE;
(*     If not REG then Give_Credit;*)
     If REG then max := 2  (*max := 110*)
          Else max := 15;
(*     InitArray(List);*)
     MainMenu(List, REG);
     c(7,0,8);
     ClrScr;
End.