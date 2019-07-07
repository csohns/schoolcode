Unit ROLLDIE;

Interface

  Function D4: Integer;
  Function D6: Integer;
  Function D8: Integer;
  Function D10: Integer;
  Function D12: Integer;
  Function D20: Integer;
  Function Percintial: Integer;

Implementation

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

Begin
End.