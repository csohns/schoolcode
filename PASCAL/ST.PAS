Program Stellar_Traveler;

Uses
  DOS, CRT;

Type
  String47 = String[47];
  Sector = Record
             NebName: String[40];
             Beacon: String[40];
             WarpA: Integer;
             WarpB: Integer;
             WarpC: Integer;
             WarpD: Integer;
             WarpE: Integer;
             WarpF: Integer;
             PortNum: Integer;
             NavHaz: Byte;
             FighterNum: LongInt;
             FighterOwn: Integer;
             FighterStat: Integer;
             TollColect: Real;
             Class1Num: Integer;
             Class2Num: Integer;
           End;
  DateRec = Record
              Month: Word;
              Day: Word;
              Year: Word;
              DayOfWeek: Word;
            End;
  User = Record
           Name: String47;
           NetName: String47;
           LastOn: DateRec;
           KilledBy: Integer;
           TurnsLeft: Integer;
           Location: Integer;
           CurrentShip: Integer;
           Credits: LongInt;
           LastSectorIn: Integer;
           MemberOfCorp: Integer;
           ExpPts: LongInt;
           MoralRnk: LongInt;
           TimesBlownUp: Integer;
           BountyAmount: LongInt;
           BountyCount: Integer;
           ContractAmount: LongInt;
           ContractCount: Integer;
           BankBalance: LongInt;
         End;
  Port = Record
           Name: String[40];
           LastShip: Integer;
           LastRobber: Integer;
           Class: Byte;
           Ore: LongInt;
           Org: LongInt;
           Equ: LongInt;
           OreProd: Integer;
           OrgProd: Integer;
           EquProd: Integer;
           OreCostChange: Integer;
           OrgCostChange: Integer;
           EquCostChange: Integer;
         End;
  Planet = Record
             Name: String[40];
             CBy: String47;
             OwnBy: Integer;
             Sector: Integer;
             Class: Byte;
             NumPeoOre: LongInt;
             NumPeoOrg: LongInt;
             NumPeoEqu: LongInt;
             Ore: LongInt;
             Org: LongInt;
             Equ: LongInt;
             MiliReac: Byte;
             QAtoms: Byte;
             QSector: Byte;
             Fighters: LongInt;
             CidlLvl: Byte;
             CidlConts: Integer;
             Shields: Integer;
             Treasury: LongInt;
             TransLvl: Integer;
           End;
  Ship = Record
           Name: String[40];
           DateBuilt: String[30];
           OwnBy: Integer;
           ShipPass: String[10];
           Shields: LongInt;
           Fighters: LongInt;
           Holds: Integer;
           Ore: Integer;
           Org: Integer;
           Equ: Integer;
           Coli: Integer;
           Sector: Integer;
           OnPlanetNum: Integer;
           Ports: LongInt;
           Kills: LongInt;
           Class: Byte;
           Model: Byte;
           TWarp: Boolean;
           Cloked: Boolean;
           LRScanner: Byte;
           Genises: Byte;
           Class1: Integer;
           Class2: Integer;
           Beacons: Integer;
           AtomicDet: Byte;
           PMissile: Byte;
           Corbomite: Integer;
           EtherProbes: Integer;
           MineDis: Integer;
           PsyProbe: Boolean;
           PlanetScanner: Boolean;
           LimpitOwner: Integer;
         End;
  Config = Record
             Maxes: Array[1..5] of Integer;
           End;
  TimeRec = Record
              Hour: Word;
              Minute: Word;
              Second: Word;
            End;
  Mes = Record
         ToUser: String47;
         FromUser: String47;
         DateSent: DateRec;
         TimeSent: TimeRec;
         Line1: String;
         Line2: String;
         Line3: String;
         Line4: String;
        End;
  Log = Record
         DateSent: DateRec;
         TimeSent: TimeRec;
         Line1: String;
         Line2: String;
         Line3: String;
         Line4: String;
        End;

