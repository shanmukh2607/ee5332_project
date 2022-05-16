// ==============================================================
// RTL generated by Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Version: 2020.2
// Copyright (C) Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

(* CORE_GENERATION_INFO="fir_fir,hls_ip_2020_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7a35t-cpg236-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=pipeline,HLS_SYN_CLOCK=6.860000,HLS_SYN_LAT=2,HLS_SYN_TPT=1,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=1335,HLS_SYN_LUT=943,HLS_VERSION=2020_2}" *)

module fir (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        in_r,
        out_r,
        out_r_ap_vld
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [31:0] in_r;
output  [31:0] out_r;
output   out_r_ap_vld;

reg ap_done;
reg ap_idle;
reg ap_ready;
reg out_r_ap_vld;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_pp0_stage0_11001;
reg   [31:0] Acc1_14;
reg   [31:0] Acc1_13;
reg   [31:0] Acc1_12;
reg   [31:0] Acc1_11;
reg   [31:0] Acc1_10;
reg   [31:0] Acc1_9;
reg   [31:0] Acc1_8;
reg   [31:0] Acc1_7;
reg   [31:0] Acc1_6;
reg   [31:0] Acc1_5;
reg   [31:0] Acc1_4;
reg   [31:0] Acc1_3;
reg   [31:0] Acc1_2;
reg   [31:0] Acc1_1;
reg   [31:0] Acc1_0;
reg  signed [31:0] in_read_reg_420;
reg  signed [31:0] in_read_reg_420_pp0_iter1_reg;
wire   [31:0] grp_fu_93_p2;
reg   [31:0] mul_ln26_reg_436;
wire   [31:0] grp_fu_99_p2;
reg   [31:0] mul_ln26_1_reg_442;
wire   [31:0] grp_fu_105_p2;
reg   [31:0] mul_ln26_2_reg_448;
wire   [31:0] grp_fu_111_p2;
reg   [31:0] mul_ln26_3_reg_454;
wire    ap_block_pp0_stage0_subdone;
wire   [31:0] add_ln26_1_fu_153_p2;
wire    ap_block_pp0_stage0;
wire   [31:0] add_ln26_2_fu_185_p2;
wire   [31:0] add_ln26_3_fu_201_p2;
wire   [31:0] add_ln26_4_fu_232_p2;
wire   [31:0] add_ln26_5_fu_248_p2;
wire   [31:0] add_ln26_6_fu_263_p2;
wire   [31:0] add_ln26_7_fu_294_p2;
wire   [31:0] add_ln26_8_fu_310_p2;
wire   [31:0] add_ln26_9_fu_326_p2;
wire   [31:0] add_ln26_10_fu_341_p2;
wire   [31:0] add_ln26_11_fu_356_p2;
wire   [31:0] add_ln26_12_fu_372_p2;
wire   [31:0] add_ln26_13_fu_387_p2;
wire   [31:0] add_ln26_14_fu_403_p2;
wire    ap_block_pp0_stage0_01001;
wire   [4:0] grp_fu_93_p1;
wire   [7:0] grp_fu_99_p1;
wire   [8:0] grp_fu_105_p1;
wire   [8:0] grp_fu_111_p1;
wire   [31:0] shl_ln26_fu_133_p2;
wire   [31:0] shl_ln26_1_fu_138_p2;
wire   [31:0] sub_ln26_fu_143_p2;
wire   [31:0] shl_ln26_2_fu_165_p2;
wire   [31:0] shl_ln26_3_fu_170_p2;
wire   [31:0] sub_ln26_1_fu_175_p2;
wire   [31:0] shl_ln26_4_fu_212_p2;
wire   [31:0] shl_ln26_5_fu_217_p2;
wire   [31:0] add_ln26_15_fu_222_p2;
wire   [31:0] shl_ln26_6_fu_274_p2;
wire   [31:0] shl_ln26_7_fu_279_p2;
wire   [31:0] sub_ln26_2_fu_284_p2;
reg   [0:0] ap_NS_fsm;
reg    ap_idle_pp0_0to1;
reg    ap_reset_idle_pp0;
wire    ap_enable_pp0;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 Acc1_14 = 32'd0;
#0 Acc1_13 = 32'd0;
#0 Acc1_12 = 32'd0;
#0 Acc1_11 = 32'd0;
#0 Acc1_10 = 32'd0;
#0 Acc1_9 = 32'd0;
#0 Acc1_8 = 32'd0;
#0 Acc1_7 = 32'd0;
#0 Acc1_6 = 32'd0;
#0 Acc1_5 = 32'd0;
#0 Acc1_4 = 32'd0;
#0 Acc1_3 = 32'd0;
#0 Acc1_2 = 32'd0;
#0 Acc1_1 = 32'd0;
#0 Acc1_0 = 32'd0;
end

fir_mul_32s_5ns_32_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 5 ),
    .dout_WIDTH( 32 ))
mul_32s_5ns_32_2_1_U1(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(in_r),
    .din1(grp_fu_93_p1),
    .ce(1'b1),
    .dout(grp_fu_93_p2)
);

fir_mul_32s_8ns_32_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 8 ),
    .dout_WIDTH( 32 ))
mul_32s_8ns_32_2_1_U2(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(in_r),
    .din1(grp_fu_99_p1),
    .ce(1'b1),
    .dout(grp_fu_99_p2)
);

fir_mul_32s_9ns_32_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 9 ),
    .dout_WIDTH( 32 ))
