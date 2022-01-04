-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   testbench.vhd
-- Deskripsi        :   testbench untuk top-level

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture structural of testbench is
component mips32 is
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
END COMPONENT;

signal tb_clock: std_logic := '0';
signal tb_reset: std_logic := '1';
signal tb_pcin: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_jump_cu: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal tb_bne_cu: std_logic;
signal tb_branch_cu: STD_LOGIC;
signal tb_memtoregCU: STD_LOGIC;
signal tb_memreadCU: STD_LOGIC;
signal tb_memwriteCU: STD_LOGIC;
signal tb_regdestCU: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal tb_regwriteCU: STD_LOGIC;
signal tb_ALUSrcCU: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal tb_ALUCtrl:STD_LOGIC;
signal tb_ProgramCounter:STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_PChasilInkremen:STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_instruksi: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_DestinationReg: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_Nilai_Rs: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_Nilai_Rt: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_HasilKomparasi: STD_LOGIC;
signal tb_HasilAlu: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_MuxyangMaukeALU: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_BacaanMemori: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_WriteBack: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_AlamatBNE: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_busmerge_out: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal tb_branch_detector: STD_LOGIC;
signal tb_bit_OP_In: STD_LOGIC_VECTOR(5 DOWNTO 0);
signal tb_bit_Funct: STD_LOGIC_VECTOR(5 DOWNTO 0);
signal tb_bit_addr_1: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_bit_addr_2: STD_LOGIC_VECTOR(4 DOWNTO 0);
signal tb_bit_SignExt: STD_LOGIC_VECTOR(15 DOWNTO 0);
signal tb_bit_shift26_28: STD_LOGIC_VECTOR(25 DOWNTO 0);

BEGIN

dut: mips32
     port map(	 CLK						=> tb_clock,
					 RST                 => tb_reset,
                pcin                => tb_pcin,
                JumpCU              => tb_jump_cu,
                bneCU               => tb_bne_cu,
                branchCU            => tb_branch_cu,
                memtoregCU          => tb_memtoregCU,
                memreadCU           => tb_memreadCU,
                memwriteCU          => tb_memwriteCU,
                regdestCU           => tb_regdestCU,
                regwriteCU          => tb_regwriteCU,
                ALUSrcCU            => tb_ALUSrcCU,
                ALUCtrl             => tb_ALUCtrl,
                ProgramCounter      => tb_ProgramCounter,
                PChasilInkremen     => tb_PChasilInkremen,
                Instruksi           => tb_instruksi,
                DestinationReg      => tb_DestinationReg,
                Nilai_Rs            => tb_Nilai_Rs,
                Nilai_Rt            => tb_Nilai_Rt,
                HasilKomparasi      => tb_HasilKomparasi,
                HasilALU            => tb_HasilAlu,
                MuxyangMaukeALU     => tb_MuxyangMaukeALU,
                BacaanMemori        => tb_BacaanMemori,
                WriteBack           => tb_WriteBack,
                AlamatBNE           => tb_AlamatBNE,
                busmerge_out        => tb_busmerge_out,
                branch_detector     => tb_branch_detector,
                bit_OP_In           => tb_bit_OP_In,
                bit_Funct           => tb_bit_Funct,
                bit_addr_1          => tb_bit_addr_1,
                bit_addr_2          => tb_bit_addr_2,
                bit_SignExt         => tb_bit_SignExt,
                bit_shift26_28      =>  tb_bit_shift26_28
);

MY_CLOCK: PROCESS
          BEGIN
            WAIT FOR 10 ps; tb_clock <= NOT(tb_clock);
          END PROCESS MY_CLOCK;

MY_RESET: PROCESS
          BEGIN
            WAIT FOR 40 ps; tb_reset <= '0';
			 END PROCESS MY_RESET;

end structural;