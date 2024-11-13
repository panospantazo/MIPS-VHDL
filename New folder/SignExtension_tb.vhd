library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SignExtension_tb is
end SignExtension_tb;

architecture Behavioral of SignExtension_tb is
    signal inst : STD_LOGIC_VECTOR(15 downto 0);
    signal data : STD_LOGIC_VECTOR(31 downto 0);

    component SignExtension
        Port ( inst : in STD_LOGIC_VECTOR(15 downto 0);
               data : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
begin
    UUT: SignExtension Port map(inst => inst, data => data);

    process
    begin
        -- 0xFFFF
        inst <= "1111111111111111";
        wait for 10 ps;

        -- 0xAAAA
        inst <= "1010101010101010";
        wait for 10 ps;

        -- 0x5555
        inst <= "0101010101010101";
        wait for 10 ps;

        wait;
    end process;
end Behavioral;


