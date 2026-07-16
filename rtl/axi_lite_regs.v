module axi_lite_regs (
    input wire s_axi_aclk,
    input wire s_axi_aresetn,
    input wire [5:0] s_axi_awaddr,
    input wire s_axi_awvalid,
    output reg s_axi_awready,
    input wire [31:0] s_axi_wdata,
    input wire s_axi_wvalid,
    output reg s_axi_wready,
    output reg [1:0] s_axi_bresp,
    output reg s_axi_bvalid,
    input wire s_axi_bready,
    input wire [5:0] s_axi_araddr,
    input wire s_axi_arvalid,
    output reg s_axi_arready,
    output reg [31:0] s_axi_rdata,
    output reg [1:0] s_axi_rresp,
    output reg s_axi_rvalid,
    input wire s_axi_rready,
    input wire [31:0] rx_counter,
    input wire [31:0] tx_counter
);
    reg [31:0] control_register;

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn) begin
            control_register <= 32'b0;
            s_axi_awready <= 1'b0;
            s_axi_wready <= 1'b0;
            s_axi_bvalid <= 1'b0;
            s_axi_bresp <= 2'b00;
            s_axi_arready <= 1'b0;
            s_axi_rvalid <= 1'b0;
            s_axi_rdata <= 32'b0;
            s_axi_rresp <= 2'b00;
        end else begin
            s_axi_awready <= s_axi_awvalid && s_axi_wvalid && !s_axi_bvalid;
            s_axi_wready <= s_axi_awvalid && s_axi_wvalid && !s_axi_bvalid;
            if (s_axi_awvalid && s_axi_wvalid && !s_axi_bvalid) begin
                if (s_axi_awaddr == 6'h00) begin
                    control_register <= s_axi_wdata;
                end
                s_axi_bvalid <= 1'b1;
                s_axi_bresp <= 2'b00;
            end else if (s_axi_bvalid && s_axi_bready) begin
                s_axi_bvalid <= 1'b0;
            end
            s_axi_arready <= s_axi_arvalid && !s_axi_rvalid;
            if (s_axi_arvalid && !s_axi_rvalid) begin
                case (s_axi_araddr)
                    6'h00: s_axi_rdata <= control_register;
                    6'h04: s_axi_rdata <= rx_counter;
                    6'h08: s_axi_rdata <= tx_counter;
                    default: s_axi_rdata <= 32'b0;
                endcase
                s_axi_rvalid <= 1'b1;
                s_axi_rresp <= 2'b00;
            end else if (s_axi_rvalid && s_axi_rready) begin
                s_axi_rvalid <= 1'b0;
            end
        end
    end
endmodule
