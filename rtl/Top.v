module Top (
    input wire clk,
    input wire rst,
    output wire  r,g,b, hsync, vsync);

wire [9:0] pixel_x;
wire [9:0] pixel_y;
wire clk_divided;
wire video_on;

clock_divider CLOCK_DIVIDER (
    .clk_50mhz(clk),
    .rst(rst),
    .clk_25mhz(clk_divided)
);

// vga_sync
vga_sync VGA_SYNC (
    .clk(clk_divided),
    .rst(rst),
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_on(video_on),
    .hsync(hsync),
    .vsync(vsync)
);

// RGB 

RGB RGB_UNIT (
    .pixel_x(pixel_x),
    .pixel_y(pixel_y),
    .video_on(video_on),
    .clk(clk_divided),
    .rst(rst),
    .r(r),
    .g(g),
    .b(b)
);
endmodule