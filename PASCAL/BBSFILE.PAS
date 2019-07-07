Program BBSfile;

Uses Dos,crt;

const CheckBreak: Boolean = False;

var
 HostName, CurrentDriveName: String[8];   {Enviroment Variables}
 VolumeDir,UpLoadDir: String;
 Drive: Byte;

 cmd, parms, Dir: String;                 {Program variables}
{////////////////////////////////////////////////////////////////////////////}
Procedure CpyRight;
  Begin
    WriteLn;
    WriteLn('BBSFILE Dos Interperater v0.0 - Alpha0');
    WriteLn('Copyright Fc Systems 1997');
    WriteLn;
  End;
{////////////////////////////////////////////////////////////////////////////}
function LeadingZero(w : Word) : String;
var
  s : String;
begin
  Str(w:0,s);
  if Length(s) = 1 then
    s := '0' + s;
  LeadingZero := s;
end;
{////////////////////////////////////////////////////////////////////////////}
    Function UpStr(texts:String):String;
      Var
        lcv: Integer;
      Begin
        For lcv := 1 to Length(texts) do
          texts[lcv] := UpCase(texts[lcv]);
        UpStr := texts;
      End;
{////////////////////////////////////////////////////////////////////////////}
  Procedure CmdInterp(var parms:String;var cmd: String);
    Var
      lcv: Integer;
      TmpCmd: String;
    Begin  {CmdInterp}
      cmd := '';
      lcv := 0;
      If Length(parms) > 0 then
        Begin
          While (lcv < Length(parms)) and (parms[lcv] <> ' ') do
            Begin
              inc(lcv,1);
              cmd := cmd + parms[lcv];
            End;
          TmpCmd := cmd; cmd := parms; parms := TmpCmd;
          If parms[Length(parms)] = ' ' then delete(parms,Length(parms),1);
          delete(cmd,1,Length(parms)+1);
        End;  {CmdInterp}
    End;
{////////////////////////////////////////////////////////////////////////}
Procedure Directory(cmdline:String);
Var
  OK,
  pauseYN,
  All: Boolean;
  parms: String;
{////////////////////////////////////////////////////////////////////}
Procedure Search(what:String; Atype:Word);
Var
  DirInfo: SearchRec;
  cntr,fnum: Integer;
  spac: Char;
  TotSize: LongInt;
{////////////////////////////////////////////////////////////////}
  Procedure DispfName(name: String);
  Var
    lcv: Integer;
  Begin
    For lcv := 1 to Length(name) do
      Begin
        If name[lcv] <> '.' then Write(name[lcv])
        Else
          Begin
            If DirInfo.Attr <> $10 then GotoXY(10,WhereY) Else
              Write(name[lcv]);
          End;
      End;
  End;
{////////////////////////////////////////////////////////////////////}
  Procedure DispfSize(I: Longint);
  var
   S: string[11];
   lcv,cntr: Integer;
  begin
   cntr := 0;
   Str(I, S);
   For lcv := Length(S) downto 1 do
     Begin
       inc(cntr,1);
       If cntr = 4 then
         Begin
           cntr := 1;
           Write(',');
           GotoXY(WhereX-2,WhereY);
         End;
       Write(S[lcv]);
       GotoXY(WhereX-2,WhereY);
     End;
  end;
{////////////////////////////////////////////////////////////////////}
  Procedure DispfDate(name:String);
  Var
    day,month,year: Word;
    f: File;
  Begin
    GotoXY(27,WhereY);
  {  Assign(f,name);
    ReSet(f);
    Close(f);}
    Write('00-00-00');
    {GetfDate}
  End;
{////////////////////////////////////////////////////////////////////}
  Procedure DispfTime(time:LongInt);
  Var
     dt: DateTime;
     am: Boolean;
  Begin
    GotoXY(37,WhereY);
    am := TRUE;
    UnpackTime(time,dt);
    with dt do
      begin
        If hour > 12 then
          Begin
            am := FALSE;
            dec(hour,12);
          End;
        Write(LeadingZero(hour),':', LeadingZero(min){,':', LeadingZero(sec)});
        If am then Write('a') Else
          Write('p');
      end;
  End;
{////////////////////////////////////////////////////////////////////}
  Procedure DispfAttr;
  Begin
     GotoXY(69,WhereY);
     With DirInfo do
       Begin
         If Attr - 63 > 0 then Write('[-ERROR-]') Else
         If Attr - 63 = 0 then Write('[rhsadv]') Else
           Begin
             GotoXY(73,WhereY);
             If Attr - 32 >= 0 then Begin
                                      dec(Attr,32);
                                      Write('a');
                                    End Else Write('-');
             GotoXY(74,WhereY);
             If Attr - 16 >= 0 then Begin
                                      dec(Attr,16);
                                      Write('d');
                                      GotoXY(14,WhereY);
                                      Write('<DIR>');
                                    End Else Write('-');
             GotoXY(75,WhereY);
             If Attr - 8 >= 0 then Begin
                                     dec(Attr,8);
                                     Write('v]');
                                     GotoXY(14,WhereY);
                                     Write('<VOL>');
                                   End Else Write('-]');
             GotoXY(72,WhereY);
             If Attr - 4 >= 0 then Begin
                                     dec(Attr,4);
                                     Write('s');
                                   End Else Write('-');
             GotoXY(71,WhereY);
             If Attr - 2 >= 0 then Begin
                                     dec(Attr,2);
                                     Write('h');
                                   End Else Write('-');
             GotoXY(69,WhereY);
             If Attr - 1 >= 0 then Begin
                                     dec(Attr,1);
                                     Write('[r');
                                   End Else Write('[-');
(*             GotoXY(69,WhereY);
             If NOT h then
               Begin
                 If r then Write('[r') Else Write('[-');
{SPECIAL}        {If h then Write('h') Else} Write('-');
                 If s then Write('s') Else Write('-');
                 If a then Write('a') Else Write('-');
                 If d then Write('d') Else Write('-');
                 If v then Write('v]') Else Write('-]');
                 If d then Begin
                             GotoXY(14,WhereY);
                             Write('<DIR>');
                           End;
                 If v then Begin
                             GotoXY(14,WhereY);
                             Write('<VOL>');
                           End;
               End Else Hidden := TRUE;*)
           End;
       End;
  End;
{////////////////////////////////////////////////////////////////////}
  Procedure DispfType;
  Begin
     GotoXY(69,WhereY);
     With DirInfo do
       Begin
         If Attr - 63 > 0 then Write('[-ERROR-]') Else
         If Attr - 63 = 0 then Write('') Else
           Begin
             If Attr - 32 >= 0 then Begin
                                      dec(Attr,32);
                                      Write('');
                                    End Else Write('');
             If Attr - 16 >= 0 then Begin
                                      dec(Attr,16);
                                      Write('');
                                      GotoXY(14,WhereY);
                                      Write('<DIR>');
                                    End Else Write('');
             If Attr - 8 >= 0 then Begin
                                     dec(Attr,8);
                                     Write('');
                                     GotoXY(14,WhereY);
                                     Write('<VOL>');
                                   End Else Write('');
             If Attr - 4 >= 0 then Begin
                                     dec(Attr,4);
                                     Write('');
                                   End Else Write('');
             If Attr - 2 >= 0 then Begin
                                     dec(Attr,2);
                                     Write('');
                                   End Else Write('');
             If Attr - 1 >= 0 then Begin
                                     dec(Attr,1);
                                     Write('');
                                   End Else Write('');
           End;
       End;
  End;
{////////////////////////////////////////////////////////////////////////}
  Procedure DispfDes;
    Var
      f: Text;
      OK: Boolean;
      DesLine: String[52];
    Begin
      OK := TRUE;
      Assign(f,'FDES.DAT');
      {$I-}
      ReSet(f);
      Close(f);
      {$I+}
      If IOResult <> 0 then OK := FALSE;
      If OK then
        Begin
          ReSet(f);
          Repeat
            ReadLn(f, DesLine);
          Until (EOF(f)) OR (DesLine = DirInfo.Name);
          If DesLine = DirInfo.Name then
            Begin
              GotoXY(27,WhereY);
              WriteLn('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
              Repeat
                ReadLn(f, DesLine);
                If DesLine[1] <> 'ò' then
                  Begin
                    GotoXY(27,WhereY);
                    WriteLn(DesLine);
                  End;
              Until (EOF(f)) OR (DesLine[1] = 'ò');
              GotoXY(27,WhereY);
              Write('-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-');
            End;
          Close(f);
        End;
    End;
{////////////////////////////////////////////////////////////////////////}
Begin  {Search}
 cntr := 0;
 fnum := 0;
 TotSize := 0;
 FindFirst('*.*', VolumeID, DirInfo);
 If DosError = 0 then
   WriteLn('Volume on server ',HostName,' is ',DirInfo.Name);
 WriteLn('Directory of ',CurrentDriveName,Dir); WriteLn;
 WriteLn('------------------------------------------------------------------------------');
 FindFirst(what, {AType} 48, DirInfo);
 while DosError = 0 do
 begin
   If DirInfo.Name <> 'FDES.DAT' then
   Begin
   inc(cntr,1); inc(fnum,1); inc(TotSize,DirInfo.Size);
{   GotoXY(1,WhereY);}
   DispfName(DirInfo.Name);
   GotoXY(25,WhereY);
   DispfSize(DirInfo.Size);
   If All then
     Begin
       DispfTime(DirInfo.Time);
       DispfDate(DirInfo.Name);
       DispfAttr;
     End
   Else Begin
          DispfType;
          DispfDes;
        End;
   WriteLn;
   If cntr > 21 then
     Begin
       If pauseYN then
         Begin
           WriteLn('Press any key to continue . . .');
           Repeat
             spac := ReadKey;
           Until spac <> '';
           WriteLn;
           WriteLn('(continuing ',HostName,'/',CurrentDriveName,Dir,')');
         End;
       cntr := 0;
     End;
   End;
   FindNext(DirInfo);
 end;
 If fnum = 0 then WriteLn('File not found');
 WriteLn('------------------------------------------------------------------------------');
 GotoXY(7,WhereY); Write(fnum, ' file(s)');
 GotoXY(32,WhereY); DispfSize(TotSize); GotoXY(34,WhereY); WriteLn('bytes');
 GotoXY(32,WhereY); DispfSize(DiskFree(0)); GotoXY(34,WhereY); WriteLn('bytes free');
 WriteLn;
End;  {Search}
{////////////////////////////////////////////////////////////////////////}
  Procedure InterpParms(var parms:String;Kind:Char);
    Var
      lcv: Integer;
    Begin
      lcv := 1;
      Repeat
{        If Kind = 'C' then
          Begin
            If (parms[lcv] <> '/') AND (parms <> ' ') then parms := '*.*';
            lcv := Length(parms);
          End;}
        Case parms[lcv] of
          '/': Begin
                 If UpCase(parms[lcv + 1]) = 'A' then All := TRUE;
                 If UpCase(parms[lcv + 1]) = 'P' then pauseYN := TRUE;
               End;
        End;
        inc(lcv,1);
      Until lcv >= Length(parms);
    End;
{////////////////////////////////////////////////////////////////////////}
Begin  {Directory}
  pauseYN := FALSE;
  All := FALSE;
  CmdInterp(cmdline,parms);
  If (cmdline = '') {and (parms = '')} then cmdline := '*.*';
  If parms <> '' then InterpParms(parms,'P'); {Else
    If cmdline <> '' then InterpParms(cmdline,'C');}
  Search(cmdline,AnyFile);
End;  {Directory}
{////////////////////////////////////////////////////////////////////////////}
Procedure ChgDir(parms: String);
  Var
    CurrDir: String;
  Begin
    GetDir(0,CurrDir);
    If parms[1] = '\' then
      Begin
        If parms = '\' then parms := VolumeDir
          Else parms := VolumeDir + parms;
(*        WriteLn('''',parms,'''');*)
        {$I-}
        ChDir(parms);
        {$I+}
      End
    Else Begin
           delete(CurrDir,1,Length(VolumeDir));
           parms := VolumeDir + CurrDir + '\' + parms;
           If (CurrDir = '') and (parms[Length(parms)] = '.') then parms := VolumeDir;
           delete(CurrDir,Length(VolumeDir),Length(CurrDir));
(*           WriteLn('''',VolumeDir,'''');
           WriteLn('''',CurrDir,'''');
           WriteLn('''',parms,'''');*)
           {$I-}
           ChDir(parms);
           {$I+}
         End;
    If IOResult <> 0 then
      Begin
        WriteLn('Invalid directory');
      End;
    WriteLn;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure UpLoad(fname: String);
  Var
    sel: Char;
    OK: Boolean;
    FromF, ToF: file;
    NumRead, NumWritten: Word;
    Buf: array[1..2048] of Char;
{////////////////////////////////////////////////////////////////////////}
  Function Fix(fname: String): String;
    Var
      lcv: Integer;
    Begin
      lcv := Length(fname);
      While (fname[lcv] <> '\') AND (fname[lcv] <> ':') AND (lcv <> 0) do
        dec(lcv,1);
      If lcv <> 0 then delete(fname,1,lcv);
      Fix := fname;
    End;
{////////////////////////////////////////////////////////////////////////}
  Procedure CreateDes(fname: String);
    Var
      f: Text;
      OK: Boolean;
      line1, line2, line3, line4: String[52];
    Begin
      OK := TRUE;
      Assign(f, UpLoadDir + '\' + 'FDES.DAT');
      {$I-}
      ReSet(f);
      Close(f);
      {$I+}
      If IOResult <> 0 then
        Begin
          WriteLn('Description file not found!  Contact SysOp...');
          OK := FALSE;
        End;
      If OK then
        Begin
          Append(f);
          line1 := '';
          line2 := '';
          line3 := '';
          line4 := '';
          WriteLn(f, UpStr(fname));
          WriteLn('Begin writing your file description NOW.');
          WriteLn('You have 4 lines of 52 chars each, a blank line will end.');
          WriteLn('Anything after 52 chars will be discarded!');
          OK := FALSE;
          Repeat
            WriteLn('( - - - - + - - - - + - - - - + - - - - + - - - - + -)');
            GotoXY(2,WhereY);
            ReadLn(line1);
            If line1 = '' then
              Begin
                WriteLn('You MUST enter in at least one line of description!!');
              End Else OK := TRUE;
          Until OK;
          GotoXY(2,WhereY);
          ReadLn(line2);
          If line2 <> '' then
            Begin
              GotoXY(2,WhereY);
              ReadLn(line3);
            End;
          If line3 <> '' then
            Begin
              GotoXY(2,WhereY);
              ReadLn(line4);
            End;
          WriteLn(f,line1);
          If line2 <> '' then WriteLn(f,line2);
          If line3 <> '' then WriteLn(f,line3);
          If line4 <> '' then WriteLn(f,line4);
          WriteLn(f, 'ò');
          Close(f);
        End;
      WriteLn;
    End;
{////////////////////////////////////////////////////////////////////////}
  Begin
    OK := FALSE;
    Repeat
      If fname <> '' then
        Begin
          Write(fname,' [Y,n] ');
          Repeat
            sel := UpCase(ReadKey);
          Until sel <> '';
          WriteLn;
          If sel = 'Y' then OK := TRUE;
        End;
      If NOT OK then
        Begin
          WriteLn('Enter in LOCAL file to UpLoad:');
          ReadLn(fname);
        End;
    Until OK;
    Assign(FromF, fname); { Open input file }
    {$I-}
    Reset(FromF, 1);  { Record size = 1 }
    Close(FromF);
    {$I+}
    If IOResult <> 0 then WriteLn(fname, ' does not exist') Else
      Begin
        ReSet(FromF, 1);
        fname := Fix(fname);
        Assign(ToF, UpLoadDir + '\' + fname); { Open output file }
        {$I-}
        ReSet(ToF);
        Close(ToF);
        {$I+}
        If IOResult = 0 then WriteLn(fname, ' already exists on server ',HostName) Else
          Begin
            CreateDes(fname);
            Rewrite(ToF, 1);  { Record size = 1 }
            WriteLn;
            WriteLn('UpLoading ', FileSize(FromF), ' bytes...');
            Repeat
              BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
              BlockWrite(ToF, Buf, NumRead, NumWritten);
            Until (NumRead = 0) OR (NumWritten <> NumRead);
            Close(FromF);
            Close(ToF);
          End;
      End;
    WriteLn;
  End;
{////////////////////////////////////////////////////////////////////////////}
Procedure DownLoad(fname: String);
  Var
    sel: Char;
    OK: Boolean;
    FromF, ToF: file;
    NumRead, NumWritten: Word;
    Buf: array[1..2048] of Char;
{////////////////////////////////////////////////////////////////////////}
  Function Fix(fname: String): String;
    Var
      lcv: Integer;
    Begin
      lcv := Length(fname);
      While (fname[lcv] <> '\') AND (fname[lcv] <> ':') AND (lcv <> 0) do
        dec(lcv,1);
      If lcv <> 0 then delete(fname,1,lcv);
      Fix := fname;
    End;
{////////////////////////////////////////////////////////////////////////}
  Begin
    OK := FALSE;
    Repeat
      If fname <> '' then
        Begin
          Write(fname,' [Y,n] ');
          Repeat
            sel := UpCase(ReadKey);
          Until sel <> '';
          WriteLn;
          If sel = 'Y' then OK := TRUE;
        End;
      If NOT OK then
        Begin
          WriteLn('Enter in REMOTE file to DownLoad:    (must be in current directory)');
          ReadLn(fname);
        End;
    Until OK;
    fname := Fix(fname);
    Assign(FromF, fname); { Open input file }
    {$I-}
    Reset(FromF, 1);  { Record size = 1 }
    Close(FromF);
    {$I+}
    If IOResult <> 0 then WriteLn(fname, ' does not exist') Else
      Begin
        ReSet(FromF, 1);
        OK := FALSE;
        Repeat
          If NOT OK then
            Begin
              WriteLn('Enter in LOCAL file name:');
              ReadLn(fname);
            End;
          If fname <> '' then
            Begin
              Write(fname,' [Y,n] ');
              Repeat
                sel := UpCase(ReadKey);
              Until sel <> '';
              WriteLn;
              If sel = 'Y' then OK := TRUE;
            End;
        Until OK;
        Assign(ToF, fname); { Open output file }
        {$I-}
        ReSet(ToF);
        Close(ToF);
        {$I+}
        If IOResult = 0 then
          Begin
            WriteLn(fname, ' already exists on local machine'); WriteLn;
            OK := FALSE;
            Repeat
              If fname <> '' then
                Begin
                  Write('Overwrite ', fname,' [Y,n] ');
                  Repeat
                    sel := UpCase(ReadKey);
                  Until sel <> '';
                  WriteLn;
                  If sel = 'Y' then OK := TRUE;
                End;
              If NOT OK then
                Begin
                  WriteLn('Enter in NEW local file name:  (leave blank to cancel)');
                  ReadLn(fname);
                End;
            Until OK;
          End;
        If fname <> '' then
          Begin
            Assign(ToF, fname); { Open output file }
            Rewrite(ToF, 1);  { Record size = 1 }
            WriteLn;
            WriteLn('DownLoading ', FileSize(FromF), ' bytes...');
            Repeat
              BlockRead(FromF, Buf, SizeOf(Buf), NumRead);
              BlockWrite(ToF, Buf, NumRead, NumWritten);
            Until (NumRead = 0) OR (NumWritten <> NumRead);
            Close(FromF);
            Close(ToF);
          End;
      End;
    WriteLn;
  End;
{////////////////////////////////////////////////////////////////////////////}
  Procedure CmdAct(var cmd, parms: String);
    Begin  {CmdAct}
    cmd := UpStr(cmd);
    parms := UpStr(parms);
      If cmd = 'CLS' then ClrScr Else
      If cmd = 'EXIT' then cmd := 'EXIT' Else
      If cmd = 'DIR' then Directory(parms) Else
      If cmd = 'VER' then CpyRight Else
      If cmd = 'CD' then ChgDir(parms) Else
      If cmd = 'SEND' then UpLoad(parms) Else
      If cmd = 'GET' then DownLoad(parms) Else
      If cmd = '' then WriteLn Else
           Begin  {Else}
             WriteLn('Bad command or file name'); WriteLn;
           End;  {Else}
    End;  {CmdAct}
{////////////////////////////////////////////////////////////////////////////}
Begin  {Main}
  HostName := 'HOST';
  CurrentDriveName := 'VOL';
  VolumeDir := 'E:\TP';
  UpLoadDir := 'E:\TP\BIN\BBS\UPLOAD';
  CpyRight;
  Repeat
    GetDir(0,Dir);
    delete(Dir,1,1);
    Write(HostName,'/',CurrentDriveName,Dir,'>'); ReadLn(cmd);
    CmdInterp(cmd, parms);
(*    WriteLn('''',cmd,'''');
    WriteLn('''',parms,'''');*)
    CmdAct(cmd, parms);
  Until cmd = 'EXIT';
  WriteLn;
End.  {Main}

SearchRec = record
  Fill: array[1..21] of Byte;
  Attr: Byte;
  Time: Longint;
  Size: Longint;
  Name: string [12];
end;