module image_rom(input clk, input[16:0] address, output reg[2:0] q);

reg[2:0] rom [0: 76799];

initial
	$readmemb("C:/Users/Delta Store/Desktop/fadoosh/ZDC/Projects/VGA/bird.mem", rom);
	
always@(posedge clk)
	q<=rom[address];

endmodule
