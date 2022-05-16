//////// Three Times Unroll FIR Filter - 16 Tap
//// The weights of the filter are assigned in the lines 121 to 124
//// Any other weights can be given here.
//// 

// Inner Product Unit 
module IPU(
  	// Outputs of Inner Product Unit
  	output reg signed [31:0] out00,
  	output reg signed [31:0] out01,
  	output reg signed [31:0] out10,
  	// Inputs to Inner Product Unit
    input [31:0] x3k,
    input [31:0] x3k1,
    input [31:0] x3k2,
    input [31:0] x3k3,
    input [31:0] x3k4,
  	input [31:0] w1,
	input [31:0] w2,
	input [31:0] w3,
  	input clk,
  	input reset
);
  wire signed [31:0] out00_wire, out01_wire, out10_wire;	
  // Instantiation of the Inner Product Cells
  IPC i00 (.out(out00_wire),.x1(x3k),.x2(x3k1),.x3(x3k2),.w1(w1),.w2(w2),.w3(w3),.clk(clk),.reset(reset));
  IPC i01 (.out(out01_wire),.x1(x3k1),.x2(x3k2),.x3(x3k3),.w1(w1),.w2(w2),.w3(w3),.clk(clk),.reset(reset));
  IPC i02 (.out(out10_wire),.x1(x3k2),.x2(x3k3),.x3(x3k4),.w1(w1),.w2(w2),.w3(w3),.clk(clk),.reset(reset));
  always@(*)begin
    case(reset)
      1'b1: begin
        out00 = 0;
        out01 = 0;
        out10 = 0;       
      end
      1'b0: begin
        // Assigning Outputs 
        out00 = out00_wire;
        out01 = out01_wire;
        out10 = out10_wire;   
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
	input [31:0] w1,
	input [31:0] w2,
	input [31:0] w3,
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
          p2 = x3*w3;
        end
      endcase
    end
    assign p1_wire = p1;
    assign p2_wire = p2;
  always@(*)begin
    case(reset)
      1'b1: out = 0;
      1'b0: begin
        out = (p1_wire+p2_wire); // Assigning Output of IPC
      end
    endcase
  end
endmodule


