library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont_4b_comp is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        q_o   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture cont_4b_comp_arq of cont_4b_comp is
    signal count : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                count <= (others => '0');
            elsif ena_i = '1' then
                count <= std_logic_vector(unsigned(count) + 1);
            end if;
        end if;
    end process;

    q_o <= count; -- Salida del contador
end architecture;
