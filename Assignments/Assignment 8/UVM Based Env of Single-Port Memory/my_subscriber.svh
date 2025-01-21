`ifndef SUBSCRIBER_SVH
`define SUBSCRIBER_SVH

import my_pkg::my_sequence_item;

class my_subscriber extends uvm_subscriber #(my_sequence_item);
  `uvm_component_utils(my_subscriber)

  parameter WIDTH = my_sequence_item#()::WIDTH;
  parameter DEPTH = my_sequence_item#()::DEPTH;
  
  bit                     rst_n;
  bit [WIDTH-1:0]         i_data;
  bit                     we;
  bit [$clog2(DEPTH)-1:0] addr;
  bit [WIDTH-1:0]         o_data;
  bit                     valid;

  my_sequence_item item0;

  covergroup CG_ADDR;
    CP_ADDR: coverpoint addr;
  endgroup: CG_ADDR

  covergroup CG_RST;
    CP_VALID: coverpoint valid{
      bins bin_valid = {0};
    }
    CP_RST: coverpoint rst_n{
      bins bin_rst = {0};
    }
    CP_ODATA: coverpoint o_data{
      bins bin_odata = {0};
    }
    CP_CROSS_VALID_RST: cross CP_VALID, CP_RST, CP_ODATA;
  endgroup: CG_RST

  covergroup CG_READ;
    CP_WE: coverpoint we{
      bins bin_valid = {0};
    }
    CP_RST: coverpoint rst_n{
      bins bin_rst = {1};
    }
    CP_ODATA: coverpoint o_data{
      bins bin_odata = {[2**(WIDTH-1):(2**(WIDTH-1))-1]};
    }
    CP_VALID: coverpoint valid{
      bins bin_valid = {1};
    }
    CP_CROSS_VALID_RST: cross CP_WE, CP_VALID, CP_RST, CP_ODATA;
  endgroup: CG_READ

  function new(string name = "my_subscriber", uvm_component parent = null);
    super.new(name, parent);
    CG_ADDR = new();
    CG_RST = new();
    CG_READ = new();
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item0 = my_sequence_item#()::type_id::create("item0");
  endfunction: build_phase

  function void write (my_sequence_item t);
    we = t.we;
    addr = t.addr;
    valid = t.valid;
    o_data = t.o_data;
    rst_n = t.rst_n;
    CG_ADDR.sample();
    CG_RST.sample();
    CG_READ.sample();
  endfunction: write

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_subscriber //my_subscriber extends uvm_subscriber

`endif // SUBSCRIBER_SVH