`include "pkg/riscv_pkg.sv"
/* verilator lint_off IMPORTSTAR */



module riscv_singlecycle
import riscv_pkg::*;
# (
    parameter DMemInitFile = "dmem.mem",    // Data Memory Initialization File
    parameter IMemInitFile = "imem.mem"     // Instruction Memory Initialization File
) (
    input   logic               clk_i,      // System Clock
    input   logic               rstn_i,     // System Reset (active low)
    input   logic   [XLEN-1:0]  addr_i,
    output  logic   [XLEN-1:0]  data_o,
    output  logic               update_o,   // Retire Signal
    output  logic   [XLEN-1:0]  pc_o,       // Retired Program Counter
    output  logic   [XLEN-1:0]  instr_o,    // Retired Instruction
    output  logic   [4:0]       reg_addr_o, // Retired Register Address
    output  logic   [XLEN-1:0]  reg_data_o, // Retired Register Data
    output  logic   [XLEN-1:0]  mem_addr_o, // Retired Memory Address
    output  logic   [XLEN-1:0]  mem_data_o, // Retired Memory Data
    output  logic               mem_wrt_o,  // Retired Memory Write Enable Signal
    output  logic               mem_read_o  // Retired Memory Readed Signal
);

//...

endmodule