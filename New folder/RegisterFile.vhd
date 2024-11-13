library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile is
    Port (
        clk : in STD_LOGIC;
        ReadReg1, ReadReg2, WriteReg : in STD_LOGIC_VECTOR(3 downto 0);
        WriteData : in STD_LOGIC_VECTOR(31 downto 0);
        RegWrite : in STD_LOGIC;
        ReadData1, ReadData2 : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegisterFile;

architecture Behavioral of RegisterFile is
    type regfile is array (15 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
    signal Registers : regfile := (others => (others => '0'));
begin
    -- Synchronous process for writing to the register file
    process(clk)
    begin
        if rising_edge(clk) then
            if RegWrite = '1' then
                Registers(to_integer(unsigned(WriteReg))) <= WriteData;
            end if;
        end if;
    end process;

    -- Combinational process for reading from the register file
    process(Registers, ReadReg1, ReadReg2)
    begin
        ReadData1 <= Registers(to_integer(unsigned(ReadReg1)));
        ReadData2 <= Registers(to_integer(unsigned(ReadReg2)));
    end process;

end Behavioral;

