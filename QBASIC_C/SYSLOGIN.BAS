10
CLS
rem INPUT "Enter in your name:  ", a$
OPEN "c:\syslog.dat" FOR APPEND AS #1
PRINT #1, "Login on "; DATE$; " at "; TIME$
CLOSE #1
END

