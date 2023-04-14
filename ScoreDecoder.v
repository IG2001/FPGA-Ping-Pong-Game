//Used SSDecoder module from Lab 4 and modified it to fit with the constraints of this project

module ScoreDecoder(reset, p1s, p2s, score1, score2);

	input reset;
	input[3:0] p1s, p2s;
	
	output reg[6:0] score1, score2; //Display score of both players
	
	always@(*) 
	begin
		if(!reset) //Sets score display to 0
		begin
			score1 = 7'b1000000;
			score2 = 7'b1000000;
		end
		else
		begin
			case(p1s)
				4'b0000 : score1 = 7'b1000000; // 0
				4'b0001 : score1 = 7'b1111001; // 1
				4'b0010 : score1 = 7'b0100100; // 2
				4'b0011 : score1 = 7'b0110000; // 3
				4'b0100 : score1 = 7'b0011001; // 4
				4'b0101 : score1 = 7'b0010010; // 5
				4'b0110 : score1 = 7'b0000010; // 6
				4'b0111 : score1 = 7'b1111000; // 7
				4'b1000 : score1 = 7'b0000000; // 8
				4'b1001 : score1 = 7'b0010000; // 9
				 default: score1 = 7'b1000000; // default displays 0
			endcase
			
			case(p2s)
				4'b0000 : score2 = 7'b1000000; // 0
				4'b0001 : score2 = 7'b1111001; // 1
				4'b0010 : score2 = 7'b0100100; // 2
				4'b0011 : score2 = 7'b0110000; // 3
				4'b0100 : score2 = 7'b0011001; // 4
				4'b0101 : score2 = 7'b0010010; // 5
				4'b0110 : score2 = 7'b0000010; // 6
				4'b0111 : score2 = 7'b1111000; // 7
				4'b1000 : score2 = 7'b0000000; // 8
				4'b1001 : score2 = 7'b0010000; // 9
				 default: score2 = 7'b1000000;
			endcase
		end
	end
	 
endmodule 