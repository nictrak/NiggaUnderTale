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
    output [7:0] half,
    output [7:0] max,
    output [7:0] atkGage,
    output pass,
    input start,
    input button,
    input clk

    );
    
    reg [7:0] max = 255;
    reg [7:0] half = 127;
    
    reg [7:0] atkGage;
    reg [7:0] damage;
    reg [7:0] atkCon;
    reg [7:0] ATK = 10;
    
    reg pass;
    
    always @(posedge clk)
    begin
        if(start == 1 & pass == 1)
        begin
            atkGage = 0;
            atkCon = half;
            damage = 0;
            pass = 0;
        end
        else if(pass == 0)
        begin
            atkGage = atkGage + 4;
            if (atkGage == max)
            begin
                pass = 1;
            end
            else if (button == 1)
            begin
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
    pass = 1;
    damage = 0;   
    end 
    
endmodule
