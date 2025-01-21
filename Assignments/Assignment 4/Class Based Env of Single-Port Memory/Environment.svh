`ifndef ENVIRONMENT_SVH
`define ENVIRONMENT_SVH

import pkg::*;
class Environment;
  Sequencer seq;
  Driver drv;
  Monitor mtr;
  Scoreboard scb;
  Subscriber sub;
  virtual intf env_vif;
  mailbox seq_drv_mbx, mtr_scb_mbx, mtr_sub_mbx;
  event drv_dn;

  function new(virtual intf env_vif);
    this.env_vif = env_vif;
  endfunction: new

  virtual function void build();
    seq_drv_mbx = new();
    mtr_scb_mbx = new();
    mtr_sub_mbx = new();
    seq = new(seq_drv_mbx, drv_dn);
    drv = new(seq_drv_mbx, env_vif, drv_dn);
    mtr = new(mtr_scb_mbx, mtr_sub_mbx, env_vif);
    scb = new(mtr_scb_mbx);
    sub = new(mtr_sub_mbx);
  endfunction: build

  virtual task run();
    fork
      seq.run(50);
      drv.run();
      mtr.run();
      scb.run();
      sub.run();
    join_any
  endtask: run

  virtual function void wrap_up();
  endfunction: wrap_up
endclass: Environment

`endif // ENVIRONMENT_SVH