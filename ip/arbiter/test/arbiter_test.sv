`include "common/rtl/sys_def.svh"
//`include "ip/arbiter/rtl/arbiter.sv"

module arbiterTestBench();

    parameter N = 4;
    logic clk, reset, valid_grant;
    logic [N-1:0] req, grant;

    arbiter #(.N(N)) dut (
        .clk(clk),
        .reset(reset),
        .req(req),
        .grant(grant),
        .valid_grant(valid_grant)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        reset = 1; #5;
        reset = 0; #5;

        req = 4'b0000; #5;
        req = 4'b1000; #5;
        req = 4'b0001; #5;
        req = 4'b1001; #5;
        req = 4'b0110; #5;
        req = 4'b1111; #5;
        $display("@@@ Passed");
        $finish;
    end

endmodule