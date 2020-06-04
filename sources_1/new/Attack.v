`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 01:13:34 PM
// Design Name: 
// Module Name: Attack
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


module Attack(
    output [7:0] damage,
    output [7:0] atkGage,
    output pass,
    input start,
    input button,
    input clk,
    input reset

    );
    
    parameter max = 248;
    parameter half = 127;
    
    reg [7:0] atkGage=0;
    reg [7:0] damage;
    reg [7:0] atkCon;
    wire reset;
    
    parameter ATK = 10;
    
    reg pass; //pass is 0 when attack phase is rendering.
    
    always @(posedge clk)
    begin
        if(reset === 1)
        begin
            atkGage = 0;
            atkCon = half;
            damage = 0;
            pass = 0;
        end
        else if(start === 1)
        begin
        if(button === 0)
            begin
                if (atkGage >= max)
                    begin
                        pass = 1;
                    end
               else atkGage = atkGage + 4;
            end
            else begin
                if (atkGage < half) atkCon = half - atkGage;
                else atkCon = atkGage - half;
                
                if (atkCon < (half/4)) damage = ATK*2;
                else if (atkCon < (half/2)) damage = ATK;
                pass = 1;
            end
        end
    end
    
    initial
    begin
    pass = 0;
    damage = 0;   
    end 
    
endmodule
