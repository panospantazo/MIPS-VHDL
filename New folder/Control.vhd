library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control is
    Port (
        opcode : in std_logic_vector(5 downto 0);
        RegDst : out std_logic;
        Branch : out std_logic;
        MemRead : out std_logic;
        MemtoReg : out std_logic;
        ALUOp : out std_logic_vector(1 downto 0);
        MemWrite : out std_logic;
        ALUSrc : out std_logic;
        RegWrite : out std_logic
    );
end Control;

architecture Behavioral of Control_Unit is
begin
    process(opcode)
    begin
        -- Default values for control signals
        RegDst <= '0';
        Branch <= '0';
        MemRead <= '0';
        MemtoReg <= '0';
        ALUOp <= "00";
        MemWrite <= '0';
        ALUSrc <= '0';
        RegWrite <= '0';
        
        case opcode is
            when "000000" => -- R-type instructions (add, sub)
                RegDst <= '1';
                ALUOp <= "10"; -- ALU Control will further decode the funct field
                RegWrite <= '1';
            when "100011" => -- lw (load word)
                ALUSrc <= '1';
                MemtoReg <= '1';
                RegWrite <= '1';
                MemRead <= '1';
            when "101011" => -- sw (store word)
                ALUSrc <= '1';
                MemWrite <= '1';
            when "000100" => -- beq (branch if equal)
                Branch <= '1';
                ALUOp <= "01"; -- ALU performs subtraction
            when "001000" => -- addi (add immediate)
                ALUSrc <= '1';
                RegWrite <= '1';
            when "000101" => -- bne (branch if not equal)
                Branch <= '1';
                ALUOp <= "01"; -- ALU performs subtraction
            when others =>
                -- Default case for unrecognized opcodes
                RegDst <= '0';
                Branch <= '0';
                MemRead <= '0';
                MemtoReg <= '0';
                ALUOp <= "00";
                MemWrite <= '0';
                ALUSrc <= '0';
                RegWrite <= '0';
        end case;
    end process;
end Behavioral;

