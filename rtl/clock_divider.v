module clock_divider (
    input wire clk_50mhz,   
    input wire rst,         
    output reg clk_25mhz    );

    always @(posedge clk_50mhz or posedge rst) begin
        if (rst) begin
            clk_25mhz <= 1'b0;
        end else begin
            clk_25mhz <= ~clk_25mhz;
        end
    end

endmodule