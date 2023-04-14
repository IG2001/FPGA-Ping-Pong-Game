module ScreenRender(clk, reset, x, y, vid_on, screen_render, clk1, pad1_on, pad2_on, ball_on, pad1_colour, pad2_colour, ball_colour, winner);
	
	input clk, reset, clk1, vid_on;
	input[9:0] x, y;
	input pad1_on, pad2_on, ball_on;
	input[1:0] winner;
	input[11:0] pad1_colour, pad2_colour, ball_colour;
	
	output[11:0] screen_render;
	
	reg[11:0] screen;
	
	localparam vgaH = 640;
	localparam vgaV = 480;
	
	localparam xSize = 50;
	localparam ySize = 50;
	
	reg[9:0] xBlock = vgaH/2;
	reg[9:0] yBlock = vgaV/2;
	
	always@(posedge clk)
	begin 
		if(!reset)
			screen <= 0; //Screen is inactive if game is not being played
		else
			begin
				if(winner == 2'b01)
					begin 
						if(pad1_on)
							screen <= pad1_colour;
						
						else if(pad2_on)
							screen <= pad2_colour;
						
						else
							screen <= 12'b000000000000;
					end
					else if(winner == 2'b10)
						screen <= pad1_colour; //Makes the screen the colour of Player 1, if they have won
					
					else if(winner == 2'b11) //Makes the screen the colour of Player 2, if they have won
						screen <= pad2_colour;
					
					else
						screen <= 0;
			end
	end
	
	assign screen_render = (vid_on) ? screen : 8'b0;
	
endmodule 
			