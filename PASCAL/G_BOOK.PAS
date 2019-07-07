                                {Chris Sohns}
                                {Grade  Book}
                                 {Period  4}
                                  {Row  #2}



Program Grade_Book;

USES
     CRT;

VAR
     score, score2, score3, score4, score5, score6, score7, score8, score9,
     score10, number_of_grades, for1, counter, score_add: Integer;
     teacher_name, class, student_name, school, letter: String;

Begin
     ClrScr;
     counter := 0;
     score_add := 0;
Write('Wnter in the teacher''s name:  ');
     ReadLn(teacher_name);
     Write('Enter in the class name:  ');
     ReadLn(class);
     Write('Enter in the student''s name:  ');
     ReadLn(student_name);
     Write('Enter the school''s name:  ');
     ReadLn(school);
     ClrScr;
     Write('How many grades do you have to put in?  ');
     ReadLn(number_of_grades);
     ClrScr;
     For for1 := 1 to number_of_grades do
          Begin
               Write('Enter in the score:  ');
               ReadLn(score);
               While (score > 100) or (score < 0) do
                    Begin
                         WriteLn;
                         WriteLn('A number between 0 and 100');
                         Write('Enter in the score:  ');
                         ReadLn(score);
                    End;
          Case score of
               98..100: letter := 'A+';
               93..97: letter := 'A';
               90..93: letter := 'A-';
               88..89: letter := 'B+';
               83..87: letter := 'B';
               80..83: letter := 'B-';
               78..79: letter := 'C+';
               73..77: letter := 'C';
               70..73: letter := 'C-';
               68..69: letter := 'D+';
               63..67: letter := 'D';
               60..63: letter := 'D-';
               Else letter := 'F';
          End;
score_add := score_add + score;
          inc(counter,1);
     End;
          ClrScr;
          WriteLn(teacher_name:(80 div 2) - (Length(teacher_name) div 2));
          WriteLn;
          WriteLn(class:10, student_name:60);
          WriteLn;
          WriteLn(school:(80 div 2) - (Length(school) div 2));
          WriteLn;
          WriteLn('  ', score_add div counter, '%  ', letter);
          ReadLn;
End.