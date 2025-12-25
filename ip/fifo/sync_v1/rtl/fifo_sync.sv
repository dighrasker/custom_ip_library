`include "common/rtl/sys_def.svh"


module fifo_sync (

    input logic                 clk,
    input logic                 reset,
    input logic                 rd_en,
    input logic                 wr_en,
    input logic  [WIDTH-1:0]    wr_data,
    output logic [WIDTH-1:0]    rd_data,
    output logic [$clog2(LENGTH+1)-1:0] spots,
    output logic                rd_ready,
    output logic                wr_ready
);

    //internal variables/data structures
    logic [WIDTH-1:0] fifo [0:LENGTH-1];
    logic [LENGTH_BITS-1:0] head, tail;
    logic full, empty;
    logic [$clog2(LENGTH+1)-1:0] next_spots;
    logic rd_fire, wr_fire;

    assign full = (spots == 0);
    assign empty = (spots == LENGTH);
    //is there space to read/write
    assign wr_ready = !full;
    assign rd_ready = !empty;

    assign rd_fire = rd_ready && rd_en;
    assign wr_fire = (wr_ready || rd_fire) && wr_en;

    assign next_spots = (rd_fire && !wr_fire) ? (spots + 1) : (!rd_fire && wr_fire) ? (spots - 1) : spots;

    always_ff @ (posedge clk) begin
        if(reset) begin
            head <= '0;
            tail <= '0;
            rd_data <= '0;
            spots <= LENGTH;
        end else begin
            if(rd_fire) begin
                rd_data <= fifo[head];
                head <= (head == (LENGTH - 1)) ? '0 : head + 1;
                
            end

            if(wr_fire) begin
                fifo[tail] <= wr_data;
                tail <= (tail == (LENGTH - 1)) ? '0 : tail + 1;
                
            end
            spots <= next_spots;
        end

    end

endmodule