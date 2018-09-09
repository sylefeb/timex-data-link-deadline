;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name :   dlnDisp.asm
; Purpose   :   Deadline Wrist App Common Display Routines
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Copyright (C) 2003 Sylvain Lefebvre
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation; (version 2)
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program; if not, write to the Free Software
;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;DO NOT MODIFY THE FOLLOWING SUBROUTINE DEFINITION;;;;;;;;;;;;;;;;;

                IF @DEF('SUBROUTINE')
                    UNDEF SUBROUTINE
                ENDIF
                DEFINE  SUBROUTINE      "'dlndisp'"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Module Name : dlnwaDefaultDisplay
; Description : Display MODE DEFAULT at default entry. This is merely used by the wizard
; Input(s)    : None
; Output(s)   : None
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                GLOBAL  dlnwaDefaultDisplay

TodayBuffer:
				db 00 ;minute
				db 00 ;hour
				db 00 ;day
				db 00 ;month
				db 00 ;year lo
				db 00 ;year hi
				db 00 ;dow
TmpBuffer:
				db 00 ;day
				db 00 ;month
				db 00 ;year lo
				db 00 ;year hi
				db 00 ;dow
DeadlineBuffer:
				db 00  ;dumb
DeadlineDatabaseData:
				db 00  ;flags
				db 10H ;day
				db 01H ;month
				db 04H ;year lo
				db 20H ;year hi
				db 00  ;dow
DeadlineDescDisplay:
				dw LCDMAINDMLINE2COL1
				db 08H 
DeadlineDescData:
				db 00  ;desc [0]
				db 00  ;desc [1]
				db 00  ;desc [2]
				db 00  ;desc [3]
				db 00  ;desc [4]
				db 00  ;desc [5]
				db 00  ;desc [6]
				db 00  ;desc [7]

NumberOfDaysDecimal:
                db 00H ;    10     1
                db 00H ;  1000   100
                db 00H ;100000 10000

PastDeadline:
				db 00H ; flag is deadline was in the past

dlnDaysShortDisplay:
                dw        LCDMAINDMLINE1COL22
                db        4, DM5_D, DM5_A, DM5_Y, DM5_S

dlnDaysLongDisplay:
                dw        LCDMAINDMLINE1COL37
                db        2, DM5_D, DM5_PERIOD

dlnEmptyDisplay:
                dw        LCDMAINDMLINE1COL16
                db        5, DM5_E, DM5_M, DM5_P, DM5_T, DM5_Y

dlnPastDisplay:
                dw        LCDUPPERDMCOL1
                db        1, DM5_MINUS

dlnLoadCount:
				db        00
				
dlnwaDefaultDisplay:

;				UTL_DECIMAL_MATH_MODE
				
