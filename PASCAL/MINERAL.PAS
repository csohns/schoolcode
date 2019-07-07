                {This is a DEMO program for a mineral database}

Program Mineral;

Uses dos,crt,menu;

TYPE
     MenuString = String[29];                  {maximum length of menu text}

{////////////////////////////////////////////////////////////////}
    Procedure MenH(X, Y, long:Integer; texts:MenuString);
         Var               {creates headers for menus}
              lcv: Integer;             {loop control variable}
{////////////////////////////////////////////////////////}
      Procedure spa(num:Integer);
           Var                      {places spaces in text}
                lcv: Integer;
           Begin
                For lcv := 1 to num do
                     Write(' ');
           End;
{////////////////////////////////////////////////}
         Begin                      {Creates menu header}
              GotoXY(X, Y);
              c(14,2,1);
              Write('É');                    {<==|}
              For lcv := 1 to long + 7 do    {<==|}
                Write('Í');                  {<==|}
              WriteLn('»');                  {<==|----writes upper boarder}
              GotoXY(X, Y + 1);              {        of the menu header  }
              c(14,2,1);
              Write('º ');                   {<==----left wall}
              c(7,2,1);
              spa(long + 5);
              c(14,2,1);
              Write(' º');                   {<==----right wall}
              GotoXY(X + 1, Y + 1);
              GotoXY(((long + 9) div 2) - (Length(texts) div 2) + X, Y + 1);
              c(7,2,1);                      {^==----centers text}
              Write(texts);                  {<==----prints centered text}
              GotoXY(X, Y + 2);
              c(14, 2, 1);
              Write('Ì');                    {<==----left merge character}
              For lcv := 1 to long + 7 do    {<==|}
                   Write('Í');               {<==|----writes lower boarder}
              WriteLn('¹');                  {<==----right merge character}
              GotoXY(1,1);
              c(7,1,0);
         End;
{////////////////////////////////////////////////////////////////}
Procedure BoxWipe(X, Y, X2, Y2: Integer);
  Var
    lcv, lcv2: Integer;                      {loop control variables}
  Begin
    c(3,2,1);
    For lcv := Y to Y2 do                    {clears box along the 'Y' axis}
      Begin
        For lcv2 := X to X2 do               {clears box along the 'X' axis}
          Begin
            GotoXY(lcv2, lcv);
            Write('°');                      {actually clears here}
          End;
      End;
    c(7,1,0);                                {reset text color}
  End;
{////////////////////////////////////////////////////////////////}
    Procedure InfoBox(X, Y, long:Integer; texts:String; BoxVar:Char);
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
              loc := 0;              {.==----If only line of text}
              If (BoxVar = 'B') or (BoxVar = 'O') then
              Begin    {^==----If top line of text}
                   If X = 0 then
                        Begin                {.==----centers text}
                             X := (Trunc(40 - ((Length(texts) div 2) + 2)));
                             loc := (X + Length(texts)) + 2;
                             GotoXY(X, Y);
                        End
                   Else GotoXY(X, Y);
                   c(15,2,3);
                   Write('É');               {<===|}
                   For lcv := 1 to long + 2 do{<==|}
                        Write('Í');          {<===|}
                   WriteLn('»');             {<===|----upper boarder of box}
              End;
              If X = 0 then
                   Begin
                        X := (Trunc(40 - (Length(texts) div 2)));
                        GotoXY(X, Y + 1);    {^==----center texts}
                   End
              Else GotoXY(X, Y + 1);
              c(15,2,3);
              Write('º ');                   {<==----left wall}
              c(8,1,3);
              Write(texts);                  {<==----write texts}
              spa(long - Length(texts));
              c(15,2,3);
              GotoXY(X + (long + 2), Y + 1);
              Write(' º');                   {<==----right text}
              If (BoxVar = 'E') or (BoxVar = 'O') then
              Begin {^==----last line of text} {^==----only line of text}
                   GotoXY(X, Y + 2);
                   c(15, 2, 3);
                   Write('È');               {<===|}
                   For lcv := 1 to long + 2 do{<==|}
                        Write('Í');          {<===|}
                   WriteLn('¼');             {<===|----lower boarder of box}
              End;
              If loc <> 0 then
                   GotoXY(loc, Y + 1);       {<==----prepare for 'answer'}
              c(7,1,0);                      {       answer statement    }
         End;
{////////////////////////////////////////////////////////////////}
Procedure TypeIn(text:String);
  Var
    lcv: Integer;                            {loop control variable}
  Begin
    For lcv := 1 to Length(text) do
      Begin
        Write(text[lcv]);                    {<==----prints given texts as }
{        Sound(950);}                        {       if it were being typed}
        Delay(80);                           {       in manually           }
{        NoSound;}
      End;
  End;
{////////////////////////////////////////////////////////////////}
Procedure MainMenu;
                                {main menu display}
  Begin
    ClrScr;
    BackDrop;                                {menu background}
    MenC(27,10,20,'S','Search','B');         {<=======|}
    Menc(27,11,20,'D','Display mineral data','C');{<==|}
    Box(27,12,25,'','C');                    {<=======|}
    MenC(27,13,20,'A','Auditorian','C');     {<=======|}
    MenC(27,14,20,'Q','Quit','E');           {<=======|}
    MenH(27,8,20,'MINERALS');                {<=======|----entire main menu}
    Delay(3000);
    InfoBox(4,3,24,'This is the main menu...','O');
    GotoXY(1,1);                             {^==----box of information}
    Delay(2000);                             {.==----box of more information}
    InfoBox(51,3,25,'From here you may:','O');
    GotoXY(1,1);
    Delay(1000);
    InfoBox(51,4,25,'                   Search','E');
    GotoXY(30,11);
    c(4,2,8);
    Write('S');
    GotoXY(34,11);
    c(7,2,8);                     {Hilight the word "sreach"}
    Write('Search');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,11);
    c(4,2,1);
    Write('S');
    GotoXY(34,11);
    c(7,2,1);                     {Un-Hilight the word "search"}
    Write('Search');
    InfoBox(51,5,25,'     Display mineral data','E');
    GotoXY(30,12);
    c(4,2,8);
    Write('D');
    GotoXY(34,12);
    c(7,2,8);                     {Hilight DispMinDat}
    Write('Display mineral data');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,12);
    c(4,2,1);
    Write('D');
    GotoXY(34,12);
    c(7,2,1);                     {Un-Hilight DispMinDat}
    Write('Display mineral data');
    InfoBox(51,6,25,'      use Auditorian mode','E');
    GotoXY(30,14);
    c(4,2,8);
    Write('A');
    GotoXY(34,14);
    c(7,2,8);                     {Hilight "Auditorian"}
    Write('Auditorian');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,14);
    c(4,2,1);
    Write('A');
    GotoXY(34,14);
    c(7,2,1);                     {Un-Hilight "Auditorian"}
    Write('Auditorian');
    InfoBox(51,7,25,'                 and Quit','E');
    GotoXY(30,15);
    c(4,2,8);
    Write('Q');
    GotoXY(34,15);
    c(7,2,8);                     {Hilight "Quit"}
    Write('Quit');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,15);
    c(4,2,1);
    Write('Q');
    GotoXY(34,15);
    c(7,2,1);                     {Un-Hilight "Quit"}
    Write('Quit');
    GotoXY(1,1);
    BoxWipe(4,3,32,5);
    BoxWipe(51,3,79,9);
    MenH(27,8,20,'MINERALS');
    InfoBox(24,19,33,'Lets start with the SEARCH option','O');
    GotoXY(1,1);
    Delay(1000);
    GotoXY(30,11);
    c(4,2,8);
    Write('S');
    GotoXY(34,11);
    c(7,2,8);
    Write('Search');
    GotoXY(1,1);
    Delay(500);
    GotoXY(30,11);
    c(4,2,1);
    Write('S');
    GotoXY(34,11);
    c(7,2,1);
    Write('Search');
    GotoXY(1,1);
    Delay(1000);
    BoxWipe(24,18,61,21);
    GotoXY(1,1);
  End;
{////////////////////////////////////////////////////////////////}
Procedure Search;
{////////////////////////////////////////////////////////}
  Procedure Luster;
    Var
      list: Array[1..20] of String;
      lcv: Integer;
    Begin
      For lcv := 1 to 20 do
        list[lcv] := '';
      list[1] := 'GRAPHITE';
      list[2] := 'LIMONITE';
      list[3] := 'HEMATITE';
      list[4] := 'GALENA';
      list[5] := 'CHALCOCITE';
      list[6] := 'GOLD';
      list[7] := 'NATIVE COPPER';
      list[8] := 'BRONITE';
      list[9] := 'CHALCOPYRITE';
      list[10] := 'NICCOLITE';
      list[11] := 'ARSENOPYRITE';
      list[12] := 'ILMENITE';
      list[13] := 'MAGNETITE';
      list[14] := 'LIMONITE';
      list[15] := 'HEMATITE';
      list[16] := 'PYRITE';
      GotoXY(5,7);
      c(15,2,1);
      Write('³ ');
      c(12,2,1);
      Write('Luster            ');
      Box(28,6,43,'Enter in luster type:  ','O');
      GotoXY(53,7);
      Delay(1000);
      InfoBox(53,20,22,'''Metallic'' is entered.','O');
      GotoXY(53,7);
      Delay(2000);
      BoxWipe(53,20,78,22);
      GotoXY(53,7);
      Delay(500);
      c(10,2,1);
      TypeIn('Metallic');
      Delay(500);
      InfoBox(56,20,19,'[ENTER] is pressed.','O');
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(56,20,78,22);
      GotoXY(1,1);
      Delay(500);
      BoxWipe(28,6,74,8);
      GotoXY(1,1);
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(33,11,52,13);
      Box(28,3,22,'','B');
      Box(28,4,22,'','C');
      Box(28,5,22,'','C');
      Box(28,6,22,'','C');
      Box(28,7,22,'','C');
      Box(28,8,22,'','C');
      Box(28,9,22,'','C');
      Box(28,10,22,'','C');
      Box(28,11,22,'','C');
      Box(28,12,22,'','E');
      Window(30,4,51,13);
      c(15,2,1);
      For lcv := 1 to 9 do
        WriteLn(list[lcv]);
      Write(list[10]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(2000);
      InfoBox(57,2,18,'This generated','B');
      InfoBox(57,3,18,'list containes','C');
      InfoBox(57,4,18,'all minerals that','C');
      InfoBox(57,5,18,'have a Metallic','C');
      InfoBox(57,6,18,'luster.','E');
      GotoXY(1,1);
      Delay(2000);
      InfoBox(37,17,38,'The student can now scroll up and down','B');
      InfoBox(37,18,38,'until they find the correct mineral.','C');
      InfoBox(37,19,38,'','C');
      InfoBox(37,20,38,'        Press [ENTER] to continue. . .','E');
      GotoXY(1,1);
      ReadLn;
      BoxWipe(57,2,78,8);
      GotoXY(1,1);
      Delay(500);
      Window(30,4,51,13);
      c(15,2,1);
      ClrScr;
      For lcv := 2 to 10 do
        WriteLn(list[lcv]);
      Write(list[11]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(800);
      Window(30,4,51,13);
      c(15,2,1);
      ClrScr;
      For lcv := 3 to 11 do
        WriteLn(list[lcv]);
      Write(list[12]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(800);
      Window(30,4,51,13);
      c(15,2,1);
      ClrScr;
      For lcv := 4 to 12 do
        WriteLn(list[lcv]);
      Write(list[13]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(1000);
      Window(30,4,51,13);
      c(15,2,1);
      ClrScr;
      For lcv := 3 to 11 do
        WriteLn(list[lcv]);
      Write(list[12]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(800);
      Window(30,4,51,13);
      c(15,2,1);
      ClrScr;
      For lcv := 2 to 10 do
        WriteLn(list[lcv]);
      Write(list[11]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(37,17,78,22);
      InfoBox(39,17,36,'Sometimes the student can''t find the','B');
      InfoBox(39,18,36,'mineral that they were looking for.','E');
      GotoXY(1,1);
      Delay(2000);
      InfoBox(57,2,18,'This only happens','B');
      InfoBox(57,3,18,'when they either:','C');
      InfoBox(57,4,18,'','C');
      InfoBox(57,5,18,'Enter in the','C');
      InfoBox(57,6,18,'information','C');
      InfoBox(57,7,18,'incorrectly, or','C');
      InfoBox(57,8,18,'they don''t scroll','C');
      InfoBox(57,9,18,'down farenough.','C');
      InfoBox(57,10,18,'','C');
      InfoBox(57,11,18,'In this case,','C');
      InfoBox(57,12,18,'they didn''t scroll','C');
      InfoBox(57,13,18,'down farenough.','E');
      GotoXY(1,1);
      Delay(500);
      InfoBox(39,19,36,'','C');
      InfoBox(39,20,36,'        Press [ENTER] to continue. . .','E');
      GotoXY(1,1);
      ReadLn;
      BoxWipe(39,17,78,22);
      BoxWipe(57,2,78,15);
      InfoBox(35,20,40,'Press [ESCAPE] to exit the mineral list.','O');
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(35,20,78,22);
      BoxWipe(28,3,53,15);
      GotoXY(1,1);
    End;
{////////////////////////////////////////////////////////}
  Procedure Origin;
    Var
      list: Array[1..20] of String;
      lcv: Integer;
    Begin
      For lcv := 1 to 20 do
        list[lcv] := '';
      list[1] := 'MAGNETITE';
      list[2] := 'PYRITE';
      GotoXY(5,16);
      c(15,2,1);
      Write('³ ');
      c(12,2,1);
      Write('Origin            ');
      GotoXY(1,1);
      Box(28,12,14,'   Igneous','B');
      Box(28,13,14,'','C');
      Box(28,14,14,'   Metamorphic','C');
      Box(28,15,14,'','C');
      Box(28,16,14,'   Sedimentary','C');
      Box(28,17,14,'','C');
      Box(28,18,14,'   Ore','E');
      c(10,2,8);
      GotoXY(30,13);
      Write(' ');
      GotoXY(30,15);
      Write(' ');
      GotoXY(30,17);
      Write(' ');
      GotoXY(30,19);
      Write(' ');
      GotoXY(30,13);
      Delay(3000);
      InfoBox(42,4,27,'Here is the list of all the','B');
      InfoBox(42,5,27,'differant mineral origins.','E');
      GotoXY(30,13);
      Delay(2000);
      BoxWipe(42,4,72,7);
      InfoBox(49,5,26,'The student knows ''PYRITE''','B');
      InfoBox(49,6,26,'is Igneous.','E');
      c(10,2,8);
      GotoXY(30,13);
      Delay(1000);
      InfoBox(52,20,23,'[SPACE BAR] is pressed.','O');
      GotoXY(30,13);
      Delay(2000);
      BoxWipe(52,20,78,22);
      c(10,2,8);
      GotoXY(30,13);
      Write('û');
      GotoXY(30,13);
      Delay(1000);
      InfoBox(49,5,26,'The student knows ''PYRITE''','B');
      InfoBox(49,6,26,'is Metamorphic.','E');
      c(10,2,8);
      GotoXY(30,13);
      Delay(1000);
      InfoBox(51,20,24,'[DOWN ARROW] is pressed.','O');
      GotoXY(30,13);
      Delay(2000);
      BoxWipe(51,20,78,22);
      c(10,2,8);
      GotoXY(30,13);
      Delay(500);
      GotoXY(30,15);
      Delay(500);
      InfoBox(52,20,23,'[SPACE BAR] is pressed.','O');
      GotoXY(30,15);
      Delay(2000);
      BoxWipe(52,20,78,22);
      c(10,2,8);
      GotoXY(30,15);
      Write('û');
      GotoXY(30,15);
      Delay(1000);
      InfoBox(49,5,26,'The student knows ''PYRITE''','B');
      InfoBox(49,6,26,'is Sedimentary.','E');
      c(10,2,8);
      GotoXY(30,15);
      Delay(1000);
      InfoBox(51,20,24,'[DOWN ARROW] is pressed.','O');
      GotoXY(30,15);
      Delay(2000);
      BoxWipe(51,20,78,22);
      c(10,2,8);
      GotoXY(30,15);
      Delay(500);
      GotoXY(30,17);
      Delay(500);
      InfoBox(52,20,23,'[SPACE BAR] is pressed.','O');
      GotoXY(30,17);
      Delay(2000);
      BoxWipe(52,20,78,22);
      c(10,2,8);
      GotoXY(30,17);
      Write('û');
      GotoXY(30,17);
      Delay(1000);
      InfoBox(49,5,26,'The student knows ''PYRITE''','B');
      InfoBox(49,6,26,'is Ore.','E');
      c(10,2,8);
      GotoXY(30,17);
      Delay(1000);
      InfoBox(51,20,24,'[DOWN ARROW] is pressed.','O');
      GotoXY(30,17);
      Delay(2000);
      BoxWipe(51,20,78,22);
      c(10,2,8);
      GotoXY(30,17);
      Delay(500);
      GotoXY(30,19);
      Delay(500);
      InfoBox(52,20,23,'[SPACE BAR] is pressed.','O');
      GotoXY(30,19);
      Delay(2000);
      BoxWipe(52,20,78,22);
      c(10,2,8);
      GotoXY(30,19);
      Write('û');
      GotoXY(30,19);
      Delay(1000);
      BoxWipe(49,5,78,8);
      InfoBox(30,8,43,'Now satasfyed that everything is correct...','O');
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(30,8,78,11);
      InfoBox(56,20,19,'[ENTER] is pressed.','O');
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(56,20,78,22);
      GotoXY(1,1);
      Delay(500);
      BoxWipe(28,12,45,20);
      GotoXY(1,1);
      Box(33,11,14,'','O');
      GotoXY(35,12);
      c(31,2,1);
      Write('Searching. . .');
      c(14,2,1);
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(33,11,52,13);
      Box(28,3,22,'','B');
      Box(28,4,22,'','C');
      Box(28,5,22,'','C');
      Box(28,6,22,'','C');
      Box(28,7,22,'','C');
      Box(28,8,22,'','C');
      Box(28,9,22,'','C');
      Box(28,10,22,'','C');
      Box(28,11,22,'','C');
      Box(28,12,22,'','E');
      Window(30,4,51,13);
      c(15,2,1);
      For lcv := 1 to 2 do
        WriteLn(list[lcv]);
      Window(1,1,80,25);
      c(14,2,1);
      GotoXY(1,1);
      Delay(2000);
      InfoBox(57,2,18,'This generated','B');
      InfoBox(57,3,18,'list containes','C');
      InfoBox(57,4,18,'all minerals that','C');
      InfoBox(57,5,18,'have a Metallic','C');
      InfoBox(57,6,18,'luster, and are','C');
      InfoBox(57,7,18,'Igneous,','C');
      InfoBox(57,8,18,'Medamorphic,','C');
      InfoBox(57,9,18,'Sedimentary,','C');
      InfoBox(57,10,18,'and Ore in','C');
      InfoBox(57,11,18,'Origin.','E');
      GotoXY(1,1);
      Delay(2000);
      InfoBox(37,17,38,'Now the student sees the word ''PYRITE''','B');
      InfoBox(37,18,38,'and knows how to spell it..','C');
      InfoBox(37,19,38,'','C');
      InfoBox(37,20,38,'        Press [ENTER] to continue. . .','E');
      GotoXY(1,1);
      ReadLn;
      BoxWipe(57,2,78,13);
      BoxWipe(37,17,78,22);
      GotoXY(1,1);
      Delay(500);
      InfoBox(35,20,40,'Press [ESCAPE] to exit the mineral list.','O');
      GotoXY(1,1);
      Delay(2000);
      BoxWipe(35,20,78,22);
      BoxWipe(28,3,53,15);
      GotoXY(1,1);
    End;
{////////////////////////////////////////////////////////}
  Begin
    BackDrop;
    Box(3,5,19,'³ Hardness','B');
    Box(3,6,19,'³ Luster','C');
    Box(3,7,19,'³ Color','C');
    Box(3,8,19,'³ Streak','C');
    Box(3,9,19,'³ Cleavage','C');
    Box(3,10,19,'³ Specific Gravity','C');
    Box(3,11,19,'³ Properties','C');
    Box(3,12,19,'³ Name','C');
    Box(3,13,19,'³ Composition','C');
    Box(3,14,19,'³ Use','C');
    Box(3,15,19,'³ Origin','E');
    MenH(3,3,14,'SEARCH METHODS');
    GotoXY(5,6);
    c(15,2,8);
    Write('³ Hardness         ');
    GotoXY(1,1);
    Delay(3000);
    InfoBox(29,3,46,' Ü Search Methods','B');
    InfoBox(29,4,46,' ßßßßßßßßßßßßßßßßß','C');
    InfoBox(29,5,46,'The purpose for having so many differant types','C');
    InfoBox(29,6,46,'of searches, is to enable students to locate','C');
    InfoBox(29,7,46,'a given mineral with great ease.','C');
    InfoBox(29,8,46,'','C');
    InfoBox(29,9,46,'                Press [ENTER] to continue. . .','E');
    GotoXY(1,1);
    ReadLn;
    BoxWipe(29,3,78,11);
    InfoBox(29,3,46,'Lets say that a student wanted to look up,','B');
    InfoBox(29,4,46,'''PYRITE'' but they didn''t know how to spell','C');
    InfoBox(29,5,46,'it.  So after "SEARCH" is chosen from the main','C');
    InfoBox(29,6,46,'menu, they see the differant search methods...','C');
    InfoBox(29,7,46,'They now realize thay they know the luster of','C');
    InfoBox(29,8,46,'PYRITE, so they chose "LUSTER".','C');
    InfoBox(29,9,46,'','C');
    InfoBox(29,10,46,'                Press [ENTER] to continue. . .','E');
    GotoXY(1,1);
    ReadLn;
    BoxWipe(29,3,78,12);
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,6);
    c(15,2,1);
    Write('³ Hardness         ');
    GotoXY(5,7);
    c(15,2,8);
    Write('³ Luster           ');
    GotoXY(1,1);
    Delay(500);
    InfoBox(56,20,19,'[ENTER] is pressed.','O');
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(56,20,78,22);
    Luster;                              {calls on the luster demo}
    GotoXY(5,7);
    c(15,2,8);
    Write('³ Luster           ');
    GotoXY(1,1);
    Delay(1000);
    InfoBox(39,18,36,'Lets say that the student also knows','B');
    InfoBox(39,19,36,'the Origin of ''PYRITE'',so we choose','C');
    InfoBox(39,20,36,'Origin.','E');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(5,7);
    c(15,2,1);
    Write('³ Luster           ');
    GotoXY(5,8);
    c(15,2,8);
    Write('³ Color            ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,8);
    c(15,2,1);
    Write('³ Color            ');
    GotoXY(5,9);
    c(15,2,8);
    Write('³ Streak           ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,9);
    c(15,2,1);
    Write('³ Streak           ');
    GotoXY(5,10);
    c(15,2,8);
    Write('³ Cleavage         ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,10);
    c(15,2,1);
    Write('³ Cleavage         ');
    GotoXY(5,11);
    c(15,2,8);
    Write('³ Specific Gravity ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,11);
    c(15,2,1);
    Write('³ Specific Gravity ');
    GotoXY(5,12);
    c(15,2,8);
    Write('³ Properties       ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,12);
    c(15,2,1);
    Write('³ Properties       ');
    GotoXY(5,13);
    c(15,2,8);
    Write('³ Name             ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,13);
    c(15,2,1);
    Write('³ Name             ');
    GotoXY(5,14);
    c(15,2,8);
    Write('³ Composition      ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,14);
    c(15,2,1);
    Write('³ Composition      ');
    GotoXY(5,15);
    c(15,2,8);
    Write('³ Use              ');
    GotoXY(1,1);
    Delay(500);
    GotoXY(5,15);
    c(15,2,1);
    Write('³ Use              ');
    GotoXY(5,16);
    c(15,2,8);
    Write('³ Origin           ');
    GotoXY(1,1);
    Delay(1000);
    BoxWipe(39,18,78,22);
    Origin;                            {calls on the Origin demo}
    GotoXY(5,16);
    c(15,2,8);
    Write('³ Origin           ');
    GotoXY(1,1);
    Delay(2000);
    InfoBox(36,20,39,'Press [ESCAPE] to exit the Search Menu.','O');
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(36,20,78,22);
    GotoXY(1,1);
  End;
{////////////////////////////////////////////////////////////////}
Procedure MainMenu2TimeThrough;
  Begin
    BackDrop;
    MenC(27,10,20,'S','Search','B');
    Menc(27,11,20,'D','Display mineral data','C');
    Box(27,12,25,'','C');
    MenC(27,13,20,'A','Auditorian','C');
    MenC(27,14,20,'Q','Quit','E');
    MenH(27,8,20,'MINERALS');
    Delay(2000);
    InfoBox(3,2,32,'Once again back at the Main Menu,','B');
    InfoBox(3,3,32,'our student decides to look up','C');
    InfoBox(3,4,32,'the data on ''PYRITE''.','E');
    GotoXY(1,1);
    Delay(4000);
    BoxWipe(3,2,38,6);
    GotoXY(1,1);
    InfoBox(20,19,39,'So we choose the Display mineral option','O');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,12);
    c(4,2,8);
    Write('D');
    GotoXY(34,12);
    c(7,2,8);
    Write('Display mineral data');
    GotoXY(1,1);
    Delay(500);
    GotoXY(30,12);
    c(4,2,1);
    Write('D');
    GotoXY(34,12);
    c(7,2,1);
    Write('Display mineral data');
    GotoXY(1,1);
    Delay(1000);
    BoxWipe(20,18,62,21);
    GotoXY(1,1);
  End;
{////////////////////////////////////////////////////////////////}
Procedure DispMinDat;
  Begin
    BackDrop;
    Box(13,11,54,'Enter in mineral name:  ','O');
    GotoXY(39,12);
    c(10,2,1);
    Delay(3000);
    InfoBox(55,20,20,'''Pyrite'' is entered.','O');
    GotoXY(39,12);
    Delay(2000);
    BoxWipe(55,20,78,22);
    GotoXY(39,12);
    Delay(500);
    c(10,2,1);
    TypeIn('Pyrite');
    Delay(500);
    InfoBox(56,20,19,'[ENTER] is pressed.','O');
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(56,20,78,22);
    GotoXY(1,1);
    Delay(500);
    BoxWipe(13,11,70,13);
    GotoXY(1,1);
    Box(33,11,14,'','O');
    GotoXY(35,12);
    c(31,2,1);
    Write('Searching. . .');
    c(14,2,1);
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(33,11,52,13);
    GotoXY(1,1);
    Box(3,3,72,'                                PYRITE                                    ','B');
    Box(3,4,72,'--------------------------------------------------------------------------','C');
    Box(3,5,72,'Hardness:  6-6.5','C');
    Box(3,6,72,'Luster:  Metallic','C');
    Box(3,7,72,'Color:  Pale brass to yellow','C');
    Box(3,8,72,'Streak:  Greenish to brownish black','C');
    Box(3,9,72,'Cleavage:  None','C');
    Box(3,10,72,'Specific Gravity:  5','C');
    Box(3,11,72,'Properities:  Brittle. Commonly occurs in cubes.','C');
    Box(3,12,72,'Name:  PYRITE','C');
    Box(3,13,72,'Composition:  FeS[2]','C');
    Box(3,14,72,'Use:  Source of sulfur for sulfuric acid','C');
    Box(3,15,72,'Origin:  I, S, M, O','E');
    GotoXY(1,1);
    Delay(4000);
    InfoBox(37,18,38,'As you can see, all the information on','B');
    InfoBox(37,19,38,'''PYRITE'' is here.','E');
    GotoXY(1,1);
    Delay(2000);
    InfoBox(37,20,38,'        Press [ENTER] to continue. . .','E');
    GotoXY(1,1);
    ReadLn;
    BoxWipe(37,18,78,22);
    GotoXY(1,1);
    Delay(500);
    InfoBox(33,20,42,'Press [ESCAPE] to retuen to the Main Menu.','O');
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(33,20,78,22);
    GotoXY(1,1);
    Delay(2000);
  End;
{////////////////////////////////////////////////////////////////}
Procedure MainMenu3TimeThrough;
  Begin
    BackDrop;
    MenC(27,10,20,'S','Search','B');
    Menc(27,11,20,'D','Display mineral data','C');
    Box(27,12,25,'','C');
    MenC(27,13,20,'A','Auditorian','C');
    MenC(27,14,20,'Q','Quit','E');
    MenH(27,8,20,'MINERALS');
    Delay(2000);
    InfoBox(3,2,38,'The demo on the use of Auditorian mode','O');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,14);
    c(4,2,8);
    Write('A');
    GotoXY(34,14);
    c(7,2,8);
    Write('Auditorian');
    GotoXY(1,1);
    Delay(500);
    GotoXY(30,14);
    c(4,2,1);
    Write('A');
    GotoXY(34,14);
    c(7,2,1);
    Write('Auditorian');
    GotoXY(1,1);
    Delay(1000);
    InfoBox(3,3,38,'will not to presented in this','C');
    InfoBox(3,4,38,'program.','E');
    GotoXY(1,1);
    Delay(2000);
    BoxWipe(3,2,44,6);
    GotoXY(1,1);
    Delay(1000);
    InfoBox(36,19,9,'Bye! Bye!','O');
    GotoXY(1,1);
    Delay(2000);
    GotoXY(30,15);
    c(4,2,8);
    Write('Q');
    GotoXY(34,15);
    c(7,2,8);
    Write('Quit');
    GotoXY(1,1);
    Delay(500);
    GotoXY(30,15);
    c(4,2,1);
    Write('Q');
    GotoXY(34,15);
    c(7,2,1);
    Write('Quit');
    GotoXY(1,1);
    Delay(1000);
    BoxWipe(36,19,48,21);
    GotoXY(1,1);
    Delay(500);
  End;
{////////////////////////////////////////////////////////////////}
Begin
  MainMenu;
  Search;
  MainMenu2TimeThrough;
  DispMinDat;
  MainMenu3TimeThrough;
End.