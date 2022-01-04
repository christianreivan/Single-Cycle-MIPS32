-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   PC.vhd
-- Deskripsi        :   Implementasi blok Program Counter

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity PC is
    Port ( clock:		in  STD_LOGIC;
           PC_in:		in  STD_LOGIC_VECTOR(31 DOWNTO 0);
           PC_out:	out STD_LOGIC_VECTOR (31 downto 0));
end PC;

architecture Behavioral of PC is
SIGNAL wire_in:  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL wire_out: STD_LOGIC_VECTOR(31 DOWNTO 0);


BEGIN

--Kombinasional
	wire_in  <= PC_in;
	PC_out	<= wire_out;

	process(clock)
	begin
		if(rising_edge(clock)) then
			wire_out <= wire_in;
		end if;
	end process;

end Behavioral;