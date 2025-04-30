library IEEE;
use IEEE.std_logic_1164.all;

entity cont_4b is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        ena_i : in  std_logic;
        q_o   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture cont_4b_arq of cont_4b is

    component ffd is
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            d_i   : in  std_logic;
            q_o   : out std_logic
        );
    end component;

    signal d  : std_logic_vector(3 downto 0); -- entradas de los ffd
    signal q  : std_logic_vector(3 downto 0); -- salidas de los ffd

begin
    -- Lógica combinacional según el diagrama
    d(0) <= q(0) xor ena_i;
    d(1) <= q(1) xor (q(0) and ena_i);
    d(2) <= q(2) xor (q(1) and q(0) and ena_i);
    d(3) <= q(3) xor (q(2) and q(1) and q(0) and ena_i);

    -- Instanciación de los 4 ffd
    ffd0: ffd 
        port map(
            clk_i => clk_i, 
            rst_i => rst_i, 
            d_i => d(0), 
            q_o => q(0)
        );

    ffd1: ffd 
        port map(
            clk_i => clk_i, 
            rst_i => rst_i, 
            d_i => d(1), 
            q_o => q(1)
        );

    ffd2: ffd 
        port map(
            clk_i => clk_i, 
            rst_i => rst_i, 
            d_i => d(2), 
            q_o => q(2)
        );

    ffd3: ffd 
        port map(
            clk_i => clk_i, 
            rst_i => rst_i, 
            d_i => d(3), 
            q_o => q(3)
        );

    q_o <= q; -- Salida del contador

end architecture;
