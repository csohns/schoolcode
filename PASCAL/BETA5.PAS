{.}
                                                                 {Chris Sohns}
                                                                     {MdBASES}
                                                                    {11/20/95}
                     {This program is a name data base. }
                     {It can store up to 1000 names.  It}
                     {can add, delete, find, print, save}
                     {load name to/from a file.         }


Program MAGdBASE;

USES
     CRT, DOS, MENU, CREDITS, ANSWERS, PONG, SCRSAV;

CONST
     recmax = 310;
     STR = 26;

TYPE
     CardStats = record
                      name  : ST26;
                      colors: ST1;
                      Off,
                      Deff  : ST2;
                      texts,
                      texts2 : ST76;
                      price : ST6;
                End;
     StringValue = String[STR];
     Group = Array[1..recmax] of CardStats;

VAR
     List: Group;
     cntr,
     max: Integer;
     REG : Boolean;



{////////////////////////////////////////////////////////////////////////}
Procedure CK_REG(var REG:Boolean);
     Type
          CodeRec = record
                         USER_NAME: ST40;
                         USER_COMPANY: ST60;
                         PASSWORD: ST17;
                         EncNum: Integer;
                         YEAR,
                         MONTH,
                         DAY: Word;
                    End;
     Var
          cstr: ST17;
          Stats: CodeRec;
          num,
          j,
          lcv, temp: Integer;
          F: File of CodeRec;
          y,m,d,dow: Word;
{////////////////////////////////////////////////////////////////}
  Procedure RegForm(code: Integer);
       Var
            lcv: Integer;
       Begin
            If code = 0 then
                 Begin
                      WriteLn('You have 2 months left to register this program');
                      WriteLn;
                 End;
            If code = 1 then
                 Begin
                      WriteLn('You have 1 month left to register this program');
                      WriteLn;
                 End;
            If code = 2 then
                 Begin
                      WriteLn('You have 0 months left to register this program');
                      WriteLn;
                      WriteLn('This program has been disabled until registered...');
                 End;
            WriteLn('This program is shareware, you have a 2 month trial run.');
            WriteLn('Once the 2 months are up, if you decide not to register,');
            WriteLn('please delete this program from your hard drive.');
            For lcv := 1 to 18 do
                 WriteLn;
            Delay(8000);
            If code = 2 then halt;
            ClrScr;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          GetDate(y,m,d,dow);
          Stats.USER_NAME := '';
          Stats.USER_COMPANY := '';
          Stats.PASSWORD := '30676';
          Stats.EncNum := 0;
          Stats.YEAR := y;
          Stats.MONTH := m;
          Stats.DAY := d;
          Assign(F, 'MAGDBASE.DAT');
          {$I-}
          ReSet(F);
          If IOResult <> 0 then
               Begin
                    ReWrite(F);
                    Write(F, Stats);
                    Close(F);
               End;
          {$I+}
          ReSet(F);
          Read(F, Stats);
          Close(F);
          cstr := '';
          For lcv := 1 to Length(Stats.PASSWORD) do
               Begin
                    j := Ord(Stats.PASSWORD[lcv]);
                    j := j - (Stats.EncNum );
                    {If j < 0 then
                         Begin
                              temp := j + 256;
                              j := 256;
                              dec(j, temp);
                         End;}
                    cstr := cstr + CHR(j);
               End;
          IF cstr = 'f’c…QQXY„†ˆjkŒ“„' then REG := TRUE
                         Else REG := FALSE;
          If NOT REG then
               Begin
                    GetDate(y,m,d,dow);
                    If (Stats.MONTH = (m)) then
                         RegForm(0);
                    If (Stats.MONTH = (m + 1)) then
                         RegForm(2);
                    If (Stats.MONTH > (m + 1)) then
                         RegForm(3);
               End;
          If REG then
               Begin
                    If Length(Stats.USER_NAME) < Length(Stats.USER_COMPANY) then
                         num := Length(Stats.USER_COMPANY)
                    Else num := Length(Stats.USER_NAME);
                    If num < 33 then num := 33;
                    ClrScr;
                    j := (40 - Trunc(num div 2)) - 2;
                    Box(j,10,num,'','B');
                    Box(j,11,num,'','C');
                    Box(j,12,num,'','C');
                    Box(j,13,num,'','E');
                    c(15,2,1);
                    j := 40 - Trunc(30 div 2);
                    GotoXY(j,11);
                    Write('This program is registered to:');
                    j := 40 - Trunc(Length(Stats.USER_NAME) div 2);
                    GotoXY(j,12);
                    Write(Stats.USER_NAME);
                    j := 40 - Trunc(2 div 2);
                    GotoXY(j,13);
                    Write('of');
                    j := 40 - Trunc(Length(Stats.USER_COMPANY) div 2);
                    GotoXY(j,14);
                    Write(Stats.USER_COMPANY);
                    GotoXY(1,1);
                    Delay(4000);
                    ClrScr;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure InitArray(var List: Group);  {Set all array com-}
     Var                               {ponents to 0}
          lcv: Integer;

     Begin
          For lcv := 1 to max do
               Begin
                    List[lcv].name := '';
                    List[lcv].colors := '';
                    List[lcv].Off := '';
                    List[lcv].Deff := '';
                    List[lcv].texts := '';
                    List[lcv].texts2 := '';
                    List[lcv].price := '';
               End;
     End; {InitArray}
{////////////////////////////////////////////////////////////////////////}
Procedure Give_Credit;
     Begin
          TextBackGround(0);
          ClrScr;
          Delay(2000);
          credit('DESIGN', 'by', 'CHRIS SOHNS');
          credit('SOFTWARE ENGINEERS', '', 'CHRIS SOHNS');
          credit('SOFTWARE ENGINEERS', '', 'DAN SULLIVAN');
          credit('SOUND EFFECTS', 'by', 'CHRIS SOHNS');
          credit('PRODUCED', 'by', 'CHRIS SOHNS');
          credit('DIRECTED', 'by', 'CHRIS SOHNS');
          credit('TESTED', 'by', 'Peter Hays');
          credit('TESTED', 'by', 'Ryan Riley');
          credit('TESTED', 'by', 'Matt Huber');
          ClrScr;
          Delay(4000);
     End;
{////////////////////////////////////////////////////////////////////////}
  Procedure Help(HelpType: Integer);
       Var
            lcv, page: Integer;
            sel: Char;
{////////////////////////////////////////////////////////}
    Procedure Blank;
         Var
              lcv, lcv2: Integer;
         Begin
              GotoXY(16,5);
              c(15,2,3);
              For lcv := 5 to 19 do
                   Begin
                        For lcv2 := 2 to 49 do
                             Write(' ');
                        GotoXY(16, WhereY + 1);
                   End;
              GotoXY(1,1);
              c(15,2,1);
         End;
{////////////////////////////////////////////////////////}
    Procedure H1(var page:Integer);
{////////////////////////////////////////////////}
      Procedure H11;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü The Main Menu                      Page 1/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßß');  GotoXY(17,8);
                Write('The Main Menu is where you can select to:');  GotoXY(17,10);
                Write(' þ Add cards');  GotoXY(17,11);
                Write(' þ Delete cards');  GotoXY(17,12);
                Write(' þ Find cards');  GotoXY(17,13);
                Write(' þ Edit cards');  GotoXY(17,14);
                Write(' þ Print the list of cards to your screen');  GotoXY(17,15);
                Write(' þ Load cards from a disk file');  GotoXY(17,16);
                Write(' þ Save cards to a disk file');  GotoXY(17,17);
                Write(' þ Start a NEW card list');  GotoXY(17,19);
                Write('And you can also Quit the program all together.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H12;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Add Cards to List                  Page 2/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you add a card to the list, you must');  GotoXY(17,10);
                Write('enter in at least the name of the card.');  GotoXY(17,11);
                Write('Then you may enter in the card type,');  GotoXY(17,12);
                Write('power, strength, and the price of the card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H13;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Delete Cards from List             Page 3/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When wish to delete a card from the list,');  GotoXY(17,10);
                Write('you must enter in the name of the card');  GotoXY(17,11);
                Write('correctly.  Then the card is erased.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H14;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Find a Card in the List            Page 4/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you try to find a card in the list,');  GotoXY(17,10);
                Write('you will be asked to enter in the card''s name.');  GotoXY(17,11);
                Write('If you enter in the name CORRECTLY, CAPS AND');  GotoXY(17,12);
                Write('ALL, you will be told if the card is in the');  GotoXY(17,13);
                Write('data base.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H15;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Edit Cards                         Page 5/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('With this option you are able to change');  GotoXY(17,10);
                Write('any aspect of a card that have you entered');  GotoXY(17,11);
                Write('incorrectly when you first entered it.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H16;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Print Cards                        Page 6/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you choose this option you are asked');  GotoXY(17,10);
                Write('if you want to view 1 specified card or the');  GotoXY(17,11);
                Write('whole list of cards that have been entered in.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H17;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Save Card List                     Page 7/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('You can save your card list to a file on disk.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H18;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Load Card List                     Page 8/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('You can load your card list from a file');  GotoXY(17,10);
                Write('on disk.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H19;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Quit                               Page 9/9');  GotoXY(17,7);
                Write(' ßßßßßßß');  GotoXY(17,9);
                Write('Self-explanatory.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
         Begin
              If page < 1 then page := 0;
              If page > 9 then page := 10;
              Case page of
                   1: H11;
                   2: H12;
                   3: H13;
                   4: H14;
                   5: H15;
                   6: H16;
                   7: H17;
                   8: H18;
                   9: H19;
              End;
              If page = 0 then page := 1;
              If page = 10 then page := 9;
         End;
{////////////////////////////////////////////////////////}
    Procedure H2(var page:Integer);
{////////////////////////////////////////////////}
      Procedure H21;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü The Edit Menu                      Page 1/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßß');  GotoXY(17,8);
                Write('The Edit Menu is where you can select to:');  GotoXY(17,10);
                Write(' þ Change Card Name');  GotoXY(17,11);
                Write(' þ Change Card Type');  GotoXY(17,12);
                Write(' þ Change Power');  GotoXY(17,13);
                Write(' þ Change Strength');  GotoXY(17,14);
                Write(' þ Change Card Text  (LINE1)');  GotoXY(17,15);
                Write(' þ Change Card Text  (LINE2)');  GotoXY(17,16);
                Write(' þ Change Card Price');  GotoXY(17,18);
                Write('To EXIT the Edit Menu just press Escape.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H22;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Name                   Page 2/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current name of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H23;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Type                   Page 3/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current type of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H24;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Power                  Page 4/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current power of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H25;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Strength               Page 5/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current strength of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H26;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Text  (LINE1)               Page 6/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current 1st line of the');  GotoXY(17,10);
                Write('text of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H27;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Text  (LINE2)               Page 7/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current 2nd line of the');  GotoXY(17,10);
                Write('text of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H28;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Price                  Page 8/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current price of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
         Begin
              If page < 1 then page := 0;
              If page > 8 then page := 10;
              Case page of
                   1: H21;
                   2: H22;
                   3: H23;
                   4: H24;
                   5: H25;
                   6: H26;
                   7: H27;
                   8: H28;
              End;
              If page = 0 then page := 1;
              If page = 10 then page := 8;
         End;
{////////////////////////////////////////////////////////}
       Begin
            page := 1;
            GotoXY(15,4);
            c(15,2,3);
            WriteLn('ÉÍ[þ]ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
            For lcv := 2 to 16 do
                 Begin
                      c(15,2,3);
                      GotoXY(15,WhereY);
                      Write('º                                                º');
                      c(8,2,0);
                      WriteLn('±±');
                 End;
            GotoXY(15, WhereY);
            c(15,2,3);
            Write('ÈÍESCÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍPgUpÍÍÍÍÍPgDownÍ¼');
            c(8,2,0);
            WriteLn('±±');
            GotoXY(17,WhereY);
            WriteLn('±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±');
            GotoXY(1,1);
            Repeat
                 If HelpType = 1 then H1(page);
                 If HelpType = 2 then H2(page);
                 Repeat
                      sel := ReadKey;
                 Until sel <> '';
                 Case Ord(sel) of
                      073: dec(page, 1);
                      081: inc(page, 1);
                 End;
            Until Ord(sel) = 027;
       End;
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
       Var                          {adds names to list}
            {name: StringValue;}
            name: ST26;
       Begin
            If cntr < max then
                 Begin
                      Box(14,11,51,'Enter in new card name:  ','O');
                      GotoXY(41,12);
                      c(15,2,1);
                      If CC then
                           Begin
                                skipchar;
                                ReadLn(FC, name);
                                Write(name);
                           End
                      Else answer26(name, WhereX, WhereY);
                      {ReadLn(name);}
                      If name <> '' then
                           Begin
                                inc(cntr, 1);
                                change := TRUE;
                                Box(2,15,27,'KEY:','B');
                                Box(2,16,27,'A = Artifact    R = Red','C');
                                Box(2,17,27,'G = Green       B = Black','C');
                                Box(2,18,27,'L = Blue        G = Gold','C');
                                Box(2,19,27,'W = White       S = Spells','C');
                                Box(2,20,27,'I = Instant     E = Enchant','E');
                                Box(0,11,27,'Enter in the card code:  ','O');
                                c(15,2,1);
                                answer1(List[cntr].colors, WhereX, WhereY);
                                {ReadLn(List[cntr].colors);}
                                With List[cntr] do
                                     Begin
                                     If (colors <> 'i') and (colors <> 'I')
                                          and (colors <> 's') and (colors <> 'S')
                                          {and (colors <> 'a') and (colors <> 'A')}
                                          and (colors <> 'e') and (colors <> 'E')
                                     then
                                     Begin
                                          Box(0,11,27,'Enter in offense power:  ','O');
                                          c(15,2,1);
                                          answer2(List[cntr].Off, WhereX, WhereY);
                                          {ReadLn(List[cntr].Off);}
                                     End;
                                     If (colors <> 'i') and (colors <> 'I')
                                          and (colors <> 's') and (colors <> 'S')
                                          {and (colors <> 'a') and (colors <> 'A')}
                                          and (colors <> 'e') and (colors <> 'E')
                                     then
                                     Begin
                                          Box(0,11,27,'Enter in defense power:  ','O');
                                          c(15,2,1);
                                          answer2(List[cntr].Deff, WhereX, WhereY);
                                          {ReadLn(List[cntr].Deff);}
                                     End;
                                End;
                                Box(1,11,76,'Enter in the card text discription:','B');
                                Box(1,12,76,'','E');
                                c(15,2,1);
                                GotoXY(3,13);
                                answer76(List[cntr].texts, WhereX, WhereY);
                                {ReadLn(List[cntr].texts);}
                                If Length(List[cntr].texts) > 70 then
                                     Begin
                                          Box(1,11,76,'Enter in the card text discription:  (LINE 2);','B');
                                          Box(1,12,76,'','E');
                                          c(15,2,1);
                                          GotoXY(3,13);
                                          answer76(List[cntr].texts2, WhereX, WhereY);
                                          {ReadLn(List[cntr].texts2);}
                                     End;
                                Box(0,11,40,'Enter in the price of the card:  $','O');
                                c(15,2,1);
                                answer6(List[cntr].price, WhereX, WhereY);
                                {ReadLn(List[cntr].price);}
                                List[cntr].name := name;
                           End;
                 End
            Else Begin
                      Box(24,11,31,'A      name limit has been set', 'O');
                      GotoXY(28, 12);
                      Write(max);
                      Sound(900);
                      Delay(500);
                      NoSound;
                      Delay(1500);
                 End;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure DeleteName(var List:Group; var cntr:Integer; var change, CC:Boolean);
       Var                          {deletes names from list}
            name: ST26;
            loc,
            lcv : Integer;
       Begin
            Box(18,11,52,'Enter in card to delete:  ', 'O');
            c(15,2,1);
            GotoXY(46,12);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else answer26(name, WhereX, WhereY); {ReadLn(name);}
            If name <> '' then
                 Begin
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
            name: ST26;
            loc : Integer;
       Begin
            Box(11,11,56,'Enter in card to search for:  ', 'O');
            GotoXY(43,12);
            c(15,2,1);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else answer26(name, WhereX, WhereY); {ReadLn(name);}
            If name <> '' then
            Begin
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
                                  c(7,2,1);
                                  GotoXY(15,24);
                                  Write(cntr);
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
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, REG, CC);
               End;
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
{////////////////////////////////////////////////////////}
        Procedure Header;
             Begin
                  ClrScr;
                  GotoXY(1,1);
                  c(15,2,1);
                  WriteLn('           NAME             TYPE  OFFENSE / DEFENSE   PRICE');
                  WriteLn('--------------------------  ----  -------   -------  -------');
             End;
{////////////////////////////////////////////////////////}
         Begin
              Box(17,11,45,'Do you want to print a certian card (N,y):  ','O');
              GotoXY(63,12);
              c(15,2,1);
              If CC then
                   ans := 'N'
              Else answer1(ans, WhereX, WhereY); {ReadLn(ans);}
              If (ans = 'Y') or (ans = 'y') then
                   Begin
                        Repeat
                             Box(15,11,59,'What card do you want to print:  ','O');
                             GotoXY(50,12);
                             c(15,2,1);
                             answer26(name, WhereX, WhereY); {ReadLn(name);}
                        Until name <> '';
                        loc := BinFind(List, name, cntr);
                        If loc > 0 then
                             Begin
                                  Header;
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
                                  GotoXY(1,4);
                                  c(10,2,1);
                                  WriteLn(List[loc].texts);
                                  Write(List[loc].texts2);
                                  c(15,2,1);
                                  skip(20);
                                  Write('Press [ENTER] to continue. . .');
                                  ReadLn;
                                  TextBackGround(0);
                                  ClrScr;
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
                                  c(13,2,1);
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
                                  WriteLn(List[lcv].price);
                                  GotoXY(1,cnrt + 1);
                                  c(10,2,1);
                                  WriteLn(List[lcv].texts);
                                  WriteLn(List[lcv].texts2);
                                  c(15,2,1);
                                  inc(cnrt, 3);
                                  If lcv2 = 8 then
                                       Begin
                                            lcv2 := 0;
                                            Write('Press [ENTER] to continue. . .');
                                            ReadLn;
                                       End;
                             End;
                        Write('Press [ENTER] to continue. . .');
                        ReadLn;
                        TextBackGround(0);
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
                             List[lcv].name := '';
                             List[lcv].colors := '';
                             List[lcv].Off := '';
                             List[lcv].Deff := '';
                             List[lcv].texts := '';
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
                Box(14,11,51,'Enter in the card name:  ','O');
                GotoXY(41,12);
                c(15,2,1);
                answer26(List[loc].name, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChColor(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(2,15,27,'KEY:','B');
                Box(2,16,27,'A = Artifact    R = Red','C');
                Box(2,17,27,'G = Green       B = Black','C');
                Box(2,18,27,'L = Blue        G = Gold','C');
                Box(2,19,27,'W = White       S = Spells','C');
                Box(2,20,27,'I = Instant     E = Enchant','E');
                Box(0,11,27,'Enter in the card code:  ','O');
                c(15,2,1);
                answer1(List[loc].colors, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChOff(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,27,'Enter in offence power:  ','O');
                c(15,2,1);
                answer2(List[loc].Off, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChDeff(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,27,'Enter in defense power:  ','O');
                c(15,2,1);
                answer2(List[loc].Deff, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChTexts(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(1,11,76,'Enter in the card text discription:','B');
                Box(1,12,76,'','E');
                c(15,2,1);
                GotoXY(3,13);
                answer76(List[loc].texts, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChTexts2(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(1,11,76,'Enter in the card text discription:  (LINE 2);','B');
                Box(1,12,76,'','E');
                c(15,2,1);
                GotoXY(3,13);
                answer76(List[loc].texts2, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
      Procedure ChPrice(Var List:Group; loc:Integer; Var change:Boolean);
           Begin
                Box(0,11,40,'Enter in the price of the card:  $','O');
                c(15,2,1);
                answer6(List[loc].price, WhereX, WhereY);
                change := TRUE;
           End;
{////////////////////////////////////////////////}
         Begin
              Repeat
              BackDrop;
              MenuCreator(15,9,43,'N','Name          :','B');
              MenuCreator(15,10,43,'C','Card Code     :','C');
              MenuCreator(15,11,43,'O','Offence       :','C');
              MenuCreator(15,12,43,'D','Deffence      :','C');
              MenuCreator(15,13,43,'1','Text  (LINE 1):','C');
              MenuCreator(15,14,43,'2','Text  (LINE 2):','C');
              MenuCreator(15,15,43,'P','Price         :','E');
              With List[loc] do
                   Begin
                        GotoXY(39,10);
                        c(15,2,1);
                        Write(name);
                        GotoXY(39,11);
                        Write(colors);
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
                        GotoXY(1,1);
                   End;
              Repeat
                   Repeat
                        sel := ReadKey;
                   Until sel <> '';
                   sel := UpCase(sel);
                   Case sel of
                        'N': ChName(List, loc, change);
                        'C': ChColor(List, loc, change);
                        'O': ChOff(List, loc, change);
                        'D': ChDeff(List, loc, change);
                        '1': ChTexts(List, loc, change);
                        '2': ChTexts2(List, loc, change);
                        'P': ChPrice(List, loc, change);
                   End;
                   If Ord(sel) = 059 then Help(2);
              Until (sel = 'N') or (sel = 'C') or (sel = 'O') or
              (sel = 'D') or (sel = 'T') or (sel = '1') or (sel = '2') or
              (sel = 'P') or (Ord(sel) = 027) or (Ord(sel) = 059);
              Until Ord(sel) = 027;
         End;
{////////////////////////////////////////////////////////}
       Begin
            Box(12,11,56,'Enter in card to edit:  ', 'O');
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
          If not REG then credit('','','SHARE WARE');
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
               c(15,2,4);
               GotoXY(35, 1);
               If not REG then Write('SHARE WARE');
               Status(cntr, DataFile);
               MenuCreator(24,8,25,'N','Start NEW card list', 'B');
               MenuCreator(24,9,25,'A','Add card', 'C');
               MenuCreator(24,10,25,'E','Edit card', 'C');
               MenuCreator(24,11,25,'D','Delete card', 'C');
               MenuCreator(24,12,25,'F','Find card', 'C');
               MenuCreator(24,13,25,'P','Print card list to screen', 'C');
               MenuCreator(24,14,25,'S','Save card list to file', 'C');
               MenuCreator(24,15,25,'L','Load card list from file', 'C');
               MenuCreator(24,16,25,'Q','Quit', 'E');
               Repeat
                    If CC = TRUE then Read(FC, sel)
                    Else Repeat
                              Repeat
                              inc(cntr2, 1);
                              If cntr2 = 732000 then    {122000 = one minute}
                                   Begin
                                        SSed := TRUE;
                                        SS;
                                   End;
                              Until KeyPressed;
                              sel := ReadKey;
                         Until sel <> '';
               cntr2 := 0;
               sel := UpCase(sel);
               Case sel of
                    'A': AddName(List, cntr, change, CC);
                    'D': DeleteName(List, cntr, change, CC);
                    'F': NameFind(List, CC);
                    'P': PrintList(List, cntr, CC);
                    'S': Save(List, DataFile, cntr, change, REG, CC);
                    'L': Load(List, DataFile, cntr, change, REG, CC);
                    'Q': Quit(List, DataFile, cntr, change, REG, CC, sel);
                    'C': Begin
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
                         End;
                    'N': NewList(List, DataFile, cntr, change);
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
               If (Ord(sel) = 025) and (REG) then Pong_Game;
               If Ord(sel) = 059 then Help(1);
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
     CK_REG(REG);
     If not REG then Give_Credit;
     If REG then max := 310
          Else max := 15;
     InitArray(List);
     MainMenu(List, REG);
     c(7,0,8);
     ClrScr;
End.