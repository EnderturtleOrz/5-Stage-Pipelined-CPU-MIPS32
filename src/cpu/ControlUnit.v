`include "global_const.v"
module ControlUnit (
    input[5:0] Op,
    input[5:0] Funct,
    input wire BranchEqual,
    output reg RSD,
    output reg RTD,
    output reg LoadD,
    output reg StoreD,
    output reg RegWriteD,
    output reg MemtoRegD,
    output reg MemWriteD,
    output reg BranchD,
    output reg[3:0] ALUControlD,
    output reg[1:0] ALUSrcAD,
    output reg[1:0] ALUSrcBD,
    output reg[1:0] RegDstD,
    output reg[1:0] SrcPCD,
    output reg Sign,
    output reg StopD
);
initial begin
    RSD         = 0;
    RTD         = 0;
    LoadD       = 0;
    StoreD      = 0;
    RegWriteD   = 0;
    MemtoRegD   = 0;
    MemWriteD   = 0;
    BranchD     = 0;
    ALUControlD = 3'b0;
    ALUSrcAD    = 2'b0;
    ALUSrcBD    = 2'b0;
    RegDstD     = 2'b0;
    SrcPCD      = 2'b0;
    StopD       = 0;    
end
always @(*) begin
    RSD         = 0;
    RTD         = 0;
    LoadD       = 0;
    StoreD      = 0;
    RegWriteD   = 0;
    MemtoRegD   = 0;
    MemWriteD   = 0;
    BranchD     = 0;
    ALUControlD = 3'b0;
    ALUSrcAD    = 2'b0;
    ALUSrcBD    = 2'b0;
    RegDstD     = 2'b0;
    SrcPCD      = 2'b0;
    StopD       = 0;
    Sign        = 1;
    if (Op == 6'b111111 && Funct == 6'b111111) begin
        StopD = 1;
    end
    else if (Op == 6'b0) begin
        RSD = 1;
        RTD = 1;
        case(Funct)
            6'h00: begin //sll
                ALUControlD = `ALU_SLL;
                ALUSrcAD    = `SRC_SA_OR_IM;
                ALUSrcBD    = `SRC_RS_OR_RT;
                RegDstD     = `DST_SRC_RD;
                RegWriteD   = 1;
                RSD         = 0;
            end
            6'h02: begin //srl
                ALUControlD = `ALU_SRL;
				ALUSrcAD    = `SRC_SA_OR_IM;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
                RSD         = 0;
            end
            6'h03: begin //sra
                ALUControlD = `ALU_SRA;
				ALUSrcAD    = `SRC_SA_OR_IM;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
                RSD         = 0;
            end
            6'h04: begin //sllv 
                ALUControlD = `ALU_SLL;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h06: begin //srlv
                ALUControlD = `ALU_SRL;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h07: begin //srav
                ALUControlD = `ALU_SRA;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h20: begin //add
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h21: begin //addu
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h22: begin //sub
                ALUControlD = `ALU_SUB;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h23: begin //subu
                ALUControlD = `ALU_SUB;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h24: begin //and
                ALUControlD = `ALU_AND;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h25: begin //or
                ALUControlD = `ALU_OR;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h26: begin //xor
                ALUControlD = `ALU_XOR;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h27: begin //nor
                ALUControlD = `ALU_NOR;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h2a: begin //slt
                ALUControlD = `ALU_SLT;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_RS_OR_RT;
				RegDstD     = `DST_SRC_RD;
				RegWriteD   = 1;
            end
            6'h08: begin //jr
                SrcPCD      = `PC_JR;
                BranchD     = 1;
                RTD         = 0;
            end
        endcase
    end
    else begin
        RSD = 1;
        case(Op)
            6'h04: begin //beq
                RTD = 1;
                if (BranchEqual) begin
                    SrcPCD   = `PC_BRANCH;
                    BranchD  = 1;                 
                end
            end
            6'h05: begin //bne
                RTD = 1;
                if (~BranchEqual) begin
                    SrcPCD   = `PC_BRANCH;
                    BranchD  = 1;                 
                end
            end
            6'h08: begin //addi
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
            end
            6'h09: begin //addiu
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
            end
            6'h0c: begin //andi
                ALUControlD = `ALU_AND;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
                Sign        = 0;
            end
            6'h0d: begin //ori
                ALUControlD = `ALU_OR;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
                Sign        = 0;
            end
            6'h0e: begin //xori
                ALUControlD = `ALU_XOR;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
                Sign        = 0;
            end
            6'h23: begin //lw
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
				RegDstD     = `DST_SRC_RT;
				RegWriteD   = 1;
                MemtoRegD   = 1;
                LoadD       = 1;
            end
            6'h2b: begin //sw
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_RS_OR_RT;
				ALUSrcBD    = `SRC_SA_OR_IM;
                MemWriteD   = 1;
                RTD         = 1;
                StoreD      = 1;  
            end
            6'h02: begin //j
                SrcPCD      = `PC_J;
                BranchD     = 1;
                RSD         = 0;  
            end
            6'h03: begin //jal
                ALUControlD = `ALU_ADD;
				ALUSrcAD    = `SRC_TARGET;
				ALUSrcBD    = `SRC_TARGET;
				RegDstD     = `DST_SRC_RA;
				RegWriteD   = 1;
                SrcPCD      = `PC_J;
                BranchD     = 1;
                RSD         = 0;     
            end
        endcase
    end
    //$display("ALUControl = %h, ALUSrcAD =%d ALUSrcBD =%d",ALUControlD,ALUSrcAD,ALUSrcBD);
end
endmodule