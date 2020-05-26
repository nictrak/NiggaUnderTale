`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 01:18:43 AM
// Design Name: 
// Module Name: testBullet2
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


module testBullet2(

    );
    wire [31:0] state;
    wire [15:0] position;
    wire [15:0] size;
    wire [2:0] color;
    wire isRender;
    reg [2:0] index;
    reg clk;
    
    Bullet a(state,position,size,color,isRender,index,clk);
    
    always
    #5 clk=~clk;
    initial
    begin
    index = 0;
    clk=0;
    
    #10 index = 1;
    #100 $finish;
    end
endmodule
