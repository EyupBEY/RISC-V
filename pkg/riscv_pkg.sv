`timescale 1ns / 1ps

package riscv_pkg;

    localparam XLEN = 32; // Register width (32-bit for RV32I)
    localparam PLEN = (XLEN == 32) ? 34 : 56; // Program Counter width (34 bits for RV32I, 56 bits for RV64I)

    // ---------------
    // Privilege Spec
    // ---------------
    typedef enum logic [1:0] {
        PRIV_LVL_M = 2'b11,
        PRIV_LVL_HS = 2'b10,
        PRIV_LVL_S = 2'b01,
        PRIV_LVL_U = 2'b00
    } priv_lvl_t;

    // type which holds xlen
    typedef enum logic [1:0] {
        XLEN_32 = 2'b01,
        XLEN_64 = 2'b10,
        XLEN_128 = 2'b11
    } xlen_e;

    typedef enum logic [1:0] {
        Off = 2'b00,
        Initial = 2'b01,
        Clean = 2'b10,
        Dirty = 2'b11
    } xs_t;

    typedef struct packed {
        logic           sd;     // Signal Dirty State - Read-Only
        logic   [62:34] wpri6;  // Writes Preserved Reads Ignored
        xlen_e          uxl;    // Variable User Mode XLEN - Hardwired to Zero in RV32I
        logic   [11:0]  wpri5;  // Writes Preserved Reads Ignored
        logic           mxr;    // Make eXecutable Readable
        logic           sum;    // Permit Supervisor User Memory Access
        logic           wpri4;  // Writes Preserved Reads Ignored
        xs_t            xs;     // Extension Register - Hardwired to Zero in RV32I
        xs_t            fs;     // Floating-point Extension Register
        logic   [1:0]   wpri3;  // Writes Preserved Reads Ignored
        xs_t            vs;     // Vector Extension Register
        logic           spp;    // Holds The Previous Privilage Mode Up To Supervisor
        logic           wpri2;  // Writes Preserved Reads Ignored
        logic           mpie;   // Machine Interrupts Enable Bit Active Prior To Trap
        logic           ube;    // UBE Controls Whether Explicit Load And Store Memory Accesses From U-Mode Are Little-Endian (UBE=0) Or Big-Endian (UBE=1)
        logic           spie;   // Supervisor Interrupts Enable Bit Active Prior To Trap
        logic   [2:0]   wpri1;  // Writes Preserved Reads Ignored
        logic           sie;    // Supervisor Interrupts Enable
        logic           wpri0;  // Writes Preserved Reads Ignored
    } sstatus_rv_t;

    //...

endpackage