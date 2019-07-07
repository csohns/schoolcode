uses  crt,ansidrv;
var f:text;  temp:string;

begin
  clrscr;
{  assign(f,'e:\ansi\ans.bat');
  reset(f);
  while not eof(f) do
    Begin
      clrscr;
      readln(f, temp);
      ansi('e:\ansi\' + temp, 1);
      writeLn('e:\ansi\' + temp);
      readln;
    End;
  Close(F);}
  ansi('e:\ansi\mallopen.ans',1);
end.