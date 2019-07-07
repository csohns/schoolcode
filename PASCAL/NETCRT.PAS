(* Josh Snyder                                 *)
(* silk @ kktv.com                             *)
(* "Common sense is not so common." - Voltaire *)


unit netcrt;
   { This unit is built to do I/O using direct access to video memory. }
   { It was built for nettalk.                                         }

(***************************************************************************)

interface

(***************************************************************************)

const
  backspace = #8;
   { Ascii code for backspace key. }
  enter = #13;
   { Ascii code for enter key. }
  beep = #7;
   { Ascii code for "beep" key. }

(***************************************************************************)

type
  position_on_screen = record
                         y : byte;
                         x : byte;
                       end;
   { Built to hold a position onscreen. }
  single_char_on_screen = record
                            letter : char;
                            attr   : byte;
                          end;
   { The information coded into a single character onscreen. }
  screen = array[0..24,0..79] of single_char_on_screen;
   { The setup of the screen in virtual memory. }

(***************************************************************************)

var
  vcrt : screen absolute $B800:0000;
   { The "virtual" cathode ray tube. Accessing this directly affects }
   { what is on the screen.                                          }
  vcursor : position_on_screen;
   { The "virtual" cursor. Whenever any procedure in this unit   }
   { is called, the cursor is updated on screen, but not before. }

(***************************************************************************)

function readkey : char;
function keypressed : boolean;
(*procedure update_cursor;
   { Purpose: Copy the virtual cursor to the real cursor.                }
   { Method : Call gotoxy in the crt unit provided with pascal.          }
   { Notes  : Gets called any time any procedure in this unit is called. }
*)
procedure scroll;
   { Purpose: Scroll the screen upward.                    }
   { Method : Copies each line upward, one char at a time. }
   { Notes  : Upmost line is lost. Blank line at bottom.   }

procedure write_char(letter : char);
   { Purpose: Write a char to the screen with full special case checking.  }
   { Method : If enter, then go to next line.                              }
   {          If backspace, back up cursor, unless at upleft corner,       }
   {            then stay where is.                                        }
   {          If beep, then beep, and put in char and move cursor forward. }
   {          Otherwise, put in char and move cursor forward.              }
   { Notes  : Used in nearly every other procedure in this unit.           }

procedure write_string(txt : string);
procedure writeln_string(txt : string);
procedure read_string(var txt : string);
procedure read_new_string(var txt : string);
procedure read_string_minmax(var txt : string; min,max : byte);
procedure read_new_string_minmax(var txt : string; min,max : byte);
procedure clear_screen;
procedure read_cursor;

implementation
uses crt;

function readkey : char; assembler;
asm
  mov ah,7h { Service 8 }
  int 21h   { Interrupt 21h }
  cmp al,0
  jne @@1
  mov ah,7h
  int 21h
  add al,128
@@1:
end;

function keypressed : boolean; assembler;
asm
  mov ah,0Bh
  int 21h
  and al,1
end;

procedure update_cursor; assembler;
asm
  mov ah,02h
  xor bh,bh
  mov dh,vcursor.y
  mov dl,vcursor.x
  int 10h
end;

procedure scroll;
var
  i,j : byte;
begin
  for i := 0 to 23 do
    for j := 0 to 79 do
      vcrt[i,j] := vcrt[i + 1,j];
  for i := 0 to 79 do vcrt[24,i].letter := #0;
  update_cursor;
end;

