`ifndef SUBSCRIBER_SVH
`define SUBSCRIBER_SVH

import pkg::Transaction;
class Subscriber;
  parameter WIDTH = Transaction#()::WIDTH;
  parameter DEPTH = Transaction#()::DEPTH;
  
  bit                     rst_n;
  bit [WIDTH-1:0]         i_data;
  bit                     we;
  bit [$clog2(DEPTH)-1:0] addr;
  bit [WIDTH-1:0]         o_data;
  bit                     valid;

  Transaction tr;
  mailbox mtr_sub_mbx;
  
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

  function new(mailbox mtr_sub_mbx);
    CG_ADDR = new();
    CG_RST = new();
    CG_READ = new();
    this.mtr_sub_mbx = mtr_sub_mbx;
  endfunction: new
  
  virtual task run();
    forever begin
      mtr_sub_mbx.get(tr);
      we = tr.we;
      addr = tr.addr;
      valid = tr.valid;
      o_data = tr.o_data;
      rst_n = tr.rst_n;
      CG_ADDR.sample();
      CG_RST.sample();
      CG_READ.sample();
    end
  endtask: run
endclass: Subscriber

`endif // SUBSCRIBER_SVH