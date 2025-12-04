module control (
   input clk,
   input rst,
   input e_menor,
   input n_menor,
   output reg ld_w0, clr_w0,
   output reg ld_w1, clr_w1,
   output reg ld_n, clr_n,
   output reg ld_ep, clr_ep
);
   
   reg [1:0] estado_atual;
   reg [1:0] prox_estado;
   
   parameter INICIO = 2'b00;
   parameter ESPERA = 2'b01;
   parameter FRENTE = 2'b10;
   parameter VOLTA  = 2'b11;
   
   always @(posedge clk or posedge rst) begin
      if (rst == 1'b1) begin
         estado_atual <= INICIO;
      end else begin
         estado_atual <= prox_estado;
      end
   end
   
   always @(*) begin
      ld_w0 = 1'b0;
      clr_w0 = 1'b0;
      ld_w1 = 1'b0;
      clr_w1 = 1'b0;
      ld_n = 1'b0;
      clr_n = 1'b0;
      ld_ep = 1'b0;
      clr_ep = 1'b0;
      prox_estado = estado_atual;
      
      case (estado_atual)
         INICIO : begin
            clr_w0 = 1'b1;
            clr_w1 = 1'b1;
            clr_n = 1'b1;
            clr_ep = 1'b1;
            prox_estado = ESPERA;
         end
         
         ESPERA : begin
            clr_n = 1'b1;
            ld_ep = 1'b1;
            if (e_menor == 1'b1) begin
               prox_estado = FRENTE;
            end else begin
               prox_estado = ESPERA;
            end
         end
         
         FRENTE : begin
            prox_estado = VOLTA;
         end
         
         VOLTA : begin
            ld_w0 = 1'b1;
            ld_w1 = 1'b1;
            ld_n = 1'b1;
            if (n_menor == 1'b1) begin
               prox_estado = FRENTE;
            end else begin
               prox_estado = ESPERA;
            end
         end
         
         default : begin
            prox_estado = INICIO;
         end
      endcase
   end
endmodule