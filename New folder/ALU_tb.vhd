library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU_tb is
end ALU_tb;

architecture Behavioral of ALU_tb is
    signal A, B : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp : STD_LOGIC_VECTOR(2 downto 0);
    signal Result : STD_LOGIC_VECTOR(31 downto 0);
    signal Zero : STD_LOGIC;

    component ALU
        Port ( A : in STD_LOGIC_VECTOR(31 downto 0);
               B : in STD_LOGIC_VECTOR(31 downto 0);
               ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
               Result : out STD_LOGIC_VECTOR(31 downto 0);
               Zero : out STD_LOGIC);
    end component;
begin
    UUT: ALU 
        Port map(
            A => A, 
            B => B, 
            ALUOp => ALUOp, 
            Result => Result, 
            Zero => Zero
        );

    stimulus_process: process
    begin
        -- Test 5 + (-4)
        A <= std_logic_vector(to_signed(5, 32));
        B <= std_logic_vector(to_signed(-4, 32));
        ALUOp <= "000";
        wait for 10 ps;

        -- Test 5 + (-5)
        A <= std_logic_vector(to_signed(5, 32));
        B <= std_logic_vector(to_signed(-5, 32));
        ALUOp <= "000"; 
        wait for 10 ps;

        -- Test 7 - 8
        A <= std_logic_vector(to_signed(7, 32));
        B <= std_logic_vector(to_signed(8, 32));
        ALUOp <= "001"; 
        wait for 10 ps;

        wait;
    end process;
end Behavioral;
