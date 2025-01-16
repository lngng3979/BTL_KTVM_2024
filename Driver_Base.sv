// Driver Class
class Uart_DriverBase;
  virtual Implement_io.TB Implement;
  string name;
  Uart_Packet pkt2send;

  reg [12:0]        payload_bit_frame;
  reg [1:0]         payload_data_bit_num;
  reg               payload_parity_en;
  reg               payload_parity_type;
  reg               payload_stop_bit_num;

  extern function new(string name = "Uart_DriverBase", virtual Implement_io.TB Implement);
  extern virtual task send();
  extern virtual task send_payload();
endclass

  function Uart_DriverBase::new(string name = "Uart_DriverBase", virtual Implement_io.TB Implement);

    this.name      = name;
    this.Implement = Implement;

  endfunction 

  task Uart_DriverBase::send();
    send_payload();
  endtask

  task Uart_DriverBase::send_payload();
            $display($time, "ns: [DRIVER] Sending Payload Begin");
            
            Implement.cb.               <= payload_bit_frame;
            Implement.cb.data_bit_num            <= payload_data_bit_num;
            Implement.cb.parity_en               <= payload_parity_en;
            Implement.cb.parity_type             <= payload_parity_type;
            Implement.cb.stop_bit_num            <= payload_stop_bit_num;

          // This is where we would be sending the data out into a queue for the Scoreboard  
  endtask


