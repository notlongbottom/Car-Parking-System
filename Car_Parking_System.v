`timescale 1ns / 1ps
module parking_system( 
                input clk,reset_n,
 input sensor_entrance, sensor_exit, 
 input [1:0] password_1, password_2,
 output wire GREEN_LED,RED_LED,
 output reg [6:0] HEX_1, HEX_2
    );

 parameter IDLE = 3'b000, WAIT_PASSWORD = 3'b001, WRONG_PASS = 3'b010, RIGHT_PASS = 3'b011,STOP = 3'b100;
 // Moore FSM : output just depends on the current state
 reg[2:0] current_state, next_state;
 reg[31:0] counter_wait;
 reg red_tmp,green_tmp;
 // Next state
 always @(posedge clk or negedge reset_n)
 begin
 if(~reset_n) 
 current_state = IDLE;
 else
 current_state = next_state;
 end

 // counter_wait
 always @(posedge clk or negedge reset_n) 
 begin
 if(~reset_n) 
 counter_wait <= 0;
 else if(current_state==WAIT_PASSWORD)
 counter_wait <= counter_wait + 1;
 else 
 counter_wait <= 0;
 end