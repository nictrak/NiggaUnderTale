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
    output wire[15:0] position1,
    output wire[15:0] size1,
    output wire[2:0] color1, //000 = white , 001 = green , 010 = blue
    output wire isRender1,
    output wire[15:0] position2,
    output wire[15:0] size2,
    output wire[2:0] color2,
    output wire isRender2,
    input wire[2:0] index1,
    input wire[2:0] index2,
    input clk

    );
    reg [63:0] mem [0:7];
    
    
    assign position1 [15:8] = mem[index1][15:8];
    assign position1 [7:0] = mem[index1][7:0];
    assign size1 [15:8] = mem[index1][23:16];
    assign size1 [7:0] = mem[index1][31:24];
    assign color1 = mem[index1][33:32];
    assign isRender1 = mem[index1][34];
    
    assign position2 [15:8] = mem[index2][15:8];
    assign position2 [7:0] = mem[index2][7:0];
    assign size2 [15:8] = mem[index2][23:16];
    assign size2 [7:0] = mem[index2][31:24];
    assign color2 = mem[index2][33:32];
    assign isRender2 = mem[index2][34];
        
    always @(posedge clk)
    begin
    end
    
    initial
    begin
    mem[1] = 64'b00000000_00000000_00000000_00000000_01010000_01010000_00000100_00000100; //test
    mem[2] = 64'b00000000_00000000_00000000_00000001_01010000_01010000_00000100_00000100; //test
    mem[3] = 64'b00000000_00000000_00000000_00000010_01010000_01010000_00000100_00000100; //test
    end
    
    
    
endmodule
