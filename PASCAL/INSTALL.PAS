Program Install;

Uses CRT, DOS, MENU;

Const
     STRI1 = 1;
     STRI17 = 17;
     STRI26 = 26;
     maxfiles = 255;

Type
     ST1 = String[STRI1];
     ST17 = String[STRI17];
     ST26 = String[STRI26];
     file_names = record
                       Fname: String[12];
                  End;
     Group = Array[1..maxfiles] of file_names;
     Inst_Cfg = Record
                  ProgName: String[76];
                  EncKey: String[29];
                  CompName: String[78];
                  DirName: String[26];
                End;

Var
     FList: Group;
     num: Integer;
     Cfg: Inst_Cfg;

{////////////////////////////////////////////////////////////////////////}
Procedure answer1(var name2: ST1; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[1];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 1 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              Write(Char_Temp);
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
{////////////////////////////////////////////////////////////////////////}
Procedure answer17(var name2: ST17; X, Y: Integer);

Var
     cntr,
     cntr2,
     lcv       : Integer;
     Char_Temp : Char;
     name      : String[17];

Begin
     name := '';
     name2 := '';
     cntr := X;
     cntr2 := 0;
     Repeat
          Repeat
               Char_Temp := ReadKey;
          Until Char_Temp <> '';
          If (Ord(Char_Temp) <> 13) and (Ord(Char_Temp) <> 8) then
               Begin
                    If cntr = X + 17 then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              inc(cntr2, 1);
                              inc(cntr, 1);
                              {Write(Char_Temp);}
                              Write('*');
                              name[cntr2] := Char_Temp;
                         End;
               End;
          If Ord(Char_Temp) = 8 then
               Begin
                    If cntr = X then
                         Begin
                              Sound(900);
                              Delay(200);
                              NoSound;
                         End
                    Else Begin
                              GotoXY(cntr - 1, Y);
                              Write(' ');
                              GotoXY(cntr - 1, Y);
                              name[cntr2] := ' ';
                              dec(cntr2, 1);
                              dec(cntr, 1);
                         End;
               End;
     Until Ord(Char_Temp) = 13;
     For lcv := 1 to cntr2 do
          name2 := name2 + name[lcv];
End;
{////////////////////////////////////////////////////////////////////////}
Procedure ReadInst(var Cfg: Inst_Cfg);
  Var
    Config: File of Inst_Cfg;
{////////////////////////////////////////////////////////////////}
  Function DC(texts:String): String;
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to Length(texts) do
        texts[lcv] := chr((ord(texts[lcv]) - 7 ) div 2);
      DC := texts;
    End;
{////////////////////////////////////////////////////////////////}
  Begin
    Assign(Config, 'INSTALL.CFG');
    {$I-}
    ReSet(Config);
    Close(Config);
    {$I+}
    If IOResult <> 0 then
      Begin
        c(7,1,0);
        Sound(950);
        Delay(200);
        NoSound;
        ClrScr;
        WriteLn('Installation aborted due to error. . .');
        WriteLn('             (installation configuration file could not be found!)');
        WriteLn;
        WriteLn;
        Halt;
      End;
    ReSet(Config);
    Read(Config, Cfg);
    Close(Config);
    Cfg.ProgName := DC(Cfg.ProgName);
    Cfg.EncKey := DC(Cfg.EncKey);
    Cfg.CompName := DC(Cfg.CompName);
    Cfg.DirName := DC(Cfg.DirName);
  End;
{////////////////////////////////////////////////////////////////////////}
Procedure BkDrp;
  Var
    lcv: Integer;
  Begin
    BackDrop;
    GotoXY(1,1);
    If Cfg.CompName <> '' then
      Begin
        c(14,2,1);
        GotoXY(80-13,23);
        For lcv := 1 to 13 do
          Write('Õ');
        c(15,2,1);
        GotoXY(80-Length(Cfg.CompName),23);
        For lcv := 1 to Length(Cfg.CompName) do
          Begin
            If Cfg.CompName[lcv] = ' ' then GotoXY(WhereX+1,WhereY)
              Else Write(Cfg.CompName[lcv]);
          End;
      End;
  End;
{////////////////////////////////////////////////////////////////////////}
Procedure Intro;
     Var
       X,Len: Integer;
     Begin
          c(8,1,0);
          ClrScr;
          c(7,1,0);
          If Length(Cfg.ProgName) <= 12 then Len := 16
            Else Len := Length(Cfg.ProgName) + 4;
          GotoXY(1,10);
          X := 40-((Len+4)div 2);
          Box(X,11,Len,'','B');
          Box(X,12,Len,'','C');
          Box(X,13,Len,'','E');
          c(15,2,1);
          GotoXY(40-(Length(Cfg.ProgName) div 2),12); Write(Cfg.ProgName);
          GotoXY(40-(12 div 2),13); Write('Installation');
          GotoXY(40-(7 div 2),14); Write('Program');
          c(7,1,0);
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
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure MainMenu;
     Var
          sel: Char;
{////////////////////////////////////////////////////////////////}
  Procedure BegInst;
       Var
            OK: Boolean;
            dir: String;
            help: File of Char;
            hlptxt: Char;
{////////////////////////////////////////////////////////}
    Procedure Create_Directory(var OK:Boolean; var dir:String);
         Var
              driv: ST1;
              directory: ST26;

         Begin
              OK := TRUE;
              Repeat
                   driv:= '';
                   directory := Cfg.DirName;
                   Box(21,11,39,'Enter in drive letter to install to:  :', 'O');
                   c(15,2,1);
                   GotoXY(60,12);
                   answer1(driv, WhereX, WhereY);
                   dir := driv + ':\' + directory;
                   {$I-}
                   If driv <> '' then MkDir(dir);
                   Case IOResult of
                        3: Begin
                                Box(0,11,15,'Drive not ready', 'O');
                                GotoXY(1,1);
                                Sound(900);
                                Delay(500);
                                NoSound;
                                Delay(1500);
                                OK := FALSE;
                           End;
                        5: Begin
                                Box(0,11,61,'Directory either already exists, or drive is write protected.', 'O');
                                GotoXY(1,1);
                                Sound(900);
                                Delay(500);
                                NoSound;
                                Delay(3500);
                                OK := FALSE;
                           End;
                       10: Begin
                                Box(0,11,19,'Invalid DOS version', 'O');
                                GotoXY(1,1);
                                Sound(900);
                                Delay(500);
                                NoSound;
                                Delay(1500);
                                OK := FALSE;
                                halt;
                           End;
                   End;
                   {$I+}
                   Until (IOResult = 0);
                   If driv = '' then OK := FALSE;
{                   If OK then
                     Begin
                       dir := dir + '\SAVEGAME';
                       MkDir(dir);
                       dir := driv + ':\' + directory;
                     End;}
         End;
{////////////////////////////////////////////////////////}
    Procedure Copy_Files(dir:String);
         Var
              FromF, ToF: file;
              NumRead, NumWritten: Word;
              Buf: array[1..2048] of Char;
              loop, lcv: Integer;
              input, output: String;
              X, Y: Integer;
              last: Real;
              Disk: Integer;
{////////////////////////////////////////////////}
      Procedure ReadOut(done:Real;var X, Y:Integer;var last:Real);
           Begin
                If done >= last + 5 then
                     Begin
                          GotoXY(X,Y);
                          c(5,1,1);
                          Write('€');
                          X := WhereX;
                          Y := WhereY;
                          last := done;
                     End;
                c(15,2,1);
                GotoXY(53, 21);
                Write(done:0:0, '%');
                GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure FLoad(var FList:Group;var lcv:Integer);
           Var
                F: file of file_names;
           Begin
                Assign(F, 'INSTALL.DAT');
                ReSet(F);
                lcv := 0;
                While NOT EOF(F) do
                     Begin
                          inc(lcv, 1);
                          Read(F, FList[lcv]);
                     End;
                Close(F);
           End;
{////////////////////////////////////////////////}
      Function FLocate(FList: Group; loop: Integer): String;
        Var
          f: File;
{////////////////////////////////////////}
        Procedure BoxWipe(X, Y, X2, Y2: Integer);
          Var
            lcv, lcv2: Integer;
          Begin
            c(3,2,1);
            For lcv := Y to Y2 do
              Begin
                For lcv2 := X to X2 do
                  Begin
                    GotoXY(lcv2, lcv);
                    Write('∞');
                  End;
              End;
            c(7,1,0);
          End;
{////////////////////////////////////////}
        Begin
          Assign(f, FList[loop].Fname);
          {$I-}
          ReSet(f);
          Close(f);
          {$I+}
          If IOResult <> 0 then
            Begin
              inc(Disk,1);
              Repeat
                {$I-}
                ReSet(f);
                Close(f);
                {$I+}
                If IOResult <> 0 then
                  Begin
                    Box(26,4,28,'Please insert Disk #','B');
                    GotoXY(48,5);
                    c(14,2,1);
                    Write(Disk);
                    Box(26,5,28,'','C');
                    Box(26,6,28,'Press Enter to continue. . .','E');
                    GotoXY(1,1);
                    ReadLn;
                    BoxWipe(26,4,57,8);
                    GotoXY(1,1);
                  End;
                {$I-}
                ReSet(f);
                Close(f);
                {$I+}
              Until IOResult = 0;
              FLocate := FList[loop].Fname;
            End
          Else FLocate := FList[loop].Fname;
        End;
{////////////////////////////////////////////////}
         Begin
              Disk := 1;
              BkDrp;
              Box(30,12,18,'Copying files. . .','O'); GotoXY(1,1);
              FLoad(FList, lcv);
              num := lcv;
              Box(20,18,38,'','B');
              Box(20,19,38,'','C');
              Box(20,20,38,'','E');
              For loop := 1 to lcv do
                Begin
                INPUT := FLocate(FList,loop);
                GotoXY(31,21);
                X := 31;  Y := 21;  last := 0;
                c(8,1,1);
                Write('∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞');
                c(15,2,1);
                GotoXY(53, 21);
                Write('0%  ');
                GotoXY(22,19);
                Write('Copying:                to');
                GotoXY(29,20);
                Write('Files left to copy:  ', lcv - loop,'  ');
                GotoXY(1,1);
                GotoXY(32,19);
                c(10,2,1);
                Write(INPUT);
                GotoXY(49,19);
                Write(dir);
                c(15,2,1);
                GotoXY(1,1);
                OUTPUT := dir + '\' + INPUT;
                Assign(FromF, INPUT); { Open input file }
                Reset(FromF, 1);  { Record size = 1 }
                Assign(ToF, OUTPUT); { Open output file }
                Rewrite(ToF, 1);  { Record size = 1 }
                {Writeln('Copying ', FileSize(FromF), ' bytes...');}
                repeat
                  BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
                  BlockWrite(ToF, Buf, NumRead, NumWritten);
                  ReadOut(FilePos(FromF) / FileSize(FromF) * 100, X, Y, last);
                until (NumRead = 0) or (NumWritten <> NumRead);
                GotoXY(31,21);
                c(5,1,1);
                Write('€€€€€€€€€€€€€€€€€€€€');
                c(15,2,1);
                GotoXY(53, 21);
                Write('100%');
                GotoXY(1,1);
{                Delay(2000);}
                Close(FromF);
                Close(ToF);
                End;
         End;
{////////////////////////////////////////////////////////}
    Procedure Decomp_Files(dir:String; FList: Group);
      Var
        f: File;
        t: File of Char;
        ProgramName, CmdLine: String;
        Fix: Char;
        loop: Integer;
{////////////////////////////////////////////////}
      Procedure PassInv;
        Var
          pass: ST17;
        Begin
          BkDrp;
          Box(29, 9, 21, '   Enter password:', 'B');
          Box(29, 10, 21, '', 'C');
          Box(29, 11, 21, '', 'C');
          Box(29, 12, 21, '', 'E');
          c(15,2,1);
          GotoXY(31,12);
          Write('                 ');
          GotoXY(31,12);
          answer17(pass,WhereX,WhereY);
          Cfg.EncKey := pass;
          CmdLine := '-d ' + '-s' + Cfg.EncKey + ' ' + dir;
          BkDrp;
          Box(0,11,21,'Decrypting files. . .','O'); GotoXY(1,1);
          Delay(1000);
          BkDrp;
        End;
{////////////////////////////////////////////////}
      Begin
        For loop := 1 to num do
          Begin
            Assign(f, dir + '\' + FList[loop].Fname);
            Assign(t, dir + '\' + FList[loop].Fname);
            ReSet(t);
            Fix := 'M';
            Write(t, Fix);
            Fix := 'Z';
            Write(t, Fix);
            Close(t);
            Delete(FList[loop].Fname,Length(FList[loop].Fname) - 3,4);
            Insert('.EXE',FList[loop].Fname,Length(FList[loop].Fname) + 1);
            Rename(f, dir + '\' + FList[loop].Fname);
          End;
{        Assign(f, dir + '\U6SHAPES.000');
        Assign(t, dir + '\U6SHAPES.000');
        ReSet(t);
        Fix := 'M';
        Write(t, Fix);
        Fix := 'Z';
        Write(t, Fix);
        Close(t);
        Rename(f, dir + '\U6SHAPES.EXE');}
        BkDrp;
        Box(0,11,25,'De-Compressing files. . .','O'); GotoXY(1,1);
        Delay(800);
        c(0,0,0);
        If Cfg.EncKey <> '' then
          Begin
            If Cfg.EncKey = '-sUserInv' then PassInv
              Else CmdLine := '-d ' + Cfg.EncKey + ' ' + dir
          End
          Else CmdLine := dir;
        ClrScr;
        For loop := 1 to num do
          Begin
            ProgramName := dir + '\' + FList[loop].Fname;
            SwapVectors;
            Exec(ProgramName, CmdLine);
            SwapVectors;
            Assign(f, dir + '\' + FList[loop].Fname);
            ReWrite(f);
            Close(f);
            Erase(f);
          End;
{        ProgramName := dir + '\U6SHAPES.EXE';
        SwapVectors;
        Exec(ProgramName, CmdLine);
        SwapVectors;
        Assign(f, dir + '\U6SHAPES.EXE');
        ReWrite(f);
        Close(f);
        Erase(f);}
        If DosError <> 0 then{ Error? }
          Begin
            If DosError = 8 then
              Box(0,12,14,'Out of memory!','O')
            Else Box(0,12,23,'Undefined error occured','O');
            GotoXY(1,1);
            c(7,1,0);
            Sound(950);
            Delay(200);
            NoSound;
            Delay(2000);
            ClrScr;
            WriteLn('Installation aborted due to error. . .');
            WriteLn;
            WriteLn;
            Halt;
          End;
        c(0,0,0);
        ClrScr;
        BkDrp;
        Box(0,11,22,'Installation Complete!','O'); GotoXY(1,1);
        Delay(2000);
      End;
{////////////////////////////////////////////////////////}
    Procedure SplChar;
      Begin
        If NOT EOF(help) then
          Begin
            Read(help,hlptxt);
            Case UpCase(hlptxt) of
              'N':  Write(Cfg.ProgName);
              'C':  Write(Cfg.CompName);
              'D':  Write(dir[1]);
              'I':  Write(Cfg.DirName);
              '0':  TextColor(0);
              '1':  TextColor(1);
              '2':  TextColor(2);
              '3':  TextColor(3);
              '4':  TextColor(4);
              '5':  TextColor(5);
              '6':  TextColor(6);
              '7':  TextColor(7);
              '~':  Write('~');
            End;
          End;
      End;
{////////////////////////////////////////////////////////}
       Begin
            BkDrp;
            Create_Directory(OK, dir);
            If OK then
              Begin
                Copy_Files(dir);
                Decomp_Files(dir, FList);
                c(7,0,0);
                ClrScr;
                Assign(help,'HELP.TXT');
                {$I-}
                ReSet(help);
                Close(help);
                {$I+}
                If IOResult = 0 then
                  Begin
                    ReSet(help);
                    While NOT EOF(help) do
                      Begin
                        Read(help, hlptxt);
                        If hlptxt = '~' then SplChar
                          Else Write(hlptxt);
                      End;
                  End;
                WriteLn;
                WriteLn;
                Halt;
              End
            Else Begin
                   c(7,1,0);
                   ClrScr;
                   WriteLn('Installation aborted due to error. . .');
                   WriteLn;
                   WriteLn;
                   Halt;
                 End;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          ClrScr;
          Repeat
               BkDrp;
               MenC(29, 11, 15, 'I', 'Install Program', 'B');
               MenC(29, 12, 15, 'Q', 'Quit', 'E');
               Repeat
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'I':  BegInst;
               End;
               Until (sel = 'I') or (sel = 'Q') or (Ord(sel) = 027);
          Until (sel = 'I') or (sel = 'Q') or (Ord(sel) = 027);
     End;
{////////////////////////////////////////////////////////////////////////}
Begin
(*     {$M $9000,0,655360 }   { 16K stack, no heap }*)
     {$M $4000,0,0 }   { 16K stack, no heap }
     ClrScr;
     ReadInst(Cfg);
     Intro;
     MainMenu;
     c(7,0,0);
     ClrScr;
End.