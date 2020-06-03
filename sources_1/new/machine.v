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
    output reg[7:0] state,
    output reg[15:0] playerInstruction,
    output reg isMove,
    output reg[7:0] monHP,
    output reg startDmg,
    input wire[7:0] keyboard,
    input wire isDeath,
    input wire atkPass,
    input wire[7:0] dmgMon,
    input wire isDmgComplete,
    input wire[7:0] damage,
    input wire heal,
    input wire clk,
    input wire clk_1hz,
    output reg atkstart,
    output reg atkbutton,
    output reg atkreset
    );
    
    parameter ZERO = 4'b0000; // for IDLE
    //key enum
    parameter W = 4'b0001;
    parameter A = 4'b0010;
    parameter S = 4'b0011;
    parameter D = 4'b0100;
    parameter J = 4'b0101;
    parameter K = 4'b0110;
    parameter L = 4'b0111;
    parameter SPACE = 4'b1000;
    
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
    
    //direction
    parameter UP = 8'b0000_0000;
    parameter LEFT = 8'b0000_0001;
    parameter DOWN = 8'b0000_0010;
    parameter RIGHT = 8'b0000_0011;
    
    parameter DODGE_TIME = 7;
    parameter ATK_TIME = 2;
    
    wire[3:0] page;
    wire[3:0] substage;
    assign page = state[7:4];
    assign substate = state[3:0];
    
    reg[7:0] nextState;
    reg[3:0] timer;
    reg[3:0] timer2;
    reg[3:0] timer3;
    
    wire [3:0] key; 
    keyConverter kc(key,keyboard,clk);

    
    
    initial begin
        state = {MENU, ZERO};
        nextState = {MENU, ZERO};
        monHP = 0;
        isMove = 0;
        playerInstruction = {ZERO, ZERO, ZERO, ZERO};
        timer = 0;
        timer2 = 0;
        timer3 = 0;
        atkstart = 0;
        atkbutton = 0;
        atkreset = 1;
    end
    
    always @(posedge clk_1hz) begin
        if(page === DODGE) begin
            timer = timer + 1;
        end
        else timer = ZERO;
        if(page === ACTION) begin
            timer2 = timer2 + 1;
        end
        else timer2 = ZERO;
         if(page === ATTACK) begin
            timer3 = timer3 + 1;
        end
        else timer3 = ZERO;
    end
    
    always @(posedge clk) begin
        startDmg = 0;
        nextState = state;
        isMove = 0;
        case(page)
            default: begin
                nextState = {MENU, ZERO};
            end
            MENU: begin
                if(key === SPACE) begin
                    nextState = {DODGE, ZERO};
                    monHP = 0;
                end
            end
            DODGE: begin
                if(timer >= DODGE_TIME) begin
                nextState = {ATTACK, ZERO};
                atkstart = 1;
                atkreset = 0;
                end
                else if(isDeath === 1) begin
                         nextState = {MENU, ZERO};
                end
                else if(isDmgComplete===1) begin
                    if(heal===1) playerInstruction = {HPY, 8'b0000_1010, ZERO}; 
                    else if(damage >= 0) playerInstruction = {DPY, damage, ZERO};
                    startDmg = 1;
                end else begin
                    if(key > 0) isMove = 1; 
                    case(key)
                        W: playerInstruction = {MOV, UP, ZERO};
                        A: playerInstruction = {MOV, LEFT, ZERO};
                        S: playerInstruction = {MOV, DOWN, ZERO};
                        D: playerInstruction = {MOV, RIGHT, ZERO};
                        ZERO: playerInstruction = {ZERO, ZERO, ZERO, ZERO};
                        default: playerInstruction = {ZERO, ZERO, ZERO, ZERO};
                    endcase
                end
            end
            ACTION: begin
                if(timer2 >= DODGE_TIME) nextState = {DODGE, ZERO};
            end
            ATTACK: begin
//                if (timer3 >= ATK_TIME) nextState = {DODGE, ZERO};
//                atkstart = 1; 
//                if (atkPass === 1) begin
//                    monHP = monHP + dmgMon;
//                    if (monHP > 100) begin
//                         nextState = {DODGE, ZERO};
//                    end
//                    else begin
//                        nextState = {DODGE, ZERO};
//                    end
//                    atkstart = 0;
//                    atkbutton = 0;
//                end
//                else if(key === SPACE)begin
//                    atkbutton = 1;
//                end
                
                if(key === SPACE) begin
                    nextState = {DODGE, ZERO};
                    atkbutton = 1;                     
                     atkstart = 0;
                     atkreset = 1;
                end
                if(atkPass === 1) begin
                    nextState = {DODGE, ZERO};
                    atkstart = 0;
                     atkreset = 1;
                end
            end
        endcase
        state = nextState;
     end
endmodule 
