Uses
   CRT;
Const
 numinv=12;
 numdev=53;
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
Type
   Vault_Rec= Record
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
Var
 vaultfile: file of vault_rec;
 v: vault_rec;
 lcv,lcv2: Integer;
 num,sel,sel2: Integer;
 cntr: Integer;
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
Procedure VaultNorm;
  Var
    sel: Integer;
  Begin
    Repeat
      clrscr;
      c(2,2,0);
      Write('Record ');c(7,1,0);Write('#');c(7,2,0);WriteLn(num);c(2,2,0);
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
      Write(' 12] Transport passes: ');c(7,2,0);WriteLn(v.transport);c(7,1,0);
      WriteLn;
      Write('Enter in item number or 9999 to Quit: ');
      ReadLn(sel);
      If sel <> 9999 then
        While ((sel < 0) or (sel > 12)) and (sel <> 9999) do
          Begin
            c(4,2,0);
            WriteLn('SELECTION MUST BE FROM 1 TO 12!');c(7,1,0);
            Write('Enter in item number or 9999 to Quit: ');
            ReadLn(sel);
          End;
      If sel <> 9999 then
        Begin
          Write('Enter in the NEW amount for ', invname[sel], ': ');
          Case sel of
            0: ReadLn(v.charges);
            1: ReadLn(v.ore);
            2: ReadLn(v.org);
            3: ReadLn(v.eqp);
            4: ReadLn(v.credits);
            5: ReadLn(v.fighters);
            6: ReadLn(v.mines);
            7: ReadLn(v.pulsars);
            8: ReadLn(v.plasmas);
            9: ReadLn(v.turns);
           10: ReadLn(v.genesis);
           11: ReadLn(v.holds);
           12: ReadLn(v.transport);
          End;
        End;
    Until sel = 9999;
  End;
{//////////////////}
Procedure VaultDevice;
  Var
    sel: Integer;
    amount: Integer;
    lcv: Integer;
  Begin
    Repeat
      clrscr;
      c(2,2,0);
      Write('Record ');c(7,1,0);Write('#');c(7,2,0);WriteLn(num);c(2,2,0);
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
      c(7,1,0);
      Write('Enter in item number or 9999 to Quit: ');
      ReadLn(sel);
      If sel <> 9999 then
        While ((sel < 101) or (sel > 153)) and (sel <> 9900) and (sel <> 9999)  do
          Begin
            c(4,2,0);
            WriteLn('SELECTION MUST BE FROM 101 TO 153!');c(7,1,0);
            Write('Enter in item number or 9999 to Quit: ');
            ReadLn(sel);
          End;
      If sel <> 9999 then
        Begin
          If sel = 9900 then
            Begin
              Write('Enter in NEW amount for everything:  ');
              ReadLn(amount);
              For lcv := 1 to 53 do
                v.devices[lcv] := amount;
            End
          Else Begin
                 Write('Enter in the NEW amount for ', devname[(sel - 100)], ': ');
                 ReadLn(v.devices[(sel - 100)]);
               End;
        End;
    Until sel = 9999;
  End;
{//////////////////}
Procedure Menu(num:Integer);
  Var
    sel: Char;
  Begin
    seek(vaultfile,num);
    Read(vaultfile,v);
    Repeat
      c(7,1,0);
      Write('Enter in menu number [1,2, or Q to Quit]: ');
      ReadLn(sel);
      sel := UpCase(sel);
      If sel = '1' then VaultNorm
        Else If sel = '2' then VaultDevice
    Until sel = 'Q';
    seek(vaultfile,num);
    Write(vaultfile,v);
  End;
{//////////////////}
Begin
   ClrScr;
   Assign(vaultfile, 'e:\tp\bin\ga\VAULT.GW');
   ReSet(vaultfile);
   Repeat
        Begin
             ClrScr;
             c(7,1,0);
             Write('Enter in record number [or 9999 to Quit]: ');
             ReadLn(num);
             If (num <> 9999) and (num >= 0) and (num < 204) then
               Begin
                 menu(num);
                 WriteLn;
                 c(7,1,0);
               End;
        End;
   Until num = 9999;
   Close(vaultfile);
   c(7,1,0);
   ClrScr;
End.