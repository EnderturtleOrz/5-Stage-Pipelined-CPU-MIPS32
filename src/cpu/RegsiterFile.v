module RegsiterFile(
    input CLK,
    input[4:0] A1,
    input[4:0] A2,
    input[4:0] A3,
    input WE3,
    input[31:0] WD3,
    output reg[31:0] RD1,
    output reg[31:0] RD2
);
integer i;
reg[31:0] RegFile[1:31]; // Note RegFIle[0] always return 0
initial begin
    for (i = 1; i < 32; i++)
        RegFile[i] = 32'b0;
end

always @(negedge CLK)
begin
    if (WE3 && A3!=5'b0) RegFile[A3] <= WD3;
end

// Use asynchronous structure
always @(*)
begin
    if (A1 == 4'b0) RD1 = 32'b0;
    else RD1 = RegFile[A1];
    if (A2 == 4'b0) RD2 = 32'b0;
    else RD2 = RegFile[A2];   
end

// always @(*)
// begin
//     for (i = 1; i < 32; i = i + 1)
//         $display("Reg %d %d",i,RegFile[i]);
//     $display("\n");
// end

endmodule