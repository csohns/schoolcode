Program Zoo;

Uses CRT;

Type
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
Function YN(ques:String): Char;
     Var
          ans: Char;
     Begin
          Write(ques, '  [Y or N]:  ');
          Repeat
               ans := ReadKey;
          Until ((ans = 'Y') or (ans = 'y') or (ans = 'N') or (ans = 'n'));
          Write(ans);
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
          {ClrScr;
          GotoXY(1,1);}
{         BackDrop;
          MenuCreator(34,10,5,'A','Add','B');
          MenuCreator(34,11,5,'P','Print','C');
          MenuCreator(34,12,5,'Q','Quit','E');}
{          WriteLn('(A)dd');
          WriteLn('(P)rint');
          WriteLn('(Q)uit');
          WriteLn;
          WriteLn;}
          Write(':');
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