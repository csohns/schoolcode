Program Sound_Tester;

Uses
  CRT, DOS, credits;

Var
  num: Integer;

Procedure Give_Credit;
     Begin
          TextBackGround(0);
          ClrScr;
          Delay(2000);
          credit('DESIGN', 'by', 'Wipper');
          credit('DESIGN', 'by', 'QuasarMan');
          credit('SOFTWARE ENGINEERS', '', 'Fc');
          credit('SOFTWARE ENGINEERS', '', 'QGL');
          credit('PRODUCED', 'by', 'Chaos Continuum');
          credit('DIRECTED', 'by', 'CHRIS SOHNS, DAN SULLIVAN');
          credit('Special thanks', 'to', 'Vindicator');
          credit('Special thanks', 'to', 'The Cast');
          credit('Special thanks', 'to', 'Jason P. (yes, Jason, YOU!)');
          credit('Special thanks', 'to', 'CBAKIE');
          credit('Special thanks', 'to', 'Barney (must kill)');
          credit('Special thanks', 'to', 'the creators of Borland Pascal');
          credit('Special thanks', 'to', 'Chuck "Mr." Auck');
          credit('Special thanks', 'to', 'Bill Gates (JUST KIDDING!!!)');
          credit('Special thanks', 'to', 'J.J. Gauch');
          credit('and Special thanks', 'to', 'Jason Hall');
          credit('and always remember', 'this UNIVERSAL truth', 'CBIAD');
          ClrScr;
          Delay(4000);
     End;

Begin
  num := 37;
  ClrScr;
  WriteLn('This program tests you ability to hear high pitched sounds.');
  WriteLn;
  WriteLn;
  WriteLn('Press ENTER to see disclaimer...');
  ReadLn;
  ClrScr;
  WriteLn('   If you family has a history of heart attaks, high blood pressure,');
  WriteLn(' hemoraging, strokes, chicken pox, pregnancies, deaths, ebola,');
  WriteLn(' smallpox, T.B., multiple personalities, A.D.D., insanity, leprosy,');
  WriteLn(' any form of the plauge, rabies, F.I.V., krooked teeth, C.B.I.A.D.,');
  WriteLn(' voting for Clinton, likeing the OJ trial, hating computers,');
  WriteLn(' being patients of Dr. Kevorkian, kleptomania, electrocution,');
  WriteLn(' contact with the reclusive "humans", actually being human,');
  WriteLn(' being something other than human, being an inanimate object,');
  WriteLn(' H.I.V., finding Waldo, seeing Magic-Eye pictures, understanding C++,');
  WriteLn(' learning Assembler, seeing in color, eating that "red crap",');
  WriteLn(' accordian playing, knowing DOOM cheat codes, doing homework,');
  WriteLn(' reading instruction manuals, useing 5 1/4 floppy disks,');
  WriteLn(' owning 9.090 gig drives, not mocking Microsoft, blindness,');
  WriteLn(' touch typing, notknowingwherethespacebaris, knoeing hoaw tu spel,');
  WriteLn(' having DNA, knowing any language other the the mythical "ENGLISH",');
  WriteLn(' typing with the earlobes (Jason), liking Barney (mental note - must kill),');
  WriteLn(' using WINDOWS 95, talking to Aaron Lamers, using BASIC,');
  WriteLn(' playing TradeWars while ignoring your girlfriend (J.J.!!!),');
  WriteLn(' not wanting money, programming with anything other than a bat,');
  WriteLn(' sibling rivalry, being cloned, UFO sighting/abductions, C.B.I.A.D,');
  WriteLn(' playing Legend of Logitech, not taking advantage of other''s stupidity,');
  WriteLn(' being named after a quasi-stellar radio source, deafness,');
  WriteLn(' reading all the way through this...    Do not run this program. Moron!');
  WriteLn;
  Write('Press ENTER to continue...');
  ReadLn;

  Give_Credit;
End.