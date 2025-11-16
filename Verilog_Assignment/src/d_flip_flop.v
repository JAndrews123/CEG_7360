//////////////////////////////////////////////////////////////////////////////
/*
Copyright (C) 2025 Joshua Andrews

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see https://www.gnu.org/licenses/.
*/
//////////////////////////////////////////////////////////////////////////////

module d_flip_flop #(
    parameter DATA_WIDTH = 3
)(
    input [DATA_WIDTH:0] D,         // Input A
    input enable,                        // Active low asynchronus enable
    input reset,                        // Active low asynchronous reset
    input clk,                          // Clock input
    output reg [DATA_WIDTH:0] Q,   // Output Bus
    output reg [DATA_WIDTH:0] Q_NOT
);

always @ (posedge clk, enable, negedge reset) begin
    if (reset == 0) begin
        Q = 0;
        Q_NOT = 0;
    end
    else if (enable == 0) begin
        Q = Q;
        Q_NOT = Q_NOT;
    end
    else begin
        Q = D;
        Q_NOT = ~D;
    end
end
endmodule
