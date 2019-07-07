uses filecopy;

var
     yes: Boolean;

begin
     yes := TFileCopy.CopyFile('snq.bak','b:\snq.bak',0);
     If yes then WriteLn
end.