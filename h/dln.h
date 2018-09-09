;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name :   dln.h
; Purpose   :   deadline mode application header
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


;==============================================================================
;
; STATE REDEFINITIONS
;
;==============================================================================

DLNBANNERSTATE              equ     COREBANNERSTATE
DLNDEFAULTSTATE             equ     COREDEFAULTSTATE
DLNSETBANNERSTATE           equ     CORESETBANNERSTATE
DLNYOUROCKSETSTATE          equ     CORESETBANNERSTATE
DLNSETSTATE                 equ     CORESETSTATE
DLNPOPUPSTATE               equ     COREPOPUPSTATE
DLNPASSWORDDEFAULTSTATE     equ     COREPASSWORDDEFAULTSTATE
DLNPASSWORDSETBANNERSTATE   equ     COREPASSWORDSETBANNERSTATE
DLNPASSWORDSETSTATE         equ     COREPASSWORDSETSTATE

; TODO: Add your own state redefinition here

;==============================================================================
;
; EVENT REDEFINITIONS
;
;==============================================================================

DLN_STATEENTRY              equ     COREEVENT_STATEENTRY
DLN_CROWNHOME               equ     COREEVENT_CROWN_HOME
DLN_CROWNSET                equ     COREEVENT_CROWN_SET1
DLN_CWPULSES                equ     COREEVENT_CW_PULSES
DLN_CCWPULSES               equ     COREEVENT_CCW_PULSES
DLN_MODEDEPRESS             equ     COREEVENT_SWITCH1DEPRESS
DLN_STARTDEPRESS            equ     COREEVENT_STARTSPLITDEPRESS

;==============================================================================
;
; DEFINES
;
;==============================================================================

DLNRECORDSIZE                   equ        13
DLNRECORDDATESIZE               equ         5
DLNRECORDDESCSIZE               equ         8
DLNRECORDDESCOFFSET             equ         5
DLNMAXDBRECORDS                 equ        20

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;