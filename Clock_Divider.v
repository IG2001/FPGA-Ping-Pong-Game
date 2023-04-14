//Used Clock Divider module from lab 4 and modified it to fit the constraints of this project
module Clock_Divider(clk, cout);

	input clk;
	output reg cout = 0;
	
	reg[27:0] count = 0;
	
	always @ (posedge clk)
	begin
		if(count == 124999)
		begin
			count <= 0;
			cout <= ~cout;
		end
		
		else
			count <= count + 1;
	end
endmodule 