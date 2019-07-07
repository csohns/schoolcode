{.}
                                                                 {Chris Sohns}
                                                                         {SNQ}
                                                                     {02/9/96}
                     {Basic stack and queue operations}
                     {using pointers.}


Program Stacks_and_Queus;

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
                    If curr^.info = name then
                         Begin
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
Function Find3(start,curr,node:ptr;var loc2:ptr): ptr;
     Var
          found: Boolean;
          prev: ptr;
     Begin
          found := false;
          prev := start;
          curr := start;
          While (curr <> nil) and (NOT found) do
               Begin
                    If curr^.next = nil then
                         Begin
                              found := true;
                              loc2 := prev;
                         End
                    Else Begin
                              prev := curr;
                              curr := curr^.next;
                         End;
               End;
          If found then Find3 := curr
             Else Find3 := nil;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Push(var start,curr,node:ptr);
     Begin
          new(node);
          box(0,12,33,'Enter in name to enter:  ','O');
          c(15,2,1);
          ReadLn(node^.info);
          {flush(output);}
          node^.next := start;
          start := node;
          curr := start;
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
Procedure Pop(var start, curr, node:ptr);
     Var
          loc, loc2: ptr;
          name: String;
     Begin
          box(0,12,47,'Enter in name to delete:  ','O');
          c(15,2,1);
          ReadLn(name);
          loc := Find(start,curr,node,name);
          If loc <> nil then
             Begin
                  {start := loc^.last;
                  curr := start;
                  loc^.last^.next := loc^.next;}
                  start := loc^.next;
                  curr := start;
                  dispose(loc);
             End
          Else Begin
                    box(27,11,27,'Name has NOT been found!!!!','O');
                    Delay(2000);
               End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure DeQ(var start, curr, node:ptr);
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
                  loc2^.next := loc^.next;
                  dispose(loc);
                  {If loc2^.next = nil then
                       begin
                            curr^.next := nil;
                       end;}
                  If (curr = loc) then
                       Begin
                            start := nil;
                            curr := start;
                            loc := nil;
                       End;
             End
          Else Begin
                    box(27,11,27,'Name has NOT been found!!!!','O');
                    Delay(2000);
               End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ClStack(var start, curr, node:ptr);
     Var
          loc: ptr;
          sel: Char;
     Begin
          box(0,12,45,'Are you sure you want to erase everything??  ','O');
          c(15,2,1);
          ReadLn(sel);
          If (sel = 'Y') or (sel = 'y') then
               While curr <> nil do
                    Begin
                         loc := curr;
                         start := curr^.next;
                         curr := start;
                         dispose(loc);
                    End;
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure ClQueue(var start, curr, node:ptr);
     Var
          loc, loc2: ptr;
          sel: Char;
     Begin
          box(0,12,45,'Are you sure you want to erase everything??  ','O');
          c(15,2,1);
          ReadLn(sel);
          If (sel = 'Y') or (sel = 'y') then
            Repeat
              loc := Find3(start,curr,node,loc2);
              If loc <> nil then
                 Begin
                      loc2^.next := loc^.next;
                      dispose(loc);
                      If (curr = loc) then
                           Begin
                                start := nil;
                                curr := start;
                                loc := nil;
                           End;
                 End;
            Until loc = nil;
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
          Box(31,4,16,'   MAIN  MENU','B');
          Box(31,5,16,'','C');
          Box(31,6,16,'Stack Functions','C');
          Box(31,7,16,'---------------','C');
          MenuCreator(31,8,11,'P','Push','C');
          MenuCreator(31,9,11,'O','Pop','C');
          MenuCreator(31,10,11,'C','Clear Stack','C');
          Box(31,11,16,'Queue Functions','C');
          Box(31,12,16,'---------------','C');
          MenuCreator(31,13,11,'E','EnQ','C');
          MenuCreator(31,14,11,'D','DeQ','C');
          MenuCreator(31,15,11,'L','Clear Queue','C');
          Box(31,16,16,'Extra Functions','C');
          Box(31,17,16,'---------------','C');
          MenuCreator(31,18,11,'R','Print list','C');
          MenuCreator(31,19,11,'Q','Quit','E');
          GotoXY(1,1);
          Repeat
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'P': Push(start, curr, node);
                    'E': Push(start, curr, node);
                    'S': Search(start, curr, node);
                    'R': Print(start, curr, node);
                    'O': Pop(start, curr, node);
                    'D': DeQ(start, curr, node);
                    'C': ClStack(start, curr, node);
                    'L': ClQueue(start, curr, node);
               End;
          Until (sel = 'P') or (sel = 'E') or (sel = 'S') or
                (sel = 'D') or (sel = 'O') or (sel = 'R') or
                (sel = 'C') or (sel = 'L') or (sel = 'Q');
     Until sel = 'Q';
End.