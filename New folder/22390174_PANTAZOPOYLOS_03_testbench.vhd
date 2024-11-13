library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MIPS_tb is
end MIPS_tb;

architecture Behavioral of MIPS_tb is
    signal clk, reset : STD_LOGIC;

    component MIPS
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC
        );
    end component;

begin
    -- Instantiate the MIPS processor
    uut: MIPS port map(
        clk => clk,
        reset => reset
    );

    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for 2.5 ns;
        clk <= '1';
        wait for 2.5 ns;
    end process;

    -- Test process
    process
    begin
        reset <= '1';  -- Assert reset
        wait for 4.9 ns;  -- Hold reset for 5 ns
        reset <= '0';  -- Deassert reset
        wait for 100 ns;  -- Run simulation for 1000 ns
        wait;
    end process;

end Behavioral;

