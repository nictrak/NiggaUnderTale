//                              -*- Mode: Verilog -*-
// Filename        : uart_echo.v
// Description     : FPGA Top Level for UART Echo
// Author          : Philip Tracton
// Created On      : Wed Apr 22 12:30:26 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed Apr 22 12:30:26 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!

module uart_echo (/*AUTOARG*/
   // Outputs
   TX,keys,
   // Inputs
   CLK, RESET, RX
   ) ;

   //---------------------------------------------------------------------------
   //
   // PARAMETERS
   //
   //---------------------------------------------------------------------------

   //---------------------------------------------------------------------------
   //
   // PORTS
   //
   //---------------------------------------------------------------------------
   input CLK;
   input RESET;
   input RX;
   output TX;
   output [7:0] keys;
   
   //---------------------------------------------------------------------------
   //
   // Registers
   //
   //---------------------------------------------------------------------------
   /*AUTOREG*/
   reg [7:0] tx_byte;
   reg       transmit;
   reg       rx_fifo_pop;
   
   reg up_reg=0, down_reg=0, left_reg=0, right_reg=0, j_reg=0, k_reg=0, l_reg=0, atk_reg=0;  
   assign keys = {up_reg,down_reg,left_reg,right_reg,j_reg,k_reg,l_reg,atk_reg};
   //---------------------------------------------------------------------------
   //
   // WIRES
   //
   //---------------------------------------------------------------------------
   /*AUTOWIRE*/

   wire [7:0] rx_byte;
   wire       irq;
   wire       busy;
   wire       tx_fifo_full;
   wire       rx_fifo_empty;
   wire       is_transmitting;

   //---------------------------------------------------------------------------
   //
   // COMBINATIONAL LOGIC
   //
   //---------------------------------------------------------------------------



   //---------------------------------------------------------------------------
   //
   // SEQUENTIAL LOGIC
   //
   //---------------------------------------------------------------------------


   uart_fifo uart_fifo(
                       // Outputs
                       .rx_byte         (rx_byte[7:0]),
                       .tx              (TX),
                       .irq             (irq),
                       .busy            (busy),
                       .tx_fifo_full    (tx_fifo_full),
                       .rx_fifo_empty   (rx_fifo_empty),
//                       .is_transmitting (is_transmitting),
                       // Inputs
                       .tx_byte         (tx_byte[7:0]),
                       .clk             (CLK),
                       .rst             (RESET),
                       .rx              (RX),
                       .transmit        (transmit),
                       .rx_fifo_pop     (rx_fifo_pop));

   //
   // If we get an interrupt and the tx fifo is not full, read the receive byte
   // and send it back as the transmit byte, signal transmit and pop the byte from
   // the receive FIFO.
   //
   
   always @(posedge CLK)
     if (RESET) begin
        tx_byte <= 8'h00;
        transmit <= 1'b0;
        rx_fifo_pop <= 1'b0;
        up_reg <= 0;down_reg <= 0;left_reg <= 0;right_reg <= 0;atk_reg <= 0;j_reg <= 0;k_reg <= 0;l_reg <= 0;
     end else begin
        if (!rx_fifo_empty & !tx_fifo_full & !transmit /*& !is_transmitting*/) begin
//           tx_byte <= (rx_byte-32);
           case(rx_byte)
                119: begin //w
                        tx_byte <= (rx_byte-32);
                        up_reg <= 1;
                    end
                97: begin //a
                        tx_byte <= (rx_byte-32);
                        left_reg <= 1;
                    end
                115: begin //s
                        tx_byte <= (rx_byte-32);
                        down_reg <= 1;
                     end
                100: begin //d
                         tx_byte <= (rx_byte-32);
                         right_reg <= 1;
                     end
                106: begin //j
                        tx_byte <= (rx_byte-32);
                        j_reg <= 1;
                     end
                107: begin //k
                        tx_byte <= (rx_byte-32);
                        k_reg <= 1;
                     end   
                108: begin //l
                        tx_byte <= (rx_byte-32);
                        l_reg <= 1;
                     end  
                32: begin //space (attack)
                        tx_byte <= (90);
                        atk_reg <= 1;
                    end
                default: 
                    begin 
                        tx_byte <= 0; 
                        up_reg <= down_reg <= left_reg <= right_reg <= atk_reg <= j_reg <= k_reg <= 0;
                    end
           endcase
           transmit <= 1'b1;
           rx_fifo_pop <= 1'b1;
        end else begin
           tx_byte <= 8'h00;
           transmit <= 1'b0;
           rx_fifo_pop <= 1'b0;
        end
     end 
     
endmodule // uart_echo