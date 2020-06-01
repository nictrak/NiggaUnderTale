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
    wire startDmg;
    wire[7:0] state;
    reg[3:0] keyboard;
    wire isDeath;
    reg atkPass;
    reg[7:0] dmgMon;
    reg isDmgComplete;
    reg[7:0] damage;
    reg heal;
    reg clk;
    Machine m(state, playerInstruction, isMove, monHP, startDmg, keyboard, isDeath, atkPass, dmgMon, isDmgComplete, damage, heal,clk);
    
    wire[31:0] pState;
    wire[15:0]position;
    wire[7:0]size;
    wire[7:0] HP;
    wire[7:0] ATK;

    Player p(pState, position, size, isDeath, HP, ATK, playerInstruction, clk, clk);
    
    always
    #5 clk=~clk;
    
    initial begin
        #0
        clk = 0;
        keyboard = 0;
        atkPass = 0;
        dmgMon = 10;
        isDmgComplete = 0;
        damage = 0;
        heal = 0;  
        #55 keyboard = 4'b1000;
        #5 keyboard = 4'b0000;
        #15 keyboard = 4'b0001;
        #5 keyboard = 4'b0000;
        #5 keyboard = 4'b0010;
        #5 keyboard = 4'b0000;  
        #5 keyboard = 4'b0011;
        #5 keyboard = 4'b0000;  
        #5 keyboard = 4'b0100;
        #5 keyboard = 4'b0000;
        #15 isDmgComplete = 1;
        damage = 5;
        heal = 0;
        #5
        isDmgComplete = 0;
        damage = 0;
        heal = 0;         
        #1000 $finish;
    end
    
endmodule
