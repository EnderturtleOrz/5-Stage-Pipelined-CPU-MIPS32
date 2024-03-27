module PipelineMEM (
    input CLK,
    input wire RegWriteE,
    input wire MemtoRegE,
    input wire MemWriteE,
    input wire LoadE,
    input wire[31:0] ALUOutE,
    input wire[4:0] WriteRegE,
	input wire FwdME,
    input wire[31:0] WriteDataE,
    input wire StopE,
    output reg RegWriteM,
    output reg MemtoRegM,
    output reg MemWriteM,
    output reg LoadM,
    output reg[31:0] ALUOutM,
    output reg[4:0] WriteRegM,
	output reg FwdMM,
    output reg[31:0] WriteDataM,
    output reg StopM
);

initial begin
    StopM = 0;
end

always @(posedge CLK) begin
    RegWriteM  <= RegWriteE;
    MemtoRegM  <= MemtoRegE;
    MemWriteM  <= MemWriteE;
    LoadM      <= LoadE;
    ALUOutM    <=  ALUOutE;
    WriteRegM  <= WriteRegE;
	FwdMM      <= FwdME;
    WriteDataM <= WriteDataE;
    StopM      <= StopE;
end

endmodule
