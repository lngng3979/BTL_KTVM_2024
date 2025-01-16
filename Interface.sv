// Define an Interface
interface Implement_io;
  logic       reset_n      ;
  logic[12:0] bit_frame    ;      // serial input rx come to register
  logic [1:0] data_bit_num ;        // data bit num mode : 5 to 8
  logic       parity_en    ;         // Parity enable or not
  logic       parity_type  ;         // Odd or Even
  logic       stop_bit_num ;         // Number of stop bits (1 or 2)
  logic [7:0] rx_data;                  // Parallel output
  logic       rx_done      ;      // Done signal
  logic       rts_n;             //request to send signal
  logic       parity_error ;      // Parity error

  clocking cb@(posedge clk);
  default input #1 output#2;
  input    rx_data;
  input    rx_done;
  input    parity_error;
  input    rts_n;
  output   data_bit_num;
  output   parity_en;
  output   stop_bit_num;
  output   bit_frame;
  output   parity_type;   


  endclocking

  modport  TB(clocking cb, output reset_n);
endinterface