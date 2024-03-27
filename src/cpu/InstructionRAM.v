module InstructionRAM (
    input CLK,
    input[31:0] PCF,
    output reg[31:0] instruction
);
reg[31:0] RAM[0:511];
integer i;
initial begin
    for(i = 0; i < 512; i = i + 1)
        RAM[i] = 32'b0;
    $readmemb("CPU_instruction.bin",RAM);
end
always @(negedge CLK)
begin
    //$display("Instruction = %b",RAM[PCF>>2]);
    instruction <= RAM[PCF>>2];
end
endmodule