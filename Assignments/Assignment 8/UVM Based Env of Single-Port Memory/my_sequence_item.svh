`ifndef SEQUENCE_ITEM_SVH
`define SEQUENCE_ITEM_SVH

class my_sequence_item #(parameter WIDTH = 32, DEPTH = 16) extends uvm_sequence_item;
  `uvm_object_utils(my_sequence_item)

  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction: new

  rand bit                     rst_n;
  rand bit [WIDTH-1:0]         i_data;
  rand bit                     we;
  rand bit [$clog2(DEPTH)-1:0] addr;
       bit [WIDTH-1:0]         o_data;
       bit                     valid;

  constraint c_rstn
    {
      rst_n dist {0:=5, 1:=95};
    }

  virtual function string convert2str();
    return $sformatf("rst_n=%0d i_data=%0d addr=%0d we=%0d o_data=%0d valid=%0d", rst_n, i_data, addr, we, o_data, valid);
  endfunction

endclass: my_sequence_item //my_sequence_item extends uvm_sequence_item

`endif // SEQUENCE_ITEM_SVH