
                   {Chaos Continuum Data Encryption Program}
                    {A Quasar Graphix Limited Presentation}
                                 {Version 1.0}
                                    {CBIAD}

Program Kill_Chris;

Uses Crt;

Var EncFile, NewFile                :Text;
    FileName, Password, FileName2   :String;
    Option, Ch, NCh                 :Char;
    Value, Cntr, Cntr2, Cntr3, size :Integer;

{ º º º º º º º º º º º º º º P R O C E D U R E S º º º º º º º º º º º º º }

Procedure Encrypt;

          Begin
               Clrscr;
               Writeln;
               Write('Please enter name of file to be encrypted: ');
               Readln(FileName);
               Writeln;
               Write('Please enter name of product file: ');
               Readln(FileName2);
               Writeln;
               Write('Please enter password: ');
               Readln(Password);
               Writeln;
               Write('Please enter code value: ');
               Readln(Value);
               Clrscr;
               Writeln;
               Write('Please wait...');
               Cntr  := 0;
               Cntr2 := 0;

               For Cntr := 1 to Length(Password) Do
                   Cntr2 := Ord(Password[Cntr]) + Cntr2;
               Cntr3 := Trunc((Cntr2 / Length(Password)) / Value);

               Assign(EncFile, FileName);
               Reset(EncFile);
               Close(EncFile);

               Assign(NewFile, FileName2);
               ReWrite(NewFile);
               Close(NewFile);

               Reset(EncFile);

               size := Filesize(EncFile);
               Cntr2 := 1;
               {Repeat}
               for cntr2 := 1 to size(EncFile) do
                       Begin
                          Read(EncFile, Ch[Cntr2]);
                          NCh := Ch;
                          If Cntr Mod 2 = 0 Then NCh := Chr(Ord(NCh) + Cntr3)
                             Else NCh := Chr(Ord(NCh) - Cntr3);
                          Close(EncFile);
                          Append(NewFile);
                          Write(NewFile, NCh);
                          Inc(Cntr);
                          Inc(Cntr2);
                          Inc(Cntr3);

                          Close(NewFile);
                          Reset(EncFile);
                    End;
               {Until EOF(EncFile);}
               Close(EncFile);

          End;

{----------------------------------------------------------------------------}

Procedure Decrypt;

          Begin
               Clrscr;
               Writeln;
               Write('Please enter name of file to be decrypted: ');
               Readln(FileName);
               Writeln;
               Write('Please enter password: ');
               Readln(Password);
               Writeln;
               Write('Please enter code value: ');
               Readln(Value);
               Clrscr;
               Writeln;
               Write('Please wait...');
               Cntr  := 0;
               Cntr2 := 1;

               For Cntr := 1 to Length(Password) Do
                   Cntr2 := Ord(Password[Cntr]) + Cntr2;
               Cntr3 := Trunc((Cntr2 / Length(Password)) / Value);

               Assign(EncFile, FileName);
               Reset(EncFile);

               Repeat

                          Read(EncFile, Ch);
                          NCh := Ch;
                          If Cntr Mod 2 = 0 Then NCh := Chr(Ord(NCh) - Cntr3)
                             Else NCh := Chr(Ord(NCh) + Cntr3);
                          ReWrite(EncFile);
                          Write(EncFile, NCh);
                          Inc(Cntr);
                          Inc(Cntr3);
                          Reset(EncFile);

               Until EOF(EncFile);

               Close(EncFile);
          End;




{ º º º º º º º º º º º º º º M A I N  P R O G R A M º º º º º º º º º º º º }

Begin
     Clrscr;
     Writeln;
     Writeln;
     Writeln('                  1. Encrypt');
     Writeln('                  2. Decrypt');
     Writeln;
     Write('Please make a selection (1,2): ');
     Option := ReadKey;
     If Option = '1' then Encrypt
        Else Decrypt;
     Clrscr;
     Writeln;
     Writeln('Procedure complete!');
     Writeln;
     Write('Have a nice day...');
     Delay(500);
End.








