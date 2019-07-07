Program Install;

Uses CRT, DOS, MENU, ANSWERS;

Const
     maxfiles = 255;

Type
     file_names = record
                       Fname: String[12];
                  End;
     Group = Array[1..maxfiles] of file_names;

Var
     FList: Group;

{////////////////////////////////////////////////////////////////////////}
Procedure Intro;
     Begin
          c(8,1,0);
          ClrScr;
          c(7,1,0);
          Box(0,11,17,' Wheel of Fortune','B');
          Box(0,12,17,'   Installation  ','C');
          Box(0,13,17,'     Program     ','E');
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
{////////////////////////////////////////////////////////}
    Procedure Create_Directory(var OK:Boolean; var dir:String);
         Var
              driv: ST1;
              directory: ST26;

         Begin
              OK := TRUE;
              Repeat
                   driv:= '';
                   directory := 'WHEEL';
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
                GotoXY(56, 21);
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
         Begin
              FLoad(FList, lcv);
              Box(23,18,38,'','B');
              Box(23,19,38,'','C');
              Box(23,20,38,'','E');
              For loop := 1 to lcv do
                Begin
                INPUT := FList[loop].Fname;
                GotoXY(34,21);
                X := 34;  Y := 21;  last := 0;
                c(8,1,1);
                Write('∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞∞');
                c(15,2,1);
                GotoXY(56, 21);
                Write('0%  ');
                GotoXY(25,19);
                Write('Copying:                to');
                GotoXY(32,20);
                Write('Files left to copy:  ', lcv - loop,'  ');
                GotoXY(1,1);
                GotoXY(35,19);
                c(10,2,1);
                Write(INPUT);
                GotoXY(52,19);
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
                GotoXY(34,21);
                c(5,1,1);
                Write('€€€€€€€€€€€€€€€€€€€€');
                c(15,2,1);
                GotoXY(56, 21);
                Write('100%');
                GotoXY(1,1);
                Delay(2000);
                Close(FromF);
                Close(ToF);
                End;
         End;
{////////////////////////////////////////////////////////}
       Begin
            BackDrop;
            Create_Directory(OK, dir);
            If OK then Copy_Files(dir)
              Else Begin
                     c(7,1,0);
                     ClrScr;
                     WriteLn('Installition aborted due to error. . .');
                     WriteLn;
                     WriteLn;
                     Halt;
                   End;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          ClrScr;
          Repeat
               BackDrop;
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
     {$M $4000,0,0 }   { 16K stack, no heap }
     ClrScr;
     Intro;
     MainMenu;
     c(7,0,0);
     ClrScr;
End.