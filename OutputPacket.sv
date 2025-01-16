`ifndef OUTPUT_PACKET_SV
`define OUTPUT_PACKET_SV

class Uart_OutputPacket;

    string              name;

    reg [7:0]           rx_data;
    reg                 parity_error;
    reg                 rts_n;
    reg                 rx_done;

    extern function new(string name = "OutputPacket");

endclass

function Uart_OutputPacket::new(string name);
    this.name = name;
endfunction

`endif 