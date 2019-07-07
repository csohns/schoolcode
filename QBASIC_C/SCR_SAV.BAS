1 'This is a TEST ONLY Screen Saver!!
DEFINT I-N
DEFSTR C
RANDOMIZE TIMER
5
s% = INT(RND * 2) + 1
IF s% = 1 THEN GOTO 6
IF s% = 2 THEN GOTO 20
6
CLS
COLOR 11, 0, 0
b1x = 40
b1y = 12
LOCATE b1y, b1x: PRINT "Û"
FOR k = 1 TO 8000: NEXT k
10
c1 = ""
b1xm = INT(RND * 3) - 1
b1ym = INT(RND * 3) - 1
IF b1xm = 0 AND b1ym = 0 THEN GOTO 10
DO WHILE (c1 = "") AND (b1x > 1) AND (b1x < 79) AND (b1y > 1) AND (b1y < 23)
  c1 = INKEY$
  b1x = b1x + b1xm
  b1y = b1y + b1ym
  LOCATE b1y - b1ym, b1x - b1xm: PRINT " "
  IF (b1x <= 2) AND (b1y <= 2) THEN b1x = b1x + 1: b1y = b1y + 1: GOTO 10
  IF (b1x <= 2) AND (b1y >= 23) THEN b1x = b1x + 1: b1y = b1y - 1: GOTO 10
  IF (b1x >= 78) AND (b1y <= 2) THEN b1x = b1x - 1: b1y = b1y + 1: GOTO 10
  IF (b1x >= 78) AND (b1y >= 23) THEN b1x = b1x - 1: b1y = b1y - 1: GOTO 10
  IF b1x <= 2 THEN b1x = b1x + 1: GOTO 10
  IF b1x >= 78 THEN b1x = b1x - 1: GOTO 10
  IF b1y <= 2 THEN b1y = b1y + 1: GOTO 10
  IF b1y >= 23 THEN b1y = b1y - 1: GOTO 10
  LOCATE b1y, b1x: PRINT "Û"
  REM LOCATE 1, 1: PRINT "X ="; b1x; " "; b1xm
  REM LOCATE 2, 1: PRINT "Y ="; b1y; " "; b1ym
  FOR k = 1 TO 800: NEXT k
