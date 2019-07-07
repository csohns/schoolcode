Unit scrsav;

Interface
Procedure SS;

Implementation
  uses crt;

Procedure SS;

  var cntr, x, y, direction, symbol :integer;

  begin
     clrscr;
     randomize;
     x := random(40) + 20;
     y := random(12) + 6;
     direction := random(9) + 1;
     while direction = 5 do
           direction := random(9) + 1;
     Repeat
          symbol := random(253) + 1;
     Until symbol <> 7;
     {textcolor(yellow);
     for cntr := 0 to 79 do begin
         gotoxy(cntr, 1);
         write('Û');
         gotoxy(cntr, 24);
         write('Û');
     end;
     for cntr := 1 to 24 do begin
         gotoxy(1, cntr);
         write('Û');
         gotoxy(79, cntr);
         write('Û');
     end;}
     repeat
     textcolor(random(15) + 1);
     if x = 2 then begin
                 Repeat
                      symbol := random(253) + 1;
                 Until symbol <> 7;
                        direction := random(9) + 1;
                        while (not (direction = 9)) and (not (direction = 6))
                              and (not (direction = 3)) do
                                  direction := random(9) + 1;
     end
     else if x = 78 then begin
                 Repeat
                      symbol := random(253) + 1;
                 Until symbol <> 7;
                        direction := random(9) + 1;
                        while (not (direction = 7)) and (not (direction = 4))
                              and (not (direction = 1)) do
                                  direction := random(9) + 1;
     end;
     if y = 2 then begin
                 Repeat
                      symbol := random(253) + 1;
                 Until symbol <> 7;
                        direction := random(9) + 1;
                        while (not (direction = 1)) and (not (direction = 2))
                              and (not (direction = 3)) do
                                  direction := random(9) + 1;
     end
     else if y = 23 then begin
                 Repeat
                      symbol := random(253) + 1;
                 Until symbol <> 7;
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
     TextColor(7);
  end;

Begin
End.
           