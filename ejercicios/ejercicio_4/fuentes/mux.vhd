library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
	port(
		a_i   	: in std_logic;
		b_i   	: in std_logic;
		sel_i  	: in std_logic;
		s_o		: out std_logic
	);
end;

architecture mux_arq of mux is
	-- Seccion declarativa

begin
    --Seccion descriptiva
	s_o <= (a_i and not sel_i) or (b_i and sel_i); -- sel = 0 -> a_i, sel = 1 -> b_i
end;