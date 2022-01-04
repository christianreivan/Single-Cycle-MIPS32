-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   MIPS32.vhd
-- Deskripsi        :   TOP_LEVEL module

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY MIPS32 IS
PORT (	CLK: IN STD_LOGIC;
			RST: IN STD_LOGIC;
			pcin: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			JumpCU: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			bneCU:  OUT STD_LOGIC;
			branchCU:	OUT STD_LOGIC;
			memtoregCU:	OUT STD_LOGIC;
			memreadCU:	OUT STD_LOGIC;
			memwriteCU:	OUT STD_LOGIC;
			regdestCU:	OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			regwriteCU:	OUT STD_LOGIC;
			ALUSrcCU:	OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			ALUCtrl:		OUT STD_LOGIC;
			ProgramCounter: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			PChasilInkremen: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Instruksi:  OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			DestinationReg: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			Nilai_Rs:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			Nilai_Rt:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			HasilKomparasi: OUT STD_LOGIC;
			HasilALU: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			MuxyangMaukeALU: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			BacaanMemori: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			WriteBack:	OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			AlamatBNE: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			busmerge_out: OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			branch_detector: OUT STD_LOGIC;
			bit_OP_In: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
			bit_Funct: OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
			bit_addr_1: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			bit_addr_2: OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
			bit_SignExt: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			bit_shift26_28: OUT STD_LOGIC_VECTOR(25 DOWNTO 0)
	  );
END MIPS32;


ARCHITECTURE TOP_LEVEL of MIPS32 IS
COMPONENT mux_2to1_32bit IS --MUX
PORT (
			D1 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			D2 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			SEL:	IN			STD_LOGIC;
			Y	:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );
END COMPONENT;

COMPONENT mux_4to1_32bit IS --MUX
PORT (
			D1 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			D2 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			D3 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			D4 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			SEL:	IN			STD_LOGIC_VECTOR(1  DOWNTO 0);
			Y	:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );

END COMPONENT;

COMPONENT mux_4to1_5bit IS --MUX
PORT (
			D1 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 1 
			D2 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 2 
			D3 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 3 
			D4 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 4
			SEL : IN std_logic_vector  (1 DOWNTO 0); -- Selector
			Y :  OUT std_logic_vector (4 DOWNTO 0)  -- Selected Data
	 );

END COMPONENT;

COMPONENT PC IS --PROGRAM COUNTER
Port ( 	  clock:		in  STD_LOGIC;
           PC_in:		in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           PC_out:	out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT Instruction_Memory IS --INSTRUCTION MEMORY
Port ( 	  addr  : in	STD_LOGIC_VECTOR (31 downto 0);
			  clock : in	STD_LOGIC;
			  reset : in	STD_LOGIC;
           instr : out  STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT cla_32 IS --ADDER 32 BIT
PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
);
END COMPONENT;

COMPONENT reg_file IS
PORT ( ADDR1 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rs
		 ADDR2 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rt
		 ADDR3 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rd
		 WR_EN:		 IN STD_LOGIC; --INDIKATOR PENULISAN
		 clock : 	 IN STD_LOGIC; -- clock 
		 WR_Data_3 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);-- write data
		 RD_DATA_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- READ DATA1
		 RD_DATA_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- READ DATA2
	  );
END COMPONENT;

COMPONENT CU IS
PORT (
			--INPUT
			OP_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			FUNCT_In : IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			--OUTPUT
			Sig_Jmp : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Sig_Bne : OUT STD_LOGIC;
			Sig_Branch : OUT STD_LOGIC;
			Sig_MemtoReg : OUT STD_LOGIC;
			Sig_MemRead : OUT STD_LOGIC;
			Sig_MemWrite : OUT STD_LOGIC;
			Sig_RegDest : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Sig_RegWrite : OUT STD_LOGIC;
			Sig_ALUSrc : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
			Sig_ALUCtrl : OUT STD_LOGIC
);
END COMPONENT;

COMPONENT sign_extender IS
PORT (
			D_In :IN std_logic_vector (15 DOWNTO 0); -- Data Input 1 
			D_Out :OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
);
END COMPONENT;

