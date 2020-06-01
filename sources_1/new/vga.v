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
		output reg [2:0] index,
		input wire clk2_10
	);

	parameter WIDTH = 640;
	parameter HEIGHT = 480;
	parameter PLAYAREAX = 320;
	parameter PLAYAREAY = 240;
	parameter HPX = 50;
	parameter HPY = 360;
	parameter SIZE = 8;
	parameter BLUE = 50;
	parameter SLIDE = 300;
	parameter LOGO = 130;
		
	// register for Basys 2 8-bit RGB DAC 
	reg [11:0] rgb_reg;
	reg reset = 0;
	reg [7:0] bulletSize;
	wire [9:0] x, y;
	wire [11:0] heartRGB;
	wire [11:0] logoRGB;
	wire[9:0] POSX, POSY, BPOSX, BPOSY;
	wire [3:0] heartX, heartY;
	wire [6:0] logoX, logoY;
	
	assign POSX = playerPos[15:8]+220;
	assign POSY = playerPos[7:0]+140;
	assign BPOSX = bulletPos[15:8]+220;
	assign BPOSY = bulletPos[7:0]+140;
	assign heartX = (x-(POSX-8));
    assign heartY = (y-(POSY-8));
    assign logoX = (x-(PLAYAREAX-64));
    assign logoY = (y-(LOGO-64));

	// video status output from vga_sync to tell when to route out rgb signal to DAC
    wire p_tick;
	// instantiate vga_sync
	vga_sync vga_sync_unit (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync), .p_tick(p_tick), .x(x), .y(y));
    heart player (.clk(clk), .x(heartX), .y(heartY), .rgb_reg(heartRGB));
    logo Logo (.clk(clk), .x(logoX), .y(logoY), .rgb_reg(logoRGB));
    
    reg [3:0] counter;
    initial
    begin
    index = 0;
    counter = 0;
    end
    
//    always @(posedge clk2_10) begin
//    if (index === 2) index = 0;
//	else index = index+1;
//    end
    
	always @(posedge clk) begin
//	    if (counter === 7) begin
//	       if (index === 7) index = 0;
//	       else index = index+1;
//	       counter = 0;
//	    end
//	    counter = counter +1;
        if (index === 2) index = 0;
    	else index = index+1;
        if (reset)
            rgb_reg <= 0;
        else
            if(state[31:28]==4'b0001)
                begin
                    if(x>=PLAYAREAX-64 && x<=PLAYAREAX+64 && y>=LOGO-64 && y<=LOGO+64)
                        rgb_reg = logoRGB; 
                end
            else if(state[31:28]==4'b1001)
                begin
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
                        rgb_reg = heartRGB; 
                    end
                //bullet
//                else if(x>=BPOSX-SIZE && x<=BPOSX+SIZE && y>=BPOSY-SIZE && y<=BPOSY+SIZE && isRender==1 && bulletColor!=2)
//                    begin
//                        case(bulletColor)
//                            2'b00: begin rgb_reg = 12'b111111111111; end
//                            2'b01: begin rgb_reg = 12'b000011110000; end
//                        endcase
//                    end
                else if(x>=BPOSX-SIZE && x<=BPOSX+SIZE && y>=BPOSY-SIZE && y<=BPOSY+SIZE && isRender==1 && bulletColor==0)
                    rgb_reg <= 12'b111111111111;
                else if(x>=BPOSX-SIZE && x<=BPOSX+SIZE && y>=BPOSY-SIZE && y<=BPOSY+SIZE && isRender==1 && bulletColor==1)
                    rgb_reg <= 12'b000011110000;
                else if(x>=BPOSX-BLUE && x<=BPOSX+BLUE && y>=BPOSY-BLUE && y<=BPOSY+BLUE && isRender==1 && bulletColor==2)
                    rgb_reg <= 12'b000000001111;
                //hp bar
                else if(x>=HPX && x<=HPX+state[15:8]*3 && y>=HPY && y<=HPY+5)
                    rgb_reg <= 12'b111100000000;
                else if(x>=HPX && x<=HPX+state[23:16]*3 && y>=HPY+7 && y<=HPY+12)
                    rgb_reg <= 12'b111111110000;
                else if(x>=HPX+300 && x<=HPX+302 && y>=HPY && y<=HPY+12)
                    rgb_reg <= 12'b111111111111;
                else rgb_reg <= 12'b000000000000;
                end
            else if(state[31:28]==4'b1010)
                begin
                    //play area
                if((x>=PLAYAREAX-131 && x<=PLAYAREAX-128 && y>=PLAYAREAY-23 && y<=PLAYAREAY+23) ||
                    (x>=PLAYAREAX+128 && x<=PLAYAREAX+131 && y>=PLAYAREAY-23 && y<=PLAYAREAY+23) ||
                    (x>=PLAYAREAX-131 && x<=PLAYAREAX+131 && y>=PLAYAREAY-23 && y<=PLAYAREAY-20) ||
                    (x>=PLAYAREAX-131 && x<=PLAYAREAX+131 && y>=PLAYAREAY+20 && y<=PLAYAREAY+23))
                        rgb_reg <= 12'b111111111111;
                    //hp bar
                else if(x>=HPX && x<=HPX+state[15:8]*3 && y>=HPY && y<=HPY+5)
                    rgb_reg <= 12'b111100000000;
                else if(x>=HPX && x<=HPX+state[23:16]*3 && y>=HPY+7 && y<=HPY+12)
                    rgb_reg <= 12'b111111110000;
                else if(x>=HPX+300 && x<=HPX+302 && y>=HPY && y<=HPY+12)
                    rgb_reg <= 12'b111111111111;
                    //slider
                else if(x>=PLAYAREAX-128+state[7:0]-1 && x<=PLAYAREAX-128+state[7:0]+1 && y>=PLAYAREAY-23 && y<=PLAYAREAY+23)
                    rgb_reg <= 12'b111111111111;
                    //slider help
                else if(x>=PLAYAREAX-1 && x<=PLAYAREAX+1 && y>=PLAYAREAY-23 && y<=PLAYAREAY-18)
                    rgb_reg <= 12'b111111111111;
                else rgb_reg <= 12'b000000000000;
                end
            else rgb_reg <= 12'b000000000000;
            
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