mul_32s_9ns_32_2_1_U3(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(in_r),
    .din1(grp_fu_105_p1),
    .ce(1'b1),
    .dout(grp_fu_105_p2)
);

fir_mul_32s_9ns_32_2_1 #(
    .ID( 1 ),
    .NUM_STAGE( 2 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 9 ),
    .dout_WIDTH( 32 ))
mul_32s_9ns_32_2_1_U4(
    .clk(ap_clk),
    .reset(ap_rst),
    .din0(in_r),
    .din1(grp_fu_111_p1),
    .ce(1'b1),
    .dout(grp_fu_111_p2)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        Acc1_0 <= mul_ln26_reg_436;
        Acc1_1 <= add_ln26_14_fu_403_p2;
        Acc1_10 <= add_ln26_5_fu_248_p2;
        Acc1_11 <= add_ln26_4_fu_232_p2;
        Acc1_12 <= add_ln26_3_fu_201_p2;
        Acc1_13 <= add_ln26_2_fu_185_p2;
        Acc1_14 <= add_ln26_1_fu_153_p2;
        Acc1_2 <= add_ln26_13_fu_387_p2;
        Acc1_3 <= add_ln26_12_fu_372_p2;
        Acc1_4 <= add_ln26_11_fu_356_p2;
        Acc1_5 <= add_ln26_10_fu_341_p2;
        Acc1_6 <= add_ln26_9_fu_326_p2;
        Acc1_7 <= add_ln26_8_fu_310_p2;
        Acc1_8 <= add_ln26_7_fu_294_p2;
        Acc1_9 <= add_ln26_6_fu_263_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        in_read_reg_420 <= in_r;
        in_read_reg_420_pp0_iter1_reg <= in_read_reg_420;
        mul_ln26_1_reg_442 <= grp_fu_99_p2;
        mul_ln26_2_reg_448 <= grp_fu_105_p2;
        mul_ln26_3_reg_454 <= grp_fu_111_p2;
        mul_ln26_reg_436 <= grp_fu_93_p2;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0_0to1 = 1'b1;
    end else begin
        ap_idle_pp0_0to1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (ap_idle_pp0_0to1 == 1'b1))) begin
        ap_reset_idle_pp0 = 1'b1;
    end else begin
        ap_reset_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        out_r_ap_vld = 1'b1;
    end else begin
        out_r_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln26_10_fu_341_p2 = (Acc1_4 + mul_ln26_2_reg_448);

assign add_ln26_11_fu_356_p2 = (Acc1_3 + add_ln26_15_fu_222_p2);

assign add_ln26_12_fu_372_p2 = (Acc1_2 + mul_ln26_1_reg_442);

assign add_ln26_13_fu_387_p2 = (Acc1_1 + sub_ln26_1_fu_175_p2);

assign add_ln26_14_fu_403_p2 = (Acc1_0 + sub_ln26_fu_143_p2);

assign add_ln26_15_fu_222_p2 = (shl_ln26_4_fu_212_p2 + shl_ln26_5_fu_217_p2);

assign add_ln26_1_fu_153_p2 = (Acc1_13 + sub_ln26_fu_143_p2);

assign add_ln26_2_fu_185_p2 = (Acc1_12 + sub_ln26_1_fu_175_p2);

assign add_ln26_3_fu_201_p2 = (Acc1_11 + mul_ln26_1_reg_442);

assign add_ln26_4_fu_232_p2 = (Acc1_10 + add_ln26_15_fu_222_p2);

assign add_ln26_5_fu_248_p2 = (Acc1_9 + mul_ln26_2_reg_448);

assign add_ln26_6_fu_263_p2 = (Acc1_8 + mul_ln26_3_reg_454);

assign add_ln26_7_fu_294_p2 = (Acc1_7 + sub_ln26_2_fu_284_p2);

assign add_ln26_8_fu_310_p2 = (Acc1_6 + sub_ln26_2_fu_284_p2);

assign add_ln26_9_fu_326_p2 = (Acc1_5 + mul_ln26_3_reg_454);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_01001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start;

assign grp_fu_105_p1 = 32'd181;

assign grp_fu_111_p1 = 32'd226;

assign grp_fu_93_p1 = 32'd11;

assign grp_fu_99_p1 = 32'd83;

assign out_r = (Acc1_14 + mul_ln26_reg_436);

assign shl_ln26_1_fu_138_p2 = in_read_reg_420_pp0_iter1_reg << 32'd3;

assign shl_ln26_2_fu_165_p2 = in_read_reg_420_pp0_iter1_reg << 32'd6;

assign shl_ln26_3_fu_170_p2 = in_read_reg_420_pp0_iter1_reg << 32'd4;

assign shl_ln26_4_fu_212_p2 = in_read_reg_420_pp0_iter1_reg << 32'd7;

assign shl_ln26_5_fu_217_p2 = in_read_reg_420_pp0_iter1_reg << 32'd1;

assign shl_ln26_6_fu_274_p2 = in_read_reg_420_pp0_iter1_reg << 32'd8;

assign shl_ln26_7_fu_279_p2 = in_read_reg_420_pp0_iter1_reg << 32'd2;

assign shl_ln26_fu_133_p2 = in_read_reg_420_pp0_iter1_reg << 32'd5;

assign sub_ln26_1_fu_175_p2 = (shl_ln26_2_fu_165_p2 - shl_ln26_3_fu_170_p2);

assign sub_ln26_2_fu_284_p2 = (shl_ln26_6_fu_274_p2 - shl_ln26_7_fu_279_p2);

assign sub_ln26_fu_143_p2 = (shl_ln26_fu_133_p2 - shl_ln26_1_fu_138_p2);

endmodule //fir