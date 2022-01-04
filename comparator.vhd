-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   comparator.vhd
-- Deskripsi        :   Implementasi blok comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY comparator IS
PORT (
			D_1 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			D_2 : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			EQ : OUT STD_LOGIC -- Hasil Perbandingan EQ
);

END comparator;

ARCHITECTURE BEHAVIOUR of comparator IS
BEGIN

PROCESS (D_1, D_2)
BEGIN
	IF (D_1 = D_2) THEN
		EQ <= '1';
	ELSE
		EQ <= '0';
	END IF;
END PROCESS;

END BEHAVIOUR;