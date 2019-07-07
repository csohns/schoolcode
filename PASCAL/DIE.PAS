Program Dice_Rolling_Program;

Uses CRT, DOS;

Function D4: Integer;
  Begin
    Randomize;
    D4 := (random(4) + 1);
  End;

Function D6: Integer;
  Begin
    Randomize;
    D6 := (random(6) + 1);
  End;

Function D8: Integer;
  Begin
    Randomize;
    D8 := (random(8) + 1);
  End;

Function D10: Integer;
  Begin
    Randomize;
    D10 := (random(10) + 1);
  End;

Function D12: Integer;
  Begin
    Randomize;
    D12 := (random(12) + 1);
  End;

Function D20: Integer;
  Begin
    Randomize;
    D20 := (random(20) + 1);
  End;

Function Percintial: Integer;
  Begin
    Randomize;
    Percintial := (random(100) + 1);
  End;

Var
  sel: Char;
Begin
    ClrScr;
    Repeat
      WriteLn;
      WriteLn('1)  4  sided die');
      WriteLn('2)  6  sided die');
      WriteLn('3)  8  sided die');
      WriteLn('4)  10 sided die');
      WriteLn('5)  12 sided die');
      WriteLn('6)  20 sided die');
      WriteLn('7)   % (100) sided die');
      WriteLn;
      WriteLn('8)  Quit');
      WriteLn;
      Repeat
        sel := ReadKey;
      Until sel <> '';
      TextColor(14);
      Case sel of
        '1':  WriteLn(D4);
        '2':  WriteLn(D6);
        '3':  WriteLn(D8);
        '4':  WriteLn(D10);
        '5':  WriteLn(D12);
        '6':  WriteLn(D20);
        '7':  WriteLn(Percintial);
      End;
      TextColor(7);
    Until sel = '8';
End.