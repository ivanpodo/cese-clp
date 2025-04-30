library IEEE;
use IEEE.std_logic_1164.all;

entity reg4b is
	port(
		e_i   	: in std_logic;
		clk_i	: in std_logic;
		s_o	: out std_logic
	);
end;

architecture reg4b_arq of reg4b is
	-- Seccion declarativa
	component ffd is
		port(
			d_i   	: in std_logic;
			ena_i   : in std_logic;
			rst_i	: in std_logic;
			clk_i	: in std_logic;
			q_o	: out std_logic
		);
	end component;

	signal q_int : std_logic_vector(2 downto 0);
begin
    --Seccion descriptiva

	FFD0 : ffd 
		port map(
			d_i   	=> e_i,
			ena_i 	=> '1',
			rst_i 	=> '0',
			clk_i 	=> clk_i,
			q_o    	=> q_int(0)
		);

	FFD1 : ffd
		port map(
			d_i   	=> q_int(0), -- conecto a la salida del 'ffd' anterior
			ena_i 	=> '1',
			rst_i 	=> '0',
			clk_i 	=> clk_i,
			q_o    	=> q_int(1)
		);

	FFD2 : ffd
		port map(
			d_i   	=> q_int(1), -- conecto a la salida del 'ffd' anterior
			ena_i 	=> '1',
			rst_i 	=> '0',
			clk_i 	=> clk_i,
			q_o    	=> q_int(2)
		);
	
	FFD3 : ffd
		port map(
			d_i   	=> q_int(2), -- conecto a la salida del 'ffd' anterior
			ena_i 	=> '1',
			rst_i 	=> '0',
			clk_i 	=> clk_i,
			q_o    	=> s_o
		);
end;
