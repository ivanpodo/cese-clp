library IEEE;
use IEEE.std_logic_1164.all;

entity ffd_tb is
end;

architecture ffd_tb_arg of ffd_tb is
    -- Seccion declarativa
    component ffd is
        port(
            d_i   	: in std_logic;
            ena_i   : in std_logic;
            rst_i	: in std_logic;
            clk_i	: in std_logic;
            q_o		: out std_logic
        );
    end component;

    signal d_tb	    : std_logic := '0';
    signal ena_tb	: std_logic := '0';
    signal rst_tb	: std_logic := '0';
    signal clk_tb	: std_logic := '0';
    signal q_tb     : std_logic;

begin
    --Seccion descriptiva
    d_tb    <=  '1' after 100 ns;
    ena_tb  <=  '1' after 50 ns, '0' after 100 ns, '1' after 150 ns;
    rst_tb  <=  '1' after 30 ns, '0' after 60 ns, '1' after 150 ns, '0' after 200 ns, '1' after 250 ns;
    clk_tb  <=  not clk_tb after 10 ns;

    DUT : ffd 
        port map(
            d_i    => d_tb,
            ena_i  => ena_tb,
            rst_i  => rst_tb,
            clk_i  => clk_tb,
            q_o    => q_tb
        );
end;