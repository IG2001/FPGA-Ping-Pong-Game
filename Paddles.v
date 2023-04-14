module Paddles(clk1, reset, p1button1, p1button2, p2button1, p2button2, x, y, pad1_on, pad2_on, pad1_colour, pad2_colour, xpad1,
		xpad2, ypad1, ypad2);
			
	input clk1, reset;
	input p1button1, p1button2, p2button1, p2button2; //Buttons for Paddle Movement (Up and Down)
	input[9:0] x, y;
	
	output pad1_on, pad2_on;
	output[11:0] pad1_colour, pad2_colour; //Colour of paddles
	
	output reg [9:0] xpad1 = leftPos + (padW/2); //Paddle Positions on Screen
	output reg [9:0] xpad2 = vgaH - (rightPos + (padW/2));
	output reg [9:0] ypad1 = vgaV/2;
	output reg [9:0] ypad2 = vgaV/2;
	
	localparam vgaH = 640;
	localparam vgaV = 480; //Resolution of Screen
	
	localparam padW = 12; //Paddle Width
	localparam padH = 80; //Paddle Height
	
	localparam leftPos = 20;
	localparam rightPos = 20;
	
	//Always statement for Player 1's Paddle
	always@(posedge clk1)
	begin
		if(!reset) //Resets Paddle 1 to default position
			begin
				xpad1 <= leftPos + (padW/2);
				ypad1 <= vgaV/2;
			end
		
		else if(!p1button1 && ypad1 - (padH/2) > 0) //Moves Paddle 1 Down
			ypad1 <= ypad1 - 1;
		
		else if(!p1button2 && ypad1 + (padH/2) < vgaV) //Moves Paddle 1 Up
			ypad1 <= ypad1 + 1;
			
		else
			ypad1 <= ypad1; //Keeps Paddle in same position if no button is pressed
	end
	
	assign pad1_on = ((x >= xpad1 - (padW/2) && x <= xpad1 + (padW/2)) && (y >= ypad1 - (padH/2) && ypad1 + (padH/2)))?1:0; //Assigns pad 1 restrictions
	assign pad1_colour = 12'b100011001110;
	
	//Always statement for Player 2's Paddle with same principles as paddle 1
	always@(posedge clk1)
	begin
		if(!reset)
		begin
			xpad2 <= vgaH - (rightPos + (padW/2));
			ypad2 <= vgaV/2;
		end
		
		else if(!p2button1 && ypad2 - (padH/2) > 0)
			ypad2 <= ypad2 - 1;
		
		else if(!p2button2 && ypad2 + (padH/2) < vgaV)
			ypad2 <= ypad2 + 1;
			
		else
			ypad2 <= ypad2;
	end
	
	assign pad2_on = ((x >= xpad2 - (padW/2) && x <= xpad2 + (padW/2)) && (y >= ypad2 - (padH/2) && y + (padH/2)))?1:0;
	assign pad2_colour = 12'bb111101110000;

endmodule 