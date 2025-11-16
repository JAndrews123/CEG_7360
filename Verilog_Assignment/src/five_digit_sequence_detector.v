//////////////////////////////////////////////////////////////////////////////
/*
Copyright (C) 2025 Joshua Andrews

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
*/
//////////////////////////////////////////////////////////////////////////////

module five_digit_sequence_detector #(
    parameter DATA_WIDTH = 3
)(
    input [DATA_WIDTH:0] Din,         // Input Bus
    input reset,                        // Active low asynchronous reset
    input clk,                          // Clock input
    output reg [DATA_WIDTH:0] Dout,   // Output Bus
    output reg [DATA_WIDTH:0] present_state     //Current state of the Moore machine initialized as an output                                                
);                                              //so it can be evaluated on the waveform


always @ (posedge clk, negedge reset) begin
    if (reset == 0) begin
        present_state = 0;      //reset is asynchronous, resets state machine, and sets output to 0 
        Dout = 0;
    end
    else begin
        case (present_state)
            0 : begin
                if (Din == 12) begin
                    present_state = 1;
                    Dout = 0;
                end
                else begin
                    present_state = 0;
                    Dout = 0;
                end
            end
            1 : begin
                if (Din == 5) begin
                    present_state = 2;
                    Dout = 0;
                end
                else begin
                    present_state = 0;
                    Dout = 0;
                end
            end
            2 : begin
                if (Din == 9) begin
                    present_state = 3;
                    Dout = 0;
                end
                else begin
                    present_state = 0;
                    Dout = 0;
                end
            end
            3 : begin
                if (Din == 15) begin
                    present_state = 4;
                    Dout = 0;
                end
                else begin
                    present_state = 0;
                    Dout = 0;
                end
            end
            4 : begin
                if (Din == 2) begin
                    present_state = 4;
                    Dout = 1;
                end
                else begin
                    present_state = 0;
                    Dout = 0;
                end
            end
        endcase
    end
end
endmodule
