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
     CRT, DOS, MENU, CREDITS, ANSWERS;

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
            ReadLn;
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
          credit('SOFTWARE ENGINEER', '', 'CHRIS SOHNS');
          credit('SOUND EFFECTS', 'by', 'CHRIS SOHNS');
          credit('PRODUCED', 'by', 'CHRIS SOHNS');
          credit('DIRECTED', 'by', 'CHRIS SOHNS');
          ClrScr;
          Delay(4000);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure MainMenu(var List:Group; var REG:Boolean);
     Var                             {Dysplays main menu}
          sel     : Char;
          cntr    : Integer;
          DataFile,
          CCFile  : ST20;
          change,
          CC       : Boolean;
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
                                Box(0,11,27,'Enter in offence power:  ','O');
                                c(15,2,1);
                                answer2(List[cntr].Off, WhereX, WhereY);
                                {ReadLn(List[cntr].Off);}
                                Box(0,11,27,'Enter in defense power:  ','O');
                                c(15,2,1);
                                answer2(List[cntr].Deff, WhereX, WhereY);
                                {ReadLn(List[cntr].Deff);}
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
                        While DataFile = '' do
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
                             End;
                   End;
              End;
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
                                  While DataFile = '' do
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
                                       End;
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
              While DataFile = '' do
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
                   End;
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
              loc, lcv, lcv2:Integer;
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
                                  ClrScr;
                                  c(15,2,1);
                                  Write(List[loc].name);
                                  GotoXY(24,1);
                                  c(13,2,1);
                                  Write(List[loc].colors);
                                  GotoXY(38,1);
                                  c(11,2,1);
                                  Write(List[loc].Deff);
                                  GotoXY(42,1);
                                  c(12,2,1);
                                  Write(List[loc].Off);
                                  GotoXY(46,1);
                                  c(14,2,1);
                                  Write('$');
                                  Write(List[loc].price);
                                  GotoXY(1,2);
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
                        ClrScr;
                        lcv2 := 0;
                        loc := BinFind(List, '', cntr);
                        For lcv := 1 to cntr do
                             Begin
                                  inc(lcv2, 1);
                                  c(15,2,1);
                                  Write(List[lcv].name,'  ');
                                  c(13,2,1);
                                  Write(List[lcv].colors,'  ');
                                  c(11,2,1);
                                  Write(List[lcv].Deff,'  ');
                                  c(12,2,1);
                                  Write(List[lcv].Off,'  ');
                                  c(14,2,1);
                                  Write('$');
                                  WriteLn(List[lcv].price);
                                  c(10,2,1);
                                  WriteLn(List[lcv].texts);
                                  WriteLn(List[lcv].texts2);
                                  c(15,2,1);
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
              Until (sel = 'N') or (sel = 'C') or (sel = 'O') or
              (sel = 'D') or (sel = 'T') or (sel = '1') or (sel = '2') or
              (sel = 'P') or (Ord(sel) = 027);
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
          change := FALSE;
          If REG then DataFile := ''
               Else DataFile := 'cards.dat';
          TextBackGround(0);
          ClrScr;
          Repeat
               {ClrScr;}
               TextBackground(0);
               BackDrop;
               c(15,2,4);
               GotoXY(35, 1);
               If not REG then Write('SHARE WARE');
               Status(cntr, DataFile);
               MenuCreator(25,8,24,'N','Start NEW card list', 'B');
               MenuCreator(25,9,24,'A','Add card', 'C');
               MenuCreator(25,10,24,'E','Edit card', 'C');
               MenuCreator(25,11,24,'D','Delete card', 'C');
               MenuCreator(25,12,24,'F','Find card', 'C');
               MenuCreator(25,13,24,'P','Print card list', 'C');
               MenuCreator(25,14,24,'S','Save card list to file', 'C');
               MenuCreator(25,15,24,'L','Load card list from file', 'C');
               MenuCreator(25,16,24,'Q','Quit', 'E');
               Repeat
                    If CC = TRUE then Read(FC, sel)
                    Else Repeat
                              sel := ReadKey;
                         Until sel <> '';
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
               {If Ord(sel) = 059 then Help(1);}
               Until (sel = 'A') or (sel = 'D') or (sel = 'F') or (sel = 'P')
                     or (sel = 'S') or (sel = 'L') or (sel = 'Q') or
                     (sel = 'N') or (sel = 'E') or (Ord(sel) = 060) or
                     (sel = 'C');
          Until sel = 'Q';
          If CC then Close(FC);
     End;
{////////////////////////////////////////////////////////////////////////}
Begin                     {main program}
     CK_REG(REG);
     If REG then max := 310
          Else max := 15;
     InitArray(List);
     MainMenu(List, REG);
     If not REG then Give_Credit;
     ClrScr;
End.