`ifndef SEQUENCER_SVH
`define SEQUENCER_SVH

import pkg::Transaction;
class Sequencer;
  Transaction tr;
  event drv_dn;
  mailbox seq_drv_mbx;

  function new(mailbox seq_drv_mbx, event drv_dn);
    this.seq_drv_mbx = seq_drv_mbx;
    this.drv_dn  = drv_dn;
  endfunction: new

  virtual task run(input int n);
    for (int i=0; i<n; i++) begin
      tr = new();
      assert(tr.randomize())
        else
          $fatal(0, "%s:%0d: Randomization failed ", `__FILE__, `__LINE__, "\"tr.randomize\"" );
      $display("[T=%0tns]: [Generator] Loop %0d/%0d create next transactor", $time, i+1, n);
      seq_drv_mbx.put(tr);
      $display("[T=%0tns]: [Generator] wait for driver to be done", $time);
      @(drv_dn);
    end
  endtask: run
endclass: Sequencer

`endif // SEQUENCER_SVH