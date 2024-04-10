(* techmap_celltype="LCU" *)
module _80_lcu_rename(P, G, CO);
	parameter WIDTH = 2;

	(* force_downto *)
	input wire [WIDTH-1:0] P;
	(* force_downto *)
	input wire [WIDTH-1:0] G;
	(* force_downto *)
	output wire [WIDTH-1:0] CO;

	(* unmapped_operator *)
	(* techmap_chtype=$sformatf("LCU_%0d", WIDTH) *)
	_TECHMAP_PLACEHOLDER_ _TECHMAP_REPLACE_(.P(P), .G(G), .CO(CO));
endmodule
