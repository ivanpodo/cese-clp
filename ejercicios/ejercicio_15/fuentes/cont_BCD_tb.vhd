library IEEE;
use IEEE.std_logic_1164.all;

entity cont_BCD_tb is
end entity;

architecture cont_BCD_tb_arq of cont_BCD_tb is
    -- Declaración del componente
    component cont_BCD is
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            ena_i : in  std_logic;
            q_o   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Señales de prueba
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal ena_i : std_logic := '0';
    signal q_o   : std_logic_vector(3 downto 0);

begin
    -- Instancia del DUT
    DUT: cont_BCD
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            q_o   => q_o
        );

    clk_i <= not clk_i after 10 ns; -- clk de 50 MHz

    -- Estímulos
    rst_i <= '1', '0' after 25 ns;                     -- Reset inicial por 25 ns
    ena_i <= '0', '1' after 30 ns, '0' after 100 ns, '1' after 150 ns;                     -- Enable activo después del reset

end architecture;
