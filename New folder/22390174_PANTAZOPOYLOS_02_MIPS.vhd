library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MIPS is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC);
end MIPS;

architecture Behavioral of MIPS is

    -- Declare internal signals
    signal PC_reg, nextPC, PC_plus1, branchAddr, jumpAddr : STD_LOGIC_VECTOR(31 downto 0);
    signal instruction : STD_LOGIC_VECTOR(31 downto 0);
    signal readData1, readData2, writeData, ALUResult, signExtended, shiftedSignExtended : STD_LOGIC_VECTOR(31 downto 0);
    signal zero : STD_LOGIC;
    signal RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, Jump : STD_LOGIC;
    signal ALUOp : STD_LOGIC_VECTOR(1 downto 0);
    signal ALUControlOut : STD_LOGIC_VECTOR(2 downto 0);
    signal muxOut : STD_LOGIC_VECTOR(4 downto 0);  -- 5-bit wide for RegisterFile
    signal muxOut_32bit : STD_LOGIC_VECTOR(31 downto 0);
    signal PCSrc : STD_LOGIC;

    -- Instantiate components
    component PC
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               PC_in : in STD_LOGIC_VECTOR(31 downto 0);
               PC_out : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component IMem
        Port ( Address : in STD_LOGIC_VECTOR(3 downto 0);
               ReadData : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component Control_Unit
        Port ( opcode : in std_logic_vector(5 downto 0);
               RegDst : out std_logic;
               Branch : out std_logic;
               MemRead : out std_logic;
               MemtoReg : out std_logic;
               ALUOp : out std_logic_vector(1 downto 0);
               MemWrite : out std_logic;
               ALUSrc : out std_logic;
               RegWrite : out std_logic);
    end component;

    component RegisterFile
        Port ( clk : in STD_LOGIC;
               ReadReg1, ReadReg2, WriteReg : in STD_LOGIC_VECTOR(3 downto 0);
               WriteData : in STD_LOGIC_VECTOR(31 downto 0);
               RegWrite : in STD_LOGIC;
               ReadData1, ReadData2 : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component SignExtension
        Port ( inst : in STD_LOGIC_VECTOR(15 downto 0);
               data : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component ALUControl
        Port ( funct : in STD_LOGIC_VECTOR(5 downto 0);
               ALUOp : in STD_LOGIC_VECTOR(1 downto 0);
               ALUControlOut : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    component ALU
        Port ( A : in STD_LOGIC_VECTOR(31 downto 0);
               B : in STD_LOGIC_VECTOR(31 downto 0);
               ALUOp : in STD_LOGIC_VECTOR(2 downto 0);
               Result : out STD_LOGIC_VECTOR(31 downto 0);
               Zero : out STD_LOGIC);
    end component;

    component DataMem
        Port ( Address : in STD_LOGIC_VECTOR(3 downto 0);
               WriteData : in STD_LOGIC_VECTOR(31 downto 0);
               MemWrite, MemRead : in STD_LOGIC;
               ReadData : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component B5Mux2to1
        Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
               B : in STD_LOGIC_VECTOR (4 downto 0);
               sel : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (4 downto 0));
    end component;

    component B32Mux2to1
        Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
               B : in STD_LOGIC_VECTOR (31 downto 0);
               sel : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component LeftShift
        Port ( data_in : in STD_LOGIC_VECTOR (31 downto 0);
               data_out : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

    component Adder32
        Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
               B : in STD_LOGIC_VECTOR (31 downto 0);
               Sum : out STD_LOGIC_VECTOR (31 downto 0));
    end component;

begin
    -- Instantiate Program Counter (PC)
    u1: PC port map(clk => clk, reset => reset, PC_in => nextPC, PC_out => PC_reg);

    -- Instantiate Instruction Memory
    u2: IMem port map(Address => PC_reg(3 downto 0), ReadData => instruction);

    -- Instantiate Control Unit
    u3: Control_Unit port map(opcode => instruction(31 downto 26), RegDst => RegDst, ALUSrc => ALUSrc, MemtoReg => MemtoReg, RegWrite => RegWrite, MemRead => MemRead, MemWrite => MemWrite, Branch => Branch, ALUOp => ALUOp);

    -- Instantiate Register File
    u4: RegisterFile port map(
            clk => clk,
            ReadReg1 => instruction(25 downto 22),  -- Use lower 4 bits for register addresses
            ReadReg2 => instruction(21 downto 18),  -- Use lower 4 bits for register addresses
            WriteReg => muxOut(3 downto 0),         -- Ensure correct bit-width
            WriteData => writeData,
            RegWrite => RegWrite,
            ReadData1 => readData1,
            ReadData2 => readData2
        );

    -- Instantiate Sign Extension
    u5: SignExtension port map(inst => instruction(15 downto 0), data => signExtended);

    -- Instantiate ALU Control Unit
    u6: ALUControl port map(funct => instruction(5 downto 0), ALUOp => ALUOp, ALUControlOut => ALUControlOut);

    -- Instantiate ALU
    u7: ALU port map(A => readData1, B => muxOut_32bit, ALUOp => ALUControlOut, Result => ALUResult, Zero => zero);

    -- Instantiate Data Memory
    u8: DataMem port map(Address => ALUResult(3 downto 0), WriteData => readData2, MemWrite => MemWrite, MemRead => MemRead, ReadData => writeData);

    -- Instantiate 5-bit 2-to-1 Multiplexer
    u9: B5Mux2to1 port map(A => instruction(20 downto 16), B => instruction(15 downto 11), sel => RegDst, Y => muxOut);

    -- Instantiate 32-bit 2-to-1 Multiplexer (ALU Source)
    u10: B32Mux2to1 port map(A => readData2, B => signExtended, sel => ALUSrc, Y => muxOut_32bit);

    -- Instantiate Left Shift 2 Unit
    u11: LeftShift port map(data_in => signExtended, data_out => shiftedSignExtended);

    -- Instantiate Adder32 for PC+1
    u12: Adder32 port map(A => PC_reg, B => x"00000001", Sum => PC_plus1);

    -- Instantiate Adder32 for Branch Address
    u13: Adder32 port map(A => PC_plus1, B => shiftedSignExtended, Sum => branchAddr);

    -- Compute next PC address based on branch and jump logic
    PCSrc <= Branch and zero;

    -- Select next PC value
    process (PC_plus1, branchAddr, PCSrc)
    begin
        if PCSrc = '1' then
            nextPC <= branchAddr;
        else
            nextPC <= PC_plus1;
        end if;
    end process;

end Behavioral;