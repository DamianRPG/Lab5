# LAB5: Configuración de puertos GPIO

*El siguiente repositorio contiene la documentación correspondiente a la actividad LAB5: Configuración de puertos GPIO.*

---

## El código utilizado consta de 3 funciones:
1) main: Encargada de leer el estado de los botones y escribir en los leds según el tipo de señal.
2) is_buttom_pressed: relee el estado del botón "x" número de veces para verificar sí su estado es constante.
3) wait: simula esperar 255 milisegundos. 

# Funcionamiento del código

### main:
# Pseudo código:
# Marco de la función:
# Descripción detallada:

### is_buttom_pressed:
# Pseudo código:
# Marco de la función:
# Descripción detallada:

### wait:
# Pseudo código:
# Marco de la función:
# Descripción detallada:
Consta de 2 ciclos for anidados. 

### Diagrama del circuito:
![ADD_page-0001](https://github.com/DamianRPG/Lab5/assets/126529855/9685ae01-5383-47ab-bb22-805555e3bf0d)

# Descricpión de armado:
Puertos de entrada: PA10 y PA11
Puertos de salida: PA0 - PA9
Una vez definidos los puertos de salida, estos harán conexión con la parte positiva de los leds (el ánodo); por otra parte, cada una de sus partes negativas (el cátodo), tendrán una conexión a una resistencia de 220OMS, esto con el fin de evitar que el sistema sufra sobrecargas. El pin G (tierra) alimentará a estos resistores.
Mientras tanto los buttons, que constan de dos pines, tendrán una conexión al pin de entrada correspondiente al STM32f103c8t6; mientras que el restante estará conectado al pin 3.3 (voltaje emitido por el microcontrolador).




