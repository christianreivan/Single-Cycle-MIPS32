-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   bus_merger.vhd
-- Deskripsi        :   Implementasi blok bus_merger

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY bus_merger IS
PORT (
			DATA_IN1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			DATA_IN2 : IN STD_LOGIC_VECTOR (27 DOWNTO 0);
			DATA_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
);
END bus_merger;

ARCHITECTURE BEHAVIOURAL of bus_merger IS
BEGIN

DATA_OUT <= DATA_IN1 & DATA_IN2;

END BEHAVIOURAL;