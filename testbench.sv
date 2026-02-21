module piso_tb;
  reg clk, rst, load;
  reg [7:0]in;
  wire out;
  
  piso dut(
    .clk(clk),
    .rst(rst),
    .load(load),
    .in(in),
    .out(out)
  );
  
  always #2 clk = ~clk;
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
    clk = 0;
    rst = 1;
    load =0;
    in = 8'b10110001;
    @(posedge clk);
     rst = 0;
     load = 1;
    @(posedge clk);
     load = 0;
    repeat(4)@(posedge clk)
    @(posedge clk);
     rst = 1;
    @(posedge clk);
     rst = 0;
    @(posedge clk);
     in = 8'b10101010;
    @(posedge clk);
    load = 1;
    @(posedge clk);
     load = 0;
    #50 $finish;
  end
endmodule