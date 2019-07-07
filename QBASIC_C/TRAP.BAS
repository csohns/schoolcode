10 KEY 15, CHR$(4) + CHR$(70): REM Trap ^BREAK
20 KEY 16, CHR$(12) + CHR$(83): REM Trap system reset
30 ON KEY(15) GOSUB 1000
40 ON KEY(16) GOSUB 2000
50 KEY(15) ON
60 KEY(16) ON
70 INPUT A$
80 FOR I = 1 TO 2000: NEXT I
1000 PRINT "I'm sorry, I can't let you do that."
1010 RETURN
2000 ATTEMPTS = ATTEMPTS + 1
2010 ON ATTEMPTS GOTO 2100, 2200, 2300, 2400, 2500
2100 PRINT "Mary had a little lamb": RETURN
2200 PRINT "Its fleece was white as snow": RETURN
2300 PRINT "And erverywhere that Marry went": RETURN
2400 PRINT "The lamb was shure to go": RETURN
2500 KEY(16) OFF: REM If they hit us once more. . .
2510 RETURN: REM then BASIC dies. . .
