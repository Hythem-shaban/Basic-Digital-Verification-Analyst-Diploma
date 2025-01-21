module top;
  int a, b;
  initial
    begin
      a = 10;
      b <= 2;
      #1 force b = 1;
      #2 b = 10;
      a <= b;
      release b;
      #3 a = 30;
    end
  initial
    begin
      #2 a = b+1;
      #1 b <= 2;
    end
  initial
    begin
      $monitor("[%0t], a=%2d, b=%0d", $time, a, b);
    end
endmodule: top

// [0], a=10, b=2
// [1], a=10, b=1
// [2], a= 2, b=1
// [3], a= 1, b=2
// [6], a=30, b=2