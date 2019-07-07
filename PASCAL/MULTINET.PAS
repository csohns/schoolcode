Program MULTINET;

{Version 1.0  Total rewrite of NetTalk}
{Version 2.0  Addition of God Commands}
{Version 2.1  Now reads network user account names}
{Version 2.5  Fake version upgrade for WATCHNET}
{Version 3.0  Subscriptions added}
{Version 3.1  Time/Date restrictions, passwords, and user types are all added}
{Version 3.2  Commertial security measures added}

Uses
  CRT, DOS, ANSWERS, NovApi;

Const
  MAX = 1000;
  User5 = 'ÙﬁÒ‚ÔΩÔÚÎÎÊÎ‰';
  User10 = 'º≠ÆµÖ®∑¶®∞';
  User20 = 'J9AFKLGJE';
  User50 = '®©öñ¢®ùû•';
  UnLimit = 'ù¢Æ•üù™|£´®†';

Type
  ST70 = String[70];
  ST11 = String[11];
  DateType = Record
               Year: Word;
               Month: Word;
               Day: Word;
               DayofWeek: Word;
             End;
  TimeType = Record
               Hour: Word;
               Minuet: Word;
               Second: Word;
               Hund: Word;
             End;
  UserType = Record
               Name: String47;
               RunOut: DateType;
               TimeSet: TimeType;
             End;
  SubScript = Record
                Active: Boolean;
                User: UserType;
              End;

Var
  user: String47;
  confname: ST11;
  lcv: Integer;
  ch: Char;
  message: ST70;
  Rmessage: String;
  OldfTime: Longint;
  X, Y, wX, wY: Integer;
  NewMessage, done: Boolean;
  InMessage: Boolean;
  reg: Boolean;
  immune: Boolean;
  tablefile: Boolean;
  ObjectID    : longint;
  ObjectType  : integer;
  ObjectName  : string47;
  ObjectLogin : NetworkTimeRecord;
  Config: SubScript;
  Speed: LongInt;
  AccessLvl: Word;
  silent: Boolean;

