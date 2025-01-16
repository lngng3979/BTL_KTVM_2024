`include "OutputPacket.sv"
class Uart_MonitorBase;
    virtual Implement_io.TB             Implement;
    
    string                              name;
    OutputPacket                        pkt2cmp;

    reg [7:0]                           rx_data2cmp;
    reg                                 parity_error2cmp;
    reg                                 rts_n2cmp;
    reg                                 rx_done2cmp;

    extern function new(string name= "MonitorBase", virtual Implement_io.TB Implement);
    extern virtual task recv();
    extern virtual task get_payload();
endclass

function Uart_MonitorBase::new(string name, virtual Implement_io.TB Implement);
    this.name = name ;
    this.Implement = Implement;
    pkt2cmp = new();
endfunction

task Uart_MonitorBase::recv();
    int pkt_cnt         = 0;
    get_payload();

    pkt2cmp.name        = $psprintf("rcvdPkt[%0d]", pkt_cnt++);
    pkt2cmp.rx_data     =rx_data2cmp;
    pkt2cmp.parity_error=parity_error2cmp;
    pkt2cmp.rts_n       =rts_n2cmp;
    pkt2cmp.rx_done     =rx_done2cmp;

endtask

task Uart_MonitorBase::get_payload();
    
    repeat(13) @(Implement.cb);
    $display  ($time, "[RECEIVER] Getting Payload");
    rx_data2cmp     =   Implement.cb.rx_data;
    rx_done2cmp     =   Implement.cb.rx_done;
    parity_error2cmp=   Implement.cb.parity_error;
    rts_n2cmp       =   Implement.cb.rts_n;
    
    $display($time , "[RECEIVER]  Payload Contents : rx_data = %h rx_done = %h parity_error = %h rts_n = %h", rx_data2cmp, rx_done2cmp, parity_error2cmp, rts_n2cmp);

endtask
