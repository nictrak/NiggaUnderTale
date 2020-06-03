`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 02:16:27 AM
// Design Name: 
// Module Name: DamageCalculator
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


module DamageCalculator(
    output reg[7:0] damage,
    output reg isComplete,
    output reg[2:0] index,
    output reg heal,
    output reg[2:0] indexCollide,
    input wire isCollide,
    input wire isRender,
    input wire isMove, //Is player move?
    input wire [2:0] color, //bullet color
    input wire start, //start pulse
    input wire clk
    );
    
    parameter attackPower = 10;
    
    reg isRun;
    
    initial begin
        damage = 0;
        index = 0;
        isRun = 0;
        isComplete = 0;
        heal = 0;
        indexCollide = 3'b111;
    end
    
    always @(posedge clk) begin
        if(start == 1) begin
            isRun = 1;
            damage = 0;
            index = 0;
            isComplete = 0;
            heal = 0;
            indexCollide = 3'b111;
        end else begin
            if(isComplete===1) isComplete = 0;
            if(isRun===1) begin
                if(isCollide===1 && isRender===1) begin
                    //TODO color check before add damge
                    if (color == 0)damage = damage + attackPower;
                    else if (color == 1) heal = 1;
                    else if (color == 2 && isMove == 1) damage = damage + attackPower;
                    indexCollide[index] = 0;
                end
                if(index === 2) begin
                        isComplete = 1;
                        isRun = 0;
                end else index = index + 1;
            end
       end
    end
    
endmodule