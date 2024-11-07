DECLARE SUB WelcomeScreen ()
DECLARE SUB ShowCursor ()
DECLARE SUB RepeatKeys (RepeatString AS STRING, NumHelpPasses AS INTEGER)
DECLARE SUB PracticeTyping ()
DECLARE SUB DrawKeyboard ()
DECLARE SUB AddKey (keystroke AS STRING)

ON ERR GOTO ErrorHandler
ON ERROR GOTO ErrorHandler

DIM SHARED num AS STRING: num = "1234567890-="
DIM SHARED qwe AS STRING: qwe = "QWERTYUIOP[]"
DIM SHARED asd AS STRING: asd = "ASDFGHJKL;'"
DIM SHARED zxc AS STRING: zxc = "ZXCVBNM,./"

DIM SHARED RowOfKeys AS STRING

DIM SHARED br, bc AS INTEGER: br = 7: bc = 0
DIM SHARED r, c AS INTEGER: r = br: c = bc

DIM SHARED keywindow AS STRING * 70

CLS
CALL WelcomeScreen

CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "   This first exercise will show you how the program works.  Just type any"
PRINT "alphabetic or numeric keys, and they will be highlighted when struck.  The"
PRINT "key will also show up in the boxes below.  The small box will show the key"
PRINT "key that you just hit (or sometimes the next key that you should hit). The"
PRINT "longer box will show the cumulative keystrokes that you have hit.  When"
PRINT "you are done with this exercise you can leave it by pressing the ESC key as"
PRINT "noted below.  The ESC key stands for Escape, and it is normally used to exit."

CALL PracticeTyping


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT " This exercise will show you the two HOME keys 'j' and 'f'.  These are the"
PRINT "  two keys where you should normally rest your RIGHT and LEFT FOREFINGERS."
PRINT "Press the key when it is highlighted and notice that the program will then"
PRINT "highlight the next key and show it in the boxes as well.  For this and for"
PRINT "all of the other exercises, you should try to use the proper finger to hit"
PRINT " the highlighted key.  Start off working for accuracy and then build speed."
PRINT "Note that after 10 passes, the higlighting will disappear - follow the box."

CALL RepeatKeys("jf", 10)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT " This exercise will show you the rest of the HOME keys along with the space"
PRINT " bar.  The HOME keys for the right hand start with the fore finger on 'j',"
PRINT "and continue with the middle finger on 'k', the ring finger on 'l', and the"
PRINT "little finger on ';'.  Similarly, the left forefinger starts on 'f', and the"
PRINT "the remaining fingers follow with the middle finger on 'd', the ring finger"
PRINT "on 's', and the little finger on 'a'.  Each of these fingers should return to"
PRINT "their home keys when not in use.  Either thumb can be used for the space bar."

CALL RepeatKeys("jkl;fdsa j f j f k d k d l s l s ; a ; a jf dk ls a; asdf ;lkj fjdksla; ", 10)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your right"
PRINT " forefinger.  These keys are: j u y h n m.  You will notice that these keys"
PRINT " start with the home key 'j' and move counter clockwise through the letters."
PRINT "If you make a mistake, the computer will beep.  Just try again and keep going."
PRINT "The program will only highlight the first 3 passes.  After that follow the box."
PRINT "  You should try to hit all the keys without looking down at your fingers."
PRINT "   Keep practicing until you can do them all several times without error."

