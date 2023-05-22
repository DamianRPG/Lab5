# LAB5: Configuración de puertos GPIO

*El siguiente repositorio contiene la documentación correspondiente a la actividad LAB5: Configuración de puertos GPIO.*

---

## El código utilizado consta de 3 funciones:
1) main: Encargada de leer el estado de los botones y escribir en los leds según el tipo de señal.
2) is_buttom_pressed: Relee el estado del botón "x" número de veces para verificar sí su estado es constante.
3) wait: Simula esperar 255 milisegundos. 
4) setup: Función encargada de configurar los puertos de la "blue pill"

# Funcionamiento del código

## main
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/2bb44fd1-93ce-4c41-824c-75827e866713)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7812255d-bf72-4a7f-9182-3cdcd0b870a9)

#### Descripción detallada:
Inicia declarando una función contador desde 0.
Seguido de esto, hará una lectura del botón 1 y 2, no sin antes pasando por la función "is_button_pressed" con la finalidad de eliminar el rebote.
Una vez leídos y salvados los estados de ambos botones, pasarán por diversos "if´s" para establecer que se debe hacer:
- Botón 1 = 0 | Botón 2 = 0 | No sucede nada
- Botón 1 = 1 | Botón 2 = 0 | La cuenta incrementa 1
- Botón 1 = 0 | Botón 2 = 1 | La cuenta decrementa 1
- Botón 1 = 1 | Botón 2 = 1 | La cuenta vuelve a 0
## is_buttom_pressed
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/fb5cb752-e150-488d-bb4e-6edd6538a86a)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7c4147e0-021f-45b6-8f03-765ce838e5b2)

#### Descripción detallada:
Función encargada de verificar sí el valor del botón que se está leyendo es constante.
Inicialmente verifica el estado de la señal, donde en caso de ser negativa, retorna un falso y finaliza la invoación.
En caso contrario, inicia un ciclo for, en el cual se verificará como maximo 10 veces el estado del mismo. Con cada ciclo se iniciará llamando a la función wait. Seguido de una lectura del mismo botón, donde en caso de estar encendido, sumará un 1 a una variable llamada "counter", mientras que, sí su lectura nos dice que está sin oprimir, reiniciará en 0 la variable.
Sí la variable "counter" supera la suma en 4 unidades (traducidas como 4 lecturas donde el botón está presionado), regresará un verdadero, dandonos a entender que el botón está presionado.
Sí la variable por el contrarió, no supera el mismo valor y el ciclo termina, nos dará a entender que el botón no está siendo presionado; límitando así el rebote.

## wait
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/f5021e2f-b78c-43c2-b56f-8363b91157c7)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/c2fbd1c3-83cc-4899-a01c-100b4d61f14d)

#### Descripción detallada:
Consta de 2 ciclos for anidados. El primero tiene como límite 5, que son los ms (milisegundos) que recibe desde la función "is_button_pressed", mientras que el segúndo consta con un límite de 255 ticks. Esto con el fin de simular una espera de 5 milisegundos por parte del microcontrolador. Sin embargo, estos valores siguen causando demasiado "rebote", por lo cual fueron modificados de 5 a 50ms y de 255 a 1000 ticks. 

## setup
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7b23c2e4-73ba-43f6-9811-1a93f2bbf809)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/f88f4771-dab3-4388-a2ba-517e43487a96)

#### Descricpión detallada:
Inicialmente se configura el reloj del puerto A, este se encuentra en la dirección 0x40021018.
Por consiguiente se le indica al microcontrolador que sus puertos de salida serán desde el pin A con númeración 0 hasta el 9.
Finalmente se le indica al mismo que sus puertos de entrada serán el pin A 10 y 11.

## Diagrama del circuito:
![ADD_page-0001](https://github.com/DamianRPG/Lab5/assets/126529855/9685ae01-5383-47ab-bb22-805555e3bf0d)

# Descricpión de circuito:
- Puertos de entrada: PA10 y PA11.
- Puertos de salida: PA0 - PA9.
- Una vez definidos los puertos de salida, estos harán conexión con la parte positiva de los leds (el ánodo); por otra parte, cada una de sus partes negativas (el cátodo), tendrán una conexión a una resistencia de 220OMS, esto con el fin de evitar que el sistema sufra sobrecargas. El pin G (tierra) alimentará a estos resistores.
Mientras tanto los buttons, que constan de dos pines, tendrán una conexión al pin de entrada correspondiente al STM32f103c8t6; mientras que el restante estará conectado al pin 3.3 (voltaje emitido por el microcontrolador).




