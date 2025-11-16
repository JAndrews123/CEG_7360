//////////////////////////////////////////////////////////////////////////////
/*
Copyright (C) 2025 Joshua Andrews

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
*/
//////////////////////////////////////////////////////////////////////////////

`timescale 10ns/1ns

module d_flip_flop_tb;

// parameter initialization
parameter DATA_WIDTH = 3;
// reg and wire initialization
reg [DATA_WIDTH:0] D;         // Input A
reg enable;                        // Active low asynchronus enable
reg reset;                        // Active low asynchronous reset
reg clk;                          // Clock input
wire [DATA_WIDTH:0] Q;   // Output Bus
wire [DATA_WIDTH:0] Q_NOT;

// design initialization
d_flip_flop #(
    .DATA_WIDTH(DATA_WIDTH)
) flipflop1 (
    .D(D),
    .enable(enable),
    .reset(reset),
    .clk(clk),
    .Q(Q),
    .Q_NOT(Q_NOT)
);

initial begin
    // will output to debugger, with any change to a value
    $monitor ("[%0t] D=0x%0h enable=0x%0h reset=0x%0h Q=0x%0h Q_NOT=0x%0h", 
              $time, D, enable, reset, Q, Q_NOT
    );


    D = 11;
    enable = 1;   //set initial values
    reset = 1;
    
    #3;
    
    $display("Swap enable");
    enable = 0;
    reset = 1;      //flip asynchromous enable to lock output
    D = 4;
    
    #5 
    
    $display("Swap enable back");
    enable = 1;     //flip enable back to set value immedietly independat of clk value
    
    #5;
    
    D = 5;
    enable = 1;
    
    #4;
    
    $display("Swap reset");
    reset = 0;      //flip reset
    
    #1;
    
    $display("Swap reset back");
    reset = 1;     // immedietly flip back to not active to show Q does not return to a value until posedge clk
    
    #5;
    
    D = 15;         //Set to all bits for 4-bit value
    
    #5;
    
    D = 0;          //set to no bits             
    
    #5;                  
    
end

// Clock running forever
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end
endmodule
