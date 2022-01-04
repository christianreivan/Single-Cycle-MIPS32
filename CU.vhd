-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   CU.vhd
-- Deskripsi        :   Implementasi blok Control Unit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY cu IS
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
END cu;

ARCHITECTURE BEHAVIOURAL of cu IS
SIGNAL JUMP: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL BNE:  STD_LOGIC;
SIGNAL BRANCH: STD_LOGIC;
SIGNAL MEMTOREG: STD_LOGIC;
SIGNAL MEMREAD: STD_LOGIC;
SIGNAL MEMWRITE: STD_LOGIC;
SIGNAL REGDEST: STD_LOGIC_VECTOR(1 DOWNTO 0);
SIGNAL REGWRITE: STD_LOGIC;
SIGNAL ALUSRC: STD_LOGIC_VECTOR (1 DOWNTO 0);
SIGNAL ALUCTRL: STD_LOGIC;

BEGIN
--Kombinasional Output
Sig_Jmp			<= 	JUMP;
Sig_Bne			<= 	BNE;
Sig_Branch		<= 	BRANCH;
Sig_MemtoReg	<=		MEMTOREG;
Sig_MemRead		<=		MEMREAD;
Sig_MemWrite	<=		MEMWRITE;
Sig_RegDest		<=		REGDEST;
Sig_RegWrite	<=		REGWRITE;
Sig_ALUSrc		<=		ALUSRC;
Sig_ALUCtrl		<=		ALUCTRL;

--Generate Sinyal Kontrol
CONTROL:
	PROCESS(OP_In, FUNCT_In)
	BEGIN
		IF ((OP_In = "000000") AND (FUNCT_In = "100000")) THEN --add
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "01";
			REGWRITE <= '1';
			ALUSRC <= "00";
			ALUCTRL <= '0';
		ELSIF ((OP_In = "000000") AND (FUNCT_In = "100010")) THEN --sub
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "01";
			REGWRITE <= '1';
			ALUSRC <= "00";
			ALUCTRL <= '1';
		ELSIF ((OP_In = "000100")) THEN	--beq
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '1';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "--";
			REGWRITE <= '0';
			ALUSRC <= "--";
			ALUCTRL <= '-';
		ELSIF ((OP_In = "000101")) THEN --bne
			JUMP <= "00";
			BNE  <= '1';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "--";
			REGWRITE <= '0';
			ALUSRC <= "--";
			ALUCTRL <= '-';
		ELSIF ((OP_In = "001000")) THEN --addi
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "00";
			REGWRITE <= '1';
			ALUSRC <= "01";
			ALUCTRL <= '0';
		ELSIF ((OP_In = "100011")) THEN --lw
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '1';
			MEMREAD <= '1';
			MEMWRITE <= '0';
			REGDEST <= "00";
			REGWRITE <= '1';
			ALUSRC <= "01";
			ALUCTRL <= '0';
		ELSIF ((OP_In = "101011")) THEN --sw
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '1';
			REGDEST <= "00";
			REGWRITE <= '0';
			ALUSRC <= "01";
			ALUCTRL <= '0';
		ELSIF ((OP_In = "000010")) THEN --jmp
			JUMP <= "01";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "--";
			REGWRITE <= '0';
			ALUSRC <= "--";
			ALUCTRL <= '-';
		ELSIF ((OP_In = "000000")) THEN --nop
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "00";
			REGWRITE <= '0';
			ALUSRC <= "00";
			ALUCTRL <= '0';
		ELSE							--SUPAYA TIDAK ADA LATCH
			JUMP <= "00";
			BNE  <= '0';
			BRANCH <= '0';
			MEMTOREG <= '0';
			MEMREAD <= '0';
			MEMWRITE <= '0';
			REGDEST <= "00";
			REGWRITE <= '0';
			ALUSRC <= "00";
			ALUCTRL <= '0';
		END IF;
	END PROCESS CONTROL;

END BEHAVIOURAL;