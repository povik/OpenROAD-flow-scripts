(* techmap_celltype="$lcu" *)
module _70_lcu_primitive(P, G, CI, CO);
	parameter WIDTH = 2;

	(* force_downto *)
	input wire [WIDTH-1:0] P;
	(* force_downto *)
	input wire [WIDTH-1:0] G;
	input wire CI;
	(* force_downto *)
	output wire [WIDTH-1:0] CO;

	(* unmapped_operator *)
	LCU #(.WIDTH(WIDTH)) _TECHMAP_REPLACE_(.P(P), .G({G[WIDTH-1:1], G[0] | (P[0] & CI)}), .CO(CO));
endmodule
