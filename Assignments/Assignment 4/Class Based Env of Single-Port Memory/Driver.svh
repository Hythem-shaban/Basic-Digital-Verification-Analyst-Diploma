`ifndef DRIVER_SVH
`define DRIVER_SVH

import pkg::Transaction;
class Driver;
  Transaction tr;
  virtual intf drv_vif;
  event drv_dn;
  mailbox seq_drv_mbx;

  function new(mailbox seq_drv_mbx, virtual intf drv_vif, event drv_dn);
    this.seq_drv_mbx = seq_drv_mbx;
    this.drv_dn  = drv_dn;
    this.drv_vif = drv_vif;
  endfunction: new

  virtual task run();
    forever begin
      $display("[T=%0tns]: [Driver] waiting for transaction..", $time);
      seq_drv_mbx.get(tr);
      @(posedge drv_vif.clk);
      tr.print("Driver");
      drv_vif.rst_n <= tr.rst_n;
      drv_vif.i_data <= tr.i_data;
      drv_vif.addr <= tr.addr;
      drv_vif.we <= tr.we;
      -> drv_dn;
    end
  endtask: run
endclass: Driver

`endif // DRIVER_SVH