library IEEE;
use IEEE.std_logic_1164.all;

entity gen_enable_tb is
end entity;

architecture gen_enable_tb_arq of gen_enable_tb is
    -- Declaración del componente
    component gen_enable is
        generic (
            N: natural := 4
        );
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            ena_i : in  std_logic;
            q_o   : out std_logic
        );
    end component;

    -- Señales de prueba
    signal clk_i : std_logic := '0';
    signal rst_i : std_logic := '0';
    signal ena_i : std_logic := '0';
    signal q_o   : std_logic;

begin
    -- Instancia del DUT
    DUT: gen_enable
        generic map(
            N => 4
        )
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            q_o   => q_o
        );

    clk_i <= not clk_i after 10 ns; -- clk a 50 MHz

    -- Estímulos
    rst_i <= '1', '0' after 25 ns;    
    ena_i <= '0', '1' after 30 ns, '0' after 150 ns, '1' after 200 ns; 
end architecture;
