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
    
    wire [15:0] position1;
    wire [15:0] size1;
    wire [2:0] color1;
    wire isRender1;
    wire [2:0] index1;

    wire [15:0] position2;
    wire [15:0] size2;
    wire [2:0] color2;
    wire isRender2;
    wire [2:0] index2;
    
    Bullet b(position1,size1,color1,isRender1,position2,size2,color2,isRender2,index1,index2,clk);
    
    wire [7:0] damage;
    wire isComplete;
    wire isCollide;
    reg isMove;
    reg start;
    wire heal;
    DamageCalculator dmc(damage, isComplete, index1, heal, isCollide, isMove, color1 ,start, clk);
    
    wire [31:0] pystate;
    wire [15:0] pyposition;
    wire pyisDeath;
    reg [15:0] pyinstruction;
    wire [7:0] pyHP;
    wire [7:0] pyATK;
    wire [7:0] pysize;
    Player p(pystate,pyposition,pyisDeath,pyinstruction,clk,pyHP,pyATK,pysize);
    
    
    CheckCollision c(isCollide,pyposition[15:8], pyposition[7:0], pysize, pysize,position1[15:8], position1[7:0], size1, size1);
    
    
    
    
    initial
    begin
        #0
        clk = 0;
        isMove = 0;
        start = 0;
        #10 start = 1;
        #100 start = 0;
        #10 isMove = 1;
        #20 start = 1;
        
        #1000 $finish;
    end
endmodule
