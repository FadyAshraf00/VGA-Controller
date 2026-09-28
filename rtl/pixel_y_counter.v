module pixel_y_counter (
    input wire clk, 
    input wire rst, 
    input wire enable,
    output reg [9:0] pixel_y
);

parameter v_total = 10'd525;

    always@(posedge clk or posedge rst) begin
            if(rst) begin
                pixel_y <= 10'd0;
            end
            else begin
                if(enable) begin
                    if(pixel_y == v_total-1) begin
                        pixel_y <= 10'd0;
                    end
                    else begin
                        pixel_y <= pixel_y + 10'd1;
                    end
                end
            end
    end
endmodule