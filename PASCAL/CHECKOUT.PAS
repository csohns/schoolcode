Program Check_Out;

Uses
     Crt;

Const
     MinChkOutTime = 1;
     MaxChkOutTime = 10;
     CustOfAvg = 75;
     AvgChkOutTime = 5;
     MaxWaitTime = 8;
     NewCust = 2;
     BuyItems = 85;
     MinShopTime = 1;
     MaxShopTime = 90;
     ShopTimeOfAvg = 75;
     AvgShopTime = 20;
     Registers = 15;
     RunTime = 4;
     min = 1;
     max = 80;

Type
     CheckOutTime = record
                       ChkOutTime: Integer;
                       ChkOutTimeTotal: Integer;
                  End;
     ShopPerson = record
                       ShopTime: Integer;
                       ShopTimeTotal: Integer;
                       Buy: Boolean;
                  End;
     Person = record
                   WaitTime: Integer;
                   WaitTimeTotal: Integer;
                   RegisterNumber: ShortInt;
              End;
     Q_Type = record
                   front,
                   rear: Integer;
                   open: Boolean;
                   List: Array[min..max] of Person;
              End;
     {Q_Type2 = record
                    front2,
                    rear2: Integer;
                    List2: Array[min..max] of ShopPerson;
               End;}
     SP = Array[1..max] of ShopPerson;
     QT = Array[1..Registers] of Q_Type;
     COT = Array[1..Registers] of CheckOutTime;
Var
     Population: SP;
     Reg: QT;
     sel: Char;
     time: LongInt;
     PeopleNumbers,
     BuyAvg,
     ShopAvg,
     WaitAvg,
     lcv: Integer;
     ChkOut: COT;

Procedure OpenLane(var Reg:QT); forward;

