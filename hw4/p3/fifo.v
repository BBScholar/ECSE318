

module fifo #(
  parameter W = 8,
  parameter D = 4
)
(
  input clk, push, pop, clear_b,
  input [W - 1:0] data_in,
  output full, empty, has_one,
  output [W - 1:0] data_out
);
  localparam CNT_BITS = $clog2(D) + 1;
  
  reg [W - 1:0] internal_data[0:D-1];
  reg [CNT_BITS-1:0] counter;

  integer i;

  assign empty = counter == 0;
  assign full = counter == D;
  assign has_one = counter == 1;

  assign data_out = internal_data[0];

  always @ (posedge clk) begin 
    if(!clear_b) begin 
      counter <= 'b0;
    end else if(push & pop) begin 
      for(i = 0; i < D - 1; i = i + 1) begin 
        internal_data[i] <= internal_data[i + 1];
      end 
      internal_data[D - 1] <= data_in;
    end else if(push & !full) begin 
      counter <= counter + 1;
      internal_data[counter] <= data_in;
    end else if(pop & !empty) begin 
      counter <= counter - 1;
      
      for(i = 0; i < D - 1; i = i + 1) begin 
        internal_data[i] <= internal_data[i + 1];
      end
      internal_data[D - 1] <= 'b0;

    end 
  end

endmodule
