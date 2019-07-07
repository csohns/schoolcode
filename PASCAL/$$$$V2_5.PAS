{.}
                                                                 {Chris Sohns}
                                                                    {Monopoly}
                                                                      {9/7/95}
                     {This is a simple Monopoly program.}
                     {The object of the game is to reach}
                     {1,500.  If you reach 0 you LOSE!}


Program Semi_Monopoly;

USES
  CRT;

{/////////////////////////////P R O C E D U R E S////////////////////////}



Procedure Play;  {MASTER PROCEDURE}
  TYPE
    location = (Start, Hospital, Casino, Hotel, ATMmachine, Mall, Work,
                Watertower, Restaurant);
  Var
    lcv, cntr, money, roll, incomm :Integer;
    place                          :location;
    name                           :String[25];

{////////////////////////////////////////////////////////////////////////}
  Procedure Intro;  {Introduction}
    Procedure InitVars;  {Initalizes variables}
      Begin
        cntr  := 1;
        money := 500;
        place := Start;
      End;
    Begin
      InitVars;
      ClrScr;
      WriteLn('Semi-Monopoly!!');
      Delay(2000);
      ClrScr;
      WriteLn('You have $500');
      WriteLn;
      writeLn('You are on Start...');
    End;

{////////////////////////////////////////////////////////////////////////}
  Procedure Skip(lines: Integer);    (*Skips the specifyed number of lines*)
    VAR
      lcv :Integer;
    Begin
      For lcv := 1 to lines do
        WriteLn;
    End;

{////////////////////////////////////////////////////////////////////////}
  Procedure random_roll;  (*Pickes a random number and that is your roll*)
    Begin
      Randomize;
      skip(4);
      WriteLn('Press [ENTER] to roll the die. . .');
      ReadLn;
      roll := random(6) + 1;
    End;

{////////////////////////////////////////////////////////////////////////}
  Procedure Start_square(var money: Integer);
    Begin                         (*Land on this square and you get $150*)
      ClrScr;
      WriteLn('Roll: ', roll);
      WriteLn('Bonus: $150');
      inc(money, 150);
      WriteLn;
      WriteLn('Cash on hand: $', money);
      skip(2);
      WriteLn('You are at: Start');
    End;

{////////////////////////////////////////////////////////////////////////}
  Procedure Cash(var money: Integer);  (*You gain $70, unless you commit*)
    VAR                                (*fraud in which you gain $200.*)
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

{////////////////////////////////////////////////////////////////////////}
  Procedure Generick(space: String;var money, dollars: Integer);
    Begin                                             (*Takes care of most*)
      ClrScr;                                         (*of the squares*)
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

  {////////M A I N//M O D U L E//O F//P R O C E D U R E////////}

  Begin
    Intro;
    Repeat
      random_roll;
      If (ORD(place) + roll) > 8 then
        Begin
          cntr := (ORD(place) + roll) - 8;
          place := Start;
          For lcv := 2 to cntr do
            place := succ(place);
          inc(money, 50);
        End
      Else For lcv := 1 to roll do
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
      If place = ATMmachine then Cash(money)
        else If place = Start then Start_square(money)
               else Generick(name, incomm, money);
    Until (money >= 1500) or (money <= 0);
    If money <= 0 then WriteLn('LOSER!!!!!!!!')
      Else WriteLn('You are a WINNER!!');
    Delay(4000);
  End;

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin
  Play;
End.