// This file defined all the global constants especially for control signals in MUX

// PC control
`define PC_PLUS4      2'b00
`define PC_J          2'b01
`define PC_JR         2'b10 
`define PC_BRANCH     2'b11

// SRC_COMMON control
`define SRC_RS_OR_RT  2'b00
`define SRC_SA_OR_IM  2'b01
`define SRC_TARGET    2'b10

// SRC_DST control
`define DST_SRC_RT    2'b00
`define DST_SRC_RD    2'b01
`define DST_SRC_RA    2'b10

// FORWARD control
`define FWD_NONE      2'b00
`define FWD_EXE       2'b01
`define FWD_MEM       2'b10
`define FWD_READ      2'b11

// ALU control
`define ALU_ADD       4'b0000
`define ALU_SUB       4'b0010
`define ALU_AND       4'b0100
`define ALU_OR        4'b0101
`define ALU_XOR       4'b0110
`define ALU_NOR       4'b0111
`define ALU_SLL       4'b1000
`define ALU_SRL       4'b1010
`define ALU_SRA       4'b1100
`define ALU_SLT       4'b1110

