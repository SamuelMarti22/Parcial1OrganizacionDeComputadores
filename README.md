# Parcial 1 — Organización de Computadores

## Tema
Diseño e implementación de una **ALU de 32 bits** usando **Nand2Tetris**.  
Se propone componer la ALU32 a partir de dos **ALU de 16 bits**, promoviendo la **modularidad** y la **reutilización de componentes**, como en diseños reales de procesadores.

---

## Objetivo
Construir una **ALU32** que procese dos entradas de 32 bits (`x` e `y`), con banderas de control (`zx, nx, zy, ny, f, no`) y genere como salida:
- Resultado de 32 bits (`out`)
- Banderas de estado:
  - **zr**: salida en cero
  - **ng**: salida negativa
  - **overflow**: detección de desbordamiento aritmético

---

## Requerimientos principales

### Operaciones soportadas
- **ADD**: Suma aritmética  
- **SUB**: Resta aritmética (complemento a 2)  
- **AND**: Operación lógica bit a bit  
- **OR**: Operación lógica bit a bit  
- **NOT / NEG**: Negación lógica o aritmética  

### Banderas de estado
- **ZERO (zr):** `1` si `out == 0`  
- **NEGATIVE (ng):** `1` si el bit 31 (MSB) de `out` es `1`  
- **OVERFLOW:** Se detecta comparando el *carry-in* y el *carry-out* del bit 31  

---

## Integración de ALU16 → ALU32
- Se usan **dos ALU16**:  
  - **Parte baja:** bits `0–15`  
  - **Parte alta:** bits `16–31`  
- **Acarreo ripple:**  
  - El *carry-out* de la ALU baja alimenta el *carry-in* de la ALU alta (solo en operaciones aritméticas).  
  - En operaciones lógicas, el carry se ignora.  
- **ZERO:** calculado como la conjunción (AND) de `zr_baja` y `zr_alta`.  
- **OVERFLOW:** detectado mediante `carry_in XOR carry_out` en el bit 31.  

---

## ALU Monolitica 32 Bits
<img width="1672" height="695" alt="image" src="https://github.com/user-attachments/assets/a803d650-bc1c-400f-8d1c-c1015fab7c42" />

## Descripción

La ALU32 (Unidad Aritmético-Lógica de 32 bits) es un circuito digital que realiza operaciones aritméticas y lógicas sobre dos operandos de 32 bits.  
En este proyecto se implementó la ALU32 en el entorno Nand2Tetris a partir de dos ALU16 conectadas en cascada y el uso de multiplexores para la selección de operaciones.

La ALU32 recibe dos entradas de 32 bits (`x` y `y`) y seis bits de control (`zx, nx, zy, ny, f, no`). Su salida corresponde a un bus de 32 bits (`out`) acompañado de tres banderas de estado:  
- `zr`: indica si la salida es cero.  
- `ng`: indica si la salida es negativa en representación de complemento a dos.  
- `ov`: indica si ocurrió un desbordamiento aritmético (overflow) en la operación de suma.

## Prueba en Nand2Tetris
<img width="1357" height="766" alt="image" src="https://github.com/user-attachments/assets/71a85d9c-88a6-40d1-8d31-a3c7b53f6bf1" />
---
## ALU 32 Bits a partir de 2 ALU's 16
<img width="1025" height="941" alt="imagen" src="https://github.com/user-attachments/assets/7a0b3057-8850-4a61-885f-f864083b2a18" />

## Descripción

La ALU32 (Unidad Aritmético-Lógica de 32 bits) es un circuito digital que realiza operaciones aritméticas y lógicas sobre dos operandos de 32 bits.  
En esta parte del pryoecto se implementaron 2 ALU de 16, "unídas", pero para esto se hicieron algunas modificaciones. Primero creamos un Add16, con la difernecia que el primer adder fuera un fulladder, esto con el proposito de recoger un carry desde el primer adder, así pudiendo transmitir información de una carry a otra; y claramente haciendo que la ALU también devuelva el carry del último adder, para pasarle información a la otra ALU, o para saber si hubo overflow. Después, para evaluar el zr, unimos ambos pines con un and, y ya tendríamos el zr real.

