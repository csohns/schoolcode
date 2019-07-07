Uses
   CRT;
Type
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
 generalfile: file of general_info;
 g: general_info;
 num: Integer;
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
Procedure StockStuff;
  Var
    lcv, lcv2: Integer;
  Begin
    Seek(generalfile, 0);
    Read(generalfile, g);
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
Procedure Menu(num:Integer);
  Var
    sel: Char;
    lcv: Integer;
  Begin
    seek(generalfile,0);
    Read(generalfile,g);
    Repeat
      c(7,1,0);
      ClrScr;
      WriteLn('(N)ame :  ', g.stocks[num].name);
      WriteLn('(P)rice: ', g.stocks[num].price);
      WriteLn('(T)rend: ', g.stocks[num].trend);
      WriteLn('(A)vail: ', g.stocks[num].avail);
      For lcv := 1 to 4 do
        WriteLn('Day (', lcv, '): ', g.stocks[num].prices[lcv]);
      WriteLn('(V)alue: ', g.stocks[num].value);
      WriteLn('(L)astvalue: ', g.stocks[num].lastvalue);
      WriteLn;
      WriteLn;
      Write('Enter in selection [or ''Q'' to Quit]:  ');
      Repeat
        Repeat
          sel := ReadKey;
        Until sel <> '';
        WriteLn(sel);
        sel := UpCase(sel);
        Write('Enter in a NEW value for selection ''', sel, ''':  ');
        Case sel of
          'N': ReadLn(g.stocks[num].name);
          'P': ReadLn(g.stocks[num].price);
          'T': ReadLn(g.stocks[num].trend);
          'A': ReadLn(g.stocks[num].avail);
          '1': ReadLn(g.stocks[num].prices[1]);
          '2': ReadLn(g.stocks[num].prices[2]);
          '3': ReadLn(g.stocks[num].prices[3]);
          '4': ReadLn(g.stocks[num].prices[4]);
          'V': ReadLn(g.stocks[num].value);
          'L': ReadLn(g.stocks[num].lastvalue);
        End;
      Until (sel = 'N') or (sel = 'P') or (sel = 'T') or (sel = 'A') or
            (sel = '1') or (sel = '2') or (sel = '3') or (sel = '4') or
            (sel = 'V') or (sel = 'L') or (sel = 'Q');
    Until sel = 'Q';
    seek(generalfile,0);
    Write(generalfile,g);
  End;
{//////////////////}
Begin
   ClrScr;
   Assign(generalfile, 'e:\tp\bin\ga\GENERAL.GW');
   ReSet(generalfile);
   Repeat
        Begin
             ClrScr;
             c(7,1,0);
             Write('Enter in record number [or 9999 to Quit]: ');
             ReadLn(num);
             If (num <> 9999) and (num >= 1) and (num < 56) then
               Begin
                 menu(num);
                 WriteLn;
                 c(7,1,0);
               End;
        End;
   Until num = 9999;
   Close(generalfile);
   c(7,1,0);
   ClrScr;
End.