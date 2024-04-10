(* export_name=$sformatf("LCU_%0d_KOGGE_STONE", WIDTH) *)
(* implements_operator=$sformatf("LCU_%0d", WIDTH) *)
module LCU_KOGGE_STONE(P, G, CO);
	parameter WIDTH = 2;

	(* force_downto *)
	input [WIDTH-1:0] P, G;

	(* force_downto *)
	output [WIDTH-1:0] CO;

	integer i, j;
	(* force_downto *)
	reg [WIDTH-1:0] p, g;

	wire [1023:0] _TECHMAP_DO_ = "proc; opt -fast";

	always @* begin
		p = P;
		g = G;

		for (i = 0; i < $clog2(WIDTH); i = i + 1) begin
			// iterate in reverse so we don't confuse a result from this stage and the previous
			for (j = WIDTH - 1; j >= 2**i; j = j - 1) begin
				g[j] = g[j] | p[j] & g[j - 2**i];
				p[j] = p[j] & p[j - 2**i];
			end
		end
	end

	assign CO = g;
endmodule

(* export_name=$sformatf("LCU_%0d_BRENT_KUNG", WIDTH) *)
(* implements_operator=$sformatf("LCU_%0d", WIDTH) *)
module LCU_BRENT_KUNG(P, G, CO);
	parameter WIDTH = 2;

	(* force_downto *)
	input [WIDTH-1:0] P, G;

	(* force_downto *)
	output [WIDTH-1:0] CO;

	integer i, j;
	(* force_downto *)
	reg [WIDTH-1:0] p, g;

	wire [1023:0] _TECHMAP_DO_ = "proc; opt -fast";

	always @* begin
		p = P;
		g = G;

		// [[CITE]] Brent Kung Adder
		// R. P. Brent and H. T. Kung, "A Regular Layout for Parallel Adders",
		// IEEE Transaction on Computers, Vol. C-31, No. 3, p. 260-264, March, 1982

		// Main tree
		for (i = 1; i <= $clog2(WIDTH); i = i+1) begin
			for (j = 2**i - 1; j < WIDTH; j = j + 2**i) begin
				g[j] = g[j] | p[j] & g[j - 2**(i-1)];
				p[j] = p[j] & p[j - 2**(i-1)];
			end
		end

		// Inverse tree
		for (i = $clog2(WIDTH); i > 0; i = i-1) begin
			for (j = 2**i + 2**(i-1) - 1; j < WIDTH; j = j + 2**i) begin
				g[j] = g[j] | p[j] & g[j - 2**(i-1)];
				p[j] = p[j] & p[j - 2**(i-1)];
			end
		end
	end

	assign CO = g;
endmodule
