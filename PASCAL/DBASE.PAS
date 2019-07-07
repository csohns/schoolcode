{.}
                                                                 {Chris Sohns}
                                                                       {dBASE}
                                                           {11/20/95-11/28/95}
                     {This program is a name data base. }
                     {It can store up to 1000 names.  It}
                     {can add, delete, find, print, save}
                     {load name to/from a file.         }


Program dBASE;

USES
     CRT, DOS;

CONST
     max = 1000;
     STR = 16;

TYPE
     StringValue = String[STR];
     MenuString = String[29];
     Group = Array[1..max] of StringValue;

VAR
     List: Group;
     cntr: Integer;



{////////////////////////////////////////////////////////////////////////}
Procedure InitArray(var List: Group);  {Set all array com-}
     Var                               {ponents to 0}
          lcv: Integer;

     Begin
          For lcv := 1 to max do
               List[lcv] := '';
     End; {InitArray}
{////////////////////////////////////////////////////////////////////////}
Procedure Intro;
     Var
          lcv: Integer;
{////////////////////////////////////////////////////////////////}
  Procedure TC(col, bk:Integer);
       Begin
            HighVideo;
            TextColor(col);
            TextBackground(bk);
       End;
{////////////////////////////////////////////////////////////////}
  Procedure s1;
       Begin
            Sound(125);
            Delay(350);
            NoSound;
       End;
{////////////////////////////////////////////////////////////////}
  Procedure s2;
       Begin
            Sound(100);
            Delay(350);
            NoSound;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          tc(7,0);
          ClrScr;
          Sound(200);
          Delay(1500);
          NoSound;
          Sound(300);
          Delay(1500);
          NoSound;
          Sound(400);
          Delay(1500);
          NoSound;
          Sound(498);
          Delay(400);
          NoSound;
          Sound(475);
          Delay(1500);
          NoSound;
          For lcv := 1 to 16 do
               Begin
                    Case lcv of
                         1: Begin
                                 tc(14, 1);
                                 GotoXY(27,25);
                                 Write('ษอออออออออออออออออออออออออป');
                                 tc(7,0);
                                 s1;
                                 WriteLn;
                            End;
                         2: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ                         บ');
                                 GotoXY(29,25);
                                 tc(28,1);
                                 Write('Illegal');
                                 tc(10,1);
                                 GotoXY(38,25);
                                 Write('Clone of dBase');
                                 GotoXY(54,25);
                                 tc(7,0);
                                 s2;
                                 WriteLn;
                            End;
                   3, 5, 7: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ                         บ');
                                 tc(7,0);
                                 s1;
                                 WriteLn;
                            End;
                         4: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ                         บ');
                                 GotoXY(40,25);
                                 tc(13,1);
                                 Write('by');
                                 GotoXY(54,25);
                                 tc(7,0);
                                 s2;
                                 WriteLn;
                            End;
                         6: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ       Chris  Sohns      บ');
                                 GotoXY(35,25);
                                 tc(15,1);
                                 Write('Chris  Sohns');
                                 GotoXY(54,25);
                                 tc(7,0);
                                 s2;
                                 WriteLn;
                            End;
                         8: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ                         บ');
                                 GotoXY(32,25);
                                 tc(11,1);
                                 Write('Intro designed by');
                                 GotoXY(54,25);
                                 tc(7,0);
                                 s2;
                                 WriteLn;
                            End;
                         9: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('บ                         บ');
                                 GotoXY(36,25);
                                 tc(31,1);
                                 Write('J.J. Gauch');
                                 GotoXY(54,25);
                                 tc(7,0);
                                 s1;
                                 WriteLn;
                            End;
                        10: Begin
                                 tc(14,1);
                                 GotoXY(27,25);
                                 Write('ศอออออออออออออออออออออออออผ');
                                 tc(7,0);
                                 s2;
                                 WriteLn;
                            End;
                    11..16: Begin
                                 If (lcv = 11) or (lcv = 13) or (lcv = 15)
                                      then s1
                                 Else s2;
                                 WriteLn;
                            End;

                    End;
               End;
          GotoXY(1,1);
          Sound(200);
          Delay(1500);
          NoSound;
          Sound(300);
          Delay(1500);
          NoSound;
          Sound(400);
          Delay(1500);
          NoSound;
          Sound(498);
          Delay(400);
          NoSound;
          Sound(475);
          Delay(1500);
          NoSound;
          Delay(4000);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure Menu(var List:Group);
     Var                             {Dysplays main menu}
          sel     : Char;
          cntr    : Integer;
          DataFile,
          CCFile  : String;
          change,
          CC      : Boolean;
          FC      : Text;
{////////////////////////////////////////////////////////////////}
    Procedure c(col, int: Integer);
         Begin                      {Changes text color}
              Case col of
                   1: TextColor(1);
                   2: TextColor(2);
                   3: TextColor(3);
                   4: TextColor(4);
                   5: TextColor(5);
                   6: TextColor(6);
                   7: TextColor(7);
                   8: TextColor(8);
                   14: TextColor(14);
              End;
              Case int of
                   0: NormVideo;
                   1: LowVideo;
                   2: HighVideo;
              End;
         End;
{////////////////////////////////////////////////////////////////}
    Procedure BackDrop;
         Var                        {Creates menu background}
              lcv, chk: Integer;
              temp: Char;
              tamper: Boolean;
              tamper_check1, control1: String[5];
              tamper_check2, control2: String[7];
         Begin
              tamper := FALSE;
              control1 := 'Force';
              control2 := 'Command';
              tamper_check1 := 'Luxik';
              tamper_check2 := 'O{yymzp';
              For lcv := 1 to 5 do
                   Begin
                        chk := Ord(tamper_check1[lcv]);
                        dec(chk, 6);
                        temp := Chr(chk);
                        tamper_check1[lcv] := temp;
                   End;
              For lcv := 1 to 7 do
                   Begin
                        chk := Ord(tamper_check2[lcv]);
                        dec(chk, 12);
                        temp := Chr(chk);
                        tamper_check2[lcv] := temp;
                   End;
              If (tamper_check1 <> control1) or (tamper_check2 <> control2)
                   then tamper := TRUE;
              If tamper then
                   Begin
                        ClrScr;
                        c(7,1);
                        TextBackground(0);
                        WriteLn('dBASE.EXE has been tampered with. . .Program halted');
                        halt;
                   End;
              GotoXY(1,1);
              c(14,2);
              TextBackground(1);
              WriteLn('ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป');
              For lcv := 2 to 22 do
                Begin
                   GotoXY(1, lcv);
                   c(14,2);
                   Write('บ');
                   c(3,2);
                   Write('ฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐฐ');
                   c(14,2);
                   Write('บ');
                End;
              Write('ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ');
              c(7,2);
              Write(control1);
              c(14,2);
              Write('อ');
              c(7,2);
              Write(control2);
              c(14,2);
              Write('ผ');
              If CC = TRUE then
                   Begin
                        c(7,2);
                        TextBackground(4);
                        GotoXY(34,1);
                        Write('FILE CONTROL');
                   End;
              TextBackground(0);
         End;
{////////////////////////////////////////////////////////////////}
    Procedure MenuCreator(X, Y:Integer; sel:Char; texts:MenuString; MenVar:Char);
{////////////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Begin                      {Creates menus}
              If (MenVar = 'B') or (MenVar = 'O') then
                   Begin
                        GotoXY(X, Y);
                        c(14, 2);
                        TextBackGround(1);
                        WriteLn('ษอออออออออออออออออออออออออออออออป');
                   End;
              GotoXY(X, Y + 1);
              TextBackGround(1);
              c(14,2);
              Write('บ ');
              c(2,2);
              Write('<');
              c(4,2);
              Write(sel);
              c(2,2);
              Write('>  ');
              c(7,2);
              Write(texts);
              spa(24 - Length(texts));
              c(14,2);
              GotoXY(X + 31, Y + 1);
              Write(' บ');
              If (MenVar = 'E') or (MenVar = 'O') then
                   Begin
                        GotoXY(X, Y + 2);
                        c(14, 2);
                        TextBackGround(1);
                        WriteLn('ศอออออออออออออออออออออออออออออออผ');
                        GotoXY(1,1);
                   End;
              TextBackGround(0);
              c(7,1);
         End;
{////////////////////////////////////////////////////////////////}
    Procedure Box(X, Y, long:Integer; texts:String; BoxVar:Char);
{////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Var                        {Creates text boxes}
              lcv: Integer;
         Begin
              If (BoxVar = 'B') or (BoxVar = 'O') then
              Begin
                   GotoXY(X, Y);
                   c(14,2);
                   TextBackground(1);
                   Write('ษ');
                   For lcv := 1 to long + 2 do
                        Write('อ');
                   WriteLn('ป');
              End;
              GotoXY(X, Y + 1);
              TextBackGround(1);
              c(14,2);
              Write('บ ');
              c(7,2);
              Write(texts);
              spa(long - Length(texts));
              c(14,2);
              GotoXY(X + (long + 2), Y + 1);
              Write(' บ');
              If (BoxVar = 'E') or (BoxVar = 'O') then
              Begin
                   GotoXY(X, Y + 2);
                   c(14, 2);
                   TextBackGround(1);
                   Write('ศ');
                   For lcv := 1 to long + 2 do
                        Write('อ');
                   WriteLn('ผ');
              End;
              c(7,2);
         End;
{////////////////////////////////////////////////////////////////}
  Procedure Status(cntr:Integer; DataFile:String);
       Begin                        {Dysplays number of records and file name}
            If DataFile = '' then DataFile := 'No Data File Selected';
            GotoXY(1,24);
            HighVideo;
            TextColor(15);
            TextBackground(4);
            Write('                                                                                ');
            GotoXY(1,24);
            Write('    Records = ', cntr, '        Data File = ', DataFile, '        F2 = MORE');
            If DataFile = 'No Data File Selected' then DataFile := '';
            NormVideo;
            GotoXY(1,1);
       End;
{////////////////////////////////////////////////////////////////}
  Procedure More(cntr:Integer; DataFile:String);
       Var                          {Dysplayes number of records, free memory,}
            ch: Char;               {max memory, HD disk space, HD disk space free,}
       Begin                        {dos version, and data file name}
            If DataFile = '' then DataFile := 'No Data File Selected';
            Box(13,9,52,'','B');
            GotoXY(15,10);
            Write('Records         = ', cntr);
            GotoXY(47,10);
            Write('Free Memory = ', MemAvail);
            Box(13,10,52,'','C');
            GotoXY(15,11);
            Write('Hard Disk Size  = ', DiskSize(0));
            GotoXY(47, 11);
            Write('Max Memory  = ', MaxAvail);
            Box(13,11,52,'','C');
            GotoXY(15,12);
            Write('Free Disk Space = ', DiskFree(0));
            GotoXY(47, 12);
            Write('Dos Version = ', DosVersion);
            Box(13,12,52,'','E');
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
  Function BinFind(var List:Group; name:StringValue; cntr:Integer):Integer;
       Var                          {searches for name and returnes location}
            min, mid, first, last: Integer;
            found: Boolean;
{/////////////////////////////////////}
  Procedure Sort(var List: Group; var First, Last: Integer);
     Var                                {Sorts the words and replaces them in}
          Left,                         {the array}
          Right  : Integer;
          Fence,
          temp   : StringValue;
     Begin
          {ClrScr;}
          Fence := List[(First + Last) div 2];
          Left := First;
          Right := Last;
          Repeat
               While List[Left] < Fence do
                    Left := Succ(Left);
               While List[Right] > Fence do
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
                      If List[mid] = name
                           then found := TRUE
                      Else If name < List[mid]
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
            name: StringValue;
       Begin
            If cntr < max then
                 Begin
                      Box(21,11,36,'Enter in new name:  ','O');
                      GotoXY(43,12);
                      If CC then
                           Begin
                                skipchar;
                                ReadLn(FC, name);
                                Write(name);
                           End
                      Else ReadLn(name);
                      If name <> '' then
                           Begin
                                inc(cntr, 1);
                                List[cntr] := name;
                                change := TRUE;
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
            name: StringValue;
            loc,
            lcv : Integer;
       Begin
            Box(18,11,42,'Enter in name to delete:  ', 'O');
            GotoXY(46,12);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else ReadLn(name);
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
                                Box(21,11,37, '                 could not be found!!', 'O');
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
  Procedure NameFind(var List:Group;var CC:Boolean);
       Var                          {searches for a names in the list}
            name: StringValue;
            loc : Integer;
       Begin
            Box(16,11,46,'Enter in name to search for:  ', 'O');
            GotoXY(48,12);
            If CC then
                 Begin
                      skipchar;
                      ReadLn(FC, name);
                      Write(name);
                 End
            Else ReadLn(name);
            If name <> '' then
            Begin
                 loc := BinFind(List, name, cntr);
                 If loc > 0 then
                      Begin
                           Box(25,11,27,'                 was found.', 'O');
                           GotoXY(28, 12);
                           Write(name);
                           Delay(2000);
                      End
                 Else Begin
                           Box(21,11,37, '                 could not be found!!', 'O');
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
    Procedure Save(var List:Group; var DataFile:String; cntr:Integer; var change, CC:Boolean);
         Var                        {saves the names to a file}
              lcv : Integer;
              temp: String;
              ans : String[1];
              F   : Text;
              oncebefore: Boolean;
         Begin
              oncebefore := FALSE;
              temp := DataFile;
              If DataFile <> '' then
                   Begin
                        Box(4,11,70,'','O');
                        GotoXY(6,12);
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
                        If CC then
                             Begin
                                  skipchar;
                                  ReadLn(FC, DataFile);
                                  Write(DataFile);
                             End
                        Else ReadLn(DataFile);
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
                                  If CC then
                                       Begin
                                            skipchar;
                                            ReadLn(FC, DataFile);
                                            Write(DataFile);
                                       End
                                  Else ReadLn(DataFile);
                             End;
                   End;
              Assign(F, DataFile);
              {$I-}
              ReSet(F);
              Close(F);
              If IOResult = 0 then
                   Begin
                        If oncebefore = FALSE then
                             Begin
                                  Repeat
                                  ans := 'N';
                                  Box(20,11,40,'','B');
                                  GotoXY(22,12);
                                  Write(DataFile,' already exists!!');
                                  Box(20,12,40,'Do you wish to overwrite the old one?  ','E');
                                  GotoXY(60,13);
                                  ReadLn(ans);
                                  If (ans = 'Y') or (ans = 'y') then ReWrite(F)
                                  Else Begin
                                            Box(14,11,51,'Enter in name of file to save to:  ','O');
                                            GotoXY(51,12);
                                            IF CC then
                                                 Begin
                                                      skipchar;
                                                      ReadLn(FC, DataFile);
                                                      Write(DataFile);
                                                 End
                                            Else ReadLn(DataFile);
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
                                            IF CC then
                                                 Begin
                                                      skipchar;
                                                      ReadLn(FC, DataFile);
                                                      Write(DataFile);
                                                 End
                                            Else ReadLn(DataFile);
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
                   End
              Else Begin
                        {$I+}
                        Assign(F, DataFile);
                        ReWrite(F);
                   End;
              {WriteLn(F, cntr);}
              For lcv := 1 to cntr do
                   WriteLn(F, List[lcv]);
              change := FALSE;
              Close(F);
         End;
{////////////////////////////////////////////////////////////////}
    Procedure Load(var List:Group; var DataFile:String; var cntr:Integer; var change, CC:Boolean);
         Var                        {loads the names from a file}
              lcv: Integer;
              F  : Text;
              ans: String[1];
         Begin
              skip(1);
              If change = TRUE then
               Begin
                    Box(19,11,42,'Your data has changed since your last save','B');
                    Box(19,12,42,'Do you want to save?  ','E');
                    GotoXY(43,13);
                    ReadLn(ans);
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, CC);
               End;
              Box(17,11,46,'Enter file name to load:  ','O');
              GotoXY(45,12);
              If CC then
                   Begin
                        skipchar;
                        ReadLn(FC, DataFile);
                        Write(DataFile);
                   End
              Else ReadLn(DataFile);
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
                        Box(17,11,46,'Enter file name to load:  ','O');
                        GotoXY(45,12);
                        If CC then
                             Begin
                                  skipchar;
                                  ReadLn(FC, DataFile);
                                  Write(DataFile);
                             End
                        Else ReadLn(DataFile);
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
                        InitArray(List);
                        While not EOF(F) do
                             Begin
                                  c(7,2);
                                  GotoXY(15,24);
                                  Write(cntr);
                                  inc(cntr, 1);
                                  ReadLn(F, List[cntr]);
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
    Procedure Quit(var List:Group; var DataFile:String; var cntr:Integer; var change, CC:Boolean; var sel:Char);
              Var                   {quilt the program}
                   ans: String[1];
              Begin
              skip(1);
              If change = TRUE then
               Begin
                    Box(19,11,42,'Your data has changed since your last save','B');
                    Box(19,12,42,'Do you want to save?  ','E');
                    GotoXY(43,13);
                    ReadLn(ans);
                    If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, CC);
               End;
              Box(23,11,33,'Are you sure you want to quit?  ','O');
              GotoXY(57,12);
              ReadLn(ans);
              If (ans = 'Y') or (ans = 'y') then sel := 'Q'
                   Else sel := 'N';
              If (CC) and (sel = 'N') then
                   CC := FALSE;
              End;
{////////////////////////////////////////////////////////////////}
    Procedure PrintList(var List:Group; cntr:Integer; var CC:Boolean);
         Var                        {prints out the names}
              ans:String[1];
              name:StringValue;
              loc, lcv, lcv2:Integer;
         Begin
              Box(17,11,45,'Do you want to print a certian name (N,y):  ','O');
              GotoXY(63,12);
              If CC then
                   ans := 'N'
              Else ReadLn(ans);
              If (ans = 'Y') or (ans = 'y') then
                   Begin
                        Repeat
                             Box(15,11,49,'What name do you want to print:  ','O');
                             GotoXY(50,12);
                             ReadLn(name);
                        Until name <> '';
                        loc := BinFind(List, name, cntr);
                        If loc > 0 then
                             Begin
                                  ClrScr;
                                  WriteLn(List[loc]);
                                  skip(20);
                                  Write('Press [ENTER] to continue. . .');
                                  ReadLn;
                                  TextBackGround(0);
                                  ClrScr;
                             End
                        Else Begin
                                  Box(23,11,31,'                 was not found.', 'O');
                                  GotoXY(26, 12);
                                  Write(name);
                                  Delay(2000);
                             End;
                   End
              Else Begin
                        ClrScr;
                        lcv2 := 0;
                        loc := BinFind(List, '', cntr);
                        For lcv := 1 to cntr do
                             Begin
                                  inc(lcv2, 1);
                                  WriteLn(List[lcv]);
                                  If lcv2 = 24 then
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
    Procedure ConsoleControl(var CCFile:String; var CC:Boolean; var FC:Text);
         Var                            {Enables program to be controled}
              lcv: Integer;             {by an external file}
              ans: String[1];
         Begin
              Box(12,11,54,'Are you sure you want to end Console Control (N,y):  ','O');
              GotoXY(67,12);
              ReadLn(ans);
              If (ans = 'Y') or (ans = 'y') then
                   Begin
                        Box(16,9,46,'','B');
                        Box(16,10,46,'','C');
                        Box(16,11,46,'','C');
                        Box(16,12,46,'','C');
                        Box(16,13,46,'','E');
                        GotoXY(18,10);
                        c(4,2);
                        Write('WARING:  YOU ARE ABOUT TO END CONSOLE CONTROL');
                        GotoXY(18,12);
                        c(2,2);
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
                        ReadLn(ans);
                        If (ans = 'Y') or (ans = 'y') then
                             Begin
                                  Box(17,11,46,'Enter file name to read:  ','O');
                                  GotoXY(45,12);
                                  ReadLn(CCFile);
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
                                            GotoXY(45,12);
                                            ReadLn(CCFile);
                                       End;
                                  Box(27,11,26,'File Control begins in:  ','O');
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
    Procedure New(var List:Group; var DataFile:String; var cntr:Integer; var change, CC:Boolean);
              Var                   {Starts new list}
                   ans: String[1];
              Begin
                   skip(1);
                   Box(17,11,45,'Are you sure you want to start a new list?  ','O');
                   GotoXY(63,12);
                   If CC then
                        ans := 'Y'
                   Else ReadLn(ans);
                   If (ans = 'Y') or (ans = 'y') then
                        Begin
                             If change = TRUE then
                                  Begin
                                       Box(19,11,42,'Your data has changed since your last save','B');
                                       Box(19,12,42,'Do you want to save?  ','E');
                                       GotoXY(43,13);
                                       ReadLn(ans);
                                       If (ans = 'Y') or (ans = 'y') then Save(List, DataFile, cntr, change, CC);
                                  End;
                             InitArray(List);
                             DataFile := '';
                             cntr := 0;
                        End;
              End;
{////////////////////////////////////////////////////////////////}
     Begin
          CC := FALSE;
          CCFile := '';
          cntr := 0;
          change := FALSE;
          DataFile := '';
          TextBackGround(0);
          ClrScr;
          Repeat
               {ClrScr;}
               TextBackground(0);
               BackDrop;
               Status(cntr, DataFile);
               MenuCreator(25,8,'N','Start NEW list', 'B');
               MenuCreator(25,9,'A','Add name', 'C');
               MenuCreator(25,10,'D','Delete name', 'C');
               MenuCreator(25,11,'F','Find name', 'C');
               MenuCreator(25,12,'P','Print name list', 'C');
               MenuCreator(25,13,'S','Save name list to file', 'C');
               MenuCreator(25,14,'L','Load name list from file', 'C');
               MenuCreator(25,15,'Q','Quit', 'E');
               {skip(4);
               Write('Enter selection:  ');
               ReadLn(sel);}
               Repeat
                    If CC then Read(FC, sel)
                    Else Repeat
                              sel := ReadKey;
                         Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'N': New(List, DataFile, cntr, change, CC);
                    'A': AddName(List, cntr, change, CC);
                    'D': DeleteName(List, cntr, change, CC);
                    'F': NameFind(List, CC);
                    'P': PrintList(List, cntr, CC);
                    'S': Save(List, DataFile, cntr, change, CC);
                    'L': Load(List, DataFile, cntr, change, CC);
                    'Q': Quit(List, DataFile, cntr, change, CC, sel);
                    'C': ConsoleControl(CCFile, CC, FC);
               End;
               If Ord(sel) = 060 then More(cntr, DataFile);
               Until (sel = 'A') or (sel = 'D') or (sel = 'F') or (sel = 'P')
                     or (sel = 'S') or (sel = 'L') or (sel = 'Q') or
                     (sel = 'N') or (Ord(sel) = 060) or (sel = 'C') or
                     (sel = 'N');
          Until sel = 'Q';
          If CC then Close(FC);
     End;
{////////////////////////////////////////////////////////////////////////}
Begin                     {main program}
     Intro;
     InitArray(List);
     Menu(List);
     ClrScr;
End.