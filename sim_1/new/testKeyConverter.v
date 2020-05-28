`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 05:10:44 PM
// Design Name: 
// Module Name: testKeyConverter
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


module testKeyConverter(

    );
    
    reg clk;
    reg [7:0]key;
    wire [3:0]out;
    
    keyConverter a(out,key,clk);
    
    always
    begin
    #5 clk=~clk;
    end
    
    initial
    begin
    clk=0;
    key=0;
    #15 key = 8'b01110000;
    #15 key = 8'b00000001;
    #15 key = 8'b00010000;
    #15 key = 8'b01110000;
    #15 key = 8'b10000000;
    #15 key = 8'b00000110;
    #15 key = 8'b00010000;
    #15 key = 8'b00011111;
    #15 key = 8'b01110000;
    #15 key = 8'b00000010;
    #15 key = 8'b00000100;
    #15 key = 8'b00000000;
    
    #1000 $finish;
    
    end
endmodule
