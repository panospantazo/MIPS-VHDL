library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder32 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           Sum : out STD_LOGIC_VECTOR (31 downto 0));
end Adder32;

architecture Behavioral of Adder32 is
begin
    process(A, B)
    begin
        Sum <= std_logic_vector(unsigned(A) + unsigned(B)); -- Add the two 32-bit inputs
    end process;
end Behavioral;