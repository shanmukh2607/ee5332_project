set moduleName fir
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set pipeline_type function
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {fir}
set C_modelType { void 0 }
set C_modelArgList {
	{ in_r int 32 regular  }
	{ out_r int 32 regular {pointer 1}  }
}
set C_modelArgMapList {[ 
	{ "Name" : "in_r", "interface" : "wire", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "in","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} , 
 	{ "Name" : "out_r", "interface" : "wire", "bitwidth" : 32, "direction" : "WRITEONLY", "bitSlice":[{"low":0,"up":0,"cElement": [{"cName": "out","cData": "int","bit_use": { "low": 0,"up": 0},"cArray": [{"low" : 0,"up" : 0,"step" : 0}]}]}]} ]}
# RTL Port declarations: 
set portNum 9
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ in_r sc_in sc_lv 32 signal 0 } 
	{ out_r sc_out sc_lv 32 signal 1 } 
	{ out_r_ap_vld sc_out sc_logic 1 outvld 1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "in_r", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "in_r", "role": "default" }} , 
 	{ "name": "out_r", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "out_r", "role": "default" }} , 
 	{ "name": "out_r_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "out_r", "role": "ap_vld" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4"],
		"CDFG" : "fir",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1", "real_start" : "0",
		"Pipeline" : "Aligned", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "1",
		"VariableLatency" : "0", "ExactLatency" : "2", "EstimateLatencyMin" : "2", "EstimateLatencyMax" : "2",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "in_r", "Type" : "None", "Direction" : "I"},
			{"Name" : "out_r", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "Acc1_14", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_15", "Type" : "Vld", "Direction" : "O"},
			{"Name" : "Acc1_13", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_12", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_11", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_10", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_9", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_8", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_7", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_6", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_5", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_4", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_3", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_2", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_1", "Type" : "OVld", "Direction" : "IO"},
			{"Name" : "Acc1_0", "Type" : "OVld", "Direction" : "IO"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_5ns_32_2_1_U1", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_8ns_32_2_1_U2", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_9ns_32_2_1_U3", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.mul_32s_9ns_32_2_1_U4", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	fir {
		in_r {Type I LastRead 0 FirstWrite -1}
		out_r {Type O LastRead -1 FirstWrite 2}
		Acc1_14 {Type IO LastRead -1 FirstWrite -1}
		Acc1_15 {Type O LastRead -1 FirstWrite -1}
		Acc1_13 {Type IO LastRead -1 FirstWrite -1}
		Acc1_12 {Type IO LastRead -1 FirstWrite -1}
		Acc1_11 {Type IO LastRead -1 FirstWrite -1}
		Acc1_10 {Type IO LastRead -1 FirstWrite -1}
		Acc1_9 {Type IO LastRead -1 FirstWrite -1}
		Acc1_8 {Type IO LastRead -1 FirstWrite -1}
		Acc1_7 {Type IO LastRead -1 FirstWrite -1}
		Acc1_6 {Type IO LastRead -1 FirstWrite -1}
		Acc1_5 {Type IO LastRead -1 FirstWrite -1}
		Acc1_4 {Type IO LastRead -1 FirstWrite -1}
		Acc1_3 {Type IO LastRead -1 FirstWrite -1}
		Acc1_2 {Type IO LastRead -1 FirstWrite -1}
		Acc1_1 {Type IO LastRead -1 FirstWrite -1}
		Acc1_0 {Type IO LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "2", "Max" : "2"}
	, {"Name" : "Interval", "Min" : "1", "Max" : "1"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	in_r { ap_none {  { in_r in_data 0 32 } } }
	out_r { ap_vld {  { out_r out_data 1 32 }  { out_r_ap_vld out_vld 1 1 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
