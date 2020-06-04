`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2020 07:48:03 PM
// Design Name: 
// Module Name: testAttack
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


module testAttack(

    );
    
    wire [7:0] damage;
    wire [7:0] atkGage;
    wire pass;
    reg start;
    reg button;
    reg clk;
    reg reset;
    
    Attack a(damage,atkGage,pass,start,button,clk,reset);
    
    always
    #5 clk =~clk;
    
    initial
    begin
    #0
    start = 1;
    button = 0;
    clk =0;
    reset = 1;
    #100 reset = 0;
//    #200 button = 1;
    #500 start = 0;
    #60 reset = 1;
    #50 reset = 0;
    #1000 $finish;  
    end
endmodule
