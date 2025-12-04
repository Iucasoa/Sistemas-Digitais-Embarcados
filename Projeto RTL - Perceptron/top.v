module top( clk, btn1, led );
   input clk;
   input btn1;
   output [3:0] led;

   // Divisor de clock
   reg [31:0] contador;
   wire clk_lento;
   
   always @(posedge clk) begin
      if (!btn1)
         contador <= 32'd0;
      else if (contador == 32'd25000000)
         contador <= 32'd0;
      else
         contador <= contador + 32'd1;
   end

   assign clk_lento = (contador == 32'd25000000);

   // Sinais de controle
   wire ld_w0, clr_w0, ld_w1, clr_w1, ld_n, clr_n, ld_ep, clr_ep;
   wire e_menor, n_menor;
   wire [7:0] w0, w1;

   wire rst = ~btn1;

   control ctrl (
        .clk(clk_lento),
        .rst(rst),
        .e_menor(e_menor),
        .n_menor(n_menor),
        .ld_w0(ld_w0), 
        .clr_w0(clr_w0),
        .ld_w1(ld_w1),
        .clr_w1(clr_w1),
        .ld_n(ld_n),
        .clr_n(clr_n),
        .ld_ep(ld_ep), 
        .clr_ep(clr_ep)
    );

    datapath dp (
        .clk(clk_lento),
        .rst(rst),
        .ld_w0(ld_w0), 
        .clr_w0(clr_w0),
        .ld_w1(ld_w1),
        .clr_w1(clr_w1),
        .ld_n(ld_n),
        .clr_n(clr_n),
        .ld_ep(ld_ep), 
        .clr_ep(clr_ep),
        .e_menor(e_menor),
        .n_menor(n_menor),
        .w0(w0),
        .w1(w1)
    );

   assign led[1:0] = w0[1:0];
   assign led[3:2] = w1[1:0];
   
endmodule