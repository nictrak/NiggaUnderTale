`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2019 03:09:33 PM
// Design Name: 
// Module Name: system
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
module system(
    output wire RsTx,
    input wire RsRx,
    output wire [10:0]led,
    output wire [3:0]vgaRed, vgaGreen, vgaBlue,
    output wire Hsync, Vsync,
    input wire [11:0]sw,
    input btnC, btnU, btnL, clk
    );
 
wire [9:0] cX, cY;
wire [1:0] cl;
//initial begin
//    cX = 600;
//    cY = 100;
//end
wire [15:0] playerPos;
wire [15:0] bulletPos;
wire [2:0] bulletColor;
wire [31:0] state = {8'b10010000,monHPrender,pHP,8'b00000000};
wire [7:0]monHPrender = 100-monHP; 
wire isRender;
wire [2:0] index;
vga_test vga(
    .clk(clk),
    .isRender(isRender), 
    .playerPos(playerPos),
    .bulletPos(bulletPos),
    .bulletColor(bulletColor[1:0]),
    .state(state),
    .hsync(Hsync),
    .vsync(Vsync),
    .rgb({vgaRed, vgaGreen, vgaBlue}),
    .index(index),
    .clk2_10(clk2_10)
);

wire clk_1hz;
wire clk_10hz;
clock(clk_1hz,clk_10hz,clk_20hz,clk_40hz,clk_8,clk2_10,clk);

wire [15:0] bulletSize;
wire [15:0] bulletSize2;
wire [15:0] playerPos2;
wire [15:0] bulletPos2;
wire [2:0] bulletColor2;
wire isRender2;
wire [2:0] index2;
reg isRun = 1;

Bullet b(bulletPos,bulletSize,bulletColor,isRender,bulletPos2,bulletSize2,bulletColor2,isRender2,index,index2,isRun,clk_10hz);

wire [15:0] playerInstruction;
wire [31:0] pstate;
wire [7:0] psize;
wire [7:0] pHP;
wire [7:0] pATK;
Player p(pstate,playerPos,psize,isDeath,pHP,pATK,playerInstruction,clk,clk_10hz);


    wire [7:0] mstate;
    wire isMove;
    wire[7:0] monHP;
    wire startDmg;
    wire[7:0] key;
    wire isDeath;
    wire atkPass;
    wire[7:0] dmgMon;
    wire isDmgComplete;
    wire[7:0] damage;
    wire heal;

Machine m(mstate,playerInstruction,isMove,monHP,startDmg,key,isDeath,atkPass,dmgMon,isDmgComplete,damage,heal,clk);


reg reset;
always @(posedge clk_20hz)
reset = ~reset;

uart_echo u2(
.TX(RsTx),
.keys(key),
.CLK(clk),
.RESET(reset),
.RX(RsRx)
);

always @(cX or cY or cl)
begin
$display("x_pos:%d, y_pos: %d, color:%d\n",x_pos, y_pos,color);
end

endmodule