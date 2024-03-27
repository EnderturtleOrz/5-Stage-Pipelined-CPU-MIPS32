`include "global_const.v"
module HazardUnit (
	input[4:0] A1,
	input[4:0] A2,
    input[4:0] WriteRegE,
    input[4:0] WriteRegM,   
    input wire RSD,
    input wire RTD,
    input wire LoadE,
    input wire LoadM,
    input wire RegWriteE,
    input wire RegWriteM,
    input wire StoreD,
    input wire BranchD,
    output reg[1:0] FwdA,
    output reg[1:0] FwdB,
    output reg FwdM,
    output reg EnableF,
    output reg EnableD,
    output reg RstD,
    output reg RstE
);
reg stall = 0;
initial begin
    stall   = 0;
    FwdA    = 0;
    FwdB    = 0;
    FwdM    = 0;
    EnableF = 1;
    EnableD = 1;
    RstD    = 0;
    RstE    = 0;
end
always @(*) begin
    stall   = 0;
    FwdA    = 0;
    FwdB    = 0;
    FwdM    = 0;
    EnableF = 1;
    EnableD = 1;
    RstD    = 0;
    RstE    = 0;
    if (RSD && RegWriteE && A1 == WriteRegE) begin
        if (LoadE) stall = 1;
        else FwdA = `FWD_EXE;
    end
    if (RSD && RegWriteM && A1 == WriteRegM) begin
        if (LoadM) FwdA = `FWD_READ;
        else FwdA = `FWD_MEM;
    end
    if (RTD && RegWriteE && A2 == WriteRegE) begin
        if (LoadE) begin
            if (StoreD) FwdM = 1;
            else stall = 1;
        end
        else FwdB = `FWD_EXE;
    end
    if (RTD && RegWriteM && A2 == WriteRegM) begin
        if (LoadM) FwdB = `FWD_READ;
        else FwdB = `FWD_MEM;
    end
    if (stall) begin
        EnableF = 0;
        EnableD = 0;
        RstE = 1;
    end
    else if(BranchD) RstD = 1;
end
endmodule