COMPONENT lshift_26_28 IS
PORT (
			D_IN : IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 32-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 32-bit;
);
END COMPONENT;

COMPONENT lshift_32_32 IS
PORT (
			D_IN : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
);
END COMPONENT;

COMPONENT bus_merger IS
PORT (
			DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
);
END COMPONENT;

COMPONENT COMPARATOR IS
PORT (
			D_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			D_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			EQ : OUT STD_LOGIC -- Hasil Perbandingan EQ
);

END COMPONENT;

COMPONENT ALU IS
PORT (
	OPRND_1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1 
	OPRND_2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
	OP_SEL : IN std_logic; -- Operation Select
	RESULT : OUT std_logic_vector (31 DOWNTO 0) -- Data Output
);
END COMPONENT;

COMPONENT data_memory IS
PORT ( ADDR : 	IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- alamat
		 WR_EN:	IN STD_LOGIC; --INDIKATOR PENULISAN
		 RD_EN:	IN STD_LOGIC; --INDIKATOR PEMBACAAN
		 clock : IN STD_LOGIC; -- clock 
		 WR_DATA: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- DATA YANG AKAN DIASSIGN KE MEMORY
		 RD_DATA : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- VALUE MEMORY YANG DIBACA
	  ); 

END COMPONENT;

COMPONENT BR_INTERRUPT IS
PORT(	sig_branch: IN STD_LOGIC;
		sig_bne:		IN STD_LOGIC;
		comp:			IN STD_LOGIC;
		pc_sel:		OUT STD_LOGIC
	);
END COMPONENT;
--WIRES
signal mux2to1_mux4to1: STD_LOGIC_VECTOR (31 DOWNTO 0);
signal mux4to1_reset:	STD_LOGIC_VECTOR (31 DOWNTO 0);
--RESET
signal reset_PC:			STD_LOGIC_VECTOR (31 DOWNTO 0);
--Output dari PC
signal wirePCout:			STD_LOGIC_VECTOR (31 DOWNTO 0);
--Output dari Instruction Memory
signal wireInstr:			STD_LOGIC_VECTOR (31 DOWNTO 0);
--Output dari Adder Increment PC
signal wirePCincrement:	STD_LOGIC_VECTOR (31 DOWNTO 0);
--wire dari blok CU
signal wirejump:			STD_LOGIC_VECTOR (1  DOWNTO 0);
signal wirebne:			STD_LOGIC;
signal wirebranch:		STD_LOGIC;
signal wirememtoreg:		STD_LOGIC;
signal wirememread:		STD_LOGIC;
signal wirememwrite:		STD_LOGIC;
signal wireregdest:		STD_LOGIC_VECTOR (1  DOWNTO 0);
signal wireregwrite:		STD_LOGIC;
signal wireALUSrc:		STD_LOGIC_VECTOR (1  DOWNTO 0);
signal wireALUCtrl:		STD_LOGIC;
--wire dari blok Register
signal wirereadData1:	STD_LOGIC_VECTOR (31 DOWNTO 0);
signal wirereadData2:	STD_LOGIC_VECTOR (31 DOWNTO 0);
--wire dari mux selecting destination register
signal mux4to1_addr3:	STD_LOGIC_VECTOR (4 DOWNTO 0);
--wire dari blok Sign Extender
signal wiresignextend:	STD_LOGIC_VECTOR (31 DOWNTO 0);
--output dari blok left shifter 26 bit to 28 bit
signal shft28_busmerge:	STD_LOGIC_VECTOR (27 DOWNTO 0);
--output dari bus merge ke mux4to1
signal busmerge_mux4to1:STD_LOGIC_VECTOR (31 DOWNTO 0);
--wire dari comparator
signal wirecomp:			STD_LOGIC;
--wire dari mux4to1 ke ALU
signal mux4to1_ALU:		STD_LOGIC_VECTOR (31 DOWNTO 0);
--wire dari blok ALU
signal wireALU:			STD_LOGIC_VECTOR (31 DOWNTO 0);
--output dari blok left shifter 32 bit to 32 bit
signal shft32_adder:		STD_LOGIC_VECTOR (31 DOWNTO 0);
--output dari RD_DATA memory ke MUX2to1
signal wireDatafromMem:	STD_LOGIC_VECTOR (31 DOWNTO 0);
--output dari blok branch interrupt
signal wireBRinterr:		STD_LOGIC;
--wire dari mux2to1 ke writedata Register
signal mux2to1_WriteReg:STD_LOGIC_VECTOR (31 DOWNTO 0);
--output dari adder untuk instruksi Jump
signal Adder_mux2to1:	STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN

