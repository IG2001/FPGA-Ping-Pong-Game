module Winner(clk, reset, newMode, p1s, p2s, winner);

	input clk, reset, newMode;
	input[3:0] p1s, p2s; //PLayer 1 score, Player 2 score
	
	output reg [1:0] winner;
	
	reg[3:0] game_win = 4'b0101; //This set the number of goals to win to 5
	
	always@(posedge clk)
	begin
		if(!reset) //Resets Winner
			winner = 0;
		else
		begin
			if(!newMode)
				game_win <= 4'b1001; //Sets number of goals to win to 9
				
			if(p1s == game_win) //Player 1 has won the game
				winner = 2'b10;
			
			else if(p2s == game_win) //Player 2 has won the game
				winner = 2'b11;
			
			else //Neither player has won yet
				winner = 2'b01;
		end
	end
endmodule 