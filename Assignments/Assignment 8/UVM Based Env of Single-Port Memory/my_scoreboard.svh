`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

import my_pkg::my_sequence_item;
import uvm_pkg::uvm_analysis_imp;

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

  parameter WIDTH = my_sequence_item#()::WIDTH;

  my_sequence_item item0;
  bit [WIDTH-1:0] ref_data[int] = '{default: 0};
  uvm_analysis_imp #(my_sequence_item, my_scoreboard) analysis_imp;
  
  function new(string name = "my_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    analysis_imp = new("analysis_imp", this);
  endfunction: build_phase

  virtual task write (my_sequence_item item0);
    if(!item0.rst_n) begin
        foreach(ref_data[i])
          ref_data[i] = 0;
    end
    else begin
      if(item0.we) begin
        ref_data[item0.addr] = item0.i_data;
        `uvm_info(get_type_name(), $sformatf("Write %s", item0.convert2str()), UVM_LOW)
      end
      if(!item0.we) begin
        if(!ref_data.exists(item0.addr)) begin
          if (item0.o_data != 0) begin
            `uvm_info(get_type_name(), $sformatf("ERROR! First time read %s", item0.convert2str()), UVM_LOW)
          end
          else begin
            `uvm_info(get_type_name(), $sformatf("PASS! First time read %s", item0.convert2str()), UVM_LOW)
          end
        end
        else begin
          if(item0.o_data != ref_data[item0.addr]) begin
            `uvm_info(get_type_name(), $sformatf("Read ERROR! addr=%0d exp=%0d act=%0d", item0.addr, ref_data[item0.addr], item0.o_data), UVM_LOW)
          end
          else begin
            `uvm_info(get_type_name(), $sformatf("Read PASS! addr=%0d exp=%0d act=%0d", item0.addr, ref_data[item0.addr], item0.o_data), UVM_LOW)
          end
        end
      end
    end
  endtask: write

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_scoreboard //my_scoreboard extends superClass

`endif // SCOREBOARD_SVH