Program Semi_Monopoly_with_mouse;

USES
  DOS, CRT, MOUSE;

TYPE
  location = (Start, Hospital, Casino, Hotel, ATMmachine, Mall, Work,
              Watertower, Restaurant);

VAR
  lcv, cntr, money, roll, incomm, oldmx, oldmy :Integer;
  place                          :location;
  name                           :String[25];

{//}

Procedure Skip(lines: Integer);
  VAR
    lcv :Integer;
  Begin
    For lcv := 1 to lines do
      WriteLn;
  End;

Procedure random_roll;
  Begin
    Randomize;
    skip(4);
    WriteLn;
    WriteLn;
    TextColor(15);
    Write('                €€€€');
    TextColor(10);
    TextBackground(7);
    Write('O');
    TextBackground(0);
    TextColor(15);
    Write('€');
    TextColor(14);
    TextBackground(7);
    Write('K');
    TextBackground(0);
    TextColor(15);
    Write('€€€€');
    TextColor(8);
    WriteLn('‹');
    WriteLn('                 ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ');
    TextColor(7);

    repeat
       if (mousex <> oldmx) OR (mousey <> oldmy) then  (* if position has changed... *)
          begin
             oldmx := mousex;               (* mousex and mousey are the mouse cursor X and Y *)
             oldmy := mousey;               (* corrdinates updated continuously by the driver *)
             MOUconditionalhide(0,0,50,0);  (* hide the cursor if it happens to be on the top line *)
             GoToXY(1,1);
             write('Mouse position: ', mousex:2, '  ', mousey:2);
             MOUshow;                       (* display the mouse cursor *)
           end;

       if MOUcheck then                     (* if a mouse event is waiting in buffer... *)
          begin
             MOUget(M);                     (* 'M' is the pointer to the mouse information *)
             MOUconditionalhide(0,3,32,5);  (* record.  Both 'M' and the record are declared *)
             case M^.buttonstat of          (* in the MOUSE.TPU unit.  Field 'buttonstat' of *)
                LEFTBPRESS:                 (* the record contains the status of the mouse buttons *)
                   begin                    (* Fields 'cx' and 'cy' are the mouse cursor coordinates *)
                      GoToXY(1,4);          (* when the event occured *)
                      {write('Left button pressed  at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
                RIGHTBPRESS:
                   begin
                      GoToXY(1,6);
                      {write('Right button pressed  at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
                LEFTBRELEASE:
                   begin
                      GoToXY(1,4);
                      {write('Left button released at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
                RIGHTBRELEASE:
                   begin
                      GoToXY(1,6);
                      {write('Right button released at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
             end; {case}
             MOUshow;
          end; {if}

    until (M^.buttonstat = LEFTBPRESS) AND (M^.cy = 9) AND (M^.cx IN [16..26]);
    GoToXY(1,10);
    TextColor(15);
    Write('                 €€€€');
    TextColor(10);
    TextBackground(7);
    Write('O');
    TextBackground(0);
    TextColor(15);
    Write('€');
    TextColor(14);
    TextBackground(7);
    Write('K');
    TextBackground(0);
    TextColor(15);
    WriteLn('€€€€');
    WriteLn('                            ');
    TextColor(7);
    Repeat
             MOUget(M);                     (* 'M' is the pointer to the mouse information *)
             MOUconditionalhide(0,3,32,5);  (* record.  Both 'M' and the record are declared *)
              case M^.buttonstat of          (* in the MOUSE.TPU unit.  Field 'buttonstat' of *)
                LEFTBPRESS:                 (* the record contains the status of the mouse buttons *)
                   begin                    (* Fields 'cx' and 'cy' are the mouse cursor coordinates *)
                      GoToXY(1,4);          (* when the event occured *)
                      {write('Left button pressed  at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
                RIGHTBPRESS:
                   begin
                      GoToXY(1,6);
                      {write('Right button pressed  at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
                LEFTBRELEASE:
                   begin
                      GoToXY(1,4);
                      {write('Left button released at: ', M^.cx:2, ' ', M^.cy:2);}
                    end;
                RIGHTBRELEASE:
                   begin
                      GoToXY(1,6);
                      {write('Right button released at: ', M^.cx:2, ' ', M^.cy:2);}
                   end;
             end; {case}
             MOUshow;
    until M^.buttonstat = LEFTBRELEASE;
    GoToXY(1,10);
    TextColor(15);
    Write('                €€€€');
    TextColor(10);
    TextBackground(7);
    Write('O');
    TextBackground(0);
    TextColor(15);
    Write('€');
    TextBackground(7);
    TextColor(14);
    Write('K');
    TextBackground(0);
    TextColor(15);
    Write('€€€€');
    TextColor(8);
    WriteLn('‹');
    WriteLn('                 ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ');
    TextColor(7);
    {Delay(2000);}
    WriteLn('Press [ENTER] to roll the die. . .');
    ReadLn;
    WriteLn('I am here');
    roll := random(6) + 1;
    WriteLn('Past the roll');
    {MOUdeinit;}                        (* de-activate the routines *)
    WriteLn('Past the De-Init');
  End;

Procedure Generick(space: String; dollars: Integer);
  Begin
    ClrScr;
    WriteLn('In the Generick procedure!!');
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

Procedure Start_square;
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

Procedure Cash;
  VAR
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

{//}

Begin
   M^.buttonstat := 0;
   oldmx := -1;
   oldmy := -1;
   MOUinit;                         (* initialization *)
   if mouseinstalled = 0 then
      begin
        WriteLn('Please install your mouse driver before running this test.');
        halt;
      end;

   MOUhide;                                (* hide the mouse cursor *)
   ClrScr;
   MOUmove(40,13);                         (* move the mouse cursor to the center of the screen *)
   MOUconfine(10,0,70,20);                 (* confine the mouse cursor within these cooridinates *)
   MOUShow;                                (* display the mouse cursor *)
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
    WriteLn('Out of random_roll');
    halt;
    inc(cntr, roll);
    WriteLn('here');
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
    writeLn('cool');
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
    WriteLn('yse!!');
    If place = ATMmachine then Cash
      else If place = Start then Start_square
             else Generick(name, incomm);
  Until (money >= 1500) or (money <= 0);
  If money <= 0 then WriteLn('LOSER!!!!!!!!')
    Else WriteLn('You are a WINNER!!');
   Delay(4000);
   MOUdeinit;                        (* de-activate the routines *)
End.