Var
  mon,da,yea,dow: Word;                 (*date indicaters*)
  h,m,sec,hund: Word;                   (*time indicaters*)
  h2,m2,s2,hund2: Word;                 (*second time indicaters*)
  sel: Char;                            (*selection counter*)
  lcv: Integer;                         (*loop control*)
  CurrSect: Integer;                    (*current sector*)
  UserID: Integer;                      (*user ID number*)
                           (*ENVIROMENT MAXIMUMS*)
  MAXSECT: Integer;                     (*Max number of sectors*)
  MAXUSER: Integer;                     (*Max number of players*)
  MAXPORT: Integer;                     (*Max number of ports*)
  MAXPLAN: Integer;                     (*Max number of planets*)
  MAXSHIP: Integer;                     (*Max number of ships*)
{////////////////////////////////////////////////////////////////////////////}
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
{////////////////////////////////////////////////////////////////////////////}
Procedure UpStr(var name:String47);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(name) do
      name[lcv] := UpCase(name[lcv]);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Center(Texts:String);
  Begin
    GotoXY(40-(Length(Texts) div 2),WhereY);
    WriteLn(Texts);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ReadConfig;
  Var
    co: File of Config;                   (*configuration file*)
    Confg: Config;                        (*configuration info*)
  Begin
    Assign(co, 'CONFIG.DAT');
    ReSet(co);
    Read(co,Confg);
    MAXSECT := Confg.Maxes[1];
    MAXUSER := Confg.Maxes[2];
    MAXPORT := Confg.Maxes[3];
    MAXPLAN := Confg.Maxes[4];
    MAXSHIP := Confg.Maxes[5];
    Close(co);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure SignOn(var UserID, CurrSect:Integer);
  Var
    u: File of User;
    Users: User;
    TmpUserName: String47;
    loc: Integer;
    sel: Char;
{////////////////////////////////////////////////////////////////////}
  Function FindUser(TmpUN:String47): Integer;
    Var
      u: File of User;
      Users: User;
      lcv: Integer;
      found: Boolean;
    Begin
      Assign(u, 'USER.DAT');
      found := FALSE;
      lcv := 0;
      ReSet(u);
      Repeat
        inc(lcv,1);
        Seek(u,lcv);
        Read(u,Users);
        If Users.NetName = TmpUN then found := TRUE;
      Until (lcv = MAXUSER) or (found);
      Close(u);
      If found then FindUser := lcv
        Else FindUser := 0;
    End;
{////////////////////////////////////////////////////////////////////}
  Procedure CreateUser(var UserID, CurrSect:Integer);
    Var
      s: File of Sector;
      u: File of User;
      sh: File of Ship;
      Sect: Sector;
      Users: User;
      Ships: Ship;
      lcv,loc,loc2: Integer;
      sel: Char;
      Alias: String47;
      TmpSN: String[40];
      DayS, YearS, HourS, MinuteS, SecondS: String[30];
{////////////////////////////////////////////////////////////}
    Function FindUserSpace: Integer;
      Var
        u: File of User;
        Users: User;
        lcv: Integer;
        found: Boolean;
      Begin
        Assign(u, 'USER.DAT');
        found := FALSE;
        lcv := 0;
        ReSet(u);
        Repeat
          inc(lcv,1);
          Seek(u,lcv);
          Read(u,Users);
          If (Users.Location = 0) and (Users.NetName = '') then found := TRUE;
        Until (lcv = MAXUSER) or (found);
        Close(u);
        If found then FindUserSpace := lcv
          Else FindUserSpace := 0;
      End;
{////////////////////////////////////////////////////////////}
    Function FindEmptyShip: Integer;
      Var
        sh: File of Ship;
        Ships: Ship;
        lcv: Integer;
        found: Boolean;
      Begin
        Assign(sh, 'SHIP.DAT');
        found := FALSE;
        lcv := 0;
        ReSet(sh);
        Repeat
          inc(lcv,1);
          Seek(sh,lcv);
          Read(sh,Ships);
          If Ships.Sector = 0 then found := TRUE;
        Until (lcv = MAXSHIP) or (found);
        Close(sh);
        If found then FindEmptyShip := lcv
          Else FindEmptyShip := 0;
      End;
{////////////////////////////////////////////////////////////}
    Begin
      Assign(u, 'USER.DAT');
      Assign(sh, 'SHIP.DAT');
      loc := FindUserSpace;
      If loc = 0 then
        Begin
          ClrScr;
          WriteLn('Sorry, but the universe is full for the moment.');
          WriteLn('You need to wait until dies or is deleted.');
          WriteLn;
          WriteLn;
          Halt;
        End;
      Users.NetName := TmpUserName;
      Write('Do you want to have an alias? [Y,N]');
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
      Until (sel = 'Y') or (sel = 'N');
      WriteLn;
      If sel = 'N' then Users.Name := Users.NetName
        Else Begin
               Repeat
                 Write('Enter in your alias: ');
                 ReadLn(Alias);
                 If Alias = '' then WriteLn('You can''t use a blank as an alias!');
               Until Alias <> '';
               Users.Name := Alias;
             End;
      GetDate(yea,mon,da,dow);
      With Users do
        Begin
          LastOn.Month := mon;
          LastOn.Day := da;
          LastOn.Year := yea;
          KilledBy := 0;
          TurnsLeft := 200;
          Location := 1;
          Credits := 2000;
          LastSectorIn := 1;
          MemberOfCorp := 0;
          ExpPts := 0;
          MoralRnk := 0;
          TimesBlownUp := 0;
          BountyAmount := 0;
          BountyCount := 0;
          ContractAmount := 0;
          ContractCount := 0;
          BankBalance := 0;
        End;
      loc2 := FindEmptyShip;
      If loc2 = 0 then
        Begin
          WriteLn;
          WriteLn;
          WriteLn('Sorry, but all ships are in use at this moment.');
          WriteLn('  Try again later.');
          WriteLn;
          WriteLn;
          Halt;
        End
      Else Begin
             Users.CurrentShip := loc2;
             ReSet(u);
             Seek(u,loc);
             Write(u,Users);
             Close(u);
             Repeat
               Write('Enter in your ship''s name: ');
               ReadLn(TmpSN);
               If TmpSN = '' then WriteLn('You can''t use a blank as a ship name!');
             Until TmpSN <> '';
             ReSet(sh);
             Seek(sh,loc2);
             Read(sh,Ships);
             Close(sh);
             Ships.Name := TmpSN;
             Ships.OwnBy := loc;
             GetDate(yea,mon,da,dow);
             GetTime(h,m,sec,hund);
             Str(da, DayS);
             Str(h, HourS);
             Str(m, MinuteS);
             Str(sec, SecondS);
             Ships.DateBuilt := HourS+':'+MinuteS+':'+SecondS+' ';
             With Ships do
               Begin
                 Case dow of
                   0: DateBuilt := DateBuilt + 'Sun ';
                   1: DateBuilt := DateBuilt + 'Mon ';
                   2: DateBuilt := DateBuilt + 'Tue ';
                   3: DateBuilt := DateBuilt + 'Wed ';
                   4: DateBuilt := DateBuilt + 'Thu ';
                   5: DateBuilt := DateBuilt + 'Fri ';
                   6: DateBuilt := DateBuilt + 'Sat ';
                 End;
                 Case mon of
                   0: DateBuilt := DateBuilt + 'Jan ';
                   1: DateBuilt := DateBuilt + 'Feb ';
                   2: DateBuilt := DateBuilt + 'Mar ';
                   3: DateBuilt := DateBuilt + 'Apr ';
                   4: DateBuilt := DateBuilt + 'May ';
                   5: DateBuilt := DateBuilt + 'Jun ';
                   6: DateBuilt := DateBuilt + 'Jul ';
                   7: DateBuilt := DateBuilt + 'Aug ';
                   8: DateBuilt := DateBuilt + 'Sep ';
                   9: DateBuilt := DateBuilt + 'Oct ';
                  10: DateBuilt := DateBuilt + 'Nov ';
                  11: DateBuilt := DateBuilt + 'Dec ';
                 End;
                 DateBuilt := DateBuilt + DayS + ', ';
                 yea := yea + 2004;
                 Str(yea, YearS);
                 DateBuilt := DateBuilt + YearS;
                 ReSet(sh);
                 Seek(sh,loc2);
                 Write(sh,Ships);
                 Close(sh);
                 UserID := loc;
                 CurrSect := 1;
               End;  (*with ships*)
           End;  (*loc2 <> 0*)
    End;  (*create user*)
{////////////////////////////////////////////////////////////////////}
  Begin
    Assign(u, 'USER.DAT');
    WriteLn('Local user login. . .');
    Write('Enter in your REAL name: ');
    ReadLn(TmpUserName);
    UpStr(TmpUserName);
{    c(8,1,0);}
    c(7,1,0);
    ClrScr;
    c(15,2,4);
    For lcv := 1 to 80 do
      Write(' ');
    GotoXY(1,1);
    Center('Stellar Traveler Operating System v.1');
    c(7,1,0);
    WriteLn;
    WriteLn;
    loc := FindUser(TmpUserName);
    If loc <> 0 then
      Begin
        UserID := loc;
        ReSet(u);
        Seek(u,UserID);
        Read(u,Users);
        CurrSect := Users.Location;
        c(2,1,0);Write('Hello ');c(11,2,0);WriteLn(Users.Name,'!');
        WriteLn;
        c(7,1,0);Write('You haven''t been on since ');c(14,2,0);Write(Users.LastOn.Month,'/',Users.LastOn.Day,'/');
        WriteLn(Users.LastOn.Year);
        GetDate(yea,mon,da,dow);
        yea := yea + 2004;
        Users.LastOn.Month := mon;
        Users.LastOn.Day := da;
        Users.LastOn.Year := yea;
        Seek(u,UserID);
        Write(u,Users);
        Close(u);
{        Delay(2000);}
        WriteLn;
        WriteLn;
        c(6,1,0);
        WriteLn('You have ',Users.TurnsLeft,' left for this stardate.');
      End
    Else Begin
           WriteLn;
           WriteLn;
           WriteLn('I can''t find your name in my database, you must be a NEW PLAYER!!');
           Write('Do you want to [P]lay or [Q]uit?');
           Repeat
             Repeat
               sel := ReadKey;
             Until sel <> '';
             sel := UpCase(sel);
           Until (sel = 'P') or (sel = 'Q');
           WriteLn;
           Case sel of
             'P': CreateUser(UserID, CurrSect);
             'Q': Begin
                    ClrScr;
                    WriteLn('You wern''t WORTHY enough to play anyway!!');
                    WriteLn;
                    WriteLn;
                    Halt;
                  End;
           End;
           ReSet(u);
           Seek(u,UserID);
           Read(u,Users);
           c(8,1,0);
           ClrScr;
           c(7,1,0);
           c(10,2,0);Write('Hello ');c(11,2,0);WriteLn(Users.Name,'!');
           WriteLn;
           WriteLn;
           c(2,1,0);WriteLn('  Welcome to the wonderful world of Stellar Traverar!!');
           WriteLn('YOU are now able to raise through the ranks of the lowly LOOSERS, to the');
           WriteLn('HIGH ranks of the respected.  To prosper, you must have POWER over your');
           WriteLn('alies and CONTROL your enemies.');
           WriteLn;
           WriteLn;
           WriteLn('[PRESS ENTER TO CONTINUE. . .]');
           Repeat
           Until keypressed;
         End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ReadPersMsg(UserID:Integer);
  Var
    u: File of User;
    m: File of MES;
    Users: User;
    MesData: MES;
{////////////////////////////////////////////////////////////////////}
  Procedure BarDivider;
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to 40 do
        Begin
          c(11,2,0);
          Write('-');
          c(14,2,0);
          Write('=');
        End;
    End;
{////////////////////////////////////////////////////////////////////}
  Begin
    Assign(u, 'USER.DAT');
    ReSet(u);
    Seek(u,UserID);
    Read(u,Users);
    Close(u);
    Assign(m, 'STLOG.DAT');
    {$I-}
    ReSet(m);
    Close(m);
    {$I+}
    If IOResult = 0 then
      Begin
        ReSet(m);
        Repeat
          Read(m,MesData);
          With MesData do
            Begin
              If ToUser = Users.Name then
                Begin
                  BarDivider;
                  c(13,2,0);Write('From: ');c(14,2,0);Write(FromUser,'  ');c(2,1,0);Write('at ');
                  c(10,2,0);Write(TimeSent.Hour,':',TimeSent.Minute,':',TimeSent.Second);c(2,1,0);Write(' on ');
                  c(10,2,0);WriteLn(DateSent.Month,'/',DateSent.Day,'/',DateSent.Year);
                  WriteLn;c(15,2,0);
                  If Line1 <> '' then WriteLn(Line1);
                  If Line2 <> '' then WriteLn(Line2);
                  If Line3 <> '' then WriteLn(Line3);
                  If Line4 <> '' then WriteLn(Line4);
                End;
            End;
        Until EOF(m);
        BarDivider;
        WriteLn;
        WriteLn;
      End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure SectDisp(UserID, CurrSect:Integer);
  Var
    s: File of Sector;
    u: File of User;
    p: File of Planet;
    po: File of Port;
    sh: File of Ship;
    Sect: Sector;
    Users: User;
    Plan: Planet;
    Por: Port;
    Ships: Ship;
    loc: Integer;
    first: Boolean;
{////////////////////////////////////////////////////////////////////}
  Function PlanetFind(loc:Integer): Integer;
    Var
      p: File of Planet;
      Plan: Planet;
      lcv2: Integer;
      found: Boolean;
    Begin
      Assign(p, 'PLANET.DAT');
      found := FALSE;
      lcv2 := loc;
      ReSet(p);
      Repeat
        inc(lcv2,1);
        Seek(p,lcv2);
        Read(p,Plan);
        If Plan.Sector = CurrSect then found := TRUE;
      Until (lcv2 = MAXPLAN) or (found);
      Close(p);
      If found then PlanetFind := lcv2
        Else PlanetFind := 0;
    End;
{////////////////////////////////////////////////////////////////////}
  Begin
{    ClrScr;}
    WriteLn;
    WriteLn;
    Assign(s, 'SECTOR.DAT');
    Assign(u, 'USER.DAT');
    Assign(p, 'PLANET.DAT');
    Assign(po, 'PORT.DAT');
    Assign(sh, 'SHIP.DAT');
    ReSet(s);
    ReSet(u);
    ReSet(p);
    ReSet(po);
    ReSet(s);
    ReSet(sh);
    Seek(s,CurrSect);
    Read(s,Sect);
    c(10,2,0);
    Write('Sector  ');c(14,2,0);Write(': ');c(11,2,0);Write(CurrSect);c(2,1,0);Write(' in ');
    If Sect.NebName <> '' then
      Begin
        c(10,2,0);
        WriteLn(Sect.NebName);
      End
    Else Begin
           c(1,1,0);
           WriteLn('uncharted space');
         End;
    If Sect.Beacon <> '' then
      Begin
        c(5,1,0);Write('Beacon  ');c(14,2,0);Write(': ');c(4,1,0);WriteLn(Sect.Beacon);
      End;
    If Sect.PortNum <> 0 then
      Begin
        Seek(po,Sect.PortNum);
        Read(po,Por);
        c(5,1,0);Write('Ports   ');c(14,2,0);Write(': ');c(11,2,0);Write(Por.Name);c(14,2,0);Write(', ');c(5,1,0);
        Write('Class ');c(11,2,0);WriteLn(Por.Class);
      End;
    loc := 0;
    first := TRUE;
    Repeat
      If loc <> MAXPLAN then loc := PlanetFind(loc)
        Else loc := 0;
      If loc <> 0 then
        Begin
          If first then
            Begin
              c(5,1,0);Write('Planets ');c(14,2,0);Write(':');
              first := FALSE;
            End;
          GotoXY(11,WhereY);
          Seek(p,loc);
          Read(p,Plan);
          If Plan.CidlLvl >= 5 then
            Begin
              c(12,2,0);Write('<<<< ');c(2,1,0);Write('(');c(14,2,0);Write(Plan.Class);c(2,1,0);Write(') ');
              c(9,2,0);Write(Plan.Name);c(12,2,0);Write(' >>>>');c(2,1,0);WriteLn(' (Shielded)');
            End
          Else Begin
                 c(2,1,0);Write('(');c(14,2,0);Write(Plan.Class);c(2,1,0);Write(') ');
                 c(2,1,0);WriteLn(Plan.Name);
               End;
        End;
    Until loc = 0;
    c(10,2,0);Write('Warps to sector(s) ');c(14,2,0);Write(': ');c(11,2,0);Write(Sect.WarpA,' - ',Sect.WarpB,' - ');
    WriteLn(Sect.WarpC,' - ',Sect.WarpD,' - ',Sect.WarpE,' - ',Sect.WarpF);c(7,1,0);
    Close(s);
    Close(u);
    Close(p);
    Close(po);
    Close(sh);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Move(var UserID,CurrSect:Integer);
  Var
    s: File of Sector;
    u: File of User;
    sh: File of Ship;
    Sect: Sector;
    Users: User;
    Ships: Ship;
    SectMove: Integer;
{////////////////////////////////////////////////////////////////////}
  Function WarpIsHere(SM:Integer;Sect:Sector): Boolean;
    Var
      found: Boolean;
    Begin
      found := FALSE;
      With Sect do
        Begin
          If (SM = WarpA) or (SM = WarpB) or (SM = WarpC) or (SM = WarpD) or
             (SM = WarpE) or(SM = WarpF) then found := TRUE;
        End;
      WarpIsHere := found;
    End;
{////////////////////////////////////////////////////////////////////}
  Begin
    Assign(s, 'SECTOR.DAT');
    Assign(u, 'USER.DAT');
    Assign(sh, 'SHIP.DAT');
    ReSet(s);
    Seek(s,CurrSect);
    Read(s,Sect);
    Close(s);
    c(5,1,0);
    Write('Move to which sector: ');
    ReadLn(SectMove);
    If WarpIsHere(SectMove,Sect) then
      Begin
        ReSet(u);
        Seek(u,UserID);
        Read(u,Users);
        Users.Location := SectMove;
        Seek(u,UserID);
        Write(u,Users);
        Close(u);
        ReSet(sh);
        Seek(sh,Users.CurrentShip);
        Read(sh,Ships);
        Ships.Sector := SectMove;
        Seek(sh,Users.CurrentShip);
        Write(sh,Ships);
        Close(sh);
        CurrSect := SectMove;
        SectDisp(UserID,CurrSect);
      End
    Else Begin
           WriteLn;
           WriteLn('There is no such warp in this sector!');
           WriteLn;
         End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Begin
{  c(8,1,0);}
  c(7,1,0);
  ClrScr;
  c(7,1,0);
  ReadConfig;
  SignOn(UserID,CurrSect);
  ReadPersMsg(UserID);
  SectDisp(UserID,CurrSect);
  Repeat
    Repeat
      GetTime(h,m,sec,hund);
      c(5,1,0);
      WriteLn;
      Write('Command [');c(14,2,0);Write('TL');c(6,1,0);Write('=');c(14,2,0);Write(h,':',m,':',sec);c(5,1,0);Write(']');
      c(15,2,0);Write(':');c(5,1,0);Write('[');c(11,2,0);Write(CurrSect);c(5,1,0);Write('] : ');
      Repeat
        sel := ReadKey;
      Until sel <> '';
      Write(sel);
      sel := UpCase(sel);
      WriteLn;
      Case sel of
        'D': Begin
               c(15,2,1);
               Write('<Re-Display>');c(7,1,0);
               WriteLn;
               SectDisp(UserID,CurrSect);
             End;
        'M': Begin
               c(15,2,1);
               Write('<Move>');c(7,1,0);
               WriteLn;
               Move(UserID,CurrSect);
             End;
        'Q': Begin
               c(20,2,0);
               WriteLn('<Quiting>');
               c(5,1,0);
               WriteLn;
               WriteLn;
               Write('Are you sure? [Y,N] ');
               Repeat
                 sel := ReadKey;
               Until sel <> '';
               Write(sel);
               sel := UpCase(sel);
               If sel = 'Y' then sel := 'Q'
                 Else WriteLn;
             End;
      End;
    Until (sel = 'D') or (sel = 'Q');
  Until sel = 'Q';
  c(7,1,0);
  ClrScr;
End.