library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY sign_extender IS
PORT (
			D_In :IN std_logic_vector (15 DOWNTO 0); -- Data Input 1 
			D_Out :OUT std_logic_vector (31 DOWNTO 0) -- Data Input 2
);
END sign_extender;

ARCHITECTURE BEHAVIOUR of sign_extender IS
SIGNAL trailing: unsigned (15 DOWNTO 0);
BEGIN

trailing <= (OTHERS => D_In(15));

D_Out <= std_logic_vector(trailing & unsigned(D_In));


END BEHAVIOUR;