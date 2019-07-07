Program NETTALK2;

Uses
  CRT, DOS, ANSWERS;

Type
  ST70 = String[70];
  ST11 = String[11];

Var
  user: ST8;
  confname: ST11;
  lcv: Integer;
  ch: Char;
  message: ST70;
  X, Y, wX, wY: Integer;
  NewMessage, done: Boolean;

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
                   Write('É');
                   For lcv := 1 to long + 2 do
                        Write('Í');
                   WriteLn('»');
              End;
              If X = 0 then
                   Begin
                        X := (Trunc(40 - (Length(texts) div 2)));
                        GotoXY(X, Y + 1);
                   End
              Else GotoXY(X, Y + 1);
              c(14,2,1);
              Write('º ');
              c(7,2,1);
              Write(texts);
              spa(long - Length(texts));
              c(14,2,1);
              GotoXY(X + (long + 2), Y + 1);
              Write(' º');
              If (BoxVar = 'E') or (BoxVar = 'O') then
              Begin
                   GotoXY(X, Y + 2);
                   c(14, 2, 1);
                   Write('È');
                   For lcv := 1 to long + 2 do
                        Write('Í');
                   WriteLn('¼');
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
{var
  d : searchrec;
begin
  findfirst('MAIN.DAT',anyfile,d);
  incoming_message := doserror = 0;
end;}
  Var
    f: Text;
  Begin
    Assign(f,confname);
    {$I-}
    ReSet(f);
    Close(f);
    {$I+}
    incoming_message := IOResult = 0;
  End;
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
  Begin
    Assign(f,confname);
    Reset(f);
    ReadLn(f, texts);
    Close(f);
    Next_Message := texts;
{    EraseF(confname);}
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure Send_Message(texts : ST70);
  Var
  f : Text;
  Begin
    Assign(f,confname);
    ReWrite(f);
    WriteLn(f,texts);
    Close(f);
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure InitScreen;
  Begin
    ClrScr;
    c(15,2,4);
    Write('                                   NETTALK2                                v1.0 ');
    Box(1,2,76,'','B');
    Box(1,3,76,'','C');
    Box(1,4,76,'','C');
    Box(1,5,76,'','C');
    Box(1,6,76,'','C');
    Box(1,7,76,'','C');
    Box(1,8,76,'','C');
    Box(1,9,76,'','C');
    Box(1,10,76,'','C');
    Box(1,11,76,'','E');
  End;
{//////////////////////////////////////////////////////////////////////}
Procedure NetTalk2Command(texts:ST70);
  Begin
    For lcv := 1 to Length(texts) do
      texts[lcv] := UpCase(texts[lcv]);
      If texts = '-EXIT' then done := TRUE;
  End;
{//////////////////////////////////////////////////////////////////////}

Begin
  wX := 1;
  wY := 1;
  NewMessage := TRUE;
  done := FALSE;
  confname := 'MAIN.DAT';
  Repeat
    c(7,1,0);
    ClrScr;
    Write('Enter in your user name:  ');
    answer8(user,WhereX, WhereY);
  Until user <> '';
  For lcv := 1 to Length(user) do
    user[lcv] := UpCase(user[lcv]);
  InitScreen;
  Send_Message(user + ' has logged on.');
  Delay(200);
  GotoXY(2,16);
  WriteLn('Enter message:');
  Repeat
    If NewMessage then
      Begin
        message := '';
        GotoXY(4,17);
        For lcv := 2 to 74 do
          Write(' ');
        GotoXY(2,17);
        Write('> ');
        NewMessage := FALSE;
        X := WhereX;
        Y := WhereY;
      End;
    Repeat Until keypressed or incoming_message;
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
                          Write(ch);
                        End;
                 End
            End
        Else Begin
               Case message[1] of
                 '-': NetTalk2Command(message);
               Else Begin
                      If message <> '' then
                        Send_Message(user + ': ' + message);
                      Delay(200);
                    End;
               End;
               NewMessage := TRUE;
             End;
      End;
    If Incoming_Message then
      Begin
        Window(3,3,78,12);
        GotoXY(wX,wY);
        c(15,2,1);
        WriteLn(Next_Message);
        c(7,1,0);
        wX := WhereX;
        wY := WhereY;
        Window(1,1,80,25);
        GotoXY(X,Y);
      End;
  Until done;
  Send_Message(user + ' has logged off.');
End.