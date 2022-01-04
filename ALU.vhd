-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   ALU.vhd
-- Deskripsi        :   blok ALU

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY ALU IS
PORT (
	OPRND_1 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 1 
	OPRND_2 : IN std_logic_vector (31 DOWNTO 0); -- Data Input 2
	OP_SEL : IN std_logic; -- Operation Select
	RESULT : OUT std_logic_vector (31 DOWNTO 0) -- Data Output
);
END ALU;

ARCHITECTURE BEHAVIOUR of ALU IS
COMPONENT CLA_32 IS
PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
);
END COMPONENT;

BEGIN

ALU_BLOCK: CLA_32
				PORT MAP(OPRND_1 => OPRND_1,
							OPRND_2 => OPRND_2,
							C_IN	  => OP_SEL,
							RESULT  => RESULT,
							C_OUT	  => OPEN);

END BEHAVIOUR;