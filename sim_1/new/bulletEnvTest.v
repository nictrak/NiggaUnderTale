`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 01:01:38 AM
// Design Name: 
// Module Name: bulletEnvTest
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


module bulletEnvTest(

    );
    //implement clock
    reg clk;
    always
 #5 clk=~clk;
    
    wire [31:0] state;
    wire [15:0] position;
    wire [15:0] size;
    wire [2:0] color;
    wire isRender;
    wire [2:0] index;
    Bullet b(state,position,size,color,isRender,index,clk);
    
    wire [7:0] damage;
    wire isComplete;
    reg isCollide;
    reg isMove;
    reg start;
    DamageCalculator dmc(damage, isComplete, index, isCollide, isMove, color ,start, clk);
    
    initial
    begin
        #0
        clk = 0;
        isCollide = 0;
        isMove = 0;
        start = 0;
        #10 start = 1;
        
        #1000 $finish;
    end
endmodule
