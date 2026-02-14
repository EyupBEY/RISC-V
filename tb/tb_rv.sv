`include "../rtl/pkg/riscv_pkg.sv"

module tb_rv
import riscv_pkg::*;
();

    parameter IMemInitFile = "imem.mem";
    parameter DMemInitFile = "dmem.mem";

    logic               clk;
    logic               rstn;
    logic   [XLEN-1:0]  addr;
    logic   [XLEN-1:0]  data;
    logic               update;
    logic   [XLEN-1:0]  pc;
    logic   [XLEN-1:0]  instr;
    logic   [4:0]       reg_addr;
    logic   [XLEN-1:0]  reg_data;
    logic   [XLEN-1:0]  mem_addr;
    logic   [XLEN-1:0]  mem_data;
    logic               mem_wrt;
    logic               mem_read;

    riscv_singlecycle #(
        .DMemInitFile(DMemInitFile),
        .IMemInitFile(IMemInitFile)
    ) core_ut (
        .clk_i(clk),
        .rstn_i(rstn),
        .addr_i(addr),
        .data_o(data),
        .update_o(update),
        .pc_o(pc),
        .instr_o(instr),
        .reg_addr_o(reg_addr),
        .reg_data_o(reg_data),
        .mem_addr_o(mem_addr),
        .mem_data_o(mem_data),
        .mem_wrt_o(mem_wrt),
        .mem_read_o(mem_read)
    );

    initial begin
        forever begin
            clk = 0;
            #1;
            clk = 1;
            #1;
        end
    end

    initial begin
        rstn = 0;
        #4;
        rstn = 1;
        while (instr != 0) begin
            #2;
        end
        $finish;
    end

endmodule
