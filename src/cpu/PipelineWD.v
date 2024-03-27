module PipelineWD (
    input CLK,
    input wire RegWriteM,
    input wire MemtoRegM,
    input wire[31:0] ReadDataM,
    input wire[31:0] ALUOutM,
    input wire[4:0] WriteRegM,
    output reg RegWriteW,
    output reg MemtoRegW,
    output reg[31:0] ReadDataW,
    output reg[31:0] ALUOutW,
    output reg[4:0] WriteRegW
);

always @(posedge CLK) begin
    RegWriteW <= RegWriteM;
    MemtoRegW <= MemtoRegM;
    ReadDataW <= ReadDataM;
    ALUOutW   <= ALUOutM;
    WriteRegW <= WriteRegM;
end

endmodule
