module vga_sync (
   input wire clk,
   input wire rst,
   output wire [9:0] pixel_x,
   output wire [9:0] pixel_y,
   output wire video_on,
   output wire hsync,
   output wire vsync
   );
wire line_tick;
parameter h_total = 10'd800;
parameter v_total = 10'd525;

//pixel_x & pixel_y
pixel_x_counter pixelx(.clk(clk),.rst(rst),.line_tick(line_tick),.pixel_x(pixel_x));
pixel_y_counter pixely(.clk(clk),.rst(rst),.enable(line_tick),.pixel_y(pixel_y));

//video_on
assign video_on=((pixel_x<10'd640)&&(pixel_y<10'd480));

//hsync
assign hsync=((pixel_x>10'd655)&&(pixel_x<=10'd751));

//vsync
assign vsync=((pixel_y>10'd489)&&(pixel_y<=10'd491));

endmodule