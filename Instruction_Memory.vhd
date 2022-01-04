-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   Instruction_Memory.vhd
-- Deskripsi        :   Implementasi blok Instruction_Memory

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity Instruction_Memory is
    Port ( addr  : in	STD_LOGIC_VECTOR (31 downto 0);
			  clock : in	STD_LOGIC;
			  reset : in	STD_LOGIC;
           instr : out  STD_LOGIC_VECTOR (31 downto 0));
end Instruction_Memory;

architecture Behavioral of Instruction_Memory is
type mem is array(0 to 255) of std_logic_vector(31 downto 0);
signal memory : mem := (
		x"20100013",x"1000fffb",x"ac040000",x"1000ffff",
		x"20110015",x"00000013",x"00000000",x"00000000",
		x"16530001",x"00000011",x"00000000",x"00000003",
		x"00000000",x"00000072",x"00000098",x"00000020",
		x"02119822",x"00000000",x"00000000",x"00000004",
		x"22730000",x"00000000",x"00000000",x"00000000",
		x"22140004",x"00000000",x"00000000",x"00000000",
		x"ae910000",x"00000000",x"00000000",x"00000000",
		x"8e950000",x"00000000",x"00000000",x"00000000",
		x"02a0a820",x"00000000",x"00000000",x"00000000",
		x"08000000",x"00000000",x"00000000",x"00000000",
		x"00000000",x"00000000",x"00000000",x"00000000",
		others => x"00000000"
		);

signal wire_in: STD_LOGIC_VECTOR(31 DOWNTO 0);
--signal instr_read: STD_LOGIC_VECTOR (31 downto 0);

begin

--instr_read <= memory(to_integer(unsigned(ADDR)));
wire_in <= addr;

	process(clock, reset, addr, memory)
	begin
		if (reset = '1') then
			instr <= (others => '0');
		elsif (rising_edge(clock)) then
			instr <= memory(to_integer(unsigned(wire_in)));
		end if;
	end process;
	
end Behavioral;