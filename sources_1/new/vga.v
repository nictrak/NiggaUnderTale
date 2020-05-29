`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2019 03:31:32 PM
// Design Name: 
// Module Name: vga
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
module vga_sync
	(
		input wire clk, reset,
		output wire hsync, vsync, p_tick,
		output wire [9:0] x, y
	);
	
	// constant declarations for VGA sync parameters
	localparam H_DISPLAY       = 640; // horizontal display area
	localparam H_L_BORDER      =  48; // horizontal left border
	localparam H_R_BORDER      =  16; // horizontal right border
	localparam H_RETRACE       =  96; // horizontal retrace
	localparam H_MAX           = H_DISPLAY + H_L_BORDER + H_R_BORDER + H_RETRACE - 1;
	localparam START_H_RETRACE = H_DISPLAY + H_R_BORDER;
	localparam END_H_RETRACE   = H_DISPLAY + H_R_BORDER + H_RETRACE - 1;
	localparam RADIUS          = 100; 
	
	localparam V_DISPLAY       = 480; // vertical display area
	localparam V_T_BORDER      =  10; // vertical top border
	localparam V_B_BORDER      =  33; // vertical bottom border
	localparam V_RETRACE       =   2; // vertical retrace
	localparam V_MAX           = V_DISPLAY + V_T_BORDER + V_B_BORDER + V_RETRACE - 1;
        localparam START_V_RETRACE = V_DISPLAY + V_B_BORDER;
	localparam END_V_RETRACE   = V_DISPLAY + V_B_BORDER + V_RETRACE - 1;
	
	// mod-4 counter to generate 25 MHz pixel tick
	reg [1:0] pixel_reg;
	wire [1:0] pixel_next;
	wire pixel_tick;
	
	always @(posedge clk, posedge reset)
		if(reset)
		  pixel_reg <= 0;
		else
		  pixel_reg <= pixel_next;
	
	assign pixel_next = pixel_reg + 1; // increment pixel_reg 
	
	assign pixel_tick = (pixel_reg == 0); // assert tick 1/4 of the time
	
	// registers to keep track of current pixel location
	reg [9:0] h_count_reg, h_count_next, v_count_reg, v_count_next;
	
	// register to keep track of vsync and hsync signal states
	reg vsync_reg, hsync_reg;
	wire vsync_next, hsync_next;
 
	// infer registers
	always @(posedge clk, posedge reset)
		if(reset)
		    begin
                    v_count_reg <= 0;
                    h_count_reg <= 0;
                    vsync_reg   <= 0;
                    hsync_reg   <= 0;
		    end
		else
		    begin
                    v_count_reg <= v_count_next;
                    h_count_reg <= h_count_next;
                    vsync_reg   <= vsync_next;
                    hsync_reg   <= hsync_next;
		    end
			
	// next-state logic of horizontal vertical sync counters
	always @*
		begin
		h_count_next = pixel_tick ? 
		               h_count_reg == H_MAX ? 0 : h_count_reg + 1
			       : h_count_reg;
		
		v_count_next = pixel_tick && h_count_reg == H_MAX ? 
		               (v_count_reg == V_MAX ? 0 : v_count_reg + 1) 
			       : v_count_reg;
		end
		
        // hsync and vsync are active low signals
        // hsync signal asserted during horizontal retrace
        assign hsync_next = h_count_reg >= START_H_RETRACE
                            && h_count_reg <= END_H_RETRACE;
   
        // vsync signal asserted during vertical retrace
        assign vsync_next = v_count_reg >= START_V_RETRACE 
                            && v_count_reg <= END_V_RETRACE;

        // video only on when pixels are in both horizontal and vertical display region
        // output signals
        assign hsync  = hsync_reg;
        assign vsync  = vsync_reg;
        assign x      = h_count_reg;
        assign y      = v_count_reg;
        assign p_tick = pixel_tick;
endmodule

module vga_test
	(
		input wire clk,
		input wire isRender,
		input wire [15:0] playerPos,
		input wire [15:0] bulletPos,
		input wire [1:0] bulletColor,
		input wire [31:0] state,
		output wire hsync, vsync,
		output wire [11:0] rgb,
		output wire [2:0] index
	);

	parameter WIDTH = 640;
	parameter HEIGHT = 480;
	parameter PLAYAREAX = 320;
	parameter PLAYAREAY = 240;
	//parameter POSX = 320;
	//parameter POSY = 240;
	
	wire [9:0] POSX;
	assign POSX = playerPos[15:8]+220;
	wire [9:0] POSY;
	assign POSY = playerPos[7:0]+140;
		
	// register for Basys 2 8-bit RGB DAC 
	reg [11:0] rgb_reg;
	reg reset = 0;
	reg [3:0] heartX, heartY;
	wire [9:0] x, y;
	wire [11:0] heartRGB;

	// video status output from vga_sync to tell when to route out rgb signal to DAC
    wire p_tick;
	// instantiate vga_sync
	vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .p_tick(p_tick), .x(x), .y(y));
    heart player (.clk(clk), .x(heartX), .y(heartY), .rgb_reg(heartRGB));
    
	always @(posedge clk) begin
        if (reset)
            rgb_reg <= 0;
        else
            //generic circle
//            if(((x-C[9:0])*(x-C[9:0])+(y-C[19:10])*(y-C[19:10])) <= 10000)
//                    video = 1;
            //play area
            if((x>=PLAYAREAX-103 && x<=PLAYAREAX-100 && y>=PLAYAREAY-103 && y<=PLAYAREAY+103) ||
                (x>=PLAYAREAX+100 && x<=PLAYAREAX+103 && y>=PLAYAREAY-103 && y<=PLAYAREAY+103) ||
                (x>=PLAYAREAX-103 && x<=PLAYAREAX+103 && y>=PLAYAREAY-103 && y<=PLAYAREAY-100) ||
                (x>=PLAYAREAX-103 && x<=PLAYAREAX+103 && y>=PLAYAREAY+100 && y<=PLAYAREAY+103))
                    rgb_reg <= 12'b111111111111;
            //heart
            else if(x>=POSX-8 && x<=POSX+8 && y>=POSY-8 && y<=POSY+8)
                begin
                    heartX = (x-(POSX-8));
                    heartY = (y-(POSY-8));
                    rgb_reg = heartRGB; 
                end
            
            else rgb_reg <= 12'b000000000000;
            //hp bar
            
//            case(color)
//                2'b00: rgb_reg <= 12'b111111111111;
//                2'b01: rgb_reg <= 12'b000011111111;
//                2'b10: rgb_reg <= 12'b111100001111;
//                2'b11: rgb_reg <= 12'b111111110000;
//            endcase
    end
	        
//	output
	assign rgb = rgb_reg;
endmodule