// Three times unrolled FIR Filter Module
module fir3x(
  // Outputs of Filter
  output reg signed [31:0] y3k,
  output reg signed [31:0] y3k1,
  output reg signed [31:0] y3k2,
  // Inputs of the Filter
  input [31:0] x3k,
  input [31:0] x3k1,
  input [31:0] x3k2,
	input clk,
	input reset
);
	// Register Unit Regs
    reg signed [31:0] x3k3,x3k4;
    wire signed [31:0] x3k3_wire,x3k4_wire;
  
  	// Weight Wire Defining
    wire signed [31:0] h0_wire,h1_wire,h2_wire,h3_wire;
    wire signed [31:0] h4_wire,h5_wire,h6_wire,h7_wire;
    wire signed [31:0] h8_wire,h9_wire,h10_wire,h11_wire;
    wire signed [31:0] h12_wire,h13_wire,h14_wire,h15_wire;
  
  	// IPU Outputs Defining
	wire signed [31:0] out0000,out0010,out0001,out0011;
	wire signed [31:0] out0100,out0110,out0101,out0111;
	wire signed [31:0] out1000,out1010,out1001,out1011;
	wire signed [31:0] out1100,out1110,out1101,out1111;
  	
  	// Assigning Weight Values
    assign h0_wire = 11; assign h1_wire = 24; assign h2_wire = 48; assign h3_wire = 83;
    assign h4_wire = 130; assign h5_wire = 181; assign h6_wire = 226; assign h7_wire = 252;
    assign h8_wire = 252; assign h9_wire = 226; assign h10_wire = 181; assign h11_wire = 130;
    assign h12_wire = 83; assign h13_wire = 48; assign h14_wire = 24; assign h15_wire = 11;
  
	assign x3k3_wire = x3k3;
	assign x3k4_wire = x3k4;
  
  	// Storing Values in Register Unit
	always @(posedge clk) begin
      case(reset)
        1'b1:begin
          x3k4 <= 0;
		  x3k3 <= 0;
        end
        1'b0:begin
          x3k3 <= x3k;
          x3k4 <= x3k1;
        end
      endcase
	end
	
	////// IPU units
	
	// IPU 0 // h{0,1,2}
  IPU i0 (.out00(out0000),.out01(out0001),.out10(out0010),
          .x3k(x3k),.x3k1(x3k1),.x3k2(x3k2),.x3k3(x3k3_wire),
          .x3k4(x3k4_wire),
          .w1(h0_wire),.w2(h1_wire),.w3(h2_wire),
           .clk(clk),.reset(reset));
  
  // IPU 0 // h{3,4,5}
  IPU i1 (.out00(out0100),.out01(out0101),.out10(out0110),
          .x3k(x3k),.x3k1(x3k1),.x3k2(x3k2),.x3k3(x3k3_wire),
          .x3k4(x3k4_wire),
          .w1(h3_wire),.w2(h4_wire),.w3(h5_wire),
           .clk(clk),.reset(reset));
  
  // IPU 0 // h{6,7,8}
  IPU i2 (.out00(out1000),.out01(out1001),.out10(out1010),
          .x3k(x3k),.x3k1(x3k1),.x3k2(x3k2),.x3k3(x3k3_wire),
          .x3k4(x3k4_wire),
          .w1(h6_wire),.w2(h7_wire),.w3(h8_wire),
           .clk(clk),.reset(reset));
  
  // IPU 0 // h{9,10,11}
  IPU i3 (.out00(out1100),.out01(out1101),.out10(out1110),
          .x3k(x3k),.x3k1(x3k1),.x3k2(x3k2),.x3k3(x3k3_wire),
          .x3k4(x3k4_wire),
          .w1(h9_wire),.w2(h10_wire),.w3(h11_wire),
           .clk(clk),.reset(reset));
  
  // IPU 0 // h{12,13,14}
  IPU i4 (.out00(out0011),.out01(out0111),.out10(out1011),
          .x3k(x3k),.x3k1(x3k1),.x3k2(x3k2),.x3k3(x3k3_wire),
          .x3k4(x3k4_wire),
          .w1(h12_wire),.w2(h13_wire),.w3(h14_wire),
           .clk(clk),.reset(reset));
  
  	
	//// PAU
	
  	// PAU Registers
    reg [31:0] PAU00,PAU01,PAU02,PAU03,PAU04;
    reg [31:0] PAU10,PAU11,PAU12,PAU13,PAU14;
    reg [31:0] PAU20,PAU21,PAU22,PAU23,PAU24;

    always @(posedge clk) begin
        case(reset)
          1'b1:begin
            PAU00 <= 0;
            PAU01 <= 0;
            PAU02 <= 0;
            PAU03 <= 0;
            PAU04 <= 0;
            y3k <= 0;
            PAU10 <= 0;
            PAU11 <= 0;
            PAU12 <= 0;
            PAU13 <= 0;
            PAU14 <= 0;
            y3k1 <= 0;
            PAU20 <= 0;
            PAU21 <= 0;
            PAU22 <= 0;
            PAU23 <= 0;
            PAU24 <= 0;
            y3k2 <= 0;        
          end
          1'b0: begin
            // Implementation of PAU
            PAU00 <= x3k*h15_wire; // Multiplying with the last weight
            PAU01 <= PAU00 + out0011;
            PAU02 <= PAU01 + out1100;
            PAU03 <= PAU02 + out1000;
            PAU04 <= PAU03 + out0100;
            y3k <= PAU04 + out0000; // Assigning first output
            PAU10 <= x3k1*h15_wire; // Multiplying with the last weight
            PAU11 <= PAU10 + out0111;
            PAU12 <= PAU11 + out1101;
            PAU13 <= PAU12 + out1001;
            PAU14 <= PAU13 + out0101;
            y3k1 <= PAU14 + out0001; // Assigning second output
            PAU20 <= x3k2*h15_wire; // Multiplying with the last weight
            PAU21 <= PAU20 + out1011;
            PAU22 <= PAU21 + out1110;
            PAU23 <= PAU22 + out1010;
            PAU24 <= PAU23 + out0110;
            y3k2 <= PAU24 + out0010; // Assigning third output
          end
        endcase
      end
endmodule

// End of Code
