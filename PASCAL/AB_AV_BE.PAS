{.}
                                                                 {Chris Sohns}
                                                                    {Averages}
                                                                      {9/7/95}
                     {The user is asked to enter in a list}
                     {of 10 numbers. The average of the   }
                     {numbers is calculated. Then a data  }
                     {table is constructed displaying the }
                     {numbers and weather thay are greater}
                     {than, equal to, or less than the    }
                     {average.}


Program ABOVE_AVERAGE_BELOW;

Uses
     CRT;

Const
     NumberAmount = 10;

Type
     ArrayType = Array[1..NumberAmount] of Real;

Var
     Collection   :ArrayType;
     F            :Text;

{/////////////////////////////P R O C E D U R E S////////////////////////}

Procedure EnterValues(var Collection:ArrayType; var F:Text); 
     Var                                            {adds values to array}
          lcv :Integer;
     Begin
          ReWrite(F);
          For lcv := 1 to NumberAmount do
               Begin
                    Write('Enter in value #', lcv, ': ');
                    ReadLn(Collection[lcv]);
                    WriteLn(F, Collection[lcv]:0:2);
               End; {loop}
          Close(F);
          ClrScr;
     End;

{////////////////////////////////////////////////////////////////////////}
Procedure Average_Out(var AVG :Real; var Collection:ArrayType);
     Var                              {adds all the numbers together,}
          sum :Real;                  {devides by the amount of numbers.}
          lcv :Integer;

     Begin
          sum := 0;
          For lcv := 1 to NumberAmount do
               sum := sum + Collection[lcv]; {end loop}
          AVG := sum / NumberAmount;
     End;

{////////////////////////////////////////////////////////////////////////}
Procedure TableValues(var Collection:ArrayType; var F:Text); 
     Var                             {displays the data in an ordered fashion}
          average :Real;
          lcv     :Integer;

     Begin
          Average_Out(average, Collection);
          Append(F);
          WriteLn(F, 'The average is: ', average:0:2);
          WriteLn(F, '');
          WriteLn('The average is: ', average:0:2);
          WriteLn;
          For lcv := 1 to NumberAmount do
               Begin
                    Write(F, Collection[lcv]:0:2,'  ');
                    Write(Collection[lcv]:0:2,'  ');
                    If Collection[lcv] = average
                         then
                              Begin
                                   WriteLn(F, 'AVERAGE');
                                   WriteLn('AVERAGE');
                              End
                    Else If Collection[lcv] > average
                              then
                                   Begin
                                        WriteLn(F, 'ABOVE');
                                        WriteLn('ABOVE');
                                   End
                         Else Begin
                                   WriteLn(F, 'BELOW');
                                   WriteLn('BELOW');
                              End;
               End; {loop}
          Close(F);
          ReadLn;
     End;

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin (*MAIN*)
     ClrScr;
     Assign(F, 'c:\AB_AV_BE.dat');
     EnterValues(Collection, F);
     TableValues(Collection, F);
End. {main program}