-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   cla_32.vhd
-- Deskripsi        :   Implementasi Top-level Untuk Carry-Lookahead Adder 32 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY cla_32 IS
PORT (
		OPRND_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0); -- Operand 1
		OPRND_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Operand 2
		C_IN : IN STD_LOGIC; -- Carry In
		RESULT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- Result
		C_OUT : OUT STD_LOGIC -- Overflow
);
END cla_32;

ARCHITECTURE BEHAVIOUR of cla_32 IS
SIGNAL wire0: STD_LOGIC_VECTOR(8 DOWNTO 0) := (OTHERS => '0');
signal complement1: STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT CLA_8BIT IS
PORT (
			A : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Operand 1
			B : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- Operand 2
			C_IN : IN STD_LOGIC; -- Carry In
			RESULT : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Result
			C_Out: OUT STD_LOGIC
);
END COMPONENT;

BEGIN
ONES: FOR i IN 0 TO 31 GENERATE
		complement1(i) <= OPRND_2(i) xor C_IN;
		END GENERATE;
		
wire0(0) <= C_IN;
CLA_1: CLA_8BIT
			port map(A => OPRND_1(3 DOWNTO 0),
						B => complement1(3 DOWNTO 0),
						C_IN => wire0(0),
						RESULT => RESULT(3 DOWNTO 0),
						C_Out => wire0(1)
						);

CLA_2: CLA_8BIT
			port map(A => OPRND_1(7 DOWNTO 4),
						B => complement1(7 DOWNTO 4),
						C_IN => wire0(1),
						RESULT => RESULT(7 DOWNTO 4),
						C_Out => wire0(2)
						);
						
CLA_3: CLA_8BIT
			port map(A => OPRND_1(11 DOWNTO 8),
						B => complement1(11 DOWNTO 8),
						C_IN => wire0(2),
						RESULT => RESULT(11 DOWNTO 8),
						C_Out => wire0(3)
						);
						
CLA_4: CLA_8BIT
			port map(A => OPRND_1(15 DOWNTO 12),
						B => complement1(15 DOWNTO 12),
						C_IN => wire0(3),
						RESULT => RESULT(15 DOWNTO 12),
						C_Out => wire0(4)
						);
						
CLA_5: CLA_8BIT
			port map(A => OPRND_1(19 DOWNTO 16),
						B => complement1(19 DOWNTO 16),
						C_IN => wire0(4),
						RESULT => RESULT(19 DOWNTO 16),
						C_Out => wire0(5)
						);
						
CLA_6: CLA_8BIT
			port map(A => OPRND_1(23 DOWNTO 20),
						B => complement1(23 DOWNTO 20),
						C_IN => wire0(5),
						RESULT => RESULT(23 DOWNTO 20),
						C_Out => wire0(6)
						);
						
CLA_7: CLA_8BIT
			port map(A => OPRND_1(27 DOWNTO 24),
						B => complement1(27 DOWNTO 24),
						C_IN => wire0(6),
						RESULT => RESULT(27 DOWNTO 24),
						C_Out => wire0(7)
						);
						
CLA_8: CLA_8BIT
			port map(A => OPRND_1(31 DOWNTO 28),
						B => complement1(31 DOWNTO 28),
						C_IN => wire0(7),
						RESULT => RESULT(31 DOWNTO 28),
						C_Out => wire0(8)
						);
						
C_OUT <= wire0(8);
				
END BEHAVIOUR;