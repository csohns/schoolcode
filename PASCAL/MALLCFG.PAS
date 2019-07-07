Program Mall_Configuration;

Uses CRT;

Type
   Config_rec = Record
                  peroff: LongInt;            {system wide}
                  mincharge: LongInt;
                  maxcharge: LongInt;
                  loanactive: Boolean;        {loan service}
                  minloan: LongInt;
                  maxloan: LongInt;
                  loanperiod: LongInt;
                  peyeactive: Boolean;        {private eye service}
                  peyecost: LongInt;
                  peyechance: LongInt;
                  twarpactive: Boolean;    {T-Warp tow service}
                  twarpcost: LongInt;
                  cshopactive: Boolean;       {Custom Ship Shop}
                  cshopholds: LongInt;
                  cshopfighters: LongInt;
                  cshopmines: LongInt;
                  cshoppulsars: LongInt;
                  cshopturns: LongInt;
                  cshopgenesis: LongInt;
                  cshopplasmas: LongInt;
                  cshoptransport: LongInt;
                  bturnactive: Boolean;       {Block Turn Service}
                  bturnmaxturns: LongInt;
                  bturnamtturnsperturn: LongInt;
                End;

Var
  cfgfile: file of Config_rec;
  c: Config_rec;
  sel: Char;
  change: Boolean;

