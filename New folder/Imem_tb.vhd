library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IMem_tb is
end IMem_tb;

architecture Behavioral of IMem_tb is
    signal Address : STD_LOGIC_VECTOR(3 downto 0);
    signal ReadData : STD_LOGIC_VECTOR(31 downto 0);

    component IMem
        Port (
            Address : in STD_LOGIC_VECTOR(3 downto 0);
            ReadData : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    UUT: IMem Port map(Address => Address, ReadData => ReadData);

    process
    begin
        -- Read the memory at position 4
        Address <= std_logic_vector(to_unsigned(4, 4));
        wait for 10 ns;

        wait;
    end process;
end Behavioral;
