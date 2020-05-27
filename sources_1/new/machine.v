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
    output wire[7:0] nextState,
    output reg[3:0] playerInstructiuon,
    output reg isMove,
    input wire[7:0] state,
    input wire[3:0] keyboard,
    input wire[3:0] menu,
    input wire isDeath,
    input wire clk
    );
    
    parameter ZERO = 4'b0000; // for IDLE
    //key enum
    parameter W = 4'b0001;
    parameter D = 4'b0010;
    parameter S = 4'b0011;
    parameter A = 4'b0100;
    parameter SPACE = 4'b0101;
    
    //page enum
    parameter NULL = 4'b0000; //blank screen do nothing
    parameter MENU = 4'b0001; //menu screen, start game, credit and start button
    parameter START = 4'b1000; //start screen wait game setting
    parameter DODGE = 4'b1001; //dodge bullets state
    parameter ATTACK = 4'b1010; //attack monster state
    parameter ACTION = 4'b1011; //choose action state
    
    //op code
    parameter HPY = 4'b0001;
    parameter DPY = 4'b0010;
    parameter IDG = 4'b0011;
    parameter SDG = 4'b0100;
    parameter MOV = 4'b0101;
    parameter SHP = 4'b0110;
    
    wire[3:0] page;
    wire[3:0] substage;
    assign page = state[7:4];
    assign substage = state[3:0];
    
    reg[3:0] nextPage;
    reg[3:0] nextSubstage;
    assign nextStage = {nextPage, nextSubstage};
    
    initial begin
        nextPage = ZERO;
        nextSubstage = ZERO;
    end
    
    always @(posedge clk) begin
        nextPage = page;
        nextSubstage = substage;
        case(page)
            MENU: begin
                if(keyboard === SPACE) begin
                    nextPage = START;
                    nextSubstage = ZERO;
                end
            end
            START: begin
            end
        endcase
    end    
   
    
endmodule
