library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUControl is
    Port ( 
        funct : in STD_LOGIC_VECTOR(5 downto 0);
        ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
        ALUControlOut : out STD_LOGIC_VECTOR(2 downto 0)
    );
end ALUControl;

architecture Behavioral of ALUControl is
begin
    process(funct, ALUOp)
    begin
        case ALUOp is
            when "00" => ALUControlOut <= "010"; -- add (lw/sw)
            when "01" => ALUControlOut <= "110"; -- sub (beq)
            when "10" =>
                case funct is
                    when "100000" => ALUControlOut <= "010"; -- add
                    when "100010" => ALUControlOut <= "110"; -- sub
                    when "100100" => ALUControlOut <= "000"; -- and
                    when "100101" => ALUControlOut <= "001"; -- or
                    when "101010" => ALUControlOut <= "111"; -- slt
                    when others => ALUControlOut <= "000"; -- or any default valid value
                end case;
            when others => ALUControlOut <= "000"; -- or any default valid value
        end case;
    end process;
end Behavioral;
