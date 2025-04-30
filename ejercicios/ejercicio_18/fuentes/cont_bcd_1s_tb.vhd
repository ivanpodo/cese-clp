library IEEE;
use IEEE.std_logic_1164.all;

entity cont_bcd_1s_tb is
end entity;

architecture cont_bcd_1s_tb_arq of cont_bcd_1s_tb is
    -- Declaración del componente tope
    component cont_bcd_1s is
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            q_o   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Señales internas
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '1';
    signal q_o   : std_logic_vector(3 downto 0);

begin
    -- Instancia del DUT
    DUT: cont_bcd_1s
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            q_o   => q_o
        );

    clk_i <= not clk_i after 4 ns; -- clk a 125 Mhz (8ns de período)
    rst_i <= '1', '0' after 20 ns;

end architecture;
