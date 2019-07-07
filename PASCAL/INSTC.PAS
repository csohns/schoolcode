Program INSTALL_DAT_CREATOR;

Const
     maxfiles = 255;

Type
     file_names = record
                       Fname: String[12];
                  End;
     Group = Array[1..maxfiles] of file_names;
     Inst_Cfg = Record
                  ProgName: String[76];
                  EncKey: String[29];
                  CompName: String[78];
                  DirName: String[26];
                End;

Var
     F: file of file_names;
     FList: Group;
     loop, lcv: Integer;
     sel: Char;
     Cfg: Inst_Cfg;

{////////////////////////////////////////////////////////////////////////////}
Procedure Init;
  Var
    k: File of Inst_Cfg;
{////////////////////////////////////////////////////////////////}
  Function EC(texts:String): String;
    Var
      lcv: Integer;
    Begin
      For lcv := 1 to Length(texts) do
        texts[lcv] := chr((ord(texts[lcv]) * 2 ) + 7);
      EC := texts;
    End;
{////////////////////////////////////////////////////////////////}
  Begin
    WriteLn('Enter in program name  (76 chars MAX):');
    ReadLn(Cfg.ProgName);
    WriteLn('Enter in company name  (78 chars MAX):');
    ReadLn(Cfg.CompName);
    WriteLn('Enter in directory name for files to be copied to  (26 chars MAX):');
    ReadLn(Cfg.DirName);
    WriteLn('Enter in ZIP encryption key (28 chrs MAX):    If none, just press Enter');
    ReadLn(Cfg.EncKey);
    If Cfg.EncKey <> '' then Insert('-s',Cfg.EncKey,1);
    Cfg.ProgName := EC(Cfg.ProgName);
    If Cfg.EncKey <> '' then Cfg.EncKey := EC(Cfg.EncKey);
    Cfg.CompName := EC(Cfg.CompName);
    Cfg.DirName := EC(Cfg.DirName);
    Assign(k,'INSTALL.CFG');
    ReWrite(k);
    Write(k,Cfg);
    Close(k);
    WriteLn;
    WriteLn;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Automatic;
  Var
    c: Text;
    source: String;
  Begin
    Init;
    Assign(F, 'INSTALL.DAT');
    WriteLn;
    Write('Enter in source file name: ');
    ReadLn(source);
    Assign(c, source);
    ReSet(c);
    loop := 0;
    While NOT EOF(c) do
      Begin
        inc(loop,1);
        ReadLn(c, FList[loop].Fname);
      End;
    Close(c);
    ReWrite(F);
    For lcv := 1 to loop do
      Write(F, FList[lcv]);
    Close(F);
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Manual;
  Begin
    Init;
    Assign(F, 'INSTALL.DAT');
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
  End;
{////////////////////////////////////////////////////////////////////////////}
Begin
  WriteLn;
  WriteLn;
  WriteLn('[A]utomatic, [M]anual, or [Q]uit');
  ReadLn(sel);
  sel := UpCase(sel);
  If sel = 'A' then Automatic
    Else If sel = 'M' then Manual
      Else Begin
             WriteLn;
             WriteLn('No changes made!');
             WriteLn;
           End;
End.