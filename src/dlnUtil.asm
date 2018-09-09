;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name :   dlnUtil.asm
; Purpose   :   deadline Wrist App Common Utility Routines
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
                DEFINE  SUBROUTINE      "'dlnutil'"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; =============================================================================
; compares two dates
; A == 1 if (date)IX < (date)IY
; A == 0 otherwise
; =============================================================================
                GLOBAL  dlnDateInf

dlnDateInf:
    
    ; year hi
    ld A,[IX+3]
	cp A,[IY+3]
	jr LT,dlnDateInfTrue
	jr GT,dlnDateInfFalse
    ; year lo
    ld A,[IX+2]
	cp A,[IY+2]
	jr LT,dlnDateInfTrue
	jr GT,dlnDateInfFalse
    ; month
    ld A,[IX+1]
	cp A,[IY+1]
	jr LT,dlnDateInfTrue
	jr GT,dlnDateInfFalse
    ; day
    ld A,[IX]
	cp A,[IY]
	jr LT,dlnDateInfTrue
	jr GE,dlnDateInfFalse
	
dlnDateInfTrue:
	ld A,#1
	jr dlnDateInfExit
dlnDateInfFalse:
	ld A,#0
dlnDateInfExit:
                ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; =============================================================================
; computes the number of days of a month
; result in B
; =============================================================================
                GLOBAL  dlnDaysInMonth

dlnDaysInMonth:

	jr dlnDaysInMonthStart
dlnDaysInMonthData:
	db 31H
	db 00H
	db 31H
	db 30H
	db 31H
	db 30H
	db 31H
	db 31H
	db 30H
	db 31H
	db 30H
	db 31H
dlnDaysInMonthStart:
    ; month
    ld A,[IX+1]
    cp A,#2
    jr NZ,dlnDaysInMonthNotFebruary
    ; year hi
    ld B,[IX+3]
    ; year lo
    ld A,[IX+2]
	; leap year ?
    KTOD_CHECK_IF_LEAP_YEAR
	jr NZ,dlnDaysInMonthNotLeap

	ld B,#29H
	jr dlnDaysInMonthExit

dlnDaysInMonthNotLeap:
	
	ld B,#28H
	jr dlnDaysInMonthExit
	
dlnDaysInMonthNotFebruary:

	UTL_BINARY_MATH_MODE	
	ld  A,[IX+1]
	ld  B,#0
	KTOD_CONVERT_BCD_TO_HEX	
	dec A
	ld  HL,#dlnDaysInMonthData
	add HL,BA
	ld  B,[HL]
	
dlnDaysInMonthExit:
                ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; =============================================================================
; Go back from one month
; change the date
; =============================================================================
                GLOBAL  dlnGoBackFromOneMonth

dlnGoBackFromOneMonth:
	
	UTL_DECIMAL_MATH_MODE
    ; update month
    ld  HL,IX
    inc HL
    sub [HL],#01H
    jr NZ,dlnGoBackFromOneMonthYearOk
	; update year
    inc HL
    sub [HL],#01H
    inc HL
    sbc [HL],#0
    ; -> month <= 12
    ld  HL,IX
    inc HL
    ld  [HL],#12H
dlnGoBackFromOneMonthYearOk:
	; update days
	car dlnDaysInMonth
    ld  HL,IX
    ld  [HL],B
dlnGoBackFromOneMonthExit:
	UTL_BINARY_MATH_MODE	
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; =============================================================================
; Next record
;
; =============================================================================
                GLOBAL  dlnNextRecord

dlnNextRecord:

    ; get current record number
    ld      IX, [CORECurrentASDAddress]
    add     IX, #DLNDBINDEXOFFSET
    ld      BA, [IX]
    inc     BA
    cp      BA,#DLNMAXDBRECORDS
    jr      C,dlnDSDEOk
    ; back to record 0
    ld      BA, #0000H
dlnDSDEOk:
    ; store the new record to display
    ld      [IX], BA				
	ret
