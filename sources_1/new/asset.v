`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/27/2020 02:34:05 PM
// Design Name: 
// Module Name: asset
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


module heart(
    input wire clk,
	input wire [3:0] x,
	input wire [3:0] y,
	output reg [11:0] rgb_reg
    );
    
    always @(posedge clk) begin
        case({y,x})
            8'b00000000: begin rgb_reg = 12'b000000000000; end
            8'b00000001: begin rgb_reg = 12'b000000000000; end
            8'b00000010: begin rgb_reg = 12'b000000000000; end
            8'b00000011: begin rgb_reg = 12'b000100010001; end
            8'b00000100: begin rgb_reg = 12'b000100010001; end
            8'b00000101: begin rgb_reg = 12'b000100010001; end
            8'b00000110: begin rgb_reg = 12'b000000000000; end
            8'b00000111: begin rgb_reg = 12'b000000000000; end
            8'b00001000: begin rgb_reg = 12'b000000000000; end
            8'b00001001: begin rgb_reg = 12'b000000000000; end
            8'b00001010: begin rgb_reg = 12'b000100010001; end
            8'b00001011: begin rgb_reg = 12'b000100010001; end
            8'b00001100: begin rgb_reg = 12'b000100010001; end
            8'b00001101: begin rgb_reg = 12'b000000000000; end
            8'b00001110: begin rgb_reg = 12'b000000000000; end
            8'b00001111: begin rgb_reg = 12'b000000000000; end
            8'b00010000: begin rgb_reg = 12'b000000000000; end
            8'b00010001: begin rgb_reg = 12'b000000000000; end
            8'b00010010: begin rgb_reg = 12'b000000000000; end
            8'b00010011: begin rgb_reg = 12'b010100010100; end
            8'b00010100: begin rgb_reg = 12'b011100100101; end
            8'b00010101: begin rgb_reg = 12'b011100100101; end
            8'b00010110: begin rgb_reg = 12'b000100010001; end
            8'b00010111: begin rgb_reg = 12'b000000000000; end
            8'b00011000: begin rgb_reg = 12'b000000000000; end
            8'b00011001: begin rgb_reg = 12'b000100010001; end
            8'b00011010: begin rgb_reg = 12'b011000100100; end
            8'b00011011: begin rgb_reg = 12'b011100100101; end
            8'b00011100: begin rgb_reg = 12'b011100100100; end
            8'b00011101: begin rgb_reg = 12'b000100010001; end
            8'b00011110: begin rgb_reg = 12'b000000000000; end
            8'b00011111: begin rgb_reg = 12'b000000000000; end
            8'b00100000: begin rgb_reg = 12'b000000000000; end
            8'b00100001: begin rgb_reg = 12'b000000010001; end
            8'b00100010: begin rgb_reg = 12'b011000100100; end
            8'b00100011: begin rgb_reg = 12'b110100000111; end
            8'b00100100: begin rgb_reg = 12'b111001001010; end
            8'b00100101: begin rgb_reg = 12'b111000011001; end
            8'b00100110: begin rgb_reg = 12'b100000010101; end
            8'b00100111: begin rgb_reg = 12'b001000010001; end
            8'b00101000: begin rgb_reg = 12'b000100010001; end
            8'b00101001: begin rgb_reg = 12'b011100100100; end
            8'b00101010: begin rgb_reg = 12'b111000000111; end
            8'b00101011: begin rgb_reg = 12'b111100001000; end
            8'b00101100: begin rgb_reg = 12'b111100000111; end
            8'b00101101: begin rgb_reg = 12'b011100100100; end
            8'b00101110: begin rgb_reg = 12'b000100010001; end
            8'b00101111: begin rgb_reg = 12'b000000000000; end
            8'b00110000: begin rgb_reg = 12'b000000010000; end
            8'b00110001: begin rgb_reg = 12'b011000010100; end
            8'b00110010: begin rgb_reg = 12'b111000001000; end
            8'b00110011: begin rgb_reg = 12'b111001001010; end
            8'b00110100: begin rgb_reg = 12'b111010001011; end
            8'b00110101: begin rgb_reg = 12'b111000101001; end
            8'b00110110: begin rgb_reg = 12'b111100001000; end
            8'b00110111: begin rgb_reg = 12'b100000010101; end
            8'b00111000: begin rgb_reg = 12'b011100100101; end
            8'b00111001: begin rgb_reg = 12'b111000001000; end
            8'b00111010: begin rgb_reg = 12'b111000000111; end
            8'b00111011: begin rgb_reg = 12'b111000001000; end
            8'b00111100: begin rgb_reg = 12'b111100001000; end
            8'b00111101: begin rgb_reg = 12'b111100000111; end
            8'b00111110: begin rgb_reg = 12'b011100100100; end
            8'b00111111: begin rgb_reg = 12'b000000010001; end
            8'b01000000: begin rgb_reg = 12'b001000110010; end
            8'b01000001: begin rgb_reg = 12'b110000000111; end
            8'b01000010: begin rgb_reg = 12'b111001011010; end
            8'b01000011: begin rgb_reg = 12'b111001111011; end
            8'b01000100: begin rgb_reg = 12'b111000011000; end
            8'b01000101: begin rgb_reg = 12'b111000000111; end
            8'b01000110: begin rgb_reg = 12'b111000000111; end
            8'b01000111: begin rgb_reg = 12'b111100001000; end
            8'b01001000: begin rgb_reg = 12'b111100001000; end
            8'b01001001: begin rgb_reg = 12'b111000000111; end
            8'b01001010: begin rgb_reg = 12'b111000000111; end
            8'b01001011: begin rgb_reg = 12'b111000000111; end
            8'b01001100: begin rgb_reg = 12'b111100001000; end
            8'b01001101: begin rgb_reg = 12'b111100000111; end
            8'b01001110: begin rgb_reg = 12'b111000000110; end
            8'b01001111: begin rgb_reg = 12'b001000110011; end
            8'b01010000: begin rgb_reg = 12'b001000110010; end
            8'b01010001: begin rgb_reg = 12'b110000000111; end
            8'b01010010: begin rgb_reg = 12'b111001111011; end
            8'b01010011: begin rgb_reg = 12'b111000011000; end
            8'b01010100: begin rgb_reg = 12'b111000000111; end
            8'b01010101: begin rgb_reg = 12'b111000000111; end
            8'b01010110: begin rgb_reg = 12'b111000000111; end
            8'b01010111: begin rgb_reg = 12'b111000000111; end
            8'b01011000: begin rgb_reg = 12'b111000000111; end
            8'b01011001: begin rgb_reg = 12'b111000000111; end
            8'b01011010: begin rgb_reg = 12'b111000000111; end
            8'b01011011: begin rgb_reg = 12'b111000000111; end
            8'b01011100: begin rgb_reg = 12'b111100001000; end
            8'b01011101: begin rgb_reg = 12'b111100000111; end
            8'b01011110: begin rgb_reg = 12'b111000000110; end
            8'b01011111: begin rgb_reg = 12'b001000110011; end
            8'b01100000: begin rgb_reg = 12'b001000110010; end
            8'b01100001: begin rgb_reg = 12'b110000000111; end
            8'b01100010: begin rgb_reg = 12'b111100001000; end
            8'b01100011: begin rgb_reg = 12'b111100001000; end
            8'b01100100: begin rgb_reg = 12'b111000000111; end
            8'b01100101: begin rgb_reg = 12'b111000000111; end
            8'b01100110: begin rgb_reg = 12'b111000000111; end
            8'b01100111: begin rgb_reg = 12'b111000000111; end
            8'b01101000: begin rgb_reg = 12'b111000000111; end
            8'b01101001: begin rgb_reg = 12'b111000000111; end
            8'b01101010: begin rgb_reg = 12'b111000000111; end
            8'b01101011: begin rgb_reg = 12'b111000000111; end
            8'b01101100: begin rgb_reg = 12'b111100001000; end
            8'b01101101: begin rgb_reg = 12'b111100000111; end
            8'b01101110: begin rgb_reg = 12'b111000000110; end
            8'b01101111: begin rgb_reg = 12'b001000110011; end
            8'b01110000: begin rgb_reg = 12'b000100010001; end
            8'b01110001: begin rgb_reg = 12'b100000010101; end
            8'b01110010: begin rgb_reg = 12'b111000000111; end
            8'b01110011: begin rgb_reg = 12'b111000000111; end
            8'b01110100: begin rgb_reg = 12'b111000000111; end
            8'b01110101: begin rgb_reg = 12'b111000000111; end
            8'b01110110: begin rgb_reg = 12'b111000000111; end
            8'b01110111: begin rgb_reg = 12'b111000000111; end
            8'b01111000: begin rgb_reg = 12'b111000000111; end
            8'b01111001: begin rgb_reg = 12'b111000000111; end
            8'b01111010: begin rgb_reg = 12'b111000000111; end
            8'b01111011: begin rgb_reg = 12'b111000001000; end
            8'b01111100: begin rgb_reg = 12'b111100000111; end
            8'b01111101: begin rgb_reg = 12'b111000000111; end
            8'b01111110: begin rgb_reg = 12'b100100010101; end
            8'b01111111: begin rgb_reg = 12'b000100010001; end
            8'b10000000: begin rgb_reg = 12'b000000000000; end
            8'b10000001: begin rgb_reg = 12'b001000100010; end
            8'b10000010: begin rgb_reg = 12'b110100000111; end
            8'b10000011: begin rgb_reg = 12'b111000000111; end
            8'b10000100: begin rgb_reg = 12'b111000000111; end
            8'b10000101: begin rgb_reg = 12'b111000000111; end
            8'b10000110: begin rgb_reg = 12'b111000000111; end
            8'b10000111: begin rgb_reg = 12'b111000000111; end
            8'b10001000: begin rgb_reg = 12'b111000000111; end
            8'b10001001: begin rgb_reg = 12'b111000000111; end
            8'b10001010: begin rgb_reg = 12'b111000000111; end
            8'b10001011: begin rgb_reg = 12'b111000000111; end
            8'b10001100: begin rgb_reg = 12'b111100000111; end
            8'b10001101: begin rgb_reg = 12'b111000000110; end
            8'b10001110: begin rgb_reg = 12'b001100110011; end
            8'b10001111: begin rgb_reg = 12'b000000000000; end
            8'b10010000: begin rgb_reg = 12'b000000000000; end
            8'b10010001: begin rgb_reg = 12'b000100010001; end
            8'b10010010: begin rgb_reg = 12'b100000010101; end
            8'b10010011: begin rgb_reg = 12'b110100000111; end
            8'b10010100: begin rgb_reg = 12'b111000000111; end
            8'b10010101: begin rgb_reg = 12'b111000000111; end
            8'b10010110: begin rgb_reg = 12'b111000000111; end
            8'b10010111: begin rgb_reg = 12'b111000000111; end
            8'b10011000: begin rgb_reg = 12'b111000000111; end
            8'b10011001: begin rgb_reg = 12'b111000000111; end
            8'b10011010: begin rgb_reg = 12'b111000000111; end
            8'b10011011: begin rgb_reg = 12'b111100000111; end
            8'b10011100: begin rgb_reg = 12'b111100000111; end
            8'b10011101: begin rgb_reg = 12'b100100010101; end
            8'b10011110: begin rgb_reg = 12'b000100010001; end
            8'b10011111: begin rgb_reg = 12'b000000000000; end
            8'b10100000: begin rgb_reg = 12'b000000000000; end
            8'b10100001: begin rgb_reg = 12'b000000000000; end
            8'b10100010: begin rgb_reg = 12'b000100010001; end
            8'b10100011: begin rgb_reg = 12'b011100010100; end
            8'b10100100: begin rgb_reg = 12'b111000000111; end
            8'b10100101: begin rgb_reg = 12'b111100000111; end
            8'b10100110: begin rgb_reg = 12'b111000000111; end
            8'b10100111: begin rgb_reg = 12'b111000000111; end
            8'b10101000: begin rgb_reg = 12'b111000000111; end
            8'b10101001: begin rgb_reg = 12'b111000000111; end
            8'b10101010: begin rgb_reg = 12'b111100000111; end
            8'b10101011: begin rgb_reg = 12'b111000000111; end
            8'b10101100: begin rgb_reg = 12'b101000010101; end
            8'b10101101: begin rgb_reg = 12'b000100010001; end
            8'b10101110: begin rgb_reg = 12'b000000000000; end
            8'b10101111: begin rgb_reg = 12'b000000000000; end
            8'b10110000: begin rgb_reg = 12'b000000000000; end
            8'b10110001: begin rgb_reg = 12'b000000000000; end
            8'b10110010: begin rgb_reg = 12'b000000000000; end
            8'b10110011: begin rgb_reg = 12'b000100010001; end
            8'b10110100: begin rgb_reg = 12'b100000010101; end
            8'b10110101: begin rgb_reg = 12'b110100000111; end
            8'b10110110: begin rgb_reg = 12'b111000001000; end
            8'b10110111: begin rgb_reg = 12'b111000000111; end
            8'b10111000: begin rgb_reg = 12'b111000000111; end
            8'b10111001: begin rgb_reg = 12'b111100000111; end
            8'b10111010: begin rgb_reg = 12'b111000000111; end
            8'b10111011: begin rgb_reg = 12'b100100010101; end
            8'b10111100: begin rgb_reg = 12'b001000010010; end
            8'b10111101: begin rgb_reg = 12'b000000000000; end
            8'b10111110: begin rgb_reg = 12'b000000000000; end
            8'b10111111: begin rgb_reg = 12'b000000000000; end
            8'b11000000: begin rgb_reg = 12'b000000000000; end
            8'b11000001: begin rgb_reg = 12'b000000000000; end
            8'b11000010: begin rgb_reg = 12'b000000000000; end
            8'b11000011: begin rgb_reg = 12'b000000000000; end
            8'b11000100: begin rgb_reg = 12'b000100010001; end
            8'b11000101: begin rgb_reg = 12'b011100010100; end
            8'b11000110: begin rgb_reg = 12'b111000000111; end
            8'b11000111: begin rgb_reg = 12'b111000001000; end
            8'b11001000: begin rgb_reg = 12'b111100000111; end
            8'b11001001: begin rgb_reg = 12'b111000000111; end
            8'b11001010: begin rgb_reg = 12'b100100010100; end
            8'b11001011: begin rgb_reg = 12'b000100010001; end
            8'b11001100: begin rgb_reg = 12'b000000000000; end
            8'b11001101: begin rgb_reg = 12'b000000000000; end
            8'b11001110: begin rgb_reg = 12'b000000000000; end
            8'b11001111: begin rgb_reg = 12'b000000000000; end
            8'b11010000: begin rgb_reg = 12'b000000000000; end
            8'b11010001: begin rgb_reg = 12'b000000000000; end
            8'b11010010: begin rgb_reg = 12'b000000000000; end
            8'b11010011: begin rgb_reg = 12'b000000000000; end
            8'b11010100: begin rgb_reg = 12'b000000000000; end
            8'b11010101: begin rgb_reg = 12'b000000010001; end
            8'b11010110: begin rgb_reg = 12'b100000010101; end
            8'b11010111: begin rgb_reg = 12'b111000000111; end
            8'b11011000: begin rgb_reg = 12'b111100000111; end
            8'b11011001: begin rgb_reg = 12'b100100010101; end
            8'b11011010: begin rgb_reg = 12'b001000100010; end
            8'b11011011: begin rgb_reg = 12'b000000000000; end
            8'b11011100: begin rgb_reg = 12'b000000000000; end
            8'b11011101: begin rgb_reg = 12'b000000000000; end
            8'b11011110: begin rgb_reg = 12'b000000000000; end
            8'b11011111: begin rgb_reg = 12'b000000000000; end
            8'b11100000: begin rgb_reg = 12'b000000000000; end
            8'b11100001: begin rgb_reg = 12'b000000000000; end
            8'b11100010: begin rgb_reg = 12'b000000000000; end
            8'b11100011: begin rgb_reg = 12'b000000000000; end
            8'b11100100: begin rgb_reg = 12'b000000000000; end
            8'b11100101: begin rgb_reg = 12'b000000000000; end
            8'b11100110: begin rgb_reg = 12'b000000010001; end
            8'b11100111: begin rgb_reg = 12'b100000010100; end
            8'b11101000: begin rgb_reg = 12'b100000010100; end
            8'b11101001: begin rgb_reg = 12'b000100010001; end
            8'b11101010: begin rgb_reg = 12'b000000000000; end
            8'b11101011: begin rgb_reg = 12'b000000000000; end
            8'b11101100: begin rgb_reg = 12'b000000000000; end
            8'b11101101: begin rgb_reg = 12'b000000000000; end
            8'b11101110: begin rgb_reg = 12'b000000000000; end
            8'b11101111: begin rgb_reg = 12'b000000000000; end
            8'b11110000: begin rgb_reg = 12'b000000000000; end
            8'b11110001: begin rgb_reg = 12'b000000000000; end
            8'b11110010: begin rgb_reg = 12'b000000000000; end
            8'b11110011: begin rgb_reg = 12'b000000000000; end
            8'b11110100: begin rgb_reg = 12'b000000000000; end
            8'b11110101: begin rgb_reg = 12'b000000000000; end
            8'b11110110: begin rgb_reg = 12'b000000000000; end
            8'b11110111: begin rgb_reg = 12'b000100010001; end
            8'b11111000: begin rgb_reg = 12'b000100010001; end
            8'b11111001: begin rgb_reg = 12'b000000000000; end
            8'b11111010: begin rgb_reg = 12'b000000000000; end
            8'b11111011: begin rgb_reg = 12'b000000000000; end
            8'b11111100: begin rgb_reg = 12'b000000000000; end
            8'b11111101: begin rgb_reg = 12'b000000000000; end
            8'b11111110: begin rgb_reg = 12'b000000000000; end
            8'b11111111: begin rgb_reg = 12'b000000000000; end
        endcase
    end  
endmodule
