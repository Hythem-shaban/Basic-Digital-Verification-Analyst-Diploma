`ifndef DRIVER_SVH
`define DRIVER_SVH

import my_pkg::my_sequence_item;
class my_driver extends uvm_driver #(my_sequence_item);
  `uvm_component_utils(my_driver);
  virtual intf vifc;
  my_sequence_item item0;

  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vifc", vifc))
      `uvm_fatal(get_full_name(), "Error!")
    item0 = my_sequence_item#()::type_id::create("item0");
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      `uvm_info(get_type_name(), $sformatf("Wait for item from sequencer"), UVM_LOW)
      seq_item_port.get_next_item(item0);
      @(vifc.cb_tb)
      vifc.plain_text <= item0.plain_text;
      vifc.cipher_key <= item0.cipher_key;
      #1step seq_item_port.item_done();
    end
  endtask: run_phase
endclass: my_driver //my_driver extendsuvm_driver

`endif // DRIVER_SVH