Program Chess;

Type
     ChessPices = (Pawn, Rook, Knight, Bishop, Queen, King);
     ChessType  = Array[Pawn..King] of integer;

Var
     Value: ChessType;

Begin
     Value[Pawn]   := 1;
     Value[Rook]   := 5;
     Value[Knight] := 3;
     Value[Bishop] := 4;
     Value[Queen]  := 9;
     Value[King]   := 1000;
End.