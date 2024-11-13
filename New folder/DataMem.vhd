library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity DataMem is
    Port ( Address : in STD_LOGIC_VECTOR(3 downto 0);
           WriteData : in STD_LOGIC_VECTOR(31 downto 0);
           MemWrite, MemRead : in STD_LOGIC;
           ReadData : out STD_LOGIC_VECTOR(31 downto 0));
end DataMem;

architecture Behavioral of DataMem is
    type memtype is array (15 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal Memory : memtype := (others => (others => '0'));
begin
    process(Address, WriteData, MemWrite, MemRead)
    begin
        if MemWrite = '1' then
            Memory(to_integer(unsigned(Address))) <= WriteData;
        end if;
        if MemRead = '1' then
            ReadData <= Memory(to_integer(unsigned(Address)));
        else
            ReadData <= (others => 'Z');  -- High impedance state when not reading
        end if;
    end process;
end Behavioral;



