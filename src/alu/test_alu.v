`timescale 1ns/1ps

module test;
    reg  [31:0] instruction;
    reg  [31:0] regA;
    reg  [31:0] regB;
    wire [31:0] result;
    wire [2:0] flags;
    alu test(instruction, regA, regB, result, flags);
    initial begin
    $display("Start testing (rs = regA by default)");
    $display("Initilazion (all zeros)");	
    instruction = 32'h0;
    regA = 32'h0;
    regB = 32'h0;

    $monitor("instruction: 32'h%h, regA: 32'h%h, regB: 32'h%h, result: 32'h%h, flags: 3'b%b \n", instruction, regA, regB, test.result, test.flags);
    #10$display("Group 1:");
    #10 $display("add (no overflow)");
        instruction <= 32'h00010020;
        regA <= 32'h00000001;
        regB <= 32'h00000002;
    #10 $display("add (overflow)");
        instruction <= 32'h00010020;
        regA <= 32'h7fffffff;
        regB <= 32'h00000008;
    #10 $display("addi (no overflow)");
        instruction <= 32'b001000_00000_00001_0000000000000001;
        regA <= 32'h00000000;
        regB <= 32'h00000000;
    #10 $display("addi (overflow)");
        instruction <= 32'b001000_00000_00001_0000000000000001;
        regA <= 32'h7fffffff;
        regB <= 32'h00000000;		
    #10 $display("addu");
        instruction <= 32'h00200021;
        regA <= 32'h7fffffff;
        regB <= 32'h00000006;
    #10 $display("addiu (rs = regB)");
        instruction <= 32'b001000_00001_00000_0000000000000001;
        regA <= 32'h00000001;
        regB <= 32'h00000003;
    #10 $display("Group 2:");		
    #10 $display("sub (no overflow)");
        instruction <= 32'h00010022;
        regA <= 32'h00000001;
        regB <= 32'h00000002;
    #10 $display("sub (overflow)");
        instruction <= 32'h00010022;
        regA <= 32'h7fffffff;
        regB <= 32'hffffffff;
    #10 $display("subu");
        instruction <= 32'h00010023;
        regA <= 32'h7fffffff;
        regB <= 32'hffffffff;
    #10 $display("Group 3:");	
    #10 $display("and");
        instruction <= 32'h00010024;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("andi");
        instruction <= 32'b001100_00000_00001_0000000000000001;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("nor");
        instruction <= 32'h00200027;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("or");
        instruction <= 32'h00200025;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("ori");
        instruction <= 32'b001101_00000_00001_0000000000000001;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("xor");
        instruction <= 32'h00200026;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("xori");
        instruction <= 32'b001110_00000_00001_0000000000000001;
        regA <= 32'h7fffffff;
        regB <= 32'h00000001;
    #10 $display("Group 4:");
    #10 $display("beq (non-zero)");
        instruction <= 32'h10010001;
        regA <= 32'h00000000;
        regB <= 32'h00000001;
    #10 $display("beq (zero)");
        instruction <= 32'h10010001;
        regA <= 32'h00000001;
        regB <= 32'h00000001;
    #10 $display("bne (non-zero)");
        instruction <= 32'h14010001;
        regA <= 32'h00000000;
        regB <= 32'h00000000;
    #10 $display("bne (zero)");
        instruction <= 32'h14010001;
        regA <= 32'h00000000;
        regB <= 32'h00000001;
    #10 $display("slt (negative)");
        instruction <= 32'h0001002a;
        regA <= 32'hf0000000;
        regB <= 32'h00000000;
    #10 $display("slt (non-negative)");
        instruction <= 32'h0001002a;
        regA <= 32'h00000000;
        regB <= 32'hf0000000;
    #10 $display("sltu (negative)");
        instruction <= 32'h0001002b;
        regA <= 32'h00000000;
        regB <= 32'hf0000000;
    #10 $display("sltu (non-negative)");
        instruction <= 32'h0001002b;
        regA <= 32'hf0000000;
        regB <= 32'h00000000;
    #10 $display("sltiu (negative)");
        instruction <= 32'b001011_00000_00001_1000000000000000;
        regA <= 32'h00000000;
        regB <= 32'h00000000;
    #10 $display("sltiu (non-negative)");
        instruction <= 32'b001011_00000_00001_0000000000000001;
        regA <= 32'hf0000000;
        regB <= 32'h00000000;
    #10 $display("Group 5:");
    #10 $display("lw");
        instruction <= 32'h8c01700f;
        regA <= 32'h00000001;
        regB <= 32'h00000000;
    #10 $display("sw");
        instruction <= 32'hac01700f;
        regA <= 32'h00000001;
        regB <= 32'h00000000;
    #10 $display("Group 6:");
    #10 $display("sll(10)");
        instruction <= 32'h00010280;
        regA <= 32'h00000000;
        regB <= 32'h00000001;
    #10 $display("sllv");
        instruction <= 32'h00010004;
        regA <= 32'h00000001;
        regB <= 32'h00000001;
    #10 $display("srl(10)");
        instruction <= 32'h00010282;
        regA <= 32'h00000000;
        regB <= 32'hf0000000;
    #10 $display("srlv");
        instruction <= 32'h00010006;
        regA <= 32'h00000001;
        regB <= 32'h00000100;
    #10 $display("sra(16)");
        instruction <= 32'b000000_00000_00001_00000_01000_000011;
        regA <= 32'h00000000;
        regB <= 32'hf0000000;
    #10 $display("srav");
        instruction <= 32'h00010007;
        regA <= 32'h00000010;
        regB <= 32'hf0000000;    
    $finish;	
    end
endmodule