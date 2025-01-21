`ifndef SEQUENCER_SVH
`define SEQUENCER_SVH

import my_pkg::my_sequence_item;
class my_sequencer extends uvm_sequencer #(my_sequence_item);
  `uvm_component_utils(my_sequencer)

  my_sequence_item item0;

  function new(string name = "my_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item0 = my_sequence_item#()::type_id::create("item0");
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_sequencer //my_sequencer extends uvm_sequencer

`endif // SEQUENCER_SVH