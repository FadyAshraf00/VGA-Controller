module RGB (
    input wire [9:0] pixel_x, 
    input wire [9:0] pixel_y, 
    input wire video_on, 
    input wire clk, 
    input wire rst,
    output reg r, g, b
);

    // 1. Scale coordinates down by 2 (divide by 2 via right-shift)
    wire [8:0] scaled_x = pixel_x[9:1];
    wire [8:0] scaled_y = pixel_y[9:1];

    // 2. Calculate 1D address using shift-and-add for (scaled_y * 320) + scaled_x
    // 320 = 256 (<<8) + 64 (<<6)
    wire [16:0] pixel_address = (scaled_y << 8) + (scaled_y << 6) + scaled_x;

    wire [2:0] rom_output;

    image_rom R (
        clk, pixel_address, rom_output
    );

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            r <= 1'b0;
            g <= 1'b0;
            b <= 1'b0;
        end else if (!video_on) begin
            r <= 1'b0;
            g <= 1'b0;
            b <= 1'b0;
        end else begin
            r <= rom_output[2];
            g <= rom_output[1];
            b <= rom_output[0];
        end
    end

endmodule