LOOP
IF c1 <> "" THEN GOSUB 2000000
GOTO 10
20
COLOR 0, 0: SCREEN 9
c% = INT(RND * 15) + 1
x = INT(RND * 639) + 1
y = INT(RND * 379) + 1
a = INT(RND * 639) + 1
b = INT(RND * 379) + 1
COLOR c%
LINE (x, y)-(a, b)
c1 = INKEY$: IF c1 = "" THEN GOTO 20
2000000
SCREEN 0
CLS
c1 = ""
COLOR 14, 1: time = 0
LOCATE 10, 15: PRINT "ษอออออออออออออออออออออออออออออออออออออออออออออออออป"
LOCATE 11, 15: PRINT "บ                                                 บ"
LOCATE 12, 15: PRINT "บ           Enter Registration Password!          บ"
LOCATE 13, 15: PRINT "บ                                                 บ"
16 LOCATE 14, 15: PRINT "บ  Please Enter Password: ";
LOCATE 14, 41: PRINT "                        บ"
LOCATE 15, 15: PRINT "บ                                                 บ"
LOCATE 16, 15: PRINT "ศอออออออออออออออออออออออออออออออออออออออออออออออออผ"
COLOR 15, 1: LOCATE 16, 49: PRINT " Force Command ": COLOR 14, 1
REM LOCATE 12, 15: PRINT "Please enter the secret password :";
LOCATE 14, 41
cstr = ""
800 c1 = INKEY$: IF c1 = "" GOTO 800
j = ASC(c1): IF j = 13 GOTO 900
REM IF j > 96 AND j < 123 THEN j = j - 32 'Convert to uppercase
cstr = cstr + CHR$(j): PRINT "*"; : GOTO 800
900 IF cstr = "ForCe1189dfhJKlsd" GOTO 160
IF cstr = "Power Access" GOTO 160
LOCATE 14, 18: BEEP
IF time = 2 THEN GOTO 210
PRINT "Invalid Password.  Press any key to continue.": time = time + 1
810 c1 = INKEY$: IF c1 = "" GOTO 810
LOCATE 14, 18: PRINT "                                            "
GOTO 16
160 REG = 1: LOCATE 22, 15
LOCATE 12, 18: PRINT "                                              "
LOCATE 14, 18: PRINT "                                              "
COLOR 30, 1: LOCATE 13, 18: PRINT "UnLocking . . .": FOR k = 1 TO 10000: NEXT k
FOR i = 1 TO 17
FOR k = 1 TO 8000: NEXT k
COLOR 14, 1: LOCATE 13, 34: IF i = 1 THEN PRINT "|"
LOCATE 13, 34: IF i = 2 THEN PRINT "/"
LOCATE 13, 34: IF i = 3 THEN PRINT "-"
LOCATE 13, 34: IF i = 4 THEN PRINT "\"
LOCATE 13, 34: IF i = 5 THEN PRINT "|"
LOCATE 13, 34: IF i = 6 THEN PRINT "/"
LOCATE 13, 34: IF i = 7 THEN PRINT "-"
LOCATE 13, 34: IF i = 8 THEN PRINT "\"
LOCATE 13, 34: IF i = 9 THEN PRINT "|"
LOCATE 13, 34: IF i = 10 THEN PRINT "/"
LOCATE 13, 34: IF i = 11 THEN PRINT "-"
LOCATE 13, 34: IF i = 12 THEN PRINT "\"
LOCATE 13, 34: IF i = 13 THEN PRINT "|"
LOCATE 13, 34: IF i = 14 THEN PRINT "/"
LOCATE 13, 34: IF i = 15 THEN PRINT "-"
LOCATE 13, 34: IF i = 16 THEN PRINT "\"
LOCATE 13, 34: IF i = 17 THEN PRINT "|"
NEXT i
LOCATE 13, 34: IF i = 18 THEN PRINT "/"
LOCATE 13, 34: IF i = 19 THEN PRINT "-"
LOCATE 13, 34: IF i = 20 THEN PRINT "\"
LOCATE 13, 34: IF i = 21 THEN PRINT "|"
LOCATE 13, 34: IF i = 22 THEN PRINT "/"
LOCATE 13, 34: IF i = 23 THEN PRINT "-"
LOCATE 13, 34: IF i = 24 THEN PRINT "\"
LOCATE 13, 34: IF i = 25 THEN PRINT "|"
LOCATE 13, 34: IF i = 26 THEN PRINT "/"
LOCATE 13, 34: IF i = 27 THEN PRINT "-"
LOCATE 13, 34: IF i = 28 THEN PRINT "\"
LOCATE 13, 34: IF i = 29 THEN PRINT "|"
LOCATE 13, 34: IF i = 30 THEN PRINT "/"
LOCATE 13, 34: IF i = 31 THEN PRINT "-"
LOCATE 13, 34: IF i = 32 THEN PRINT "\"
LOCATE 13, 34: IF i = 33 THEN PRINT "|"
FOR i = 1 TO 41
LOCATE 13, 34: IF i = 34 THEN PRINT "/"
LOCATE 13, 34: IF i = 35 THEN PRINT "-"
LOCATE 13, 34: IF i = 36 THEN PRINT "\"
LOCATE 13, 34: IF i = 37 THEN PRINT "|"
LOCATE 13, 34: IF i = 38 THEN PRINT "/"
LOCATE 13, 34: IF i = 39 THEN PRINT "-"
LOCATE 13, 34: IF i = 40 THEN PRINT "\"
LOCATE 13, 34: IF i = 41 THEN PRINT "|"
NEXT i
FOR i = 1 TO 45
LOCATE 13, 34: IF i = 42 THEN PRINT "/"
LOCATE 13, 34: IF i = 43 THEN PRINT "-"
LOCATE 13, 34: IF i = 44 THEN PRINT "\"
LOCATE 13, 34: IF i = 45 THEN PRINT "|"
NEXT i
LOCATE 13, 34: IF i = 46 THEN PRINT "/"
LOCATE 13, 34: IF i = 47 THEN PRINT "-"
LOCATE 13, 34: IF i = 48 THEN PRINT "\"
LOCATE 13, 34: IF i = 49 THEN PRINT "|"
FOR i = 1 TO 8000: NEXT i
COLOR 30, 1: LOCATE 13, 34: PRINT "."
IF cstr = "Power Access" THEN REG = 2
FOR i = 1 TO 20000: NEXT i
GOTO 820
210 COLOR , 0: CLS : GOTO 5
REM 210 LOCATE 12, 18: PRINT "                                              "
REM LOCATE 14, 18: PRINT "                                              "
REM LOCATE 12, 18: PRINT "                Access Denied.               "
REM LOCATE 14, 18: PRINT "           Bombs have been disabled          "
REM 220 LOCATE 15, 18: PRINT "                                             "
REM SLEEP 4: REG = -1
820 COLOR 7, 0: CLS : END

