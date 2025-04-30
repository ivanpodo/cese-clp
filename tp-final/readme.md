# Proyecto Final – Control Lógico Programable

Esta carpeta contiene los archivos de un **generador de PWM configurable** implementado en FPGA como proyecto final de la materia **Control Lógico Programable** (FIUBA).

## Descripción general

El módulo PWM fue diseñado en VHDL, simulado en **ModelSim** y sintetizado utilizando **Vivado 2018.3** para la placa **Arty Z7-10**.  
La verificación funcional se realizó con un **testbench** dedicado, mientras que la prueba en hardware utilizó un **IP Core VIO** (Virtual Input/Output) para interactuar en tiempo real con los registros de configuración del PWM.

La carga del bitstream en la FPGA se realizó mediante **escritorio remoto** al laboratorio de sistemas embebidos (LSE) de FIUBA.

---

## Estructura del proyecto

- [`pwm.vhd`](./fuentes/pwm.vhd) → Módulo PWM configurable en VHDL.  
- [`pwm_tb.vhd`](./fuentes/pwm_tb.vhd) → Testbench funcional utilizado en ModelSim.
- [`top_level.vhd`](./fuentes/top_level.vhd) → Módulo superior usado para la síntesis y generación del bitstream.
- [`rtl_pwm_expandido.pdf`](./docs/rtl-schematic-pwm-open.pdf) → Esquemático RTL con el módulo `pwm` expandido.  
- [`rtl_pwm_colapsado.pdf`](./docs/rtl-schematic.pdf) → Esquemático RTL con el módulo `pwm` colapsado.
- [`utilizacion_recursos_vivado.csv`](./docs/utilizacion-tabla.png) → Tabla de utilización de recursos en Vivado (LUTs, FFs, etc).

---

## Herramientas utilizadas

| Herramienta     | Versión     | Uso                          |
|------------------|--------------|-------------------------------|
| ModelSim         | 10.x         | Simulación del testbench     |
| Vivado           | 2018.3       | Síntesis y generación de bitstream |
| IP Integrator    | VIO Core     | Prueba del PWM en hardware   |

---

