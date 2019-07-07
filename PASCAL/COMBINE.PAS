Procedure Combine(var start,curr,node:ptr);
     Var
          C1, C2, T1, T2: ptr;
     Begin
          C1 := S1;
          C2 := S2;
          T1 := C1;
          T2 := T2;
          curr := start;
          If (S1 <> nil) or (S2 <> nil) then
               Begin
                 While (C1 <> nil) and (C2 <> nil) do
                    Begin
                         If C1^.info < C2^.info then
                              Begin
                                   new(node);
                                   node^.info := C1^.info;
                                   If start = nil then
                                        Begin
                                             node^.next := start;
                                             start := node;
                                             curr := start;
                                        End
                                   Else Begin
                                             node^.next := nil;
                                             curr^.next := node;
                                             curr := node;
                                        End;
                                   T1 := C1;
                                   C1 := C1^.next;
                                   Dispose(T1);
                              End
                         Else Begin
                                   new(node);
                                   node^.info := C2^.info;
                                   If start = nil then
                                        Begin
                                             node^.next := start;
                                             start := node;
                                             curr := start;
                                        End
                                   Else Begin
                                             node^.next := nil;
                                             curr^.next := node;
                                             curr := node;
                                        End;
                                   T2 := C2;
                                   C2 := C2^.next;
                                   Dispose(T2);
                              End;  (*IF*)
                    End;  (*WHILE*)
                 If (S1 = nil) or (C1 = nil) then do
                      Begin
                           curr^.next := C2;
                           S2 := nil;
                      End;
                 Else Begin
                           curr^.next := C1;
                           S1 := nil;
                      End;
                 End; (*IF*)
     End;