/*
* Nome: Diego Da Silva Ferreira
* Matricula:71 06 78
*/

module dff ( output q, output qnot,
	     input d, input clk,
    	     input clear, input preset);

     reg q, qnot;
	always @( posedge clk )
	begin
		if(clear)
		begin
			q <= 1'b0;
			qnot <= 1'b1;
		end
		else
		begin
			if(preset)
			begin
				q <= 1'b1;
				qnot <= 1'b0;
			end
			else
			begin
				q <= d;
				qnot <= ~d;
			end
		end
	end
endmodule // dff


module Exe (output [5:0]s, input clk, input x, input clear);

	wire [5:0]tmp;
	wire [5:0]ss;
	wire or1;

	dff ddf1 (s[5], tmp[0],x | tmp[5], clk, 1'b0, clear);
	dff ddf2 (s[4], tmp[1], s[5]     , clk, 1'b0, clear);
	dff ddf3 (s[3], tmp[2], s[4]     , clk, 1'b0, clear);
	dff ddf4 (s[2], tmp[3], s[3]     , clk, 1'b0, clear);
	dff ddf5 (s[1], tmp[4], s[2]     , clk, 1'b0, clear);
	dff ddf6 (s[0], tmp[5], s[1]     , clk, 1'b0, clear);
	
endmodule

module principal;

	wire [5:0]out;
	reg clk, clear, in;

	Exe exe1 (out, clk, in, clear);

	initial
	begin : main 

		$display ( "Time Saida");

		clear = 1;
		clk = 1;
		in = 0;
		#1 clear = 0;

		#26 $finish;
	end 

	always
	#1 clk = ~clk;

	always @( posedge clk )
		begin
			$display ( "%4d %5b", $time, out );
		end 
endmodule//end principal
/*

teste:

Time Saida
   2 111111
   4 011111
   6 001111
   8 000111
  10 000011
  12 000001
  14 000000
  16 100000
  18 110000
  20 111000
  22 111100
  24 111110
  26 111111

*/
