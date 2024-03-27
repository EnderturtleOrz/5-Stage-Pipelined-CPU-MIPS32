module mux5bit(
	input[1:0]  sel,
	input[4:0] port_0,
	input[4:0] port_1,
	input[4:0] port_2,
	output reg[4:0] out
);
always @(*) begin
	case(sel)
		2'b00: out = port_0;
		2'b01: out = port_1;
		2'b10: out = port_2;
		default: out = port_0;
	endcase
end
endmodule