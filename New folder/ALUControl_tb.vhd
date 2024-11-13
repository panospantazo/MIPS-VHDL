library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl_tb is
end ALUControl_tb;

architecture Behavioral of ALUControl_tb is
    signal funct : STD_LOGIC_VECTOR(5 downto 0);
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControlOut : STD_LOGIC_VECTOR(2 downto 0);

    component ALUControl
        Port ( 
            funct : in STD_LOGIC_VECTOR(5 downto 0);
            ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
            ALUControlOut : out STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

begin
    -- Instantiate the ALUControl component
    UUT: ALUControl 
        Port map(
            funct => funct, 
            ALUOp => ALUOp, 
            ALUControlOut => ALUControlOut
        );

    -- Stimulus process
    stimulus_process : process
    begin
        -- Test case 1: Funct = 100000, ALUOp = 10
        funct <= "100000";
        ALUOp <= "10";
        wait for 10 ps;

        -- Test case 2: Funct = 100010, ALUOp = 10
        funct <= "100010";
        ALUOp <= "10";
        wait for 10 ps;

        -- Test case 3: Funct = 111111, ALUOp = 00
        funct <= "111111";
        ALUOp <= "00";
        wait for 10 ps;

        -- Test case 4: Funct = 111111, ALUOp = 01
        funct <= "111111";
        ALUOp <= "01";
        wait for 10 ps;

        wait;  -- End of simulation
    end process stimulus_process;

end Behavioral;

