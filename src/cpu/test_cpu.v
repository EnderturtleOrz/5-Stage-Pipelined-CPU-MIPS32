`timescale 1ns/1ps

module test;
    reg CLK;
    CPU cpu(.CLK(CLK));
    initial begin
        CLK = 0;
    end
    always #10
    begin
        CLK = ~CLK;
    end
endmodule
