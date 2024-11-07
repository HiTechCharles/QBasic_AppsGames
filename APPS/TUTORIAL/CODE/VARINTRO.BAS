CLS     'clears (erases) any numbers or letters from the screen

LET FirstNumber = 92    'store two numbers in the computer's memory
LET SecondNumber = 68   'using the variable names FirstNumber and SecondNumber

PRINT FirstNumber       'Print information on the screen  In this case, the
PRINT SecondNumber      'numbers stored under FIrstNumber and SecondNumber

PRINT
PRINT "Hello, world!"   'You can print out words, too.  just use 'PRINT'
PRINT                   'with the desired message in quotes.  (" ")
PRINT

PRINT " First number is"; FirstNumber   'more than one message or stored
PRINT "Second number is"; SecondNumber  'number can be printed out at once,
                                        'one after the other on the same line.

SLEEP    'makes the computer wait for a keyboard key to be hit before
         'continuing the program

CLS   'blank the screen - erase the things we've printed out and start fresh
      'without that 'SLEEP' command, the screen would blank before we got to
      'see what was printed out.

TOTAL = FirstNumber + SecondNumber      'Let's ask the computer to add our
                                        'two stored values, and save the
                                        'answer under the name 'TOTAL'

PRINT "The answer is"; TOTAL            'print out the answer that was just
                                        'calculated.

