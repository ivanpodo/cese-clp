library IEEE;
use IEEE.std_logic_1164.all;

entity sumRest4 is
	port(
		a_i   	: in std_logic_vector(3 downto 0);
		b_i   	: in std_logic_vector(3 downto 0);
		sr_i  	: in std_logic; --suma/resta: 0 suma, 1 resta
		s_o		: out std_logic_vector(3 downto 0);
		co_o  	: out std_logic
	);
end;

architecture sumRest4_arq of sumRest4 is
	-- Seccion declarativa
	component sum1b is
		port(
			a_i   	: in std_logic;
			b_i   	: in std_logic;
			ci_i  	: in std_logic;
			s_o		: out std_logic;
			co_o  	: out std_logic
		);
	end component;

	signal ci_aux	: std_logic_vector(2 downto 0);
	signal b_xor	: std_logic_vector(3 downto 0); -- b_i complementado

begin
    --Seccion descriptiva
	-- Fue necesario hacer b_xor porque no se pueden hacer declaraciones de señales dentro de 
	-- 'port map'. (ej: b_i => b_i(0) xor sr_i en el port map de sum1b)
	b_xor(0) <= b_i(0) xor sr_i; -- si es resta, b_i se complementa
	b_xor(1) <= b_i(1) xor sr_i;
	b_xor(2) <= b_i(2) xor sr_i;
	b_xor(3) <= b_i(3) xor sr_i;

		S0 : sum1b 
			port map(
				a_i   	=> a_i(0),
				b_i 	=> b_xor(0), -- si es resta, b_i se complementa
				ci_i	=> sr_i,
				s_o 	=> s_o(0),
				co_o	=> ci_aux(0)
			);

		S1 : sum1b
			port map(
				a_i   	=> a_i(1),
				b_i 	=> b_xor(1), -- si es resta, b_i se complementa
				ci_i	=> ci_aux(0), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(1),
				co_o	=> ci_aux(1)
			);

		S2 : sum1b
			port map(
				a_i   	=> a_i(2),
				b_i 	=> b_xor(2), -- si es resta, b_i se complementa
				ci_i	=> ci_aux(1), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(2),
				co_o	=> ci_aux(2)
			);

		S3 : sum1b
			port map(
				a_i   	=> a_i(3),
				b_i 	=> b_xor(3), -- si es resta, b_i se complementa
				ci_i	=> ci_aux(2), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(3),
				co_o	=> co_o
			);
end;