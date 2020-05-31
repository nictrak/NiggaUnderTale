`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.05.2020 14:35:12
// Design Name: 
// Module Name: clock
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


module clock(
output clk_1hz,
output clk_10hz,
output clk_20hz,
output clk_40hz,
output clk_8,
output clk2_10,
input clk
);
    wire [27:0] tclk;
    assign tclk[0]=clk;
    assign clk_1hz=tclk[27];
    assign clk_10hz=tclk[23];
    assign clk_20hz=tclk[22];
    assign clk_40hz=tclk[21];
    assign clk_8=tclk[3];
    assign clk2_10=tclk[18];
    genvar c;
    generate for(c=0; c<27; c=c+1)
        begin
            clockDiv fdiv(tclk[c+1], tclk[c]);
        end
    endgenerate
    
endmodule

module clockDiv(
    output clkDiv,
    input clk
    );
    reg clkDiv;
    initial
    begin
        clkDiv=0;
    end
    always @(posedge clk)
    begin
        clkDiv=~clkDiv;
    end
endmodule

//module counter10(
//output clk10,
//input clk
//);
//    reg [4:0] i=0;
//    reg val=0;
    
//    assign clk10 = val;
    
//    always @(posedge clk)
//    begin
//        if(i==9)
//        begin
//            val <= 1;
//            i <= 0;
//        end
//        else begin
//            i <= i+1;
//            val <= 0;
//        end
//    end
    
//endmodule



