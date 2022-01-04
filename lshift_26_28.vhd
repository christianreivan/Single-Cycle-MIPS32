-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   lshift_26_28.vhd
-- Deskripsi        :   Implementasi blok shifter 26 bit ke 28 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY lshift_26_28 IS
PORT (
			D_IN : IN STD_LOGIC_VECTOR (25 DOWNTO 0); -- Input 26-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (27 DOWNTO 0) -- Output 28-bit;
);
END lshift_26_28;

ARCHITECTURE BEHAVIOUR of lshift_26_28 IS
BEGIN

D_OUT <= STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(("00" & D_IN)), 2));

END BEHAVIOUR;