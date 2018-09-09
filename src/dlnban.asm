;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name :   dlnban.asm
; Purpose   :   deadline Application Banner State Manager
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;DO NOT MODIFY THE FOLLOWING SUBROUTINE DEFINITION;;;;;;;;;;;;;;;;;

                IF @DEF('SUBROUTINE')
                    UNDEF SUBROUTINE
                ENDIF
                DEFINE  SUBROUTINE      "'dlnban'"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

                GLOBAL  dlnwaBannerStateManager

dlnwaBannerStateManager:

                car     coreCommonBannerStateHandler
                ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; To modify your customized banner message created from the wizard goto dlnDisp.asm file
; The above code tells the core to execute your customized banner message
; specified in dlnpor.asm
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;