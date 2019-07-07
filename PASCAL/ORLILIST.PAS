{.}
                                                                 {Chris Sohns}
                                                                   {ORLILISTS}
                                                                    {02/16/96}
                     {Ordered Linker Lists using pointers}


Program Ordered_Linked_Listes;

uses
    crt, menu, dos;

type
    ptr = ^nodetype;
    nodetype = record
                     info: string[10];
                     next: ptr;
               end;

var
   node: ptr;
   start: ptr;
   curr: ptr;
   sel: Char;

{////////////////////////////////////////////////////////////////////////////}
  Procedure Status;
       Begin                        {Dysplays number of records and file name}
            GotoXY(1,24);
            c(15,2,4);
            Write('                                                                                ');
            GotoXY(1,24);
            Write('                                Free Mem = ', MemAvail, '                   ');
            c(7,2,0);
            GotoXY(1,1);
       End;
{////////////////////////////////////////////////////////////////////////////}
Function Find(start,curr,node:ptr; name:String): ptr;
     Var
          found: Boolean;
     Begin
          found := false;
          While (curr <> nil) and (NOT found) do
               Begin
                    If curr^.info = name then found := true
                       Else curr := curr^.next;
               End;
          If found then Find := curr
             Else Find := nil;
     End;
{////////////////////////////////////////////////////////////////////////////}
Function Find2(start,curr,node:ptr; name:String;var loc2:ptr): ptr;
     Var
          found: Boolean;
          prev: ptr;
     Begin
          found := false;
          prev := start;
          curr := start;
          While (curr <> nil) and (NOT found) do
               Begin
                    If name = curr^.info then
                         Begin
                              {WriteLn(name);
                              WriteLn(curr^.info);
                              ReadLn;}
                              found := true;
                              loc2 := prev;
                         End
                    Else Begin
                              prev := curr;
                              curr := curr^.next;
                         End;
               End;
          If found then Find2 := curr
             Else Find2 := nil;
     End;
{////////////////////////////////////////////////////////////////////////////}
Function Find3(start,curr,node:ptr; name:String;var loc2:ptr): ptr;
     Var
          found: Boolean;
          prev: ptr;
     Begin
          found := false;
          prev := start;
          curr := start;
          While (curr <> nil) and (NOT found) do
               Begin
                    If name < curr^.info then
                         Begin
                              {WriteLn(name);
                              WriteLn(curr^.info);
                              ReadLn;}
                              found := true;
                              loc2 := prev;
                         End
                    Else Begin
                              prev := curr;
                              curr := curr^.next;
                         End;
               End;
          If found then Find3 := curr
             Else Begin
                       loc2 := prev;
                       Find3 := nil;
                  End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Add(var start,curr,node:ptr);
     Var
          loc, loc2: ptr;
          name: String;
     Begin
          box(0,12,33,'Enter in name to enter:  ','O');
          c(15,2,1);
          ReadLn(name);
          If name <> '' then
          Begin
          new(node);
          node^.info := name;
          loc := Find3(start,curr,node,node^.info,loc2);
          If start = nil then
               Begin
                    node^.next := start;
                    {start^.next := node;}
                    start := node;
                    curr := start;
                    {WriteLn('start = nil');
                    ReadLn;}
               End
          Else If loc = loc2 then
                    Begin
                         node^.next := loc;
                         start := node;
                         curr := start;
                         {WriteLn('loc = loc2');
                         ReadLn;}
                    End
{          Else If loc = nil then
                    Begin
                         node^.next := loc2^.next;
                         loc2^.next := node;
                         WriteLn('loc = nil');
                         ReadLn;
                    End}
               Else If loc2 <> loc then
                         Begin
                              node^.next := loc;
                              loc2^.next := node;
                              {WriteLn(loc2^.info);
                              WriteLn(loc^.info);
                              WriteLn('loc2 <> loc');
                              ReadLn;}
                         End
          End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Print(start,curr,node:ptr);
     Begin
          ClrScr;
          While curr <> nil do
               Begin
                    WriteLn(curr^.info);
                    curr := curr^.next;
               End;
          Write('Press [ENTER] to continue. . .');
          ReadLn;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Search(start, curr, node:ptr);
     Var
          name: String;
          loc: ptr;
     Begin
          box(0,12,49,'What name will I look for?  ','O');
          c(15,2,1);
          ReadLn(name);
          loc := Find(start,curr,node,name);
          If loc <> nil then box(29,11,23,'Name has been found!!!!','O')
             Else box(27,11,27,'Name has NOT been found!!!!','O');
          Delay(2000);
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Delete(var start, curr, node:ptr);
     Var
          loc, loc2: ptr;
          name: String;
     Begin
          box(0,12,47,'Enter in name to delete:  ','O');
          c(15,2,1);
          ReadLn(name);
          loc := Find2(start,curr,node,name,loc2);
          If loc <> nil then
               Begin
               If start^.next = loc^.next then
                    Begin
                         start := loc^.next;
                         curr := start;
                         Dispose(loc);
                         {WriteLn('start = nil');
                         ReadLn;}
                    End
{          Else If loc = loc2 then
                    Begin
                         node^.next := loc;
                         start := node;
                         curr := start;
                         WriteLn('loc = loc2');
                         ReadLn;
                    End}
{          Else If loc = nil then
                    Begin
                         node^.next := loc2^.next;
                         loc2^.next := node;
                         WriteLn('loc = nil');
                         ReadLn;
                    End}
               Else If loc2 <> loc then
                         Begin
                              loc2^.next := loc^.next;
                              Dispose(loc);
                              {WriteLn(loc2^.info);
                              WriteLn(loc^.info);
                              WriteLn('loc2 <> loc');
                              ReadLn;}
                         End;
               End
          Else Begin
                    box(27,11,27,'Name has NOT been found!!!!','O');
                    Delay(2000);
               End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Begin
     ClrScr;
     start := nil;
     curr := start;
     node := nil;
     Repeat
          BackDrop;
          Status;
          Box(31,9,16,'   MAIN  MENU','B');
          Box(31,10,16,'','C');
          MenuCreator(31,11,11,'A','Add name','C');
          MenuCreator(31,12,11,'D','Delete name','C');
          MenuCreator(31,13,11,'S','Search list','C');
          MenuCreator(31,14,11,'P','Print list','C');
          MenuCreator(31,15,11,'Q','Quit','E');
          GotoXY(1,1);
          Repeat
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'A': Add(start, curr, node);
                    'D': Delete(start, curr, node);
                    'S': Search(start, curr, node);
                    'P': Print(start, curr, node);
               End;
          Until (sel = 'A') or (sel = 'D') or (sel = 'S') or
                (sel = 'P') or (sel = 'Q');
     Until sel = 'Q';
End.