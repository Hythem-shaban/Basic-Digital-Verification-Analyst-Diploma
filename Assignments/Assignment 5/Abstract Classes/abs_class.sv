virtual class Class1;
  pure virtual function void fun1(int x1, int y1);

  pure virtual function void fun2(int x2, int y2);
endclass: Class1

class Class2 extends Class1;
  function new();
    super.new();
  endfunction: new

  virtual function fun1(int x1, int y1);
    int res;
    res = x1 + y1;
    $display("Result of fun1: %0d", res);
  endfunction

  /* MUST BE OVERRIDEN
  virtual function fun2(int x2, int y2);
    int res;
    res = x2 + y2;
    $display("Result of fun2: %0d", res);
  endfunction
  */
endclass: Class2

class Class3 extends Class1;
  function new();
    super.new();
  endfunction: new

  /*MUST BE OVERRIDEN
  virtual function fun1(int x1, int y1);
    int res;
    res = x1 + y1;
    $display("Result of fun1: %0d", res);
  endfunction
  */

  virtual function fun2(int x2, int y2);
    int res;
    res = x2 + y2;
    $display("Result of fun2: %0d", res);
  endfunction
endclass: Class3