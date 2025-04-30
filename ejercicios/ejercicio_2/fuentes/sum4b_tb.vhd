library IEEE;
use IEEE.std_logic_1164.all;

entity sum4b_tb is
end;

architecture sum4b_tb_arg of sum4b_tb is
    -- Seccion declarativa
    component sum1b is
        port(
            a_i   	: in std_logic_vector(3 downto 0);
            b_i   	: in std_logic_vector(3 downto 0);
            ci_i  	: in std_logic;
            s_o		: out std_logic_vector(3 downto 0);
            co_o  	: out std_logic
        );
    end component;

    signal a_tb	    : std_logic_vector(3 downto 0) := "0000";
    signal b_tb	    : std_logic_vector(3 downto 0) := "0000";
    signal ci_tb	: std_logic := '0';
    signal s_tb     : std_logic_vector(3 downto 0);
    signal co_tb    : std_logic;

begin
    --Seccion descriptiva
    a_tb    <=  "1010" after 100 ns;
    b_tb    <=  "0101" after 200 ns;
    ci_tb   <=  '1' after 50 ns, '0' after 100 ns, '1' after 150 ns, '0' after 200 ns, '1' after 250 ns;

    DUT : entity work.sum4b 
        port map(
            a_i    => a_tb,
            b_i    => b_tb,
            ci_i   => ci_tb,
            s_o    => s_tb,
            co_o   => co_tb
        );

end;