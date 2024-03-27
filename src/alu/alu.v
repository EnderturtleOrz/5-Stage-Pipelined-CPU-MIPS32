// flags[2] : zero flag
// flags[1] : negative flag
// flags[0] : overflow flag 
module alu(
    input[31:0] instruction, 
    input[31:0] regA, 
    input[31:0] regB, 
    output[31:0] result, 
    output[2:0] flags
);

reg[5:0] opcode, fun;
reg[4:0] sa;
reg[31:0] rd, rs, rt;
reg[31:0] im;
reg[2:0] flags;

always @(*) begin
    flags = 3'b0;
    opcode = instruction[31:26];
    if (instruction[25:21] == 5'b00000) begin
        rs = regA;
        rt = regB;
    end
    else begin
        rs = regB;
        rt = regA;
    end
    if (opcode == 6'b0) begin
        fun = instruction[5:0];
        sa = instruction[10:6];
        case(fun)
            6'h00: begin //sll
                rd = rt << sa;
            end
            6'h02: begin //srl
                rd = rt >> sa;
            end
            6'h03: begin //sra
                rd = $signed(rt) >>> sa;
            end
            6'h04: begin //sllv
                rd = rt << rs;
            end
            6'h06: begin //srlv
                rd = rt >> rs;
            end
            6'h07: begin //srav
                rd = $signed(rt) >>> rs;
            end
            6'h20: begin //add
                rd = rs + rt;
                flags[0] = (~rs[31] & ~rt[31] & rd[31]) | (rs[31] & rt[31] & ~rd[31]);
            end
            6'h21: begin //addu
                rd = rs + rt;
            end
            6'h22: begin //sub
                rd = rs - rt; 
                flags[0] = (~rs[31] & rt[31] & rd[31]) | (rs[31] & ~rt[31] & ~rd[31]);               
            end
            6'h23: begin //subu
                rd = rs - rt; 
            end
            6'h24: begin //and
                rd = rs & rt;
            end
            6'h25: begin //or
                rd = rs | rt;
            end
            6'h26: begin //xor
                rd = rs ^ rt;
            end
            6'h27: begin //nor
                rd = ~(rs | rt);
            end
            6'h2a: begin //slt
                rd = rs - rt;
                flags[1] = rd[31];
            end
            6'h2b: begin //sltu
                rd = rs - rt;
                flags[1] = (rs < rt);
            end
        endcase
    end
    else begin
        im = {{16{instruction[15]}},instruction[15:0]};
        case(opcode)
            6'h04: begin //beq
                rd = rs - rt;
                flags[2] = (rs == rt);
            end
            6'h05: begin //bne
                rd = rs - rt;
                flags[2] = (rs != rt);
            end
            6'h08: begin //addi
                rd = rs + im;
                flags[0] = (~rs[31] & ~im[31] & rd[31]) | (rs[31] & im[31] & ~rd[31]);
            end
            6'h09: begin //addiu
                rd = rs + im;
            end
            6'h0a: begin //slti
                rd = rs - im;
                flags[1] = rd[31];
            end
            6'h0b: begin //sltiu
                rd = rs - im;
                flags[1] = (rs < im);
            end
            6'h0c: begin //andi
                im = {16'b0,instruction[15:0]};
                rd = rs & im;
            end
            6'h0d: begin //ori
                im = {16'b0,instruction[15:0]};
                rd = rs | im;
            end
            6'h0e: begin //xori
                im = {16'b0,instruction[15:0]};
                rd = rs ^ im;
            end
            6'h23: begin //lw
                rd = rs + im;
            end
            6'h2b: begin //sw
                rd = rs + im;
            end
        endcase
    end
end

assign result = rd;

endmodule
