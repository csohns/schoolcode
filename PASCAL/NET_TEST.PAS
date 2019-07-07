Program DLLGKLKDFGKL;

Uses CRT, DOS, NovApi;

Var
  Drive: Char;
  DirectoryHandle    : Byte;
  StatusFlag         : Byte;
  Directory          : String;
  ScanMask           : string47;
  ScanType           : integer;
  LastSeen           : longint;
  FoundName          : string47;
  FoundType          : integer;
  FoundID            : longint;
  FoundFlag          : byte;
  FoundSecurity      : byte;
  FoundHasProperties : boolean;

{
procedure CreateDirectory(NewDirectory : string; NewDirectoryHandle : byte;
                          MaximumRights : byte);
procedure CreateObject(NewObject : string47; NewType : integer;
                       ObjectFlag,ObjectSecurity : byte);
procedure CreateProperty(WhichObject : string47; WhatType : integer;
                         NewProperty : string15; NewFlags,NewSecurity : byte);
procedure GetDirectoryHandle(Drive : char;
                             var DirectoryHandle, StatusFlag : byte);
procedure GetDirectoryPath(DirectoryHandle : byte;
                           var Directory : string);
procedure ScanObject(ScanMask : string47; ScanType : integer;
                     var LastSeen           : longint;
                     var FoundName          : string47;
                     var FoundType          : integer;
                     var FoundID            : longint;
                     var FoundFlag          : byte;
                     var FoundSecurity      : byte;
                     var FoundHasProperties : boolean);
}

Begin
  WriteLn;
  WriteLn;
  Write('Enter in a NetWork drive letter: ');
  ReadLn(Drive);
  Drive := UpCase(Drive);
  GetDirectoryHandle(Drive, DirectoryHandle, StatusFlag);
  WriteLn('DRIVE: ''',Drive,'''');
  WriteLn('DIRECTORY HANDLE: ',DirectoryHandle);
  WriteLn('STATUS FLAG: ',StatusFlag);
  ReadLn;
  WriteLn;
  WriteLn;
  Write('Enter in ScanMask: ');
  ReadLn(ScanMask);
  Write('Enter in ScanType: ');
  ReadLn(ScanType);
  ScanObject(ScanMask, ScanType, LastSeen, FoundName, FoundType, FoundID,
             FoundFlag, FoundSecurity, FoundHasProperties);
  WriteLn('SCAN MASK: ',ScanMask);
  WriteLn('SCAN TYPE: ',ScanType);
  WriteLn('LAST SEEN: ',LastSeen);
  WriteLn('FOUND NAME: ',FoundName);
  WriteLn('FOUND TYPE: ',FoundType);
  WriteLn('FOUND ID: ',FoundID);
  WriteLn('FOUND FLAG: ',FoundFlag);
  WriteLn('FOUND SECURITY: ',FoundSecurity);
  WriteLn('FOUND HAS PROPERTIES: ',FoundHasProperties);
  ReadLn;
End.