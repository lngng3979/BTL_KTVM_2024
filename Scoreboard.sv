`include "Packet.sv"
`include "OutputPacket.sv"

// Scoreboard Class
class Uart_Scoreboard;
        string              name;
        Uart_Packet         pkt_sent = new();
        Uart_OutputPacket   pkt_cmp  = new();

        typedef mailbox #(Uart_Packet) drv2sb_mb;
        drv2sb_mb                      drv2sb;

        typedef mailbox #(Uart_OutputPacket)  mon2sb_mb;
        mon2sb_mb                             mon2sb;

        int                                   num_test;
        int                                   num_test_passed;
        int                                   num_test_failed;

        // Declare the signals to be compared 
        reg [7:0]           rx_data_chk= 0;
        reg                 rx_done_chk= 0;
        reg                 parity_error_chk= 0;
        reg                 rts_n_chk= 0;

//----------------------------------Define CoverGroup -------------------------------------//

//..................................................................

//-------------------------------------------------------------------------------------------------//

    extern          funtion new(string name = "Uart_Scoreboard", drv2sb_mb drv2sb = null,mon2sb_mb mon2sb = null);
    extern  virtual task  start();
    extern  virtual task  check();
    extern  virtual task  check_rts_n();
    extern  virtual task  check_rx_done();
    extern  virtual task  check_rx_data();
    extern  virtual task  check_parity();
    extern  virtual task  result();


endclass

function Uart_Scoreboard::new(string name, drv2sb_mb drv2sb, mon2sb_mb mon2sb);
this.name           =name;
if(drv2sb ==null)
drv2sb             =new();
if(mon2sb  ==null)
mon2sb              =new();
this.drv2sb         =drv2sb;
this.mon2sb         =mon2sb;
//COVERAGE ADDITION
//...............

endfunction 

task Uart_Scoreboard::start();
     $display ($time, "[SCOREBOARD] Scoreboard Started");

     $display ($time, "[SCOREBOARD] Receiver Mailbox contents = %d", mon2sb.num());)
    fork
        forever
        begin
            if(mon2sb.try_get(pkt_cmp)) begin
                    $display($time, "[SCOREBOARD] Grabbing Data From both Driver and Monitor");
                    drv2sb.get(pkt_sent);
                    check();
/// fill in here

            end
            else
            begin
                #1;
            end
        end



    join_none
