library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity A5Mux2to1_tb is
end A5Mux2to1_tb;

architecture Behavioral of A5Mux2to1_tb is
    signal A, B : STD_LOGIC_VECTOR(4 downto 0);
    signal sel : STD_LOGIC;
    signal Y : STD_LOGIC_VECTOR(4 downto 0);

    component a5Mux2to1
        Port ( 
            A : in STD_LOGIC_VECTOR(4 downto 0);
            B : in STD_LOGIC_VECTOR(4 downto 0);
            sel : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(4 downto 0)
        );
    end component;

begin
    -- Instantiate the a5Mux2to1 component
    UUT: a5Mux2to1 
        Port map(
            A => A, 
            B => B, 
            sel => sel, 
            Y => Y
        );

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test case 1: A = 0x1A, B = 0x0B, sel = 1
        A <= "11010";  -- 0x1A
        B <= "01011";  -- 0x0B
        sel <= '1';
        wait for 10 ps;

        -- Test case 2: A = 0x1A, B = 0x0B, sel = 0
        sel <= '0';
        wait for 10 ps;

        wait;  -- End of simulation
    end process stimulus_process;

end Behavioral;