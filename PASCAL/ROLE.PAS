Program TareNet;

Uses
     CRT, DOS, ANSWERS;

Type
     PlayerType = (Mercinary, Asassian, Hacker, Ranger, Police_Officer,
                   Cyber_Cop, Borg, Force_Command);
     ArmorType = (Clothes, Leather, BulletVest, Adimantemum, PSG);
     WeaponType = (knife, stun_gun, pistol, rifle_22, magnum_44, SemiAuto,
                   Auto, Gatling_gun, Rocket_Launcher, Laser_Gun, Ion_Gun,
                   NE2000, NPG, None);
     Player_Record = record
                          name : ST26;
                          Hp: Integer;
                          ptype: PlayerType;
                          experance: LongInt;
                          allinment: LongInt;
                          money: LongInt;
                          armor: ArmorType;
                          AHp: Integer;
                          weapon1: WeaponType;
                          weapon2: WeaponType;
                          weapon3: WeaponType;
                          weapon4: WeaponType;
                          weapon5: WeaponType;
                          weapon6: WeaponType;
                          weapon7: WeaponType;
                          weapon8: WeaponType;
                          ammo1: Integer;
                          ammo2: Integer;
                          ammo3: Integer;
                          ammo4: Integer;
                          ammo5: Integer;
                          ammo6: Integer;
                          ammo7: Integer;
                          ammo8: Integer;
                     End;

