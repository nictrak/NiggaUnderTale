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
    input wire isRun,
    input clk

    );
    reg [35:0] mem [0:7];
    
    
    assign position1 [15:8] = mem[index1][15:8];
    assign position1 [7:0] = mem[index1][7:0];
    assign size1 [15:8] = mem[index1][31:24];
    assign size1 [7:0] = mem[index1][23:16];
    assign color1 = mem[index1][34:32];
    assign isRender1 = mem[index1][35];
    
    assign position2 [15:8] = mem[index2][15:8];
    assign position2 [7:0] = mem[index2][7:0];
    assign size2 [15:8] = mem[index1][31:24];
    assign size2 [7:0] = mem[index1][23:16];
    assign color2 = mem[index2][34:32];
    assign isRender2 = mem[index2][35];
        
    always @(posedge clk)
    begin
        if(isRun) begin
            if(mem[0][7:0] >= 200) mem[0][7:0] = 8'b0000_0001; 
            else mem[0][7:0] = mem[0][7:0] + 10;
            if(mem[1][7:0] >= 200) mem[1][7:0] = 8'b0000_0001; 
            else mem[1][7:0] = mem[1][7:0] + 10;
            if(mem[2][7:0] >= 200) mem[2][7:0] = 8'b0000_0001; 
            else mem[2][7:0] = mem[2][7:0] + 10;
        end
    end
    
    initial
    begin
    mem[0] = 35'b1_000_00000011_00000011_01000000_00000011;
    mem[1] = 35'b1_001_00000011_00000011_01100000_00000011;
    mem[2] = 35'b1_010_00000011_00000011_01010000_00000011;
    end
    
    
    
endmodule
