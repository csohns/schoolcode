Program Inst_SetUp;

Uses
  CRT, DOS;

Var
  f: File;
  t: File of Char;
  Fname: String;
  Corrupt: Char;

Begin
  Write('Enter in file name to convert: ');
  ReadLn(Fname);
  Assign(f, Fname);
  Assign(t, Fname);
  ReSet(t);
  Corrupt := 'F';
  Write(t, Corrupt);
  Corrupt := 'C';
  Write(t, Corrupt);
  Close(t);
  Delete(Fname,Length(Fname) - 3,4);
  Insert('.000',Fname,Length(Fname) + 1);
  Rename(f, Fname);
End.