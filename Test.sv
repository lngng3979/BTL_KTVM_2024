// Test Class
`include "Packet.sv"
`include "OutputPacket.sv"
`include "Driver.sv"
`include "Generator.sv"
`include "Monitor.sv"
`include "Scoreboard.sv"

program Implement_Test #(
    parameter  TEST_NAME = "Data_Integrity",   //defaults
    parameter  NUM_PACKETS = 10
)(Implement_io.TB Implement);

    Uart_Generator generator ;
    Uart_Driver    drvr;
    Uart_Scoreboard sb;
    Uart_Monitor    mon;

    Uart_Packet    pkt_sent = new("Uart_Packet");
    int            count    = 0;
    int            number_packets;
    string         test_name = TEST_NAME;

    initial begin
        number_packets =NUM_PACKETS;
        generator      = new("Uart_Generator", number_packets);
        sb             = new();

        drvr           = new("drvr[0]", generator.gen2drv,sb.drv2sb, Implement);
        rcvr           = new("rcvr[0]", sb.mon2sb);
        reset();
        $display("[%tns] Start test case for : %s",$time ,test_name);
        generator.start(test_name);
        drvr.start();
        sb.start();
        rcvr.start();
        repeat(number_packets+1) @(Implement.cb);
        sb.result();
        $display($time, "WE ARE DONE ... GO HOME AND SLEEP!!! .... ANYWAY STILL MAINTAINANCE");

    end
 
    task reset();
    $display($time, "ns: [RESET] Design Reset Start");
    Implement.reset_n              <= 1'b0;
    repeat(10) @(Implement.cb);
    Implement.reset_n               <=1'b1;
    $display($time, "ns: [RESET] Design Reset End");
    endtask

//This is the end of the TB
endprogram