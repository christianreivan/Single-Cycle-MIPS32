-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   mux_2to1_32bit.vhd
-- Deskripsi        :   Implementasi blok mux_2to1 untuk 32 bits wide data

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY mux_2to1_32bit IS
PORT (
			D1 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			D2 :	IN			STD_LOGIC_VECTOR(31 DOWNTO 0);
			SEL:	IN			STD_LOGIC;
			Y	:	OUT		STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );

END mux_2to1_32bit;

ARCHITECTURE BEHAVIOURAL of mux_2to1_32bit IS

BEGIN

Y <= D1 WHEN (SEL = '0') ELSE
	  D2 WHEN (SEL = '1') ELSE
	  D1;

END BEHAVIOURAL;