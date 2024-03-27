module PipelineIF (
    input CLK,
    input EnableF,
    input wire[31:0] PC_apostrophe,
    output reg[31:0] PCF
);
initial begin
    PCF = 32'b0;
end
always @(posedge CLK) begin
    if (EnableF) PCF <= PC_apostrophe;
end

endmodule
