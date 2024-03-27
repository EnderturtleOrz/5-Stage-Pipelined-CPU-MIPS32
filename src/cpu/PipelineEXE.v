module PipelineEXE (
    input CLK,
    input EnableE,
    input RstE,
    input wire RegWriteD,
    input wire MemtoRegD,
    input wire MemWriteD,
    input wire LoadD,
    input wire[3:0] ALUControlD,
    input wire[1:0] ALUSrcAD,
    input wire[1:0] ALUSrcBD,
    input wire[1:0] RegDstD,
    input wire[31:0] RD1_Fwd,
    input wire[31:0] RD2_Fwd,
    input wire[4:0] RtD,
    input wire[4:0] RdD,
    input wire[31:0] SignImmD,
    input wire[31:0] SAD,
    input wire[31:0] PCPlus4D,
    input wire StopD,
    input wire FwdM,
    output reg RegWriteE,
    output reg MemtoRegE,
    output reg MemWriteE,
    output reg LoadE,
    output reg[3:0] ALUControlE,
    output reg[1:0] ALUSrcAE,
    output reg[1:0] ALUSrcBE,
    output reg[1:0] RegDstE,
    output reg[31:0] RD1E,
    output reg[31:0] RD2E,
    output reg[4:0] RtE,
    output reg[4:0] RdE,
    output reg[31:0] SignImmE,
    output reg[31:0] SAE,
    output reg[31:0] PCPlus4E,
    output reg FwdME,
    output reg StopE
);

initial begin
    RegWriteE   = 0;
    MemtoRegE   = 0;
    MemWriteE   = 0;
    LoadE       = 0;
    ALUControlE = 4'b0;
    ALUSrcAE    = 2'b0;
    ALUSrcBE    = 2'b0;
    RegDstE     = 2'b0;
    RD1E        = 32'b0;
    RD2E        = 32'b0;
    RtE         = 5'b0;
    RdE         = 5'b0;
    SignImmE    = 32'b0;
    SAE         = 32'b0;
    PCPlus4E    = 32'b0;
    FwdME       = 2'b0;
    StopE       = 0;    
end

always @(posedge CLK) begin
    StopE       <= StopD;
    if (RstE) begin
        RegWriteE   <= 0;
        MemtoRegE   <= 0;
        MemWriteE   <= 0;
        LoadE       <= 0;
        ALUControlE <= 4'b0;
        ALUSrcAE    <= 2'b0;
        ALUSrcBE    <= 2'b0;
        RegDstE     <= 2'b0;
        RD1E        <= 32'b0;
        RD2E        <= 32'b0;
        RtE         <= 5'b0;
        RdE         <= 5'b0;
        SignImmE    <= 32'b0;
        SAE         <= 32'b0;
        PCPlus4E    <= 32'b0;
        FwdME       <= 2'b0;
    end
    else if (EnableE) begin
        RegWriteE   <= RegWriteD;
        MemtoRegE   <= MemtoRegD;
        MemWriteE   <= MemWriteD;
        LoadE       <= LoadD;
        ALUControlE <= ALUControlD;
        ALUSrcAE    <= ALUSrcAD;
        ALUSrcBE    <= ALUSrcBD;
        RegDstE     <= RegDstD;
        RD1E        <= RD1_Fwd;
        RD2E        <= RD2_Fwd;
        RtE         <= RtD;
        RdE         <= RdD;
        SignImmE    <= SignImmD;
        SAE         <= SAD;
        PCPlus4E    <= PCPlus4D;
        FwdME       <= FwdM;
        StopE       <= StopD;
    end
end

endmodule
