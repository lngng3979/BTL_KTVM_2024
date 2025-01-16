// Include timing


`include "Driver_Base.sv"
class Uart_Driver extends Uart_DriverBase;
    typedef mailbox #(Uart_Packet) gen2drv_mb;
    gen2drv_mb gen2drv = new;
    typedef mailbox #(Uart_Packet) drv2sb_mb;
    drv2sb_mb drv2sb = new;

    extern function new(string name = "Uart_Driver", gen2drv_mb gen2drv, drv2sb_mb drv2sb, virtual Implement_io.TB Implement);
    extern virtual task start();
endclass

function Uart_Driver::new(string name = "Uart_Driver", gen2drv_mb gen2drv, drv2sb_mb drv2sb,virtual Implement_io.TB Implement);
    super.new(name, Implement);
    this.gen2drv = gen2drv;
    this.drv2sb = drv2sb;
endfunction

task Uart_Driver::start();
    reg [12:0] bit_frame_temp;
    int get_flag =10 ;
    int packets_sent = 0;
    $display ($time, "ns: [DRIVER] Driver Started");
        fork
            forever 
            begin 
                gen2drv.get(pkt2send); //grab the packet in the queqe
                packets_sent++;
                bit_frame_temp = {pkt2send.idle_bit, pkt2send.start_bit, pkt2send.data_frame, pkt2send.parity,pkt2send.stop_bit};
                $display($time, "[DRIVER] Sending in new packet BEGIN");


                this.payload_bit_frame    = bit_frame_temp;
                this.payload_data_bit_num = data_bit_num;
                this.payload_parity_en    = parity_en;
                this.payload_parity_type  = parity_type;
                this.payload_stop_bit_num = stop_bit_num;

                send();
                $display ($time, "ns: [DRIVER] Sending in new packet END");
                $display ($time, "ns: [DRIVER] Number of packets sent = %d",packets_sent);
                drv2mon2.put(pkt2send);
                $display($time, "ns: [DRIVER] The number of Packets in the Generator Mailbox = %d", gen2drv.num());
                if(gen2drv.num() == 0)begin
                    break;
                end
                @(Execute.cb);
            end
        join_none
        $display ($time,  "[DRIVER] DRIVER Forking of process is finished");		
endtask


//monitor ,driver , packet , 