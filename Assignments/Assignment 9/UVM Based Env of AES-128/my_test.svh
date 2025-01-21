`ifndef TEST_SVH
`define TEST_SVH

import my_pkg::my_sequence0;
import my_pkg::my_environment;

class my_test extends uvm_test;
  `uvm_component_utils(my_test)
  virtual intf vifc;
  my_sequence0 seq0;
  my_environment env0;

  function new(string name = "my_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vifc", vifc))
      `uvm_fatal(get_full_name(), "Error!")
    uvm_config_db#(virtual intf)::set(this, "env0", "my_vifc", vifc);
    seq0 = my_sequence0::type_id::create("seq0", this);
    env0 = my_environment::type_id::create("env0", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    seq0.start(env0.agt0.seq0);
    phase.drop_objection(this);
  endtask: run_phase
endclass: my_test //my_test extends uvm_test

`endif // TEST_SVH