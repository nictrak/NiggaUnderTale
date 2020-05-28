`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/28/2020 04:48:39 PM
// Design Name: 
// Module Name: keyConverter
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


module keyConverter(
    output wire [3:0] out,
    input wire [7:0] key,
    input clk
    );
    
    
    reg [3:0] index = 15;
    reg [3:0] indexl = 15;
    
    assign out = index;
    
    always @(posedge clk)
    begin
        if (indexl > 0 && indexl < 8 && key[8-indexl] === 1) index = indexl;
        else begin
            case(key)
                8'b10000000: index = 1; //W
                8'b01000000: index = 3; //S
                8'b00100000: index = 4; //A
                8'b00010000: index = 2; //D
                8'b00001000: index = 5; //J
                8'b00000100: index = 6; //K
                8'b00000010: index = 7; //L
                8'b00000001: index = 8; //SPACE
                default: index = 0;
            endcase
         end
         indexl = index;
    end
    
//    always @(index)
//    begin
//        case(index)
//            0: out = 4'b0001;
//            1: out = 4'b0000;
//            2: out = 4'b0001;
//            3: out = 4'b0001;
//            4: out = 4'b0001;
//            5: out = 4'b0001;
//            6: out = 4'b0001;
//            7: out = 4'b0001;           
//    end
    
endmodule
