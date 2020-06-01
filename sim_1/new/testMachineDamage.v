`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 07:41:41 PM
// Design Name: 
// Module Name: testMachineDamage
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


module testMachineDamage(

    );
    
    wire[7:0] state;
    wire[15:0] playerInstruction;
    wire isMove;
    wire[7:0] monHP;
    wire startDmg;
    reg [7:0] keyboard =0;
    reg isDeath = 0;
    reg atkPass =0;
    reg[7:0] dmgMon=0;
    reg isDmgComplete;
    reg[7:0] damage;
    reg heal;
    reg clk;
    
    Machine m(state,playerInstruction,isMove,monHP,startDmg,keyboard,isDeath,atkPass,dmgMon,isDmgComplete,damage,heal,clk);
    
    always
    #5 clk = ~clk;
    
    initial
    begin
    isDmgComplete = 0;
    damage = 10;
    heal =0;
    clk =0;
    #20 isDmgComplete =1;
    #20 heal =1;
    #1000 $finish;
    end
    
endmodule
