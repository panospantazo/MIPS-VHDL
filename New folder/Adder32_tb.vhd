library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder32_tb is
end Adder32_tb;

architecture Behavioral of Adder32_tb is
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal Sum : STD_LOGIC_VECTOR(31 downto 0);

    component Adder32
        Port ( 
            A : in STD_LOGIC_VECTOR(31 downto 0);
            B : in STD_LOGIC_VECTOR(31 downto 0);
            Sum : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin
    -- Instantiate the Adder32 component
    UUT: Adder32 
        Port map(
            A => A, 
            B => B, 
            Sum => Sum
        );

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test case 1: A = 0xAAAAAAAA, B = 0xBBBBBBBB
        A <= x"AAAAAAAA";
        B <= x"BBBBBBBB";
        wait for 10 ps;

        -- Test case 2: A = 0xAAAAAAAA, B = 0x55555556
        A <= x"AAAAAAAA";
        B <= x"55555556";
        wait for 10 ps;

        wait;  -- End of simulation
    end process stimulus_process;

end Behavioral;