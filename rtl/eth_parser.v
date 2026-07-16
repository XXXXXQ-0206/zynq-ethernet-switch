module eth_parser (
    input wire clk,
    input wire rst_n,
    input wire frame_valid,
    input wire [7:0] frame_data,
    input wire [3:0] frame_byte_index,
    output reg header_valid,
    output reg [47:0] destination_mac,
    output reg [47:0] source_mac,
    output reg [15:0] ether_type
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            header_valid <= 1'b0;
            destination_mac <= 48'b0;
            source_mac <= 48'b0;
            ether_type <= 16'b0;
        end else if (frame_valid) begin
            header_valid <= (frame_byte_index == 4'd13);
            case (frame_byte_index)
                4'd0: destination_mac[47:40] <= frame_data;
                4'd1: destination_mac[39:32] <= frame_data;
                4'd2: destination_mac[31:24] <= frame_data;
                4'd3: destination_mac[23:16] <= frame_data;
                4'd4: destination_mac[15:8] <= frame_data;
                4'd5: destination_mac[7:0] <= frame_data;
                4'd6: source_mac[47:40] <= frame_data;
                4'd7: source_mac[39:32] <= frame_data;
                4'd8: source_mac[31:24] <= frame_data;
                4'd9: source_mac[23:16] <= frame_data;
                4'd10: source_mac[15:8] <= frame_data;
                4'd11: source_mac[7:0] <= frame_data;
                4'd12: ether_type[15:8] <= frame_data;
                4'd13: ether_type[7:0] <= frame_data;
                default: begin end
            endcase
        end else begin
            header_valid <= 1'b0;
        end
    end
endmodule