;				ld HL,#NumberOfDaysDecimal
;				ld [HL],#99H
;				inc HL
;				ld [HL],#99H
;				inc HL
;				ld [HL],#00H
;							
;				ld HL,#NumberOfDaysDecimal+1
;				ld A,[HL]	
;				ld IX, #LCDMAINDMLINE1COL1
;				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
;				ld HL,#NumberOfDaysDecimal
;				ld A,[HL]	
;				ld IX, #LCDMAINDMLINE1COL13
;				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
;				
;				ld HL,#NumberOfDaysDecimal
;				add [HL],#01H
;				inc HL
;				adc [HL],#0
;				inc HL
;				adc [HL],#0
;
;				ld HL,#NumberOfDaysDecimal
;				add [HL],#99H
;				inc HL
;				adc [HL],#0
;				inc HL
;				adc [HL],#0
;
;				ld HL,#NumberOfDaysDecimal
;				add [HL],#99H
;				inc HL
;				adc [HL],#0
;				inc HL
;				adc [HL],#0
;
;				ld HL,#NumberOfDaysDecimal+2
;				ld A,[HL]	
;				ld IX, #LCDMAINDMLINE2COL1
;				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
;				ld HL,#NumberOfDaysDecimal+1
;				ld A,[HL]	
;				ld IX, #LCDMAINDMLINE2COL13
;				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_NO_ZERO_SUP
;				ld HL,#NumberOfDaysDecimal
;				ld A,[HL]	
;				ld IX, #LCDMAINDMLINE2COL25
;				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_NO_ZERO_SUP
;
;				ret
				
				ld L,#0
				ld [dlnLoadCount],L

		dlnReload:
		
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
				;read deadline from database
				ld      HL, [CORECurrentADDAddress]
                ld      [DBExternalMemoryAddress], HL
                DB_OPEN_FILE
                
                ; Setup the record number to retrieve
				ld      HL, [CORECurrentASDAddress]
				add     HL,#DLNDBINDEXOFFSET
				ld      HL, [HL]
                ld      [DBRecordNumber], HL

                ; Read date
                ld      HL, #DeadlineDatabaseData
                ld      [DBInternalMemoryAddress], HL
                ld      L, #DLNRECORDDATESIZE
                ld      [DBLengthLo], L
                DB_READ_RECORD_RANDOMFIX

				; Read desc				
                ld      HL, #DeadlineDescData
                ld      [DBInternalMemoryAddress], HL                
                ld      L, #DLNRECORDDESCSIZE
                ld      [DBLengthLo], L
                ld      L, #DLNRECORDDESCOFFSET
                ld      [DBRecordOffset], L                
                DB_READ_RECORD_WITHOFFSET_RANDOMFIX
                
                DB_CLOSE_FILE

				; empty ?
				ld A,[DeadlineDatabaseData]
				cp A,#0
				jr nz,dlnNotEmpty
				; try only max records times
				ld L,[dlnLoadCount]
				inc L
				ld [dlnLoadCount],L
				cp L,#DLNMAXDBRECORDS
				jr Z,dlnEmpty
				; goto next
				car dlnNextRecord
				jr dlnReload
				
		dlnNotEmpty:

				; DEBUG
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IX,#DeadlineBuffer+2
				;car dlnGoBackFromOneMonth
				;ld IY, #DeadlineBuffer+2
				;UTL_DISPLAY_DATE_COMPLETE
				;ret
				
				; DEBUG
				;ld L,[DBNumberOfRecords]
				;UTL_CONVERT_HEX_TO_2DIGIT_BCD
				;ld IX, #LCDMAINDMLINE1COL1
				;LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
				;ld L,[DBSizePerRecord]
				;UTL_CONVERT_HEX_TO_2DIGIT_BCD
				;ld IX, #LCDMAINDMLINE2COL1
				;LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
				;ld L,[DBRecordNumber]
				;UTL_CONVERT_HEX_TO_2DIGIT_BCD
				;ld IX, #LCDMAINDMLINE1COL10
				;LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_NO_ZERO_SUP
				;ld L,[DBRecordNumber+1]
				;UTL_CONVERT_HEX_TO_2DIGIT_BCD
				;ld IX, #LCDMAINDMLINE1COL22
				;LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_NO_ZERO_SUP
                
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

				LCD_CLR_DISPLAY

                ; display desc on bottom line
				ld IY, #DeadlineDescDisplay
				LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG

				; display date and day of week information for deadline
				ld IY, #DeadlineBuffer+2
				UTL_DISPLAY_DATE_COMPLETE

				; copy the primary time zone data to today buffer
				ld A, [COREPTZIndex]
				ld IY, #TodayBuffer
				KTOD_COPY_TIME_MIN_TO_DOW_FROM_RESOURCE

				; check if deadline prior from today
				ld IX,#DeadlineBuffer+2
				ld IY,#TodayBuffer+2
				car dlnDateInf
				cp A,#1
				jr NZ,dlnNotPast

				; invert dates
				; -> today => tmp				
				ld A, [TodayBuffer+2]
				ld HL,#TmpBuffer
				ld [HL],A
				ld A, [TodayBuffer+3]
				ld HL,#TmpBuffer+1
				ld [HL],A
				ld A, [TodayBuffer+4]
				ld HL,#TmpBuffer+2
				ld [HL],A
				ld A, [TodayBuffer+5]
				ld HL,#TmpBuffer+3
				ld [HL],A
				; -> deadline => today
				ld A, [DeadlineBuffer+2]
				ld HL,#TodayBuffer+2
				ld [HL],A
				ld A, [DeadlineBuffer+3]
				ld HL,#TodayBuffer+3
				ld [HL],A
				ld A, [DeadlineBuffer+4]
				ld HL,#TodayBuffer+4
				ld [HL],A
				ld A, [DeadlineBuffer+5]
				ld HL,#TodayBuffer+5
				ld [HL],A
				; -> tmp => deadline
				ld A, [TmpBuffer]
				ld HL,#DeadlineBuffer+2
				ld [HL],A
				ld A, [TmpBuffer+1]
				ld HL,#DeadlineBuffer+3
				ld [HL],A
				ld A, [TmpBuffer+2]
				ld HL,#DeadlineBuffer+4
				ld [HL],A
				ld A, [TmpBuffer+3]
				ld HL,#DeadlineBuffer+5
				ld [HL],A

				ld HL,#PastDeadline
				ld [HL],#1
			
				jr dlnEndPastTest
					
		dlnNotPast:

				ld HL,#PastDeadline
				ld [HL],#0

		dlnEndPastTest:

				; compute the number of days between deadline and today

				; -> init to zero
				ld A,#0
				ld [NumberOfDaysDecimal],A
				ld [NumberOfDaysDecimal+1],A
				ld [NumberOfDaysDecimal+2],A

		dlnComputeDays:
		
				; -> while "today" month and years are different from deadline month and years
				;   -> compare month
				ld A,[TodayBuffer+3]
				ld B,[DeadlineBuffer+3]
				cp A,B
				jr NZ,dlnComputeDaysContinue
				;   -> compare year low
				ld A,[TodayBuffer+4]
				ld B,[DeadlineBuffer+4]
				cp A,B
				jr NZ,dlnComputeDaysContinue
				;   -> compare year high
				ld A,[TodayBuffer+5]
				ld B,[DeadlineBuffer+5]
				cp A,B
				jr NZ,dlnComputeDaysContinue
				; -> equals !
				jr dlnComputeDaysDone
				
		dlnComputeDaysContinue:
				
				; -> add current date number of days to the days counter
				
				ld A,[DeadlineBuffer+2]
				;ld A,#31H

				UTL_DECIMAL_MATH_MODE
				ld HL,#NumberOfDaysDecimal
				add [HL],A
				inc HL
				adc [HL],#0
				inc HL
				adc [HL],#0
				UTL_BINARY_MATH_MODE	

		    dlnAdd1Done:
		    
				; -> go to previous month
				;ld A, [DeadlineBuffer+2]
				;ld IY, #DeadlineBuffer+2
				;KTOD_SUBTRACT_DAYS
				;ld IY, #DeadlineBuffer+2
				;KTOD_ADJUST_DATE_AND_YEAR

				ld IX, #DeadlineBuffer+2
				car dlnGoBackFromOneMonth
				
				jr dlnComputeDays
				
		dlnComputeDaysDone:

				; -> subtract days of deadline from today current day value
				UTL_DECIMAL_MATH_MODE
				ld B, [TodayBuffer+2]
				ld A, [DeadlineBuffer+2]
				sub A,B
				
				; -> add this to number of days
				ld HL,#NumberOfDaysDecimal
				add [HL],A
				inc HL
				adc [HL],#0
				inc HL
				adc [HL],#0
				UTL_BINARY_MATH_MODE	
				
		    dlnAdd2Done:

				; we are done ! => display result

				; display the number of days

				ld A,[NumberOfDaysDecimal+2]
				cp A,#0
				jr nz,dlnLongDisplay
				ld A,[NumberOfDaysDecimal+1]
				cp A,#09H
				jr LT,dlnShortDisplay
				
			dlnLongDisplay:
			
				ld A,[NumberOfDaysDecimal+2]
				ld IX, #LCDMAINDMLINE1COL1
				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
				ld A,[NumberOfDaysDecimal+1]
				ld IX, #LCDMAINDMLINE1COL13
				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_SUP_ZERO
				ld A,[NumberOfDaysDecimal]
				ld IX, #LCDMAINDMLINE1COL25
				LCD_DISP_SMALL_FIXED_WIDTH_2DIG_DM_DATA_NO_ZERO_SUP
				; display "days" message
				ld IY, #dlnDaysLongDisplay
				LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG

				jr dlnEndDisplay
				
			dlnShortDisplay:

				ld A,[NumberOfDaysDecimal]
				ld B,[NumberOfDaysDecimal+1]
				ld IX, #LCDMAINDMLINE1COL1
				LCD_DISP_SMALL_FIXED_WIDTH_3DIG_DM_DATA_NO_LSD_SUP
				; display "days" message
				ld IY, #dlnDaysShortDisplay
				LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG

			dlnEndDisplay:

				; display past message if needed
				ld A,[PastDeadline]
				cp A,#0
				jr Z,dlnEndPastDisplay
				; past message
				ld IY, #dlnPastDisplay
				LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG
				
