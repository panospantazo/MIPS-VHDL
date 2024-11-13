library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Control_tb is
end Control_tb;

architecture Behavioral of Control_tb is

    -- Component declaration for the Control Unit
    component Control
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
    end component;

    -- Testbench signals
    signal opcode : std_logic_vector(5 downto 0) := (others => '0');
    signal RegDst : std_logic;
    signal Branch : std_logic;
    signal MemRead : std_logic;
    signal MemtoReg : std_logic;
    signal ALUOp : std_logic_vector(1 downto 0);
    signal MemWrite : std_logic;
    signal ALUSrc : std_logic;
    signal RegWrite : std_logic;

begin
    uut: Control
        Port map (
            opcode => opcode,
            RegDst => RegDst,
            Branch => Branch,
            MemRead => MemRead,
            MemtoReg => MemtoReg,
            ALUOp => ALUOp,
            MemWrite => MemWrite,
            ALUSrc => ALUSrc,
            RegWrite => RegWrite
        );

    -- Test process
    process
    begin
        -- Test case for addi $0, $0, 0
        opcode <= "001000"; -- opcode for addi
        wait for 10 ps;
        assert (ALUSrc = '1' and RegWrite = '1' and RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and ALUOp = "00" and MemWrite = '0') 
        report "Test case for addi failed" severity error;
        report "addi $0, $0, 0 test passed" severity note;

        -- Test case for sw $6, 0($4)
        opcode <= "101011"; -- opcode for sw
        wait for 10 ps;
        assert (ALUSrc = '1' and MemWrite = '1' and RegDst = '0' and Branch = '0' and MemRead = '0' and MemtoReg = '0' and ALUOp = "00" and RegWrite = '0')
        report "Test case for sw failed" severity error;
        report "sw $6, 0($4) test passed" severity note;

        -- Test case for bne $5, $0, L1
        opcode <= "000101"; -- opcode for bne
        wait for 10 ps;
        assert (Branch = '1' and ALUOp = "01" and ALUSrc = '0' and RegWrite = '0' and RegDst = '0' and MemRead = '0' and MemtoReg = '0' and MemWrite = '0')
        report "Test case for bne failed" severity error;
        report "bne $5, $0, L1 test passed" severity note;

        wait;
    end process;
end behavioral;

