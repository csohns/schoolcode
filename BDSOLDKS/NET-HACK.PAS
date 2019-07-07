Program Net_Hack;

Uses
     IPXLib, NovAPI, NovTools, Crt;

Var
     ServerName, NetworkPath, command: String;
     WhichObject, WhichGroup: String[47];
     Password: String[127];
     LoginDrive, DriveLetter, NetDrive: Char;
     WhatType, ConnectionID, lcv: Integer;
     AccountBalance, CreditLimit: LongInt;
     SecurityAccessLevel: Byte;
     WhichLPT: LPTNames;
     BannerName: BannerArray;
     ServerList: AccountHoldServerArray;
     OpCode : DownServerCommands;

{procedure GetAccountStatus(WhichObject : string47; WhatType : integer;
                           var AccountBalance, CreditLimit  : longint;
                           var ServerList     : AccountHoldServerArray);
procedure GetBannerUserName(var BannerUserName : BannerArray);
procedure GetBinderyAccessLevel(var SecurityAccessLevel : byte);
procedure VerifyObjectPassword(WhichObject : string47; WhatType : integer;
                               Password : string127);}
Begin
     ClrScr;
     OpenBindery;
     Write('Enter in your user name:  ');
     ReadLn(WhichObject);
     GetAccountStatus(WhichObject, 1, AccountBalance, CreditLimit, ServerList);
     GetBinderyAccessLevel(SecurityAccessLevel);
     WriteLn(WhichObject);
     WriteLn;
     Write(AccountBalance, '        ', CreditLimit);
     WriteLn;
     WriteLn(SecurityAccessLevel);
     Delay(4000);
     WriteLn('NET-HACK');
     For lcv := 1 to 10 do
          WriteLn;
     Repeat
          Write('Enter in command:  ');
          ReadLn(command);
     If command = 'ATTACH'
          then Begin
                    Write('Enter in file server name:  ');
                    ReadLn(ServerName);
                    Write('Enter in login drive:  ');
                    ReadLn(LoginDrive);
                    {Attach(ServerName, LoginDrive);}
               End;
     If command = 'ADDMEMBERTOGROUP'
          then Begin
                    Write('Enter in user name:  ');
                    ReadLn(WhichObject);
                    Write('Enter in which group:  ');
                    ReadLn(WhichGroup);
                    AddMemberToGroup(WhichObject, 1, WhichGroup);
               End;
     If command = 'ENDCAP'
          then Begin
                    {Write('Which LPT port to EndCap?  ');
                    ReadLn(WhichLPT);}
                    EndCap(WhichLPT);
               End;
     If command = 'FILESERVERNAME'
          then Begin
                    Write('Enter in file server connection ID:  ');
                    ReadLn(ConnectionID);
                    {FileServerName(ConnectionID);}
               End;
     If command = 'FULLNAME'
          then Begin
                    Write('Enter in user name:  ');
                    ReadLn(WhichObject);
                    {FullName(WhichObject, 1);}
               End;
     If command = 'MAP'
          then Begin
                    Write('Enter in drive letter to map:  ');
                    ReadLn(DriveLetter);
                    Write('Enter in network path:  ');
                    ReadLn(NetworkPath);
                    Map(DriveLetter, NetworkPath);
               End;
     If command = 'MAPDEL'
          then Begin
                    Write('Enter in the drive map to delete:  ');
                    ReadLn(DriveLetter);
                    MapDel(DriveLetter);
               End;
     If command = 'REMOVEMEMBERFROMGROUP'
          then Begin
                    Write('Enter in user name:  ');
                    ReadLn(WhichObject);
                    Write('Enter in group name:  ');
                    ReadLn(WhichGroup);
                    RemoveMemberFromGroup(WhichObject, 1, WhichGroup);
               End;
     If command = 'SERVERCONNECTIONID'
          then Begin
                    Write('Enter in file server name:  ');
                    ReadLn(ServerName);
                    {ServerConnectionID(ServerName);}
               End;
     If command = 'VOLUMENAME'
          then Begin
                    Write('Enter in network drive letter:  ');
                    ReadLn(NetDrive);
                    {VolumeName(NetDrive);}
               End;
     If command = 'LISTOFCOMMANDS'
          then Begin
                    WriteLn('-Attach');
                    WriteLn('AddMemberToGroup');
                    WriteLn('?EndCap');
                    WriteLn('-FileServerName');
                    WriteLn('-FullName');
                    WriteLn('Map');
                    WriteLn('MapDel');
                    WriteLn('RemoveMemberFromGroup');
                    WriteLn('-ServerConnectionID');
                    WriteLn('-VolumeName');
               End;
     If command = 'SETBANNERUSERNAME'
          then Begin
                    {Write('Enter in new uaer name:  ');
                    ReadLn(BannerName);}
                    SetBannerUserName(BannerName);
               End;
     If command = 'DOWNFILESERVER'
          then Begin
                    ClrScr;
                    WriteLn('File Server shut down in 8 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 7 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 6 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 5 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 4 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 3 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 2 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('File Server shut down in 1 seconds. . .');
                    Delay(1000);
                    ClrScr;
                    WriteLn('You asked for it!!!!!!!!!!!!!!!!');
                    Delay(2000);
                    DownFileServer(OpCode);
               End;

     Until command = 'QUIT';
     CloseBindery;

End.

{procedure AbortServiceQueueJob(QueueID : longint; JobNumber : integer);
procedure AddObjectToSet(WhichObject : string47; WhatType : integer;
                         WhichProperty : string15;
                         NewMemberName : string47; NewMemberType : integer);
procedure AddTrusteeToDirectory(WhichObjectID : longint;
                                DirectoryHandle : integer; Directory : string;
                                RightsMask : byte);
procedure AllocPermanentDirectoryHandle(CurrentHandle : byte;
                                        Directory : string; DriveLetter : char;
                                        var NewHandle, EffectiveRights : byte);
procedure AllocSpecialTemporaryDirectoryHandle(CurrentHandle : byte;
                                        Directory : string; DriveLetter : char;
                                        var NewHandle, EffectiveRights : byte);
procedure AllocTemporaryDirectoryHandle(CurrentHandle : byte;
                                        Directory : string; DriveLetter : char;
                                        var NewHandle, EffectiveRights : byte);
procedure AttachServerToQueue(QueueID : longint);
procedure AttachToFileServer(ConnectionID : byte);
procedure BroadcastToConsole(Message : string60);
procedure CancelLPTCapture;
procedure CancelSpecificCapture(Device : LPTNames);
procedure ChangeJobQueueEntry(QueueID : longint;
                              var Job : JobEntryRecord);
procedure ChangeJobQueuePosition(QueueID : longint; JobNumber : integer;
                                 NewPosition : byte);
procedure ChangeObjectPassword(WhichObject : string47; WhatType : integer;
                               OldPassword, NewPassword : string127);
procedure ChangeObjectSecurity(WhichObject : string47; WhatType : integer;
                               NewSecurity : byte);
procedure ChangePropertySecurity(WhichObject : string47; WhatType : integer;
                                 WhichProperty : string15; NewSecurity : byte);
procedure ChangeServersRightsToClientsRights(QueueID : longint; JobNumber : integer);
procedure CheckPipeStatus(ConnectionList : string100;
                          var ResultList : string100);
procedure ClearConnectionNumber(LogicalConnectionNumber : byte);
procedure ClearFile(FileName : string);
procedure ClearFileSet;
procedure ClearLogicalRecord(LogicalRecordName : string99);
procedure ClearLogicalRecordSet;
procedure ClearPhysicalRecord(FileHandle : integer;
                              RecordOffset, RecordLength : longint);
procedure ClearPhysicalRecordSet;
procedure CloseAndStartQueueJob(QueueID : longint; JobNumber : integer);
procedure CloseBindery;
procedure CloseMessagePipe(ConnectionList : string100;
                          var ResultList : string100);
procedure CloseSemaphore(SemaphoreHandle : longint);
function  ConnectionNumber : integer;
procedure CreateDirectory(NewDirectory : string; NewDirectoryHandle : byte;
                          MaximumRights : byte);
procedure CreateObject(NewObject : string47; NewType : integer;
                       ObjectFlag,ObjectSecurity : byte);
procedure CreateProperty(WhichObject : string47; WhatType : integer;
                         NewProperty : string15; NewFlags,NewSecurity : byte);
procedure CreateQueue(QueueName,QueuePath : string; QueueBase : byte;
                      var NewQueueID : longint);
procedure CreateQueueJob(QueueID : longint; var Job : JobEntryRecord);
procedure DeallocateDirectoryHandle(DirectoryHandle : byte);
function  DefaultConnectionID : integer;
function  DefaultLocalPrinter : LPTNames;
procedure DeleteDirectory(Directory : string; DirectoryHandle : byte);
procedure DeleteObject(WhichObject : string47; WhatType : integer);
procedure DeleteObjectFromSet(WhichObject : string47; WhatType : integer;
                              WhichProperty : string15;
                              MemberName : string47; MemberType : integer);
procedure DeleteProperty(WhichObject : string47; WhatType : integer;
                         NewProperty : string15);
procedure DeleteTrusteeFromDirectory(WhichObjectID : longint;
                                     DirectoryHandle : integer;
                                     Directory : string);
procedure DestroyQueue(QueueID : longint);
procedure DetachFromFileServer(ConnectionID : byte);
procedure DetachServerFromQueue(QueueID : longint);
procedure DisableFileServerLogin;
procedure DisableTransactionTracking;
procedure DownFileServer(OpCode : DownServerCommands);
procedure EnableFileServerLogin;
procedure EnableTransactionTracking;
procedure EndLPTCapture;
procedure EndOfJob(OpCode : WhichJobs);
procedure EndSpecificCapture(Device : LPTNames);
procedure EnterLoginArea(NumberOfLocalDrives : byte;
                         LoginSubdirectory : string);
procedure ExamineSemaphore(SemaphoreHandle : longint;
                           var SemaphoreValue : integer;
                           var OpenCount      : integer);
procedure FileServerFileCopy(SourceHandle,DestinationHandle : word;
                            SourceOffset,DestinationOffset : longint;
                            BytesToCopy : longint;
                            var BytesCopied : longint);
function  FileServerLoginEnabled : boolean;
procedure FinishServiceQueueJob(QueueID : longint; JobNumber : integer;
                                Charge : longint);
procedure FlushLPTCapture;
procedure FlushSpecificCapture(Device : LPTNames);
procedure GetAccountStatus(WhichObject : string47; WhatType : integer;
                           var AccountBalance, CreditLimit  : longint;
                           var ServerList     : AccountHoldServerArray);
procedure GetBannerUserName(var BannerUserName : BannerArray);
procedure GetBinderyAccessLevel(var SecurityAccessLevel : byte);
procedure GetBroadcastMessage(var BroadcastMessage : string55);
procedure GetBroadcastMode(var Mode : BroadcastModes);
procedure GetConnectionIDTable(var ShellConnectionTable : ConnectionTablePointer);
procedure GetConnectionInformation(WhichConnection : integer;
                                   var ObjectID    : longint;
                                   var ObjectType  : integer;
                                   var ObjectName  : string47;
                                   var ObjectLogin : NetworkTimeRecord);
procedure GetConnectionsSemaphores(ConnectionNumber : integer;
                                   var LastSeen : integer;
                                   var NumberRecords : byte;
                                   var InfoRec : SemaphoreInfoArray);
procedure GetDefaultCaptureFlags(var Flags : PrintFlagInformation);
procedure GetDirectoryHandle(Drive : char;
                             var DirectoryHandle, StatusFlag : byte);
procedure GetDirectoryPath(DirectoryHandle : byte;
                           var Directory : string);
procedure GetDiskCacheStatistics(var InfoRec : DiskCacheStatistics);
procedure GetDiskChannelStatistics(ChannelNbr : byte;
                                   var InfoRec : DiskChannelStatistics);
procedure GetDiskUtilization(WhichObjectID : longint; WhatVolume : byte;
                         var UsedDirectories,UsedFiles,UsedBlocks : integer);
procedure GetDriveConnectionIDTable(var DrvConnectionTable : DriveConnectionTablePtr);
procedure GetDriveFlagTable(var DrvFlagTable : DriveFlagTablePtr);
procedure GetDriveHandleTable(var DrvHandleTable : DriveHandleTablePtr);
procedure GetDriveMappingTable(var InfoRec : ServerDriveMappingTable);
procedure GetEffectiveDirectoryRights(Directory : string; DirHandle : byte;
                                      var EffectiveRights : byte);
procedure GetExtendedFileAttributes(FileName : string; var ExtendedAttributes : byte);
procedure GetFileServerDateAndTime(var NetworkTime : NetworkTimeRecord);
procedure GetFileServerDescriptionStrings(var CompanyName,Revision,RevisionDate,Copyright : string);
procedure GetFileServerInformation(var InfoRec : FileServerInformation);
procedure GetFileServerNameTable(var ServerNameTable : NameTablePtr);
procedure GetFileSystemStatistics(var InfoRec : FileSystemStatistics);
procedure GetInternetAddress(ConnectionNumber : integer;
                             var ConnectionAddress : InternetworkAddress);
procedure GetJobsQueueEntryFileSize(QueueID : longint;
                                    JobNumber : integer;
                                    var FileSize : longint);
procedure GetLANDriversConfiguationInformation(WhichLAN : byte;
                                           var Address     : NetworkAddress;
                                           var HostAddress : NodeAddress;
                                           var LANDriverInstalled : boolean;
                                           var OptionNumber : byte;
                                           var ConfigurationText : string);
procedure GetListOfQueueJobs(QueueID : longint;
                             var JobCount : integer;
                             var Jobs : JobArray);
procedure GetLockMode(var Mode : LockModes);
procedure GetObjectConnectionNumbers(WhichObject : string47; WhatType : integer;
                                     var ConnectionList : string100);
procedure GetObjectID(WhichObject : string47; WhatType : integer;
                      var ObjectID : longint);
procedure GetObjectName(WhichObjectID : longint;
                        var ObjectName : string47; var ObjectType : integer);
procedure GetObjectsRemainingDiskSpace(WhichObjectID : longint;
                                       var InfoRec : RemainingSpaceRecord);
procedure GetPersonalMessage(var WhoSentIt : byte; var Message : string);
procedure GetPrinterStatus(ServerPrinter :byte;
                           var ServerPrinterStopped,
                               ServerPrinterOffLine  : boolean;
                           var ServerPrinterFormType : byte);
procedure GetSemaphoreInformation(SemaphoreName : string;
                                  var LastSeen,OpenCount : integer;
                                  var Value : shortint;
                                  var NumberRecords : byte;
                                  var Information : SemaphoreInformationRecords);
procedure GetServerLANIOStatistics(var InfoRec : ServerLANIOStatistics);
procedure GetServerMiscInformation(var InfoRec : ServerMiscInformation);
procedure GetSpecificCaptureFlags(Device : LPTNames;
                                  var Flags : PrintFlagInformation);
procedure GetStationAddress(var ThisNodeAddress : NodeAddress);
procedure GetVolumeInformation(VolNumber : byte;
                               var InfoRec : PhysicalVolumeInformation);
procedure GetVolumeInfoWithHandle(DirHandle : integer; var InfoRec : VolumeInformation);
procedure GetVolumeInfoWithNumber(VolNumber : integer; var InfoRec : VolumeInformation);
procedure GetVolumeName(VolumeNumber : byte; var VolumeName : string15);
procedure GetVolumeNumber(VolumeName : string15;
                          var VolumeNumber : byte);
procedure GetWorkstationEnvironment(var EnvironmentInfo : WorkstationEnvironment);
function  IsObjectInSet(WhichObject : string47; WhatType : integer;
                        WhichProperty : string15;
                        MemberName : string47; MemberType : integer) : boolean;
procedure LockFileSet(TimeOutTics : integer);
procedure LockLogicalRecordSet(TimeOutTics : integer);
procedure LockPhysicalRecordSet(Mode : LockDirectives; TimeOutTics : integer);
function  LoggedHasConsolePrivileges : boolean;
procedure LogFile(FileName : string; Mode : LogModes; TimeOutTics : integer);
procedure LogLogicalRecord(RecordName : string99;
                           Mode : LogicalLockDirectives; TimeOutTics : integer);
procedure LogNetworkMessage(Message : string80);
procedure LogPhysicalRecord(FileHandle : word; Mode : LogicalLockDirectives;
                            RecordStartOffset, RecordLength : longint;
                            TimeOutTics : integer);
procedure LoginToFileServer(WhichObject : string47; WhatType : integer;
                            Password : string27);
procedure LogOut;
procedure LogOutFromFileServer(ConnectionID : integer);
function  LPTCaptureActive(var QueuingServerConnectionID : integer) : boolean;
procedure ModifyMaximumRightsMask(Directory : string; DirHandle : byte;
                                  RevokeRights, GrantRights : byte);
function  NumberOfLocalDrives : integer;
procedure OpenBindery;
procedure OpenMessagePipe(DestinationConnections : string100;
                          var InitialPipeStatus : string100);
procedure OpenSemaphore(SemaphoreName : string127; InitialValue : integer;
                        var SemaphoreHandle : longint; var OpenCount : integer);
function  PreferredConnectionID : integer;
function  PrimaryConnectionID : integer;
procedure PurgeAllErasedFiles;
procedure PurgeErasedFiles;
procedure ReadJobQueueEntry(QueueID : longint; JobNumber : integer;
                            var Job : JobEntryRecord);
procedure ReadPropertyValue(WhichObject : string47; WhatType : integer;
                            WhichProperty : string15; SegmentNumber : integer;
                            var Property;
                            var PropertyFlags : byte;
                            var MoreSegments  : boolean);
procedure ReadQueueCurrentStatus(QueueID : longint;
                                 var QueueStatus : byte;
                                 var NumberOfEntries : byte;
                                 var NumberOfServers : byte;
                                 var ServerIDList      : IDList;
                                 var ServerStationList : StationList);
procedure ReadServerCurrentStatus(QueueID,ServerID : longint;
                                  ServerStation : byte;
                                  var ServerStatus : ServerStatusType);
procedure ReleaseFile(FileName : string);
procedure ReleaseFileSet;
procedure ReleaseLogicalRecord(LogicalRecord : string99);
procedure ReleaseLogicalRecordSet;
procedure ReleasePhysicalRecord(FileHandle : word;
                            RecordStartOffset, RecordLength : longint);
procedure ReleasePhysicalRecordSet;
procedure RemoveJobFromQueue(QueueID : longint; JobNumber : integer);
procedure RenameDirectory(Directory : string; DirHandle : byte;
                          NewDirectory : string);
procedure RenameObject(WhichObject : string47; WhatType : integer;
                       NewName : string47);
procedure RestoreEraseFile(VolumeName : string16; DirHandle : byte;
                           var ErasedFilename, RestoredFilename : string);
procedure RestoreServersRights;
procedure ScanDirectoryForTrustees(Directory : string; DirHandle : byte;
                                   var SequenceNumber : byte;
                                   var FoundDirectory : string16;
                                   var OwnerID : longint;
                                   var CreationDate : longint;
                                   var FiveTrustees : TrusteeIDArray;
                                   var FiveRights   : TrusteeRightsArray);
procedure ScanDirectoryInfomation(Directory : string; DirHandle : byte;
                                  var SequenceNumber   : integer;
                                  var FoundDirectory   : string16;
                                  var OwnerID          : longint;
                                  var CreationDate     : longint;
                                  var MaximumRightsMask: byte);
procedure ScanFileInformation(FileName : string; DirHandle : byte;
                              SearchAttribute : byte;
                              var SequenceNumber : integer;
                              var FoundFile : string13;
                              var FileAttributes : byte;
                              var ExtendedAttributes : byte;
                              var FileSize : longint;
                              var OwnerID : longint;
                              var CreationDate : word;
                              var LastAccessDate : word;
                              var LastUpdateDate : longint;
                              var LastArchiveDate : longint);
procedure ScanObject(ScanMask : string47; ScanType : integer;
                     var LastSeen           : longint;
                     var FoundName          : string47;
                     var FoundType          : integer;
                     var FoundID            : longint;
                     var FoundFlag          : byte;
                     var FoundSecurity      : byte;
                     var FoundHasProperties : boolean);
procedure ScanObjectTrusteePaths(WhichVolume   : byte;
                                 WhichObjectID : longint;
                                 var LastSeen  : integer;
                                 var TrusteePath   : string;
                                 var TrusteeRights : byte);
procedure ScanProperty(WhichObject : string47; WhatType : integer;
                       ScanMask : string15;
                       var LastSeen       : longint;
                       var FoundName      : string15;
                       var FoundFlags     : byte;
                       var FoundSecurity  : byte;
                       var FoundHasValue  : boolean;
                       var MoreProperties : boolean);
procedure SendBroadcastMessage(Message : string55; Connections : string100;
                               var ResultCodes : string100);
procedure SendConsoleBroadcast(Message : string55; Connections : string100);
procedure SendPersonalMessage(Message : string126; ConnectionList : string100;
                              var ResultCodes : string100);
procedure ServiceQueueJob(QueueID : longint; TargetServiceType : integer;
                          var Job : JobEntryRecord);
procedure SetBannerUserName(BannerName : BannerArray);
procedure SetBroadcastMode(NewMode : BroadcastModes);
procedure SetCapturePrintJob(PrintQueueJobNumber : integer;
                             NetWareFileHandle : FileServerFileHandle;
                             Device : LPTNames);
procedure SetCapturePrintQueue(PrintQID : longint; Device : LPTNames);
procedure SetDefaultCaptureFlags(var CaptureInfo : CaptureFlags);
procedure SetDefaultLocalPrinter(Device : LPTNames);
procedure SetDirectoryHandle(SourceDirectory : string;
                             SourceDirHandle, TargetDirHandle : byte);
procedure SetDirectoryInformation(Directory : string; DirHandle : byte;
                                  NewOwner : longint; NewCreationDate : longint;
                                  MaximumRightsMask : byte);
procedure SetEndOfJobStatus(Mode : EndOfJobStatus);
procedure SetErrorMode(Mode : ErrorModes);
procedure SetExtendedFileAttributes(Filename : string; ExtendedAttributes : byte);
procedure SetFileInformation(Filename : string; DirHandle : byte;
                             SearchAttributes : byte;
                             FileAttributes,ExtendedAttributes : byte;
                             OwnerID : longint;
                             CreationDate,LastAccessDate : integer;
                             LastUpdateDate,LastArchiveDate : longint);
procedure SetFileServerDateAndTime(NewTime : ServerTimeRecord);
procedure SetLockMode(NewMode : LockModes);
procedure SetPreferredConnectionID(PreferredConnection : byte);
procedure SetPrimaryConnectionID(PrimaryConnection : byte);
procedure SetQueueCurrentStatus(QueueID : longint; QueueStatus : byte);
procedure SetServerCurrentStatus(QueueID : longint;
                                 var ServerStatus : ServerStatusType);
procedure SetSpecificCaptureFlags(Device : LPTNames;
                                   var CaptureInfo : CaptureFlags);
procedure SignalSemphore(SemaphoreHandle : longint);
procedure SpecifyCaptureFile(Filename : string; DirHandle : byte);
procedure StartLPTCapture;
procedure StartSpecificCapture(Device : LPTNames);
procedure SubmitAccountCharge(WhichObject : string47;
                              WhatType, ServiceType : integer;
                              Charge, CancelHoldAmount : longint;
                              CommentType : CommentTypes; Comment : string);
procedure SubmitAccountHold(WhichObject : string47; WhatType : integer;
                            AmountToReserve : longint);
procedure SubmitAccountNote(WhichObject : string47; WhatType : integer;
                            ServiceType : integer;
                            CommentType : CommentTypes; Comment : string);
procedure TTSAbortTransaction;
procedure TTSBeginTransaction;
procedure TTSEndTransaction(var ReferenceNumber : longint);
procedure TTSGetApplicationTresholds(var LogicalLockThreshold,
                                         PhysicalLockThreshold : byte);
procedure TTSGetWorkstationThresholds(var LogicalLockThreshold,
                                          PhysicalLockThreshold : byte);
function  TTSIsAvailable : boolean;
procedure TTSSetApplicationTresholds(LogicalLockThreshold,
                                     PhysicalLockThreshold : byte);
procedure TTSSetWorkstationThresholds(LogicalLockThreshold,
                                      PhysicalLockThreshold : byte);
procedure TTSTransactionStatus(TransactionReferenceNumber : longint);
procedure VerifyObjectPassword(WhichObject : string47; WhatType : integer;
                               Password : string127);
procedure WaitOnSemaphore(SemaphoreHandle : longint; TimeoutLimit : integer);
procedure WritePropertyValue(WhichObject : string47; WhatType : integer;
                             WhichProperty : string15; var PropertyValue;
                             SegmentNumber : integer; MoreSegments : boolean);}


{function  Attach(ServerName : string; LoginDrive : char) : integer;
procedure AddMemberToGroup(WhichObject : string47; WhatType : integer;
                           WhichGroup  : string47);
procedure Capture(WhichLPT : LPTNames;  WhichQueue : string;
                     FormNumber : shortint; Copies : integer;
                     TabSize : shortint; BannerTitle,BannerName : BannerArray;
                     MaxLines,MaxColumns : integer;
                     PrintBanner,DoFormFeed,Keep,AutoEndCap : boolean;
                     TimeOutValue : integer);
procedure DOSPathToNetworkPath(DOSPath : string; var ServerName,Volume,Path : string);
procedure EndCap(WhichLPT : LPTNames);
function  FileServerName(ConnectionID : integer) : string;
procedure Flag(AFile : string; ChangeMethod : FlagMethods; Attribs,ExAttribs : byte);
function  FullName(WhichObject : string47; WhatType : integer) : string;
procedure GetObjectLoginControl(WhichObject : string47; WhatType : integer;
                                var LoginInfo : LoginControlRecord);
procedure Map(DriveLetter : char; NetworkPath : string);
procedure MapDel(DriveLetter : char);
procedure MapTemporary(TempNumber : integer; NetworkPath : string);
procedure NFSplit(NetPath : string; var ServerName,Volume,Path,Name,Extent : string);
function  ObjectCanLoginAt(LoginInfo : LoginControlRecord;
                          Day,Hour,Minute : byte) : boolean;
procedure OpenLoginScript(ConnectionID : integer; var ScriptFile : TEXT);
function  ObjectIDHexString(WhichObject : string47; WhatType : integer) : string;
procedure RemoveMemberFromGroup(WhichObject : string47; WhatType : integer;
                                WhichGroup  : string47);
function  ServerConnectionID(ServerName : string) : integer;
function  VolumeName(NetDrive : char) : string;}