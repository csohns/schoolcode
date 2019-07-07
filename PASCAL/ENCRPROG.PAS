Uses CRT,DOS,NovApi;
Var
  f: Text;
  lcv: Integer;
  Pass: String47;
  num: Integer;
Begin
  ClrScr;
  Assign(f,'tst.tst');
  Write('Enter in the password: ');
  ReadLn(Pass);
  Write('Enter in encryption number: ');
  ReadLn(num);
  Write(Pass,' is NOW ');
  For lcv := 1 to Length(Pass) do
    Pass[lcv] := chr(ord(Pass[lcv])+num);
  WriteLn(Pass);
  Append(f);
  WriteLn(f,Pass);
  Close(f);
End.