`include "uart.sv"
`timescale 1ns/1ps

module uart_tb;
parameter CLK_PERIOD = 20;

  reg        clk;           // Clock signal
  reg        reset_n;       // Reset signal (active low)
  wire         tx;            // Transmitted data
  reg        start_tx;      // Start transmission signal
  reg        cts_n;         // Clear-to-send signal
  reg  [1:0] data_bit_num;  // Number of data bits
  reg        parity_en;     // Parity enable
  reg        parity_type;   // Parity type (odd/even)
  reg        rx;
  reg        stop_bit_num;  // Number of stop bits (2 bits wide)
  wire  [7:0] rx_data;       // Received data
  wire        rx_done;       // Receive done signal
  wire        rts_n;         // Ready-to-send signal
  reg [7:0]  tx_data;       // Transmitted data output
  wire       tx_done;
  wire       parity_error;



  // UART module instantiation
  uart dut (
    .clk            (clk),
    .reset_n        (reset_n),
    .start_tx       (start_tx),
    .rx             (tx),
    .cts_n          (cts_n),
    .rts_n          (rts_n),
    .data_bit_num   (data_bit_num),
    .stop_bit_num   (stop_bit_num),
    .rx_data        (rx_data),
    .tx_data        (tx_data),
    .rx_done        (rx_done),
    .tx             (rx),
    .parity_error   (parity_error),
    .parity_en      (parity_en),
    .parity_type    (parity_type),
    .tx_done        (tx_done)
  ) ;

  // Generate clock signal
  initial begin
    clk = 0;
    forever #(CLK_PERIOD / 2) clk = ~clk;
  end
initial begin
    reset_n = 0;
    #10 
    reset_n =1;
end

  // Stimulus for testing
  initial begin
    start_tx = 1;

    #10
    start_tx     = 1'b1;
    reset_n      = 1'b1;   // Release reset
    parity_type  = 1'b0;   // No parity
    parity_en    = 1'b0;   // Parity disabled
    data_bit_num = 2'b11;  // 8 data bits
    stop_bit_num = 1'b1;  // 1 stop bit
    tx_data      = 8'h55;
  
    
    #500;
    reset_n      = 1'b0;   // Apply reset again
    
    #100;


    reset_n      = 1'b1;   // Release reset
    
  end


endmodule
