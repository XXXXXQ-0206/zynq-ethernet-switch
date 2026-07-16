module ethernet_switch (
    input wire clk,
    input wire rst_n,
    input wire frame_valid,
    input wire [7:0] frame_data,
    input wire [3:0] frame_byte_index,
    input wire [1:0] ingress_port,
    output wire header_valid,
    output wire lookup_hit,
    output wire [1:0] egress_port,
    output wire flood
);
    wire [47:0] destination_mac;
    wire [47:0] source_mac;
    wire [15:0] ether_type;

    eth_parser parser (
        .clk(clk), .rst_n(rst_n), .frame_valid(frame_valid),
        .frame_data(frame_data), .frame_byte_index(frame_byte_index),
        .header_valid(header_valid), .destination_mac(destination_mac),
        .source_mac(source_mac), .ether_type(ether_type)
    );

    mac_cam_lut cam_lut (
        .clk(clk), .rst_n(rst_n), .learn_valid(header_valid),
        .learn_mac(source_mac), .learn_port(ingress_port),
        .lookup_valid(header_valid), .lookup_mac(destination_mac),
        .lookup_hit(lookup_hit), .lookup_port(egress_port), .flood(flood)
    );
endmodule
