-- Praktikum EL3111 Arsitektur Sistem Komputer
-- Modul            :   5
-- Percobaan        :   1 dan 2
-- Tanggal          :   25 November 2021
-- Rombongan        :   C (tuker dari A)
-- Nama (NIM)       :   Christian Reivan (13219005)
-- Nama File        :   cla.vhd
-- Deskripsi        :   Implementasi blok paling rendah dari Carry Lookahead Adder

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cla is
port (
      P :      in std_logic_vector(3 downto 0);
      G :      in std_logic_vector(3 downto 0);
		cin :    in std_logic;
      Cout :   out std_logic_vector(4 downto 0)
     );
end cla;

architecture Behavioral of cla is
BEGIN

Cout(0) <= cin;
Cout(1) <= G(0) or (P(0) and cin);
Cout(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and cin);
Cout(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and cin);
Cout(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and cin);
 
END Behavioral;