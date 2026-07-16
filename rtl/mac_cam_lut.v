module mac_cam_lut #(
    parameter ENTRY_COUNT = 16,
    parameter AGE_LIMIT = 1024
) (
    input wire clk,
    input wire rst_n,
    input wire learn_valid,
    input wire [47:0] learn_mac,
    input wire [1:0] learn_port,
    input wire lookup_valid,
    input wire [47:0] lookup_mac,
    output reg lookup_hit,
    output reg [1:0] lookup_port,
    output reg flood
);
    reg [47:0] mac_table [0:ENTRY_COUNT-1];
    reg [1:0] port_table [0:ENTRY_COUNT-1];
    reg valid_table [0:ENTRY_COUNT-1];
    integer age_table [0:ENTRY_COUNT-1];
    integer index;
    integer selected_index;
    reg found_entry;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (index = 0; index < ENTRY_COUNT; index = index + 1) begin
                valid_table[index] <= 1'b0;
                age_table[index] <= 0;
                mac_table[index] <= 48'b0;
                port_table[index] <= 2'b0;
            end
        end else begin
            for (index = 0; index < ENTRY_COUNT; index = index + 1) begin
                if (valid_table[index]) begin
                    if (age_table[index] >= AGE_LIMIT) begin
                        valid_table[index] <= 1'b0;
                    end else begin
                        age_table[index] <= age_table[index] + 1;
                    end
                end
            end
            if (learn_valid) begin
                selected_index = 0;
                found_entry = 1'b0;
                for (index = 0; index < ENTRY_COUNT; index = index + 1) begin
                    if (valid_table[index] && mac_table[index] == learn_mac) begin
                        selected_index = index;
                        found_entry = 1'b1;
                    end else if (!valid_table[index] && !found_entry) begin
                        selected_index = index;
                    end
                end
                valid_table[selected_index] <= 1'b1;
                mac_table[selected_index] <= learn_mac;
                port_table[selected_index] <= learn_port;
                age_table[selected_index] <= 0;
            end
        end
    end

    always @(*) begin
        lookup_hit = 1'b0;
        lookup_port = 2'b0;
        flood = lookup_valid;
        for (index = 0; index < ENTRY_COUNT; index = index + 1) begin
            if (lookup_valid && valid_table[index] && mac_table[index] == lookup_mac) begin
                lookup_hit = 1'b1;
                lookup_port = port_table[index];
                flood = 1'b0;
            end
        end
    end
endmodule
