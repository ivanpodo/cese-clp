library IEEE;
use IEEE.std_logic_1164.all;

entity reg4b_comp is
	port(
		e_i   	: in std_logic;
		clk_i	: in std_logic;
		s_o		: out std_logic
	);
end;

architecture reg4b_comp_arq of reg4b_comp is
	-- Seccion declarativa
	signal reg : std_logic_vector(3 downto 0); -- memoria de 4 bits
begin
    --Seccion descriptiva

	process(clk_i)
	begin
		if rising_edge(clk_i) then
			reg(3 downto 1) <= reg(2 downto 0); -- Desplazamiento a la derecha
			reg(0) <= e_i;
		end if;
	end process;
	s_o <= reg(3); -- Salida del registro
end;