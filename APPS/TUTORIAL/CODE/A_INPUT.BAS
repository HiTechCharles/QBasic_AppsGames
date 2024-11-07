'Input printing and math


COLOR 15: CLS        'Clear the screen, switch to white text color

PRINT "Enter two numbers, press ENTER after typing in each one."
INPUT " First number:  >", first       'Asks for a number, stores it under 'first'
INPUT "Second number:  >", second      'save the next input as 'second'
PRINT
PRINT "The numbers are"; first; "and"; second   'display the selected numbers


Added = first + second         'Add the two numbers, and store the result
Subtracted = first - second    'Subtract and store
Multiplied = first * second    'multiply and store
Divided = first / second       'divide and store



