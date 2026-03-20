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

```

## 📐 Arquitetura do Sistema

### Máquina de Estados (FSM) - Perceptron
O controle do neurônio segue o fluxo abaixo para garantir a convergência dos pesos:



1. **INICIO:** Limpa todos os registros e contadores após o Reset.
2. **ESPERA:** Realiza o cálculo da soma ponderada e aplica a função degrau.
3. **FRENTE:** Verifica o erro e prepara a transição para a próxima amostra da porta OR.
4. **VOLTA:** Atualiza os registros de pesos ($w_0, w_1$) e reinicia o ciclo se houver mais épocas.

### Estrutura de Conexões (Pinagem ATmega328P)
Para reproduzir o Módulo Arduino, utilize a seguinte configuração física:

| Periférico | Pino Arduino | Registrador | Função |
|------------|--------------|-------------|--------|
| **Botão** | Digital 2    | `PD2 (INT0)`| Entrada com Interrupção |
| **LED** | Digital 13   | `PB5`       | Saída de Status |

---

## 📊 Funcionamento do Hardware

### Simulação de Sinais (Waveforms)
Abaixo, a representação visual esperada no **GTKWave** ao observar a convergência dos pesos durante o treinamento:



### Tabela de Verdade (Treinamento OR)
O Perceptron ajusta os pesos síncronos ao clock para satisfazer a lógica:

| Entrada A | Entrada B | Saída Esperada |
|:---------:|:---------:|:--------------:|
|     0     |     0     |        0       |
|     0     |     1     |        1       |
|     1     |     0     |        1       |
|     1     |     1     |        1       |

---

## 🔧 Como Executar

### 1. Arduino (AVR Bare-metal)
- Abra o arquivo `.ino` desejado na **Arduino IDE**.
- Certifique-se de selecionar a placa **Arduino Uno**.
- Para os códigos "SemDelay", o botão deve estar obrigatoriamente no **Pino 2** (Interrupção Física).

### 2. RTL Perceptron (Simulação)
Para verificar o aprendizado do hardware via terminal utilizando o **Icarus Verilog**:

```bash
# 1. Compilar os módulos
iverilog -o perceptron_sim top.v control.v datapath.v

# 2. Executar a simulação
vvp perceptron_sim

```

---

## 🎓 Aprendizados Principais

Durante o desenvolvimento deste projeto, foram explorados desafios reais de engenharia que conectam a teoria de algoritmos à realidade física do hardware:

* **Manipulação Bare-metal:** Entendimento profundo de como a abstração de bibliotecas (como as do Arduino) consome ciclos de CPU. A programação direta via registradores provou ser essencial para sistemas de tempo real.
* **Concorrência em Hardware (RTL):** Diferente de um processador sequencial, o design em Verilog permitiu que o cálculo da soma ponderada e a lógica de controle ocorressem em paralelo, otimizando o tempo de processamento neural.
* **Tratamento de Sinais:** Implementação de estratégias de *debouncing* e sincronização de *clock* para garantir que entradas mecânicas (botões) não causem instabilidade na lógica digital.
* **IA em Baixo Nível:** A implementação do Perceptron demonstrou que redes neurais simples podem ser aceleradas em hardware dedicado (FPGA/ASIC) sem a necessidade de sistemas operacionais complexos.

---

## 👨‍💻 Autor

**Lucas Oassoa**
* **GitHub:** [@Iucasoa](https://github.com/Iucasoa)
* **Universidade:** UFERSA (Universidade Federal Rural do Semi-Árido)
* **Curso:** Engenharia de Computação

---

## 📄 Licença

Este projeto está licenciado sob a **Licença MIT**. Você é livre para usar, modificar e distribuir o código, desde que mantenha os créditos originais. Consulte o arquivo `LICENSE` para mais detalhes.

---
**Última atualização:** 2026-03-20