{////////////////////////////////////////////////////////////////////////}
Procedure ClearQ(var Q:Q_Type);
     Begin
          Q.front := 0;
          Q.rear := 0;
     End;
{////////////////////////////////////////////////////////////////////////}
Function EmptyQ(var Reg:QT; lcv:Integer):Boolean;
     Begin
          EmptyQ := Reg[lcv].front = 0;
     End;
{////////////////////////////////////////////////////////////////////////}
Function Next(I:Integer):Integer;
     Begin
          If I = max then next := min
               Else next := Succ(I);
     End;
{////////////////////////////////////////////////////////////////////////}
Function Last(I:Integer):Integer;
     Begin
          If I = min then last := max
               Else last := Pred(I);
     End;
{////////////////////////////////////////////////////////////////////////}
Function FullQ(var Reg:QT; lcv: Integer):Boolean;
     Begin
           FullQ := (next(Reg[lcv].rear) = Reg[lcv].front);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure EnQ(var Reg:QT; lcv:Integer);
     Begin
          If NOT FullQ(Reg, lcv) then
               Begin
                    Reg[lcv].List[next(Reg[lcv].rear)].WaitTime := 1;
                    Reg[lcv].List[next(Reg[lcv].rear)].WaitTimeTotal := 0;
                    Reg[lcv].rear := next(Reg[lcv].rear);
                    If Reg[lcv].front = 0 then Reg[lcv].front := 1;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure DeQ(var Reg:QT; lcv:Integer; var WTime:Integer);
     Begin
          If NOT EmptyQ(Reg, lcv) then
               Begin
               If Reg[lcv].front = Reg[lcv].rear then Reg[lcv].front := 0
                    Else Begin
                              inc(WTime, Reg[lcv].List[Reg[lcv].front].WaitTimeTotal);
                              Reg[lcv].front := next(Reg[lcv].front);
                         End;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure Init(var Population:SP; var Reg:QT; var ChkOut:COT);
     Var
          lcv, lcv2: Integer;
     Begin
          For lcv := min to max do
               With Population[lcv] do
                    Begin
                         ShopTime := 0;
                         ShopTimeTotal := 0;
                         Buy := FALSE;
                    End;
          For lcv := 1 to Registers do
               Begin
                    With Reg[lcv] do
                         Begin
                              front := 0;
                              rear := 0;
                              If lcv = 1 then open := TRUE
                                   Else open := FALSE;
                              For lcv2 := min to max do
                                   Begin
                                        List[lcv2].WaitTime := 0;
                                        List[lcv2].WaitTimeTotal := 0;
                                   End;
                         End;
               End;
          For lcv := 1 to Registers do
               Begin
                    ChkOut[lcv].ChkOutTime := 1;
                    ChkOut[lcv].ChkOutTimeTotal := 0;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure AddPerson(var Population:SP;Var PropleNumbers:Integer);
     Var
          num, loc: Integer;
{////////////////////////////////////////////////////////////////}
  Function Empty(var Population:SP): Integer;
       Var
            OK: Boolean;
            lcv: Integer;
       Begin
            OK := FALSE;
            lcv := 0;
            Repeat
                 inc(lcv, 1);
                 If Population[lcv].ShopTime = 0 then OK := TRUE;
            Until (OK) or (lcv = max);
            If lcv = max then
                 Begin
                      ClrScr;
                      WriteLn('Too many people to handle. . .');
                      Halt;
                 End;
            Empty := lcv;
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          loc := Empty(Population);
          num := Random(100) + 1;
          If num < ShopTimeOfAvg + 1 then Population[loc].ShopTime := Random(20) + 1
               Else Population[loc].ShopTime := Random(70) + 20;
          Population[loc].ShopTimeTotal := 0;
          num := Random(100) + 1;
          If num < BuyItems + 1 then Population[loc].Buy := TRUE
               Else Population[loc].Buy:= FALSE;
          inc(PeopleNumbers, 1);
          If Population[loc].Buy = TRUE then inc(BuyAvg, 1);
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure incr(var Population:SP);
     Var
          lcv: Integer;
     Begin
          For lcv := min to max do
               Begin
                    If Population[lcv].ShopTime <> 0 then
                         inc(Population[lcv].ShopTimeTotal, 1);
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure incr2(var Reg:QT);
     Var
          lcv, lcv2: Integer;
     Begin
          For lcv := 1 to Registers do
               For lcv2 := min to max do
                    Begin
                         If Reg[lcv].List[lcv2].WaitTime <> 0 then
                              Begin
                                   inc(Reg[lcv].List[lcv2].WaitTimeTotal, 1);
                              End;
                    End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure ChkPop(Var Population:SP; Var Reg:QT;var ShopAvg:Integer);
     Var
          lcv, lcv2: Integer;
{////////////////////////////////////////////////////////////////}
  Procedure Shop2Reg(var Population:SP; var lcv:Integer; var Reg:QT; var ShopAvg:Integer);
       Var
            lcv2,
            num: Integer;
            Len: Array[1..Registers] of Integer;
{////////////////////////////////////////////////////////}
    Procedure Shortest(var num1, num2:Integer);
         Begin
              If num1 < num2 then num2 := num1;
                   {Else If num2 < num1 then Shortest := num2;}
         End;
{////////////////////////////////////////////////////////}
    Function FindLine(var Reg:QT; num:Integer): Integer;
         Var
           lcv: Integer;
         Begin
           For lcv := 1 to Registers do
             Begin
               If Reg[lcv].open then
                    If Len[lcv] = num then FindLine := lcv;
                 {If Reg[lcv].front >= Reg[lcv].rear then
                   If Reg[lcv].front - Reg[lcv].rear = num then FindLine := lcv
                   Else If Reg[lcv].rear > Reg[lcv].front then
                          If Reg[lcv].rear - Reg[lcv].front = num then FindLine := lcv;}
             End;
         End;
{////////////////////////////////////////////////////////}
       Begin
         If time MOD 1 = 0 then
           If WaitAvg/BuyAvg > MaxWaitTime then OpenLane(Reg);
         num := 888;
         For lcv2 := 1 to Registers do
           Len[lcv2] := 888;
         For lcv2 := 1 to Registers do
           If Reg[lcv2].open then
             If Reg[lcv2].front = Reg[lcv2].rear then
               Len[lcv2] := 0
             Else If Reg[lcv2].front > Reg[lcv2].rear then
                    Len[lcv2] := (max - Reg[lcv2].front) + Reg[lcv2].rear
                  Else If Reg[lcv2].rear > Reg[lcv2].front then
                         Len[lcv2] := Reg[lcv2].rear - Reg[lcv2].front;
         {For lcv2 := 1 to Registers do
           Write(Len[lcv2], '  ');
         WriteLn;}
         For lcv2 := 1 to Registers do
           If Reg[lcv2].open then
             Shortest(Len[lcv2], num);
         {WriteLn(num);
         WriteLn(FindLine(Reg, num));}
         inc(ShopAvg, Population[lcv].ShopTime);
         Population[lcv].ShopTime := 0;
         EnQ(Reg, FindLine(Reg, num));
         {EnQ(Reg, 1);}
       End;
{////////////////////////////////////////////////////////////////}
     Begin
          For lcv := 1 to max do
               Begin
                    If Population[lcv].ShopTime = Population[lcv].ShopTimeTotal
                         then Begin
                                   If Population[lcv].Buy = TRUE then
                                        Shop2Reg(Population, lcv, Reg, ShopAvg)
                                   Else Population[lcv].ShopTime := 0;
                              End;
               End;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure CheckOut(var Reg:QT; var lcv, WaitAvg:Integer; var ChkOut:COT);
     Var
          num: Integer;
     Begin
          DeQ(Reg, lcv, WaitAvg);
          If Reg[lcv].front - Reg[lcv].rear = 0 then
               If lcv <> 1 then
                    Begin
                         {WriteLn('close!!    ', lcv);}
                         Reg[lcv].open := FALSE;
                    End;
          num := Random(100) + MinChkOutTime;
          If num < CustOfAvg + 1 then ChkOut[lcv].ChkOutTime := Random(AvgChkOutTime) + MinChkOutTime
               Else ChkOut[lcv].ChkOutTime := Random(MaxChkOutTime) + MinChkOutTime;
          ChkOut[lcv].ChkOutTimeTotal := 0;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure PrintResults(PeopleNumbers, ShopAvg, BuyAvg, WaitAvg:Integer);
     Var
          lcv: Integer;
     Begin
          Clrscr;
          WriteLn(PeopleNumbers, ' people came into the store');
          WriteLn((ShopAvg / PeopleNumbers):0:2, ' average shopping time');
          WriteLn(BuyAvg, ' people purchesed items');
          WriteLn((WaitAvg / BuyAvg):0:2, ' average waiting time in the register line');
          WriteLn;
          WriteLn;
          {For lcv := 1 to Registers do
               Begin
                    Write(lcv, '  ');
                    If Reg[lcv].open then WriteLn('open');
                    If NOT Reg[lcv].open then WriteLn('closed');
               End;}
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////////////}
Procedure OpenLane(var Reg:QT);
     Var
          lcv: Integer;
          found: Boolean;
     Begin
          lcv := 0;
          found := FALSE;
          Repeat
               inc(lcv, 1);
               If NOT Reg[lcv].open then found := TRUE;
          Until (found) or (lcv = Registers);
          If found then
               Begin
                    {WriteLn('Have an open!!    ', lcv);
                    delay(200);}
                    Reg[lcv].open := TRUE;
               end;
     End;
{////////////////////////////////////////////////////////////////////////}
Begin
     Randomize;
     TextColor(7);
     ClrScr;
     time := 0;
     PeopleNumbers := 0;
     BuyAvg := 0;
     ShopAvg := 0;
     WaitAvg := 0;
     Init(Population, Reg, ChkOut);
     Reg[1].open := TRUE;
     Repeat
          inc(time, 1);
          For lcv := 1 to Registers do
               If Reg[lcv].open then
                    inc(ChkOut[lcv].ChkOutTimeTotal, 1);
          incr(Population);
          incr2(Reg);
          If time MOD NewCust = 0 then AddPerson(Population, PeopleNumbers);
          ChkPop(Population, Reg, ShopAvg);
          For lcv := 1 to Registers do
               If Reg[lcv].open then
                    If ChkOut[lcv].ChkOutTime = ChkOut[lcv].ChkOutTimeTotal then CheckOut(Reg, lcv, WaitAvg, ChkOut);
     Until RunTime * 60 = time;
     PrintResults(PeopleNumbers, ShopAvg, BuyAvg, WaitAvg);
End.