Program MAZE_STACKS;

Uses
     crt, dos;

Var
     MazeX, MazeY: Integer;

Procedure Play(MazeX, MazeY:Integer);

Const
     min = 1;
     max = 2000;

Type
     index_type = min..max;
     element_type = array[index_type] of Integer;
     stacktype = record
                       elements: Element_type;
                       top: 0..max;
                  end;
     Group = Array[1..24, 1..79] of Integer;

Var
     maze: Group;
     Stack: StackType;

Procedure InitMaze(var Maze:Group);
     Var
          lcv, lcv2: Integer;
     Begin
          For lcv := 1 to MazeY do
               For lcv2 := 1 to MazeX do
                    maze[lcv,lcv2] := 8;
     End;

Procedure CreateMaze(var Maze:Group);
     Var
          lcv, lcv2, wall, ExitX, ExitY: Integer;
     Begin
          Randomize;
          For lcv := 1 to MazeY do
               For lcv2 := 1 to MazeX do
                    Begin
                         wall := Random(4);
                         maze[lcv, lcv2] := wall;
                    End;
          ExitX := Random(MazeX) + 1;
          ExitY := Random(MazeY) + 1;
          Maze[ExitY, ExitX] := 8;
     End;

Procedure DrawMaze(var Maze:Group);
     Var
          lcv, lcv2: Integer;
     Begin
          For lcv := 1 to MazeY do
               Begin
                    For lcv2 := 1 to MazeX do
                         Begin
                              If (Maze[lcv,lcv2] >= 0) and (Maze[lcv,lcv2] < 3)
                                   then Begin
                                             TextColor(8);
                                             Write('±');
                                             TextColor(7);
                                        End;
                              If Maze[lcv,lcv2] = 3 then
                                   Begin
                                        TextColor(14);
                                        Write('²');
                                        TextColor(7);
                                   End;
                              If Maze[lcv,lcv2] = 8 then
                                   Begin
                                        TextColor(10);
                                        Write('E');
                                        TextColor(7);
                                   End;
                         End;
                    WriteLn;
               End;
     End;

Procedure ClearStack(Var Stack: StackType);
     Begin                      {sets stack counter to 0}
          Stack.Top := 0;
     End;

Function EmptyStack(Stack: StackType): Boolean;
     Begin                      {returns TRUE if stack is empty}
          EmptyStack := Stack.Top = 0;
     End;

Function FullStack(Stack: StackType): Boolean;
     Begin                      {returns TRUE if stack is full}
          FullStack := Stack.Top = max;
     End;

Procedure Push(VAR Stack: StackType; Value: Integer);
     Begin                      {adds data to stack}
          If NOT FullStack(Stack) then Begin
               Inc(Stack.Top);
               Stack.Elements[Stack.Top] := Value;
          End {IF}
     End;

Procedure Pop(Var Stack: StackType; Var Value: Integer);
     Begin                      {removes data from the stack}
          If NOT EmptyStack(Stack) then Begin
               Value := Stack.Elements[Stack.Top];
               Dec(Stack.Top);
          End; {IF}
     End;

Procedure Start(Var Maze:Group; Var Stack:StackType);
     Var
          X, Y, N, E, S, W, M: Integer;
          {Stack: StackType;}
  Procedure PlacePice(Var Maze:Group; Var X, Y:Integer);
       Begin
            Randomize;
            X := Random(MazeX) + 1;
            Y := Random(MazeY) + 1;
            {Maze[Y, X] := 6;}
       End;
  Procedure Scan(Var Maze:Group; Var X, Y, N, E, S, W:Integer; Var Stack:StackType);
       Var
            cntr: Integer;
            ReScan: Boolean;
       Begin
            Repeat
            ReScan := FALSE;
            cntr := 0;
            Case Maze[Y - 1, X] of
                 0..2, 8: Begin
                               N := 0;
                               If Y - 1 < 1 then N := 1
                                    Else inc(cntr);
                          End;
              Else N := 1;
            End;
            Case Maze[Y, X + 1] of
                 0..2, 8: Begin
                               E := 0;
                               If X + 1 > MazeX then E := 1
                                    Else inc(cntr);
                          End;
              Else E := 1;
            End;
            Case Maze[Y + 1, X] of
                 0..2, 8: Begin
                               S := 0;
                               If Y + 1 > MazeY then S := 1
                                    Else inc(cntr);
                          End;
              Else S := 1;
            End;
            Case Maze[Y, X - 1] of
                 0..2, 8: Begin
                               W := 0;
                               If X - 1 < 1 then W := 1
                                    Else inc(cntr);
                          End;
              Else W := 1;
            End;
            If cntr > 1 then
                 Begin
                      If NOT FullStack(Stack) then
                           Begin
                                Push(Stack, X);
                                Push(Stack, Y);
                           End;
                      If FullStack(Stack) then
                           Begin
                                GotoXY(1,25);
                                Write('Stack Overflow!!!!!!!!!!!!!!!!');
                                ClearStack(Stack);
                                Delay(2000);
                                ClrScr;
                                {Halt;}
                           End;
                 End;
            If cntr = 0 then
                 Begin
                      If NOT EmptyStack(Stack) then
                           Begin
                                GotoXY(X, Y);
                                TextColor(15);
                                Write('ù');
                                TextColor(7);
                                Maze[Y, X] := 6;
                                Pop(Stack, Y);
                                Pop(Stack, X);
                                ReScan := TRUE;
                           End;
                      If EmptyStack(Stack) then
                           Begin
                                GotoXY(1,25);
                                Write('No Soultion!!!!!!!!!!!!!!!!');
                                ClearStack(Stack);
                                Delay(2000);
                                ClrScr;
                                {Halt;}
                           End;
                 End;
            Until ReScan = FALSE;
       End;

    Begin
          ClearStack(Stack);
          N := 1;
          E := 1;
          S := 1;
          W := 1;
          M := 0;
          PlacePice(Maze, X, Y);
          Repeat
               Scan(Maze, X, Y, N, E, S, W, Stack);
               If N = 0 then M := 1
                    Else If E = 0 then M := 2
                         Else If S = 0 then M := 3
                              Else If W = 0 then M := 4;
               Maze[Y, X] := 6;
               TextColor(15);
               GotoXY(X, Y);
               Write('ù');
               TextColor(7);
               Case M of
                    1: dec(Y);
                    2: inc(X);
                    3: inc(Y);
                    4: dec(X);
               End;
               TextColor(12);
               GotoXY(X, Y);
               Write(Char(1));
               TextColor(7);
               Delay(20);
          Until (Maze[Y, X] = 8) or (M = 0) or (EmptyStack(Stack))
               or (FullStack(Stack));
          ClearStack(Stack);
     End;


Begin
     ClrScr;
     InitMaze(Maze);
     CreateMaze(Maze);
     DrawMaze(Maze);
     Start(Maze, Stack);
     {ReadLn;}
End;

Begin
     Randomize;
     Repeat
     MazeX := Random(79) + 1;
     MazeY := Random(24) + 1;
     Play(MazeX, MazeY);
     GotoXY(1,1);
     Delay(2000);
     Until Keypressed;
End.