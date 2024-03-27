module PipelineID (
    input CLK,
    input EnableD,
    input RstD,
    input wire[31:0] RD,
    input wire[31:0] PCF,
    input wire[31:0] PCPlus4F,
    output reg[31:0] InstrD,
    output reg[31:0] PCD,
    output reg[31:0] PCPlus4D
);

initial begin
    InstrD   = 32'b0;
    PCD      = 32'b0;
    PCPlus4D = 32'b0;    
end

always @(posedge CLK) begin
    if (RstD) begin
        InstrD   <= 32'b0;
        PCD      <= 32'b0;
        PCPlus4D <= 32'b0;
    end
    else if (EnableD) begin
        InstrD   <= RD;
        PCD      <= PCF;
        PCPlus4D <= PCPlus4F;
    end
end

endmodule
