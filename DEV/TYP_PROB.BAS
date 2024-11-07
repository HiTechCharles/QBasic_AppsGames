DECLARE FUNCTION I2A$ (h%)

'I've made a program that calculates the length of time between one date/time
'and another.  I am using a custom type to hold the month, day, year, and
'time entered by the user.  Created a function to take numeric variables and
'convert them to strings.

'  ù When printing numeric variables, a white space gets printed on either
'    side of the desired value.  Converting to strings before printing
'    eliminates this.
'  ù The conversion function takes a single value, and returns this same value
'    as a string.

TYPE DateClass
    month AS INTEGER
      day AS INTEGER
     year AS INTEGER
    time AS STRING * 6
END TYPE  '12

DIM SHARED start AS DateClass

'Set some values using custom type variables
    start.month = 3
    start.day = 11
    start.year = 1982

'Print the above values.  I don't have to use the '%' symbol because the
'variables were declaired as integers.
    PRINT "Date Entered:  "; I2A$(start.month); "-"; I2A$(start.day); "-"; I2A$(start.year%)


'set a variable without a type symbol - supposed to default to INTEGER if
'type symbol not specified for a variable.
    TotalDays = 5

'first, print the variable out plain, then try it using the conversion func
     PRINT "Total Days:  "; TotalDays  '( <--always works)

    'PRINT "Total Days:  "; I2A$(TotalDays)    '(Error #13)

'Executing the above line causes a "Parameter type mismatch" error"  WHY?  the
'function accepts an integer, and the variable to convert is also INTEGER.  I
'know a sub/function's parameter list variables have to match types with those
'you wish to use as inputs to a sub/function.

'I have to add '%' to each variable to get it to work with the conversion
'function.  My problem is I don't want ot have to go through all my
'variables and add '%' to each one that gets used with a sub/function.

'CONCLUSION:  Can't use user-defined type variables in a sub/function without
'adding type symbols to the functions' parameter list variables.

FUNCTION I2A$ (h%)
    I2A$ = LTRIM$(RTRIM$(STR$(h%)))
END FUNCTION

