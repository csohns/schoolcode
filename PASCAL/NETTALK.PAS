{$M 65520,0,0}
(* Author: Josh Snyder *)

program talk_over_network_using_files_only;
uses netcrt,dos;

procedure erase_file(filename : string);
var
  f : file;
begin
  assign(f,filename);
  erase(f);
end;

function exist(filename : string) : boolean;
var
  f : file;
begin
  assign(f,filename);
{$I-}
  reset(f);
  close(f);
{$I+}
  exist := ioresult = 0;
end;

function stringof(i : byte) : string;
var
 s : string[3];
begin
  str(i,s);
  stringof := s;
end;

function numberof(s : string) : byte;
var
  i : byte;
  code : word;
begin
  val(s,i,code);
  if code <> 0 then numberof := 0
    else numberof := i;
end;

function up_case(txt : string) : string;
var
  s : string;
  i : byte;
begin
  for i := 1 to ord(txt[0]) do s[i] := upcase(txt[i]);
  s[0] := txt[0];
  up_case := s;
end;

var
  myname : string;
  urname : string;
  mynum : byte;
  done : boolean;

function incoming_message : boolean;
var
  d : searchrec;
begin
  findfirst(urname+'.*',anyfile,d);
  incoming_message := doserror = 0;
end;

function next_message : string;
var
  f : file of char;
  k : char;
  s : string;
  i : byte;
begin
  i := 0;
  while (i <= 999) and (not exist(urname+'.'+stringof(i))) do inc(i);
  assign(f,urname+'.'+stringof(i));
  reset(f);
  s := '';
  while not eof(f) do
  begin
    read(f,k);
    s := s + k;
  end;
  close(f);
  next_message := s;
  erase_file(urname+'.'+stringof(i));
end;

procedure send_message(txt : string);
var
  f : file of char;
  k : char;
  i : byte;
begin
  insert(myname+': ',txt,1);
  assign(f,myname+'.'+stringof(mynum));
  rewrite(f);
  for i := 1 to ord(txt[0]) do
  begin
    k := txt[i];
    write(f,k);
  end;
  close(f);
  inc(mynum);
  if mynum = 1000 then mynum := 0;
end;

procedure dos_command(txt : string);
begin
  delete(txt,1,1);
  { Remove ":" from front }
  write_char(enter);
  swapvectors;
  exec(getenv('comspec'),'/C ' + txt);
  swapvectors;
  read_cursor;
end;

procedure run_dos_prompt;
begin
  writeln_string('Type exit to return to Nettalk.');
  swapvectors;
  exec(getenv('COMSPEC'),'');
  swapvectors;
  clear_screen;
end;

procedure nettalk_command(txt : string);
begin
  delete(txt,1,1);
  txt := up_case(txt);
  if txt = 'EXIT' then done := true;
  if txt = 'CLS' then clear_screen;
  if txt = 'DOS' then run_dos_prompt;
  if txt = 'HELP' then
  begin
    write_char(#13);
    writeln_string('  Nettalk:');
    writeln_string('  Type any message and it will be sent UNLESS...');
    writeln_string('  the first character is:');
    write_char(#13);
    writeln_string('  "-" in which case it is interpreted as a command.');
    writeln_string('  Current commands are "help","exit","cls", and "dos".');
    write_char(#13);
    writeln_string('  ":" in which case it is interpreted as a dos command.');
    writeln_string('  Nettalk will then run that dos command for you.');
    write_char(#13);
    writeln_string('  Examples:');
    write_char(#13);
    writeln_string('  -exit       ... exits this program');
    writeln_string('  :dir        ... shows what is in the current directory');
    writeln_string('  -help       ... shows this game screen');
    writeln_string('  -dos        ... goes to a dos prompt');
    writeln_string('  -cls        ... clear the screen');
    writeln_string('  :edit g.txt ... edits g.txt');
    write_char(#13);
    write_char(#13);
  end;
end;

var
  message : string;

begin
  clear_screen;
  write_string('Your name: ');
  read_new_string_minmax(myname,1,8);
  write_string('Input from: ');
  read_new_string_minmax(urname,1,8);
  done := false;
  repeat
    write_string('$ ');
    repeat until keypressed or incoming_message;
    if keypressed then
    begin
      message := readkey;
      if message <> #13 then
      begin
        if message = #8 then message := #0;
        read_string_minmax(message,0,253 - length(myname));
        case message[1] of
          ':' : dos_command(message);
          '-' : nettalk_command(message);
        else
          send_message(message);
        end;
      end else write_char(#13);
    end else write_char(#13);
    while incoming_message do writeln_string(next_message);
  until done;
  send_message(myname+' has logged off.');
end.