Program Zoo;

Uses CRT;

Type
    MenuString = String[29];
    STR20 = String[20];
    STR60 = String[60];
    ptr = ^nodetype;
    nodetype = record
                     info: STR20;
                     question: STR60;
                     N: ptr;
                     Y: ptr;
               end;
Var
     sel: Char;
     ch: String;
     root: ptr;
     LEVEL: Integer;

{///////////////////////////////////////////////////////////////////////}
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
          Write('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');          c(7,2,1);
          c(7,0,0);
     End;
{////////////////////////////////////////////////////////////////}
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
{///////////////////////////////////////////////////////////////////////}
Function YN(ques:String): Char;
     Var
          ans: Char;
     Begin
          Write(ques);
          c(5,1,0);
          Write('  [Y or N]:  ');
          Repeat
               ans := ReadKey;
          Until ((ans = 'Y') or (ans = 'y') or (ans = 'N') or (ans = 'n'));
          Write(ans);
          c(7,1,0);
          WriteLn;
          YN := UpCase(ans);
     End;
{///////////////////////////////////////////////////////////////////////}
Procedure Print(curr:ptr);
     Begin
          if curr = nil then writeln('nil!!');
          If curr <> nil then
               Begin
                    Print(curr^.N);       {L}
                    WriteLn(curr^.info);  {N}
                    Print(curr^.Y);       {R}
               End;
     End;
{///////////////////////////////////////////////////////////////////////}
Procedure TreePrint(curr:ptr);
     Begin
          inc(LEVEL, 1);
          If curr <> nil then
               Begin
                    TreePrint(curr^.Y);              {R}
                    WriteLn(curr^.info:LEVEL * 10);  {N}
                    TreePrint(curr^.N);              {L}
               End;
          if curr = nil then writeln('nil!!');
          dec(LEVEL, 1);
     End;
{///////////////////////////////////////////////////////////////////////}
Procedure start(var root:ptr);
     Var
          Name: String[20];
          Quest: String[60];
          curr, prev, node:  ptr;
          ans: Char;
          FOUND: Boolean;
{///////////////////////////////////////////////////////////////}
  Procedure Add(var curr:ptr; Name:STR20; Quest:STR60);
       Var
            node: ptr;
       Begin
            new(node);
            node^.info := Name;
            node^.question := Quest;
            node^.N := nil;
            node^.Y := nil;
            curr := node;
{            If prev = nil then
                 r := node
            Else Begin
                      curr := r;}
                      {While curr <> nil do
                           Begin
                                prev := curr;
                                If  val < curr^.info then
                                     curr := curr^.left
                                Else curr := curr^.right;
                           End;
                      If prev^.info > val then
                           prev^.left := node
                      Else prev^.right := node;}
                 {End;}
       End;
{///////////////////////////////////////////////////////////////}
     Begin
       FOUND := FALSE;
       curr := root;
       prev := nil;
       If root = nil then
         Begin
           WriteLn('STUPID, AM I...INFORMATION, HAVE NOT');
           Delay(500);
           WriteLn('I GIVE UP!!');
           Write('Tell me your animal name:  ');
           ReadLn(Name);
           WriteLn('What question will I use to identify this animal?');
           ReadLn(Quest);
           Add(root, Name, Quest);
           FOUND := TRUE;
         End;
       While ((curr <> nil) and (FOUND = FALSE)) do
         Begin
           ans := YN(curr^.question);
           If ans = 'Y' then
             Begin
               prev := curr;
{               ans := YN('Are you thinking of a(n) ' + curr^.info);
               If ans = 'Y' then
                 Begin
                   WriteLn('I WIN!!');
                   FOUND := TRUE;
                 End
               Else} Begin
                      If curr^.Y = nil then
                        Begin
                          WriteLn('I GIVE UP!!');
                          Write('Tell me your animal name:  ');
                          ReadLn(Name);
                          WriteLn('What question will I use to identify this animal?');
                          ReadLn(Quest);
                          Add(curr^.Y, Name, Quest);
                          FOUND := TRUE;
                        End
                      Else curr := curr^.Y;
                     End;
             End
           Else Begin
                  If prev <> nil then
                       Begin
                         ans := YN('Are you thinking of a(n) ' + prev^.info);
                         If ans = 'Y' then
                           Begin
                             WriteLn('I WIN!!');
                             FOUND := TRUE;
                           End
                         Else prev := nil;
                       End;
                  If FOUND = FALSE then
                    Begin
                      If curr^.N = nil then
                        Begin
                          WriteLn('I GIVE UP!!');
                          Write('Tell me your animal name:  ');
                          ReadLn(Name);
                          WriteLn('What question will I use to identify this animal?');
                          ReadLn(Quest);
                          Add(curr^.N, Name, Quest);
                          FOUND := TRUE;
                        End
                      Else curr := curr^.N;
                    End;
                End;
         End;
     End;
{///////////////////////////////////////////////////////////////////////}
Begin
     root := nil;
     LEVEL := -1;
     ClrScr;
     Repeat
          GotoXY(1,1);
          BackDrop;
          MenC(34,10,5,'A','Add','B');
          MenC(34,11,5,'P','Print','C');
          MenC(34,12,5,'T','Tree','C');
          MenC(34,13,5,'Q','Quit','E');
{          WriteLn('(A)dd');
          WriteLn('(P)rint');
          WriteLn('(Q)uit');
          WriteLn;
          WriteLn;}
{          Write(':');}
          Repeat
               sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
{               'A': Begin
                         Write('Enter in a character:  ');
                         ReadLn(ch);
                         Add(root, ch);
                    End;}
               'B': Begin
                      Repeat
                        start(root);
                        sel := YN('Do you wish to play again?');
                      Until sel = 'N';
                    End;

               'P': Print(root);
               'T': TreePrint(root);
          End;
     Until sel = 'Q';
End.