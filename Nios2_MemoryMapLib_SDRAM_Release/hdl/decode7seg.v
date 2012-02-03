//
// 7seg decoder
// 2012/1/10 yishii
//

module decode7seg(
	input [3:0] data,
	output reg [6:0] decoded7seg);
	
	always @* begin
		case(data)
			4'h0: decoded7seg = 7'b1000000;
			4'h1: decoded7seg = 7'b1111001;
			4'h2: decoded7seg = 7'b0100100;
			4'h3: decoded7seg = 7'b0110000;
			4'h4: decoded7seg = 7'b0011001;
			4'h5: decoded7seg = 7'b0010010;
			4'h6: decoded7seg = 7'b0000010;
			4'h7: decoded7seg = 7'b1011000;
			4'h8: decoded7seg = 7'b0000000;
			4'h9: decoded7seg = 7'b0010000;
			4'ha: decoded7seg = 7'b0001000;
			4'hb: decoded7seg = 7'b0000011;
			4'hc: decoded7seg = 7'b1000110;
			4'hd: decoded7seg = 7'b0100001;
			4'he: decoded7seg = 7'b0000110;
			4'hf: decoded7seg = 7'b0001110;
			default: decoded7seg = 7'b1111111;
		endcase
	end
endmodule
