program automatic test (intf tb_ifc);
  import pkg::Environment;
  Environment env;
  initial
    begin
      env = new(tb_ifc);
      env.build();
      env.run();
      env.wrap_up();
      #10;
      $finish;
    end
endprogram: test