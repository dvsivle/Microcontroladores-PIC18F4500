;Este es un comentario, esta es una plantilla
    list p=18f4550			;Modelo del microcontrolador
    #include <p18f4550.inc>		;Llamo a la librer�a de nombre de los regs
    #include "LCD_LIB.asm"
    
    ;Zona de los bits de configuraci�n (falta)
    CONFIG  FOSC = XT_XT	  ; Oscillator Selection bits (XT oscillator (XT))
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    
    org 0x0000
    goto configuro
    
    org 0x20
    ;Seg�n la librer�a el LCD esta conectado con el PIC: RS->RD0, RW->RD1, E->RD2, Datos->RD4-RD7
configuro:
    clrf TRISD			;Todo el puerto D como salida (LCD)
    call DELAY15MSEG		;Rutina de la librer�a para configurar el LCD
    call LCD_CONFIG    
    call CURSOR_OFF

inicio:
    call CURSOR_HOME
    movlw 0x48
    call ENVIA_CHAR
    movlw 0x6F
    call ENVIA_CHAR
    movlw 0x6C
    call ENVIA_CHAR
    movlw 0x61
    call ENVIA_CHAR
    movlw 0x20
    call ENVIA_CHAR
    movlw 0x4D
    call ENVIA_CHAR
    movlw 0x75
    call ENVIA_CHAR
    movlw 0x6E
    call ENVIA_CHAR    
    movlw 0x64
    call ENVIA_CHAR
    movlw 0x6F
    call ENVIA_CHAR    

fin:	nop
	goto fin
    
    end