-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   mux_4to1_5bit.vhd
-- Deskripsi        :   Implementasi blok mux_4to1 untuk 5 bits wide data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


ENTITY mux_4to1_5bit IS
PORT (
			D1 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 1 
			D2 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 2 
			D3 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 3 
			D4 :  IN std_logic_vector (4 DOWNTO 0); -- Data Input 4
			SEL : IN std_logic_vector  (1 DOWNTO 0); -- Selector
			Y :  OUT std_logic_vector (4 DOWNTO 0)  -- Selected Data
	 );

END mux_4to1_5bit;


ARCHITECTURE BEHAVIOUR of mux_4to1_5bit IS

BEGIN

Y <= D1 WHEN (SEL = "00") ELSE
	  D2 WHEN (SEL = "01") ELSE
	  D3 WHEN (SEL = "10") ELSE
	  D4 WHEN (SEL = "11") ELSE
	  D1;

END BEHAVIOUR;