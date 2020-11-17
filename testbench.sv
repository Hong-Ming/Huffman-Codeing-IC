`timescale 1ns/1ps

`include "pattern.sv"
`include "huffman.sv"

module TESTBENCH();


logic clk;
logic rst_n;
logic in_valid;
logic [7:0] gray_data;

logic CNT_valid;
logic [7:0] CNT1, CNT2, CNT3, CNT4, CNT5, CNT6;
logic code_valid;
logic [7:0] HC1, HC2, HC3, HC4, HC5, HC6;
logic [7:0] M1, M2, M3, M4, M5, M6;
  
  
initial begin 
  $fsdbDumpfile("huffman.fsdb");
  $fsdbDumpvars();
  $fsdbDumpvars(0,"+mda");
end

huffman I_huffman
(
  .clk(clk),
  .rst_n(rst_n),
  .in_valid(in_valid),
  .gray_data(gray_data),
  .CNT_valid(CNT_valid),
  .CNT1(CNT1),
  .CNT2(CNT2),
  .CNT3(CNT3),
  .CNT4(CNT4),
  .CNT5(CNT5),
  .CNT6(CNT6),
  .code_valid(code_valid),
  .HC1(HC1),
  .HC2(HC2),
  .HC3(HC3),
  .HC4(HC4),
  .HC5(HC5),
  .HC6(HC6),
  .M1(M1),
  .M2(M2),
  .M3(M3),
  .M4(M4),
  .M5(M5),
  .M6(M6)

);


PATTERN I_PATTERN
(   
  .clk(clk),
  .rst_n(rst_n),
  .in_valid(in_valid),
  .gray_data(gray_data),
  .CNT_valid(CNT_valid),
  .CNT1(CNT1),
  .CNT2(CNT2),
  .CNT3(CNT3),
  .CNT4(CNT4),
  .CNT5(CNT5),
  .CNT6(CNT6),
  .code_valid(code_valid),
  .HC1(HC1),
  .HC2(HC2),
  .HC3(HC3),
  .HC4(HC4),
  .HC5(HC5),
  .HC6(HC6),
  .M1(M1),
  .M2(M2),
  .M3(M3),
  .M4(M4),
  .M5(M5),
  .M6(M6)
);

endmodule
