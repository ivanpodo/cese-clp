library IEEE;
use IEEE.std_logic_1164.all;

entity sum4b is
	port(
		a_i   	: in std_logic_vector(3 downto 0);
		b_i   	: in std_logic_vector(3 downto 0);
		ci_i  	: in std_logic;
		s_o		: out std_logic_vector(3 downto 0);
		co_o  	: out std_logic
	);
end;

architecture sum4b_arq of sum4b is
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

begin
    --Seccion descriptiva
		S0 : sum1b 
			port map(
				a_i   	=> a_i(0),
				b_i 	=> b_i(0),
				ci_i	=> ci_i,
				s_o 	=> s_o(0),
				co_o	=> ci_aux(0)
			);

		S1 : sum1b
			port map(
				a_i   	=> a_i(1),
				b_i 	=> b_i(1),
				ci_i	=> ci_aux(0), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(1),
				co_o	=> ci_aux(1)
			);

		S2 : sum1b
			port map(
				a_i   	=> a_i(2),
				b_i 	=> b_i(2),
				ci_i	=> ci_aux(1), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(2),
				co_o	=> ci_aux(2)
			);

		S3 : sum1b
			port map(
				a_i   	=> a_i(3),
				b_i 	=> b_i(3),
				ci_i	=> ci_aux(2), -- lo conecto al co del sum1b anterior
				s_o 	=> s_o(3),
				co_o	=> co_o
			);
end;