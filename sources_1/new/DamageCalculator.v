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
    input wire isCollide,
    input wire isMove, //Is player move?
    input wire color, //bullet color
    input wire start, //start pulse
    input wire clk
    );
    
    parameter attackPower = 50;
    
    reg isRun;
    
    initial begin
        damage = 0;
        index = 0;
        isRun = 0;
        isComplete = 0;
    end
    
    //start iteration
    always @(posedge start) begin
        isRun = 1;
        damage = 0;
        index = 0;
        isComplete = 0;
    end
    
    always @(posedge clk) begin
        if(isRun) begin
            if(isCollide) begin
                //TODO color check before add damge
                damage = damage + attackPower;
            end
            if(index === 7) begin
                    isComplete = 1;
                    isRun = 0;
            end else index = index + 1;
        end
    end
    
endmodule