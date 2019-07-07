Program INSTALL_DAT_CREATOR;

Uses
     CRT;

Const
     maxfiles = 255;

Type
     file_names = record
                       Fname: String[12];
                  End;
     Group = Array[1..maxfiles] of file_names;

Var
     F: file of file_names;
     FList: Group;
     loop, lcv: Integer;
     sel: Char;

{///////////////////////}
Procedure Manual;
     Begin
          ReWrite(F);
          Write('How many files are there??  ');
          ReadLn(lcv);
          For loop := 1 to lcv do
               Begin
                    WriteLn('Enter in file number ', loop);
                    Write(':  ');
                    ReadLn(FList[loop].Fname);
               End;
          For loop := 1 to lcv do
               Write(F, FList[loop]);
          Close(F);
     End;
{///////////////////////}
Procedure Automatic;
     Var
          FLoadF: String;
          I: Text;
     Begin
          ReWrite(F);
          Write('Enter in file to load from:  ');
          ReadLn(FLoadF);
          Assign(I, FLoadF);
          ReSet(I);
          lcv := 0;
          While NOT EOF(I) do
               Begin
                    inc(lcv, 1);
                    ReadLn(I, FList[lcv].Fname);
                    WriteLn(FList[lcv].Fname);
               End;
          Close(I);
          For loop := 1 to lcv do
               Write(F, FList[loop]);
          Close(F);
     End;
{///////////////////////}

Begin
     Assign(F, 'INSTALL.DAT');
     WriteLn('[M]anual or [A]utomatic');
     Repeat
          Repeat
               sel := ReadKey;
          Until sel <> '';
     sel := UpCase(sel);
     Until (sel = 'M') or (sel = 'A');
     If sel = 'M' then Manual
          Else If sel = 'A' then Automatic
                    Else WriteLn('ABORT');
End.