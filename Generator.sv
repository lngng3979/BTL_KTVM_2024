`include "Packet.sv"
// Generator Class

class Uart_Generator;
    string      name    ;
    Uart_Packet pkt2send;

  typedef mailbox #(Uart_Packet) gen2drv_mb;
  gen2drv_mb  gen2drv;

  int packet_number;
  int number_packets;

  extern function new(string name = "Uart_Generator", int number_packets);
  extern virtual task gen  (string test_name );
  extern virtual task start(string test_name );


function int contains(string a , string b);
    //check if string A contains string B
    int len_a ;
    int len_b ;
    len_a = a.len();
    len_b = b.len();

    $display("a (%s) len %d -- b (%s) len %d ", a , len_a , b ,len_b);
    for (int i =0 ; i<len_a , i++) begin
        if(a.subsbtr(i , i+len_b -1 ) == b)
        return 1;
    end
    return 0;
endfunction
endclass


  function Uart_Generator::gen(string name = "Uart_Generator", int number_packets);
    this.name     =    name ;
    this.pkt2send =    new();
    this.gen2drv  =    new;
    this.packet_number = 0;
    this.number_packets= number_packets;
  endfunction

  //Fill in the blank 

  task Uart_Generator::gen(string test_name);
  pkt2send.name         = $psprintf("Uart_Packet [%0d]", packet_number ++);
  
  //set up constraint mode for Uart_Packet
  pkt2send.data.constraint_mode(0);
  pkt2send.
  pkt2send.    .constraint_mode(0);



  endtask

  task Uart_Generator::start(string test_name);
        $display($time, "ns : [GENERATOR] Generator Started"):
        fork
            begin
                for( int i= 0; i<number_packets || number_packets <=0; i++)
                begin
                    gen(test_name);
                begin
                    Uart_Packet pkt= new pkt2send;
                    gen2drv.put(pkt); 
                end
            end

            end
            $display($time, "ns: [GENERATOR] Generation Finish Creating %d Packets ", number_packets);
        join_none
  endtask

