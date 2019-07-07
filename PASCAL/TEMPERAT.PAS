{.}
                                                                 {Chris Sohns}
                                                               {Temp HIGH LOW}
                                                                      {9/7/95}
                     {This program hav the user enter in  }
                     {the temperature for each hour, at   }
                     {records the HIGH and LOW temperature}


Program Temperature;

Uses
     CRT;

Type
     ArrayType = Array[1..24] of Real;

Var
     Temp :ArrayType;
     F    :Text;

{/////////////////////////////P R O C E D U R E S////////////////////////}

Procedure EnterValues(var temp: ArrayType; var F: Text);
     Var                        {enter in temperatures for each hour}
          lcv: Integer;

     Begin
          ReWrite(F);
          For lcv := 1 to 24 do
               Begin
                    Write('Enter in the temperatuer for hour #', lcv,': ');
                    ReadLn(Temp[lcv]);
                    WriteLn(F, Temp[lcv]:0:2);
               End; {loop}
     End; {EnterValues}

Procedure HighLow(var temp: ArrayType; var F: Text);
     Var                        {enter in temperatures for each hour}
          high,
          low     :Real;
          lcv,
          hightime,
          lowtime :Integer;

     Begin
          high := Temp[1];
          low := Temp[1];
          For lcv := 1 to 24 do
               Begin
                    If Temp[lcv] > high then
                         Begin
                              high := Temp[lcv];
                              hightime := lcv;
                         End {if then}
                    Else If Temp[lcv] < low then
                              Begin
                                   low := Temp[lcv];
                                   lowtime := lcv;
                              End; {if then else}
               End; {loop}
          WriteLn(F, '');
          WriteLn(F, 'The high was ', high:0:2, 'ø, at ', hightime,'.');
          WriteLn(F, 'The low was ', low:0:2, 'ø, at ', lowtime,'.');
          Close(F);
          WriteLn;
          WriteLn('The high was ', high:0:2, 'ø, at ', hightime,'.');
          WriteLn('The low was ', low:0:2, 'ø, at ', lowtime,'.');
     End; {HighLow}

{/////////////////////////////F U N C T I O N S//////////////////////////}

Function TempAverage(var Temp: ArrayType):Real;
     Var                      {calculates the average of the temperatures}
          Sum :Real;
          lcv :Integer;

     Begin
          Sum := 0;
          For lcv := 1 to 24 do
               sum := sum + Temp[lcv]; {end loop}
          TempAverage := sum / 24;
     End; {TempAverage}

{/////////////////////////M A I N//P R O G R A M/////////////////////////}

Begin  {main}
     ClrScr;
     Assign(F, 'c:\temperat.dat');
     EnterValues(temp, F);
     HighLow(temp, F);
     Append(F);
     WriteLn(F, 'The average temperature was: ', TempAverage(Temp):0:2, 'ø.');
     Close(F);
     WriteLn('The average temperature was: ', TempAverage(Temp):0:2, 'ø.');
     ReadLn;
End.  {main}