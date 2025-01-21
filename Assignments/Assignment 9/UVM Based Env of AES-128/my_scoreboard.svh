`ifndef SCOREBOARD_SVH
`define SCOREBOARD_SVH

import my_pkg::my_sequence_item;
import uvm_pkg::uvm_analysis_imp;

class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)
  my_sequence_item ref_item0;
  uvm_analysis_imp #(my_sequence_item, my_scoreboard) analysis_imp;

  function new(string name = "my_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction: new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ref_item0 = my_sequence_item#()::type_id::create("ref_item0");
    analysis_imp = new("analysis_imp", this);
  endfunction: build_phase
  integer fd;
  task write(my_sequence_item t);
    // Open file "key.txt" for writing
    fd = $fopen("ref_model/key.txt","w");
    // Writing to file : First line writing the data , Second line writing the key
    $fdisplay(fd,"%h\n%h", t.plain_text, t.cipher_key);
    // Close the "key.txt"
    $fclose(fd);
    // "$system" task to run the python code and interact with SCOREBOARD through I/O files
    $system($sformatf("python ref_model/aes_enc.py"));
    // Open file "output.txt" for reading
    fd = $fopen("ref_model/output.txt","r");
    // Reading the output of python code through "output.txt" file
    $fscanf(fd,"%h", ref_item0.cipher_text);
    // Close the "output.txt"
    $fclose(fd);
    // COMPARE THE ACTUAL OUTPUT AND EXPECTED OUTPUT
    if(ref_item0.cipher_text == t.cipher_text) begin
        `uvm_info(get_type_name(), $sformatf("SUCCESS , OUT IS %h and EXP-OUT IS %h ", t.cipher_text , ref_item0.cipher_text), UVM_LOW);
    end
    else begin
        `uvm_info(get_type_name(), $sformatf("FAILURE , OUT IS %h and EXP-OUT IS %h ", t.cipher_text , ref_item0.cipher_text), UVM_LOW);
    end
    
  endtask: write
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction: connect_phase

  task run_phase(uvm_phase phase);
    super.run_phase(phase);
  endtask: run_phase
endclass: my_scoreboard //my_scoreboard extends uvm_scoreboard

`endif // SCOREBOARD_SVH