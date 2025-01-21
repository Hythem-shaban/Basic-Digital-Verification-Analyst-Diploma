`timescale 1ns/1ns
interface intf#(parameter KEY_WIDTH = 128) (input logic clk);

logic [127:0] plain_text;
logic [KEY_WIDTH-1:0] cipher_key;
logic [127:0] cipher_text;

clocking cb_tb @(posedge clk);
  output plain_text;
  output cipher_key;
  input cipher_text;
endclocking: cb_tb

modport tb (
  clocking cb_tb
);

endinterface: intf