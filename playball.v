module playball(clk, clk1, reset, x, y, ball_on, ball_colour, xpad1, xpad2, ypad1, ypad2, p1s, p2s, score);
	
	input clk, clk1, reset;
	input[1:0] score;
	input[9:0] x, y;
	input[9:0] xpad1, xpad2, ypad1, ypad2; //Paddles
	
	output ball_on;
	output reg [3:0] p1s, p2s; //Player 1 Score, Player 2 Score
	output[11:0] ball_colour; //Colour of Ball
	
	reg[9:0] xball, yball;
	
	localparam vgaH = 640;
	localparam vgaV = 480; //Resolution of Screen
	
	localparam ballW = 24; //Width of ball
	localparam ballH = 24; //Height of Ball
	
	localparam padW = 12; //Width of Paddles
	localparam padH = 80; //Height of Paddles
	
	integer a = 1;
	integer b = 1;
	
	
	always @ (posedge clk1)
	begin
		if(!reset) //This section puts the ball in the middle and sets both player's score to 0 when a reset occurs
		begin
			xball <= vgaH/2;
			yball <= vgaV/2;
			p1s <= 0;
			p2s <= 0;
		end
		
		else if(score == 2'b01)
		begin
			//These 2 statements are responsible for edge collision detection
			if(yball == (vgaV - (ballH/2) - 1))
				b = b * -1;
				
			if(yball == (ballH/2) + 1)
				b = b * -1;
				
			//These 2 statements are responsible for paddle collision detection
			if(xball < (xpad1 + ballW/2) && yball > (ypad1 - padH/2) && yball < (ypad1 + padH/2))
				a = a * -1;
				
			if(xball > (xpad2 - ballW/2) && yball > (ypad2 - padH/2) && yball < (ypad2 + padH/2))
				a = a * -1;
				
			if(xball == (vgaH - ballW/2))
			begin
				xball <= vgaH/2;
				yball <= vgaV/2;
				a = a * -1;
				b = b * -1;
				p1s <= p1s + 1;
			end
			
			else if(xball == 0)
			begin
				xball <= vgaH/2;
				yball <= vgaV/2;
				a = a * -1;
				b = b * -1;
				p2s = p2s + 1;
			end
			
			else
			begin
				xball <= xball + a;
				yball <= yball - b;
			end
		end
	else //Ball is constant if game is not on
	begin
		xball <= xball;
		yball <= yball;
	end
end

assign ball_on = (x >= xball - (ballW/2) && x <= xball + (ballW/2) && y >= yball - (ballH/2) && y <= yball + (ballH/2))?1:0; //Gives the ball movement

assign ball_colour = 12'bb101110111011; //Silver Colour

endmodule 
			