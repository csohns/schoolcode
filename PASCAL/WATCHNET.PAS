Program WATCHNET;

{Version 1.0  MULITNET monitoring program}

Uses
  CRT, DOS, ANSWERS;

Type
  ST70 = String[70];
  ST11 = String[11];

Var
  user: ST10;
  confname: ST11;
  lcv: Integer;
  message: ST70;
  Rmessage: String;
  OldfTime: Longint;
  NewMessage: Boolean;
  InMessage: Boolean;
  tablefile: Boolean;
  h,m,s,hund: Word;

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
Procedure Intro;
{//////////////////////////////////////////////////////////////}
  Procedure Center(texts:String);
    Begin
      GotoXY(40-(Length(texts) div 2),WhereY);
      WriteLn(texts);
    End;
{//////////////////////////////////////////////////////}
  Begin
    c(8,1,0);
    ClrScr;
    c(10,2,4);
    Center(' WATCHNET v1.0 ');
    c(7,1,0);
    WriteLn;
    WriteLn;
    WriteLn;
    Center('WatchNet is designed to diconnect all MultiNet v2.0 - v2.5 users.');
    WriteLn;
    c(8,1,0);
    Write(' ');
    GotoXY(WhereX-1,WhereY);
    c(7,1,0);
    Delay(4000);
  End;
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
Procedure SendGodCommand(texts:ST70);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := UpCase(texts[lcv]);
    Send_Message(texts);
    NewMessage := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}
Begin
  OldfTime:= 0;
  Rmessage := '';
  NewMessage := TRUE;
  confname := 'F:\PUBLIC.DAT';
  Intro;
  Repeat
    c(15,2,0);
    Write('Scanning. . .   ');
    lcv := 0;
    Repeat
      Case lcv of
        0: Begin
             GotoXY(WhereX-1,WhereY);
             Write('|');
           End;
      1000: Begin
             GotoXY(WhereX-1,WhereY);
             Write('/');
           End;
      2000: Begin
             GotoXY(WhereX-1,WhereY);
             Write('-');
           End;
      3000: Begin
             GotoXY(WhereX-1,WhereY);
             Write('\');
           End;
      End;
      InMessage := Incoming_Message;
      inc(lcv,1);
      If lcv > 4000 then lcv := 0;
    Until keypressed or InMessage;
    GetTime(h,m,s,hund);
    GotoXY(WhereX-1,WhereY);
    c(9,2,0);
    Write(h,':',m,':',s,'.',hund);
    c(7,1,0);
    WriteLn;
    message := Next_Message;
    If (message[1] <> '*') and (message[1] <> '"') then
      Begin
        SendGodCommand('*DROP ALL');
        For lcv := 80 to 520 do
          Begin
            Sound(lcv);
            Delay(1);
          End;
        For lcv := 520 downto 80 do
          Begin
            Sound(lcv);
            Delay(1);
          End;
        NoSound;
        c(12,2,0);
        WriteLn('GOT ONE!!');
        c(10,2,0);
        WriteLn(message);
        c(7,1,0);
      End;
  Until keypressed;
  c(7,1,0);
  ClrScr;
End.