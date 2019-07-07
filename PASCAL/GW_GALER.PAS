{.}
                                {Chris Sohns}
                                  {GWGALER}
                                  {5/11/96}


Program Galaixy_Galeria_Mall;

Uses
   CRT, ANSIDRV;
Const
 numinv=12;
 numdev=53;
 numpdevs=15;
 invname: array[0..numinv] of string[40] =
           ('Rental Charge',         {0}
            'Ore',                   {1}
            'Org',                   {2}
            'Eqp',                   {3}
            'Credits',               {4}
            'Fighters',              {5}
            'Sector Mines',          {6}
            'Pulsar bombs',          {7}
            'Plasma devices',        {8}
            'Turns',                 {9}
            'Genesis devices',      {10}
            'Holds',                {11}
            'Transport passes');    {12}

 oinvprice: array[1..numinv] of longint =
            (     8,      15,        25,
                  1,      98,     15000,
             215000,   21500,      1500,
              10000,     500,     17500);

 devname: array[1..numdev] of string[40] =
           ('Starbase Teleporter',   {1}
            'Early Warning Sensor',  {2}
            'Ship-to-Ship scanner',  {3}
            'Planetary scanner',     {4}
            'Pulsar Tube',           {5}
            'Anticloak sensor',      {6}
            'Sensor Beacon',         {7}
            'Starbase scanner',      {8}
            'Fusion Cell',           {9}
            'Mine Deflector',       {10}
            'Cloaking Device',      {11}
            'AntiCloaking Device',  {12}
            'Emergency Warp',       {13}
            'Krypton Bomb',         {14}
            'Interstel link',       {15}
            'Homing Beacon',        {16}
            'Speed Dock',           {17}
            'Mine Diffuser',        {18}
            'Stun Mine',            {19}
            'Homing Detector',      {20}
            'Homing Jammer',        {21}
            'Phaser Bank-1000',     {22}
            'Phaser Shield-1000',   {23}
            'Phaser Bank-5000',     {24}
            'Phaser Shield-5000',   {25}
            'Renegade Pass',        {26}
            'Distortion Minimizer', {27}
            'Holographic Imager',   {28}
            'Sb-Aware Autopilot',   {29}
            'Scout-Autopilot',      {30}
            'Titanium Armor',       {31}
            'Regenerative Armor',   {32}
            'B-Group ACloak + 25%', {33}
            'Planetary Autodetect', {34}
            'Device Transport',     {35}
            'Krypton Deflect 10%',  {36}
            'Mine Deflector (10)',  {37}
            'Mine Deflector (15)',  {38}
            'Mine Deflector (20)',  {39}
            'Mine Deflector (25)',  {40}
            'Low Armor',            {41}   { 75 turn   }
            'Medium Armor',         {42}   { 250 turn  }
            'Heavy Armor',          {43}   { 1000 turn }
            'Super Regen Armor',    {44}   { 500 turn  }
            'Phaser Shield-10000',  {45}
            'Phaser Bank-10000',    {46}
            'Phaser Shield-20000',  {47}
            'Cloak/Anticloak pack', {48}
            'Scanner Pack',         {49}
            'Invasion Pack',        {50}
            'Red Cylinder',         {51}
            'Blue Cylinder',        {52}
            'Black Box');           {53}

 odevprice: array[1..numdev] of longint =
            (100000,    75000,    50000,    125000,
             350000,    80000,    30000,    175000,
              20000,   100000,    18000,     22000,
              27000,   250000,     8000,     80000,
              22000,   100000,    50000,     40000,
             160000,   150000,   175000,    575000,
             680000,    60000,   100000,     75000,
              50000,    75000,    50000,    300000,
             250000,    85000,    25000,    500000,
             250000,   500000,   750000,   1000000,
              25000,   100000,   300000,   1000000,
            1500000,  2500000,  3000000,    180000,
            2500000,  7500000,   150000,    500000,
             250000);
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

   Vault_Rec = Record
            Devices: array[1..100] of longint;
            credits: longint;
            fighters: longint;
            mines: longint;
            plasmas: longint;
            turns: longint;
            genesis: longint;
            holds: longint;
            eqp, ore, org: longint;
            charges: real;
            transport: longint;
            pulsars: longint;
           end;

   user_rec = record
             active: boolean;
             turns_left: word;
             timeused: byte;
             real_name: string[30];
             alias: string[30];
             last_day: string[8];
             holds: word;
             eqp: word;
             ore: word;
             org: word;
             fighters: longint;
             credits: longint;
             credit_account: longint;
             stocks: array[1..55] of word;
             mines: word;
             pulsar: word;
             LotteryTickets: word;
             onteam: word;
             genesis: word;
             plasma: word;
             timesdied: word;
             transport: word;
             sector: word;
             feds_destroyed: longint;
             cabal_destroyed: longint;
             devices: array[1..numpdevs] of word;
             devicedat: array[1..numpdevs] of word;
             devicestat: array[1..numpdevs] of word;
             shipstat: array[1..9] of word;
             lasthour: byte;
             lastmin: byte;
            end;

 stock_rec = record
              name: string[30];
              price: longint;
              trend: integer;
              avail: longint;
              prices: array[1..4] of longint;
              value: longint;
              lastvalue: longint;
             end;

 general_info = record
                 turns_per_day: word;
                 days_to_delete: word;
                 cost_of_fighter: longint;
                 cost_of_genesis: longint;
                 cost_of_pulsar: longint;
                 cost_of_escape: longint;
                 cost_of_mine: longint;
                 cost_of_lottery: longint;
                 cost_of_anticloak: longint;
                 cost_of_plasma: longint;
                 cost_of_transport: longint;
                 cost_of_hold: longint;
                 cost_of_turn: longint;
                 cost_of_outpost: longint;
                 cost_of_starbase: longint;
                 cabal_days: word;
                 cargo_holds: longint;
                 fighters: longint;
                 credits: longint;
                 sell_eqp, sell_org, sell_ore: word;
                 buy_eqp, buy_org, buy_ore: word;
                 stocks: array[1..55] of stock_rec;
                 password: string;
                 fedreport: array[1..50] of word;
                 fedstrength: array[1..50] of longint;
                 AllowRemote: boolean;
                 cabal_attack_earth: byte;
                 cabal_attack_top_player: byte;
                 cabal_remain_hq: byte;
                 cabal_remain_sec: byte;
                 cabal_num_groups: byte;
                 cabal_revenge: byte;
                 wanderer_move: word;
                 checkwarps: boolean;
                 Registered_name: string[30];
                 Registered_data: string[30];
                 time_today: word;
                 calls_today: word;
                 days: word;
                 time_total: longint;
                 calls_total: longint;
                 lastdate: array[1..4] of word;
                 statson: boolean;
                 statfile: string;
                 gambleon: boolean;
                 triviaenc: boolean;
                 gamblelimit: longint;
                 trivia_cost: longint;
                 trivia_pay: longint;
                 maxholds: word;
                 startvers: string[4];
                 curvers: string[4];
                 dp: array[1..30] of longint;
                 maxcloaks: word;
                 maxstuns: word;
                 maxmines: word;
                 cabal_base_sector: word;
                 cabal_planet_num: word;
                 FedKillPayoff: real;
                 FedKillPercent: real;
                 CabalKillPayoff: real;
                 CabalKillPercent: real;
                 tourny: word;
                 devprice: array[1..100] of longint;
                 amspecial: word;
                 cost_of_repair: longint;
                end;

