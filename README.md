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

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7812255d-bf72-4a7f-9182-3cdcd0b870a9)

#### Descripción detallada:

## is_buttom_pressed
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/fb5cb752-e150-488d-bb4e-6edd6538a86a)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7c4147e0-021f-45b6-8f03-765ce838e5b2)

#### Descripción detallada:

## wait
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/f5021e2f-b78c-43c2-b56f-8363b91157c7)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/c2fbd1c3-83cc-4899-a01c-100b4d61f14d)

#### Descripción detallada:
Consta de 2 ciclos for anidados. 

## setup
#### Pseudo código:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/7b23c2e4-73ba-43f6-9811-1a93f2bbf809)

#### Marco de la función:
![image](https://github.com/DamianRPG/Lab5/assets/126529855/f88f4771-dab3-4388-a2ba-517e43487a96)

#### Descricpión detallada:

## Diagrama del circuito:
![ADD_page-0001](https://github.com/DamianRPG/Lab5/assets/126529855/9685ae01-5383-47ab-bb22-805555e3bf0d)

# Descricpión de circuito:
- Puertos de entrada: PA10 y PA11.
- Puertos de salida: PA0 - PA9.
- Una vez definidos los puertos de salida, estos harán conexión con la parte positiva de los leds (el ánodo); por otra parte, cada una de sus partes negativas (el cátodo), tendrán una conexión a una resistencia de 220OMS, esto con el fin de evitar que el sistema sufra sobrecargas. El pin G (tierra) alimentará a estos resistores.
Mientras tanto los buttons, que constan de dos pines, tendrán una conexión al pin de entrada correspondiente al STM32f103c8t6; mientras que el restante estará conectado al pin 3.3 (voltaje emitido por el microcontrolador).




