//////// Four Times Unroll FIR Filter - 16 Tap
//// The weights of the filter are assigned in the lines 131 to 134
//// Any other weights can be given here.
//// 

// Inner Product Unit 
module IPU(
  	// Outputs of Inner Product Unit
  	output reg signed [31:0] out00,
  	output reg signed [31:0] out01,
  	output reg signed [31:0] out10,
  	output reg signed [31:0] out11,
  	// Inputs to Inner Product Unit
  	input [31:0] x4k,
	input [31:0] x4k1,
	input [31:0] x4k2,
	input [31:0] x4k3,
    input [31:0] x4k4,
    input [31:0] x4k5,
    input [31:0] x4k6,
  	input [31:0] w1,
	input [31:0] w2,
	input [31:0] w3,
	input [31:0] w4,
  	input clk,
  	input reset
);
  wire signed [31:0] out00_wire, out01_wire, out10_wire,out11_wire;	
  // Instantiation of the Inner Product Cells
  IPC i00 (.out(out00_wire),.x1(x4k),.x2(x4k1),.x3(x4k2),.x4(x4k3),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.clk(clk),.reset(reset));
  IPC i01 (.out(out01_wire),.x1(x4k1),.x2(x4k2),.x3(x4k3),.x4(x4k4),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.clk(clk),.reset(reset));
  IPC i02 (.out(out10_wire),.x1(x4k2),.x2(x4k3),.x3(x4k4),.x4(x4k5),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.clk(clk),.reset(reset));
  IPC i03 (.out(out11_wire),.x1(x4k3),.x2(x4k4),.x3(x4k5),.x4(x4k6),.w1(w1),.w2(w2),.w3(w3),.w4(w4),.clk(clk),.reset(reset));
  always@(*)begin
    case(reset)
      1'b1: begin
        out00 = 0;
        out01 = 0;
        out10 = 0;
        out11 = 0;        
      end
      1'b0: begin
        // Assigning Outputs 
        out00 = out00_wire;
        out01 = out01_wire;
        out10 = out10_wire;
        out11 = out11_wire;    
      end
    endcase
  end
endmodule
// End of IPU Module


// Inner Product Cells

module IPC(
  	// Output of Inner Product Cell
	output reg signed [31:0] out,
  	// Inputs of Inner Product Cell
	input [31:0] x1,
	input [31:0] x2,
	input [31:0] x3,
	input [31:0] x4,
	input [31:0] w1,
	input [31:0] w2,
	input [31:0] w3,
	input [31:0] w4,
	input clk,
	input reset
);
	reg signed [31:0] p1,p2;
  	wire signed [31:0] p1_wire, p2_wire;
  	// Doing the Multiplication and Addition
    always@(*)begin
      case(reset)
        1'b1: begin
          p1 = 0;
          p2 = 0; 
          end
        1'b0: begin
          p1 = x1*w1+x2*w2;
          p2 = x3*w3+x4*w4;
        end
      endcase
    end
    assign p1_wire = p1;
    assign p2_wire = p2;
    always@(*)begin
      case(reset)
        1'b1: out = 0;
        1'b0: begin
          // Assigning the Output 
          out = (p1_wire+p2_wire);
        end
      endcase
    end
endmodule


