uses DOS, CRT, mouse;

var oldmx, oldmy: integer;

Begin
   M^.buttonstat := 0;
   if M^.buttonstat = 242 then
        Begin
             WriteLn('NetWare Initelizer');
             WriteLn('Version 1.0  by');
             WriteLn('Chris Sohns  of');
             WriteLn('Force Command');
        End;
   oldmx := -1;
   oldmy := -1;
   MOUinit;                         (* initialization *)
   if mouseinstalled = 0 then
      begin
        WriteLn('Please install your mouse driver before running this program.');
        ReadLn;
        halt;
      end;

   MOUhide;                                (* hide the mouse cursor *)
   ClrScr;
   MOUmove(40,20);                         (* move the mouse cursor to the center of the screen *)
   MOUconfine(10,0,70,20);                 (* confine the mouse cursor within these cooridinates *)
   MOUShow;                                (* display the mouse cursor *)
   GotoXY(30,11);
   TextColor(14);
   TextBackground(1);
   WriteLn('ษอออออออออออออออออออป');
   GotoXY(30,12);
   Write('บ  ');
   TextColor(12);
   Write(' Force Command ');
   TextColor(14);
   WriteLn('  บ');
   GotoXY(30,13);
   Write('บ  ');
   TextColor(10);
   Write('    Central    ');
   TextColor(14);
   WriteLn('  บ');
   GotoXY(30,14);
   WriteLn('ศอออออออออออออออออออผ');
   repeat
      if (mousex <> oldmx) OR (mousey <> oldmy) then  (* if position has changed... *)
         begin
            oldmx := mousex;               (* mousex and mousey are the mouse cursor X and Y *)
            oldmy := mousey;               (* corrdinates updated continuously by the driver *)
            MOUconditionalhide(0,0,50,0);  (* hide the cursor if it happens to be on the top line *)
            {GoToXY(1,1);
            write('Mouse position: ', mousex:2, '  ', mousey:2);}
            MOUshow;                       (* display the mouse cursor *)
          end;

      if MOUcheck then                     (* if a mouse event is waiting in buffer... *)
         begin
            MOUget(M);                     (* 'M' is the pointer to the mouse information *)
            MOUconditionalhide(0,3,32,5);  (* record.  Both 'M' and the record are declared *)
            {case M^.buttonstat of          (* in the MOUSE.TPU unit.  Field 'buttonstat' of *)
               LEFTBPRESS:                 (* the record contains the status of the mouse buttons *)
                  begin                    (* Fields 'cx' and 'cy' are the mouse cursor coordinates *)
                     GoToXY(1,4);          (* when the event occured *)
                     write('Left button pressed  at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               RIGHTBPRESS:
                  begin
                     GoToXY(1,6);
                     write('Right button pressed  at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               LEFTBRELEASE:
                  begin
                     GoToXY(1,4);
                     write('Left button released at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               RIGHTBRELEASE:
                  begin
                     GoToXY(1,6);
                     write('Right button released at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
            end;} {case}
            MOUshow;
         end; {if}

   until (M^.buttonstat = LEFTBPRESS) AND (M^.cy = 13) AND (M^.cx = 49);
   Repeat
            MOUget(M);                     (* 'M' is the pointer to the mouse information *)
            MOUconditionalhide(0,3,32,5);  (* record.  Both 'M' and the record are declared *)
            {case M^.buttonstat of          (* in the MOUSE.TPU unit.  Field 'buttonstat' of *)
               LEFTBPRESS:                 (* the record contains the status of the mouse buttons *)
                  begin                    (* Fields 'cx' and 'cy' are the mouse cursor coordinates *)
                     GoToXY(1,4);          (* when the event occured *)
                     write('Left button pressed  at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               RIGHTBPRESS:
                  begin
                     GoToXY(1,6);
                     write('Right button pressed  at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               LEFTBRELEASE:
                  begin
                     GoToXY(1,4);
                     write('Left button released at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
               RIGHTBRELEASE:
                  begin
                     GoToXY(1,6);
                     write('Right button released at: ', M^.cx:2, ' ', M^.cy:2);
                  end;
            end;} {case}
            MOUshow;
   until M^.buttonstat = LEFTBRELEASE;
   {Delay(2000);}
   MOUdeinit;                        (* de-activate the routines *)
End.