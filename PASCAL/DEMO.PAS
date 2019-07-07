(* This program demonstrates Dave Kirsch's 'true' EGA/VGA mouse routines. *)
program Demo;

uses DOS, CRT, mouse;

var oldmx, oldmy: integer;

begin
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
   GoToXY(1,8);
   WriteLn('Turbo Pascal demo of Dave Kirsch''s ''true'' EGA/VGA');
   WriteLn('C mouse cursor functions.  Pascal demo by Jim Loos.');
   WriteLn;
   WriteLn('Click here [þ] with left mouse button to quit.');

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
            end; {case}
            MOUshow;
         end; {if}

   until (M^.buttonstat = LEFTBPRESS) AND (M^.cy = 10) AND (M^.cx IN [11..13]);
   MOUdeinit;                        (* de-activate the routines *)

end.

