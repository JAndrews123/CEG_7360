//////////////////////////////////////////////////////////////////////////////
/*
Copyright (C) 2025 Joshua Andrews

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
*/
//////////////////////////////////////////////////////////////////////////////

`timescale 10ns/1ns

module five_digit_sequence_detector_tb;

// parameter initialization
parameter DATA_WIDTH = 3;
// reg and wire initialization
reg [DATA_WIDTH:0] Din;         // Input A
reg reset;                        // Active low asynchronous reset
reg clk;                          // Clock input
wire [DATA_WIDTH:0] Dout;   // Output Bus
wire [DATA_WIDTH:0] present_state;

// design initialization
five_digit_sequence_detector #(
    .DATA_WIDTH(DATA_WIDTH)
) detector1 (
    .Din(Din),
    .reset(reset),
    .clk(clk),
    .Dout(Dout),
    .present_state(present_state)
);

initial begin
    // will output to debugger, with any change to a value
    $monitor ("[%0t] Din=0x%0h reset=0x%0h Dout=0x%0h", 
              $time, Din, reset, Dout
    );
      
    //reset state machine to initial state 
    reset = 0;
    
    #1;
              
    Din = 0;
    reset = 1;

    //Begin correct sequence of 12, 5, 9, 15, and 2
        
    #3;
    
    Din = 12;
    
    #10;
    
    Din = 5;
    
    #10;
    
    Din = 9;
    
    #10;
    
    Din = 15;
    
    #10;
    
    Din = 2;
    
    //Verify Dout is now 1
    #10

    //Verify bad sequence after reset
    
    reset = 0;
    
    #3;
    
    reset = 1;
    Din = 12;
    
    #10;
    
    Din = 5;
    
    #10;
    
    Din = 9;
    
    #10;
    
    //value of 8 breaks the sequence and sets present_state to 0
    Din = 8;
    
    #10
    
    Din = 2;
    
    //Verify Dout does not go to 1
    
    #20;
end

// Clock running forever
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end
endmodule
