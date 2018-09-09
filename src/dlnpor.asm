;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; File Name    : dlnpor.asm
; Purpose      : deadline parameter file
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        GLOBAL  dlnwaPORInitializationParameters

dlnwaPORInitializationParameters:

                ;============================================================
                ; ACB offset mask.
                ;============================================================

                ; Application System Data is located in heap.
                ; Other ACB entries are located either in ROM or EEPROM.

                db      bCOREAppSystemDataOffset


                ;============================================================
                ; Number of resources required.
                ;============================================================

                db      00h                         ; TOD
                db      00h                         ; Backup
                db      01h                         ; Time Zone Check
                db      00h                         ; Timer Resource
                db      00h                         ; Stopwatch Resource
                db      00h                         ; Synchro Timer Resource

                ;============================================================
                ; Flag(s) ownership.
                ;============================================================

                db      0                           ; LCD Flags 1
                db      0                           ; LCD Flags 2

                ;============================================================
                ; Heap size requirements.
                ;============================================================

                dw      0000H                           ; Code
                dw      DLNSYSTEMDATASIZE               ; ASD
                dw      0000H                           ; ADD
                ;============================================================
                ; Application Configuration Data Byte.
                ;============================================================

                db      COREACDEEPROMAPP            ; Code is external.

                ;============================================================
                ; Application Unique ID.
                ;============================================================

                db      COREAPPTYPEGENERIC          ; Application type
                db      00h                         ; Application instance number

                ;============================================================
                ; ACB Parameters.
                ;============================================================

                dw      0000H                       ; ASD address offset.
                dw      0000H                       ; ADD address offset.
                dw      CODESTATEADDRESS            ; App state manager address (Absolute Address).
                dw      CODECOMMONADDRESS           ; App background handler address (Absolute Address).
                dw      dlnBannerMsg                ; App mode name function address (Absolute Address).