// FIR Filter Four Times Unrolled Implementation
module fir4x(
	output reg signed [31:0] y4k,
	output reg signed [31:0] y4k1,
	output reg signed [31:0] y4k2,
	output reg signed [31:0] y4k3,
	input [31:0] x4k,
	input [31:0] x4k1,
	input [31:0] x4k2,
	input [31:0] x4k3,
	input clk,
	input reset
);
	// Register Unit Regs
	
    reg signed [31:0] x4k4,x4k5,x4k6;
	wire signed [31:0] x4k4_wire,x4k5_wire,x4k6_wire;
  
  	// Weights Wire Defining
    wire signed [31:0] h0_wire,h1_wire,h2_wire,h3_wire;
    wire signed [31:0] h4_wire,h5_wire,h6_wire,h7_wire;
    wire signed [31:0] h8_wire,h9_wire,h10_wire,h11_wire;
    wire signed [31:0] h12_wire,h13_wire,h14_wire,h15_wire;
  	// IPU Outputs Defining
	wire signed [31:0] out0000,out0010,out0001,out0011;
	wire signed [31:0] out0100,out0110,out0101,out0111;
	wire signed [31:0] out1000,out1010,out1001,out1011;
	wire signed [31:0] out1100,out1110,out1101,out1111;
  
  	// Weights Assigning
    assign h0_wire = 11; assign h1_wire = 24; assign h2_wire = 48; assign h3_wire = 83;
    assign h4_wire = 130; assign h5_wire = 181; assign h6_wire = 226; assign h7_wire = 252;
    assign h8_wire = 252; assign h9_wire = 226; assign h10_wire = 181; assign h11_wire = 130;
    assign h12_wire = 83; assign h13_wire = 48; assign h14_wire = 24; assign h15_wire = 11;
  
	assign x4k4_wire = x4k4;
	assign x4k5_wire = x4k5;
	assign x4k6_wire = x4k6;
  	// Storing Values in Register Unit
	always @(posedge clk) begin
      case(reset)
        1'b1:begin
          x4k4 <= 0;
		  x4k5 <= 0;
		  x4k6 <= 0;
        end
        1'b0:begin
          x4k4 <= x4k;
          x4k5 <= x4k1;
          x4k6 <= x4k2;
        end
      endcase
	end
	
	////// IPU units
	
	// IPU 0 // h{0,1,2,3}
  IPU i0 (.out00(out0000),.out01(out0001),.out10(out0010),.out11(out0011),
          .x4k(x4k),.x4k1(x4k1),.x4k2(x4k2),.x4k3(x4k3),
           .x4k4(x4k4_wire),.x4k5(x4k5_wire),.x4k6(x4k6_wire),
          .w1(h0_wire),.w2(h1_wire),.w3(h2_wire),.w4(h3_wire),
           .clk(clk),.reset(reset));
  
	
	// IPU 1 // h{4,5,6,7}
  IPU i1 (.out00(out0100),.out01(out0101),.out10(out0110),.out11(out0111),
          .x4k(x4k),.x4k1(x4k1),.x4k2(x4k2),.x4k3(x4k3),
           .x4k4(x4k4_wire),.x4k5(x4k5_wire),.x4k6(x4k6_wire),
          .w1(h4_wire),.w2(h5_wire),.w3(h6_wire),.w4(h7_wire),
          .clk(clk),.reset(reset));
  
	
	// IPU 2 // h{8,9,10,11}
  IPU i2 (.out00(out1000),.out01(out1001),.out10(out1010),.out11(out1011),
          .x4k(x4k),.x4k1(x4k1),.x4k2(x4k2),.x4k3(x4k3),
           .x4k4(x4k4_wire),.x4k5(x4k5_wire),.x4k6(x4k6_wire),
          .w1(h8_wire),.w2(h9_wire),.w3(h10_wire),.w4(h11_wire),
          .clk(clk),.reset(reset));
  

	// IPU 3 // h{12,13,14,15}
  IPU i3 (.out00(out1100),.out01(out1101),.out10(out1110),.out11(out1111),
          .x4k(x4k),.x4k1(x4k1),.x4k2(x4k2),.x4k3(x4k3),
           .x4k4(x4k4_wire),.x4k5(x4k5_wire),.x4k6(x4k6_wire),
          .w1(h12_wire),.w2(h13_wire),.w3(h14_wire),.w4(h15_wire),
          .clk(clk),.reset(reset));
	
	//// PAU
	
  	// PAU registers
	reg [31:0] PAU00,PAU01,PAU02;
	reg [31:0] PAU10,PAU11,PAU12;
	reg [31:0] PAU20,PAU21,PAU22;
	reg [31:0] PAU30,PAU31,PAU32;
	
  
  always @(posedge clk) begin
      case(reset)
        1'b1:begin
          PAU00 <= 0;
          PAU01 <= 0;
          PAU02 <= 0;
          y4k <= 0;
          PAU10 <= 0;
          PAU11 <= 0;
          PAU12 <= 0;
          y4k1 <= 0;
          PAU20 <= 0;
          PAU21 <= 0;
          PAU22 <= 0;
          y4k2 <= 0;
          PAU30 <= 0;
          PAU31 <= 0;
          PAU32 <= 0;
          y4k3 <= 0;         
        end
        1'b0: begin
          // Implementation of PAU
          PAU00 <= out1100;
          PAU01 <= PAU00 + out1000;
          PAU02 <= PAU01 + out0100;
          y4k <= PAU02 + out0000; // Assigning first output
          PAU10 <= out1101;
          PAU11 <= PAU10 + out1001;
          PAU12 <= PAU11 + out0101;
          y4k1 <= PAU12 + out0001; // Assigning second output
          PAU20 <= out1110;
          PAU21 <= PAU20 + out1010;
          PAU22 <= PAU21 + out0110;
          y4k2 <= PAU22 + out0010; // Assigning third output
          PAU30 <= out1111;
          PAU31 <= PAU30 + out1011;
          PAU32 <= PAU31 + out0111;
          y4k3 <= PAU32 + out0011; // Assigning fourth output
        end
      endcase
	end
endmodule

//////// End of Code
