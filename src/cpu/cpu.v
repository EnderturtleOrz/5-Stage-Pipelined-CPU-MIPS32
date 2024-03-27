`include "global_const.v"
`include "mux4.v"
`include "mux5bit.v"
`include "InstructionRAM.v"
`include "RegsiterFile.v"
`include "alu.v"
`include "DataRAM.v"
`include "ControlUnit.v"
`include "HazardUnit.v"
`include "PipelineIF.v"
`include "PipelineID.v"
`include "PipelineEXE.v"
`include "PipelineMEM.v"
`include "PipelineWD.v"

module CPU (
    input CLK
);
//signal definitions
// IF
wire EnableF;
wire RstF;
wire[31:0] PC_apostrophe;
wire[31:0] RD;
wire[31:0] PCF;
wire[31:0] PCPlus4F;
// ID
wire EnableD;
wire RstD;
wire[31:0] InstrD;
wire[31:0] PCD;
wire[31:0] PCPlus4D;
wire BranchEqual;
wire RSD;
wire RTD;
wire LoadD;
wire StoreD;
wire RegWriteD;
wire MemtoRegD;
wire MemWriteD;
wire BranchD;
wire[3:0]ALUControlD;
wire[1:0] ALUSrcAD;
wire[1:0] ALUSrcBD;
wire[1:0] RegDstD;
wire[1:0] SrcPCD;
wire[31:0] RD1_Fwd;
wire[31:0] RD2_Fwd;
wire[31:0] RD1;
wire[31:0] RD2;
wire[31:0] SignImmD;
wire[31:0] SAD;
wire StopD;
wire Sign;
// EXE
wire[31:0] ALUOutE;
wire EnableE = 1;
wire RstE;
wire RegWriteE;
wire MemtoRegE;
wire MemWriteE;
wire LoadE;
wire[3:0] ALUControlE;
wire[1:0] ALUSrcAE;
wire[1:0] ALUSrcBE;
wire[1:0] RegDstE;
wire[31:0] RD1E;
wire[31:0] RD2E;
wire[4:0] RtE;
wire[4:0] RdE;
wire[31:0] SignImmE;
wire[31:0] SAE;
wire[31:0] PCPlus4E;
wire FwdME;
wire[4:0] WriteRegE;
wire[31:0] WriteDataE;
wire StopE;
// MEM
wire RegWriteM;
wire MemtoRegM;
wire MemWriteM;
wire LoadM;
wire[31:0] ALUOutM;
wire[4:0] WriteRegM;
wire FwdMM;
wire[31:0] ReadDataM;
wire[31:0] WriteDataM;
wire[31:0] WD;
wire StopM;
// WB
wire RegWriteW;
wire MemtoRegW;
wire[31:0] ReadDataW;
wire[31:0] ALUOutW;
wire[4:0] WriteRegW;
wire[31:0] ResultW;
// ALU
wire[31:0] regA;
wire[31:0] regB;
// Harzard Unit
wire[1:0] FwdA;
wire[1:0] FwdB;
wire FwdM;

