`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2020 01:14:03 PM
// Design Name: 
// Module Name: testBullet
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


module testBullet(

    );
    wire[15:0] position1;
    wire[15:0] size1;
    wire[2:0] color1; //000 = white , 001 = green , 010 = blue
    wire isRender1;
    wire[15:0] position2;
    wire[15:0] size2;
    wire[2:0] color2;
    wire isRender2;
    reg[2:0] index1;
    reg[2:0] index2;
    reg isRun;
    reg clk;
    
    Bullet a(position1,size1,color1,isRender1,position2,size2,color2,isRender2,index1,index2,isRun,clk);
    
    always
    #5 clk=~clk;
    initial
    begin
    index1 = 0;
    index2 = 0;
    clk=0;
    isRun = 1;
    #500 index1 = 1;
    #1000 $finish;
    end
    
    
endmodule