La ALU32 recibe dos entradas de 32 bits (`x` y `y`) y seis bits de control (`zx, nx, zy, ny, f, no`). Su salida corresponde a un bus de 32 bits (`out`) acompañado de tres banderas de estado:  
- `zr`: indica si la salida es cero.  
- `ng`: indica si la salida es negativa en representación de complemento a dos.  
- `ov`: indica si ocurrió un desbordamiento aritmético (overflow) en la operación de suma.
## Prueba en Nand2Tetris
![Uploading imagen.png…]()

---

## Funcionamiento

1. **Preparación de entradas**  
   - `zx` / `zy`: fuerzan `x` o `y` a cero.  
   - `nx` / `ny`: invierten los valores de `x` o `y`.

2. **Operación principal**  
   - `f = 0`: se realiza la operación lógica `x AND y`.  
   - `f = 1`: se realiza la suma `x + y` con propagación de acarreo.

3. **Ajuste final**  
   - `no = 1`: invierte el resultado final.  

4. **Banderas de estado**  
   - `zr = 1`: la salida es cero.  
   - `ng = 1`: la salida es negativa (`out[31] = 1`).  
   - `ov = 1`: se produjo overflow de signo en la suma.  

---

## Arquitectura y diseño

El diseño de la ALU32 sigue una construcción jerárquica basada en módulos:

- **Chips básicos**: Nand, Not, And, Or, Mux, DMux, HalfAdder, FullAdder, Or8Way.  
- **Chips intermedios**: Not16, And16, Or16, Mux16, Add16, Add16c.  
- **Chips principales**: ALU16 y ALU32.  

La estrategia consiste en conectar **dos ALU16 en cascada**:  
- La primera ALU16 procesa los 16 bits menos significativos y produce un acarreo de salida.  
- Dicho acarreo se conecta como entrada de la segunda ALU16, que procesa los 16 bits más significativos.  

Las operaciones `AND` y `ADD` se calculan en paralelo. Posteriormente, se utilizan multiplexores para seleccionar el resultado según el bit de control `f`.  
Finalmente, la salida puede invertirse si `no = 1`, también mediante un multiplexor.

Este enfoque modular permite escalar el diseño y reutilizar componentes previamente implementados.

---

## Combinaciones de control

La siguiente tabla resume algunas combinaciones de los bits de control y la operación correspondiente:

| zx | nx | zy | ny | f | no | Operación         |
|----|----|----|----|---|----|-------------------|
| 1  | 0  | 1  | 0  | 1 | 0  | 0 (constante)     |
| 1  | 1  | 1  | 1  | 1 | 1  | 1 (constante)     |
| 0  | 0  | 1  | 1  | 0 | 0  | x                 |
| 1  | 1  | 0  | 0  | 0 | 0  | y                 |
| 0  | 0  | 0  | 0  | 1 | 0  | x + y             |
| 0  | 1  | 0  | 0  | 1 | 0  | x + 1             |
| 0  | 1  | 0  | 0  | 1 | 1  | x - 1             |
| 0  | 0  | 0  | 1  | 1 | 1  | x - y             |

---

## Instrucciones de uso en Nand2Tetris

1. Copiar el archivo `ALU32.hdl` en la carpeta:
   ```
   nand2tetris/projects/02/
   ```

2. Abrir el simulador de hardware:
   ```
   nand2tetris/tools/HardwareSimulator
   ```

3. Cargar el chip:
   - `File → Load Chip… → ALU32.hdl`

4. Cargar el archivo de prueba:
   - `File → Load Script… → ALU32.tst`

5. Ejecutar la simulación:  
   - Pulsar **Run**.

6. Si la implementación es correcta, aparecerá el mensaje:
   ```
   End of script - Comparison ended successfully
   ```


