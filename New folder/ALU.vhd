
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port (
        A : in STD_LOGIC_VECTOR (31 downto 0);
        B : in STD_LOGIC_VECTOR (31 downto 0);
        ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
        Result : out STD_LOGIC_VECTOR (31 downto 0);
        Zero : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    signal signed_A : signed(31 downto 0);
    signal signed_B : signed(31 downto 0);
    signal temp_result : signed(31 downto 0);
begin
    signed_A <= signed(A);
    signed_B <= signed(B);

    process(signed_A, signed_B, ALUOp)
    begin
        case ALUOp is
            when "000" =>
                temp_result <= signed_A + signed_B;  -- ADD
            when "001" =>
                temp_result <= signed_A - signed_B;  -- SUB
            when others =>
                temp_result <= (others => '0');  -- Default case
        end case;
    end process;

    Result <= std_logic_vector(temp_result);  -- Assign internal result to output port

    process(temp_result)
    begin
        -- Set Zero flag
        if temp_result = 0 then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
    end process;

end Behavioral;