Var
 cfgfile: file of Config_rec;
 vaultfile: file of vault_rec;
 userfile: file of user_rec;
 generalfile: file of general_info;
 o: Config_rec;
 v: vault_rec;
 u: user_rec;
 g: general_info;
 lcv,lcv2: Integer;
 recnum,sel,sel2: Integer;
 cntr: Integer;
 first: String;
 last: String;
 fee: LongInt;
 ABORT: Boolean;
{//////////////////}
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
{//////////////////}
Procedure pause;
  Var
    num: LongInt;
    sel: Char;
  Begin
    num := 0;
    c(5,1,0);
    Write('[PAUSE]');c(8,1,0);Write(' ');GotoXY(WhereX - 1, WhereY);c(7,1,0);
    Repeat
      sel := ReadKey;
      inc(num, 1);
      If num = 8000 then
        Begin
          c(5,2,0);
          Write('[Press any key to continue. . .]');
          c(7,1,0);
          num := 0;
        End;
    Until sel <> '';
  End;
{//////////////////}
Function twoupper(name:String): String;
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(name) do
      Begin
        name[lcv] := UpCase(name[lcv]);
      End;
    twoupper := name;
  End;
{//////////////////}
Procedure VaultNorm;
  Var
    sel: Integer;
    amount: Integer;
  Begin
    Repeat
      clrscr;
      c(2,2,0);
{      Write('Record ');c(7,1,0);Write('#');c(7,2,0);WriteLn(recnum);c(2,2,0);}
      WriteLn;
      WriteLn;
      Write('  *] Rental Charges: ');c(7,2,0);WriteLn(v.charges:0:0);c(2,2,0);
      WriteLn;
      Write('  1] Ore: ');c(7,2,0);Write(v.ore);c(2,2,0);
      GotoXY(40,5);
      Write('  7] Pulsar bombs: ');c(7,2,0);WriteLn(v.pulsars);c(2,2,0);
      Write('  2] Org: ');c(7,2,0);Write(v.org);c(2,2,0);
      GotoXY(40,6);
      Write('  8] Plasma devices: ');c(7,2,0);WriteLn(v.plasmas);c(2,2,0);
      Write('  3] Eqp: ');c(7,2,0);Write(v.eqp);c(2,2,0);
      GotoXY(40,7);
      Write('  9] Turns: ');c(7,2,0);WriteLn(v.turns);c(2,2,0);
      Write('  4] Credits: ');c(7,2,0);Write(v.credits);c(2,2,0);
      GotoXY(40,8);
      Write(' 10] Genesis devices: ');c(7,2,0);WriteLn(v.genesis);c(2,2,0);
      Write('  5] Fighters: ');c(7,2,0);Write(v.fighters);c(2,2,0);
      GotoXY(40,9);
      Write(' 11] Holds: ');c(7,2,0);WriteLn(v.holds);c(2,2,0);
      Write('  6] Sector Mines: ');c(7,2,0);Write(v.mines);c(2,2,0);
      GotoXY(40,10);
      Write(' 12] Transport passes: ');c(7,2,0);WriteLn(v.transport);
      WriteLn;
      WriteLn('You have ', u.credits, ' credits.');c(7,1,0);
      Write('Enter in item number or 9999 to Quit: ');
      ReadLn(sel);
      If sel <> 9999 then
        While ((sel < 1) or (sel > 12)) and (sel <> 9999) do
          Begin
            c(4,2,0);
            WriteLn('SELECTION MUST BE FROM 1 TO 12!');c(7,1,0);
            Write('Enter in item number or 9999 to Quit: ');
            ReadLn(sel);
          End;
      If sel <> 9999 then
        Begin
          WriteLn('Each ', invname[sel], ' costs ', oinvprice[sel], ' per unit.');
          WriteLn('You can purchase up to ', u.credits div oinvprice[sel], ' units.');
          Write('How many would you like to buy? ');
          ReadLn(amount);
          If (amount * oinvprice[sel]) > u.credits
            then Write('You do not have that much money!!!')
          Else
            Begin
              u.credits := u.credits - (oinvprice[sel] * amount);
              Case sel of
                1: v.ore := v.ore + amount;
                2: v.org := v.org + amount;
                3: v.eqp := v.eqp + amount;
                4: v.credits := v.credits + amount;
                5: v.fighters := v.fighters + amount;
                6: v.mines := v.mines + amount;
                7: v.pulsars := v.pulsars + amount;
                8: v.plasmas := v.plasmas + amount;
                9: v.turns := v.turns + amount;
               10: v.genesis := v.genesis + amount;
               11: v.holds := v.holds + amount;
               12: v.transport := v.transport + amount;
              End;
            End;
        End;
    Until sel = 9999;
  End;
{//////////////////}
Procedure VaultDevice;
  Var
    sel: Integer;
    amount: Integer;
  Begin
    Repeat
      clrscr;
      c(2,2,0);
{      Write('Record ');c(7,1,0);Write('#');c(7,2,0);WriteLn(recnum);c(2,2,0);}
      WriteLn;
      cntr := 0;
      For lcv := 1 to numdev do
        Begin
          If cntr = 3 then
            Begin
              WriteLn;
              cntr := 0;
            End;
          inc(cntr, 1);
          c(4,2,0);
          Write((lcv+100));c(7,2,0);Write('] ');c(2,2,0);
          For lcv2 := 1 to 11 do
            Write(devname[lcv,lcv2]);
          c(7,2,0);Write(' (');c(14,2,0);Write(v.devices[lcv]);c(7,2,0);Write(')  ');
        End;
      WriteLn;
      WriteLn('You have ', u.credits, ' credits.');
      c(7,1,0);
      Write('Enter in item number or 9999 to Quit: ');
      ReadLn(sel);
      If sel <> 9999 then
        While ((sel < 101) or (sel > 153)) and (sel <> 9999)  do
          Begin
            c(4,2,0);
            WriteLn('SELECTION MUST BE FROM 101 TO 153!');c(7,1,0);
            Write('Enter in item number or 9999 to Quit: ');
            ReadLn(sel);
          End;
      If sel <> 9999 then
        Begin
          WriteLn('Each ', devname[(sel - 100)], ' costs ', odevprice[(sel - 100)], ' per unit.');
          WriteLn('You can purchase up to ', u.credits div odevprice[(sel - 100)], ' units.');
          Write('How many would you like to buy? ');
          ReadLn(amount);
          If (amount * odevprice[(sel - 100)]) > u.credits
            then Write('You do not have that much money!!!')
          Else
            Begin
              u.credits := u.credits - (odevprice[(sel - 100)] * amount);
              v.devices[(sel - 100)] := v.devices[(sel - 100)] + amount;
            End;
        End;
    Until sel = 9999;
  End;
{//////////////////}
Procedure skip(interval:Integer);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to interval do
      WriteLn;
  End;
{//////////////////}
Procedure StockStuff;
  Var
    lcv, lcv2: Integer;
  Begin
    Seek(generalfile, 0);
    Read(generalfile, g);
    ClrScr;
    c(2,1,0);
    WriteLn('Stand by. . .');
    Delay(2000);
    c(7,1,0);
    ClrScr;
    For lcv := 1 to 8 do
      Begin
        WriteLn('name :  ', g.stocks[lcv].name);
        WriteLn('price: ', g.stocks[lcv].price);
        WriteLn('trend: ', g.stocks[lcv].trend);
        WriteLn('avail: ', g.stocks[lcv].avail);
        For lcv2 := 1 to 4 do
          WriteLn('Day ', lcv2, ': ', g.stocks[lcv].prices[lcv2]);
        WriteLn('value: ', g.stocks[lcv].value);
        WriteLn('lastvalue: ', g.stocks[lcv].lastvalue);
        ReadLn;
      End;
  End;
{//////////////////}
Procedure PriInvest;
  Var
    num: Byte;
    searchnum: Integer;
    sel: Char;
    name: String;
{//////////}
Function found2(name:String): Integer;
  Var
    have: Boolean;
    cntr: Integer;
    Begin
      have := false;
      cntr := 0;
      Seek(userfile, 0);
      While (NOT EOF(userfile)) and (NOT have) do
        Begin
          Read(userfile, u);
          If u.alias = name
            then Begin
                   found2 := cntr;
                   have := true;
                 End
            Else Begin
                     found2 := 0;
                     inc(cntr, 1);
                 End;
        End;
    End;
{//////////}
  Begin
    Randomize;
    num := Random(2);
    If num = 0 then
      ANSI('e:\ansi\cecil.ans', 0)
    Else ANSI('e:\ansi\private.ans', 0);
    skip(4);
    WriteLn('I charge $', o.peyecost, ' to locate a person.');
    skip(2);
    Write('What''d ya say?  ');
    Repeat
      sel := ReadKey;
    Until sel <> '';
    sel := UpCase(sel);
    WriteLn;
    If sel = 'Y' then
      Begin
        If u.credits - o.peyecost >= 0 then
          Begin
            Write('How do you want me to look for?  ');
            ReadLn(name);
            If name <> '' then
              Begin
                u.credits := u.credits - o.peyecost;
                Seek(userfile, recnum);
                Write(userfile, u);
                name := twoupper(name);
                searchnum := found2(name);
                num := Random(100) + 1;
                If (searchnum <> 0) and (num <= o.peyechance) then
                  Begin
                    WriteLn('SUCCESS!!');
                    WriteLn(name, ' is currently located in sector ', u.sector, '.');
                  End
                Else WriteLn('Sorry, I couldn''t find ', name, '.');
                Seek(userfile, recnum);
                Read(userfile, u);
                pause;
              End;
          End
        Else Begin
               ANSI('e:\ansi\noway.ans', 0);
               Delay(2000);
             End;
      End
    Else WriteLn('Don''t waste my time!');
  End;
{//////////////////}
Procedure Tow;
  Var
    num: Integer;
    sel : Char;
  Begin
    ANSI('e:\ansi\towing.ans', 0);
    skip(2);
    c(4,2,0);
    WriteLn('Welcome to TransWarp Towing!');
    c(7,2,0);
    Write('We can tow you anywhere from sector ');c(14,2,0);Write('1');c(7,2,0);Write(' to sector ');c(14,2,0);Write('2000');
    c(7,2,0);WriteLn('.');
    WriteLn('For the small cost of $', o.twarpcost, ', we are at your service.');c(7,1,0);
    WriteLn;
    Write('Are you in need of our services?  ');
    Repeat
      sel := ReadKey;
    Until sel <> '';
    sel := UpCase(sel);
    WriteLn;
    If sel = 'Y' then
      Begin
        If u.credits - o.twarpcost >= 0 then
          Begin
            Write('Which sector do you want to go to?  [0 means Quit]:  ');
            ReadLn(num);
            While (num < 0) or (num > 2000) do
              Begin
                WriteLn('[0 to 2000]');
                Write('Which sector do you want to go to?  [0 means Quit]');
                ReadLn(num);
              End;
            If num <> 0 then
              Begin
                u.credits := u.credits - o.twarpcost;
                TextColor(LightBlue + BLINK);
                WriteLn('Computing shortest path...');
                Delay(800);
                c(5,1,0);
                WriteLn('Interlink established with Federation Navigation system...');
                WriteLn('Sector transit information being downloaded.');
                Delay(2400);
                If num >= 1050 then
                  Begin
                    WriteLn('Remote locational beam connected.');
                    Delay(3200);
                  End;
                c(1,2,0);
                WriteLn('Computed.');
                Delay(1600);
                If num >= 1050 then
                  ANSI('e:\ansi\wormhole.ans', 4)
                Else ANSI('e:\ansi\transwrp.ans', 8);
                u.sector := num;
                skip(4);
                Write('There you go, you are now in sector ');c(14,2,0);Write(num);c(7,1,0);WriteLn('.');
                pause;
              End;
          End
        Else Begin
               ANSI('e:\ansi\noway.ans', 0);
               Delay(2000);
             End;
      End
    Else WriteLn('Don''t waste my time!');
  End;
{//////////////////}
Procedure Menu(num:Integer);
  Var
    sel: Char;
  Begin
    ABORT := false;
    ANSI('e:\ansi\mallopen.ans', 0);
    Delay(2000);
    Read(cfgfile, o);
    c(14,2,0);
    ClrScr;
    WriteLn('WELCOME ', u.alias, '!');c(7,2,0);
    Write('                  To the ');c(1,2,0);WriteLn('Galaixy Galleria Mall');c(7,1,0);
    skip(2);
    If o.peroff <> 0 then
      Begin
        Write('             The mall where everything is ');c(7,2,0);Write(o.peroff);c(4,1,0);Write('%');c(7,1,0);
        WriteLn(' off.');
      End;
    Delay(4000);
    skip(4);
    If o.maxcharge <> 0 then
      Begin
        Randomize;
        fee := Random(o.maxcharge) + o.mincharge;
        WriteLn(u.credits);
        c(7,2,0);Write('Today the mall entrance fee is ');c(2,2,0);Write('$');c(7,1,0);Write(fee);c(7,2,0);WriteLn('.');
        Write('Do you still want to enter? [Y or N]:  ');
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        WriteLn;
        If sel = 'Y' then
          Begin
            If u.credits < fee then
              Begin
                ABORT := true;
                ANSI('e:\ansi\noway.ans',0);
                {c(4,2,0);WriteLn('SECURITY!');Delay(200);
                c(7,1,0);Write('You don''t have enough credits to enter. BE GONE!');}
                Delay(2000);
              End
            Else Begin
                  u.credits := u.credits - fee;
                   c(7,1,0);
                   WriteLn;
                   WriteLn('Thank you, your DONATION will be used for improvments.');
                   Delay(2000);
                 End;
          End
        Else ABORT := true;
        If ABORT then
          Begin
            c(7,1,0);
            ClrScr;
            Halt;
          End;
      End
    Else Delay(2000);
    seek(vaultfile,num);
    Read(vaultfile,v);
    Repeat
      ClrScr;
      c(2,1,0);WriteLn('ษอออออออออออออออออออออออออออออออออออออออป');
      Write('บ     ');c(2,2,0);Write('Obvious places to go are');c(14,2,0);Write(':         ');c(2,1,0);WriteLn('บ');
      WriteLn('บ                                       บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('B');c(5,2,0);Write('> ');c(3,2,0);Write('Baker''s Business of COOL STU');
      Write('FF    ');c(2,1,0);WriteLn('บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('H');c(5,2,0);Write('> ');c(3,2,0);Write('The Stellar Hardware Emporium');
      Write('     ');c(2,1,0);WriteLn('บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('S');c(5,2,0);Write('> ');c(3,2,0);Write('See the Stock ticker tape    ');
      Write('     ');c(2,1,0);WriteLn('บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('P');c(5,2,0);Write('> ');c(3,2,0);Write('Cecil the Private Eye        ');
      Write('     ');c(2,1,0);WriteLn('บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('T');c(5,2,0);Write('> ');c(3,2,0);Write('TransWarp Towing             ');
      Write('     ');c(2,1,0);WriteLn('บ');
      WriteLn('บ                                       บ');
      Write('บ ');c(5,2,0);Write('<');c(4,2,0);Write('Q');c(5,2,0);Write('> ');c(3,2,0);Write('Quit and return to your ship');
      Write('      ');c(2,1,0);WriteLn('บ');
      c(2,1,0);WriteLn('ศอออออออออออออออออออออออออออออออออออออออผ');c(7,1,0);
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        sel := UpCase(sel);
        Case sel of
          'B': VaultNorm;
          'H': VaultDevice;
          'S': StockStuff;
          'P': If o.peyeactive then
                 PriInvest
               Else Begin
                      ANSI('e:\ansi\disable.ans', 0);
                      pause;
                    End;
          'T': If o.twarpactive then
                 Tow
               Else Begin
                      ANSI('e:\ansi\disable.ans', 0);
                      pause;
                    End;
        End;
      Until (sel = 'B') or (sel = 'H') or (sel = 'S') or (sel = 'P') or
            (sel = 'T') or (sel = 'Q');
{~5บ ~3<~5G~3> ~1The 2nd National Galactic Bank    ~5บ
~5บ ~3<~5P~3> ~1The Federal Space Police HQ       ~5บ
~5บ ~3<~5S~3> ~1The Federation Shipyards          ~5บ
~5บ ~3<~5T~3> ~1The Lost Trader's Tavern          ~5บ
~5บ ~3<~2!~3> ~dStardock Help                     ~5บ}
    Until sel = 'Q';
    seek(vaultfile,num);
    Write(vaultfile,v);
    seek(userfile,num);
    Write(userfile,u);
  End;
{//////////////////}
Function found: Integer;
  Var
    have: Boolean;
    cntr: Integer;
    Begin
      have := false;
      cntr := 0;
      While (NOT EOF(userfile)) and (NOT have) do
        Begin
          Read(userfile, u);
          If u.real_name = first + ' ' + last
            then Begin
                   found := cntr;
                   have := true;
                 End
            Else Begin
                     found := 0;
                     inc(cntr, 1);
                 End;
        End;
    End;
{//////////////////}
Begin
   Write('Enter in your first name:  ');
   ReadLn(first);
   Write('Enter in your last name:  ');
   Read(last);
   first := twoupper(first);
   last := twoupper(last);
   ClrScr;
   Assign(cfgfile, 'e:\tp\bin\mall.cfg');
   Assign(vaultfile, 'e:\tp\bin\ga\VAULT.GW');
   Assign(userfile, 'e:\tp\bin\ga\USERS7.GW');
   Assign(generalfile, 'e:\tp\bin\ga\GENERAL.GW');
   ReSet(cfgfile);
   ReSet(vaultfile);
   ReSet(userfile);
   ReSet(generalfile);
   recnum := found;
   If (recnum > 0 ) then menu(recnum)
     Else Begin
            WriteLn;
            WriteLn;
            WriteLn('Sorry, but I couldn''t find your name in my database.');
            WriteLn;
            WriteLn;
            Delay(2000);
          End;
   c(7,2,0);
   WriteLn('Thank you, and come again!');
   Close(cfgfile);
   Close(vaultfile);
   Close(userfile);
   Close(generalfile);
   c(7,1,0);
   Delay(2000);
End.