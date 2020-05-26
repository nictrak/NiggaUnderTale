`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2019 03:09:33 PM
// Design Name: 
// Module Name: system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module system(
    output wire RsTx,
    input wire RsRx,
    output wire [10:0]led,
    output wire [3:0]vgaRed, vgaGreen, vgaBlue,
    output wire Hsync, Vsync,
    input wire [11:0]sw,
    input btnC, btnU, btnL, clk
    );
 
wire [9:0] cX, cY;
wire [1:0] cl;
//initial begin
//    cX = 600;
//    cY = 100;
//end
    
vga_test vga(
    .clk(clk), 
    .sw(sw),
    .C({cX, cY}),
    .color(cl),
    .hsync(Hsync),
    .vsync(Vsync),
    .rgb({vgaRed, vgaGreen, vgaBlue})
);

uart_echo u2(
.TX(RsTx),
.cX(cY),.cY(cX),.cl(cl),
.CLK(clk),
.RESET(reset),
.RX(RsRx)
);

always @(cX or cY or cl)
begin
$display("x_pos:%d, y_pos: %d, color:%d\n",x_pos, y_pos,color);
end

endmodule