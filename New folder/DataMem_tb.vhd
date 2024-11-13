library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DataMem_tb is
end DataMem_tb;

architecture Behavioral of DataMem_tb is
    signal Address : STD_LOGIC_VECTOR(3 downto 0);
    signal WriteData : STD_LOGIC_VECTOR(31 downto 0);
    signal MemWrite, MemRead : STD_LOGIC;
    signal ReadData : STD_LOGIC_VECTOR(31 downto 0);

    component DataMem
        Port ( Address : in STD_LOGIC_VECTOR(3 downto 0);
               WriteData : in STD_LOGIC_VECTOR(31 downto 0);
               MemWrite, MemRead : in STD_LOGIC;
               ReadData : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
begin
    UUT: DataMem Port map(Address => Address, WriteData => WriteData, MemWrite => MemWrite, MemRead => MemRead, ReadData => ReadData);

    process
    begin
        -- Write 5 to memory location 0
        Address <= std_logic_vector(to_unsigned(0, 4)); -- 4 bits wide
        WriteData <= std_logic_vector(to_signed(5, 32));
        MemWrite <= '1';
        MemRead <= '0';
        wait for 10 ps;

        -- Write 7 to memory location 1
        Address <= std_logic_vector(to_unsigned(1, 4)); -- 4 bits wide
        WriteData <= std_logic_vector(to_signed(7, 32));
        wait for 10 ps;

        -- Read memory location 0
        Address <= std_logic_vector(to_unsigned(0, 4)); -- 4 bits wide
        MemWrite <= '0';
        MemRead <= '1';
        wait for 10 ps;

        wait;
    end process;
end Behavioral;
