module pixel_x_counter (
    input wire clk,
    input wire rst,
    output reg [9:0] pixel_x,
    output wire line_tick

);
parameter h_total = 10'd800;
assign line_tick = (pixel_x == h_total-1);

    
    always @(posedge clk or posedge rst) begin
        if (rst) 
		begin		
            pixel_x <= 10'd0;
        end
		else 
        begin	
               if (pixel_x == h_total-1)
			   begin
                  pixel_x <= 10'd0;
               end
			   else 
			   begin
                  pixel_x <= pixel_x + 10'd1;
               end
        end
    end

endmodule