{//////////////////////////////////////////////////////////////////////}
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
{//////////////////////////////////////////////////////////////////////}
Function EnCrypt(code:ST10):Boolean;
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(code) do
      code[lcv] := chr(ord(code[lcv])+42);
    If (code = 'm}yrx}') or (*(code = 'Åszzo|') or (code = '{k}k|wkx') or*)
       (code = 'mrmu') or (*(code = 'kmu') or (code = 't}xÉno|') or
       (code = 'nkx}') or*) (code = '}zo|Äs}y|') then
         EnCrypt := TRUE
    Else EnCrypt := FALSE;
  End;
{//////////////////////////////////////////////////////////////////////}
Function BPSChk: LongInt;
  Var
    cntr: LongInt;
    h,m,s,hund: Word;
    h2,m2,s2,hund2: Word;
    f: File of SubScript;
    Stest: SubScript;
  Begin
    cntr := 0;
    c(31,2,0);
    WriteLn;
    WriteLn('Preforming speed test. . .');
    c(7,1,0);
(*    Repeat                       {|                           }
      GetTime(h,m,s,hund);       {|                           }
    Until hund = 0;              {|                           }
    Repeat                       {|     Old Preformance Test!!}
      inc(cntr,1);               {|         VERY INACURATE    }
      GetTime(h2,m2,s2,hund2);   {|              BUT          }
    Until s2 = s + 1;            {|          HIGH NUMBERS     }*)
                                 {----------------------------}
    Assign(f,'P TEST.TST');      {|                           }
    ReWrite(f);                  {|                           }
    Write(f,Stest);              {|                           }
    Close(f);                    {|                           }
    ReSet(f);                    {|                           }
    GetTime(h,m,s,hund);         {|                           }
    Repeat                       {|                           }
      Seek(f,0);                 {|     NEW Preformance Test!!}
      inc(cntr,1);               {|          VERY ACURATE     }
      GetTime(h2,m2,s2,hund2);   {|              BUT          }
    Until s2 = s + 1;            {|       NO ONE WILL BELEIVE }
    Close(f);                    {|         THE LOW NUMBERS   }
    Erase(f);                    {|                           }
(*    cntr := cntr * 60;*)
    BPSChk := cntr;
  End;
{//////////////////////////////////////////////////////////////////////}
Function TrapCheck: Boolean;
  Const
{    TrapYear = 1997;
    TrapMonth = 0;}
    TrapYear = 1996;
    TrapMonth = 11;
  Var
    Year,Month,Day,DayOfWeek: Word;
  Begin
    GetDate(Year,Month,Day,DayOfWeek);
    If Year >= TrapYear then
      Begin
        If (Year = TrapYear) and (Month <= TrapMonth) then TrapCheck := FALSE
         Else TrapCheck := TRUE;
      End
    Else TrapCheck := FALSE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure InitCfg(var Config:SubScript);
  Var
    f: File of SubScript;
    cntr: Integer;
  Begin
    Assign(f,'MULTINET.CFG');
    Config.Active := FALSE;
    Config.User.Name := '';
    Config.User.TimeSet.Hour := 0;
    Config.User.TimeSet.Minuet := 0;
    Config.User.TimeSet.Second := 0;
    Config.User.TimeSet.Hund := 0;
    Config.User.RunOut.Year := 0;
    Config.User.RunOut.Month := 0;
    Config.User.RunOut.Day := 0;
    Config.User.RunOut.DayofWeek := 0;
    cntr := -1;
    ReWrite(f);
    Repeat
      inc(cntr,1);
      Write(f,Config);
    Until cntr = MAX-1;
    Close(f);
  End;
{//////////////////////////////////////////////////////////////////////}
    Function PassEnCrypt(Pass:String47; num:Integer):String47;
      Var
        lcv: Integer;
      Begin
        For lcv := 1 to Length(Pass) do
          Pass[lcv] := chr(ord(Pass[lcv])+num);
        PassEnCrypt := Pass;
      End;
{//////////////////////////////////////////////////////////////////////}
Procedure EditCfg(var Config:SubScript);
  Var
    f: File of SubScript;
    sel: Char;
{//////////////////////////////////////////////////////////////}
  Procedure UpStr(var name:String47);
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to Length(name) do
        name[lcv] := UpCase(name[lcv]);
    End;
{//////////////////////////////////////////////////////////////}
  Function FindSub(name:String47): Integer;
    Var
      cntr: Integer;
      found: Boolean;
      TmpCfg: SubScript;
    Begin
      cntr := 0;
      found := FALSE;
      ReSet(f);
      Repeat
        inc(cntr, 1);
        Seek(f,cntr);
        Read(f,TmpCfg);
        If TmpCfg.User.Name = name then found := TRUE;
      Until (found) or (cntr = MAX-1);
      If found then FindSub := cntr
        Else FindSub := -1;
      Close(f);
    End;
{//////////////////////////////////////////////////////////////}
  Function EFindSub: Integer;
    Var
      cntr: Integer;
      found: Boolean;
      TmpCfg: SubScript;
    Begin
      cntr := 0;
      found := FALSE;
      ReSet(f);
      Repeat
        inc(cntr, 1);
        Seek(f,cntr);
        Read(f,TmpCfg);
        If TmpCfg.User.Name = '' then found := TRUE;
      Until (found) or (cntr = MAX-1);
      If found then EFindSub := cntr
        Else EFindSub := -1;
      Close(f);
    End;
{//////////////////////////////////////////////////////////////}
  Procedure AddSub;
    Var
      loc: Integer;
      sel: Char;
      Config: SubScript;
    Begin
      loc := EFindSub;
      If loc = -1 then
        Begin
          Sound(950);
          Delay(200);
          NoSound;
          Delay(800);
          WriteLn('The SubScription data base is full, you can not add any more users.');
          Delay(2200);
        End
      Else Begin
             Config.Active := FALSE;
             Write('Enter subscribed user name: ');
             ReadLn(Config.User.Name);
             UpStr(Config.User.Name);
             If Config.User.Name <> '' then
               Begin
                 If FindSub(Config.User.Name) = -1 then
                 Begin
                 WriteLn;
                 Write('Enter Month subscription expires: ');
                 ReadLn(Config.User.RunOut.Month);
                 Write('Enter Day subscription expires: ');
                 ReadLn(Config.User.RunOut.Day);
                 Write('Enter Year subscription expires: ');
                 ReadLn(Config.User.RunOut.Year);
                 WriteLn;
                 WriteLn('         (24 HOUR TIME)');
                 Write('Enter FIRST login time in Hours: ');
                 ReadLn(Config.User.TimeSet.Hour);
                 Write('Enter FIRST login time in Minutes: ');
                 ReadLn(Config.User.TimeSet.Minuet);
                 WriteLn;
                 WriteLn('         (24 HOUR TIME)');
                 Write('Enter LAST login time in Hours: ');
                 ReadLn(Config.User.TimeSet.Second);
                 Write('Enter LAST login time in Minutes: ');
                 ReadLn(Config.User.TimeSet.Hund);
                 WriteLn;
                 Repeat
                   WriteLn('[0 = NORMAL  1 = IMMUNE  2 = GOD/IMMUNE  3 = EDIT/GOD/IMMUNE]');
                   Write('What type of user will ',Config.User.Name,' be? ');
                   ReadLn(Config.User.RunOut.DayOfWeek);
                   WriteLn;
                 Until Config.User.RunOut.DayOfWeek IN [0,1,2,3];
                 ClrScr;
                 WriteLn('Name:  ',Config.User.Name);
                 Write('Subscription expires on ',Config.User.RunOut.Month,'/',Config.User.RunOut.Day,'/');
                 WriteLn(Config.User.RunOut.Year);
                 Write('Can login from ',Config.User.TimeSet.Hour,':',Config.User.TimeSet.Minuet);
                 WriteLn(' to ',Config.User.TimeSet.Second,':',Config.User.TimeSet.Hund);
                 Case Config.User.RunOut.DayOfWeek of
                   0: WriteLn('User is a NORMAL user.');
                   1: WriteLn('User is IMMUNE to god commands.');
                   2: WriteLn('User is a GOD and is IMMUNE.');
                   3: WriteLn('User can EDIT subscriptions, is a GOD, and is IMMUNE.');
                 End;
                 WriteLn;
                 Write('Accept [Y,N]');
                 Repeat
                   sel := ReadKey;
                   sel := UpCase(sel);
                 Until sel IN ['Y','N'];
                 If sel = 'Y' then
                   Begin
                     ReSet(f);
                     Seek(f,loc);
                     Write(f,Config);
                     Close(f);
                   End;
                 End
                 Else Begin
                        Sound(950);
                        Delay(200);
                        NoSound;
                        Delay(800);
                        WriteLn('User is already in the data base!');
                        Delay(2200);
                      End;
               End;
           End;
    End;
{//////////////////////////////////////////////////////////////}
  Procedure DeleteSub(Config:SubScript);
    Var
      loc: Integer;
      sel: Char;
    Begin
      Write('Enter subscribed user name to delete: ');
      ReadLn(Config.User.Name);
      If Config.User.Name <> '' then
      Begin
      UpStr(Config.User.Name);
      loc := FindSub(Config.User.Name);
      If loc = -1 then
        Begin
          Sound(950);
          Delay(200);
          NoSound;
          Delay(800);
          WriteLn('This user is not in the SubScription data base.');
          Delay(2200);
        End
      Else Begin
             Config.Active := FALSE;
             Config.User.Name := '';
             Config.User.TimeSet.Hour := 0;
             Config.User.TimeSet.Minuet := 0;
             Config.User.TimeSet.Second := 0;
             Config.User.TimeSet.Hund := 0;
             Config.User.RunOut.Year := 0;
             Config.User.RunOut.Month := 0;
             Config.User.RunOut.Day := 0;
             Config.User.RunOut.DayofWeek := 0;
             ReSet(f);
             Seek(f,loc);
             Write(f,Config);
             Close(f);
           End;
      End;
    End;
{//////////////////////////////////////////////////////////////}
  Procedure EditSub;
    Var
      loc: Integer;
      sel: Char;
      TmpName: String47;
    Begin
      Write('Enter subscribed user name to delete: ');
      ReadLn(Config.User.Name);
      If Config.User.Name <> '' then
      Begin
      UpStr(Config.User.Name);
      loc := FindSub(Config.User.Name);
      If loc = -1 then
        Begin
          Sound(950);
          Delay(200);
          NoSound;
          Delay(800);
          WriteLn('This user is not in the SubScription data base.');
          Delay(2200);
        End
      Else Begin
             ReSet(f);
             Seek(f,loc);
             Read(f,Config);
             Close(f);
             Repeat
               c(8,1,0);
               ClrScr;
               c(7,1,0);
               WriteLn('A]  Name: ',Config.User.Name);
               Write('B]  Experation date: ',Config.User.RunOut.Month,'/',Config.User.RunOut.Day,'/');
               WriteLn(Config.User.RunOut.Year);
               WriteLn('C]  First login time: ',Config.User.TimeSet.Hour,':',Config.User.TimeSet.Minuet);
               WriteLn('D]  Last login time: ',Config.User.TimeSet.Second,':',Config.User.TimeSet.Hund);
               Write('E]  User type: ');
               Case Config.User.RunOut.DayOfWeek of
                 0: WriteLn('User is a NORMAL user.');
                 1: WriteLn('User is IMMUNE to god commands.');
                 2: WriteLn('User is a GOD and is IMMUNE.');
                 3: WriteLn('User can EDIT subscriptions, is a GOD, and is IMMUNE.');
               End;
               WriteLn('Q]  Quit');
               Repeat
                 Repeat
                   sel := ReadKey;
                 Until sel <> '';
                 sel := UpCase(sel);
                 Case sel of
                   'A': Begin
                          Write('Enter subscribed user name: ');
                          ReadLn(TmpName);
                          UpStr(TmpName);
                          If TmpName <> '' then Config.User.Name := TmpName
                            Else Begin
                                   Sound(950);
                                   Delay(800);
                                   NoSound;
                                   Delay(1200);
                                 End;
                        End;
                   'B': Begin
                          Write('Enter Month subscription expires: ');
                          ReadLn(Config.User.RunOut.Month);
                          Write('Enter Day subscription expires: ');
                          ReadLn(Config.User.RunOut.Day);
                          Write('Enter Year subscription expires: ');
                          ReadLn(Config.User.RunOut.Year);
                        End;
                   'C': Begin
                          WriteLn('         (24 HOUR TIME)');
                          Write('Enter FIRST login time in Hours: ');
                          ReadLn(Config.User.TimeSet.Hour);
                          Write('Enter FISRT login time in Minutes: ');
                          ReadLn(Config.User.TimeSet.Minuet);
                        End;
                   'D': Begin
                          WriteLn('         (24 HOUR TIME)');
                          Write('Enter LAST login time in Hours: ');
                          ReadLn(Config.User.TimeSet.Second);
                          Write('Enter LAST login time in Minutes: ');
                          ReadLn(Config.User.TimeSet.Hund);
                        End;
                   'E': Begin
                          Repeat
                            WriteLn('[0 = NORMAL  1 = IMMUNE  2 = GOD/IMMUNE  3 = EDIT/GOD/IMMUNE]');
                            Write('What type of user will ',Config.User.Name,' be? ');
                            ReadLn(Config.User.RunOut.DayOfWeek);
                            WriteLn;
                          Until Config.User.RunOut.DayOfWeek IN [0,1,2,3];
                        End;
                 End;
               Until (sel = 'A') or (sel = 'B') or (sel = 'C') or (sel = 'D') or
                     (sel = 'E') or (sel = 'Q')
             Until sel = 'Q';
             ReSet(f);
             Seek(f,loc);
             Write(f,Config);
             Close(f);
           End;
      End;
    End;
{//////////////////////////////////////////////////////////////}
  Procedure PrintSub;
    Var
      cntr: Integer;
      Config: SubScript;
    Begin
      cntr := 0;
      ReSet(f);
      Repeat
        inc(cntr,1);
        Seek(f,cntr);
        Read(f,Config);
        If Config.User.Name <> '' then
          Begin
            WriteLn('#',cntr);
            WriteLn('Name:  ',Config.User.Name);
            Write('Subscription expires on ',Config.User.RunOut.Month,'/',Config.User.RunOut.Day,'/');
            WriteLn(Config.User.RunOut.Year);
            Write('Can login from ',Config.User.TimeSet.Hour,':',Config.User.TimeSet.Minuet);
            WriteLn(' to ',Config.User.TimeSet.Second,':',Config.User.TimeSet.Hund);
            Case Config.User.RunOut.DayOfWeek of
              0: WriteLn('User is a NORMAL user.');
              1: WriteLn('User is IMMUNE to god commands.');
              2: WriteLn('User is a GOD and is IMMUNE.');
              3: WriteLn('User can EDIT subscriptions, is a GOD, and is IMMUNE.');
            End;
            WriteLn;
          End;
      Until cntr = MAX-1;
      Close(f);
      Write('Press [ENTER] to return to the main menu. . .');
      ReadLn;
    End;
{//////////////////////////////////////////////////////////////}
  Procedure RegSub;
    Var
      Pass: String47;
      f: File of SubScript;
      Config: SubScript;
      sel: Char;
    Begin
      Assign(f,'MULTINET.CFG');
      ReSet(f);
      Read(f,Config);
      Close(f);
      If Config.User.Name <> '' then
        Begin
          If PassEnCrypt(Config.User.Name,157) = User5 then
            WriteLn('You presently posess a 5 user license.') else
          If PassEnCrypt(Config.User.Name,101) = User10 then
            WriteLn('You presently posess a 10 user license.') else
          If PassEnCrypt(Config.User.Name,248) = User20 then
            WriteLn('You presently posess a 20 user license.') else
          If PassEnCrypt(Config.User.Name,85) = User50 then
            WriteLn('You presently posess a 50 user license.') else
          If PassEnCrypt(Config.User.Name,92) = UnLimit then
            WriteLn('You presently posess an unlimited user license.') else
          WriteLn('You presently posess a ''SHAREWARE'' 2 user license.');
        End
      Else WriteLn('You presently posess a ''SHAREWARE'' 2 user license.');
      Write('Do you wish to change this? [Y,N]: ');
      Repeat
        sel := UpCase(ReadKey);
      Until sel <> '';
      If sel = 'Y' then
        Begin
          WriteLn;
          WriteLn;
          Write('Enter in your NEW licensed password: ');
          ReadLn(Pass);
          For lcv := 1 to Length(Pass) do
            Pass[lcv] := UpCase(Pass[lcv]);
          If Pass <> '' then
            Begin
              If PassEnCrypt(Pass,157) = User5 then
                WriteLn('You have been GRANTED a 5 user license.') else
              If PassEnCrypt(Pass,101) = User10 then
                WriteLn('You have been GRANTED a 10 user license.') else
              If PassEnCrypt(Pass,248) = User20 then
                WriteLn('You have been GRANTED a 20 user license.') else
              If PassEnCrypt(Pass,85) = User50 then
                WriteLn('You have been GRANTED a 50 user license.') else
              If PassEnCrypt(Pass,92) = UnLimit then
                WriteLn('You have been GRANTED an unlimited user license.') else
              WriteLn('You have been GRANTED a ''SHAREWARE'' 2 user license.');
            End
          Else WriteLn('No license change!!');
          Delay(2000);
          If Pass <> '' then
            Begin
              Config.User.Name := Pass;
              ReSet(f);
              Write(f,Config);
              Close(f);
            End;
        End;
    End;
{//////////////////////////////////////////////////////////////}
  Begin
    Assign(f,'MULTINET.CFG');
    Repeat
      ClrScr;
      ReSet(f);
      Read(f,Config);
      Close(f);
      If EnCrypt(user) then Write('0.)  ')
        Else Write('     ');
      WriteLn('SubScriptions active: ',Config.Active);
      WriteLn('1.)  Add subscription');
      WriteLn('2.)  Delete subscription');
      WriteLn('3.)  Edit subscription');
      WriteLn('4.)  Display subscription list');
      WriteLn;
      WriteLn('5.)  License registation');
      WriteLn('6.)  Quit');
      WriteLn;
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        Case sel of
          '0': Begin
                 If EnCrypt(user) then
                   Begin
(*                     If Config.Active then Config.Active := FALSE
                       Else Config.Active := TRUE;*)
                     Config.Active := NOT Config.Active;
                     ReSet(f);
                     Write(f,Config);
                     Close(f);
                   End;
               End;
          '1': AddSub;
          '2': DeleteSub(Config);
          '3': EditSub;
          '4': PrintSub;
          '5': RegSub;
        End;
      Until (sel = '0') or (sel = '1') or (sel = '2') or (sel = '3') or
            (sel = '4') or (sel = '5') or (sel = '6');
    Until sel = '6';
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure LoadCfg(var Config:SubScript);
  Var
    f: File of SubScript;
    cntr: Integer;
    found: Boolean;
{//////////////////////////////////////////////////////////////}
  Function TimeChk: Boolean;
    Var
      h,m,s,hun: Word;
    Begin
      GetTime(h,m,s,hun);
      With Config.User.TimeSet do
        Begin
          If (Hour = 0) and (Minuet = 0) and (Second = 0) and (Hund = 0) then
            TimeChk := TRUE
          Else If ((Hour <= h) and (h <= Second)) and ((Minuet <= m) and (m <= Hund)) then
                 TimeChk := TRUE
               Else TimeChk := FALSE;
        End;
    End;
{//////////////////////////////////////////////////////////////}
  Function DateChk: Boolean;
    Var
      da,mon,yea,dow: Word;
    Begin
      GetDate(yea,mon,da,dow);
      With Config.User.RunOut do
        Begin
          If (Year = 0) and (Month = 0) and (Day = 0) then
            DateChk := TRUE
          Else If yea <= Year then
                 Begin
                   If yea = Year then
                     Begin
                       If mon <= Month then
                         Begin
                           If mon = Month then
                             Begin
                               If da <= Day then
                                 DateChk := TRUE
                               Else DateChk := FALSE;  (*day*)
                             End
                           Else DateChk := TRUE;  (*if curr month = run out month*)
                         End
                       Else DateChk := FALSE;  (*month*)
                     End
                   Else DateCHK := TRUE;  (*if curr year = run our year*)
                 End
               Else DateChk := FALSE;  (*year*)
        End;
    End;
{//////////////////////////////////////////////////////////////}
  Begin
    c(31,2,0);
    WriteLn('Scanning User List. . .');
    c(7,1,0);
    Assign(f,'MULTINET.CFG');
    {$I-}
    ReSet(f);
    Close(f);
    {$I+}
    If IOResult = 0 then
      Begin
        cntr := -1;
        found := FALSE;
        ReSet(f);
        Repeat
          inc(cntr,1);
          Seek(f,cntr);
          Read(f,Config);
          If Config.User.Name = user then found := TRUE;
          If (cntr = 0) and (NOT Config.Active) then found := TRUE;
        Until (found) or (cntr = MAX-1);
        Close(f);
        If (NOT found) and (NOT EnCrypt(user)) then
          Begin
            ClrScr;
            WriteLn('You will not be allowed access to MultiNet until you subscribe to it.');
            WriteLn('    Contact your SUPERVISOR for subscription information.');
            WriteLn;
            WriteLn;
            Sound(900);
            Delay(800);
            NoSound;
            Delay(1200);
            Halt;
          End;
        If NOT EnCrypt(user) then
          Begin
            If NOT TimeChk then
              Begin
                ClrScr;
                With Config.User.TimeSet do
                  Begin
                    WriteLn('You may only access MultiNet between the hours of ',Hour,':',Minuet,' & ',Second,':',Hund,'.');
                    WriteLn;
                    WriteLn;
                    Sound(900);
                    Delay(800);
                    NoSound;
                    Delay(1200);
                    Halt;
                  End;
              End;
            If NOT DateChk then
              Begin
                ClrScr;
                With Config.User.RunOut do
                  Begin
                    WriteLn('Your account expired on ',Month,'/',Day,'/',Year,'.');
                    WriteLn;
                    WriteLn;
                    Sound(900);
                    Delay(800);
                    NoSound;
                    Delay(1200);
                    Halt;
                  End;
              End;
          End;
      End
    Else Begin
           ClrScr;
           WriteLn;
           WriteLn('Your SUPERVISOR must initalize the subscription data base first.');
           WriteLn;
           WriteLn;
           Halt;
         End;
  End;
{//////////////////////////////////////////////////////////////////////}
Function GCheck(user:ST10): Boolean;
  Var
    lcv: Integer;
  Begin
    GCheck := FALSE;
    For lcv := 1 to Length(user)-2 do
      If (user[lcv] = 'G') and (user[lcv+1] = 'O') and (user[lcv+2] = 'D') then GCheck := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Intro;
{//////////////////////////////////////////////////////////////}
  Procedure Center(texts:String);
    Begin
      GotoXY(40-(Length(texts) div 2),WhereY);
      WriteLn(texts);
    End;
{//////////////////////////////////////////////////////////////}
  Function DC(texts:String): String;
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to Length(texts) do
        texts[lcv] := chr(ord(texts[lcv]) div 2);
      DC := texts;
    End;
{//////////////////////////////////////////////////////}
  Procedure Help;
    Begin
      c(8,1,0);
      ClrScr;
      c(14,2,0);
      WriteLn('Sepcial message commands:');
      c(15,2,0);
      WriteLn;
      Write(' - To send a private message, ');c(7,1,0);Write('(ie: to only one person) ');
      c(15,2,0);WriteLn('you use the format.');
      Write('     ');c(12,2,0);Write('!');c(10,2,0);Write('<');c(7,1,0);Write('user name');c(10,2,0);Write('> ');
      c(11,2,0);Write('"');c(7,1,0);Write('message');c(11,2,0);WriteLn('"');c(15,2,0);
      Write('          Example:  ');c(12,2,0);Write('!');c(10,2,0);Write('JOE ');c(11,2,0);
      WriteLn('How are you doing today');c(15,2,0);
      Write('       The message ');c(11,2,0);Write('"');c(7,1,0);Write('How are you doing today');c(11,2,0);Write('" ');
      c(15,2,0);Write('will only sent to ');c(10,2,0);Write('"');c(7,1,0);Write('JOE');c(10,2,0);WriteLn('"');c(15,2,0);
      WriteLn;
      Write(' - To call a user, ');c(7,1,0);Write('(ie: make another user aware that you want to talk) ');
      c(15,2,0);WriteLn('do this.');
      Write('     ');c(12,2,0);Write('#');c(10,2,0);Write('<');c(7,1,0);Write('user name');c(10,2,0);WriteLn('>');c(15,2,0);
      Write('          Example:  ');c(12,2,0);Write('#');c(10,2,0);WriteLn('JOE');c(15,2,0);
      Write('       ');c(10,2,0);Write('"');c(7,1,0);Write('JOE''s');c(10,2,0);Write('" ');
      c(15,2,0);WriteLn('computer will now beep a few times and display your name.');
      WriteLn;
      WriteLn;
      c(14,2,0);
      WriteLn('Sepcial conference commands:');
      c(15,2,0);
      WriteLn;
      Write(' - To create ');c(29,2,0);Write('YOUR ');c(15,2,0);Write('very own conference type ');c(11,2,0);Write('"');
      c(12,2,0);Write('-');c(7,1,0);Write('CREATE');c(11,2,0);Write('"');c(15,2,0);WriteLn(', then follow directions.');
      Write('          Example:  ');c(12,2,0);Write('-');c(10,2,0);WriteLn('CREATE');
      WriteLn;
      GotoXY(1,25);
      c(7,1,0);Write('Press ');c(8,2,0);Write('[');c(10,2,0);Write('ENTER');c(8,2,0);Write('] ');c(7,1,0);Write('to start ');
      c(12,2,0);Write('M');c(15,2,0);Write('ulti');c(9,2,0);Write('N');c(15,2,0);Write('et. . .');c(7,1,0);
      ReadLn;
    End;
{//////////////////////////////////////////////////////////////}
  Procedure WhatsNew;
    Begin
      c(8,1,0);
      ClrScr;
      c(15,2,0);
      WriteLn('Well here we are, I finally pulled myself together to finish v3.1');
      WriteLn('and to add in all the functions that have been requested by users.');
      WriteLn('     I hope everything works out the way I''ve planed it!!');
      WriteLn('If you have any questions or concerns e-mail me at csohns@kktv.com');
      WriteLn;
      c(12,2,0);
      WriteLn('Below is a list of bugs and fixes I have made to each version.');
      c(14,2,0);
      WriteLn('Version 3.1');
      c(7,1,0);
      WriteLn('     User scanning speed is increased by 4037%');
      WriteLn('     Performance speed checking is increased by 852%');
      WriteLn('     A user list has been added');
      WriteLn('     Subscription experation dates and login times now work');
      WriteLn('     User access level added to subscription');
      WriteLn('     Added an optional SILENT login process for GOD users');
      WriteLn('     Addition of password protection for private conferences');
      c(14,2,0);
      WriteLn('Version 3.0');
      c(7,1,0);
      WriteLn('     Addition of help and whats new areas to help new users');
      WriteLn('     Private messages now work along with calling other users');
      WriteLn('     Upped the average message transfer speed by 5%');
      WriteLn('     Subscriptions added but experation date and login times don''t work');
      c(14,2,0);
      WriteLn('Version 2.5');
      c(7,1,0);
      WriteLn('     You are now able to create conferences');
      WriteLn('     Messages are now encrypted using DES');
      WriteLn;
      WriteLn('Press [ENTER] to continue. . .');
      ReadLn;
      WriteLn;
      c(14,2,0);
      WriteLn('Version 2.1');
      c(7,1,0);
      WriteLn('     Alieses are no longer allowed, for security reasons');
      WriteLn('     Message speed is now 20% faster than in v2.0');
      c(14,2,0);
      WriteLn('Version 2.0');
      c(7,1,0);
      WriteLn('     Addition of conferences for differant user groups');
      WriteLn('     Message transfer rate broke the 2400bps barrier!!');
      c(14,2,0);
      WriteLn('Version 1.0');
      c(7,1,0);
      WriteLn('     Colorized all text for a more friendly user interface');
      WriteLn('     Now more than 2 users can communicate simotaniously');
      c(14,2,0);
      WriteLn('Version .96');
      c(7,1,0);
      WriteLn('     Total failure: transfer rate incleadbly slow!');
      c(14,2,0);
      WriteLn('Version .1');
      c(7,1,0);
      WriteLn('     Transfer from a 2 user NetTalk2 to a multi user MultiNet');
      WriteLn('                    (NEVER WORKED CORRECTLY!)');
      c(14,2,0);
      WriteLn('Pending UpGrades:');
      c(7,1,0);
      WriteLn('     Password protection for user created conferences.');
      WriteLn;
      c(15,2,0);
      WriteLn('Press [ENTER] to start MultiNet. . .');
      ReadLn;
    End;
{//////////////////////////////////////////////////////////////}
  Var
    lcv: Integer;
    pass:STLOG;
    sel: Char;
  Begin
    c(8,1,0);
    ClrScr;
    pass := '';
    c(10,2,4);
    Center(DC('@öÍÿË“ú Ë@¨ ‰Ê“ﬁ‹@f\d@'));
    c(7,1,0);
    Center(DC('Üﬁ‡ÚÓ‰ﬁ‹Œ@brrl'));
    c(15,2,1);
    Center('Release date: 01/06/1997');
    c(7,1,0);
    WriteLn;
    WriteLn;
    WriteLn(DC('®–“Ê@‡‰ﬁŒ‰¬⁄@“Ê@» Ê“Œ‹ »@Ëﬁ@¬ÿÿﬁÓ@‹ ËÓﬁ‰÷@ÍÊ ‰Ê@Ëﬁ@∆ﬁ⁄⁄Í‹“∆¬Ë @ƒ ËÓ  ‹'));
    WriteLn(DC(' ¬∆–@ﬁË– ‰\@@®– ‰ @“Ê@‹ﬁ@ÿ“⁄“Ë@ﬁ‹@Ë– @‹Í⁄ƒ ‰@ﬁÃ@ÍÊ ‰Ê@¬Ë@ﬁ‹ @Œ“Ï ‹@Ë“⁄ \'));
    WriteLn;
    WriteLn(DC('§ ‚Í“‰⁄ ‹ËÊt@@¶ﬁ⁄ @Êﬁ‰Ë@ﬁÃ@Ã“ÿ @Ê–¬‰“‹Œ@⁄ Ë–ﬁ»@⁄ÍÊË@ƒ @“‹@ÍÊ X@Ó ¬Ë– ‰@ﬁ‰@‹ﬁË'));
    WriteLn(DC('@@@@@@@@@@@@@@“ËNÊ@àû¶NÊ@íú®ä§òúñ\ä∞ä@¬‹»@¶êÇ§ä\ä∞ä@ﬁ‰@¬@‹ ËÓﬁ‰÷@‡‰ﬁËﬁ∆¬ÿ'));
    WriteLn(DC('@@@@@@@@@@@@@@»ﬁ Ê‹NË@⁄¬ËË ‰@ﬁ‹ @ƒ“ËBB'));
    WriteLn;
    WriteLn;
    c(4,2,0);
    Center(DC('Ü§äàí®¶'));
    WriteLn;
    c(14,2,0);
    Center(DC('û‰“Œ“‹¬ÿ@í» ¬t@@îﬁÊ–@¶‹Ú» ‰@@Pú Ë®¬ÿ÷R'));
    WriteLn;
    c(9,2,0);
    Center(DC('†‰ﬁŒ‰¬⁄⁄“‹Œt@@Ü–‰“Ê@¶ﬁ–‹Ê'));
    Center(DC('à Ê“Œ‹t@@Ü–‰“Ê@¶ﬁ–‹Ê'));
    WriteLn;
    c(5,2,0);
    Center(DC('®ä¶®íúé'));
    c(9,2,0);
    Center(DC('Ü–‰“Ê@¶ﬁ–‹Ê'));
    Center(DC('à¬‹@@¶Íÿÿ“Ï¬‹'));
    c(7,1,0);
    GotoXY(1,25);
    Write(DC('†‰ ÊÊ@∂äú®ä§∫@Ëﬁ@∆ﬁ‹Ë“‹Í \@\@\'));
    c(15,2,0);
    Write(' , H for help, or N for Whats New');
    c(7,1,0);
{
    answerLogInVis(pass,WhereX,WhereY);
    For lcv := 1 to Length(pass) do
      pass[lcv] := UpCase(pass[lcv]);
    For lcv := 1 to Length(pass) do
      pass[lcv] := chr(ord(pass[lcv])+6);
}
    Repeat
      sel := ReadKey;
    Until sel <> '';
    sel := UpCase(sel);
    Case sel of
      'H': Help;
      'N': WhatsNew;
    End;
(*    If {(pass = 'IHOGJ') and} (EnCrypt(user)) then reg := TRUE
      Else reg := FALSE;*)
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
              lcv, loc: Integer;
         Begin
              loc := 0;
              If (BoxVar = 'B') or (BoxVar = 'O') then
              Begin
                   If X = 0 then
                        Begin
                             X := (Trunc(40 - (Length(texts) div 2)));
                             loc := (X + Length(texts)) + 2;
                             GotoXY(X, Y);
                        End
                   Else GotoXY(X, Y);
                   c(14,2,1);
                   Write('…');
                   For lcv := 1 to long + 2 do
                        Write('Õ');
                   WriteLn('ª');
              End;
              If X = 0 then
                   Begin
                        X := (Trunc(40 - (Length(texts) div 2)));
                        GotoXY(X, Y + 1);
                   End
              Else GotoXY(X, Y + 1);
              c(14,2,1);
              Write('∫ ');
              c(7,2,1);
              Write(texts);
              spa(long - Length(texts));
              c(14,2,1);
              GotoXY(X + (long + 2), Y + 1);
              Write(' ∫');
              If (BoxVar = 'E') or (BoxVar = 'O') then
              Begin
                   GotoXY(X, Y + 2);
                   c(14, 2, 1);
                   Write('»');
                   For lcv := 1 to long + 2 do
                        Write('Õ');
                   WriteLn('º');
              End;
              If loc <> 0 then
                   GotoXY(loc, Y + 1);
              c(7,1,0);
         End;
{//////////////////////////////////////////////////////////////////////}
(*Function ExtStr(i : byte) : string;
var
 s : string[3];
begin
  Str(i,s);
  ExtStr := s;
end;*)
{//////////////////////////////////////////////////////////////////////}
Function Incoming_Message : Boolean;
  Var
    info : SearchRec;
  Begin
    FindFirst(confname,anyfile,info);
    If DosError = 0 then
      Begin
        If info.Time <> OldfTime then
          Begin
            OldfTime := info.Time;
            Incoming_Message := TRUE;
          End
          Else Incoming_Message := FALSE;
      End
    Else Incoming_Message := FALSE;
  End;
(*  Var
    f: Text;
  Begin
    Assign(f,confname);
    {$I-}
    ReSet(f);
    Close(f);
    {$I+}
    incoming_message := IOResult = 0;
  End;*)
{//////////////////////////////////////////////////////////////////////}
Procedure EraseF(filename : ST11);
  Var
    f : File;
  Begin
    Assign(f,filename);
    Erase(f);
  End;
{//////////////////////////////////////////////////////////////////////}
Function Next_Message : string;
  Var
    f : Text;
    texts: ST70;
    lcv: Integer;
  Begin
    Assign(f,confname);
    Reset(f);
    ReadLn(f, texts);
    Close(f);
    For lcv := 1 to Length(texts) do
      texts[lcv] := chr(ord(texts[lcv])-88);
    Next_Message := texts;
{    EraseF(confname);}
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Send_Message(texts : ST70);
  Var
  f,a : Text;
  ConName: String;
  info : SearchRec;
  lcv: Integer;
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := chr(ord(texts[lcv])+88);
    ConName := confname;
    Delete(ConName,Length(ConName)-3,Length(ConName));
    Assign(f,confname);
    ReWrite(f);
    WriteLn(f,texts);
    Close(f);
    If tablefile then
      Begin
        Assign(a,ConName+'.TBL');
        {$I-}
        ReSet(a);
        Close(a);
        {$I+}
        If IOResult = 0 then
          Begin
            Append(a);
            WriteLn(a,texts);
            Close(a);
          End
        Else Begin
               ReWrite(a);
               WriteLn(a,texts);
               Close(a);
             End;
      End;
    Delay(200);
{    EraseF(confname);}
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure InitScreen;
  Var
    ConName: String;
  Begin
    wX := 1;
    wY := 1;
    ClrScr;
    If immune then
      c(15,2,5)
    Else c(15,2,4);
    Write('                                   MULTINET                                v3.2 ');
    Box(1,2,76,'','B');
    Box(1,3,76,'','C');
    Box(1,4,76,'','C');
    Box(1,5,76,'','C');
    Box(1,6,76,'','C');
    Box(1,7,76,'','C');
    Box(1,8,76,'','C');
    Box(1,9,76,'','C');
    Box(1,10,76,'','C');
    Box(1,11,76,'','C');
    Box(1,12,76,'','C');
    Box(1,13,76,'','C');
    Box(1,14,76,'','E');
    ConName := confname;
    Delete(ConName,Length(ConName)-3,Length(ConName));
    GotoXY(40-(Length(ConName) div 2),2);
    c(8,1,3);
    Write(ConName);
(*    GotoXY(80-9,16);      {SLOW SPEED TESTER  (calculations/second)}
    Write(Speed,' bps');*)
    GotoXY(80-9,16);      {FAST SPEED TESTER  (files/second)}
    Write(Speed,' F/S');
    c(7,1,0);
    If reg then
      Begin
        c(9,1,4);
      End
    Else c(8,1,3);
    GotoXY(2,16);
    Write(user);
    c(7,1,0);
    GotoXY(2,17);
    Write('Commands:  -EXIT (leaves program),  -JOIN (change conference),  -UL (user list)');
    If confname <> 'PUBLIC.DAT' then
      WriteLn('           -PUBLIC (return to public conference)')
    Else WriteLn;
    WriteLn('Enter message:');
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure JoinConf;
{//////////////////////////////////////////////////////////////}
  Function AlExist(ConName:ST8): Boolean;
    Var
      f: Text;
    Begin
      For lcv := 1 to Length(ConName) do
        ConName[lcv] := chr(ord(ConName[lcv])-51);
      Assign(f,ConName+'.DAT');
      {$I-}
      ReSet(f);
      Close(f);
      {$I+}
      If IOResult = 0 then AlExist := TRUE
        Else ALExist := FALSE;
    End;
{//////////////////////////////////////////////////////////////}
  Var
    lcv: Integer;
    ConName: ST8;
    good: Boolean;
    pass: ST17;
    f: Text;           {|   Password Protection}
    first: Boolean;    {|        Variables     }
    CurrPass: ST17;    {|                      }
    confname2: String; {|                      }
  Begin
    good := FALSE;
    GotoXY(2,17);
    For lcv := 1 to 78 do
      Write(' ');
    WriteLn;
    For lcv := 1 to 40 do
      Write(' ');
    GotoXY(1,17);
    WriteLn('Public chat rooms availible :  PROGRAM (For all programers),');
    WriteLn('    GEEK (For all computer "GODS"), SC (Stage Crew [password protected],');
    WriteLn('    TEACHER (For all teachers), EXTRA (anything you want it for)');
    WriteLn;
    WriteLn('Private chat rooms availible:  PRIV1, PRIV2, PRIV3, PRIV4');
    WriteLn;
    WriteLn('Enter conference name:');
    GotoXY(1,20);
    For lcv := 1 to 74 do
      Write(' ');
    GotoXY(2,24);
    Write('> ');
    answer8(ConName,WhereX,WhereY);
    WriteLn;
    For lcv := 1 to Length(ConName) do
      ConName[lcv] := UpCase(ConName[lcv]);
    For lcv := 1 to Length(ConName) do
      ConName[lcv] := chr(ord(ConName[lcv])+51);
    If ConName = 'Éàu|v' then good := TRUE
      Else If ConName = 'vvzÇwvv' then good := TRUE
        Else If ConName = 'Üv' then good := TRUE
          Else If ConName = 'zxx~' then good := TRUE
            Else If ConName = 'ÉÖÇzÖtÄ' then good := TRUE
              Else If ConName = 'xãáÖt' then good := TRUE
                Else If ConName = 'ÉÖ|âd' then good := TRUE
                  Else If ConName = 'ÉÖ|âe' then good := TRUE
                    Else If ConName = 'ÉÖ|âf' then good := TRUE
                      Else If ConName = 'ÉÖ|âg' then good := TRUE
                        Else If ConName = 'áxtv{xÖ' then good := TRUE
                          Else If ConName = 'áxv{ÅÇ' then good := TRUE
                            Else If AlExist(ConName) then good := TRUE
                              Else Begin
                                     Sound(950);
                                     Write('Conference does not exist!!');
                                     Delay(500);
                                     NoSound;
                                     Delay(2000);
                                  End;
    If ConName = 'Üv' then
      Begin
        GotoXY(2,25);
        Write('Enter in password:  ');
        answer17(pass,WhereX,WhereY);
        For lcv := 1 to Length(pass) do
          pass[lcv] := UpCase(pass[lcv]);
        For lcv := 1 to Length(pass) do
          pass[lcv] := chr(ord(pass[lcv])+242);
        If pass <> '57DF'+chr(18)+'5:7I' then
          Begin
            WriteLn('        INCORRECT PASSWORD!');
            Sound(950);
            Delay(500);
            NoSound;
            good := FALSE;
          End;
      End;
    If good then
      Begin
        For lcv := 1 to Length(ConName) do
          ConName[lcv] := chr(ord(ConName[lcv])-51);
        If NOT silent then Send_Message(user+' has joined another conference.');
        If ((ConName = 'PRIV1') or (ConName = 'PRIV2') or (ConName = 'PRIV3') or
           (ConName = 'PRIV4')) and (AccessLvl <= 1) then
          Begin
            first := TRUE;
            confname2 := confname;
            confname := ConName+'.DAT';
            Assign(f,ConName+'.USR');
            ReWrite(f);
            Close(f);
            Send_Message('*çä}âç}ãå');
            Delay(1000);
            ReSet(f);
            If NOT EOF(f) then first := FALSE;
            Close(f);
            Erase(f);
            If first then
              Begin
                Assign(f,ConName+'.PAS');
                GotoXY(WhereX + 10,WhereY - 1);
                Write('You are the first to enter this conference!');
                GotoXY(2,25);
                Write('Enter in a NEW password [just press ENTER for no password]:  ');
                answer17(pass,WhereX,WhereY);
                If pass <> '' then
                  Begin
                    For lcv := 1 to Length(pass) do
                      pass[lcv] := UpCase(pass[lcv]);
                    For lcv := 1 to Length(pass) do
                      pass[lcv] := chr(ord(pass[lcv])-65);
                    ReWrite(f);
                    WriteLn(f,pass);
                    Close(f);
                  End;
                confname := ConName + '.DAT';
              End
            Else Begin
                   Assign(f,ConName+'.PAS');
                   GotoXY(2,25);
                   {$I-}
                   ReSet(f);
                   Close(f);
                   {$I+}
                   If IOResult = 0 then
                     Begin
                       Write('Enter in password:  ');
                       answer17(pass,WhereX,WhereY);
                       For lcv := 1 to Length(pass) do
                         pass[lcv] := UpCase(pass[lcv]);
                       For lcv := 1 to Length(pass) do
                         pass[lcv] := chr(ord(pass[lcv])-65);
                       ReSet(f);
                       ReadLn(f,Currpass);
                       Close(f);
                       If pass = CurrPass then
                         confname := ConName + '.DAT'
                       Else Begin
                              confname := confname2;
                              Send_Message(user+' FAILED the password check for '+ConName+'!');
                            End;
                     End
                   Else confname := ConName + '.DAT';
                 End;
          End
        Else confname := ConName + '.DAT';
        If NOT silent then Send_Message(user+' has entered this conference.');
      End;
    NewMessage := TRUE;
    InitScreen;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure CreateConf;
{//////////////////////////////////////////////////////////////}
  Function Exist(ConName:ST8): Boolean;
{//////////////////////////////////////////////////////}
    Function AlExist: Boolean;
      Var
        f: Text;
      Begin
        For lcv := 1 to Length(ConName) do
          ConName[lcv] := chr(ord(ConName[lcv])-51);
        Assign(f,ConName+'.DAT');
        {$I-}
        ReSet(f);
        Close(f);
        {$I+}
        If IOResult = 0 then AlExist := TRUE
          Else ALExist := FALSE;
      End;
{//////////////////////////////////////////////////////}
    Begin
      Exist := TRUE;
      If (ConName <> 'Éàu|v') and (ConName <> 'vvzÇwvv') and
         (ConName <> 'Üv') and (ConName <> 'zxx~') and
         (ConName <> 'ÉÖÇzÖtÄ') and (ConName <> 'xãáÖt') and
         (ConName <> 'ÉÖ|âd') and (ConName <> 'ÉÖ|âe') and
         (ConName <> 'ÉÖ|âf') and (ConName <> 'ÉÖ|âg') and
         (ConName <> 'áxtv{xÖ') and (ConName <> 'áxv{ÅÇ') and
         (NOT AlExist) then Exist := FALSE;
    End;
{//////////////////////////////////////////////////////////////}
  Var
    lcv: Integer;
    ConName: ST8;
    good: Boolean;
    f: Text;
    Oldconfname: ST11;
  Begin
    good := FALSE;
    GotoXY(2,17);
    For lcv := 1 to 70 do
      Write(' ');
    WriteLn;
    For lcv := 1 to 40 do
      Write(' ');
    GotoXY(1,17);
    WriteLn('In order to create a conference, you must enter a valid, 1-8 letter/number name.');
    WriteLn('    (The conference name MUST start with a letter!)');
    WriteLn;
    WriteLn('Enter NEW conference name:');
    GotoXY(1,20);
    For lcv := 1 to 74 do
      Write(' ');
    GotoXY(2,22);
    Write(': ');
    answer8(ConName,WhereX,WhereY);
    WriteLn;
    If (ConName <> '') and (ConName[1] <> ' ') then
      Begin
        For lcv := 1 to Length(ConName) do
          ConName[lcv] := UpCase(ConName[lcv]);
        For lcv := 1 to Length(ConName) do
          ConName[lcv] := chr(ord(ConName[lcv])+51);
        IF NOT Exist(ConName) then
          Begin
            For lcv := 1 to Length(ConName) do
              ConName[lcv] := chr(ord(ConName[lcv])-51);
            Assign(f,ConName+'.DAT');
            ReWrite(f);
            Close(f);
            Oldconfname := confname;
            confname := ConName + '.DAT';
            Send_Message(user + ' created this conference.');
            confname := Oldconfname;
          End
        Else Begin
               WriteLn;
               Sound(950);
               WriteLn('Conference already existes!!');
               Delay(500);
               NoSound;
            End;
      End;
    InitScreen;
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure UserRequest;
  Var
    f: Text;
    lcv: Integer;
    Line: String;
    ConName: String;
  Begin
    ConName := confname;
    Delete(ConName,Length(ConName)-3,Length(ConName));
    Assign(f,ConName+'.USR');
    ReWrite(f);
    Close(f);
    Send_Message('*çä}âç}ãå');
    Delay(1000);
    {$I-}
    ReSet(f);
    Close(f);
    {$I+}
    If IOResult = 0 then
      Begin
        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);
        ReSet(f);
        While NOT EOF(f) do
          Begin
            ReadLn(f,Line);
            WriteLn(Line);
          End;
        Close(f);
        Erase(f);
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
      End;
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure NetTalk2Command(texts:ST70);
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := UpCase(texts[lcv]);
    If texts = '-EXIT' then done := TRUE;
    If texts = '-JOIN' then JoinConf;
    If texts = '-PUBLIC' then Begin
                                If NOT silent then Send_Message(user+' has returned to the PUBLIC conference.');
                                confname := 'PUBLIC.DAT';
                                If NOT silent then Send_Message(user+' has re-entered this conference.');
                                NewMessage := TRUE;
                                InitScreen;
                              End;
    If reg then If texts = '-CREATE' then CreateConf;
    If texts = '-UL' then UserRequest;
  End;
{//////////////////////////////////////////////////////////////////////}
Function UVerify(code:String;loc:Integer): Boolean;
  Var
    UName:ST10;
  Begin
    UName := Copy(code,loc,Length(user));
    If (user = UName) or (UName = 'ALL') then
      UVerify := TRUE
    Else UVerify := FALSE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Evict(DestUser:ST10);
  Begin
    If UVerify(DestUser,1) then
      Begin
{        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);}
        WriteLn('"GOD": You have been EVICTED back to the PUBLIC conference.');
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
        Delay(200);
        Send_Message('"GOD" has EVICTED '+DestUser+' back to the PUBLIC conference.');
        confname := 'PUBLIC.DAT';
        Send_Message('"GOD" has EVICTED '+DestUser+' back to this conference.');
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);
        NewMessage := TRUE;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Drop(DestUser:ST10);
  Begin
    If UVerify(DestUser,1) then
      Begin
{        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);}
        WriteLn('"GOD": You are being LOGGED OFF for your actions!!');
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
        Delay(200);
        Send_Message('"GOD" has LOGGED OFF '+DestUser+'.');
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Delay(2000);
        ClrScr;
        Halt;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Screw(DestUser:ST10);
  Var
    colT,colB,X,Y,ch,sou: Integer;
  Begin
    If UVerify(DestUser,1) then
      Begin
{        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);}
        WriteLn('"GOD": You are SCREWED!!');
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
        Delay(200);
        Send_Message('"GOD" has SCREWED UP '+DestUser+'.  (Just for the FUN of it!!)');
{        GotoXY(X,Y);}
        NewMessage := FALSE;
        Randomize;
        Repeat
          colT := Random(31)+1;
          colB := Random(16)+1;
          X := Random(80)+1;
          Y := Random(24)+1;
          ch := Random(190)+65;
          sou := Random(1000)+37;
          GotoXY(X,Y);
          TextColor(colT);
          TextBackground(colB);
          Write(char(ch));
          Sound(sou);
          Delay(20);
          NoSound;
        Until NewMessage;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure LogOff(DestUser : string);
  Begin
    If UVerify(DestUser,1) then
      Begin
{        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);}
        WriteLn('"GOD": YOU HAVE PISSED ME OFF ENOUGH!!');
        Delay(2000);
        WriteLn('"GOD": I am now logging you off of the network!!!!');
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
        Delay(200);
        Send_Message('"GOD" has LOGGED '+DestUser+' OFF of the NETWORK.');
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Delay(1);
        Sound(960);
        Delay(500);
        NoSound;
        Delay(2000);
        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);
        DetachFromFileServer(connectionnumber);
{        NewMessage := TRUE;
        InitScreen;}
      End;
End;
{//////////////////////////////////////////////////////////////////////}
Procedure ReBoot; Assembler;
Asm
  mov ax,0
  mov ds,ax
  mov ax,1234
  mov [72],ax
{  jmp ffff:0}
End;
{//////////////////////////////////////////////////////////////////////}
Procedure RBoot(DestUser : string);
  Begin
    If UVerify(DestUser,1) then
      Begin
{        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);}
        WriteLn('"GOD": YOU HAVE PISSED ME OFF TOO MUCH!!');
        Delay(2000);
        WriteLn('"GOD": I am now re-setting YOUR computer!!!!');
{        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);}
        Delay(200);
        Send_Message('"GOD" has RE-SET '+DestUser+'''s computer.');
        ReBoot;
{        NewMessage := TRUE;
        InitScreen;}
      End;
End;
{//////////////////////////////////////////////////////////////////////}
Procedure SendName;
  Var
    f: Text;
    ConName: String;
  Begin
    ConName := confname;
    Delete(ConName,Length(ConName)-3,Length(ConName));
    Assign(f,ConName+'.USR');
    {$I-}
    ReSet(f);
    Close(f);
    {$I+}
    If IOResult = 0 then
      Begin
        Append(f);
        WriteLn(f,user);
        Close(f);
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure GetGodCommand(Rmessage:String);
  Var
    lcv: Integer;
    Command: String;
    DestUser: ST10;
  Begin
    lcv := 0;
    Command := '';
    DestUser := '';
    Repeat
      inc(lcv,1);
      Command := Command + Rmessage[lcv];
    Until (Rmessage[lcv+1] = 'X') or (lcv = Length(Rmessage));
    Delete(Rmessage,1,Length(Command)+1);
    DestUser := Rmessage;
    For lcv := 1 to Length(DestUser) do
      DestUser[lcv] := chr(ord(DestUser[lcv])-56);
    If (Command = '*}éÅ{å') and (NOT immune) then Evict(DestUser);
    If (Command = '*|äáà') and (NOT immune) then Drop(DestUser);
    If (Command = '*ã{ä}è') and (NOT immune) then Screw(DestUser);
    If (Command = '*Ñáá~~') and (NOT immune) then LogOff(DestUser);
    If (Command = '*çä}âç}ãå') and (NOT silent) then SendName;
{    c(7,1,0);
    wX := WhereX;
    wY := WhereY;
    Window(1,1,80,25);
    GotoXY(X,Y);
    InitScreen;
    NewMessage := TRUE;}
    c(7,1,0);
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure SendGodCommand(texts:ST70);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := UpCase(texts[lcv]);
    For lcv := 2 to Length(texts) do
      texts[lcv] := chr(ord(texts[lcv])+56);
    Send_Message(texts);
{    InitScreen;}
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure GetPriv(Rmessage:String);
  Begin
    If UVerify(Rmessage,2) then
      Begin
        Delete(Rmessage,1,Length(user)+1);
        If Rmessage[1] = ' ' then
          Begin
            Delete(Rmessage,1,1);
            WriteLn(Rmessage);
          End;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure SendPriv(texts:ST70);
  Var
    lcv: Integer;
    DestUser: ST10;
  Begin
    Delete(texts,1,1);
    lcv := 0;
    DestUser := '';
    Repeat
      inc(lcv,1);
      DestUser := DestUser + texts[lcv];
    Until (texts[lcv+1] = ' ') or (lcv = Length(texts));
    For lcv := 1 to Length(DestUser) do
      DestUser[lcv] := UpCase(DestUser[lcv]);
    Delete(texts,1,Length(DestUser)+1);
    Send_Message('!' + DestUser + ' ' + user + ': ' + texts);
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure GetCall(Rmessage:String);
  Begin
    If UVerify(Rmessage,2) then
      Begin
        Delete(Rmessage,1,Length(user)+1);
        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);
        WriteLn('You are being called by ',Rmessage);
{        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);}
        Sound(666);
        Delay(500);
        NoSound;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure SendCall(texts:ST70);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := UpCase(texts[lcv]);
    Send_Message(texts + user);
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure GetImmunity(Rmessage:String);
  Var
    lcv: Integer;
  Begin
    Delete(Rmessage,1,1);
    If Rmessage <> 'ALL' then
    If UVerify(Rmessage,1) then
      Begin
(*        For lcv := 1 to Length(Rmessage) do
          Rmessage[lcv] := chr(ord(Rmessage[lcv])+42);
        If (Rmessage = 'm}yrx}') or {}(Rmessage = 'Åszzo|') or
           (Rmessage = '{k}k|wkx') or (Rmessage = 'nkx}'){}
           (Rmessage = 'mrmu') or (Rmessage = '}zo|Äs}y|') then*)
        If (EnCrypt(user)) or (AccessLvl >= 2) then
          Begin
{            Window(3,3,78,15);
            GotoXY(wX,wY);
            c(15,2,1);}
            WriteLn('Someone has TRIED to remove your immunity.');
{            c(7,1,0);
            wX := WhereX;
            wY := WhereY;
            Window(1,1,80,25);
            GotoXY(X,Y);}
            Sound(666);
            Delay(500);
            NoSound;
{            InitScreen;}
{            NewMessage := TRUE;}
          End
        Else If immune = FALSE then
               Begin
                 immune := TRUE;
                 c(7,1,0);
                 wX := WhereX;
                 wY := WhereY;
                 Window(1,1,80,25);
                 GotoXY(1,1);
                 If immune then
                   c(15,2,5)
                 Else c(15,2,4);
                 Write('                                   MULTINET                                v3.2 ');
                 Window(3,3,78,15);
                 GotoXY(wX,wY);
                 c(15,2,1);
                 {NewMessage := TRUE;}
               End
               Else Begin
                      immune := FALSE;
                      c(7,1,0);
                      wX := WhereX;
                      wY := WhereY;
                      Window(1,1,80,25);
                      GotoXY(1,1);
                      If immune then
                        c(15,2,5)
                      Else c(15,2,4);
                      Write('                                   MULTINET                                v3.2 ');
                      Window(3,3,78,15);
                      GotoXY(wX,wY);
                      c(15,2,1);
                      {NewMessage := TRUE;}
                    End;
      End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure OverImmune(DestUser:ST10);
  Var
    pass: STLOG;
    lcv: Integer;
  Begin
      If DestUser <> '' then
        Begin
          If AccessLvl < 4 then
          Begin
          c(7,1,0);
          pass := '';
          WriteLn;
          Write(': ');
          answerLOGInVis(pass,WhereX,WhereY);
          For lcv := 1 to Length(pass) do
            pass[lcv] := UpCase(pass[lcv]);
          For lcv := 1 to Length(pass) do
            pass[lcv] := chr(ord(pass[lcv])+24);
          If pass = '^gj[]IIPQ\^`bcdk\' then Begin
                                               WriteLn('CODE ACCEPTED!');
                                               Send_Message('|'+DestUser);
                                               Delay(500);
                                               GotoXY(1,WhereY-1);
                                               For lcv := 1 to 20 do
                                                 Write(' ');
                                              End
            Else Begin
                   WriteLn('INVALID CODE!');
                   Delay(500);
                   GotoXY(1,WhereY-1);
                   For lcv := 1 to 20 do
                     Write(' ');
                 End;
          End
          Else Send_Message('|'+DestUser);
        End;
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Emulate(DestUser:ST10);
  Var
    pass: STLOG;
  Begin
    c(7,1,0);
    pass := '';
    WriteLn;
    Write(': ');
    answerLOG(pass,WhereX,WhereY);
    For lcv := 1 to Length(pass) do
      pass[lcv] := UpCase(pass[lcv]);
    GotoXY(1,WhereY);
    For lcv := 1 to 74 do
      Write(' ');
    c(14,2,1);
    GotoXY(2,16);
    For lcv := 1 to Length(user) do
      Begin
        Write('Õ');
      End;
    user := pass;
    If reg then
      Begin
        c(9,1,4);
      End
    Else c(8,1,3);
    GotoXY(2,16);
    Write(user);
    NewMessage := TRUE;
{    InitScreen;}
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure SendSpecial(message:ST70);
  Var
    lcv: Integer;
    Command: String;
    DestUser: ST10;
  Begin
    Command := '';
    DestUser := '';
    For lcv := 1 to Length(message) do
      message[lcv] := UpCase(message[lcv]);
    For lcv := 2 to Length(message) do
      message[lcv] := chr(ord(message[lcv])-17);
    lcv := 0;
    Repeat
      inc(lcv,1);
      Command := Command + message[lcv];
    Until (message[lcv+1] = '') or (lcv = Length(message));
    Delete(message,1,Length(Command)+1);
    DestUser := message;
    For lcv := 1 to Length(DestUser) do
      DestUser[lcv] := chr(ord(DestUser[lcv])+17);
    If Command = '|>E4AA834' then OverImmune(DestUser);
    If Command = '|4<D;0C4' then Emulate(DestUser);
{    If Command = '|4=3>F' then Endow(DestUser);}
    {InitScreen;}
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
  Procedure RegChk;
    Var
      f: Text;
      lcv: Integer;
      Line: String;
      cntr: Integer;
{//////////////////////////////////////////////////////////////}
    Function MaxConnect: Integer;
      Var
        f: File of SubScript;
        Config: SubScript;
        Pass: String47;
      Begin
        Assign(f,'MULTINET.CFG');
        ReSet(f);
        Read(f,Config);
        Close(f);
        If PassEnCrypt(Config.User.Name,157) = User5 then
          MaxConnect := 5 else
        If PassEnCrypt(Config.User.Name,101) = User10 then
          MaxConnect := 10 else
        If PassEnCrypt(Config.User.Name,248) = User20 then
          MaxConnect := 20 else
        If PassEnCrypt(Config.User.Name,85) = User50 then
          MaxConnect := 50 else
        If PassEnCrypt(Config.User.Name,92) = UnLimit then
          MaxConnect := 32767 else
        MaxConnect := 2;
      End;
{//////////////////////////////////////////////////////////////}
    Begin
      cntr := 0;
      Assign(f,'PUBLIC.USR');
      ReWrite(f);
      Close(f);
      Send_Message('*çä}âç}ãå');
      Delay(1000);
      {$I-}
      ReSet(f);
      Close(f);
      {$I+}
      If IOResult = 0 then
        Begin
          ReSet(f);
          While NOT EOF(f) do
            Begin
              ReadLn(f,Line);
              inc(cntr,1);
            End;
          Close(f);
          Erase(f);
          If cntr+1 > MaxConnect then
            Begin
              ClrScr;
              WriteLn('MultiNet is only licensed for ',MaxConnect, ' users to be connected at');
              WriteLn('one time, you are user #',MaxConnect+1,'.');
              WriteLn;
              WriteLn;
              Sound(900);
              Delay(800);
              NoSound;
              Delay(1200);
              Halt;
            End;
        End;
  End;
{//////////////////////////////////////////////////////////////////////}

Begin
  reg := FALSE;
  immune := FALSE;
  tablefile := TRUE;
  OldfTime:= 0;
  wX := 1;
  wY := 1;
  Rmessage := '';
  NewMessage := TRUE;
  done := FALSE;
  confname := 'PUBLIC.DAT';
  silent := FALSE;
  lcv := 0;
  Repeat
    c(7,1,0);
    ClrScr;
    inc(lcv,1);

    Write('Enter in your user name:  ');
    ReadLn(user);
{    answer10(user,WhereX, WhereY);

  GetConnectionInformation(connectionnumber,ObjectID,ObjectType,ObjectName,ObjectLogin);
  user := ObjectName;
}
  Until (user <> '') or (lcv = 800);
  If lcv = 800 then
    Begin
      ClrScr;
      Sound(900);
      Delay(500);
      NoSound;
      WriteLn;
      WriteLn('MultiNet has experenced some form of network error!');
      WriteLn('  This error could have been caused by executation on a standalone,');
      WriteLn('  or an incompatible network server.  MultiNet has only been tested on');
      WriteLn('  Novell v3.11 & v3.12 Servers, but SHOULD work on v2.x - v4.x servers.');
      WriteLn('                                              Shutting Down.');
      WriteLn;
      WriteLn;
      Halt;
    End;
  For lcv := 1 to Length(user) do
    user[lcv] := UpCase(user[lcv]);
  If GCheck(user) then Halt;
  If EnCrypt(user) then
    Begin
      If ParamCount > 0 then
        Begin
          If ParamStr(1) = '/INIT' then
            Begin
              InitCfg(Config);
              ClrScr;
              WriteLn;
              WriteLn('SubScription file has been created.');
              WriteLn;
              WriteLn;
              Halt;
            End;
        End;
    End;
  {If TrapCheck then }LoadCfg(Config);
  If EnCrypt(user) then AccessLvl := 4
    Else AccessLvl := Config.User.RunOut.DayOfWeek;
  Case AccessLvl of
    1: immune := TRUE;
    2..4: Begin
            reg := TRUE;
            immune := TRUE;
          End;
  End;
(*  If reg then immune := EnCrypt(user);*)  (*old GOD/IMMUNE access*)
  If (EnCrypt(user)) or (AccessLvl >= 2) then
    Begin
      If ParamCount > 0 then
        Begin
          If (ParamStr(1) = '/EDIT') and ((EnCrypt(user)) or (AccessLvl >= 3)) then
            Begin
              EditCfg(Config);
              Halt;
            End;
          If (ParamStr(1) = '/S') or (ParamStr(1) = '/s') then silent := TRUE;
        End;
    End;
  Speed := BPSChk;
  Intro;
  If AccessLvl <> 4 then RegChk;
  InitScreen;
  If NOT silent then Send_Message(user + ' has logged on.');
  Delay(200);
  Repeat
    If NewMessage then
      Begin
        c(7,1,0);
        message := '';
        GotoXY(4,20);
        For lcv := 2 to 74 do
          Write(' ');
        GotoXY(2,20);
        Write('> ');
        NewMessage := FALSE;
        X := WhereX;
        Y := WhereY;
      End;
    Repeat
      InMessage := Incoming_Message;
    Until keypressed or InMessage;
    If keypressed then
      Begin
        ch := Readkey;
        If ch <> #13 then
          Begin
            If ch = #8 then
              Begin
                delete(message, Length(message), Length(message));
                ch := #0;
                X := X - 1;
                If X < 4 then
                  Begin
                    X := 4;
                  End;
                GotoXY(X,Y);
                Write(' ');
                GotoXY(X,Y);
              End
            Else Begin
                   X := X + 1;
                   If X > 74 then
                     Begin
                       X := 74;
                       GotoXY(X,Y);
                       Sound(950);
                       Delay(1);
                       NoSound;
                     End
                   Else Begin
                          message := message + ch;
                          If (reg) and (message[1] = '*') then
                            c(8,1,0)
                          Else If (reg) and (message[1] = '|') then
                                 c(8,1,0)
                               Else c(7,1,0);
                          Write(ch);
                        End;
                 End
            End
        Else Begin
               Case message[1] of
                 '-': NetTalk2Command(message);
                 '!': SendPriv(message);
                 '*': If reg then SendGodCommand(message);
                 '#': SendCall(message);
                 '|': If reg then SendSpecial(message);
               Else Begin
                      If message <> '' then
                        Send_Message(user + ': ' + message);
                    End;
               End;
               NewMessage := TRUE;
             End;
      End;
    If InMessage then
      Begin
        Window(3,3,78,15);
        GotoXY(wX,wY);
        c(15,2,1);
        Rmessage := Next_Message;
        Case Rmessage[1] of
          '*': GetGodCommand(Rmessage);
          '!': GetPriv(Rmessage);
          '#': GetCall(Rmessage);
          '|': GetImmunity(Rmessage);
        Else {If NOT UVerify(Rmessage,1) then} WriteLn(Rmessage)
        End;
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
      End;
  Until done;
  If NOT silent then Send_Message(user + ' has logged off.');
  ClrScr;
End.