Var
     Player: Player_Record;
{////////////////////////////////////////////////////////////////////////}
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
{////////////////////////////////////////////////////////////////////////}
Procedure Init(var player:Player_Record);
     Var
          sel: Char;
     Begin
          player.name := '';
          player.Hp := 0;
          player.ptype := Borg;
          player.experance := 0;
          player.allinment := 0;
          player.money := 0;
          player.armor := Clothes;
          player.AHp := 0;
          player.weapon1 := None;
          player.ammo1 := 0;
          player.weapon2 := None;
          player.ammo2 := 0;
          player.weapon3 := None;
          player.ammo3 := 0;
          player.weapon4 := None;
          player.ammo4 := 0;
          player.weapon5 := None;
          player.ammo5 := 0;
          player.weapon6 := None;
          player.ammo6 := 0;
          player.weapon7 := None;
          player.ammo7 := 0;
          player.weapon8 := None;
          player.ammo8 := 0;
          c(15,2,0);
          Write('Enter in your player''s name:  ');
          answer26(player.name, WhereX, WhereY);
          ClrScr;
          WriteLn('  1.)  Mercinary        5.)  Police Officer');
          WriteLn;
          WriteLn('  2.)  Asassian         6.)  Cyber Cop');
          WriteLn;
          WriteLn('  3.)  Hacker           7.)  Borg');
          WriteLn;
          WriteLn('  4.)  Ranger');
          Repeat
               GotoXY(1,11);
               Write('Enter in your occupation:  ');
               Repeat
                    sel := ReadKey;
               Until sel <> '';
          Until (sel = '1') or (sel = '2') or (sel = '3') or (sel = '4') or
                (sel = '5') or (sel = '6') or (sel = '7');
          With player do
               Case sel of
                    '1': Begin
                              ptype := Mercinary;
                              Hp := 100;
                              AHp := 200;
                              money := 2000;
                              armor := BulletVest;
                              weapon1 := knife;
                              ammo1 := 0;
                              weapon2 := SemiAuto;
                              ammo2 := 200;
                              weapon3 := magnum_44;
                              ammo3 := 8;
                         End;
                    '2': Begin
                              ptype := Asassian;
                              Hp := 80;
                              AHp := 8;
                              money := 800;
                              weapon1 := knife;
                              ammo1 := 0;
                              weapon2 := Pistol;
                              ammo2 := 20;
                         End;
                    '3': Begin
                              ptype := Hacker;
                              Hp := 100;
                              AHp := 8;
                              money := 8000;
                              weapon1 := knife;
                              ammo1 := 0;
                              weapon2 := Stun_Gun;
                              ammo2 := 4;
                         End;
                    '4': Begin
                              ptype := Ranger;
                              Hp := 100;
                              AHp := 100;
                              money := 400;
                              armor := Leather;
                              weapon1 := knife;
                              ammo1 := 0;
                              weapon2 := Auto;
                              ammo2 := 400;
                              weapon3 := rifle_22;
                              ammo3 := 10;
                         End;
                    '5': Begin
                              ptype := Police_Officer;
                              Hp := 100;
                              AHp := 200;
                              money := 200;
                              armor := BulletVest;
                              weapon1 := knife;
                              ammo1 := 0;
                              weapon2 := Stun_Gun;
                              ammo2 := 20;
                              weapon3 := pistol;
                              ammo3 := 20;
                         End;
                    '6': Begin
                              ptype := Cyber_Cop;
                              Hp := 1000;
                              AHp := 800;
                              money := 100;
                              armor := PSG;
                              weapon1 := Laser_Gun;
                              ammo1 := 40;
                              weapon2 := NPG;
                              ammo2 := 2;
                         End;
                    '7': Begin
                              ptype := Borg;
                              Hp := 2000;
                              AHp := 600;
                              money := 80;
                              armor := Adimantemum;
                              weapon1 := Auto;
                              ammo1 := 400;
                              weapon2 := Gatling_Gun;
                              ammo2 := 800;
                         End;
               End;
          If player.name = 'Wipper' then
               Begin
                    player.ptype := Hacker;
                    player.Hp := 32767;
                    player.AHp := 32767;
                    player.experance := 8000000;
                    player.allinment := 8000000;
                    player.money := 2147483647;
                    player.armor := PSG;
                    player.weapon1 := knife;
                    player.ammo1 := 0;
                    player.weapon2 := Auto;
                    player.ammo2 := 32767;
                    player.weapon3 := Gatling_Gun;
                    player.ammo3 := 32767;
                    player.weapon4 := Rocket_Launcher;
                    player.ammo4 := 32767;
                    player.weapon5 := Laser_Gun;
                    player.ammo5 := 32767;
                    player.weapon6 := Ion_Gun;
                    player.ammo6 := 32767;
                    player.weapon7 := NE2000;
                    player.ammo7 := 32767;
                    player.weapon8 := NPG;
                    player.ammo8 := 32767;
               End;
          WriteLn;
          Write('Press [ENTER] to see your new stats. . .');
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure Stats(var player:Player_Record);
     Begin
          ClrScr;
          c(14,2,0);
          GotoXY(6,WhereY);
          WriteLn('ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»');  GotoXY(6,WhereY);
          WriteLn('º Name:                                                              º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Occupation:                                                        º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Hp:        ³ Armor:              ³ Armor Hp:                       º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Experance:             ³ Allinment:                                º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º 1.)                  ³ 2.)                  ³ 3.)                  º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Ammo:                ³ Ammo:                ³ Ammo:                º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º 4.)                  ³ 5.)                  ³ 6.)                  º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Ammo:                ³ Ammo:                ³ Ammo:                º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º 7.)                  ³ 8.)                  ³                      º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Ammo:                ³ Ammo:                ³                      º');  GotoXY(6,WhereY);
          WriteLn('ÇÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¶');  GotoXY(6,WhereY);
          WriteLn('º Credits:             ³                      ³                      º');  GotoXY(6,WhereY);
          WriteLn('ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼');
          c(7,1,0);
          GotoXY(8,2);
          Write('Name:');
          GotoXY(8,4);
          Write('Occupation:');
          GotoXY(8,6);
          Write('Hp:');
          GotoXY(21,6);
          Write('Armor:');
          GotoXY(43,6);
          Write('Armor Hp:');
          GotoXY(8,8);
          Write('Experance:');
          GotoXY(33,8);
          Write('Allinment:');
          GotoXY(8,10);
          Write('1.)');
          GotoXY(31,10);
          Write('2.)');
          GotoXY(54,10);
          Write('3.)');
          GotoXY(8,12);
          Write('Ammo:');
          GotoXY(31,12);
          Write('Ammo:');
          GotoXY(54,12);
          Write('Ammo:');
          GotoXY(8,14);
          Write('4.)');
          GotoXY(31,14);
          Write('5.)');
          GotoXY(54,14);
          Write('6.)');
          GotoXY(8,16);
          Write('Ammo:');
          GotoXY(31,16);
          Write('Ammo:');
          GotoXY(54,16);
          Write('Ammo:');
          GotoXY(8,18);
          Write('7.)');
          GotoXY(31,18);
          Write('8.)');
          GotoXY(8,20);
          Write('Ammo:');
          GotoXY(31,20);
          Write('Ammo:');
          GotoXY(8,22);
          Write('Credits:');
          With player do
               Begin
                    c(15,2,0);
                    GotoXY(15,2);
                    Write(name);
                    c(9,2,0);
                    GotoXY(21,4);
                    Case ptype of
                         Mercinary     : Write('Mercinary');
                         Asassian      : Write('Asassian');
                         Hacker        : Write('Hacker');
                         Ranger        : Write('Ranger');
                         Police_Officer: Write('Police Officer');
                         Cyber_Cop     : Write('Cyber Cop');
                         Borg          : Write('Borg');
                    End;
                    c(4,2,0);
                    GotoXY(13,6);
                    Write(Hp);
                    c(5,1,0);
                    GotoXY(29,6);
                    Case armor of
                         Clothes: Write('Clothes');
                         Leather: Write('Leather');
                         BulletVest: Write('Bullet Vest');
                         Adimantemum: Write('Adimantemum');
                         PSG: Write('PSG');
                    End;
                    c(6,1,0);
                    GotoXY(53,6);
                    Write(AHp);
                    c(3,2,0);
                    GotoXY(20,8);
                    Write(experance);
                    c(3,2,0);
                    GotoXY(45,8);
                    Write(allinment);
                    c(11,1,0);
                    GotoXY(13,10);
                    Case weapon1 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    GotoXY(36,10);
                    Case weapon2 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    GotoXY(59,10);
                    Case weapon3 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    c(13,2,0);
                    GotoXY(15,12);
                    If ammo1 > 0 then Write(ammo1);
                    GotoXY(38,12);
                    If ammo2 > 0 then Write(ammo2);
                    GotoXY(61,12);
                    If ammo3 > 0 then Write(ammo3);
                    c(11,1,0);
                    GotoXY(13,14);
                    Case weapon4 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    GotoXY(36,14);
                    Case weapon5 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    GotoXY(59,14);
                    Case weapon6 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    c(13,2,0);
                    GotoXY(15,16);
                    If ammo4 > 0 then Write(ammo4);
                    GotoXY(38,16);
                    If ammo5 > 0 then Write(ammo5);
                    GotoXY(61,16);
                    If ammo6 > 0 then Write(ammo6);
                    c(11,1,0);
                    GotoXY(13,18);
                    Case weapon7 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    GotoXY(36,18);
                    Case weapon8 of
                         knife          : Write('Knife');
                         stun_gun       : Write('Stun Gun');
                         pistol         : Write('Pistol');
                         rifle_22       : Write('22 rifle');
                         magnum_44      : Write('44 magnum');
                         SemiAuto       : Write('Semi-Automatic');
                         Auto           : Write('Automatic');
                         Gatling_gun    : Write('Gatling Gun');
                         Rocket_Launcher: Write('Rocket Launcher');
                         Laser_Gun      : Write('Laser Gun');
                         Ion_Gun        : Write('Ion Gun');
                         NE2000         : Write('NE2000');
                         NPG            : Write('NPG');
                    End;
                    c(13,2,0);
                    GotoXY(15,20);
                    If ammo7 > 0 then Write(ammo7);
                    GotoXY(38,20);
                    If ammo8 > 0 then Write(ammo8);
                    c(10,2,0);
                    GotoXY(18,22);
                    Write(money);
                    c(7,0,0);
               End;
          GotoXY(1,24);
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////////////}
Begin
     ClrScr;
     Init(player);
     Stats(player);
     ClrScr;
End.