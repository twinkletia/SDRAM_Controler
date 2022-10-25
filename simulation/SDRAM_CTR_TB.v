module tb(m_clock, p_reset, sdrclk, sdrclk1);
  	input p_reset, m_clock, sdrclk, sdrclk1;
	wire p_reset, m_clock, sdrclk, sdrclk1;
	parameter tCYC_SDRAM=7.5;
	parameter tCYC_TOP=20;
	parameter tPD=(tCYC_TOP/10);

	SDRAM_SIM SDRAM_SIM_instance(
		.p_reset(p_reset),
		.m_clock(m_clock),
		.sdrclk(sdrclk),
		.sdrclk1(sdrclk1)
	);
	/*
	initial forever #(tCYC_TOP/2) m_clock = ~m_clock;
	initial forever #(tCYC_SDRAM/2) sdrclk = ~sdrclk;

	initial begin
		$dumpfile("SDRAM_SIM.vcd");
		$dumpvars(0,SDRAM_SIM_instance);
	end

	initial begin
		#(tPD)
			p_reset = 1;
			m_clock = 0;
			sdrclk  = 0;
		#(tCYC_TOP)
			p_reset = 0;
	end
	*/
endmodule
