library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LeftShift is
    Port ( data_in : in STD_LOGIC_VECTOR (31 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end LeftShift;

architecture Behavioral of LeftShift is
begin
    process(data_in)
    begin
        data_out <= std_logic_vector(shift_left(unsigned(data_in), 2)); 
    end process;
end Behavioral;



