{.}
                                                                 {Chris Sohns}
                                                                        {code}
                                                                      {9/7/95}
                     {This program counts the number of}
                     {occurances of each letter in a file.}


Program code;

Uses
     CRT;

Type
     Alpha = Array['A'..'Z'] of Integer;

Var
     Fname  :String;
     Bet    :Alpha;

{/////////////////////////////P R O C E D U R E S////////////////////////}

Procedure InitArray(var List :Alpha);  {Initalizes BET array}
     Var
          lcv :Char;

     Begin
          For lcv := 'A' to 'Z' do
               List[lcv] := 0;
     End; {InitArray}

{////////////////////////////////////////////////////////////////////////}

Procedure EnterFileName(var File_Name :String);  {enter in file name to scan}
     Begin
          Write('Enter in the name of a file: ');
          ReadLn(File_Name);
     End; {EnterFileName}

{////////////////////////////////////////////////////////////////////////}

Procedure DataPR(var Bet:Alpha; var FileName:String);
     Var                        {prints results of file scan}
          lcv :Char;
          F   :Text;

     Begin
          Assign(F, 'c:\alpha.dat');
          ReWrite(F);
          WriteLn(F, FileName);
          WriteLn(FileName);
          For lcv := 'A' to 'Z' do
               If Bet[lcv] <> 0
                    then Begin
                              Write(F, lcv, '=', Bet[lcv], '  ');
                              Write(lcv, '=', Bet[lcv], '  ');
                         End;
          Close(F);
          ReadLn;
     End; {DataPR}

Procedure LetterCount(var List: Alpha; FileName: String);
     Var                               {counts up the number of letters}
          F      : Text;
          Letter : Char;
     Begin
          Assign(F, FileName);
          ReSet(F);
          While not EOF(F) do
               Begin
                    Read(F, letter);
                    If ((ORD(letter) > 64) and (ORD(letter) < 91) or
                                          (ORD(letter) > 96) and (ORD(letter)
                                          < 123))
                         then List[UpCase(letter)] := List[UpCase(letter)] + 1;
               End;
          Close(F);
     End;

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin  {main}
     ClrScr;
     InitArray(Bet);
     EnterFileName(fname);
     LetterCount(Bet, fname);
     DataPR(Bet, fname);
End.  {main}