Foreword:
--------

This is old code that I am adding on github from my archives. I had a ton of fun
developing for the Timex DataLink USB, and it would be a shame for this code to
get lost. So here it is! Let me know if you manage to find some use for it.

Everything below comes straight from 2003!

---------------------------------------------------------
            - Deadline Wristapp - v1.01

               For Timex datalink USB

                                (c) 2003 Sylvain Lefebvre
---------------------------------------------------------

Description:
------------

This Wristapp count down the remaining days before an event (like a deadline). 
You can enter up to 5 different events. For each event you can enter a description 
of up to 8 characters.

Change-log:
-----------

* 11/03/2003

    + 20 deadlines
    + count days elapsed since past deadlines
    + up to 999999 days (see Known bugs below)
    + displays only non empty slots

* 02/12/2003

    + well, without a leap year bug, it's not a good program ;-)

Usage:
------

 Default State:
 --------------

  Switches:

   MODE        - next mode
   START/SPLIT - next event

  PC Interface:
  -------------

   Enter descriptions and dates. If the description is empty then the event will be
   ignored.

Files:
------

 DEADLINE.TXT             - application description (this file)
 DEADLINE.APP             - application info
 DEADLINE_PAR_018.BIN     - application initialization parameter list
 DEADLINE_CODE_018.BIN    - application code
 DEADLINE_PIM_PLUGIN.DLL  - PC Interface

Install:
--------

Copy all files in the App directory. Use the mode as usual with 
the Timex Datalink USB interface.

Known bugs:
-----------

* counting more than 9999 days results in a wrong display.

Contact:
--------

Feel free to send comments and bug reports to Sylvain.Lefebvre@laposte.net
If you like this Wristapp let me know :)

Licence:
--------

The source code is under the GPL licence. See http://www.gnu.org
Please link to the original version if you are planning to distribute
a modified version.

Copyright (C) 2003 Sylvain Lefebvre

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; (version 2)

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

-----

This application is provided without any warranty, use at your own risk.

TIMEX is a registered trademark and service mark of Timex Corporation.
TIMEX DATA LINK and WristApp are trademarks of Timex Corporation in the U.S. and other
countries.

-----


    

