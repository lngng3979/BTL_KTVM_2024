//include timing

// Monitor Class
class Uart_Monitor extends Uart_MonitorBase;
  typedef mailbox#(Uart_OutputPacket) mon2sb_mb;
  mon2sb_mb mon2sb;

  extern  function new(string name = "Uart_Monitor", mon2sb_mb mon2sb,virtual Implement_io.TB Implement);
  extern  virtual task start();
  
endclass

function Uart_Monitor::new (string name , mon2sb_mb mon2sb, virtual Implement_io.TB Implement);
  super.new(name , Implement);
  this.mon2sb = mon2sb;
endfunction

task Uart_Monitor::start();
    int i;
    i=0;
    $display($time, "[MONITOR] MONITOR STARTED");
    repeat(13) @(Implement.cb);
    fork
      forever
      begin
        recv();
        mon2sb.put(pkt2cmp);
        $display($time, "[MONITOR] Payload Obtained");
        i++;

      end

    join_none
    $display($time, "[MONITOR] Forking of Process Finished");
endtask