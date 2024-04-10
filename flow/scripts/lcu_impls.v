`ifdef PLATFORM_sky130hd

(* export_name=$sformatf("LCU_%0d_SC_KOGGE_STONE", WIDTH) *)
(* implements_operator=$sformatf("LCU_%0d", WIDTH) *)
module LCU_SC_KOGGE_STONE(P, G, CO);
	parameter WIDTH = 2;

	(* force_downto *)
	input [WIDTH-1:0] P, G;

	(* force_downto *)
	output [WIDTH-1:0] CO;

	localparam STAGES = $clog2(WIDTH);

	integer i, j;
	(* force_downto *)
	wire [WIDTH-1:0] p [STAGES:0], g [STAGES:0];

	assign p[0] = P;
	assign g[0] = G;

	generate
		genvar i, j;

		for (i = 0; i < $clog2(WIDTH); i = i + 1) begin
			for (j = 0; j < 2**i; j = j + 1) begin
				assign g[i + 1][j] = g[i][j];
				assign p[i + 1][j] = p[i][j];
			end
			for (j = 2**i; j < WIDTH; j = j + 1) begin
				sky130_fd_sc_hd__a21o_1 a21o(
					.A2(g[i][j - 2**i]),
					.A1(p[i][j]),
					.B1(g[i][j]),
					.X(g[i + 1][j]));

				sky130_fd_sc_hd__and2_1 and2(
					.A(p[i][j]), .B(p[i][j - 2**i]), .X(p[i + 1][j]));
			end
		end
	endgenerate

	assign CO = g[STAGES];
endmodule
`endif
