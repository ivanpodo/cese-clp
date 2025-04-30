library IEEE;
use IEEE.std_logic_1164.all;

entity ffd is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        d_i   : in  std_logic;
        q_o   : out std_logic
    );
end entity;

architecture ffd_arq of ffd is
    signal q_reg : std_logic := '0';
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                q_reg <= '0';
            else
                q_reg <= d_i;
            end if;
        end if;
    end process;

    q_o <= q_reg;
end architecture;

-- Se reutilizó el FFD del ejercicio 5 pero se quitó el 'enable'