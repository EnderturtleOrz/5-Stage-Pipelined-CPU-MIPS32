// Since we do not need to detect overflow and something else , so remove flags
`include "global_const.v"
module alu(
    input[3:0] sel, 
    input[31:0] regA, 
    input[31:0] regB, 
    output reg[31:0] res
);
always @(*) begin
    case(sel)
        `ALU_ADD:  res = regA + regB;
        `ALU_SUB:  res = regA - regB;
        `ALU_AND:  res = regA & regB;
        `ALU_OR:   res = regA | regB;
        `ALU_XOR:  res = regA ^ regB;
        `ALU_NOR:  res = ~(regA | regB);
        `ALU_SLL:  res = regB << regA;
        `ALU_SRL:  res = regB >> regA;
        `ALU_SRA:  res = $signed(regB) >>> regA;
        `ALU_SLT:  res = (($signed(regA))<($signed(regB)));
    endcase
    //$display("ALU ID = %d, RegA = %d, RegB =%d",sel,regA,regB);
end

endmodule
