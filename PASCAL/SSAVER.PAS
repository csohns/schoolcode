{.}
                                {Dan Sullivan}
                               {Period 4 Pascal}
                                {Screen Saver}
                                   {Row 1}

program screen_saver;

uses crt;

var cntr, x, y, direction, symbol :integer;

begin
     clrscr;
     randomize;
     x := random(40) + 20;
     y := random(12) + 6;
     direction := random(9) + 1;
     while direction = 5 do
           direction := random(9) + 1;
     symbol := random(253) + 1;
     textcolor(yellow);
     for cntr := 0 to 79 do begin
         gotoxy(cntr, 1);
         write('�');
         gotoxy(cntr, 24);
         write('�');
     end;
     for cntr := 1 to 24 do begin
         gotoxy(1, cntr);
         write('�');
         gotoxy(79, cntr);
         write('�');
     end;
     repeat
     textcolor(white);
     if x = 2 then begin
                  symbol := random(253) + 1;
                        direction := random(9) + 1;
                        while (not (direction = 9)) and (not (direction = 6))
                              and (not (direction = 3)) do
                                  direction := random(9) + 1;
     end
     else if x = 78 then begin
                  symbol := random(253) + 1;
                        direction := random(9) + 1;
                        while (not (direction = 7)) and (not (direction = 4))
                              and (not (direction = 1)) do
                                  direction := random(9) + 1;
     end;
     if y = 2 then begin
                  symbol := random(253) + 1;
                        direction := random(9) + 1;
                        while (not (direction = 1)) and (not (direction = 2))
                              and (not (direction = 3)) do
                                  direction := random(9) + 1;
     end
     else if y = 23 then begin
                  symbol := random(253) + 1;
                        direction := random(9) + 1;
                        while (not (direction = 7)) and (not (direction = 8))
                              and (not (direction = 9)) do
                                  direction := random(9) + 1;
     end;
           case direction of
                1, 2, 3 : y := y + 1;
           end;
           case direction of
                7, 8, 9 : y := y - 1;
           end;
           case direction of
                1, 4, 7 : x := x - 1;
           end;
           case direction of
                3, 6, 9 : x := x + 1;
           end;

           gotoxy(x, y);
           write(chr(symbol));
           delay(50);
           gotoxy(x, y);
           write(' ');
     until keypressed;
end.

           