`ifndef AGENT_SVH
`define AGENT_SVH

import my_pkg::my_sequence_item;
import my_pkg::my_sequencer;
import my_pkg::my_driver;
import my_pkg::my_monitor;
import uvm_pkg::uvm_analysis_port;

class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)
  virtual intf vifc;
  my_sequence_item item0;
  uvm_analysis_port #(my_sequence_item) analysis_port;
  my_sequencer seq0;
  my_driver drv0;
  my_monitor mon0;

  function new(string name = "my_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vifc", vifc))
      `uvm_fatal(get_full_name(), "Error!")
    uvm_config_db#(virtual intf)::set(this, "drv0", "my_vifc", vifc);
    uvm_config_db#(virtual intf)::set(this, "mon0", "my_vifc", vifc);
    analysis_port = new("analysis_port", this);
    seq0 = my_sequencer::type_id::create("seq0", this);
    drv0 = my_driver::type_id::create("drv0", this);
    mon0 = my_monitor::type_id::create("mon0", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv0.seq_item_port.connect(seq0.seq_item_export);
    mon0.analysis_port.connect(analysis_port);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_agent //my_agent extends uvm_agent

`endif // AGENT_SVH