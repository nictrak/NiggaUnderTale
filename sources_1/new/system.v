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
reg [15:0] bulletPos = 16'b0;
reg [2:0] bulletColor = 3'b0;
reg [31:0] state = 32'b0;
reg isRender = 1;
wire [2:0] index = 3'b0;
vga_test vga(
    .clk(clk),
    .isRender(isRender), 
    .playerPos(playerPos),
    .bulletPos(bulletPos),
    .bulletColor(bulletColor),
    .state(state),
    .hsync(Hsync),
    .vsync(Vsync),
    .rgb({vgaRed, vgaGreen, vgaBlue}),
    .index(index)
);

wire clk_1hz;
wire clk_10hz;
clock(clk_1hz,clk_10hz,clk);

wire [15:0] playerInstruction;
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