library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity barrel_shifter is
    generic (
        N : natural := 8;  -- Ancho del vector
        M : natural := 3   -- Ancho del desplazamiento (log2(N))
    );
    port (
        a_i   : in  std_logic_vector(N-1 downto 0);
        des_i : in  std_logic_vector(M-1 downto 0);
        s_o   : out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture barrel_shifter_arq of barrel_shifter is
begin
    process(a_i, des_i)
        variable des_int : natural;
    begin
        des_int := to_integer(unsigned(des_i));
        case des_int is
            when 0 => s_o <= a_i;
            when 1 => s_o <= a_i(N-2 downto 0) & '0';
            when 2 => s_o <= a_i(N-3 downto 0) & "00";
            when 3 => s_o <= a_i(N-4 downto 0) & "000";
            when 4 => s_o <= a_i(N-5 downto 0) & "0000";
            when 5 => s_o <= a_i(N-6 downto 0) & "00000";
            when 6 => s_o <= a_i(N-7 downto 0) & "000000";
            when 7 => s_o <= (others => '0');
            when others => s_o <= (others => '0');
        end case;
    end process;
end architecture;
