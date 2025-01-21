class env #(parameter WIDTH = 32, DEPTH = 16);
  typedef struct {
		bit [WIDTH-1:0] i_data;
		bit [$clog2(DEPTH)-1:0] addr; 
		bit we;
		bit valid;
		bit [WIDTH-1:0] o_data;
	} Packet;

  Packet driver_q [$];
  Packet monitor_q [$];

  event driver_done;

  task generator(input int count);
    Packet pkt;
    for (int i = 0; i < count; i++)
      begin
        $display("[T=%0tns]: [Generator] create packet %0d/%0d", $time, i+1, count);
        pkt.i_data = $random;
        pkt.addr = $random;
        pkt.we = $random;
        $display("[T=%0tns]: [Generator] send packet %p to driver", $time, pkt);
        driver_q.push_front(pkt);
        $display("[T=%0tns]: [Generator] wait for driver to be done", $time);
        @(driver_done);
      end
  endtask: generator

  task driver(virtual intf ifc);
    Packet pkt;
    $display("[T=%0tns]: [Driver] starting..", $time);
    forever begin
      $display("[T=%0tns]: [Driver] waiting for packet..", $time);
      pkt = driver_q.pop_back();
      $display("[T=%0tns]: [Driver] %p", $time, pkt);
      @(posedge ifc.clk);
      ifc.i_data <= pkt.i_data;
      ifc.addr   <= pkt.addr;
      ifc.we     <= pkt.we;
      -> driver_done;
    end
  endtask: driver

  task monitor(virtual intf ifc);
    Packet pkt;
    $display("[T=%0tns]: [Monitor] starting..", $time);
    forever begin
      @(posedge ifc.clk);
      pkt.i_data = ifc.i_data;
      pkt.addr   = ifc.addr;
      pkt.we     = ifc.we;
      if (!ifc.we) begin
        @(posedge ifc.clk);
      end  
        pkt.o_data = ifc.o_data;
        pkt.valid = ifc.valid;
      monitor_q.push_front(pkt);
      $display("[T=%0tns]: [Monitor] %p", $time, pkt);
    end
  endtask: monitor

  task scoreboard(output int error_c);
    Packet ref_q [DEPTH], pkt;
    $display("[T=%0tns]: [Scoreboard] starting..", $time);
    forever begin
      pkt = monitor_q.pop_back();
      if (pkt.we) begin
        ref_q[pkt.addr] = pkt;
        $display("[T=%0tns]: [Scoreboard] Write %p", $time, pkt);
      end
		#10;
      if (!pkt.we) begin
        if(pkt.o_data != ref_q[pkt.addr].i_data)
          begin
          	$display("[T=%0tns]: [Scoreboard] Read Error %p", $time, pkt);
            error_c ++;
          end
        else
          begin
          	$display("[T=%0tns]: [Scoreboard] Read Pass %p", $time, pkt);
          end
      end
    end
  endtask: scoreboard
endclass: env