dlnEndPastDisplay:

				; done
				jr dlnDefaultDisplayExit

dlnEmpty:
				; empty message
				ld IY, #dlnEmptyDisplay
				LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG
                ; display record number
				jr dlnDefaultDisplayExit
				
dlnDefaultDisplayExit:

                ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Module Name : dlnwaSetDisplay
; Description : Display SET DEFAULT at set default entry. This is merely used by the wizard
; Input(s)    : None
; Output(s)   : None
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                GLOBAL  dlnwaSetDisplay

dlnwaSetDisplay:

                ld        IY,#dlnSetDisplayLine1
                ld        IX,#dlnSetDisplayLine2
                car       dlnDisplayLine1Line2

                jr        dlnSetDisplayExit

dlnSetDisplayLine1:
                dw        LCDMAINDMLINE1COL14
                db        3, DM5_S, DM5_E, DM5_T

dlnSetDisplayLine2:

                dw        LCDMAINDMLINE2COL6
                db        7, DM5_D, DM5_E, DM5_F, DM5_A, DM5_U,DM5_L,DM5_T

dlnSetDisplayExit:

                ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Module Name : tsawaDisplayLine1Line2
; Description : Display message at Main Dot Matrix Line 1 and Line 2
; Input(s)    : IY = table address for Line1, IX = table address for Line2
; Output(s)   : None
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dlnDisplayLine1Line2:

                push      IX
                LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG

                pop       IX
                ld        IY,IX
                LCD_DISP_FORMATTED_SMALL_PROP_WIDTH_DM_MSG

dlnDisplayLine1Line2Exit:
                ret


;==============================================================================
;
;                THIS IS YOUR COSTUMIZED MODE BANNER CREATED FROM WRISTAPP WIZARD
;
;==============================================================================

                GLOBAL      dlnBannerMsg
dlnBannerMsg:

                db        LCDBANNER_COL1, DM5_D, DM5_E, DM5_A, DM5_D, DM5_L, DM5_I, DM5_N, DM5_E
                db        LCD_END_BANNER


                ;TODO: Add your own functionality display below or edit above display routines
