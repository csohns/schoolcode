Extras from MINBASE.PAS

Procedure CK_REG(var REG:Boolean);
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
          lcv, temp: Integer;
          F: File of CodeRec;
          y,m,d,dow: Word;
{////////////////////////////////////////////////////////////////}
  Procedure RegForm(code: Integer);
       Var
            lcv: Integer;
       Begin
            If code = 0 then
                 Begin
                      WriteLn('You have 2 months left to register this program');
                      WriteLn;
                 End;
            If code = 1 then
                 Begin
                      WriteLn('You have 1 month left to register this program');
                      WriteLn;
                 End;
            If code = 2 then
                 Begin
                      WriteLn('You have 0 months left to register this program');
                      WriteLn;
                      WriteLn('This program has been disabled until registered...');
                 End;
            WriteLn('This program is shareware, you have a 2 month trial run.');
            WriteLn('Once the 2 months are up, if you decide not to register,');
            WriteLn('please delete this program from your hard drive.');
            For lcv := 1 to 18 do
                 WriteLn;
            Delay(8000);
            If code = 2 then halt;
            ClrScr;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          GetDate(y,m,d,dow);
          Stats.USER_NAME := '';
          Stats.USER_COMPANY := '';
          Stats.PASSWORD := '30676';
          Stats.EncNum := 0;
          Stats.YEAR := y;
          Stats.MONTH := m;
          Stats.DAY := d;
          Assign(F, 'MAGDBASE.DAT');
          {$I-}
          ReSet(F);
          If IOResult <> 0 then
               Begin
                    ReWrite(F);
                    Write(F, Stats);
                    Close(F);
               End;
          {$I+}
          ReSet(F);
          Read(F, Stats);
          Close(F);
          cstr := '';
          For lcv := 1 to Length(Stats.PASSWORD) do
               Begin
                    j := Ord(Stats.PASSWORD[lcv]);
                    j := j - (Stats.EncNum );
                    {If j < 0 then
                         Begin
                              temp := j + 256;
                              j := 256;
                              dec(j, temp);
                         End;}
                    cstr := cstr + CHR(j);
               End;
          IF cstr = 'f’c…QQXY„†ˆjkŒ“„' then REG := TRUE
                         Else REG := FALSE;
          If NOT REG then
               Begin
                    GetDate(y,m,d,dow);
                    If (Stats.MONTH = (m)) then
                         RegForm(0);
                    If (Stats.MONTH = (m + 1)) then
                         RegForm(2);
                    If (Stats.MONTH > (m + 1)) then
                         RegForm(3);
               End;
          If REG then
               Begin
                    If Length(Stats.USER_NAME) < Length(Stats.USER_COMPANY) then
                         num := Length(Stats.USER_COMPANY)
                    Else num := Length(Stats.USER_NAME);
                    If num < 33 then num := 33;
                    ClrScr;
                    j := (40 - Trunc(num div 2)) - 2;
                    Box(j,10,num,'','B');
                    Box(j,11,num,'','C');
                    Box(j,12,num,'','C');
                    Box(j,13,num,'','E');
                    c(15,2,1);
                    j := 40 - Trunc(30 div 2);
                    GotoXY(j,11);
                    Write('This program is registered to:');
                    j := 40 - Trunc(Length(Stats.USER_NAME) div 2);
                    GotoXY(j,12);
                    Write(Stats.USER_NAME);
                    j := 40 - Trunc(2 div 2);
                    GotoXY(j,13);
                    Write('of');
                    j := 40 - Trunc(Length(Stats.USER_COMPANY) div 2);
                    GotoXY(j,14);
                    Write(Stats.USER_COMPANY);
                    GotoXY(1,1);
                    Delay(4000);
                    ClrScr;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}


