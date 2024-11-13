library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity IMem is
    Port ( 
        Address : in STD_LOGIC_VECTOR(3 downto 0);
        ReadData : out STD_LOGIC_VECTOR(31 downto 0)
    );
end IMem;

architecture Behavioral of IMem is
    type memtype is array (15 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal Memory : memtype := (
        0 => x"20000000",  -- addi $0, $0, 0
        1 => x"20420000",  -- addi $2, $2, 0
        2 => x"20840000",  -- addi $2, $4, 0
        3 => x"20030001",  -- addi $3, $0, 1
        4 => x"20050003",  -- addi $5, $0, 3
        5 => x"00603020",  -- add $6, $3, $0
        6 => x"AC860000",  -- sw $6, 0($4)
        7 => x"20630001",  -- addi $3, $3, 1
        8 => x"20840001",  -- addi $4, $4, 1
        9 => x"20A5FFFF",  -- addi $5, $5, -1
        10 => x"14A0FFF9", -- bne $5, $0, L1 (Offset -7)
        others => (others => '0')
    );
begin
    process(Address)
    begin
        ReadData <= Memory(to_integer(unsigned(Address)));
    end process;
end Behavioral;
