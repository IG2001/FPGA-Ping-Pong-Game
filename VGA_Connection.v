module VGA_Connection(clk, reset, Hsync, Vsync, vid_on, pTick, x, y);

	input clk, reset;
	
	output Hsync, Vsync, vid_on, pTick;
	output[9:0] x, y;
	
	//Horizontal Resolution parameters
	localparam vgaH = 640; //Horizontal Display Resolution
	localparam leftB = 48; //Left Border
	localparam rightB = 16; //Right Border
	localparam horzRe = 96; //Horizontal Retrace
	
	localparam horzMax = vgaH + leftB + rightB + horzRe - 1;
	localparam startHorzRe = vgaH + rightB;
	localparam endHorzRe = vgaH + rightB + leftB - 1;
	
	//Vertical Resolution parameters
	localparam vgaV = 480; //Vertical Display Resolution
	localparam topB = 10; //Top Border
	localparam botB = 33; //Bottom Border
	localparam vertRe = 2; //Vertical Retrace
	
	localparam vertMax = vgaV + topB + botB + vertRe - 1;
	localparam startVertRe = vgaV + botB;
	localparam endVertRe = vgaV + botB + vertRe - 1;
	
	reg pixel;
	wire nextPixel, pixelTick;
	
	always@(posedge clk, posedge reset)
		
		if(reset)
			pixel <= 0;
			
		else
			pixel <= nextPixel;
	
	assign nextPixel = pixel + 1;
	
	assign pixelTick = (pixel == 0);
	
	reg[9:0] hCount, hCountNext, vCount, vCountNext; //These register track the current pixel location
	reg HsyncCount, VsyncCount; //These register track the state of Vsync and Hsync
	wire HsyncNext, VsyncNext; 
	
	always@(posedge clk, posedge reset)
		if(reset)
		begin	
			vCount <= 0;
			hCount <= 0;
			VsyncCount <= 0;
			HsyncCount <= 0;
		end
		else
		begin
			vCount <= vCountNext;
			hCount <= hCountNext;
			VsyncCount <= VsyncNext;
			HsyncCount <= HsyncNext;
		end
		
	always@(*)
	begin
		hCountNext = pixelTick ? hCount == horzMax ? 0 : hCount + 1 : hCount;
		
		vCountNext = pixelTick && hCount == horzMax ? (vCount == vertMax ? 0 : vCount + 1) : vCount;
	end
	
	assign HsyncNext = hCount >= startHorzRe && hCount <= endHorzRe; //HSync signal assigned during horizontal retrace
	
	assign VsyncNext = vCount >= startVertRe && vCount <= endVertRe; //VSync signal assigned during vertical retrace
	
	assign vid_on = (hCount < vgaH) && (vCount < vgaV); //Display is only on when both regions (horizontal and vertical) have pixels 
	
	assign Hsync = HsyncCount;
	assign Vsync = VsyncCount;
	assign x = hCount;
	assign y = vCount;
	assign pTick = pixelTick;
	
endmodule 
	