CALL RepeatKeys("juyhnm", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT " This exercise will show you all the keys that are assigned to your left"
PRINT "forefinger.  These keys are: f r t g b v.  You will notice that these keys"
PRINT " start with the home key 'f' and circulate clockwise through the letters."
PRINT " You should try to hit all the keys without looking down at your fingers."
PRINT "  Keep practicing until you can do them all several times without error."
PRINT "As before, the highlighting will only last for the first three passes. After"
PRINT "that, you should focus on the center box which will show you the next key."

CALL RepeatKeys("frtgbv", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT " This exercise will help you move from the right home key 'j' to all of the"
PRINT " other right forefinger keys (u y h n m).  You will notice that these keys"
PRINT " start with the home key 'j' and move counter clockwise through the letters."
PRINT "If you make a mistake, the computer will beep.  Just try again and keep going."
PRINT "  You should try to hit all the keys without looking down at your fingers."
PRINT "   Keep practicing until you can do them all several times without error."

CALL RepeatKeys("jujyjhjnjm", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will help you move from the left home key 'f' to all of the"
PRINT " other left forefinger keys (r t g b v).  You will notice that these keys"
PRINT "  start with the home key 'f' and circulate clockwise through the letters."
PRINT "If you make a mistake, the computer will beep.  Just try again and keep going."
PRINT "  You should try to hit all the keys without looking down at your fingers."
PRINT "   Keep practicing until you can do them all several times without error."

CALL RepeatKeys("frftfgfbfv", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will help you memorize the locations of your right forefinger"
PRINT " keys.  The letters will be randomly chosen from the right forefinger letters"
PRINT "(j u y h n m).  As before, you should try NOT to look at your fingers.  Instead"
PRINT "  you should try to remember where the keys are relative to the home key 'j'."
PRINT "Note that the forefinger home keys (j and f) will usually have a raised bump on"
PRINT "them that will help you find them without looking.  Try to find them by feel"
PRINT "  and keep practicing until you are confident that you can find all the keys."

CALL RepeatKeys("jhynujymymmynujynujhnujymymhnmhmujmnujjymhyhnujyhnujymmnujyhnujmhhymymhnujyhnujnumhymhnu", 0)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will help you memorize the locations of your left forefinger"
PRINT " keys.  The letters will be randomly chosen from the left forefinger letters"
PRINT "(f r t g b v).  As before, you should try NOT to look at your fingers.  Instead"
PRINT "  you should try to remember where the keys are relative to the home key 'j'."
PRINT "Note that the forefinger home keys (j and f) will usually have a raised bump on"
PRINT "them that will help you find them without looking.  Try to find them by feel"
PRINT "  and keep practicing until you are confident that you can find all the keys."

CALL RepeatKeys("ftvgrbvgfgffgfgfvftrtbbrtgfvvgttrbtbrtvrbftvgrbvrfrbvtgvgfvgtgrbvtrbtbrtvfvgfvgtrbrbftvgrbv", 0)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your right"
PRINT "  middle finger.  These keys are: k i and , (comma).  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("kik,", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your left"
PRINT "    middle finger.  These keys are: d, e, and c.  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("dedc", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your right"
PRINT "  ring finger.  These keys are: l, o, and . (period).  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("lol.", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your left"
PRINT "     ring finger.  These keys are: s, w, and x.  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("swsx", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your right"
PRINT "    little finger.  These keys are: ;, p, and /.  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys(";p;/", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the keys that are assigned to your left"
PRINT "    little finger.  These keys are: a, q, and z.  You will notice that"
PRINT "   this row of keys is slanted to the upper left.  This is true of all key"
PRINT "assignments on both hands.  They always slant to the upper left.  As before,"
PRINT "  you should try to hit all the keys without looking down at your fingers."
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("aqaz", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise will show you all the number assignments.  As before, the"
PRINT " assignments slant to the upper left, so that your index fingers will hit"
PRINT "numbers 4 and 5 on the left hand, and 6 and 7 on the right hand.  Similarly,"
PRINT "your middle finger will hit 3 on the left and 8 on the right.  Your ring"
PRINT "finger will hit 2 on the left and 9 on the right.  Your little finger will"
PRINT "hit 1 on the left and 0 on the right.  NOTE: Use the 1 and 0 (not l and O)"
PRINT "    Keep practicing until you can do them all repeatedly without error."

CALL RepeatKeys("j6j7jf5f4fk8kd3dl9ls2s;0;a1a", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "This exercise will force you to use all of the alphabetic keys to type a"
PRINT "real sentence.  As with the earlier exercises, you should try to hit each"
PRINT " key with the proper finger while watching the screen (not you fingers)."
PRINT " This sentence will also require you to use the space bar between words,"
PRINT " and also between sentences.  Be sure to press the space bar when needed."
PRINT "    Keep practicing until you can type this sentence without errors."

CALL RepeatKeys("The quick brown fox jumps over the lazy dog. ", 3)


CLS
CALL DrawKeyboard

LOCATE 1, 1, 0
PRINT "  This exercise allows you to practice your typing skills.  You may type"
PRINT " anything that comes to mind and it will appear in the text window at the"
PRINT "  bottom of the screen.  You might try repeating the following sentence:"
PRINT " "
PRINT "                 The quick brown fox jumps over the lazy dog."

CALL PracticeTyping


LOCATE 24, 1, 0

END

ErrorHandler:
  CLS
  SYSTEM
  END

SUB AddKey (keystroke AS STRING)
  IF ASC(keystroke) = 8 THEN
    MID$(keywindow, 2) = MID$(keywindow, 1, 69)
    MID$(keywindow, 1, 1) = " "
    LOCATE 20, 39, 0
    PRINT " ";
  ELSE
    keywindow = MID$(keywindow, 2)
    MID$(keywindow, 70, 1) = keystroke
    LOCATE 20, 39, 0
    PRINT keystroke;
  END IF
  LOCATE 22, 4, 0
  PRINT keywindow;
  CALL ShowCursor
END SUB

SUB DrawKeyboard

  DIM vv AS STRING * 1: vv = CHR$(179)
  DIM hh AS STRING * 1: hh = CHR$(196)
  DIM tu AS STRING * 1: tu = CHR$(193)
  DIM td AS STRING * 1: td = CHR$(194)
  DIM tl AS STRING * 1: tl = CHR$(180)
  DIM tr AS STRING * 1: tr = CHR$(195)
  DIM ll AS STRING * 1: ll = CHR$(192)
  DIM lr AS STRING * 1: lr = CHR$(217)
  DIM ul AS STRING * 1: ul = CHR$(218)
  DIM ur AS STRING * 1: ur = CHR$(191)
  DIM xx AS STRING * 1: xx = CHR$(197)
  DIM ss AS STRING * 1: ss = " "

  DIM svv AS STRING * 1: svv = CHR$(179)
  DIM shh AS STRING * 1: shh = CHR$(196)
  DIM stu AS STRING * 1: stu = CHR$(193)
  DIM std AS STRING * 1: std = CHR$(194)
  DIM stl AS STRING * 1: stl = CHR$(180)
  DIM str AS STRING * 1: str = CHR$(195)
  DIM sll AS STRING * 1: sll = CHR$(192)
  DIM slr AS STRING * 1: slr = CHR$(217)
  DIM sul AS STRING * 1: sul = CHR$(218)
  DIM sur AS STRING * 1: sur = CHR$(191)
  DIM sxx AS STRING * 1: sxx = CHR$(197)
  DIM sss AS STRING * 1: sss = " "


  vv = CHR$(186)
  hh = CHR$(205)
  tu = CHR$(202)
  td = CHR$(203)
  tl = CHR$(185)
  tr = CHR$(204)
  ll = CHR$(200)
  lr = CHR$(188)
  ul = CHR$(201)
  ur = CHR$(187)
  xx = CHR$(206)
  ss = " "

  ' First Draw all of the Key Borders
  r = 1

  FOR r = 1 TO 5
    IF r = 1 THEN
      RowOfKeys = num
    ELSEIF r = 2 THEN
      RowOfKeys = qwe
    ELSEIF r = 3 THEN
      RowOfKeys = asd
    ELSE
      RowOfKeys = zxc
    END IF
    IF r = 1 THEN
      LOCATE br + (r * 2) - 1, bc + (r * 3) - 2, 0
    ELSE
      LOCATE br + (r * 2) - 1, bc + (r * 3) - (2 + 3), 0
      PRINT ll; hh; hh;
    END IF
    IF r = 1 THEN
      PRINT ul;
    ELSEIF r < 5 THEN
      PRINT td;
    ELSE
      PRINT hh;
    END IF
    FOR c = 1 TO LEN(RowOfKeys)
      IF r = 1 THEN
        IF c = LEN(RowOfKeys) THEN
          PRINT hh; hh; hh; hh; hh; ur;
        ELSE
          PRINT hh; hh; hh; hh; hh; td;
        END IF
      ELSEIF r = 5 THEN
        IF c < LEN(RowOfKeys) THEN
          PRINT hh; hh; tu; hh; hh; hh;
        END IF
      ELSE
        IF c = LEN(RowOfKeys) THEN
          PRINT hh; hh; tu; hh; hh; ur;
        ELSE
          PRINT hh; hh; tu; hh; hh; td;
        END IF
      END IF
    NEXT c
    IF (r < 5) THEN
      LOCATE br + (r * 2) + 1 - 1, bc + (r * 3) - 2, 0
      FOR c = 1 TO LEN(RowOfKeys)
        IF c = LEN(RowOfKeys) THEN
          PRINT vv; "  "; MID$(RowOfKeys, c, 1); "  "; vv;
        ELSE
          PRINT vv; "  "; MID$(RowOfKeys, c, 1); "  ";
        END IF
      NEXT c
    END IF

  NEXT r

  ' Finish Drawing the Key Borders

  FOR r = 2 TO 4
    IF r = 1 THEN
      RowOfKeys = num
    ELSEIF r = 2 THEN
      RowOfKeys = qwe
    ELSEIF r = 3 THEN
      RowOfKeys = asd
    ELSE
      RowOfKeys = zxc
    END IF
    c = LEN(RowOfKeys) - 1
    LOCATE br + ((r + 1) * 2) - 1, bc + (c * 6) + ((r + 1) * 3) - 2, 0
    IF r = 4 THEN
      PRINT hh; hh; hh; lr;
    ELSE
      PRINT td; hh; hh; lr;
    END IF
  NEXT r

  ' Draw in the Space Bar

  REM LOCATE 16, 18, 0
  REM PRINT ul;
  REM FOR c = 0 TO 41
    REM PRINT hh;
  REM NEXT c
  REM PRINT ur;
 
  LOCATE 16, 19, 0
  PRINT td;
  LOCATE 16, 61, 0
  PRINT td;
  LOCATE 17, 19, 0
  PRINT vv;
  FOR c = 0 TO 40
    PRINT ss;
  NEXT c
  PRINT vv;
  LOCATE 17, 35, 0
  PRINT "Space Bar";
  LOCATE 18, 19, 0
  PRINT ll;
  FOR c = 0 TO 40
    PRINT hh;
  NEXT c
  PRINT lr;


  ' Next draw a single border around the input area

  LOCATE 21, 2, 0
  PRINT sul;
  FOR c = 0 TO 71
    PRINT shh;
  NEXT c
  PRINT sur;
  LOCATE 22, 2, 0
  PRINT svv;
  FOR c = 0 TO 71
    PRINT sss;
  NEXT c
  PRINT svv;
  LOCATE 23, 2, 0
  PRINT sll;
  FOR c = 0 TO 71
    PRINT shh;
  NEXT c
  PRINT slr;

  ' Finally Draw a small box around the key character

  LOCATE 19, 37, 0
  PRINT sul; shh; shh; shh; sur;
  LOCATE 20, 37, 0
  PRINT svv; sss; sss; sss; svv;
  LOCATE 21, 37, 0
  PRINT stu; shh; shh; shh; stu;

END SUB

SUB PracticeTyping
  
  LOCATE 24, 1, 0
  PRINT "                            < Press ESC to go on >";
 
  DIM keystroke AS STRING
  DIM lastkey AS STRING
  DIM lastr AS INTEGER, lastc AS INTEGER
  DIM lasttime AS SINGLE
  DIM keylit AS INTEGER
  lastr = 1
  lastc = 1
  keylit = 0
  keystroke = ""
  keywindow = ""

  DO
    keystroke = INKEY$
  LOOP WHILE keystroke <> ""
  DO
    CALL ShowCursor
    keystroke = INKEY$
    IF keystroke = "" THEN

      IF ((TIMER - lasttime) > .2) AND (keylit > 0) THEN
        LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 3, 0
        PRINT " ";
        LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 1, 0
        PRINT " ";
        LOCATE 17, 33, 0
        PRINT " ";
        LOCATE 17, 45, 0
        PRINT " ";
        keylit = 0
      END IF
      CALL ShowCursor
                                            
    ELSEIF keystroke = " " THEN

      CALL AddKey(keystroke)
      LOCATE 17, 33, 0
      PRINT CHR$(16);
      LOCATE 17, 45, 0
      PRINT CHR$(17);
      lasttime = TIMER
      CALL ShowCursor
      keylit = 1

    ELSEIF ASC(keystroke) = 8 THEN

      CALL AddKey(keystroke)
      CALL ShowCursor

    ELSE

      LOCATE 17, 33, 0
      PRINT " ";
      LOCATE 17, 45, 0
      PRINT " ";
 
      LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 3, 0
      PRINT " ";
      LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 1, 0
      PRINT " ";
                                           
      FOR r = 1 TO 4
        IF r = 1 THEN
          RowOfKeys = num
        ELSEIF r = 2 THEN
          RowOfKeys = qwe
        ELSEIF r = 3 THEN
          RowOfKeys = asd
        ELSEIF r = 4 THEN
          RowOfKeys = zxc
        END IF
                                             
        FOR c = 1 TO LEN(RowOfKeys)
          IF UCASE$(MID$(keystroke, 1, 1)) = MID$(RowOfKeys, c, 1) THEN
            LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 3, 0
            PRINT CHR$(16);
            LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 1, 0
            PRINT CHR$(17);
            lastr = r
            lastc = c
            lasttime = TIMER
                                                 
            CALL AddKey(keystroke)

            keylit = 1
                                          
            REM PLAY "p2"
          END IF
        NEXT c
                                             
      NEXT r
     
      REM PLAY "l32a"
    END IF
   
    CALL ShowCursor

  LOOP UNTIL MID$(keystroke, 1, 1) = CHR$(27)
END SUB

SUB RepeatKeys (RepeatString AS STRING, NumHelpPasses AS INTEGER)

  LOCATE 1, 1, 0

  LOCATE 24, 1, 0
  PRINT "                            < Press ESC to go on >";

  DIM repeatlen AS INTEGER, nextchar AS INTEGER
  REM DIM NumHelpPasses AS INTEGER
  REM NumHelpPasses = 3

  DIM keystroke AS STRING
  DIM lastkey AS STRING
  DIM lastr AS INTEGER, lastc AS INTEGER
  DIM lasttime AS SINGLE
  lastr = 1
  lastc = 1
  keylit = 0
  keystroke = ""
  keywindow = ""

  DO
    keystroke = INKEY$
  LOOP WHILE keystroke <> ""
 
  repeatlen = LEN(RepeatString)
  nextchar = 1
 
  CALL AddKey(MID$(RepeatString, nextchar, 1))
  REM CALL ShowCursor

  DO

    IF NumHelpPasses > 0 THEN
     
      ' Locate and highlight the next target key
     
      IF MID$(RepeatString, nextchar, 1) = " " THEN
       
        LOCATE 17, 33, 0
        PRINT CHR$(219);
        LOCATE 17, 45, 0
        PRINT CHR$(219);
     
      ELSE
       
        FOR r = 1 TO 4
          IF r = 1 THEN
            RowOfKeys = num
          ELSEIF r = 2 THEN
            RowOfKeys = qwe
          ELSEIF r = 3 THEN
            RowOfKeys = asd
          ELSEIF r = 4 THEN
            RowOfKeys = zxc
          END IF
          FOR c = 1 TO LEN(RowOfKeys)
            IF UCASE$(MID$(RepeatString, nextchar, 1)) = MID$(RowOfKeys, c, 1) THEN
              LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 3, 0
              PRINT CHR$(219);
              LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 1, 0
              PRINT CHR$(219);
            END IF
          NEXT c
        NEXT r
     
      END IF
                   
    END IF

    REM CALL ShowCursor

    keystroke = INKEY$
    IF keystroke = "" THEN

      IF (TIMER - lasttime) > .2 THEN
        LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 3, 0
        PRINT " ";
        LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 1, 0
        PRINT " ";
      END IF

    ELSEIF LCASE$(keystroke) = LCASE$(MID$(RepeatString, nextchar, 1)) THEN

      nextchar = nextchar + 1
      IF nextchar > repeatlen THEN
        nextchar = 1
        IF NumHelpPasses > 0 THEN
          NumHelpPasses = NumHelpPasses - 1
        END IF
      END IF

      CALL AddKey(MID$(RepeatString, nextchar, 1))

    ELSEIF ASC(keystroke) <> 27 THEN

      PLAY "L8a"

    END IF

    IF keystroke <> "" THEN

      LOCATE 17, 33, 0
      PRINT " ";
      LOCATE 17, 45, 0
      PRINT " ";
 
      LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 3, 0
      PRINT " ";
      LOCATE br + (lastr * 2), bc + ((lastc - 1) * 6) + ((lastr + 1) * 3) - 1, 0
      PRINT " ";

      FOR r = 1 TO 4
        IF r = 1 THEN
          RowOfKeys = num
        ELSEIF r = 2 THEN
          RowOfKeys = qwe
        ELSEIF r = 3 THEN
          RowOfKeys = asd
        ELSEIF r = 4 THEN
          RowOfKeys = zxc
        END IF
                                           
        FOR c = 1 TO LEN(RowOfKeys)
          IF UCASE$(MID$(keystroke, 1, 1)) = MID$(RowOfKeys, c, 1) THEN
            LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 3, 0
            PRINT CHR$(16);
            LOCATE br + (r * 2), bc + ((c - 1) * 6) + ((r + 1) * 3) - 1, 0
            PRINT CHR$(17);
            lastr = r
            lastc = c
            lasttime = TIMER
                                              
            REM   CALL AddKey(keystroke)
                                       
            REM PLAY "p2"
          END IF
        NEXT c
                                           
      NEXT r
      REM PLAY "l32a"
    END IF
  LOOP UNTIL MID$(keystroke, 1, 1) = CHR$(27)

END SUB

SUB ShowCursor
  LOCATE 22, 74, 1
END SUB

SUB WelcomeScreen

  DIM time

  DIM vv AS STRING * 1: vv = CHR$(179)
  DIM hh AS STRING * 1: hh = CHR$(196)
  DIM tu AS STRING * 1: tu = CHR$(193)
  DIM td AS STRING * 1: td = CHR$(194)
  DIM tl AS STRING * 1: tl = CHR$(180)
  DIM tr AS STRING * 1: tr = CHR$(195)
  DIM ll AS STRING * 1: ll = CHR$(192)
  DIM lr AS STRING * 1: lr = CHR$(217)
  DIM ul AS STRING * 1: ul = CHR$(218)
  DIM ur AS STRING * 1: ur = CHR$(191)
  DIM xx AS STRING * 1: xx = CHR$(197)
  DIM ss AS STRING * 1: ss = " "

  vv = CHR$(186)
  hh = CHR$(205)
  tu = CHR$(202)
  td = CHR$(203)
  tl = CHR$(185)
  tr = CHR$(204)
  ll = CHR$(200)
  lr = CHR$(188)
  ul = CHR$(201)
  ur = CHR$(187)
  xx = CHR$(206)
  ss = " "

  LOCATE 1, 1, 0
  REM   "              "; W                                   E                       L                       C                       O                       M                           E
  PRINT "              "; ur; ss; ss; ss; ss; ss; ul; ss; ss
  PRINT "              "; vv; ss; ss; ss; ss; ss; vv; ss; ss; ul; hh; hh; ur; ss; ss; ur; ss; ss; ss; ss; ss; ul; hh; hh; ur; ss; ss; ul; hh; hh; ur; ss; ss; ul; hh; td; hh; ur; ss; ss; ul; hh; hh; ur
  PRINT "              "; vv; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; vv; ss; vv; ss; ss; vv
  PRINT "              "; vv; ss; ss; vv; ss; ss; vv; ss; ss; tr; hh; hh; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; vv; ss; vv; ss; ss; tr; hh; hh
  PRINT "              "; vv; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; vv; ss; vv; ss; ss; vv
  PRINT "              "; ll; hh; hh; tu; hh; hh; lr; ss; ss; ll; hh; hh; lr; ss; ss; ll; hh; hh; hh; ss; ss; ll; hh; hh; lr; ss; ss; ll; hh; hh; lr; ss; ss; lr; ss; ss; ss; ll; ss; ss; ll; hh; hh; lr

  LOCATE 9, 1, 0
  REM   "                              "; t                       o
  PRINT "                              "; ss; ss; vv; ss; ss; ss
  PRINT "                              "; hh; hh; xx; hh; hh; ss
  PRINT "                              "; ss; ss; vv; ss; ss; ss; ul; hh; hh; ur
  PRINT "                              "; ss; ss; vv; ss; ss; ss; vv; ss; ss; vv
  PRINT "                              "; ss; ss; ll; ss; ss; ss; ll; hh; hh; lr

  LOCATE 16, 1, 0
  REM   "         "; T                               Y                       P                   E                   T                               E                       A                       C                      H
  PRINT "         "; ul; hh; hh; td; hh; hh; ur; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ss; ul; hh; hh; td; hh; hh; ur; ss
  PRINT "         "; ss; ss; ss; vv; ss; ss; ss; ss; ur; ss; ss; ur; ss; ss; ul; hh; hh; ur; ss; ul; hh; hh; ur; ss; ss; ss; ss; vv; ss; ss; ss; ss; ul; hh; hh; ur; ss; ss; ul; hh; hh; ur; ss; ss; ul; hh; hh; ur; ss; ss; ul; ss; ss; ul
  PRINT "         "; ss; ss; ss; vv; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; vv; ss; ss; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv
  PRINT "         "; ss; ss; ss; vv; ss; ss; ss; ss; ll; hh; hh; tl; ss; ss; tr; hh; hh; lr; ss; tr; hh; hh; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; tr; hh; hh; ss; ss; ss; tr; hh; hh; tl; ss; ss; vv; ss; ss; ss; ss; ss; tr; hh; hh; tl
  PRINT "         "; ss; ss; ss; vv; ss; ss; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; ss; ss; vv; ss; ss; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv; ss; ss; vv; ss; ss; ss; ss; ss; vv; ss; ss; vv
  PRINT "         "; ss; ss; ss; lr; ss; ss; ss; ss; ss; hh; hh; lr; ss; ss; lr; ss; ss; ss; ss; ll; hh; hh; lr; ss; ss; ss; ss; lr; ss; ss; ss; ss; ll; hh; hh; lr; ss; ss; lr; ss; ss; lr; ss; ss; ll; hh; hh; lr; ss; ss; lr; ss; ss; lr

  LOCATE 24, 6, 0
  PRINT "This program is the Intellectual Property of Robert M. Kuczewski";
  LOCATE 25, 20, 0
  PRINT "Copyright 1995 - All Rights Reserved";

  FOR i% = 440 TO 1000 STEP 5
    SOUND i%, i% / 30000
  NEXT i%

  REM PLAY "MB O1"
  REM PLAY "l4cf.l8fl4fag.l8fl4gaf.l8fl4a>cl2d.l4dc. ""
  DO
  LOOP WHILE INKEY$ <> " "


END SUB



