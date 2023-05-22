.include "gpio.inc" @ Includes definitions from gpio.inc file

.thumb              @ Assembles using thumb mode
.cpu cortex-m3      @ Generates Cortex-M3 instructions
.syntax unified

.include "nvic.inc"

setup:
        # Prologo
        push    {r7, lr}
        sub     sp, sp, #4
        add     r7, sp, #0    

        # Se configura el reloj del puerto A
        ldr     r0, =RCC_APB2ENR @ move 0x40021018 to r0
        mov     r3, 0x4 @ loads 4 in r3 to enable clock in port A (IOPC bit)
        str     r3, [r0] @ M[RCC_APB2ENR] gets 4

        # Se configuran los pines del 0 al 7 del puerto A
        ldr     r0, =GPIOA_CRL @ moves address of GPIOA_CRL register to r0
        ldr     r3, =0x33333333 
        str     r3, [r0] @ M[GPIOA_CRL] gets 0x33333333

        # Se configuran los pines del 8 al 11 del puerto A
        ldr     r0, =GPIOA_CRH @ moves address of GPIOA_CRH register to r0
        ldr     r3, =0x44448833 
        str     r3, [r0] @ M[GPIOA_CRH] gets 0x44448833
        b       main

main:        
        # Prologo
        push    {r7}
        sub     sp, sp, #16
        add     r7, sp, #0 
        # Counter = 0;
        mov     r0, #0
        str     r0, [r7, #12]
        # Se verifica el estado del botón 1
L1:          
        ldr     r0, =GPIOA_IDR
        ldr     r0, [r0]
        and     r0, #1024
        lsr     r0, #10
        str     r0, [r7, #8]
        ldr     r0, [r7, #8]
        bl      is_button_pressed
        # Se almacena el resultado
        str     r0, [r7, #8]
        # Se verifica el estado del botón 2
        ldr     r0, =GPIOA_IDR
        ldr     r0, [r0]
        and     r0, #2048
        lsr     r0, #11
        str     r0, [r7, #4]
        ldr     r0, [r7, #4]
        bl      is_button_pressed
        # Se almacena el resultado
        str	r0, [r7, #4]
        # Revisa si el estado del botón 1 es 0 o 1
	ldr	r0, [r7, #8]
        cmp     r0, 0x0 
        bne     L2
        # Sí el estado del botón 1 es 0, revisa el estado del botón 2  
	ldr     r0, [r7, #4]
        cmp     r0, 0x0 
        bne     L4    
        # Sí ambos están en 0 (sin presionar) se regresa al main
        b       L1   
L2:
        # Sí el estado del botón 1 es 1, revisa el estado del botón 2 
	ldr     r0, [r7, #4] 
        cmp     r0, 0x1 
        bne     L3      
        # Sí ambos botones están oprimidos, se resetean los leds
        ldr     r0, [r7, #12]
        mov     r0, 0x0
        str     r0, [r7, #12]
        b       L6
L3:       
        # Sí solo el botón 1 está presionado, se suma una unidad
        ldr     r0, [r7, #12]   
        add     r0, r0, #0x1    
        str     r0, [r7, #12]  
	b       L5
L4:     
        # Sí solo el botón 2 está presionado, se resta una unidad
        ldr     r0, [r7, #12]   
        sub     r0, r0, #0x1    
        str     r0, [r7, #12] 
        # En caso de que el resultado sea negativo:        
L5:    
        str     r0, [r7, #12] 
        cmp	r0, 0x0
        bge 	L6
        # Se encienden los leds:
        ldr     r0, =GPIOA_ODR
        ldr     r0, [r7, #12]   
        ldr     r1, =#1023
	and     r0, r1
        # Almacena la salida en el contador
        str     r3, [r0] 
	b       L1  
        #En caso de que el resultado sea positivo:
L6:
        # Se encienden los leds:
        ldr     r0, =GPIOA_ODR
        ldr     r3, [r7, #12]   
        # Almacena la salida en el contador
        str     r3, [r0]        
        b       L1

is_button_pressed:
        push    {r7, lr}
        sub     sp, sp, #16
        add     r7, sp, #0
        # Salva y carga el valor del botón
        str     r0, [r7, #4]
        ldr     r3, [r7, #4]
        # Verifica si el botón está presionado
        cmp     r0, #0
        bne     IB1
        # En caso de no estarlo
        movs    r3, #0
        b       IB6
IB1:
        # Counter = 0
        movs    r3, #0
        str     r3, [r7, #8]
        # i = 0
        movs    r3, #0
        str     r3, [r7, #12]
        b       IB5
IB2:
        # Envía los argumentos a la función wait
        movs    r0, #50
        bl      wait
        ldr     r3, [r7, #4]
        # En caso de que el botón no esté presionado:
        cmp     r3, #0
        bne     IB3
        # En caso de estar presionado, el contador se reinicia
        movs    r3, #0
        str     r3, [r7, #8]
        b       IB4
IB3:
        # En caso de no estar presionado, aumenta en 1 el contador
        ldr     r3, [r7, #8]
        adds    r3, r3, #1
        str     r3, [r7, #8]
        ldr     r3, [r7, #8]
        # counter >= 4
        cmp     r3, #4
        ble     IB4
        # Retorna verdadero en caso de estar presionado
        movs    r3, #1
        b       IB6
IB4:
        # Sí es falso, i++
        ldr     r3, [r7, #12]
        adds    r3, r3, #1
        str     r3, [r7, #12]
IB5:
        ldr     r3, [r7, #12]
        cmp     r3, #9
        ble     IB2
        # Final del ciclo for, se retorna un falso
        movs    r3, #0
IB6:
        # Retorna el argumento
        mov     r0, r3
        adds    r7, r7, #16
        mov     sp, r7
        pop     {r7, pc}

wait:
        # Prologo
        push    {r7}
        sub     sp, sp, #20
        add     r7, sp, #0
        str	r0, [r7]
        # i=0
        mov	r3, #0
        str	r3, [r7, #8]
        b	W4
W1: 	
        # j=0
        mov	r3, #0
        str	r3, [r7, #12]
        b       W3
W2: 
        # j++    
        ldr	r3, [r7, #12]
        adds	r3, r3, #1
        str 	r3, [r7, #12]
W3: 
        # j<ticks
        ldr	r3, [r7, #12]	
        cmp	r3, #1000
        ble	W2
        #i++
        ldr	r3, [r7, #8]
        adds	r3, r3, #1
        str	r3, [r7, #8]
W4: 	
        # i<ms
        ldr	r2, [r7, #8]
        ldr	r3, [r7]
        cmp	r2, r3
        blt	W1
        # Epilogo
        adds	r7, r7, #20
        mov	sp, r7
        pop	{r7}
        bx      lr
