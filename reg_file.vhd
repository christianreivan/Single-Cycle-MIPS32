-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul			:	5
-- Percobaan		:	1 dan 2
-- Tanggal			:	25 November 2021
-- Rombongan		:	A
-- Nama (NIM)		:	Christian Reivan (13219005)
-- Nama File		:	reg_file.vhd
-- Deskripsi		:	Implementasi Register

LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY REG_FILE IS 
PORT ( ADDR1 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rs
		 ADDR2 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rt
		 ADDR3 : 	 IN STD_LOGIC_VECTOR (4 DOWNTO 0); -- REGISTER Rd
		 WR_EN:		 IN STD_LOGIC; --INDIKATOR PENULISAN
		 clock : 	 IN STD_LOGIC; -- clock 
		 WR_Data_3 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);-- write data
		 RD_DATA_1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0); -- READ DATA1
		 RD_DATA_2 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) -- READ DATA2
	  ); 

END ENTITY;

ARCHITECTURE structural OF REG_FILE IS
TYPE ramtype IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL mem: ramtype := (
   x"00000000", x"8c030001", x"00430820", x"ac010003",	--r0, at, v0, v1
   x"1022ffff", x"1021fffa", x"0043282a", x"10a00002", 	--a0, a1, a2, a3
   x"1000fffb", x"ac040000", x"1000ffff", x"00000000",	--t0, t1, t2, t3
   x"00000000", x"00000004", x"00000008", x"00000000",	--t4, t5, t6, t7
   x"00000000", x"00000000", x"00000000", x"00000000",	--s0, s1, s2, s3
   x"00000000", x"00000000", x"00000000", x"00000000",	--s4, s5, s6, s7
   x"00000000", x"00000000", x"00000000", x"00000000",	--t8, t9, k0, k1
   x"00000000", x"00000000", x"00000000", x"00000000"		--gp, sp, s8, ra
   );
SIGNAL rd_data1: STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL rd_data2: STD_LOGIC_VECTOR(31 DOWNTO 0);
--SIGNAL address1: STD_LOGIC_VECTOR(4  DOWNTO 0);
--SIGNAL address2: STD_LOGIC_VECTOR(4  DOWNTO 0);

BEGIN
-- Blok Kombinasional
RD_DATA_1 <= rd_data1;
RD_DATA_2 <= rd_data2;
--address1 <= ADDR1;
--address2 <= ADDR2;

PROCESS (CLOCK, ADDR1, ADDR2, ADDR3, WR_EN, MEM, WR_Data_3)
BEGIN
			if (rising_edge(clock)) then
				if (WR_EN = '1') then
					if (addr3 /= "00000") then
						mem(to_integer(unsigned(ADDR3))) <= WR_Data_3;
					end if;
				end if;
			end if;
			
			if (falling_edge(clock)) then
					rd_data1 <= mem(to_integer(unsigned(ADDR1)));
					rd_data2 <= mem(to_integer(unsigned(ADDR2)));
			end if;
			
end process;
		
END structural;