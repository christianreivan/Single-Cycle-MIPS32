-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   BR_INTERRUPT.vhd
-- Deskripsi        :   Blok kombinasional untuk selektor mux2to1 apabila branching

LIBRARY ieee; 
USE ieee.std_logic_1164.all; 
USE ieee.numeric_std.all;

ENTITY BR_INTERRUPT IS
PORT(	sig_branch: IN STD_LOGIC;
		sig_bne:		IN STD_LOGIC;
		comp:			IN STD_LOGIC;
		pc_sel:		OUT STD_LOGIC
	);
END BR_INTERRUPT;

ARCHITECTURE BEHAVIOUR of BR_INTERRUPT IS
BEGIN

--Blok menentukan apakah PC dipilih target address atau hasil increment + 4
pc_sel <= (sig_bne AND NOT(COMP)) OR (sig_branch AND COMP);

END BEHAVIOUR;