library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity barrel_shifter_tb is
end;

architecture barrel_shifter_tb_arq of barrel_shifter_tb is
    -- Sección declarativa
    component barrel_shifter is
        generic (
            N : natural := 8;  -- Ancho del vector
            M : natural := 3   -- Ancho del desplazamiento (log2(N))
        );
        port (
            a_i   : in  std_logic_vector(N-1 downto 0);
            des_i : in  std_logic_vector(M-1 downto 0);
            s_o   : out std_logic_vector(N-1 downto 0)
        );
    end component;

    -- Parámetros
    constant N : natural := 8;
    constant M : natural := 3;

    -- Señales para conectar al DUT
    signal a_tb   : std_logic_vector(N-1 downto 0);
    signal des_tb : std_logic_vector(M-1 downto 0);
    signal s_tb   : std_logic_vector(N-1 downto 0);

begin
    -- Instancia del DUT
    DUT : barrel_shifter
        generic map (
            N => N,
            M => M
        )
        port map (
            a_i   => a_tb,
            des_i => des_tb,
            s_o   => s_tb
        );
    
    -- Proceso de testbench
    a_tb <= "10101010";
    des_tb <= "000" after 10 ns, "001" after 20 ns, "010" after 30 ns,
              "011" after 40 ns, "100" after 50 ns, "101" after 60 ns,
              "110" after 70 ns, "111" after 80 ns;
end architecture;
