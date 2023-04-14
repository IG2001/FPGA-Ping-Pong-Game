module Main(clk, reset, newMode, newMode2, p1button1, p1button2, p2button1, p2button2, screen, Hsync, Vsync, score1, score2);

	input clk, reset, newMode, newMode2, p1button1, p1button2, p2button1, p2button2;
	
	output Hsync, Vsync;
	output[6:0] score1, score2;
	output[11:0] screen;
	
	wire vid_on, clk1, ball_on, pad1_on, pad2_on;
	wire [1:0] winner;
	wire[3:0] p1s, p2s;
	wire[9:0] xpad1, xpad2, ypad1, ypad2;
	wire[9:0] x, y;
	
	VGA_Connection V0 (.clk(clk), .Hsync(Hsync), .Vsync(Vsync), .x(x), .y(y), .vid_on(vid_on));
	
	ScreenRender S0 (clk, reset, x, y, vid_on, screen, clk1, pad1_on, pad2_on, ball_on, pad1_colour, pad2_colour,
				ball_colour, winner);
	
	Clock_Divider C0 (clk, clk1);
	
	playball B0(clk, clk1, reset, x, y, ball_on, ball_colour, xpad1, xpad2, ypad1, ypad2, p1s, p2s, winner);
	
	Paddles P0(clk1, reset, p1button1, p1button2, p2button1, p2button2, x, y, pad1_on, pad2_on, pad1_colour, pad2_colour, xpad1,
		xpad2, ypad1, ypad2);
		
	Winner W0(clk, reset, newMode, p1s, p2s, winner);
	
	ScoreDecoder D0(reset, p1s, p2s, score1, score2);
	
endmodule 