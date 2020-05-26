`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2020 02:26:43 PM
// Design Name: 
// Module Name: machine
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


module Machine(
    output reg[7:0] nextState,
    output reg[3:0] playerInstructiuon,
    output reg isMove,
    input wire[7:0] state,
    input wire[3:0] keyboard,
    input wire[3:0] menu,
    input wire isDeath,
    input wire clk
    );
    
    //key enum
    parameter IDLE = 4'b0000;
    parameter UP = 4'b0001;
    parameter LEFT = 4'b0010;
    parameter DOWN = 4'b0011;
    parameter RIGHT = 4'b0100;
    parameter ENTER = 4'b0101;
    
    //page enum
    parameter NULL = 4'b0000; //blank screen do nothing
    parameter MENU = 4'b0001; //menu screen, start game, credit and start button
    parameter START = 4'b1000; //start screen wait game setting
    parameter DODGE = 4'b1001; //dodge bullets state
    parameter ATTACK = 4'b1010; //attack monster state
    parameter ACTION = 4'b1011; //choose action state
    
    wire[3:0] page;
    wire[3:0] substage;
    assign keyboard = state[7:4];
    assign menuInp = state[3:0];
    assign page = 0;
    
    
    
endmodule
