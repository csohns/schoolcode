Uses NovApi,NovTools,CRT;

Procedure UserInfo;
Type
  String20 = String[20];
Var
  lcv,lcv2: Integer;
  AccountBalance, CreditLimit  : longint;
  ServerList     : AccountHoldServerArray;
  LoginInfo: LoginControlRecord;
  SecurityAccessLevel: Byte;
  WhichConnection : integer;
  ObjectID    : longint;
  ObjectType  : integer;
  ObjectName  : string47;
  ObjectLogin : NetworkTimeRecord;
  HexObjectID : String20;
  NodeAddress: String20;
  NameList: Array[1..100] of string47;
  TmpNameList: Array[1..100] of string47;
  X: Integer;
  change: Boolean;
  ConnectionAddress: InternetworkAddress;
  PNN: LongInt;
  tmpbt: Byte;
{////////////}
  Procedure LongInt2Hex(var ObjectID: LongInt; var HexObjectID: String20);
    Var
      tmpint: Integer;
      tmpchr: Char;
      LessZero: Boolean;
    Begin
      LessZero := FALSE;
      If ObjectID < 0 then LessZero := TRUE;
(*      If ObjectID < 0 then tmpint := ObjectID MOD -16
        Else tmpint := ObjectID MOD 16;*)
      tmpint := ObjectID MOD 16;
      tmpint := abs(tmpint);
      If LessZero then
        Begin
          tmpint := 15 - tmpint;
        End;
      Case tmpint of
        0:  tmpchr := '0';
        1:  tmpchr := '1';
        2:  tmpchr := '2';
        3:  tmpchr := '3';
        4:  tmpchr := '4';
        5:  tmpchr := '5';
        6:  tmpchr := '6';
        7:  tmpchr := '7';
        8:  tmpchr := '8';
        9:  tmpchr := '9';
       10:  tmpchr := 'A';
       11:  tmpchr := 'B';
       12:  tmpchr := 'C';
       13:  tmpchr := 'D';
       14:  tmpchr := 'E';
       15:  tmpchr := 'F';
      End;
(*    If ObjectID < 0 then ObjectID := ObjectID DIV -16
      Else ObjectID := ObjectID DIV 16;*)
    ObjectID := ObjectID DIV 16;
    {Write(tmpchr);}
    HexObjectID := HexObjectID + tmpchr;
    If ObjectID <> 0 then LongInt2Hex(ObjectID,HexObjectID);
    End;
{////////////}
Procedure Switch(var HexObjectID:String20);
  Var
    tmpHOID: String20;
    lcv: Integer;
  Begin
    tmpHOID := '';
    For lcv := Length(HexObjectID) downto 1 do
      tmpHOID := tmpHOID + HexObjectID[lcv];
    HexObjectID := tmpHOID;
  End;
{////////////}
Begin
  ClrScr;
  For lcv := 1 to 100 do
    Begin
      GetConnectionInformation(lcv,ObjectID,ObjectType,ObjectName,ObjectLogin);
      NameList[lcv] := ObjectName;
    End;
  Repeat
  ClrScr;
  X := 2;
  For lcv := 1 to 100 do
    Begin
      PNN := 0;
      GetConnectionInformation(lcv,ObjectID,ObjectType,ObjectName,ObjectLogin);
      GetInternetAddress(lcv,ConnectionAddress);
(*      Write(ObjectName);
      For lcv2 := 1 to 4 do
        Write(ConnectionAddress.NetworkNumber[lcv2]);
      Write('  ');                                   *)
      NodeAddress := '';
      For lcv2 := 1 to 6 do
        Begin
          HexObjectID := '';
          PNN := ConnectionAddress.PhysicalNodeNumber[lcv2];
          LongInt2Hex(PNN,HexObjectID);
          Switch(HexObjectID);
          NodeAddress := NodeAddress + HexObjectID;
        End;
(*      Write(NodeAddress);
      Write('  ');
      WriteLn(ConnectionAddress.SocketNumber);*)
      TmpNameList[lcv] := ObjectName;
      GotoXY(X,WhereY);
      If WhereY = 25 then Write(lcv,'  ',ObjectName)
        Else Write(lcv,'  ',ObjectName);
      If ObjectName <> '' then      {REM this out to see all free connections}
      Case lcv of
        1..24:  Begin
                  GotoXY(21,WhereY);
                  WriteLn(NodeAddress);
                End;
        25:  Begin
               GotoXY(21,WhereY);
               Write(NodeAddress);
             End;
        26..49:  Begin
                   GotoXY(55,WhereY);
                   WriteLn(NodeAddress);
                 End;
        50:  Begin
               GotoXY(55,WhereY);
               Write(NodeAddress);
             End;
        51..74:  Begin
                   GotoXY(21,WhereY);
                   WriteLn(NodeAddress);
                 End;
        75:  Begin
               GotoXY(21,WhereY);
               Write(NodeAddress);
             End;
        76..99:  Begin
                   GotoXY(55,WhereY);
                   WriteLn(NodeAddress);
                 End;
        100:  Begin
                GotoXY(55,WhereY);
                Write(NodeAddress);
              End;
      End;
      Case lcv of
        9:  Begin
              X := 1;
              GotoXY(X,WhereY);
            End;
       25:  Begin
              X := 34;
              GotoXY(X,1);
            End;
       50:  Begin
              ReadLn;
              ClrScr;
              X := 1;
              GotoXY(X,1);
            End;
       75:  Begin
              X := 34;
              GotoXY(X,1);
            End;
       99: Begin
             X := 33;
             GotoXY(X,WhereY);
           End;
      End;
   End;
   GotoXY(1,1);
   change := FALSE;
   Repeat
     For lcv := 1 to 100 do
       Begin
         GetConnectionInformation(lcv,ObjectID,ObjectType,ObjectName,ObjectLogin);
         TmpNameList[lcv] := ObjectName;
         If NameList[lcv] <> TmpNameList[lcv] then change := TRUE;
       End;
     If change then
       For lcv := 1 to 100 do
         NameList[lcv] := TmpNameList[lcv];
   Until (keypressed) or (change);
  Until keypressed;
  ClrScr;
End;

{////////////////////////}
Var
    lcv: Integer;
    sel: Char;
Begin
  UserInfo;
End.