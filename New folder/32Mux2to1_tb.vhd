library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A32Mux2to1_tb is
end A32Mux2to1_tb;

architecture Behavioral of A32Mux2to1_tb is
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal sel : STD_LOGIC;
    signal Y : STD_LOGIC_VECTOR(31 downto 0);

    component A32Mux2to1
        Port ( 
            A : in STD_LOGIC_VECTOR(31 downto 0);
            B : in STD_LOGIC_VECTOR(31 downto 0);
            sel : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    -- Instantiate the A32Mux2to1 component
    UUT: A32Mux2to1 
        Port map(
            A => A, 
            B => B, 
            sel => sel, 
            Y => Y
        );

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test case 1: A = 0xAAAAAAAA, B = 0xBBBBBBBB, sel = 1
        A <= x"AAAAAAAA";
        B <= x"BBBBBBBB";
        sel <= '1';
        wait for 10 ps;

        -- Test case 2: A = 0xAAAAAAAA, B = 0xBBBBBBBB, sel = 0
        sel <= '0';
        wait for 10 ps;

        wait;  -- End of simulation
    end process stimulus_process;

end Behavioral;
