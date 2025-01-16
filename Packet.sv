`ifndef Packet
`define Packet
// Define a Packet Class

class Uart_Packet;
                   
  rand  reg             rx           ;                   // serial bit to Uart receiver
  rand  reg [1:0]       data_bit_num ;                   // data bit num mode : 5 to 8
  randc reg             parity_en    ;                   // Parity enable or not
  randc reg             parity_type  ;                   // Odd or Even
  rand  reg             stop_bit_num ;                   // Number of stop bits (1 or 2)
  
  

  //bit_frame signal
  randc  reg            idle_bit     ;
  randc  reg            start_bit    ;
  randc  reg[7:0]       data_frame   ;
  randc  reg            parity       ;
  randc  reg [1:0]      stop_bit     ;
  
  
  string          name;

  
  //Constraint for data member 
  constraint limit {
        idle_bit  inside [1];
        start_bit inside [0];
        stop_bit  inside [11;1];
  }
  
  constraint 
  
 //A lot of constraint

      extern function new(string name = "Uart_Packet");

endclass

function Packet::new(string name = "Uart_Packet");
        this.name = name ;
endfunction

`endif 