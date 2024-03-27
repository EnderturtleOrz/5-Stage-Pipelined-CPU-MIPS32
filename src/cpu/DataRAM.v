module DataRAM (
    input CLK,
    input MemWriteM,
    input[31:0] WD,
    input[31:0] ALUOutM,
    input StopM,
    output reg[31:0] ReadDataM
);
reg[31:0] RAM[0:511];
integer i;
integer file_handle = 0;
localparam file_name = "./data.bin";

initial begin
    for (i = 0; i < 512; i = i + 1)
        RAM[i] = 32'b0;
end

//integer CLK_cnt;

//initial begin
//    CLK_cnt = 0;
//end

//always @(posedge CLK) begin
//    CLK_cnt = CLK_cnt + 1;
//end

always @(*)
begin
    if (StopM) begin
        file_handle = $fopen(file_name, "w");
        if (!file_handle)
        begin
            $display("Couldn't open the file.");
            $stop;
        end
        for (i = 0; i < 512; i ++)
        begin
            $fwrite(file_handle,"%b\n", RAM[i]);
        end
        //$display("CLK_cnt = %d",CLK_cnt);
        $finish;
    end
end

always @(negedge CLK)
begin
    if (MemWriteM) RAM[ALUOutM >> 2] <= WD;
    ReadDataM <= RAM[ALUOutM >> 2];
end
endmodule