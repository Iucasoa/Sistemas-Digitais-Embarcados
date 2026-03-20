# \ud83c\udf0c Sistemas Digitais Embarcados

> Um repositório dedicado à exploração de **Sistemas Embarcados** e **Projetos de Hardware Digital**, integrando soluções práticas com Arduino e implementações avançadas em Verilog.

---

## \ud83c\udfcb Sobre o Projeto

Este repositório apresenta uma coleção completa de projetos educacionais e aplicados nas áreas de **sistemas embarcados** e **design digital em hardware**. Os projetos demonstram desde aplicações práticas de sensores com microcontroladores até implementações sofisticadas de algoritmos de aprendizado de máquina em linguagem de descrição de hardware.

---

## \ud83c\udf0e Tecnologias Utilizadas

| Tecnologia | Descrição |
|-----------|-----------|
| ![Arduino](https://img.shields.io/badge/Arduino-00979D?style=for-the-badge&logo=Arduino&logoColor=white) | Microcontrolador para projetos embarcados |
| ![Verilog](https://img.shields.io/badge/Verilog-FF6B6B?style=for-the-badge&logoColor=white) | Linguagem HDL para design digital |
| ![C++](https://img.shields.io/badge/C%2B%2B-00599C?style=for-the-badge&logo=c%2B%2B&logoColor=white) | Linguagem para programação de microcontroladores |

---

## 📁 Estrutura de Pastas

```
Sistemas-Digitais-Embarcados/
│
├── 📂 Códigos Arduino/
│   ├── 🌡️ Temperature Sensor
│   │   └── Medição de temperatura com DHT11
│   │
│   ├── 📡 IR Remote Control
│   │   └── Controle remoto infravermelho para dispositivos
│   │
│   └── 📏 Ultra-Sonic Ranging
│       └── Medição de distância com sensor ultrassônico
│
├── 📂 Projeto RTL - Perceptron/
│   ├── 🧠 Single Layer Perceptron
│   │   └── Implementação básica para classificação binária
│   │
│   ├── 🔗 Multi-layer Perceptron
│   │   └── Rede multicamadas com capacidades avançadas
│   │
│   ├── 📋 Testbenches
│   │   └── Ambientes de teste para validação
│   │
│   └── 📊 Simulation Results
│       └── Resultados de simulação e síntese
│
└── 📄 README.md (Este arquivo)
```

### \ud83d\udd0e Descrição das Pastas Principais

- **Códigos Arduino**: Projetos práticos que utilizam sensores e componentes eletrônicos para demonstrar aplicações reais de sistemas embarcados.
  
- **Projeto RTL - Perceptron**: Implementação de algoritmos de rede neural em hardware, utilizando Verilog para síntese em dispositivos FPGA.

---

## \ud83c\udf89 Funcionalidades Principais

### \ud83d\plug Projetos Arduino

#### 1️⃣ **Temperature Sensor** 🌡️
- Leitura de temperatura ambiente usando sensor **DHT11**
- Exibição de dados em **LCD 16x2**
- Detecção automática de superaquecimento
- Registro de dados em intervalos regulares

#### 2️⃣ **IR Remote Control** 📡
- Decodificação de sinais infravermelhos
- Controle de múltiplos dispositivos via controle remoto
- Interface simples e intuitiva
- Suporta diversos modelos de controle

#### 3️⃣ **Ultra-Sonic Ranging** 📏
- Cálculo de distância utilizando sensor HC-SR04
- Saída analógica e digital
- Detecção automática de obstáculos
- Precisão em diferentes cenários

### 🧠 Projeto RTL - Perceptron

#### 1️⃣ **Single Layer Perceptron**
- Arquitetura simples e clara
- Implementação de pesos e bias
- Função de ativação em lógica digital
- Ideal para problemas de classificação binária
- Facilmente expansível para arquiteturas mais complexas

#### 2️⃣ **Multi-layer Perceptron**
- Integração de múltiplas camadas de neurônios
- Capacidade de resolver problemas não-lineares
- Testbenches abrangentes inclusos
- Resultados de simulação validados
- Suporte a datasets complexos com maior precisão

---

## 🚀 Como Instalar e Rodar

### 📋 Pré-requisitos

#### Para Projetos Arduino:
- Arduino IDE (versão 1.8.x ou superior)
- Driver USB para placa Arduino
- Bibliotecas necessárias:
  - `DHT.h` (para sensor de temperatura)
  - `LiquidCrystal.h` (para display LCD)
  - `IRremote.h` (para controle remoto)
  - `NewPing.h` (para sensor ultrassônico)

#### Para Projetos Verilog:
- Simulador Verilog (ModelSim, Vivado, ou similar)
- Compilador HDL
- Ferramenta de síntese (Xilinx Vivado, Quartus, ou equivalente)

### 🔧 Instalação

#### Arduino

1. **Clone o repositório**
   ```bash
   git clone https://github.com/Iucasoa/Sistemas-Digitais-Embarcados.git
   cd Sistemas-Digitais-Embarcados
   ```

2. **Instale as bibliotecas necessárias**
   - Abra o Arduino IDE
   - Acesse: `Sketch` → `Include Library` → `Manage Libraries`
   - Procure e instale: DHT, LiquidCrystal, IRremote, NewPing

3. **Carregue o código**
   - Abra a pasta `Códigos Arduino`
   - Selecione o projeto desejado
   - Abra o arquivo `.ino` no Arduino IDE
   - Conecte a placa via USB
   - Selecione a placa e porta em `Tools`
   - Clique em **Upload** (→)

#### Verilog

1. **Clone o repositório**
   ```bash
   git clone https://github.com/Iucasoa/Sistemas-Digitais-Embarcados.git
   cd "Projeto RTL - Perceptron"
   ```

2. **Abra no simulador**
   - Importe os arquivos Verilog no seu simulador favorito
   - Carregue os testbenches correspondentes
   - Execute a simulação

3. **Síntese (Opcional)**
   - Use Vivado, Quartus ou outra ferramenta
   - Configure para sua placa FPGA
   - Gere o bitstream e programe o dispositivo

---

## 💡 Exemplos de Uso

### Arduino - Leitura de Temperatura
```cpp
#include "DHT.h"
#include <LiquidCrystal.h>

#define DHTPIN 2
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

void setup() {
  dht.begin();
  lcd.begin(16, 2);
}

void loop() {
  float temp = dht.readTemperature();
  lcd.print("Temp: ");
  lcd.print(temp);
  delay(2000);
}
```

---

## 🤝 Contribuição

Valorizamos contribuições! Se você deseja colaborar com este projeto, siga os passos abaixo:

### 📝 Guia de Contribuição

1. **Fork o repositório**
   - Clique no botão "Fork" no canto superior direito

2. **Clone seu fork**
   ```bash
   git clone https://github.com/SEU-USERNAME/Sistemas-Digitais-Embarcados.git
   cd Sistemas-Digitais-Embarcados
   ```

3. **Crie uma branch para sua feature**
   ```bash
   git checkout -b feature/minha-contribuicao
   ```

4. **Realize suas alterações**
   - Adicione melhorias, correções ou novos projetos
   - Mantenha o código limpo e bem documentado
   - Siga as convenções de nomenclatura do projeto

5. **Commit e Push**
   ```bash
   git add .
   git commit -m "Descrição clara da contribuição"
   git push origin feature/minha-contribuicao
   ```

6. **Abra um Pull Request**
   - Descreva as mudanças realizadas
   - Explique o motivo da contribuição
   - Aguarde a revisão

### ✅ Padrões de Qualidade

- Código bem comentado e organizado
- Documentação atualizada
- Testes funcionando corretamente
- Sem duplicação desnecessária

---

## 📚 Recursos Adicionais

- **[Arduino Official Documentation](https://www.arduino.cc/reference/)**
- **[Verilog Tutorials](https://www.verilog-tutorial.com/)**
- **[FPGA Development](https://www.xilinx.com/)**

---

## 📄 Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.

---

## 👨‍💻 Autor

**Lucas Oliveira** (@Iucasoa)

Se você tiver dúvidas ou sugestões, abra uma **Issue** no repositório!

---

## ⭐ Agradecimentos

Obrigado por visitar este repositório! Se achou útil, considere dar uma ⭐ para apoiar este projeto.

**Desenvolvido com ❤️ para a comunidade de Sistemas Embarcados**