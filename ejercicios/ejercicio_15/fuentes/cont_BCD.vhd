library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity cont_BCD is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        q_o   : out std_logic_vector(3 downto 0) -- Cuenta de 0 a 9 (0000 a 1001)
    );
end entity;

architecture cont_BCD_arq of cont_BCD is
    signal count : std_logic_vector(3 downto 0) := (others => '0');
begin
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                count <= (others => '0');
            elsif ena_i = '1' then
                if count = "1001" then -- Si la cuenta es 9 (1001), reinicio
                    count <= (others => '0');
                else
                    count <= std_logic_vector(unsigned(count) + 1); -- Incremento de la cuenta
                end if;
            end if;
        end if;
    end process;

    q_o <= count; -- Salida de la cuenta BCD
end architecture;
