CLS
password$ = chr$(67)+chr$(79)+chr$(79)+chr$(76)
CLS
PRINT "Enter in your password:  ";
INPUT "", pass$
IF password$ = pass$ THEN PRINT "good" ELSE PRINT "bad"
INPUT "Press [ENTER] to continue. . ."; a$
END

