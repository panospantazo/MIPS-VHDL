library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LeftShift_tb is
end LeftShift_tb;

architecture Behavioral of LeftShift_tb is
    signal data_in : STD_LOGIC_VECTOR(31 downto 0);
    signal data_out : STD_LOGIC_VECTOR(31 downto 0);

    component LeftShift
        Port ( data_in : in STD_LOGIC_VECTOR(31 downto 0);
               data_out : out STD_LOGIC_VECTOR(31 downto 0));
    end component;
begin
    UUT: LeftShift Port map(data_in => data_in, data_out => data_out);

    process
    begin
        -- 0x0FFFFFFF
        data_in <= x"0FFFFFFF";
        wait for 10 ps;

        wait;
    end process;
end Behavioral;


