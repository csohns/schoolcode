                                                                 {Chris Sohns}
                                                                    {Monopoly}
                                                                      {9/7/95}
                     {This is a simple Monopoly program.}
                     {The object of the game is to reach}
                     {$1,500.  If you reach $0 you LOSE!}


Program Semi_Monopoly;

USES
  CRT;

TYPE
  location = (Start, Hospital, Casino, Hotel, ATMmachine, Mall, Work,
              Watertower, Restaurant);

VAR
  lcv, cntr, money, roll, incomm :Integer;
  place                          :location;
  name                           :String[25];

{/////////////////////////////P R O C E D U R E S////////////////////////}

Procedure Skip(lines: Integer);    (*Skips the specifyed number of lines*)
  VAR
    lcv :Integer;
  Begin
    For lcv := 1 to lines do
      WriteLn;
  End;

Procedure random_roll;  (*Pickes a random number and that is your roll*)
  Begin
    Randomize;
    skip(4);
    WriteLn('Press [ENTER] to roll the die. . .');
    ReadLn;
    roll := random(6) + 1;
  End;

Procedure Generick(space: String; dollars: Integer);    (*Takes care of most*)
  Begin                                                 (*of the squares*)
    ClrScr;
    WriteLn('Roll: ', roll);
    If dollars < 0
      then Begin
             WriteLn('Spend: ', ABS(dollars));
             inc(money, dollars);
           End
    else Begin
           WriteLn('Gain: ', dollars);
           inc(money, dollars);
         End;
    WriteLn;
    WriteLn('Cash on hand : $', money);
    skip(2);
    WriteLn('You are at: ', space);
  End;

Procedure Start_square;    (*Land on this square and you get $150*)
  Begin
    ClrScr;
    WriteLn('Roll: ', roll);
    WriteLn('Bonus: $150');
    inc(money, 150);
    WriteLn;
    WriteLn('Cash on hand: $', money);
    skip(2);
    WriteLn('You are at: Start');
  End;

Procedure Cash;    (*You gain $70, unless you commet froud inwhich*)
  VAR              (*you gain $200.*)
    fraud: Integer;
  Begin
    Randomize;
    ClrScr;
    fraud := random(400);
    WriteLn('Roll: ', roll);
    If ((28 < fraud) and (fraud < 248)) or (fraud = 400)
      then Begin
             WriteLn('Commit FRAUD!!');
             WriteLn('Gain: $200');
             inc(money, 200);
           End
    Else Begin
           WriteLn('Gain: $75');
           inc(money, 75);
         End;
    WriteLn;
    WriteLn('Cash on hand: $', money);
    skip(2);
    WriteLn('You are at: The ATMmachine');
  End;

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin
  cntr  := 1;
  money := 500;
  ClrScr;
  WriteLn('Semi-Monopoly!!');
  Delay(2000);
  ClrScr;
  WriteLn('You have $500');
  WriteLn;
  writeLn('You are on Start...');
  place := Start;
  Repeat
    random_roll;
    inc(cntr, roll);
    If cntr > 9 then
      Begin
        cntr := cntr - 9;
        place := Start;
        For lcv := 2 to cntr do
          place := succ(place);
        inc(money, 50);
      End
    else For lcv := 1 to roll do
           place := succ(place);
    Case place of
      Hospital   :name := 'The 1st National Hospital';
      Casino     :name := 'The You LOSE Casino';
      Hotel      :name := 'Holiday Inn';
      Mall       :name := 'Chapel Hills Mall';
      Work       :name := 'Microhard';
      Watertower :name := 'The WaterTower';
      Restaurant :name := 'Wendy''s';
    End;
    Case place of
      Work       :incomm := 75;
      Hospital,
      Casino,
      Hotel,
      Mall,
      Restaurant :incomm := -100;
      Watertower :incomm := 0;
    End;
    If place = ATMmachine then Cash
      else If place = Start then Start_square
             else Generick(name, incomm);
  Until (money >= 1500) or (money <= 0);
  If money <= 0 then WriteLn('LOSER!!!!!!!!')
    Else WriteLn('You are a WINNER!!');
  Delay(400);
End.