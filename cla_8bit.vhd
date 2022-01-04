-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   cla_8bit.vhd
-- Deskripsi        :   Implementasi blok cla untuk 8 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY cla_8bit IS --harusnya 4bit
PORT (
			A : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- Operand 1
			B : IN STD_LOGIC_VECTOR (3 DOWNTO 0); -- Operand 2
			C_IN : IN STD_LOGIC; -- Carry In
			RESULT : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); -- Result
			C_Out: OUT STD_LOGIC
);
END cla_8bit;

ARCHITECTURE BEHAVIOUR of cla_8bit IS
signal P,G : STD_LOGIC_VECTOR(3 DOWNTO 0) :=  "0000";
signal COUT : STD_LOGIC_VECTOR(4 DOWNTO 0) := "00000";
--signal complement1: STD_LOGIC_VECTOR(3 DOWNTO 0);
component cla is
port (
      P :    in std_logic_vector(3 downto 0);
      G :    in std_logic_vector(3 downto 0);
		Cin :  in std_logic;
      Cout : out std_logic_vector(4 downto 0)
     );
end component;

BEGIN

P <= A xor B;
G <= A and B;

CARRYLOOKAHEAD: cla
					 port map(P=>P, G=>G, Cout=>COUT, Cin=>C_IN);

RESULT <= P xor COUT(3 DOWNTO 0);
C_Out <= COUT(4);

END BEHAVIOUR;