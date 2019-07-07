uses
    crt, menu, dos;

type
    ptr = ^nodetype;
    nodetype = record
                     info: string[10];
                     next: ptr;
                     last: ptr;
               end;

var
   node: ptr;
   start: ptr;
   curr: ptr;
   prev: ptr;
   sel: Char;


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
     Begin
          found := false;
          While (curr <> nil) and (NOT found) do
               Begin
                    If curr^.info = name then
                       Begin
                            found := true;
                            loc2 := curr^.last;
                       End
                    Else curr := curr^.next;
               End;
          If found then Find2 := curr
             Else Find2 := nil;
     End;
{////////////////////////////////////////////////////////////////////////////}
Function nextnode(node:ptr):ptr;
     Begin
          new(node);
          nextnode := node;
          dispose(node);
     End;
{////////////////////////////////////////////////////////////////////////////}
Procedure Add(var start,curr,node:ptr);
     Begin
          new(node);
          prev := nextnode(node);
          box(0,12,33,'Enter in name to enter:  ','O');
          c(15,2,1);
          ReadLn(node^.info);
          {flush(output);}
          node^.next := start;
          node^.last := prev;
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
                  start := loc^.last;
                  curr := start;
                  loc^.last^.next := loc^.next;
                  dispose(loc);
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
     prev := nil;
     node := nil;
     Repeat
          BackDrop;
          MenuCreator(35,11,12,'A','Add a name','B');
          MenuCreator(35,12,12,'S','Search','C');
          MenuCreator(35,13,12,'P','Print list','C');
          MenuCreator(35,13,12,'D','Delete name','C');
          MenuCreator(35,14,12,'Q','Quit','E');
          GotoXY(1,1);
          Repeat
               Repeat
                    sel := ReadKey;
               Until sel <> '';
               sel := UpCase(sel);
               Case sel of
                    'A': Add(start, curr, node);
                    'S': Search(start, curr, node);
                    'P': Print(start, curr, node);
                    'D': Delete(start, curr, node);
               End;
          Until (sel = 'A') or (sel = 'P') or (sel = 'S') or
                (sel = 'D') or (sel = 'Q');
     Until sel = 'Q';
End.