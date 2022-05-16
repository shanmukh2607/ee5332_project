`timescale 1ns/1ps
module IPU(
  	output reg signed [31:0] out00,
  	output reg signed [31:0] out01,
  input [31:0] x2k,
  input [31:0] x2k1,
  input [31:0] x2k2,
  	input [31:0] w1,
	input [31:0] w2,
  	input clk,
  	input reset
);
  wire signed [31:0] out00_wire, out01_wire;	
  IPC i00 (.out(out00_wire),.x1(x2k),.x2(x2k1),.w1(w1),.w2(w2),.clk(clk),.reset(reset));
  IPC i01 (.out(out01_wire),.x1(x2k1),.x2(x2k2),.w1(w1),.w2(w2),.clk(clk),.reset(reset));
  always@(*)begin
    case(reset)
      1'b1: begin
        out00 = 0;
        out01 = 0;       
      end
      1'b0: begin
        out00 = out00_wire;
        out01 = out01_wire;  
      end
    endcase
  end
endmodule


module IPC(
	output reg signed [31:0] out,
	input [31:0] x1,
	input [31:0] x2,
	input [31:0] w1,
	input [31:0] w2,
	input clk,
	input reset
);
	reg signed [31:0] p1,p2;
  wire signed [31:0] p1_wire, p2_wire;
  always@(*)begin
    case(reset)
      1'b1: begin
        p1 = 0;
        p2 = 0; 
        end
      1'b0: begin
        //$display("Start of IPC: %0t", $realtime);
        p1 = x1*w1;
        p2 = x2*w2;
      end
    endcase
  end
    assign p1_wire = p1;
    assign p2_wire = p2;
	//assign p1 = x1*w1+x2*w2;
	//assign p2 = x3*w3+x4*w4;
  always@(*)begin
    case(reset)
      1'b1: out = 0;
      1'b0: begin
        out = (p1_wire+p2_wire);
        //$display("End Time of IPC: %0t",$realtime);
      end
    endcase
  end
endmodule


module fir2x(
  output reg signed [31:0] y2k,
  output reg signed [31:0] y2k1,
  input [31:0] x2k,
  input [31:0] x2k1,
	input clk,
	input reset
);
	// Register Unit
	
  reg signed [31:0] x2k2;
    wire signed [31:0] x2k2_wire;
    wire signed [31:0] h0_wire,h1_wire,h2_wire,h3_wire;
  wire signed [31:0] h4_wire,h5_wire,h6_wire,h7_wire;
  wire signed [31:0] h8_wire,h9_wire,h10_wire,h11_wire;
  wire signed [31:0] h12_wire,h13_wire,h14_wire,h15_wire;
	wire signed [31:0] out0000,out0010,out0001,out0011;
	wire signed [31:0] out0100,out0110,out0101,out0111;
	wire signed [31:0] out1000,out1010,out1001,out1011;
	wire signed [31:0] out1100,out1110,out1101,out1111;
    assign h0_wire = 11; assign h1_wire = 24; assign h2_wire = 48; assign h3_wire = 83;
  assign h4_wire = 130; assign h5_wire = 181; assign h6_wire = 226; assign h7_wire = 252;
  assign h8_wire = 252; assign h9_wire = 226; assign h10_wire = 181; assign h11_wire = 130;
  assign h12_wire = 83; assign h13_wire = 48; assign h14_wire = 24; assign h15_wire = 11;
	assign x2k2_wire = x2k2;
	always @(posedge clk) begin
      case(reset)
        1'b1:begin
          x2k2 <= 0;
        end
        1'b0:begin
          x2k2 <= x2k;
        end
      endcase
	end
	
	////// IPU units
	
	// IPU 0 // h{0,1,2,3}
  IPU i0 (.out00(out0000),.out01(out0001),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h0_wire),.w2(h1_wire),
           .clk(clk),.reset(reset));
  
  IPU i1 (.out00(out0010),.out01(out0011),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h2_wire),.w2(h3_wire),
           .clk(clk),.reset(reset));
  
  IPU i2 (.out00(out0100),.out01(out0101),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h4_wire),.w2(h5_wire),
           .clk(clk),.reset(reset));
  
  IPU i3 (.out00(out0110),.out01(out0111),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h6_wire),.w2(h7_wire),
           .clk(clk),.reset(reset));
  IPU i4 (.out00(out1000),.out01(out1001),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h8_wire),.w2(h9_wire),
           .clk(clk),.reset(reset));
  IPU i5 (.out00(out1010),.out01(out1011),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h10_wire),.w2(h11_wire),
           .clk(clk),.reset(reset));
  IPU i6 (.out00(out1100),.out01(out1101),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h12_wire),.w2(h13_wire),
           .clk(clk),.reset(reset));
  IPU i7 (.out00(out1110),.out01(out1111),
          .x2k(x2k),.x2k1(x2k1),.x2k2(x2k2_wire),
          .w1(h14_wire),.w2(h15_wire),
           .clk(clk),.reset(reset));
	
	//// PAU
	
  reg [31:0] PAU00,PAU01,PAU02,PAU03,PAU04,PAU05,PAU06;
  reg [31:0] PAU10,PAU11,PAU12,PAU13,PAU14,PAU15,PAU16;
	
  always @(posedge clk) begin
      case(reset)
        1'b1:begin
          PAU00 <= 0;
          PAU01 <= 0;
          PAU02 <= 0;
          PAU03 <= 0;
          PAU04 <= 0;
          PAU05 <= 0;
          PAU06 <= 0;
          y2k <= 0;
          PAU10 <= 0;
          PAU11 <= 0;
          PAU12 <= 0;
          PAU13 <= 0;
          PAU14 <= 0;
          PAU15 <= 0;
          PAU16 <= 0;
          y2k1 <= 0;        
        end
        1'b0: begin
          PAU00 <= out1110;
          PAU01 <= PAU00 + out1100;
          PAU02 <= PAU01 + out1010;
          PAU03 <= PAU02 + out1000;
          PAU04 <= PAU03 + out0110;
          PAU05 <= PAU04 + out0100;
          PAU06 <= PAU05 + out0010;
          y2k <= PAU06 + out0000;
          PAU10 <= out1111;
          PAU11 <= PAU10 + out1101;
          PAU12 <= PAU11 + out1011;
          PAU13 <= PAU12 + out1001;
          PAU14 <= PAU13 + out0111;
          PAU15 <= PAU14 + out0101;
          PAU16 <= PAU15 + out0011;
          y2k1 <= PAU16 + out0001;
        end
      endcase
	end
endmodule