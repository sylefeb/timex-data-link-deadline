;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name    : dlndef.asm
; Purpose      : deadline Application Default State Manager
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
;;;;;;;;;;;;;DO NOT MODIFY THE FOLLOWING SUBROUTINE DEFINITION;;;;;;;;;;;;;;;;;

                IF @DEF('SUBROUTINE')
                    UNDEF SUBROUTINE
                ENDIF
                DEFINE  SUBROUTINE      "'dlndef'"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Module Name : dlnDefaultStateManager
; Description : deadline Application Default State Manager.
; Assumptions : Display is cleared on first time entry into the state.
; Input(s)    : CORECurrentEvent  - system event to be processed
;               COREEventArgument - event extra information
; Output(s)   : None
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                GLOBAL  dlnDefaultStateManager

dlnDefaultStateManager:

                ; Set IYReg the address of the deadline ASD.
                ld      IY, [CORECurrentASDAddress]

                ld      A, [CORECurrentEvent]

                ; Check if state entry event.
                cp      A, #DLN_STATEENTRY
                jr      Z, dlnDefaultStateStateEntryEvent

                ; Check if mode depress event.
                cp      A, #DLN_MODEDEPRESS
                jr      Z, dlnDefaultStateModeDepressEvent

                ; Check if crown set event.
                cp      A, #DLN_CROWNSET
                jr      Z, dlnDefaultPulledCrownEvent

                ; Check if start depress event.
                cp      A, #DLN_STARTDEPRESS
                jr      Z, dlnDefaultStartDepressEvent

                ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;; EVENT HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dlnDefaultPulledCrownEvent:
                ;**************************************************************
                ;
                ;                       CROWN SET
                ;
                ;**************************************************************

                ld      B, #DLNYOUROCKSETSTATE
                CORE_REQ_STATE_CHANGE

                ret

dlnDefaultStateStateEntryEvent:
                ;**************************************************************
                ;
                ;                       STATE ENTRY
                ;
                ;**************************************************************

                ;This is the default display, replace it with your own
                car      dlnwaDefaultDisplay

                ;TODO: Add your own code initialization here

                ret

dlnDefaultStateModeDepressEvent:
                ;**************************************************************
                ;
                ;                       MODE DEPRESS
                ;
                ;**************************************************************

                ;This is default to go to the next mode

                CORE_REQ_MODE_CHANGE_NEXT

                ret
         
dlnDefaultStartDepressEvent:

                ;**************************************************************
                ;
                ;                       START DEPRESS
                ;
                ;**************************************************************
                car      dlnNextRecord
				; update display
                car      dlnwaDefaultDisplay

                ret
