/*
 *  yosys -- Yosys Open SYnthesis Suite
 *
 *  Copyright (C) 2012  Claire Xenia Wolf <claire@yosyshq.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

(* lib_whitebox *)
module LCU(P, G, CO);
	parameter WIDTH = 2;
	(* force_downto *)
	input wire [WIDTH-1:0] P;
	(* force_downto *)
	input wire [WIDTH-1:0] G;
	(* force_downto *)
	output wire [WIDTH-1:0] CO;

	integer i, j;
	(* force_downto *)
	reg [WIDTH-1:0] p, g;

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