jumpCU     <= wirejump;
bneCU      <= wirebne;
branchCU   <= wirebranch;
memtoregCU <= wirememtoreg;
memreadCU  <= wirememread;
memwriteCU <= wirememwrite;
regdestCU  <= wireregdest;
regwriteCU <= wireregwrite;
ALUSrcCU   <= wireALUSrc;
ALUCtrl    <= wireALUCtrl;

pcin <= reset_PC;
ProgramCounter <= wirePCout;
PChasilInkremen <= wirePCincrement;
Instruksi <= wireInstr;
DestinationReg <= mux4to1_addr3;
Nilai_Rs <= wirereadData1;
Nilai_Rt <= wirereadData2;
HasilKomparasi <= wirecomp;
HasilALU <= wireALU;
MuxyangMaukeALU <= mux4to1_ALU;
BacaanMemori <= wireDatafromMem;
WriteBack <= mux2to1_WriteReg;
AlamatBNE <= Adder_mux2to1;
busmerge_out <= busmerge_mux4to1;
branch_detector <= wireBRinterr;
bit_OP_In <= wireInstr(31 downto 26);
bit_Funct <= wireInstr(5 downto 0);
bit_addr_1 <= wireInstr(25 downto 21);
bit_addr_2 <= wireInstr(20 downto 16);
bit_SignExt <= wireInstr(15 downto 0);
bit_shift26_28 <= wireInstr(25 downto 0);



MUX2TO1_reset: mux_2to1_32bit
						PORT MAP( D1	=>	mux4to1_reset,
									 D2	=>	x"00000000",
									 SEL	=>	RST,
									 Y		=>	reset_PC);

MUX2TO1_A: mux_2to1_32bit
						PORT MAP( D1	=>	wirePCincrement,
									 D2	=>	Adder_mux2to1,
									 SEL	=>	wireBRinterr,
									 Y		=>	mux2to1_mux4to1);

MUX4TO1_A: mux_4to1_32bit
						PORT MAP( D1	=>	mux2to1_mux4to1,
									 D2	=>	busmerge_mux4to1,
									 D3	=>	(OTHERS => '0'),
									 D4	=>	(OTHERS => '0'),
									 SEL	=>	wirejump,
									 Y		=>	mux4to1_reset);

PROGRAM_COUNTER:	PC
						PORT MAP( CLOCK  => CLK,
									 PC_In  => reset_PC,
									 PC_Out => wirePCout);
								
INSTRUCT_MEMORY: Instruction_Memory
							PORT MAP( ADDR	 => wirePCout,
										 CLOCK => CLK,
										 RESET => RST,
										 INSTR => wireInstr);

PC_INCREMENT:	CLA_32
					PORT MAP( OPRND_1	=> wirePCout,
								 OPRND_2	=>	X"00000004",
								 C_IN		=>	'0',
								 RESULT	=>	wirePCincrement,
								 C_OUT	=>	OPEN);

CONTROL_UNIT: CU
					PORT MAP( OP_In			=>	wireInstr(31 DOWNTO 26),
								 FUNCT_In		=>	wireInstr(5  DOWNTO  0),
								 Sig_Jmp			=> wirejump,
								 Sig_Bne			=> wirebne,
								 Sig_Branch		=> wirebranch,
								 Sig_MemtoReg	=> wirememtoreg,
								 Sig_MemRead 	=> wirememread,
								 Sig_MemWrite	=> wirememwrite,
								 Sig_RegDest	=>	wireregdest,
								 Sig_RegWrite	=> wireregwrite,
								 Sig_ALUSrc		=>	wireALUSrc,
								 Sig_ALUCtrL	=> wireALUCtrl);

