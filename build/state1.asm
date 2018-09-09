;**FILE STATE1.ASM

; ********************************************************************
; *
; * M851 WRISTAPP BUILDER
; * Timex Corporation 2002 All Rights Reserved
; * July 2002
; *
; * WristApp: deadline
; *
; ********************************************************************


$CASE ON
$LIST OFF
    INCLUDE 'c:\m851\include\M851INC.H'
    INCLUDE 'C:\M851\App\deadline\build\COMMINC.H'


    INCLUDE 'c:\m851\include\MODEL.H'
    INCLUDE 'c:\m851\include\HW88349.H'
    INCLUDE 'c:\m851\include\HWI2CEE.H'
    INCLUDE 'c:\m851\include\HWBOND.H'
    INCLUDE 'c:\m851\include\HWKBD.H'
    INCLUDE 'c:\m851\include\HWMACRO.H'
    INCLUDE 'c:\m851\include\HWMAIN.H'
    INCLUDE 'c:\m851\include\HWRESET.H'
    INCLUDE 'c:\m851\include\HWVARS.H'
    INCLUDE 'c:\m851\include\HWSERMAC.H'
    INCLUDE 'c:\m851\include\CORE.H'
    INCLUDE 'c:\m851\include\COREMAC.H'
    INCLUDE 'c:\m851\include\CORESVMC.H'
    INCLUDE 'c:\m851\include\COMM.H'
    INCLUDE 'c:\m851\include\LCD.H'
    INCLUDE 'c:\m851\include\LCDMACRO.H'
    INCLUDE 'c:\m851\include\LCDRAM.H'
    INCLUDE 'c:\m851\include\DB.H'
    INCLUDE 'c:\m851\include\DBMACRO.H'
    INCLUDE 'c:\m851\include\AUD.H'
    INCLUDE 'c:\m851\include\AUDMAC.H'
    INCLUDE 'c:\m851\include\UTLMATH.H'
    INCLUDE 'c:\m851\include\UTLMTHMC.H'
    INCLUDE 'c:\m851\include\UTLEDT.H'
    INCLUDE 'c:\m851\include\UTLEDTMC.H'
    INCLUDE 'c:\m851\include\UTLDSP.H'
    INCLUDE 'c:\m851\include\UTLDEF.H'
    INCLUDE 'c:\m851\include\UTLDSPMC.H'
    INCLUDE 'c:\m851\include\UTLACCMC.H'
    INCLUDE 'c:\m851\include\UTLMSC.H'
    INCLUDE 'c:\m851\include\UTLMSCMC.H'
    INCLUDE 'c:\m851\include\UTLVARS.H'
    INCLUDE 'c:\m851\include\UTILVARS.H'
    INCLUDE 'c:\m851\include\KRES.H'
    INCLUDE 'c:\m851\include\KRESMAC.H'
    INCLUDE 'c:\m851\include\KSTP.H'
    INCLUDE 'c:\m851\include\KSTPMAC.H'
    INCLUDE 'c:\m851\include\KSYN.H'
    INCLUDE 'c:\m851\include\KSYNMAC.H'
    INCLUDE 'c:\m851\include\KTMR.H'
    INCLUDE 'c:\m851\include\KTMRMAC.H'
    INCLUDE 'c:\m851\include\KTOD.H'
    INCLUDE 'c:\m851\include\KTODMAC.H'
    INCLUDE 'c:\m851\include\KTZC.H'
    INCLUDE 'c:\m851\include\KTZCMAC.H'
    INCLUDE 'c:\m851\include\KBCK.H'
    INCLUDE 'c:\m851\include\KBCKMAC.H'
    INCLUDE 'c:\m851\include\USG.H'
    INCLUDE 'c:\m851\include\USGVARS.H'
    INCLUDE 'c:\m851\include\USGMAC.H'
    INCLUDE 'c:\m851\include\TOD.H'
    INCLUDE 'c:\m851\include\TODVARS.H'
    INCLUDE 'c:\m851\include\ADD_HDR.H'
    INCLUDE 'c:\m851\include\ADD_MAC.H'


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ; WRIST APPLICATION SPECIFIC HEADER FILE
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    INCLUDE 'C:\M851\App\deadline\h\dlnvars.h'
    INCLUDE 'C:\M851\App\deadline\h\dln.h'

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


$LIST ON

CODESTATEADDRESS     equ     CommonCodeEnd

        DEFSECT ".text", CODE AT CODESTATEADDRESS
        SECT    ".text"

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;
     ; ADD WRISTAPP SOURCE FILE TO BE IN THE STATE CODE
     ;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    INCLUDE 'C:\M851\App\deadline\src\dlndef.asm'

     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;**END FILE STATE1.ASM
