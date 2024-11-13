library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A32Mux2to1 is
    Port (
        A : in STD_LOGIC_VECTOR (31 downto 0);
        B : in STD_LOGIC_VECTOR (31 downto 0);
        sel : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR (31 downto 0)
    );
end A32Mux2to1;

architecture Behavioral of A32Mux2to1 is
begin
    process(A, B, sel)
    begin
        if sel = '0' then
            Y <= A;
        else
            Y <= B;
        end if;
    end process;
end Behavioral;