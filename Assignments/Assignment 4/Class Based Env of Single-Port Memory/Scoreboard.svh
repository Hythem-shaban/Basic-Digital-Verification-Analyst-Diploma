`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

import pkg::Transaction;
class Scoreboard;
  parameter DEPTH = Transaction#()::DEPTH;
  Transaction tr, ref_tr[DEPTH];
  mailbox mtr_scb_mbx;

  function new(mailbox mtr_scb_mbx);
    this.mtr_scb_mbx = mtr_scb_mbx;
  endfunction: new

  virtual task run();
    forever begin
      mtr_scb_mbx.get(tr);
      tr.print("Scoreboard");
      if(!tr.rst_n) begin
        foreach(ref_tr[i])
          ref_tr[i] = null;
      end
      else begin
        if(tr.we) begin
          if(ref_tr[tr.addr] == null) begin
            ref_tr[tr.addr] = new();
          end
          ref_tr[tr.addr] = tr;
          $display("[T=%0tns]: [Scoreboard] Write %p", $time, tr);
        end

        if(!tr.we) begin
          if(ref_tr[tr.addr] == null) begin
            if (tr.o_data != 0) begin
              $display ("[T=%0tns]: [Scoreboard] ERROR! First time read, addr=%0d, exp=0, act=%0d", $time, tr.addr, tr.o_data);
            end
            else begin
              $display ("[T=%0tns]: [Scoreboard] PASS! First time read, addr=%0d, exp=0, act=%0d", $time, tr.addr, tr.o_data);
            end
          end
          else begin
            if(tr.o_data != ref_tr[tr.addr].i_data) begin
              $display("[T=%0tns]: [Scoreboard] Read ERROR! addr=%0d exp=%0d act=%0d", $time, tr.addr, ref_tr[tr.addr].i_data, tr.o_data);
            end
            else begin
                $display("[T=%0tns]: [Scoreboard] Read PASS! addr=%0d exp=%0d act=%0d", $time, tr.addr, ref_tr[tr.addr].i_data, tr.o_data);
            end
          end
        end
      end
    end
  endtask: run
endclass: Scoreboard

`endif // SCOREBOARD_SVH