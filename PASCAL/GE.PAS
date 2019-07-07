Program Grant_Ease;

Uses
  CRT;

Type
  MenuString = String[29];
  Group = Array[1..20] of String[70];

Var
  List: Group;
  sel: Char;
{/////////////////////////////////////////////////////////////////////////}
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
{/////////////////////////////////////////////////////////////////////////}
Procedure BackDrop;
  Var                        {Creates menu background}
    lcv: Integer;
  Begin
    GotoXY(1,1);
    c(14,2,1);
    WriteLn('ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
    For lcv := 2 to 22 do
      Begin
        GotoXY(1, lcv);
        c(14,2,1);
        Write('º');
        c(3,2,1);
        Write('°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°');
        c(14,2,1);
        Write('º');
      End;
    Write('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
    c(7,0,0);
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure MenC(X, Y, long:Integer; sel:Char; texts:MenuString; MenVar:Char);
  Var
    lcv: Integer;
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
        c(14,2,1);
        Write('É');
        For lcv := 1 to long + 7 do
          Write('Í');
        WriteLn('»');
      End;
    GotoXY(X, Y + 1);
    c(14,2,1);
    Write('º ');
    c(2,2,1);
    Write('<');
    c(4,2,1);
    Write(sel);
    c(2,2,1);
    Write('>  ');
    c(7,2,1);
    Write(texts);
    spa(long - Length(texts));
    {spa(24 - Length(texts));}
    c(14,2,1);
    GotoXY(X + (long + 7), Y + 1);
    {GotoXY(X + 31, Y + 1);}
    Write(' º');
    If (MenVar = 'E') or (MenVar = 'O') then
      Begin
        GotoXY(X, Y + 2);
        c(14, 2, 1);
        Write('È');
        For lcv := 1 to long + 7 do
          Write('Í');
        WriteLn('¼');
        GotoXY(1,1);
      End;
    c(7,1,0);
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
{////////////////////////////////////////////////////////////////}
Procedure Status;
  Begin                        {Dysplays number of records and file name}
    GotoXY(1,24);
    c(15,2,4);
    Write('                                                                                ');
    GotoXY(1,24);
    Write('  Progran Design by:  Chris Sohns                              GRANT EASE  ');
    c(7,2,0);
    GotoXY(1,1);
  End;
{////////////////////////////////////////////////////////////////}
Procedure InitArray(var List:Group);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to 20 do
      List[lcv] := '';
  End;
{/////////////////////////////////////////////////////////////////////////}
Procedure Intro;
  Begin
    c(7,0,0);
    ClrScr;
    Delay(800);
    BackDrop;
    Status;
    Box(34,12,10,'Grant Ease','O');
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
{/////////////////////////////////////////////////////////////////////////}
Begin
  InitArray(List);
  Intro;
  Window(2,2,79,22);
  c(7,1,1);
  Repeat
    ClrScr;
    MenC(,11,,'B','Begin','B');
  Window(1,1,80,25);
  c(7,0,0);
  ClrScr;
End.