library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture Behavioral of RegisterFile_tb is
    signal clk, RegWrite : STD_LOGIC;
    signal ReadReg1, ReadReg2, WriteReg : STD_LOGIC_VECTOR(3 downto 0);
    signal WriteData : STD_LOGIC_VECTOR(31 downto 0);
    signal ReadData1, ReadData2 : STD_LOGIC_VECTOR(31 downto 0);

    component RegisterFile
        Port (
            clk : in STD_LOGIC;
            ReadReg1, ReadReg2, WriteReg : in STD_LOGIC_VECTOR(3 downto 0);
            WriteData : in STD_LOGIC_VECTOR(31 downto 0);
            RegWrite : in STD_LOGIC;
            ReadData1, ReadData2 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    constant CLK_PERIOD : time := 10 ps;

begin
    -- Instantiate the RegisterFile component
    UUT: RegisterFile
        Port map(
            clk => clk,
            ReadReg1 => ReadReg1,
            ReadReg2 => ReadReg2,
            WriteReg => WriteReg,
            WriteData => WriteData,
            RegWrite => RegWrite,
            ReadData1 => ReadData1,
            ReadData2 => ReadData2
        );

    -- Clock generation process
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process clk_process;

    -- Stimulus process
    stimulus_process : process
    begin
        -- Write 5 to register $3
        RegWrite <= '1';
        WriteReg <= "0011";
        WriteData <= std_logic_vector(to_signed(5, 32));
        wait for CLK_PERIOD;

        -- Write 7 to register $4
        WriteReg <= "0100";
        WriteData <= std_logic_vector(to_signed(7, 32));
        wait for CLK_PERIOD;

        -- Write 9 to register $5
        WriteReg <= "0101";
        WriteData <= std_logic_vector(to_signed(9, 32));
        wait for CLK_PERIOD;

        -- Read registers $3 and $4
        RegWrite <= '0';
        ReadReg1 <= "0011";
        ReadReg2 <= "0100";
        wait for CLK_PERIOD;

        wait;  -- End of simulation
    end process stimulus_process;

end Behavioral;
