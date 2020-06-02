`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Anan Methasate 6031061021
// 
// Create Date: 25.05.2020 14:36:44
// Design Name: 
// Module Name: collision
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


//module collision(
//output wire [4:0] debug_ops,
//output wire isDone,
//output wire isCollide,
//input wire clk,
//input wire start,
//input wire [7:0] px, py, lpx, lpy,
//input wire [7:0] bx, by, lbx, lby
//);
//    /////for debug///
    
//    assign debug_ops = col_ops;
    
//    /////////////////
//    reg [4:0] col_ops = 0;
//    reg [3:0] idx = 0;
//    reg bullet = 0;
//    reg done = 0;
//    wire check;
//    assign isCollide = bullet;
////    single_pulser sp(isDone, done, clk);
//    assign isDone = done;
//    CheckCollision ic(check,px,py,lpx,lpy,bx,by,lbx,lby);
    
//    always @(posedge clk)
//    begin
    
//        case (col_ops)
//        0: begin 
//                if(start == 1) begin col_ops<=1; end 
//           end
//        1: begin 
//                bullet <= check; 
//                col_ops=col_ops+1; 
//           end
//        2: begin
//                 done <= 1;
//                 col_ops<=col_ops+1;
//            end
        
//        3: begin
//                 done <= 0;
//                 bullet <= 0;
//                 col_ops <= 0;
//            end
//        endcase
        
//    end

//endmodule

module CheckCollision(
output wire check,
input wire [7:0] px, py, lpx, lpy,
input wire [7:0] bx, by, lbx, lby
);

   wire [7:0] paddx, psubx, baddx, bsubx;
   wire [7:0] paddy, psuby, baddy, bsuby;
   
   
   assign paddx = px+(lpx>>1);
   assign baddx = bx+(lbx>>1);
   assign psubx = px-(lpx>>1);
   assign bsubx = bx-(lbx>>1);
   
   assign paddy = py+(lpy>>1);
   assign baddy = by+(lby>>1);
   assign psuby = py-(lpy>>1);
   assign bsuby = by-(lby>>1);
   
   reg check_reg = 0;
   assign check = check_reg;
   
   always @(px or py or lpx or lpy or bx or by or lbx or lby)
   begin
    if((px <= bx && paddx >= bsubx) || (px > bx && baddx >= psubx)) begin
        if((py <= by && paddy >= bsuby) || (py > by && baddy >= psuby)) begin
           check_reg = 1;  
        end
        else begin check_reg = 0; end
    end
    else begin check_reg = 0; end
   end
    
endmodule