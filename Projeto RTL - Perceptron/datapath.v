module datapath(
   input clk,
   input rst,
   input ld_w0, clr_w0,
   input ld_w1, clr_w1,
   input ld_n, clr_n,
   input ld_ep, clr_ep,
   output reg e_menor,
   output reg n_menor,
   output reg signed [7:0] w0, w1
);
   
   reg [1:0] contador_amostra;
   reg [3:0] contador_epoca;
   
   // Parâmetros
   parameter TOTAL_EPOCAS = 4'd4;
   parameter LIMIAR = 8'd1;
   
   // Variáveis para cálculos
   reg signed [15:0] soma_ponderada;
   reg resultado_calculado;
   reg signed [7:0] erro;

   // Entradas fixas - implementadas como LUT
   wire [1:0] entrada_00 = 2'b00;
   wire [1:0] entrada_01 = 2'b01;
   wire [1:0] entrada_10 = 2'b10;
   wire [1:0] entrada_11 = 2'b11;
   
   wire saida_00 = 1'b0;
   wire saida_01 = 1'b1;
   wire saida_10 = 1'b1;
   wire saida_11 = 1'b1;

   // Seleção de entrada atual
   reg [1:0] entrada_atual;
   reg saida_esperada_atual;
   
   always @(*) begin
      case (contador_amostra)
         2'b00: begin
            entrada_atual = entrada_00;
            saida_esperada_atual = saida_00;
         end
         2'b01: begin
            entrada_atual = entrada_01;
            saida_esperada_atual = saida_01;
         end
         2'b10: begin
            entrada_atual = entrada_10;
            saida_esperada_atual = saida_10;
         end
         2'b11: begin
            entrada_atual = entrada_11;
            saida_esperada_atual = saida_11;
         end
         default: begin
            entrada_atual = entrada_00;
            saida_esperada_atual = saida_00;
         end
      endcase
   end

   // Processamento principal
   always @(posedge clk or posedge rst) begin
      if (rst == 1'b1) begin
         w0 <= 8'd0;
         w1 <= 8'd0;
         contador_amostra <= 2'd0;
         contador_epoca <= 4'd0;
         e_menor <= 1'b1;
         n_menor <= 1'b1;
         soma_ponderada <= 16'd0;
         resultado_calculado <= 1'b0;
         erro <= 8'd0;
      end
      else begin
         // Calcula soma ponderada
         if (entrada_atual[0] == 1'b1 && entrada_atual[1] == 1'b1) begin
            soma_ponderada <= w0 + w1;
         end else if (entrada_atual[0] == 1'b1) begin
            soma_ponderada <= w0;
         end else if (entrada_atual[1] == 1'b1) begin
            soma_ponderada <= w1;
         end else begin
            soma_ponderada <= 16'd0;
         end
         
         // Função de ativação
         if (soma_ponderada >= LIMIAR) begin
            resultado_calculado <= 1'b1;
         end else begin
            resultado_calculado <= 1'b0;
         end

         // Calcula erro
         if (saida_esperada_atual == 1'b1 && resultado_calculado == 1'b0) begin
            erro <= 8'd1;
         end else if (saida_esperada_atual == 1'b0 && resultado_calculado == 1'b1) begin
            erro <= 8'shFF; // -1
         end else begin
            erro <= 8'd0;
         end

         // Atualização de pesos
         if (ld_w0 == 1'b1) begin
            if (entrada_atual[0] == 1'b1) begin
               w0 <= w0 + erro;
            end
         end else if (clr_w0 == 1'b1) begin
            w0 <= 8'd0;
         end

         if (ld_w1 == 1'b1) begin
            if (entrada_atual[1] == 1'b1) begin
               w1 <= w1 + erro;
            end
         end else if (clr_w1 == 1'b1) begin
            w1 <= 8'd0;
         end

         // Contadores
         if (ld_n == 1'b1) begin
            if (contador_amostra == 2'd3) begin
               contador_amostra <= 2'd0;
            end else begin
               contador_amostra <= contador_amostra + 2'd1;
            end
         end else if (clr_n == 1'b1) begin
            contador_amostra <= 2'd0;
         end

         if (ld_ep == 1'b1) begin
            contador_epoca <= contador_epoca + 4'd1;
         end else if (clr_ep == 1'b1) begin
            contador_epoca <= 4'd0;
         end

         // Flags
         if (contador_amostra < 2'd3) begin
            n_menor <= 1'b1;
         end else begin
            n_menor <= 1'b0;
         end

         if (contador_epoca < TOTAL_EPOCAS) begin
            e_menor <= 1'b1;
         end else begin
            e_menor <= 1'b0;
         end
      end
   end
endmodule