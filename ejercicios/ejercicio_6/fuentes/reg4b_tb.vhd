library IEEE;
use IEEE.std_logic_1164.all;

entity reg4b_tb is
end;

architecture reg4b_tb_arg of reg4b_tb is
    -- Seccion declarativa
    component reg4b is
        port(
            e_i   	: in std_logic;
            clk_i	: in std_logic;
            s_o		: out std_logic
        );
    end component;

    signal e_tb	    : std_logic := '0';
    signal clk_tb	: std_logic := '0';
    signal s_tb     : std_logic;

begin
    --Seccion descriptiva
    e_tb    <=  '1' after 50 ns, '0' after 100 ns, '1' after 120 ns, '0' after 140 ns;
    clk_tb  <=  not clk_tb after 10 ns;

    DUT : reg4b 
        port map(
            e_i    => e_tb,
            clk_i  => clk_tb,
            s_o    => s_tb
        );
end;