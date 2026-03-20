# 🤖 Embedded Systems & Neural Hardware (RTL)

[![Linguagem](https://img.shields.io/badge/Linguagens-C%20%7C%20Verilog-orange.svg)](https://www.iso.org/standard/74528.html)
[![Plataforma](https://img.shields.io/badge/Plataforma-AVR%20%7C%20FPGA-blue.svg)]()
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Completo-brightgreen.svg)]()

## 📖 Descrição

Este repositório reúne projetos de engenharia de computação focados em **Sistemas Embarcados de Baixo Nível** e **Design de Hardware Digital**. O objetivo principal é demonstrar a transição entre o controle de software via registradores em microcontroladores AVR (ATmega328P) e a aceleração de algoritmos em hardware (Perceptron) utilizando Verilog.

---

## 🚀 Funcionalidades

O projeto está dividido em dois ecossistemas complementares:

### ⚡ Módulo Arduino (AVR Bare-metal)
Diferente do uso comum da biblioteca Arduino, este módulo foca na manipulação de bits nos registros do processador:
- **Controle de Lâmpada e Tranca:** Lógicas de acionamento por botão com manipulação direta de memória.
- **Debouncing em Software:** Implementação de atrasos controlados para evitar falsos positivos no sensor.
- **Lógica Orientada a Interrupção:** Uso de `ISR(INT0_vect)` para garantir que a CPU responda instantaneamente a estímulos externos no pino `PD2`.
- **Eficiência:** Uso de `PORTB`, `DDRD` e `PINB` para reduzir o tempo de execução e o tamanho do binário.

### 🧠 Módulo Perceptron (RTL/Verilog)
Um neurônio artificial completo implementado em nível de portas lógicas para aprender a função **OR**:
- **Unidade de Controle (FSM):** Gerencia os estados `INICIO`, `ESPERA`, `FRENTE` e `VOLTA`.
- **Datapath Digital:** Calcula a soma ponderada das entradas e atualiza os pesos `w0` e `w1` em tempo real.
- **Feedback de Erro:** Sistema autônomo que ajusta os parâmetros até que a saída do hardware seja idêntica à saída esperada.
- **Divisor de Clock:** Implementado no `top.v` para permitir a visualização do aprendizado em LEDs físicos.

---

## 🛠️ Conceitos de Engenharia Aplicados

| Conceito | Descrição |
|----------|-----------|
| **Bit Manipulation** | Configuração de IO via máscaras de bits (`(1 << PB5)`). |
| **ISR (Interrupt Service Routine)** | Rotinas de interrupção externas para tratamento prioritário. |
| **FSM (Finite State Machine)** | Máquina de estados para coordenar as épocas de treino da IA. |
| **Datapath Design** | Unidade aritmética para cálculo de soma ponderada e função de ativação degrau. |

---

## 💻 Tecnologias Utilizadas

- **Linguagens:** C (padrão AVR/GNU), Verilog (Hardware Description Language).
- **Compiladores:** `avr-gcc`, Icarus Verilog.
- **Hardware Alvo:** Arduino Uno (ATmega328P) e FPGAs (síntese via `top.v`).
- **Simulação:** GTKWave (visualização de formas de onda).

---

## 📁 Estrutura do Repositório

```text
.
├── Códigos Arduino/
│   ├── LampadaComDelay.ino     # Controle via polling (registrador PINB)
│   ├── LampadaSemDelay.ino     # Implementação com Interrupção (EIMSK/EICRA)
│   ├── TrancaComDelay.ino      # Lógica de trava com debouncing via delay
│   └── TrancaSemDelay.ino      # Interrupção externa para inversão de estado
│
└── Projeto RTL - Perceptron/
    ├── control.v               # FSM: Coordena os estados do treinamento
    ├── datapath.v              # Aritmética: Pesos, erro e soma ponderada
    └── top.v                   # Integração: Divisor de clock e IO de LEDs
