Program MULTINET;

{Version 1.0  Total rewirte of NetTalk}
{Version 2.0  Addition of God Commands}
{Version 2.1  Now reads network user account names}

Uses
  CRT, DOS, ANSWERS, NovApi;

Type
  ST70 = String[70];
  ST11 = String[11];

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
    If (code = 'm}yrx}') or (code = 'Åszzo|') or (code = '{k}k|wkx') or
       (code = 'mrmu') or (code = 'kmu') or (code = 't}xÉno|') then
         EnCrypt := TRUE
    Else EnCrypt := FALSE;
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
  Var
    lcv: Integer;
    pass:STLOG;
  Begin
    ClrScr;
    pass := '';
    c(10,2,4);
    Center(DC('@öÍÿË“ú Ë@¨ ‰Ê“ﬁ‹@d\`@'));
    c(7,1,0);
    Center(DC('Üﬁ‡ÚÓ‰ﬁ‹Œ@brrl'));
    WriteLn;
    WriteLn;
    WriteLn(DC('®–“Ê@‡‰ﬁŒ‰¬⁄@“Ê@» Ê“Œ‹ »@Ëﬁ@¬ÿÿﬁÓ@‹ ËÓﬁ‰÷@ÍÊ ‰Ê@Ëﬁ@∆ﬁ⁄⁄Í‹“∆¬Ë @ƒ ËÓ  ‹'));
    WriteLn(DC(' ¬∆–@ﬁË– ‰\@@®– ‰ @“Ê@‹ﬁ@ÿ“⁄“Ë@ﬁ‹@Ë– @‹Í⁄ƒ ‰@ﬁÃ@ÍÊ ‰Ê@¬Ë@ﬁ‹ @Œ“Ï ‹@Ë“⁄ \'));
    WriteLn;
    WriteLn(DC('§ ‚Í“‰⁄ ‹ËÊt@@¶ﬁ⁄ @Êﬁ‰Ë@ﬁÃ@Ã“ÿ @Ê–¬‰“‹Œ@⁄ Ë–ﬁ»@⁄ÍÊË@ƒ @“‹@ÍÊ X@Ó Ë– ‰@ﬁ‰@‹ﬁË'));
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
{
    answerLogInVis(pass,WhereX,WhereY);
    For lcv := 1 to Length(pass) do
      pass[lcv] := UpCase(pass[lcv]);
    For lcv := 1 to Length(pass) do
      pass[lcv] := chr(ord(pass[lcv])+6);
}
    ReadLn;
    If {(pass = 'IHOGJ') and} (EnCrypt(user)) then reg := TRUE
      Else reg := FALSE;
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
    ClrScr;
    If immune then
      c(15,2,5)
    Else c(15,2,4);
    Write('                                   MULTINET                                v2.1 ');
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
    WriteLn('Commands:  -EXIT (leaves program),  -JOIN (change conference)');
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
        Send_Message(user+' has joined another conference.');
        confname := ConName + '.DAT';
        Send_Message(user+' has entered this conference.');
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
    InitScreen;
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
                                Send_Message(user+' has returned to the PUBLIC conference.');
                                confname := 'PUBLIC.DAT';
                                Send_Message(user+' has re-entered this conference.');
                                NewMessage := TRUE;
                                InitScreen;
                              End;
    If reg then If texts = '-CREATE' then CreateConf;
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
        swapvectors;
        exec(getenv('comspec'),'/C ' + 'G:\PUBLIC\LOGOUT.EXE');
        swapvectors;
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
        Send_Message('"GOD" has RE-SET '+DestUser+'''s computer.');
        ReBoot;
{        NewMessage := TRUE;
        InitScreen;}
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
    Until (Rmessage[lcv+1] = ' ') or (lcv = Length(Rmessage));
    Delete(Rmessage,1,Length(Command)+1);
    DestUser := Rmessage;
    If Command = '*EVICT' then Evict(DestUser);
    If Command = '*DROP' then Drop(DestUser);
    If Command = '*SCREW' then Screw(DestUser);
{    If Command = '*LOGOFF' then LogOff(DestUser);}
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
Procedure GetSpecial(Rmessage:String);
  Var
    lcv: Integer;
  Begin
    Delete(Rmessage,1,1);
    If UVerify(Rmessage,1) then
      Begin
        For lcv := 1 to Length(Rmessage) do
          Rmessage[lcv] := chr(ord(Rmessage[lcv])+42);
        If (Rmessage = 'm}yrx}') or (Rmessage = 'Åszzo|') or (Rmessage = '{k}k|wkx') then
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
                 Write('                                   MULTINET                                v2.1 ');
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
                      Write('                                   MULTINET                                v2.0 ');
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
    lcv := 0;
    Repeat
      inc(lcv,1);
      Command := Command + message[lcv];
    Until (message[lcv+1] = ' ') or (lcv = Length(message));
    Delete(message,1,Length(Command)+1);
    DestUser := message;
    If Command = '|OVERRIDE' then OverImmune(DestUser);
    If Command = '|EMULATE' then Emulate(DestUser);
{    If Command = '|ENDOW' then Endow(DestUser);}
    {InitScreen;}
    NewMessage := TRUE;
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
  Repeat
    c(7,1,0);
    ClrScr;
{
    Write('Enter in your user name:  ');
    answer10(user,WhereX, WhereY);
}
  GetConnectionInformation(connectionnumber,ObjectID,ObjectType,ObjectName,ObjectLogin);
  user := ObjectName;
  Until user <> '';
  For lcv := 1 to Length(user) do
    user[lcv] := UpCase(user[lcv]);
  If GCheck(user) then Halt;
  Intro;
  If reg then immune := EnCrypt(user);
  InitScreen;
  Send_Message(user + ' has logged on.');
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
          '*': If NOT immune then
                 GetGodCommand(Rmessage);
          '!': GetPriv(Rmessage);
          '#': GetCall(Rmessage);
          '|': GetSpecial(Rmessage);
        Else {If NOT UVerify(Rmessage,1) then} WriteLn(Rmessage)
        End;
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
      End;
  Until done;
  Send_Message(user + ' has logged off.');
  ClrScr;
End.