REGISTER_FILES:	REG_FILE
						PORT MAP( ADDR1		=>	wireInstr(25 DOWNTO 21),
									 ADDR2		=>	wireInstr(20 DOWNTO 16),
									 ADDR3		=>	mux4to1_addr3,
									 WR_EN		=>	wireregwrite,
									 CLOCK		=> CLK,
									 WR_Data_3	=>	mux2to1_WriteReg,
									 RD_DATA_1	=> wirereadData1,
									 RD_DATA_2	=>	wirereadData2);
									 
MUX4TO1_B:	mux_4to1_5bit
				PORT MAP( D1	=>	wireInstr(20 DOWNTO 16),
							 D2	=>	wireInstr(15 DOWNTO 11),
							 D3	=>	(OTHERS => '0'),
							 D4	=>	(OTHERS => '0'),
							 SEL	=>	wireregdest,
							 Y		=>	mux4to1_addr3);

SIGN_EXTENDED:	SIGN_EXTENDER
					PORT MAP( D_In		=>	wireInstr(15 DOWNTO 0),
								 D_Out	=>	wiresignextend);

LEFT_SHIFTER_26_28:	LSHIFT_26_28
							PORT MAP( D_IN		=>	wireInstr(25 DOWNTO 0),
										 D_OUT	=>	shft28_busmerge);

BUS_MERGE:	BUS_MERGER
				PORT MAP( DATA_IN1	=>	wirePCincrement(31 DOWNTO 28),
							 DATA_IN2	=>	shft28_busmerge,
							 DATA_OUT	=>	busmerge_mux4to1);

MUX4TO1_C:	 mux_4to1_32bit
						PORT MAP( D1	=>	wirereadData2,
									 D2	=>	wiresignextend,
									 D3	=>	(OTHERS => '0'),
									 D4	=>	(OTHERS => '0'),
									 SEL	=>	wireALUSrc,
									 Y		=>	mux4to1_ALU);
										
COMPARATOR_BLOCK:	COMPARATOR
							PORT MAP( D_1	=>	wirereadData1,
										 D_2	=>	wirereadData2,
										 EQ	=>	wirecomp);

ALU_BLOCK:	ALU
				PORT MAP( OPRND_1	=> wirereadData1,
							 OPRND_2	=>	mux4to1_ALU,
							 OP_SEL	=>	wireALUCtrl,
							 RESULT	=>	wireALU);

LEFT_SHIFTER_23_32:	LSHIFT_32_32
							PORT MAP( D_IN		=>	wiresignextend,
										 D_OUT	=> shft32_adder);

BRANCH_ADDRESS_ADDER:	CLA_32
								PORT MAP( OPRND_1	=> shft32_adder,
											 OPRND_2	=>	wirePCincrement,
											 C_IN		=>	'0',
											 RESULT	=>	Adder_mux2to1,
											 C_OUT	=>	OPEN);

BRANCH_TEST: BR_INTERRUPT
					PORT MAP( sig_branch	=>	wirebranch,
								 sig_bne		=>	wirebne,
								 comp			=>	wirecomp,
								 pc_sel		=>	wireBRinterr);
								 
MEMORY_FILES:	DATA_MEMORY
					 PORT MAP( ADDR		=>	wireALU,
								  WR_EN		=>	wirememwrite,
								  RD_EN		=> wirememread,
								  CLOCK		=> CLK,
								  WR_DATA	=>	wirereadData2,
								  RD_DATA	=>	wireDatafromMem);
								  
MUX2TO1_B:	mux_2to1_32bit
				 PORT MAP( D1	=>	wireALU,
							  D2	=>	wireDatafromMem,
							  SEL	=>	wirememtoreg,
							  Y	=>	mux2to1_WriteReg);
END TOP_LEVEL;