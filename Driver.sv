// Driver Class
class uart_driver;
  virtual uart_if vif;
  mailbox#(uart_packet) drv2mon_mb;
  mailbox#(uart_packet) gen2drv_mb;

  function new(virtual uart_if vif_if, mailbox#(uart_packet) g2d_mb, mailbox#(uart_packet) d2m_mb);
    vif = vif_if;
    gen2drv_mb = g2d_mb;
    drv2mon_mb = d2m_mb;
  endfunction

  task drive_packets();
    uart_packet pkt;
    forever begin
      gen2drv_mb.get(pkt);
      vif.rx = 0;          // Start bit
      repeat (16) @(posedge vif.clk);
      for (int i = 0; i < 8; i++) begin
        vif.rx = pkt.data[i];
        repeat (16) @(posedge vif.clk);
      end
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