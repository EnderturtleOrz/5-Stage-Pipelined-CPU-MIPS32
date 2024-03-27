module mux4(
	input[1:0]  sel,
	input[31:0] port_0,
	input[31:0] port_1,
	input[31:0] port_2,
	input[31:0] port_3,
	output reg[31:0] out
);
always @(*) begin
	case(sel)
		2'b00: out = port_0;
		2'b01: out = port_1;
		2'b10: out = port_2;
		2'b11: out = port_3;
		default: out = port_0;
	endcase
end
endmodule