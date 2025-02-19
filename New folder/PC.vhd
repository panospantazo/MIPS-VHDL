library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           PC_in : in STD_LOGIC_VECTOR(31 downto 0);
           PC_out : out STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is
    signal PC_reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            PC_reg <= (others => '0');
        elsif rising_edge(clk) then
            PC_reg <= PC_in;
        end if;
    end process;
    PC_out <= PC_reg;
end Behavioral;



