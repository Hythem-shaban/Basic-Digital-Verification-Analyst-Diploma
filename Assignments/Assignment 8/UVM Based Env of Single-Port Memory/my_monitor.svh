`ifndef MONITOR_SVH
`define MONITOR_SVH

import my_pkg::my_sequence_item;
import uvm_pkg::uvm_analysis_port;

class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)

  virtual intf vifc;
  my_sequence_item item0;
  uvm_analysis_port #(my_sequence_item) analysis_port;

  function new(string name = "my_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vifc", vifc))
      `uvm_fatal(get_full_name(), "Error!")
    item0 = my_sequence_item#()::type_id::create("item0");
    analysis_port = new("analysis_port", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      @(posedge vifc.clk)
      item0.rst_n = vifc.rst_n;
      item0.i_data = vifc.i_data;
      item0.we = vifc.we;
      item0.addr = vifc.addr;
      if (!vifc.we)
        @(posedge vifc.clk);
      item0.o_data = vifc.o_data;
      item0.valid = vifc.valid;
      `uvm_info(get_type_name(), $sformatf("%s", item0.convert2str()), UVM_LOW)
      #1step analysis_port.write(item0);
    end
  endtask: run_phase
endclass: my_monitor //my_monitor extends uvm_monitor

`endif // MONITOR_SVH