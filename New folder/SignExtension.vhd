library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtension is
    Port ( inst : in STD_LOGIC_VECTOR (15 downto 0);
           data : out STD_LOGIC_VECTOR (31 downto 0));
end SignExtension;

architecture Behavioral of SignExtension is
begin
    process(inst)
    begin
        data <= std_logic_vector(resize(signed(inst), 32));
    end process;
end Behavioral;

