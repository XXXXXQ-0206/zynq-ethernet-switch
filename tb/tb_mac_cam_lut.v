`timescale 1ns/1ps

module tb_mac_cam_lut;
    reg clk = 0;
    reg rst_n = 0;
    reg learn_valid = 0;
    reg [47:0] learn_mac = 0;
    reg [1:0] learn_port = 0;
    reg lookup_valid = 0;
    reg [47:0] lookup_mac = 0;
    wire lookup_hit;
    wire [1:0] lookup_port;
    wire flood;

    mac_cam_lut #(.ENTRY_COUNT(4), .AGE_LIMIT(8)) dut (
        .clk(clk), .rst_n(rst_n), .learn_valid(learn_valid),
        .learn_mac(learn_mac), .learn_port(learn_port),
        .lookup_valid(lookup_valid), .lookup_mac(lookup_mac),
        .lookup_hit(lookup_hit), .lookup_port(lookup_port), .flood(flood)
    );

    always #5 clk = ~clk;

    initial begin
        repeat (2) @(negedge clk);
        rst_n = 1'b1;
        @(negedge clk);
        learn_valid = 1'b1;
        learn_mac = 48'h66778899aabb;
        learn_port = 2'd2;
        @(negedge clk);
        learn_valid = 1'b0;
        lookup_valid = 1'b1;
        lookup_mac = 48'h66778899aabb;
        #1;
        if (!lookup_hit || lookup_port != 2'd2 || flood) begin
            $fatal(1, "Known MAC was not forwarded to the learned port");
        end
        lookup_mac = 48'h001122334455;
        #1;
        if (lookup_hit || !flood) begin
            $fatal(1, "Unknown MAC was not flooded");
        end
        $display("tb_mac_cam_lut PASS");
        $finish;
    end
endmodule
