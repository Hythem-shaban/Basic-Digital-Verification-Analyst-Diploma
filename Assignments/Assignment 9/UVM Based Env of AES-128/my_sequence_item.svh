`ifndef SEQUENCE_ITEM_SVH
`define SEQUENCE_ITEM_SVH

class my_sequence_item #(parameter KEY_WIDTH = 128) extends uvm_sequence_item;
  `uvm_object_utils(my_sequence_item)

  function new(string name = "my_sequence_item");
    super.new(name);
  endfunction: new

  rand bit [127:0] plain_text;
  rand bit [KEY_WIDTH-1:0] cipher_key;
       bit [127:0] cipher_text;
  

  virtual function string convert2str();
    return $sformatf("plain_text=%0h, cipher_key=%0h, cipher_text=%0h", plain_text, cipher_key, cipher_text);
  endfunction: convert2str
  
endclass: my_sequence_item //my_sequence_item extends uvm_sequence_item

`endif // SEQUENCE_ITEM_SVH