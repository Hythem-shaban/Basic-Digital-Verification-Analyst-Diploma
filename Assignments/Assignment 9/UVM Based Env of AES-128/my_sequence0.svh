`ifndef SEQUENCE_SVH
`define SEQUENCE_SVH

import my_pkg::my_sequence_item;
class my_sequence0 extends uvm_sequence;
  `uvm_object_utils(my_sequence0)
  my_sequence_item item0;

  function new(string name = "my_sequence");
    super.new(name);
  endfunction : new

//  task pre_body();
//    item0 = my_sequence_item::type_id::create("item0");
//  endtask: pre_body

  task body();
    for (int i = 0; i < 5; i++) begin
      item0 = my_sequence_item#()::type_id::create("item0");
      start_item(item0);
      assert(item0.randomize())
        else
          `uvm_fatal(get_full_name, "Failed to randomize item0");
      `uvm_info(get_type_name(), $sformatf("Generate new item: %s", item0.convert2str()), UVM_LOW)
      finish_item(item0);
    end
  endtask: body
endclass: my_sequence0 //my_sequence0 extends uvm_sequence

`endif // SEQUENCE_SVH
