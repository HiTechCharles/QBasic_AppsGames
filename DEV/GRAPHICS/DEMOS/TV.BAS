  'TELEVISION STATIC
  'By Noah Daleo
  'This program is pretty simple if you understand how screen 7's video pages
  'work, so I won't go into detail explaining it.
  'One interesting thing about this program is that if you stare at it, you'll
  'see patterns forming.  If you try to keep your eye on one area, it will
  'appear to be migrating to one edge of the screen.  Any patterns that you
  'see are just your eyes playing tricks on you, because this is purely
  'random and no patterns were programmed in.
  'Try looking at the screen like one of those "Magic Eye" pictures!
  'But don't come whining to me if it gives you migraines, convulsions, etc.
  'My e-mail:    rjd42@aol.com
  'My website:   http://members.aol.com/rjd42
                 'That's probably where you got this anyway.  Why not
                 'go back for some more cool programs?  Go now!


  DEFINT A-Y
  screens% = 7   'The higher this is the better it looks, but it takes longer
                 'to load.  It must be at least 1 but no greater than 7.
  disco$ = "NO"  'Change this to yes for a slightly more psychadelic effect.
  SCREEN 7, 0, 0, 0
  PRINT "Generating static..."
  PRINT "  0 percent done"
  FOR this% = 1 TO screens%
    SCREEN 7, 0, this%, 0
    PALETTE 1, 15
    RANDOMIZE TIMER
    FOR thish% = 0 TO 320
      FOR thisv% = 0 TO 200
        PSET (thish%, thisv%), RND
      NEXT thisv%
    NEXT thish%
    SCREEN 7, 0, 0, 0
    LOCATE 2, 1: PRINT INT((this% / screens%) * 100); "percent done"
  NEXT this%
  SCREEN 7, 0, 0, 0
  DO
    FOR this% = 1 TO screens%
      PCOPY this%, 0
      ztimer! = TIMER
      DO
      LOOP UNTIL TIMER > ztimer! + .1
      IF UCASE$(LTRIM$(RTRIM$(disco$))) = "YES" THEN PALETTE 1, INT(RND * 16)
    NEXT this%
  LOOP UNTIL INKEY$ <> ""

