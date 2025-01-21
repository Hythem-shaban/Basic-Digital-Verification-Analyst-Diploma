`ifndef ENVIRONMENT_SVH
`define ENVIRONMENT_SVH

import my_pkg::my_agent;
import my_pkg::my_scoreboard;
import my_pkg::my_subscriber;

class my_environment extends uvm_env;
  `uvm_component_utils(my_environment)
  virtual intf vifc;
  my_agent agt0;
  my_scoreboard scb0;
  my_subscriber sub0;

  function new(string name = "my_environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf)::get(this, "", "my_vifc", vifc))
      `uvm_fatal(get_full_name(), "Error!")
    uvm_config_db#(virtual intf)::set(this, "agt0", "my_vifc", vifc);
    agt0 = my_agent::type_id::create("agt0", this);
    scb0 = my_scoreboard::type_id::create("scb0", this);
    sub0 = my_subscriber::type_id::create("sub0", this);
  endfunction: build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt0.analysis_port.connect(scb0.analysis_imp);
    agt0.analysis_port.connect(sub0.analysis_export);
    //agt0.mon0.analysis_port.connect(scb0.analysis_imp);
    //agt0.mon0.analysis_port.connect(sub0.analysis_export);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_environment //my_environment extends uvm_environment

`endif // ENVIRONMENT_SVH