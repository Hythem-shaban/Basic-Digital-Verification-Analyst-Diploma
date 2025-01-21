`ifndef MONITOR_SVH
`define MONITOR_SVH

import pkg::Transaction;
class Monitor;
  Transaction tr;
  virtual intf mtr_vif;
  mailbox mtr_scb_mbx, mtr_sub_mbx;


  function new(mailbox mtr_scb_mbx, mailbox mtr_sub_mbx, virtual intf mtr_vif);
    this.mtr_vif = mtr_vif;
    this.mtr_scb_mbx = mtr_scb_mbx;
    this.mtr_sub_mbx = mtr_sub_mbx;
  endfunction: new

  virtual task run();
    forever begin
      tr = new();
      @(posedge mtr_vif.clk);
      tr.rst_n = mtr_vif.rst_n;
      tr.i_data = mtr_vif.i_data;
      tr.we = mtr_vif.we;
      tr.addr = mtr_vif.addr;
      tr.o_data = mtr_vif.o_data;
      tr.valid = mtr_vif.valid;
      tr.print("Monitor");
      mtr_scb_mbx.put(tr);
      mtr_sub_mbx.put(tr);
    end
  endtask: run
endclass: Monitor

`endif // MONITOR_SVH