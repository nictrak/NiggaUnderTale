`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 03:15:42 PM
// Design Name: 
// Module Name: instructionTest
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


module instructionTest(

    );
    wire[15:0] playerInstruction;
    wire isMove;
    wire[7:0] monHP;
    wire[7:0] state;
    reg[3:0] keyboard;
    wire isDeath;
    reg atkPass;
    reg[7:0] dmgMon;
    reg clk;
    Machine m(state, playerInstruction, isMove, monHP, keyboard, isDeath, atkPass, dmgMon, clk);
    
    wire[31:0] pState;
    wire[15:0]position;
    wire[7:0]size;
    wire[7:0] HP;
    wire[7:0] ATK;

    Player p(pState, position, size, isDeath, HP, ATK, playerInstruction, clk);
    
    always
    #5 clk=~clk;
    
    initial begin
        #0
        clk = 0;
        keyboard = 0;
        atkPass = 0;
        dmgMon = 10;
        #55 keyboard = 4'b0101;
        #5 keyboard = 4'b0000;  
        #1000 $finish;
    end
    
endmodule
