Program ST_INIT;

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

Var
  co: File of Config;                   (*configuration file*)
  Confg: Config;                        (*configuration info*)
  h,m,sec,hund: Word;                   (*time indicaters*)
  h2,m2,s2,hund2: Word;                 (*second time indicaters*)
  SpinNum: Byte;                        (*spin cycle counter*)
  sel: Char;                            (*selection counter*)
  lcv: Integer;                         (*loop control*)
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
Procedure MenS(SelOption:Char; Texts: String);
  Begin
    c(12,2,0);
    Write('<');
    c(10,2,0);
    Write(SelOption);
    c(12,2,0);
    Write('>    ');
    c(5,1,0);
    Write(Texts);
    c(7,1,0);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Center(Texts:String);
  Begin
    GotoXY(40-(Length(Texts) div 2),WhereY);
    WriteLn(Texts);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Spin(var SpinNum:Byte);
  Begin
    inc(SpinNum,1);
    c(15,2,0);
    Case SpinNum of
      1: Write('|');
      2: Write('/');
      3: Write('-');
      4: Write('\');
    End;
    If SpinNum = 4 then SpinNum := 0;
    c(7,1,0);
    GotoXY(WhereX-1,WhereY);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ChangeMaxSect(var MAXSECT,MAXUSER,MAXPORT,MAXPLAN,MAXSHIP: Integer);
  Var
    TmpMaxSect: Real;
  Begin
    WriteLn;
    c(15,2,0);
    WriteLn('Enter in a number between 20 and 200');
    Write(': ');
    ReadLn(MAXSECT);
    If MAXSECT < 20 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No lower than 20!');
        Delay(1500);
        MAXSECT := 100;
      End;
    If MAXSECT > 200 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No higher than 200!');
        Delay(1500);
        MAXSECT := 100;
      End;
    TmpMaxSect := MAXSECT;
    MAXUSER := Round(TmpMaxSect * 0.8);  (*80% of sectors*)
    MAXPORT := Round(TmpMaxSect * 0.4);  (*40% of sectors*)
    MAXPLAN := Round(TmpMaxSect * 1);   (*100% of sectors*)
    MAXSHIP := (MAXUSER * 2);   (*200% of players*)
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ChangeMaxUser(var MAXUSER,MAXSHIP: Integer);
  Var
    TmpMaxSect: Real;
  Begin
    TmpMaxSect := MAXSECT;
    WriteLn;
    c(15,2,0);
    WriteLn('Enter in a number between 16 and 160');
    WriteLn('  (Default number is 80% of the total number of sectors)');
    Write(': ');
    ReadLn(MAXUSER);
    If MAXUSER < 16 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No lower than 16!');
        Delay(1500);
        MAXUSER := Round(TmpMaxSect * 0.8);
      End;
    If MAXUSER > 160 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No higher than 160!');
        Delay(1500);
        MAXUSER := Round(TmpMaxSect * 0.8);
      End;
    MAXSHIP := (MAXUSER * 2);   (*200% of players*)
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ChangeMaxPort(var MAXPORT: Integer);
  Var
    TmpMaxSect: Real;
  Begin
    TmpMaxSect := MAXSECT;
    WriteLn;
    c(15,2,0);
    WriteLn('Enter in a number between 8 and 80');
    WriteLn('  (Default number is 40% of the total number of sectors)');
    Write(': ');
    ReadLn(MAXPORT);
    If MAXPORT < 8 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No lower than 8!');
        Delay(1500);
        MAXPORT := Round(TmpMaxSect * 0.4);
      End;
    If MAXPORT > 80 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No higher than 80!');
        Delay(1500);
        MAXPORT := Round(TmpMaxSect * 0.4);
      End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ChangeMaxPlan(var MAXPLAN: Integer);
  Var
    TmpMaxSect: Real;
  Begin
    TmpMaxSect := MAXSECT;
    WriteLn;
    c(15,2,0);
    WriteLn('Enter in a number between 20 and 200');
    WriteLn('  (Default number is 100% of the total number of sectors)');
    Write(': ');
    ReadLn(MAXPLAN);
    If MAXPLAN < 20 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No lower than 20!');
        Delay(1500);
        MAXPLAN:= Round(TmpMaxSect * 1);
      End;
    If MAXPLAN > 200 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No higher than 200!');
        Delay(1500);
        MAXPLAN := Round(TmpMaxSect * 1);
      End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ChangeMaxShip(var MAXSHIP: Integer);
  Var
    TmpMaxSect: Real;
  Begin
    TmpMaxSect := MAXSECT;
    WriteLn;
    c(15,2,0);
    WriteLn('Enter in a number between 32 and 320');
    WriteLn('  (Default number is 200% of the total number of users)');
    Write(': ');
    ReadLn(MAXSHIP);
    If MAXSHIP < 32 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No lower than 32!');
        Delay(1500);
        MAXSHIP := Round(TmpMaxSect * 2);
      End;
    If MAXSHIP > 320 then
      Begin
        c(28,2,0);
        Sound(950);
        Delay(500);
        NoSound;
        WriteLn('No higher than 320!');
        Delay(1500);
        MAXSHIP := Round(TmpMaxSect * 2);
      End;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure CreateUsers(MAXUSER: Integer);
  Var
    u: File of User;                   (*player file*)
    Users: User;                       (*player info*)
    lcv: Integer;                      (*loop control*)
  Begin
    WriteLn;
    c(3,1,0);
    WriteLn('Creating players. . .');
    c(7,1,0);
    Users.Name := '';
    Users.NetName := '';
    Users.LastOn.Month := 0;
    Users.LastOn.Day := 0;
    Users.LastOn.Year := 0;
    Users.LastOn.DayofWeek := 0;
    Users.KilledBy := 0;
    Users.TurnsLeft := 0;
    Users.Location := 0;
    Users.CurrentShip := 0;
    Users.Credits := 0;
    Users.LastSectorIn := 0;
    Users.MemberOfCorp := 0;
    Users.ExpPts := 0;
    Users.MoralRnk := 0;
    Users.TimesBlownUp := 0;
    Users.BountyAmount := 0;
    Users.BountyCount := 0;
    Users.ContractAmount := 0;
    Users.ContractCount := 0;
    Users.BankBalance := 0;
    Assign(u, 'USER.DAT');
    Write('  Creating file ');
    ReWrite(u);
    SpinNum := 0;
    For lcv := 1 to MAXUSER + 1 do
      Begin
        Spin(SpinNum);
        Write(u,Users);
      End;
    Close(u);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure CreateShips(MAXSHIP:Integer);
  Var
    sh: File of Ship;                  (*ship file*)
    Ships: Ship;                       (*ship info*)
    lcv: Integer;                      (*loop control*)
  Begin
    WriteLn;
    c(3,1,0);
    WriteLn('Creating ships. . .');
    c(7,1,0);
    Ships.Name := '';
    Ships.DateBuilt := '';
    Ships.OwnBy := 0;
    Ships.ShipPass := '';
    Ships.Shields := 0;
    Ships.Fighters := 0;
    Ships.Holds := 0;
    Ships.Ore := 0;
    Ships.Org := 0;
    Ships.Equ := 0;
    Ships.Coli := 0;
    Ships.Sector := 0;
    Ships.OnPlanetNum := 0;
    Ships.Ports := 0;
    Ships.Kills := 0;
    Ships.Class := 0;
    Ships.Model := 0;
    Ships.TWarp := FALSE;
    Ships.Cloked := FALSE;
    Ships.LRScanner := 0;
    Ships.Genises := 0;
    Ships.Class1 := 0;
    Ships.Class2 := 0;
    Ships.Beacons := 0;
    Ships.AtomicDet := 0;
    Ships.PMissile := 0;
    Ships.Corbomite := 0;
    Ships.EtherProbes := 0;
    Ships.MineDis := 0;
    Ships.PsyProbe := FALSE;
    Ships.PlanetScanner := FALSE;
    Ships.LimpitOwner := 0;
    Assign(sh, 'SHIP.DAT');
    Write('  Creating file ');
    ReWrite(sh);
    SpinNum := 0;
    For lcv := 1 to MAXSHIP + 1 do
      Begin
        Spin(SpinNum);
        Write(sh,Ships);
      End;
    Close(sh);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure CreateSectors(MAXSECT: Integer);
 Var
  s: File of Sector;                   (*sector file*)
  Sect,Sect2: Sector;                  (*sector info*)
  lcv,lcv2: Integer;                   (*loop control*)
  cntr,cntr2: Integer;                 (*link control*)
  loc: Integer;                        (*sector locater*)
{////////////////////////////////////////////////////////////////////}
  Function FindEmpty(Sect2:Sector): Integer;
    Var
      lcv: Integer;                    (*loop control*)
      found: Boolean;                  (*link find*)
    Begin
      lcv := 0;
      found := FALSE;
      Repeat
        inc(lcv,1);
        Case lcv of
          1: If Sect2.WarpA = 0 then found := TRUE;
          2: If Sect2.WarpB = 0 then found := TRUE;
          3: If Sect2.WarpC = 0 then found := TRUE;
          4: If Sect2.WarpD = 0 then found := TRUE;
          5: If Sect2.WarpE = 0 then found := TRUE;
          6: If Sect2.WarpF = 0 then found := TRUE;
        End;
      Until (lcv = 6) or (found);
      If found then FindEmpty := lcv
        Else lcv := 0;
    End;  (*FindEmpty*)
{////////////////////////////////////////////////////////////////////}
 Begin  (*CreateSectors*)
  WriteLn;
  c(3,1,0);
  WriteLn('Creating sectors. . .');
  c(7,1,0);
  Randomize;
  Sect.NebName := '';
  Sect.Beacon := '';
  Sect.WarpA := 0;
  Sect.WarpB := 0;
  Sect.WarpC := 0;
  Sect.WarpD := 0;
  Sect.WarpE := 0;
  Sect.WarpF := 0;
  Sect.PortNum := 0;
  Sect.NavHaz := 0;
  Sect.FighterNum := 0;
  Sect.FighterOwn := 0;
  Sect.FighterStat := 0;
  Sect.TollColect := 0;
  Sect.Class1Num := 0;
  Sect.Class2Num := 0;
  Assign(s, 'SECTOR.DAT');
  Write('  Creating file ');
  ReWrite(s);
  SpinNum := 0;
  For lcv := 1 to MAXSECT + 1 do
    Begin
      Spin(SpinNum);
      Write(s, Sect);
    End;
  Close(s);
  WriteLn(' DONE');
  Write('  Linking sectors ');
  ReSet(s);
  SpinNum := 0;
    For lcv := 1 to MAXSECT do
      Begin
        Spin(SpinNum);
        Seek(s,lcv);
        Read(s, Sect);
        For lcv2 := 1 to 6 do
          Begin
            cntr := Random(MAXSECT) + 1;
            If cntr = lcv then cntr := 0
              Else Begin
                     Case lcv2 of
                       1: Begin
                            If Sect.WarpA = 0 then
                              Begin
                                Sect.WarpA := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpA link*)
                       2: Begin
                            If Sect.WarpB = 0 then
                              Begin
                                Sect.WarpB := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpB link*)
                       3: Begin
                            If Sect.WarpC = 0 then
                              Begin
                                Sect.WarpC := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpC link*)
                       4: Begin
                            If Sect.WarpD = 0 then
                              Begin
                                Sect.WarpD := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpD link*)
                       5: Begin
                            If Sect.WarpE = 0 then
                              Begin
                                Sect.WarpE := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpE link*)
                       6: Begin
                            If Sect.WarpF = 0 then
                              Begin
                                Sect.WarpF := cntr;
                                Seek(s,cntr);
                                Read(s,Sect2);
                                loc := FindEmpty(Sect2);
                                Case loc of
                                  1: Sect2.WarpA := lcv;
                                  2: Sect2.WarpB := lcv;
                                  3: Sect2.WarpC := lcv;
                                  4: Sect2.WarpD := lcv;
                                  5: Sect2.WarpE := lcv;
                                  6: Sect2.WarpF := lcv;
                                End;
                                Seek(s,cntr);
                                Write(s,Sect2);
                              End;
                          End;  (*WarpF link*)
                     End;  (*Case for links*)
                   End;  (*Link for warp 'lcv2'*)
          End;  (*All links for sector 'lcv'*)
        Seek(s,lcv);
        Write(s,Sect);
{        Write('Sector #',lcv,' links to ',Sect.WarpA,'  ',Sect.WarpB);
        WriteLn('  ',Sect.WarpC,'  ',Sect.WarpD,'  ',Sect.WarpE,'  ',Sect.WarpF);}
      End;  (*Finished with sector 'lcv'*)
  Close(s);
  WriteLn(' DONE');
  WriteLn;
 End;  (*CreateSectors*)
{////////////////////////////////////////////////////////////////////////////}
Procedure CreatePlanets(MAXPLAN:Integer);
  Var
    p: File of Planet;                 (*planet file*)
    Planets: Planet;                   (*planet info*)
    lcv: Integer;                      (*loop control*)
  Begin
    WriteLn;
    c(3,1,0);
    WriteLn('Creating planets. . .');
    c(7,1,0);
    Planets.Name := '';
    Planets.CBy := '';
    Planets.OwnBy := 0;
    Planets.Sector := 0;
    Planets.Class := 0;
    Planets.NumPeoOre := 0;
    Planets.NumPeoOrg := 0;
    Planets.NumPeoEqu := 0;
    Planets.Ore := 0;
    Planets.Org := 0;
    Planets.Equ := 0;
    Planets.MiliReac := 0;
    Planets.QAtoms := 0;
    Planets.QSector := 0;
    Planets.Fighters := 0;
    Planets.CidlLvl := 0;
    Planets.CidlConts := 0;
    Planets.Shields := 0;
    Planets.Treasury := 0;
    Planets.TransLvl := 0;
    Assign(p, 'PLANET.DAT');
    Write('  Creating file ');
    ReWrite(p);
    SpinNum := 0;
    For lcv := 1 to MAXPLAN + 1 do
      Begin
        Spin(SpinNum);
        Write(p,Planets);
      End;
    Close(p);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure CreatePorts(MAXPORT:Integer);
  Var
    s: File of Sector;                 (*sector file*)
    po: File of Port;                  (*port file*)
    Ports: Port;                       (*port info*)
    Sect: Sector;                      (*sector info*)
    lcv: Integer;                      (*loop control*)
    loc: Integer;                      (*sector location finder*)
{////////////////////////////////////////////////////////////////////}
  Function EmptySect: Integer;
    Var
      cntr: Integer;
      found: Boolean;
    Begin
      found := FALSE;
      Randomize;
      ReSet(s);
      Repeat
        Repeat
          cntr := Random(MAXSECT) + 1;
        Until cntr <> 1;
        Seek(s,cntr);
        Read(s,Sect);
        If Sect.PortNum = 0 then found := TRUE;
      Until found;
      Close(s);
      If found then EmptySect := cntr
        Else EmptySect := 0;
    End;
{////////////////////////////////////////////////////////////////////}
  Begin
    WriteLn;
    Randomize;
    c(3,1,0);
    WriteLn('Creating ports. . .');
    c(7,1,0);
    Ports.Name := '';
    Ports.LastShip := 0;
    Ports.LastRobber := 0;
    Ports.Ore := 1000;
    Ports.Org := 1000;
    Ports.Equ := 1000;
    Assign(po, 'PORT.DAT');
    Write('  Creating file ');
    ReWrite(po);
    SpinNum := 0;
    For lcv := 1 to MAXPORT + 1 do
      Begin
        Spin(SpinNum);
        With Ports do
          Begin
            Class := Random(7) + 1;
            OreProd := Random(200) + 1;
            OrgProd := Random(200) + 1;
            EquProd := Random(200) + 1;
            OreCostChange := Random(200) - 100;
            OrgCostChange := Random(200) - 100;
            EquCostChange := Random(200) - 100;
          End;
        Write(po,Ports);
      End;
    Close(po);
    WriteLn(' DONE');
    Assign(s, 'SECTOR.DAT');
    Write('  Linking ports ');
    ReSet(po);
    SpinNum := 0;
    For lcv := 2 to MAXPORT do
      Begin
        Spin(SpinNum);
        loc := EmptySect;
        If loc <> 0 then
          Begin
            ReSet(s);
            Seek(s,loc);
            Read(s,Sect);
            Sect.PortNum := lcv;
            Seek(s,loc);
            Write(s,Sect);
            Close(s);
          End;
      End;
    Close(po);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure SpiffUpFeds;
  Var
    s: File of Sector;
    Sect: Sector;
  Begin
    SpinNum := 0;
    WriteLn;
    c(3,1,0);
    WriteLn('Building planets. . .');
    c(7,1,0);
    Write('  Stablizing matter ');
    Assign(s, 'SECTOR.DAT');
    ReSet(s);
    Seek(s,1);
    Spin(SpinNum);
    Sect.NebName := 'Terran';  (*SECTOR 1*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 2;
    Sect.WarpB := 3;
    Sect.WarpC := 4;
    Sect.WarpD := 5;
    Sect.WarpE := 6;
    Sect.WarpF := 7;
    Sect.PortNum := 1;
    Sect.NavHaz := 0;
    Sect.FighterNum := 0;
    Sect.FighterOwn := 0;
    Sect.FighterStat := 0;
    Sect.TollColect := 0;
    Sect.Class1Num := 0;
    Sect.Class2Num := 0;
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 2*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 1;
    Sect.WarpB := 3;
    Sect.WarpC := 4;
    Sect.WarpD := 7;
    Sect.WarpE := 8;
    Sect.WarpF := 9;
    Sect.PortNum := 0;
    Seek(s,2);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 3*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 2;
    Sect.WarpB := 4;
    Sect.WarpC := 5;
    Sect.WarpD := 6;
    Sect.WarpE := 7;
    Sect.WarpF := 8;
    Seek(s,3);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 4*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 3;
    Sect.WarpB := 5;
    Sect.WarpC := 6;
    Sect.WarpD := 8;
    Sect.WarpE := 9;
    Sect.WarpF := 10;
    Seek(s,4);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 5*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 1;
    Sect.WarpB := 3;
    Sect.WarpC := 6;
    Sect.WarpD := 7;
    Sect.WarpE := 14;
    Sect.WarpF := 12;
    Seek(s,5);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 6*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 2;
    Sect.WarpB := 4;
    Sect.WarpC := 5;
    Sect.WarpD := 9;
    Sect.WarpE := 12;
    Sect.WarpF := 14;
    Seek(s,6);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 7*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 1;
    Sect.WarpB := 2;
    Sect.WarpC := 3;
    Sect.WarpD := 4;
    Sect.WarpE := 5;
    Sect.WarpF := 18;
    Seek(s,7);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 8*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 4;
    Sect.WarpB := 8;
    Sect.WarpC := 12;
    Sect.WarpD := 16;
    Sect.WarpE := 18;
    Sect.WarpF := 20;
    Seek(s,8);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 9*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 1;
    Sect.WarpB := 3;
    Sect.WarpC := 6;
    Sect.WarpD := 9;
    Sect.WarpE := 16;
    Sect.WarpF := 17;
    Seek(s,9);
    Write(s,Sect);
    Spin(SpinNum);
    Read(s,Sect);
    Sect.NebName := 'Terran';  (*SECTOR 10*)
    Sect.Beacon := 'Federation Space';
    Sect.WarpA := 1;
    Sect.WarpB := 2;
    Sect.WarpC := 4;
    Sect.WarpD := 5;
    Sect.WarpE := 7;
    Sect.WarpF := 8;
    Seek(s,10);
    Write(s,Sect);
    Close(s);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure SpiffUpPorts;
  Var
    po: File of Port;
    Ports: Port;
  Begin
    SpinNum := 0;
    WriteLn;
    c(3,1,0);
    WriteLn('Port construction. . .');
    c(7,1,0);
    Write('  Building StarPorts ');
    Assign(po, 'PORT.DAT');
    ReSet(po);
    Spin(SpinNum);
    Seek(po,1);
    Read(po,Ports);
    Ports.Name := 'Sol';
    Ports.Class := 0;
    Ports.Ore := 1000;
    Ports.Org := 1000;
    Ports.Equ := 1000;
    Ports.OreProd := 200;
    Ports.OrgProd := 200;
    Ports.EquProd := 200;
    Seek(po,1);
    Write(po,Ports);
    Spin(SpinNum);
    Ports.Name := 'Shallow Space 9';
    Write(po,Ports);
    Spin(SpinNum);
    Ports.Name := 'Alpha Centauri';
    Write(po,Ports);
    Spin(SpinNum);
    Ports.Name := 'Stargate Alpha';
    Ports.Class := 9;
    Write(po,Ports);
    Close(po);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure SpiffUpPlanets;
  Var
    p: File of Planet;
    Planets: Planet;
  Begin
    SpinNum := 0;
    Randomize;
    WriteLn;
    c(3,1,0);
    WriteLn('Planet conolization. . .');
    c(7,1,0);
    Write('  Evolution begins ');
    Assign(p, 'PLANET.DAT');
    ReSet(p);
    Spin(SpinNum);
    Seek(p,1);
    With Planets do
      Begin
        Name := 'Terra';
        CBy := '<UNKNOWN>';
        OwnBy := -1;
        Sector := 1;
        Class := 0;
        NumPeoOre := 0;
        NumPeoOrg := 0;
        NumPeoEqu := 0;
        Ore := 0;
        Org := 0;
        Equ := 0;
        MiliReac := 0;
        QAtoms := 0;
        QSector := 0;
        Fighters := 0;
        CidlLvl := 0;
        CidlConts := 0;
        Shields := 0;
        Treasury := 0;
        TransLvl := 0;
      End;
    Write(p,Planets);
    Seek(p,2);
    Read(p,Planets);
    Spin(SpinNum);
    With Planets do
      Begin
        Name := 'Wwow Homeworld';
        CBy := '<UNKNOWN>';
        OwnBy := -2;
        Repeat
          Sector := Random(MAXSECT)+1;
        Until Sector > 10;
        NumPeoOre := 800;
        NumPeoOrg := 800;
        NumPeoEqu := 800;
        Ore := 200;
        Org := 200;
        Equ := 200;
        MiliReac := 100;
        QAtoms := 100;
        QSector := 20;
        Fighters := 20000;
        CidlLvl := 1;
      End;
    Seek(p,2);
    Write(p,Planets);
    Spin(SpinNum);
    Seek(p,3);
    Read(p,Planets);
    With Planets do
      Begin
        Name := 'Za''ha''doom';
        CBy := '<UNKNOWN>';
        OwnBy := -3;
        Repeat
          Sector := Random(MAXSECT)+1;
        Until Sector > 10;
        NumPeoOre := 400;
        NumPeoOrg := 400;
        NumPeoEqu := 400;
        Ore := 100;
        Org := 100;
        Equ := 100;
        MiliReac := 100;
        QAtoms := 100;
        QSector := 20;
        Fighters := 10000;
      End;
    Seek(p,3);
    Write(p,Planets);
    Close(p);
    WriteLn(' DONE');
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure DisplayInformation;
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
    lcv,loc: Integer;
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
        If Plan.Sector = lcv then found := TRUE;
      Until (lcv2 = MAXPLAN) or (found);
      Close(p);
      If found then PlanetFind := lcv2
        Else PlanetFind := 0;
    End;
{////////////////////////////////////////////////////////////////////}
  Begin
    ClrScr;
    Assign(s, 'SECTOR.DAT');
    Assign(u, 'USER.DAT');
    Assign(p, 'PLANET.DAT');
    Assign(po, 'PORT.DAT');
    Assign(sh, 'SHIP.DAT');
    lcv := 0;
    ReSet(s);
    ReSet(u);
    ReSet(p);
    ReSet(po);
    ReSet(s);
    ReSet(sh);
    Repeat
      inc(lcv,1);
      Seek(s,lcv);
      Read(s,Sect);
      c(10,2,0);
      Write('Sector  ');c(14,2,0);Write(': ');c(11,2,0);Write(lcv);c(2,1,0);Write(' in ');
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
      Write(Sect.WarpC,' - ',Sect.WarpD,' - ',Sect.WarpE,' - ',Sect.WarpF);c(7,1,0);
      WriteLn;
      WriteLn;
      ReadLn;
    Until lcv = MAXSECT;
    Close(s);
    Close(u);
    Close(p);
    Close(po);
    Close(sh);
  End;
{////////////////////////////////////////////////////////////////////////////}
Begin
  MAXSECT := 100;
  MAXUSER := 80;
  MAXPORT := 40;
  MAXPLAN := 100;
  MAXSHIP := 160;
  Repeat
    c(8,1,0);
    ClrScr;
    c(15,2,4);
    For lcv := 1 to 80 do
      Write(' ');
    GotoXY(1,1);
    Center('Stellar Traveler Installition  v1.0');
    c(7,1,0);
    WriteLn;
    WriteLn;
    MenS('Z','Begin universe creation');WriteLn;WriteLn;
    MenS('A','Change number of sectors');WriteLn('        (',MAXSECT,')');
    MenS('B','Change number of players');WriteLn('        (',MAXUSER,')');
    MenS('C','Change number of ports  ');WriteLn('        (',MAXPORT,')');
    MenS('D','Change number of planets');WriteLn('        (',MAXPLAN,')');
    MenS('E','Change number of ships  ');WriteLn('        (',MAXSHIP,')');
    WriteLn;
    MenS('Q','Quit');
    Repeat
      Repeat
        sel := ReadKey;
      Until sel <> '';
      sel := UpCase(sel);
      Case sel of
        'A': ChangeMaxSect(MAXSECT,MAXUSER,MAXPORT,MAXPLAN,MAXSHIP);
        'B': ChangeMaxUser(MAXUSER,MAXSHIP);
        'C': ChangeMaxPort(MAXPORT);
        'D': ChangeMaxPlan(MAXPLAN);
        'E': ChangeMaxShip(MAXSHIP);
      End;
    Until (sel = 'Z') or (sel = 'A') or (sel = 'B') or (sel = 'C') or
          (sel = 'D') or (sel = 'E') or (sel = 'Q');
  Until (sel = 'Z') or (sel = 'Q');
  If sel = 'Z' then
    Begin
      GetTime(h,m,sec,hund);  (*startup time*)
      c(7,1,0);
      Assign(co, 'CONFIG.DAT');
      ReWrite(co);
      Confg.Maxes[1] := MAXSECT;
      Confg.Maxes[2] := MAXUSER;
      Confg.Maxes[3] := MAXPORT;
      Confg.Maxes[4] := MAXPLAN;
      Confg.Maxes[5] := MAXSHIP;
      Write(co,Confg);
      Close(co);
      ClrScr;
      CreateUsers(MAXUSER);
      CreateShips(MAXSHIP);
      CreateSectors(MAXSECT);
      CreatePlanets(MAXPLAN);
      CreatePorts(MAXPORT);
      SpiffUpFeds;
      SpiffUpPorts;
      SpiffUpPlanets;
{      DisplayInformation;}
      GetTime(h2,m2,s2,hund2);  (*ending time*)
      WriteLn;
      WriteLn;
      WriteLn('  Started at [',h2,':',m,':',sec,']');
      WriteLn('    Ended at [',h2,':',m2,':',s2,']');
      WriteLn;
    End;
End.