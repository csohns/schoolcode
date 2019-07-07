uses crt, dos;

type
     buffer = Array[1..1000] of Char;

var
     inp: text;
     outp: text;
     input, output: String;
     ch: char;
     buf: buffer;
     lcv, fun: Integer;
     size: LongInt;
     left: Real;

Begin
     ClrScr;
     Write('Enter in input file:  ');
     ReadLn(input);
     Write('Enter in output file:  ');
     ReadLn(output);
     assign(inp, input);
     assign(outp, output);
     reset(inp);
     lcv := 0;
     size := 0;
     while not eof(inp) do
          Begin
               inc(size, 1);
               read(inp, ch);
          End;
     close(inp);
     reset(inp);
     while not eof(inp) do
          Begin
               inc(lcv, 1);
               read(inp, buf[lcv]);
               GotoXY(1,1);
               left := lcv / size * 100;
               Write(left:0:0, '%');
               delay(1);
          End;
     close(inp);
     rewrite(outp);
     For fun := 1 to lcv do
          Begin
               write(outp, buf[fun]);
          End;
     close(outp);
End.