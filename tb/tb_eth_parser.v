`timescale 1ns/1ps

module tb_eth_parser;
    reg clk = 0;
    reg rst_n = 0;
    reg frame_valid = 0;
    reg [7:0] frame_data = 0;
    reg [3:0] frame_byte_index = 0;
    wire header_valid;
    wire [47:0] destination_mac;
    wire [47:0] source_mac;
    wire [15:0] ether_type;

    eth_parser dut (
        .clk(clk),
        .rst_n(rst_n),
        .frame_valid(frame_valid),
        .frame_data(frame_data),
        .frame_byte_index(frame_byte_index),
        .header_valid(header_valid),
        .destination_mac(destination_mac),
        .source_mac(source_mac),
        .ether_type(ether_type)
    );

    always #5 clk = ~clk;

    task send_byte;
        input [3:0] index;
        input [7:0] value;
        begin
            @(negedge clk);
            frame_valid = 1'b1;
            frame_byte_index = index;
            frame_data = value;
        end
    endtask

    initial begin
        repeat (2) @(negedge clk);
        rst_n = 1'b1;
        send_byte(0, 8'h00); send_byte(1, 8'h11); send_byte(2, 8'h22);
        send_byte(3, 8'h33); send_byte(4, 8'h44); send_byte(5, 8'h55);
        send_byte(6, 8'h66); send_byte(7, 8'h77); send_byte(8, 8'h88);
        send_byte(9, 8'h99); send_byte(10, 8'haa); send_byte(11, 8'hbb);
        send_byte(12, 8'h08); send_byte(13, 8'h00);
        @(posedge clk); #1;
        if (!header_valid || destination_mac != 48'h001122334455 ||
            source_mac != 48'h66778899aabb || ether_type != 16'h0800) begin
            $fatal(1, "Ethernet II header parsing failed");
        end
        $display("tb_eth_parser PASS");
        $finish;
    end
endmodule
