-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   lshift_32_32.vhd
-- Deskripsi        :   Implementasi blok shifter 32 bit ke 32 bit

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY lshift_32_32 IS
PORT (
			D_IN : IN STD_LOGIC_VECTOR (31 DOWNTO 0); -- Input 32-bit;
			D_OUT : OUT STD_LOGIC_VECTOR (31 DOWNTO 0) -- Output 32-bit;
);
END lshift_32_32;

ARCHITECTURE BEHAVIOUR of lshift_32_32 IS
BEGIN

D_OUT <= STD_LOGIC_VECTOR(SHIFT_LEFT(UNSIGNED(D_IN), 2));

END BEHAVIOUR;