{////////////////////////////////////////////////////////////////}
Procedure InitFile;
  Begin
    c.peroff := 10;
    c.mincharge := 1;
    c.maxcharge := 8000;
    c.loanactive := false;
    c.minloan := 1000;
    c.maxloan := 1000000;
    c.loanperiod := 30;
    c.peyeactive := true;
    c.peyecost := 1000;
    c.peyechance := 60;
    c.twarpactive := true;
    c.twarpcost := 500;
    c.cshopactive := true;
    c.cshopholds := 400;
    c.cshopfighters := 100;
    c.cshopmines := 12000;
    c.cshoppulsars := 115000;
    c.cshopturns := 1000;
    c.cshopgenesis := 8000;
    c.cshopplasmas := 400000;
    c.cshoptransport := 17000;
    c.bturnactive := false;
    c.bturnmaxturns := 500;
    c.bturnamtturnsperturn := 10;
  End;
{////////////////////////////////////////////////////////////////}
Procedure CData;
  Var
    sel: Char;
{////////////////////////////////////////////////////////}
  Procedure LServe;
    Var
      sel: Char;
    Begin
      Repeat
        WriteLn;
        Write('1. active.....: ');
        If c.loanactive = true then
          WriteLn('TRUE')
        Else WriteLn('FALSE');
        WriteLn('2. loan min...: $', c.minloan);
        WriteLn('3. loan max...: $', c.maxloan);
        Write('4. loan period: ', c.loanperiod);
        If c.loanperiod = 1 then
          WriteLn(' day')
        Else WriteLn(' days');
        WriteLn;
        WriteLn('Q. Done');
        WriteLn;
        Repeat
          Repeat
            sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
            '1': If c.loanactive = true then
                   c.loanactive := false
                 Else c.loanactive := true;
            '2': Begin
                   Write('Enter in minimum loan amount:  ');
                   ReadLn(c.minloan);
                 End;
            '3': Begin
                   Write('Enter in maxium loan amount:  ');
                   ReadLn(c.maxloan);
                 End;
            '4': Begin
                   Write('Enter in loan period amount (in days):  ');
                   ReadLn(c.loanperiod);
                 End;
          End;
        Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = '4') or
              (sel = 'Q');
      Until sel = 'Q';
    End;
{////////////////////////////////////////////////////////}
  Procedure PEye;
    Var
      sel: Char;
    Begin
      Repeat
        WriteLn;
        Write('1. active........: ');
        If c.peyeactive = true then
          WriteLn('TRUE')
        Else WriteLn('FALSE');
        WriteLn('2. scan cost.....: $', c.peyecost);
        WriteLn('3. sucessful scan: ', c.peyechance, '%');
        WriteLn;
        WriteLn('Q. Done');
        WriteLn;
        Repeat
          Repeat
            sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
            '1': If c.peyeactive = true then
                   c.peyeactive := false
                 Else c.peyeactive := true;
            '2': Begin
                   Write('Enter in cost for scan:  ');
                   ReadLn(c.peyecost);
                 End;
            '3': Begin
                   Write('Enter in percentage chance for a successful scan:  ');
                   ReadLn(c.peyechance);
                 End;
          End;
        Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = 'Q');
      Until sel = 'Q';
    End;
{////////////////////////////////////////////////////////}
  Procedure TWarp;
    Var
      sel: Char;
    Begin
      Repeat
        WriteLn;
        Write('1. active.........: ');
        If c.twarpactive = true then
          WriteLn('TRUE')
        Else WriteLn('FALSE');
        WriteLn('2. cost for towing: $', c.twarpcost);
        WriteLn;
        WriteLn('Q. Done');
        WriteLn;
        Repeat
          Repeat
            sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
            '1': If c.twarpactive = true then
                   c.twarpactive := false
                 Else c.twarpactive := true;
            '2': Begin
                   Write('Enter in cost for TransWarp towing:  ');
                   ReadLn(c.twarpcost);
                 End;
          End;
        Until (sel = '1') or (sel = '2') or (sel = 'Q');
      Until sel = 'Q';
    End;
{////////////////////////////////////////////////////////}
  Procedure Shop;
    Var
      sel: Char;
    Begin
      Repeat
        WriteLn;
        Write('1. active........: ');
        If c.cshopactive = true then
          WriteLn('TRUE')
        Else WriteLn('FALSE');
        WriteLn('2. holds cost....: $', c.cshopholds);
        WriteLn('3. fighters cost.: $', c.cshopfighters);
        WriteLn('4. mines cost....: $', c.cshopmines);
        WriteLn('5. pulsar cost...: $', c.cshoppulsars);
        WriteLn('6. turn cost.....: $', c.cshopturns);
        WriteLn('7. genesis cost..: $', c.cshopgenesis);
        WriteLn('8. plasma cost...: $', c.cshopplasmas);
        WriteLn('9. transport cost: $', c.cshoptransport);
        WriteLn;
        WriteLn('Q. Done');
        WriteLn;
        Repeat
          Repeat
            sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
            '1': If c.cshopactive = true then
                   c.cshopactive := false
                 Else c.cshopactive := true;
            '2': Begin
                   Write('Enter in cost for holds:  ');
                   ReadLn(c.cshopholds);
                 End;
            '3': Begin
                   Write('Enter in cost for fighters:  ');
                   ReadLn(c.cshopfighters);
                 End;
            '4': Begin
                   Write('Enter in cost for mines:  ');
                   ReadLn(c.cshopmines);
                 End;
            '5': Begin
                   Write('Enter in cost for pulsars:  ');
                   ReadLn(c.cshoppulsars);
                 End;
            '6': Begin
                   Write('Enter in cost for turns:  ');
                   ReadLn(c.cshopturns);
                 End;
            '7': Begin
                   Write('Enter in cost for genesis devices:  ');
                   ReadLn(c.cshopgenesis);
                 End;
            '8': Begin
                   Write('Enter in cost for plasma devices:  ');
                   ReadLn(c.cshopplasmas);
                 End;
            '9': Begin
                   Write('Enter in cost for transports:  ');
                   ReadLn(c.cshoptransport);
                 End;
          End;
        Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = '4') or
              (sel = '5') or (sel = '6') or (sel = '7') or (sel = '8') or
              (sel = '9') or (sel = 'Q');
      Until sel = 'Q';
    End;
{////////////////////////////////////////////////////////}
  Procedure TStore;
    Var
      sel: Char;
    Begin
      Repeat
        WriteLn;
        Write('1. active....: ');
        If c.bturnactive = true then
          WriteLn('TRUE')
        Else WriteLn('FALSE');
        WriteLn('2. max turns.: ', c.peyecost);
        WriteLn('3. turns/turn: ', c.peyechance);
        WriteLn;
        WriteLn('Q. Done');
        WriteLn;
        Repeat
          Repeat
            sel := ReadKey;
          Until sel <> '';
          sel := UpCase(sel);
          Case sel of
            '1': If c.bturnactive = true then
                   c.bturnactive := false
                 Else c.bturnactive := true;
            '2': Begin
                   Write('Enter in maximum amount of turns in storage:  ');
                   ReadLn(c.bturnmaxturns);
                 End;
            '3': Begin
                   Write('Enter in the number of game turns it will take to equal 1 stored turn:  ');
                   ReadLn(c.bturnamtturnsperturn);
                 End;
          End;
        Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = 'Q');
      Until sel = 'Q';
    End;
{////////////////////////////////////////////////////////}
  Begin
    Repeat
      WriteLn;
      WriteLn('(L)oan service      [Not Implmented]');
      WriteLn('(P)rivate Eye');
      WriteLn('Trans(W)arp towing');
      WriteLn('(C)ustom Ship Shop');
      WriteLn('(T)urn storage      [Not Implmented]');
      WriteLn('(Q)uit');
      WriteLn;
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        Case sel of
          'L': LServe;
          'P': PEye;
          'W': TWarp;
          'C': Shop;
          'T': TStore;
        End;
      Until (sel = 'L') or (sel = 'P') or (sel = 'W') or (sel = 'C') or
            (sel = 'T') or (sel = 'Q');
    Until sel = 'Q';
  End;
{////////////////////////////////////////////////////////////////}
Procedure SysData;
  Var
    sel: Char;
  Begin
    Repeat
      WriteLn;
      Write('1. sale percentage: ', c.peroff, '% off');
      If c.peroff = 0 then
        WriteLn('    NO SALE')
      Else If c.peroff = 100 then
             WriteLn('    FREE')
           Else WriteLn;
      WriteLn('2. min docking fee: $', c.mincharge);
      WriteLn('3. max docking fee: $', c.maxcharge);
      WriteLn('Q. Done');
      WriteLn;
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        Case sel of
          '1': Begin
                 Write('Enter in the percent off in the sale (0 means no sale):  ');
                 ReadLn(c.peroff);
                 While (c.peroff < 0) or (c.peroff > 100) do
                   Begin
                     WriteLn('[0 to 100]');
                     Write('Enter in the percent off in the sale (0 means no sale):  ');
                     ReadLn(c.peroff);
                   End;
               End;
          '2': Begin
                 Write('Enter in the minimum docking fee:  ');
                 ReadLn(c.mincharge);
                 While (c.mincharge < 0) or (c.mincharge > 2000000) do
                   Begin
                     WriteLn('[0 to 2,000,000]');
                     Write('Enter in the minimum docking fee:  ');
                     ReadLn(c.mincharge);
                   End;
               End;
          '3': Begin
                 Write('Enter in the maxium docking fee:  ');
                 ReadLn(c.maxcharge);
                 While (c.maxcharge < 0) or (c.maxcharge > 2000000) do
                   Begin
                     WriteLn('[0 to 2,000,000]');
                     Write('Enter in the maxium docking fee:  ');
                     ReadLn(c.maxcharge);
                   End;
               End;
        End;
      Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = 'Q');
    Until sel = 'Q';
  End;
{////////////////////////////////////////////////////////////////}
Begin
  change := false;
  Assign(cfgfile, 'mall.cfg');
  {$I-}
  ReSet(cfgfile);
  Close(cfgfile);
  {$I+}
  If IOResult <> 0 then
    Begin
      ReWrite(cfgfile);
      InitFile;
      Write(cfgfile, c);
      Close(cfgfile);
    End;
  ReSet(cfgfile);
  Read(cfgfile, c);
  Close(cfgfile);
  Repeat
    WriteLn;
    WriteLn('(S)- System data');
    WriteLn('(C)- Chanel data');
    WriteLn('(Q)- Quit!');
    WriteLn;
    Repeat
      Repeat
        sel := ReadKey;
      Until sel <> '';
      sel := UpCase(sel);
      Case sel of
         'C': CData;
         'S': SysData;
      End;
    Until (sel = 'S') or (sel = 'C') or (sel = 'Q');
  Until sel = 'Q';
  ReWrite(cfgfile);
  Write(cfgfile, c);
  Close(cfgfile);
End.