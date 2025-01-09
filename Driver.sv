// Driver Class
class uart_driver;
  virtual uart_if vif;
  mailbox#(uart_packet) drv2mon_mb;
  mailbox#(uart_packet) gen2drv_mb;

 
      vif.rx = pkt.parity;
      repeat (16) @(posedge vif.clk);
      for (int j = 0; j < pkt.stop_bits; j++) begin
        vif.rx = 1;         // Stop bits
        repeat (16) @(posedge vif.clk);
      end
      drv2mon_mb.put(pkt);
    end
  endtask
endclass
