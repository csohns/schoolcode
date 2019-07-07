uses crt,dos;

var
  num,num2,lcv: integer;

begin
  write('enter number: ');
  readln(num);
  for lcv := num downto 1 do
      if num mod lcv = 0 then writeln(lcv,',',num div lcv);
  readln;
end.