BootTrax by Charles Martin

WHAT IT DOES
BootTrax records into a file the date and time someone turns on the computer.


HOW TO INSTALL FOR WINDOWS
Unzip all of the files in the package into any folder.

Make shortcuts to the following programs in the directory you chose.
   for the BootTrax files.  (To make a shortcut, RIGHT-CLICK on a file, then
   choose "CREATE SHORTCUT."  Move the new shortcut to any place you wish)

PROGRAM         DESCRIPTION
BT_MAN.EXE      Manager  (see the BOOTTRAX MANAGER section below.)
BT_LOG.exe      Logger  (This goes in the STARTUP
                group in the start Menu, under PROGRAMS.  This program
                does the actual recording.


HOW TO INSTALL FOR MS-DOS
Unzip all of the files in the package into any directory.

If you use a menu program to launch programs, such as DosShell, make links
to the following programs:  

PROGRAM         DESCRIPTION
BT_MAND.EXE     Manager  (see the USING BOOTTRAX section below.)
BT_LOG.EXE      Logger  (This should be ran from your C:\AUTOEXEC.BAT** 
                file so it can run each time your computer starts.  This 
                program does the actual recording.

**Add this line into your AUTOEXEC.BAT file.  If you chose a different
install directory, substitute the correct one.   @C:\BOOTTRAX\BT_LOG.EXE


OPERATION
After setting up the software, the program will run each time your computer
starts, to record what time and date it started.  If you delete the log
file, (see below,) it will be created if it does not exist.  While the
program is running, no messages tell the user it's running.

THE BOOTTRAX MANAGER 
To see the times your computer was started, you must use the Manager.
This program can also delete the log file, so you can start over.

When you load the program, (BT_MAN.EXE,) the title screen will appear.
Press any key here to see the menu.  (The picture shows the word BootTrax
at the top center.  Near the bottom, there's a pair of boots, with footprints
leading from there.  The footprints run next to a computer.)

The main menu allows you to either view the log file, or delete it.

---Viewing the log file
When viewing the file, you can use the UP and DOWN arrows, or your mouse,
to move around.  The newest additions are at the bottom.  If the computer
starts more than once in the same day, it will be indicated in each notation.

---Deleting the log file
Deleting the log file allows you to start over.  You will be asked if you
are sure you want to delete.

---Recreating record files
If you want to quickly start over, or get error messages from the program,
use this option.  It will delete the log file, and others used for recording.

---HELP!!---
You're lookin' at it!  This file will show up if you ask for help.


DESCRIPTION OF THE FILES THAT MAKE BOOTTRAX
BRUN45.EXE      Allows all the other programs to function.
BT.GIF          Title screen picture.
BTREADME.TXT    ReadMe & Help
BT_LOG.EXE      Makes the time & date recordings.
BT_MAN.EXE      Manager  Lets you view, and delete the log file.
BT_MAND.EXE     DOS version of Manager.  Uses a dos viewer to display files.
BT_SETUP.EXE    Recreates the recording files, in case of program errors.
LIST.COM        Used by the DOS version of Manager to display files.
MS.GIF          Logo image


TROUBLESHOOTING + Q&A
Q. When I try to view the log file, it says it cannot be found.
A. The log program  (BT_LOG.EXE) must be ran at least once.  Restart
   your computer to run it.  Also check your installation.

Q. The log file never gets created or there's never anything in it.
A. The program that does the recording isn't being ran when your computer
   starts.  Add the program to your AUTOEXEC.BAT file (for MS-DOS,) or
   make a shortcut to BT_LOG.EXE, and put it in your startup group in your
    start menu, under programs.

Q. When I run the Manager in windows, it comes up in a little window.  Can it
   be made bigger?
A. The window can be made to fill the entire screen.  This is done by holding
   down the ALT key, then pressing ENTER.  This works for most other DOS
   programs, too.


CONTACTING THE AUTHOR
To ask questions, or pose suggestions, email me at HiTechCharles@gmail.com