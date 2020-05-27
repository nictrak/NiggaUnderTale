`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2020 04:04:53 PM
// Design Name: 
// Module Name: Player
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


module Player(
    output [31:0]state,
    output [15:0]position,
    output isDeath,
    input [15:0] instruction,
    input clk,
    output [7:0] HP,
    output [7:0] ATK,
    output [7:0] size

    );
    
    reg [7:0] x;
    reg [7:0] y;
    wire [15:0] position;
    assign position[7:0] = y;
    assign position[15:8] = x;
    
    wire [31:0] state;
    assign state[15:0] = position;
    
    reg isDeath;
    reg [7:0] HP;
    reg [7:0] ATK;
    wire [7:0] movementSpeed = 4;
    reg [7:0] size = 10;
   
    
    
    always@(posedge clk)
    begin
        case (instruction[15:12])
            default : ;
            4'b0001 : 
                begin
                HP = HP+instruction[11:4]; //Heal player health
                if(HP>100) HP=100;
                end
            4'b0010 : 
                begin
                if (HP != 0) HP = HP-instruction[11:4]; //Damage player health
                if (HP > 100) HP = 0;
                end
            4'b0011 : ATK = ATK+instruction[11:4]; //Increse player attack power
            4'b0100 : ATK = instruction[11:4]; //set attack power to number
            4'b0000 : ;
            4'b0101 : 
                begin
                case(instruction[11:4])
                    0 : 
                        begin
                        x = x-movementSpeed;
                        if(x<0+size/2+movementSpeed) x=0+size/2+movementSpeed;
                        end
                    1 : 
                        begin
                        y = y-movementSpeed;
                        if(y<0+size/2+movementSpeed) y=0+size/2+movementSpeed;
                        end
                    2 : 
                        begin
                        x = x+movementSpeed;
                        if(x>200-size/2) x=200-size/2;
                        end
                    3 : 
                        begin
                        y = y+movementSpeed;
                        if(y>200-size/2) y=200-size/2;
                        end
                endcase
                end
            4'b0110 : HP = instruction[11:4]; //set HP                      
        endcase
        
        //if(x<0+size/2) x=0+size/2;
        //if(x>200-size/2) x=200-size/2;
        //if(y<0+size/2) y=0+size/2;
        //if(y>200-size/2) y=200-size/2;
    end
    
    always @(HP)
    begin
        if(HP > 100 | HP == 0) isDeath = 1;
        else isDeath = 0;
    end

//initial
    initial
    begin
    HP = 100;
    ATK = 10;
    x=14;
    y=14;
    end
                      
          
endmodule