procedure write_char(letter : char);
begin
  case letter of
    enter : if vcursor.y = 24 then
            begin
              scroll;
              vcursor.x := 0;
            end else
            begin
              vcursor.x := 0;
              inc(vcursor.y);
            end;
    backspace : begin
                  if vcursor.x = 0 then
                  begin
                    if vcursor.y <> 0 then
                    begin
                      dec(vcursor.y);
                      vcursor.x := 79;
                    end;
                  end else dec(vcursor.x);
                  vcrt[vcursor.y,vcursor.x].letter := #0;
                end;
    beep : begin
             sound(333);
             delay(70);
             sound(666);
             delay(70);
             sound(1332);
             delay(70);
             nosound;
             vcrt[vcursor.y,vcursor.x].letter := letter;
             if vcursor.x <> 79 then
               inc(vcursor.x)
             else
             begin
               vcursor.x := 0;
               if vcursor.y <> 24 then inc(vcursor.y) else scroll;
             end;
           end;
  else
    vcrt[vcursor.y,vcursor.x].letter := letter;
    if vcursor.x <> 79 then
      inc(vcursor.x)
    else
    begin
      vcursor.x := 0;
      if vcursor.y <> 24 then inc(vcursor.y) else scroll;
    end;
  end;
  update_cursor;
end;

procedure write_string(txt : string);
var
  i : byte;
begin
  for i := 1 to ord(txt[0]) do write_char(txt[i]);
  update_cursor;
end;

procedure writeln_string(txt : string);
var
  i : byte;
begin
  for i := 1 to ord(txt[0]) do write_char(txt[i]);
  write_char(enter);
  update_cursor;
end;

procedure read_string(var txt : string);
var
  key : char;
begin
  write_string(txt);
  repeat
    key := readkey;
    if keypressed then key := chr( ord(readkey) + 128);
    if (key <> enter) and (txt[0] = #255) and (key <> backspace) then
    begin
      sound(666);
      delay(200);
      nosound;
    end else
    begin
      case key of
        backspace : if txt[0] <> #0 then
                    begin
                      write_char(backspace);
                      txt[0] := pred(txt[0]);
                    end;
        enter : write_char(enter);
        beep : begin
                 write_char(#0);
                 txt[0] := succ(txt[0]);
                 txt[ ord(txt[0]) ] := key;
               end;
      else
        write_char(key);
        txt[0] := succ(txt[0]);
        txt[ ord(txt[0]) ] := key;
      end;
    end;
  until key = enter;
  update_cursor;
end;

procedure read_new_string(var txt : string);
begin
  txt[0] := #0;
  read_string(txt);
  update_cursor;
end;

procedure read_string_minmax(var txt : string; min,max : byte);
var
  key : char;
begin
  write_string(txt);
  repeat
    key := readkey;
    if keypressed then key := chr( ord(readkey) + 128);
    if (key <> enter) and (txt[0] = chr(max)) and (key <> backspace) then
    begin
      sound(666);
      delay(200);
      nosound;
    end else
    begin
      if (key = enter) and (txt[0] < chr(min)) then
      begin
        sound(666);
        delay(200);
        nosound;
      end else
      begin
        case key of
          backspace : if txt[0] <> #0 then
                      begin
                        write_char(backspace);
                        txt[0] := pred(txt[0]);
                      end;
          enter : write_char(enter);
          beep : begin
                   write_char(#0);
                   txt[0] := succ(txt[0]);
                   txt[ ord(txt[0]) ] := key;
                 end;
        else
          write_char(key);
          txt[0] := succ(txt[0]);
          txt[ ord(txt[0]) ] := key;
        end;
      end;
    end;
  until (key = enter) and (txt[0] >= chr(min));
  update_cursor;
end;

procedure read_new_string_minmax(var txt : string; min,max : byte);
begin
  txt[0] := #0;
  read_string_minmax(txt,min,max);
  update_cursor;
end;

procedure clear_screen;
var
  i,j : byte;
begin
  for i := 0 to 24 do
    for j := 0 to 79 do
    begin
      vcrt[i,j].letter := #0;
      vcrt[i,j].attr := 15;
    end;
  vcursor.x := 0;
  vcursor.y := 0;
  update_cursor;
end;

procedure read_cursor;
begin
  vcursor.x := wherex - 1;
  vcursor.y := wherey - 1;
end;

end.