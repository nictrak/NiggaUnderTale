`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 12:47:07 PM
// Design Name: 
// Module Name: Bullet
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


module Bullet(
    output [31:0] state,
    output [15:0] position,
    output [15:0] size,
    output [2:0] color,
    output isRender,
    input [3:0] index,
    input clk

    );
    reg [63:0] mem [7:0];
    
    wire [31:0] state;
    
    reg [7:0] x;
    reg [7:0] y;
    wire [15:0] position;
    assign position [15:8] = x;
    assign position [7:0] = y;
    
    reg [7:0] xsize;
    reg [7:0] ysize;
    wire [15:0] size;
    assign size [15:8] = xsize;
    assign size [7:0] = ysize;
    
    reg [2:0] color;
    reg isRender;
    
    always @(posedge clk)
    begin
    x = mem[index][15:8];
    y = mem[index][7:0];
    xsize = mem[index][23:16];
    ysize = mem[index][31:24];
    color = mem[index][33:32];
    isRender = mem[index][34];
    end
    
    initial
    begin
    mem[1] = 64'b0000000000000000000000000000010111110000000011110101010110101010; 
    end
    
    
    
endmodule
