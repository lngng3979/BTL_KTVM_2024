// Test Top Module
module Implement_Test_Top;
  uart dut(
    .clk(Implement_io.clk),
    .reset_n(Implement_io.reset_n),
    .rx(Implement_io.rx),
    .rts_n(Implement_io.rts_n),
    .data_bit_num(Implement_io.data_bit_num),
    .stop_bit_num(Implement_io.stop_bit_num),
    .parity_en(Implement_io.parity_en),
    .parity_type(Implement_io.parity_type),
    .rx_data(Implement_io.rx_data),
    .rx_done(Implement_io.rx_done),
    .parity_error(Implement_io.parity_error),
    
  )
  /* ------------- TEST NAME ------------------------
  1. all_top                            // Generate all operations
  2. 5bit
  3. 6bit
  ....
*/

  Implement_Test #(.TEST_NAME("5bit"),.NUM_PACKETS(100)) test(Implement_io)
initial 
begin



end
endmodule
