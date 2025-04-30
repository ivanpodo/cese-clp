library IEEE;
use IEEE.std_logic_1164.all;

entity mux_tb is
end;

architecture mux_tb_arg of mux_tb is
    -- Seccion declarativa
    component mux is
        port(
            a_i   	: in std_logic;
            b_i   	: in std_logic;
            sel_i  	: in std_logic;
            s_o		: out std_logic
        );
    end component;

    signal  a_tb : std_logic := '0';
    signal  b_tb : std_logic := '0';
    signal  sel_tb : std_logic := '0';
    signal  s_tb : std_logic;

begin
    --Seccion descriptiva
    a_tb    <=  not a_tb after 60 ns;
    b_tb    <=  not b_tb after 120 ns;
    sel_tb  <=  not sel_tb after 25 ns;

    DUT : mux 
        port map(
            a_i    => a_tb,
            b_i    => b_tb,
            sel_i  => sel_tb,
            s_o    => s_tb
        );
end;