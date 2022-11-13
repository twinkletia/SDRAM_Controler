declare SDRAM_CTR{
	input	DRAM_DI[16];
	output	DRAM_DO[16];
	output	DRAM_A[13];
	output	DRAM_BA[2];
	output 	DRAM_LDQM;
	output 	DRAM_UDQM;
	output 	DRAM_RAS;
	output 	DRAM_CAS;
	output 	DRAM_CKE;
	output 	DRAM_WE;
	output 	DRAM_CS;

	input	rxin;
	output	rxout;
	output	finish_init;
	input	rw_mode;
	input	bank[2];
	input	row[13];
	input	column[10];

	input	datai0[16];
	input	datai1[16];
	input	datai2[16];
	input	datai3[16];
	input	datai4[16];
	input	datai5[16];
	input	datai6[16];
	input	datai7[16];
	
	output	datao0[16];
	output	datao1[16];
	output	datao2[16];
	output	datao3[16];
	output	datao4[16];
	output	datao5[16];
	output	datao6[16];
	output	datao7[16];
	input switch;
}
