;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name     : dlnBckHd.asm
; Purpose       : Handles the following application specific functions:
;                   - application initialization
;                   - resource refresh
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
                DEFINE  SUBROUTINE      "'dlnBckHd'"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Module Name : dlnBackgroundHandler
; Description : Handles application initialization and refresh resource handlers.
; Assumptions : COREInitializationASDAddress is already set by kernel.
;               COREInitializationADDAddress is already set by kernel.
; Input(s)    : None
; Output(s)   : None
;               ( Destroyed: All registers )
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                GLOBAL  dlnBackgroundHandler

dlnBackgroundHandler:

                ; Load the event to be process to AReg.
                ld      A, [COREBackgroundEvent]

                ; Check if INIT event.
                cp      A, #COREEVENT_INIT
                jr      NZ, dlnBackgroundProcessExit

dlnBackgroundInitEvent:

                ;Init DB index to 0

				ld A, #0
				ld IY, [COREInitializationASDAddress]
				ld [IY + DLNDBINDEXOFFSET + 0], A
				ld [IY + DLNDBINDEXOFFSET + 1], A

dlnBackgroundProcessExit:

                ret