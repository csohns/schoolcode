Program Registration;

Uses CRT, DOS, MENU, ANSWERS;

Var
     REG: Boolean;
     sel: Char;

{////////////////////////////////////////////////////////////////}
Procedure code(var REG:Boolean);
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
          lcv, Enc, temp: Integer;
          F: File of CodeRec;
          y, m, d, dow: Word;
     Begin
          Stats.USER_NAME := '';
          Stats.USER_COMPANY := '';
          Stats.PASSWORD := '';
          Assign(F, 'MAGDBASE.DAT');
          {$I-}
          ReSet(F);
          Close(F);
          {$I+}
          If IOResult <> 0 then
               Begin
                    Box(0,11,47,'You must run MAGDBASE before you run REGISTER!!','O');
                    GotoXY(1,1);
                    Sound(900);
                    Delay(500);
                    NoSound;
                    Delay(3500);
                    c(7,0,0);
                    ClrScr;
                    halt;
               End;
          Box(6,11,62,'Enter in your name:  ','O');
          c(15,2,1);
          GotoXY(29,12);
          answer40(Stats.USER_NAME, WhereX, WhereY);
          Box(10,11,60,'Enter in your company name:  ','B');
          Box(10,12,60,'','E');
          c(15,2,1);
          GotoXY(12,13);
          answer60(Stats.USER_COMPANY, WhereX, WhereY);
          Box(0,11,46,'Enter in registration code:  ','O');
          c(15,2,1);
          answer17(Stats.PASSWORD, WhereX, WhereY);
          {ReadLn(code);}
          Randomize;
          Stats.EncNum := Random(65) + 1;
          cstr := '';
          For lcv := 1 to Length(Stats.PASSWORD) do
               Begin
                    j := Ord(Stats.PASSWORD[lcv]);
                    j := j + (Stats.EncNum + 32);
                    {If j > 256 then
                         Begin
                              temp := j - 256;
                              j := 0;
                              inc(j, temp);
                         End;}
                    cstr := cstr + CHR(j);
               End;
          Stats.PASSWORD := cstr;
          ReWrite(F);
          Write(F, Stats);
          Close(F);
     End;
{////////////////////////////////////////////////////////////////}
Begin
     c(7,0,0);
     Repeat
          Repeat
               BackDrop;
               MenC(31,11,13,'Z','Enter in code','B');
               MenC(31,12,13,'Q','Quit','E');
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'Z': code(REG);
               End;
          Until (sel = 'Z') or (sel = 'Q');
     Until sel = 'Q';
     c(7,0,0);
     ClrScr;
End.