Procedure Give_Credit;
     Begin
          TextBackGround(0);
          ClrScr;
{          Delay(2000);
          credit('DESIGN', 'by', 'CHRIS SOHNS');
          credit('SOFTWARE ENGINEERS', '', 'CHRIS SOHNS');
          credit('SOFTWARE ENGINEERS', '', 'DAN SULLIVAN');
          credit('SOUND EFFECTS', 'by', 'CHRIS SOHNS');
          credit('PRODUCED', 'by', 'CHRIS SOHNS');
          credit('DIRECTED', 'by', 'CHRIS SOHNS');
          credit('TESTED', 'by', 'Peter Hays');
          credit('TESTED', 'by', 'Ryan Riley');
          credit('TESTED', 'by', 'Matt Huber');
          ClrScr;
          Delay(4000);}
     End;
{////////////////////////////////////////////////////////////////////////}
  Procedure Help(HelpType: Integer);
       Var
            lcv, page: Integer;
            sel: Char;
{////////////////////////////////////////////////////////}
    Procedure Blank;
         Var
              lcv, lcv2: Integer;
         Begin
              GotoXY(16,5);
              c(15,2,3);
              For lcv := 5 to 19 do
                   Begin
                        For lcv2 := 2 to 49 do
                             Write(' ');
                        GotoXY(16, WhereY + 1);
                   End;
              GotoXY(1,1);
              c(15,2,1);
         End;
{////////////////////////////////////////////////////////}
    Procedure H1(var page:Integer);
{////////////////////////////////////////////////}
      Procedure H11;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü The Main Menu                      Page 1/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßß');  GotoXY(17,8);
                Write('The Main Menu is where you can select to:');  GotoXY(17,10);
                Write(' þ Add cards');  GotoXY(17,11);
                Write(' þ Delete cards');  GotoXY(17,12);
                Write(' þ Find cards');  GotoXY(17,13);
                Write(' þ Edit cards');  GotoXY(17,14);
                Write(' þ Print the list of cards to your screen');  GotoXY(17,15);
                Write(' þ Load cards from a disk file');  GotoXY(17,16);
                Write(' þ Save cards to a disk file');  GotoXY(17,17);
                Write(' þ Start a NEW card list');  GotoXY(17,19);
                Write('And you can also Quit the program all together.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H12;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Add Cards to List                  Page 2/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you add a card to the list, you must');  GotoXY(17,10);
                Write('enter in at least the name of the card.');  GotoXY(17,11);
                Write('Then you may enter in the card type,');  GotoXY(17,12);
                Write('power, strength, and the price of the card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H13;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Delete Cards from List             Page 3/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When wish to delete a card from the list,');  GotoXY(17,10);
                Write('you must enter in the name of the card');  GotoXY(17,11);
                Write('correctly.  Then the card is erased.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H14;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Find a Card in the List            Page 4/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you try to find a card in the list,');  GotoXY(17,10);
                Write('you will be asked to enter in the card''s name.');  GotoXY(17,11);
                Write('If you enter in the name CORRECTLY, CAPS AND');  GotoXY(17,12);
                Write('ALL, you will be told if the card is in the');  GotoXY(17,13);
                Write('data base.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H15;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Edit Cards                         Page 5/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('With this option you are able to change');  GotoXY(17,10);
                Write('any aspect of a card that have you entered');  GotoXY(17,11);
                Write('incorrectly when you first entered it.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H16;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Print Cards                        Page 6/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('When you choose this option you are asked');  GotoXY(17,10);
                Write('if you want to view 1 specified card or the');  GotoXY(17,11);
                Write('whole list of cards that have been entered in.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H17;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Save Card List                     Page 7/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('You can save your card list to a file on disk.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H18;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Load Card List                     Page 8/9');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('You can load your card list from a file');  GotoXY(17,10);
                Write('on disk.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H19;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Quit                               Page 9/9');  GotoXY(17,7);
                Write(' ßßßßßßß');  GotoXY(17,9);
                Write('Self-explanatory.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
         Begin
              If page < 1 then page := 0;
              If page > 9 then page := 10;
              Case page of
                   1: H11;
                   2: H12;
                   3: H13;
                   4: H14;
                   5: H15;
                   6: H16;
                   7: H17;
                   8: H18;
                   9: H19;
              End;
              If page = 0 then page := 1;
              If page = 10 then page := 9;
         End;
{////////////////////////////////////////////////////////}
    Procedure H2(var page:Integer);
{////////////////////////////////////////////////}
      Procedure H21;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü The Edit Menu                      Page 1/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßß');  GotoXY(17,8);
                Write('The Edit Menu is where you can select to:');  GotoXY(17,10);
                Write(' þ Change Card Name');  GotoXY(17,11);
                Write(' þ Change Card Type');  GotoXY(17,12);
                Write(' þ Change Power');  GotoXY(17,13);
                Write(' þ Change Strength');  GotoXY(17,14);
                Write(' þ Change Card Text  (LINE1)');  GotoXY(17,15);
                Write(' þ Change Card Text  (LINE2)');  GotoXY(17,16);
                Write(' þ Change Card Price');  GotoXY(17,18);
                Write('To EXIT the Edit Menu just press Escape.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H22;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Name                   Page 2/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current name of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H23;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Type                   Page 3/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current type of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H24;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Power                  Page 4/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current power of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H25;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Strength               Page 5/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current strength of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H26;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Text  (LINE1)               Page 6/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current 1st line of the');  GotoXY(17,10);
                Write('text of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H27;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Text  (LINE2)               Page 7/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current 2nd line of the');  GotoXY(17,10);
                Write('text of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
      Procedure H28;
           Begin
                Blank;
                GotoXY(17,6);
                c(8,1,3);
                Write(' Ü Change Card Price                  Page 8/8');  GotoXY(17,7);
                Write(' ßßßßßßßßßßßßßßßßßßßß');  GotoXY(17,9);
                Write('Lets you change the current price of a card.');  GotoXY(1,1);
           End;
{////////////////////////////////////////////////}
         Begin
              If page < 1 then page := 0;
              If page > 8 then page := 10;
              Case page of
                   1: H21;
                   2: H22;
                   3: H23;
                   4: H24;
                   5: H25;
                   6: H26;
                   7: H27;
                   8: H28;
              End;
              If page = 0 then page := 1;
              If page = 10 then page := 8;
         End;
{////////////////////////////////////////////////////////}
       Begin
            page := 1;
            GotoXY(15,4);
            c(15,2,3);
            WriteLn('ÉÍ[þ]ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');
            For lcv := 2 to 16 do
                 Begin
                      c(15,2,3);
                      GotoXY(15,WhereY);
                      Write('º                                                º');
                      c(8,2,0);
                      WriteLn('±±');
                 End;
            GotoXY(15, WhereY);
            c(15,2,3);
            Write('ÈÍESCÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍPgUpÍÍÍÍÍPgDownÍ¼');
            c(8,2,0);
            WriteLn('±±');
            GotoXY(17,WhereY);
            WriteLn('±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±');
            GotoXY(1,1);
            Repeat
                 If HelpType = 1 then H1(page);
                 If HelpType = 2 then H2(page);
                 Repeat
                      sel := ReadKey;
                 Until sel <> '';
                 Case Ord(sel) of
                      073: dec(page, 1);
                      081: inc(page, 1);
                 End;
            Until Ord(sel) = 027;
       End;
