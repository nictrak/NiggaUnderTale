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
   TX,cX,cY,cl,
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
   output [9:0]cX, cY;
   output [1:0] cl;
   //---------------------------------------------------------------------------
   //
   // Registers
   //
   //---------------------------------------------------------------------------
   /*AUTOREG*/
   reg [7:0] tx_byte;
   reg       transmit;
   reg       rx_fifo_pop;
   reg [9:0] x_pos;
   reg [9:0] y_pos;
   reg [1:0] color;
   assign cX = x_pos;
   assign cY = y_pos;
   assign cl = color;
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
     end else begin
        if (!rx_fifo_empty & !tx_fifo_full & !transmit /*& !is_transmitting*/) begin
//           tx_byte <= (rx_byte-32);
           case(rx_byte)
                119: begin //w
                    tx_byte <= (rx_byte-32);
                    y_pos = y_pos + 10;
                    
                    end
                97: begin //a
                    tx_byte <= (rx_byte-32);
                    x_pos = x_pos - 10;
                        end
                115: begin //s
                    tx_byte <= (rx_byte-32);
                    y_pos = y_pos - 10;
                        end
                100: begin //d
                    tx_byte <= (rx_byte-32);
                    x_pos = x_pos + 10;
                        end
                99: begin //c
                    tx_byte <= (rx_byte-32);
                    color = 1;
                        end
                109: begin //m
                      tx_byte <= (rx_byte-32);
                      color = 2;
                        end
                121: begin //y 
                     tx_byte <= (rx_byte-32);
                     color = 3;
                     end              
                32: begin //space
                    tx_byte <= (90);
                    color=0;
                    end   
                default: begin tx_byte <= 0; end
           endcase
           transmit <= 1'b1;
           rx_fifo_pop <= 1'b1;
        end else begin
           tx_byte <= 8'h00;
           transmit <= 1'b0;
           rx_fifo_pop <= 1'b0;
        end
     end // else: !if(RESET)

endmodule // uart_echo