library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity A5Mux2to1 is 
    Port (
        A : in STD_LOGIC_VECTOR (4 downto 0);
        B : in STD_LOGIC_VECTOR (4 downto 0);
        sel : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR (4 downto 0)
    );
end A5Mux2to1;

architecture Behavioral of A5Mux2to1 is
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