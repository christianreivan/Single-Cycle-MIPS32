-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   data_memory.vhd
-- Deskripsi        :   Implementasi blok data_memory

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY data_memory IS
PORT ( ADDR : 	IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- alamat
		 WR_EN:	IN STD_LOGIC; --INDIKATOR PENULISAN
		 RD_EN:	IN STD_LOGIC; --INDIKATOR PEMBACAAN
		 clock : IN STD_LOGIC; -- clock 
		 WR_DATA: IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- DATA YANG AKAN DIASSIGN KE MEMORY
		 RD_DATA : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- VALUE MEMORY YANG DIBACA
	  ); 

END data_memory;

ARCHITECTURE structural OF data_memory IS
type mem is array(0 to 255) of std_logic_vector(31 downto 0);
	signal memory : mem := (
		x"00000000",x"8c010000",x"8c020004",x"8c030008",
		x"00000000",x"00822020",x"0043282a",x"10a00002",
		x"0000000a",x"1000fffb",x"ac040000",x"1000ffff",
		x"00000020",x"00000013",x"00000000",x"00000000",
		x"00000012",x"00000011",x"00000000",x"00000003",
		x"00000002",x"00000072",x"00000098",x"00000020",
		x"00000022",x"00000010",x"00000000",x"00000001",
		x"00000008",x"00000000",x"00000000",x"00000004",
		others => x"00000000"
		);
signal temp_rd_data: STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
--Kombinasional
RD_DATA <= temp_rd_data;

PROCESS (clock, wr_en, rd_en, addr, memory, wr_data)
BEGIN
	if (rising_edge(clock)) then
				if ((WR_EN = '1') and (RD_EN = '0')) then
					memory(to_integer(unsigned(ADDR))) <= WR_Data;
				end if;
	end if;
	
	if (falling_edge(clock)) then
				if ((WR_EN = '0') and (RD_EN = '1')) then
					temp_rd_data <= memory(to_integer(unsigned(ADDR)));
				end if;
	end if;
	
end PROCESS;

END structural;