// IF stage
wire[31:0] PCD_InstrD;
wire[31:0] PCPlus4D_SignImmE;
assign PCD_InstrD = {PCD[31:28],InstrD[25:0],2'b0};
assign PCPlus4D_SignImmE = PCPlus4D+{SignImmD[29:0],2'b0};
mux4 pc_mux(
    .sel(SrcPCD),
    .port_0(PCPlus4F),
    .port_1(PCD_InstrD),
    .port_2(RD1_Fwd),
    .port_3(PCPlus4D_SignImmE),

    .out(PC_apostrophe)
);

// always @(SrcPCD,PCPlus4D_SignImmE) begin
//     $display(PC_apostrophe,PCPlus4D_SignImmE);
// end

PipelineIF if_stage(
    .CLK(CLK),
    .EnableF(EnableF),
    .PC_apostrophe(PC_apostrophe),

    .PCF(PCF)
);

assign PCPlus4F = PCF + 4;

InstructionRAM instruction_ram(
    .CLK(CLK),
    .PCF(PCF),

    .instruction(RD)
);

// ID stage
PipelineID id_stage(
    .CLK(CLK),
    .EnableD(EnableD),
    .RstD(RstD),
    .RD(RD),
    .PCF(PCF),
    .PCPlus4F(PCPlus4F),

    .InstrD(InstrD),
    .PCD(PCD),
    .PCPlus4D(PCPlus4D)
);

ControlUnit control_unit(
    .Op(InstrD[31:26]),
    .Funct(InstrD[5:0]),
    .BranchEqual(BranchEqual),

    .RSD(RSD),
    .RTD(RTD),
    .LoadD(LoadD),
    .StoreD(StoreD),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .BranchD(BranchD),
    .ALUControlD(ALUControlD),
    .ALUSrcAD(ALUSrcAD),
    .ALUSrcBD(ALUSrcBD),
    .RegDstD(RegDstD),
    .SrcPCD(SrcPCD),
    .Sign(Sign),
    .StopD(StopD)
);

RegsiterFile regsiter_file(
    .CLK(CLK),
    .A1(InstrD[25:21]),
    .A2(InstrD[20:16]),
    .A3(WriteRegW),
    .WE3(RegWriteW),
    .WD3(ResultW),

    .RD1(RD1),
    .RD2(RD2)
);

mux4 rd1_mux(
    .sel(FwdA),
    .port_0(RD1),
    .port_1(ALUOutE),
    .port_2(ALUOutM),
    .port_3(ReadDataM),

    .out(RD1_Fwd)
);

mux4 rd2_mux(
    .sel(FwdB),
    .port_0(RD2),
    .port_1(ALUOutE),
    .port_2(ALUOutM),
    .port_3(ReadDataM),

    .out(RD2_Fwd)
);

assign BranchEqual = (RD1_Fwd == RD2_Fwd);
assign SignImmD    = (Sign ? {{16{InstrD[15]}},InstrD[15:0]} : {16'b0,InstrD[15:0]});
assign SAD         = {27'b0,InstrD[10:6]};

// always @(SignImmD) begin
//     $display("Signed",SignImmD);
// end

// always @(SignImmD) begin
//     $display("SignImmD = %d",SignImmD);
//     $display("ALUSrcAE =%d ALUSrcBE =%d",ALUSrcAE,ALUSrcBE);
// end

// always @(BranchEqual) begin
//      $display("BranchEqual=",BranchEqual);
// end

// always @( SrcPCD) begin
//     $display("SrcPCD=%b",SrcPCD);
// end
// EXE stage
PipelineEXE exe_stage(
    .CLK(CLK),
    .EnableE(EnableE),
    .RstE(RstE),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .LoadD(LoadD),
    .ALUControlD(ALUControlD),
    .ALUSrcAD(ALUSrcAD),
    .ALUSrcBD(ALUSrcBD),
    .RegDstD(RegDstD),
    .RD1_Fwd(RD1_Fwd),
    .RD2_Fwd(RD2_Fwd),
    .RtD(InstrD[20:16]),
    .RdD(InstrD[15:11]),
    .SignImmD(SignImmD),
    .SAD(SAD),
    .PCPlus4D(PCPlus4D),
    .FwdM(FwdM),
    .StopD(StopD),

    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .LoadE(LoadE),
    .ALUControlE(ALUControlE),
    .ALUSrcAE(ALUSrcAE),
    .ALUSrcBE(ALUSrcBE),
    .RegDstE(RegDstE),
    .RD1E(RD1E),
    .RD2E(RD2E),
    .RtE(RtE),
    .RdE(RdE),
    .SignImmE(SignImmE),
    .SAE(SAE),
    .PCPlus4E(PCPlus4E),
    .FwdME(FwdME),
    .StopE(StopE)
);

reg[31:0] always_low;
reg[4:0] reg_ra;
initial begin
    always_low = 32'b0;
    reg_ra = 31;
end
mux4 a_mux(
    .sel(ALUSrcAE),
    .port_0(RD1E),
    .port_1(SAE),
    .port_2(PCPlus4E),
    .port_3(always_low),

    .out(regA)
);
mux4 b_mux(
    .sel(ALUSrcBE),
    .port_0(RD2E),
    .port_1(SignImmE),
    .port_2(always_low),
    .port_3(always_low),

    .out(regB)
);

mux5bit m_mux(
    .sel(RegDstE),
    .port_0(RtE),
    .port_1(RdE),
    .port_2(reg_ra),

    .out(WriteRegE)
);

alu a_alu(
    .regA(regA),
    .regB(regB),
    .sel(ALUControlE),

    .res(ALUOutE)
);

assign WriteDataE = RD2E;

// MEM stage
PipelineMEM mem_stage(
    .CLK(CLK),
    .RegWriteE(RegWriteE),
    .MemtoRegE(MemtoRegE),
    .MemWriteE(MemWriteE),
    .LoadE(LoadE),
    .ALUOutE(ALUOutE),
    .WriteRegE(WriteRegE),
    .FwdME(FwdME),
    .WriteDataE(WriteDataE),
    .StopE(StopE),

    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .MemWriteM(MemWriteM),
    .LoadM(LoadM),
    .ALUOutM(ALUOutM),
    .WriteRegM(WriteRegM),
    .FwdMM(FwdMM),
    .WriteDataM(WriteDataM),
    .StopM(StopM)
);

assign WD = FwdMM ? ResultW: WriteDataM;

DataRAM main_memory(
    .CLK(CLK),
    .MemWriteM(MemWriteM),
    .WD(WD),
    .ALUOutM(ALUOutM),
    .StopM(StopM),

    .ReadDataM(ReadDataM)
);

// WD Stage
PipelineWD wd_stage(
    .CLK(CLK),
    .RegWriteM(RegWriteM),
    .MemtoRegM(MemtoRegM),
    .ReadDataM(ReadDataM),
    .ALUOutM(ALUOutM),
    .WriteRegM(WriteRegM),

    .RegWriteW(RegWriteW),
    .MemtoRegW(MemtoRegW),
    .ReadDataW(ReadDataW),
    .ALUOutW(ALUOutW),
    .WriteRegW(WriteRegW)
);

assign ResultW = MemtoRegW ? ReadDataW : ALUOutW;

// Hazard Unit
HazardUnit hazard_unit(
    .A1(InstrD[25:21]),
    .A2(InstrD[20:16]),
    .WriteRegE(WriteRegE),
    .WriteRegM(WriteRegM),
    .RSD(RSD),
    .RTD(RTD),
    .LoadE(LoadE),
    .LoadM(LoadM),
    .RegWriteE(RegWriteE),
    .RegWriteM(RegWriteM),
    .StoreD(StoreD),
    .BranchD(BranchD),

    .FwdA(FwdA),
    .FwdB(FwdB),
    .FwdM(FwdM),
    .EnableF(EnableF),
    .EnableD(EnableD),
    .RstD(RstD),
    .RstE(RstE)
);

endmodule