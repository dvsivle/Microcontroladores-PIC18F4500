/*
 * File:   maincode.c
 * Author: klnla
 *
 * Created on May 19, 2020, 7:59 PM
 */

// PIC18F4550 Configuration Bit Settings
// 'C' source line config statements
#pragma config PLLDIV = 1       // PLL Prescaler Selection bits (No prescale (4 MHz oscillator input drives PLL directly))
#pragma config CPUDIV = OSC1_PLL2// System Clock Postscaler Selection bits ([Primary Oscillator Src: /1][96 MHz PLL Src: /2])
#pragma config FOSC = XTPLL_XT  // Oscillator Selection bits (XT oscillator, PLL enabled (XTPLL))
#pragma config PWRT = ON        // Power-up Timer Enable bit (PWRT enabled)
#pragma config BOR = OFF        // Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
#pragma config BORV = 3         // Brown-out Reset Voltage bits (Minimum setting 2.05V)
#pragma config WDT = OFF        // Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
#pragma config WDTPS = 32768    // Watchdog Timer Postscale Select bits (1:32768)
#pragma config CCP2MX = ON      // CCP2 MUX bit (CCP2 input/output is multiplexed with RC1)
#pragma config PBADEN = OFF     // PORTB A/D Enable bit (PORTB<4:0> pins are configured as digital I/O on Reset)
#pragma config MCLRE = ON       // MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#pragma config LVP = OFF        // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

#include <xc.h>

#define _XTAL_FREQ 48000000UL   //Frecuencia de trabajo 48MHz

void configuracion(void) {
    //Aqu� colocas las configuraciones iniciales
    TRISD = 0xFE;               //Puerto RD0 como salida
}

void retardo_var(int valor) {
    for (int i=0;i<valor;i++) {
        __delay_ms(10);
    }
}

void main(void) {
    configuracion();
    while(1) {
        //Tu programa de usuario
        for (int x=0;x<20;x++) {
            LATDbits.LD0 = 1;       //Mandamos un uno l�gico a RD0
            retardo_var(x);
            //__delay_ms(200);        //Retardo de 200ms
            LATDbits.LD0 = 0;       //Mandamos un cero l�gico a RD0
            retardo_var(x);
            //__delay_ms(200);        //Retardo de 200ms       
        }
        for (int x=0;x<20;x++) {
            LATDbits.LD0 = 1;       //Mandamos un uno l�gico a RD0
            retardo_var(20-x);
            //__delay_ms(200);        //Retardo de 200ms
            LATDbits.LD0 = 0;       //Mandamos un cero l�gico a RD0
            retardo_var(20-x);
            //__delay_ms(200);        //Retardo de 200ms       
        }
    }
}
