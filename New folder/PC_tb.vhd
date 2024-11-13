library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is
    signal clk, reset : STD_LOGIC;
    signal PC_in : STD_LOGIC_VECTOR(31 downto 0);
    signal PC_out : STD_LOGIC_VECTOR(31 downto 0);

    component PC
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               PC_in : in STD_LOGIC_VECTOR(31 downto 0);
               PC_out : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    constant CLK_PERIOD : time := 10 ps;
begin
    UUT: PC Port map(clk => clk, reset => reset, PC_in => PC_in, PC_out => PC_out);

    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    process
    begin
        reset <= '1';
        wait for 10 ps;
        reset <= '0';

        -- Write 0xAAAA BBBB
        PC_in <= x"AAAA_BBBB";
        wait for 10 ps;

        -- Write 0xFFFF CCCC
        PC_in <= x"FFFF_CCCC";
        wait for 10 ps;

        wait;
    end process;
end Behavioral;

