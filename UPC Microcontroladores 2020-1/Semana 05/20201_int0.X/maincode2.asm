;Este es un comentario, se le antecede un punto y coma
    list p=18f4550	;Modelo del microcontrolador
    #include <p18f4550.inc>	;Llamada a la librer�a de nombre de los registros
    
    ;Directivas de preprocesador o bits de configuraci�n
    CONFIG  PLLDIV = 1            ; PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
    CONFIG  CPUDIV = OSC1_PLL2    ; System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
    CONFIG  FOSC = XT_XT          ; Oscillator Selection bits (XT oscillator (XT))
    CONFIG  PWRT = ON             ; Power-up Timer Enable bit (PWRT enabled)
    CONFIG  BOR = OFF             ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
    CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
    CONFIG  CCP2MX = ON           ; CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
    CONFIG  PBADEN = OFF          ; PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
    CONFIG  MCLRE = ON            ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
    CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

    org 0x0000		;Vector de RESET
    goto init_conf
    
    org 0x0008		;Vector de interrupci�n de alta prioridad
    goto interropt_hp
    
    org 0x0018		;Vector de interrupcion de baja prioridad
    goto interropt_lp
    
    
    org 0x0020		;Zona de programa de usuario
init_conf:
    bcf TRISD, 7	;Puerto RD7 como salida
    bcf TRISD, 5	;Puerto RD5 como salida

    ;Configuraci�n de las interrupciones
    bsf RCON, 7		;Habilitar las prioridades en las interrupciones
    bcf INTCON3, INT1IP	;Interrupcion INT1 como baja prioridad
    bsf INTCON3, INT1IE	;Habilitar INT1
    movlw 0xD0		
    movwf INTCON	;GIEH=1, GIEL=1, INT0IE=1 Habilitamos la interrupcion INT0
    
loop:
    nop
    goto loop		;El micro en el cauce normal no hace nada

    ;Rutina de interrupci�n de alta prioridad    
interropt_hp:
	    btg LATD, 7		    ;Complemento de RD7
	    bcf INTCON, INT0IF	    ;Bajamos la bandera de la interrupci�n externa
	    retfie
	    
    ;Rutina de interrupci�n de baja prioridad    
interropt_lp:
	    btg LATD, 5		    ;Complemento de RD7
	    bcf INTCON3, INT1IF	    ;Bajamos la bandera de la interrupci�n externa
	    retfie	    
	    end		;Fin del programa