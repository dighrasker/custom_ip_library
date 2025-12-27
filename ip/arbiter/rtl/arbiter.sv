`include "common/rtl/sys_def.svh"


module arbiter #(parameter N = 8)(

    input logic  clk,
    input logic reset,
    input logic [N-1:0] req,
    output logic [N-1:0] grant,
    output logic valid_grant
);  

    logic [N-1:0] local_grant;
    logic grant_valid;
    always_comb begin
        local_grant = '0;
        grant_valid = 1;
        for(int i = N-1; i > 0; --i) begin
            if(req[i]) begin
                local_grant[i] = 1;
                break;
            end
        end
    end


    always_ff @ (posedge clk) begin
        if (reset) begin
            grant <= '0;
        end else if (grant_valid) begin
            grant <= local_grant;
            valid_grant <= 1;
        end else begin
            valid_grant <= 0;
        end
    end

endmodule