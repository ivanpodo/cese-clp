library IEEE;
use IEEE.std_logic_1164.all;

entity cont_bcd_1s is
    port (
        clk_i : in  std_logic;
        rst_i : in  std_logic;
        q_o   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture cont_bcd_1s_arq of cont_bcd_1s is
    -- Declaración de componentes
    component gen_enable is
        generic (
            N: natural := 125000000
        );
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            ena_i : in  std_logic;
            q_o   : out std_logic
        );
    end component;

    component cont_bcd is
        port (
            clk_i : in  std_logic;
            rst_i : in  std_logic;
            ena_i : in  std_logic;
            q_o   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Señal interna
    signal ena_bcd : std_logic;

begin
    -- Instancia del generador de habilitación (1 Hz con clk de 125 MHz)
    gen_en: gen_enable
        generic map (
			-- Hay que colocar 125000000 para que el contador cuente 1 segundo (supongo clock de 125Mhz)
			-- Pongo 100 para simulación
            N => 100
        )
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => '1',     -- habilitado siempre
            q_o   => ena_bcd
        );

    -- Instancia del contador BCD
    bcd_cnt: cont_bcd
        port map (
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_bcd,
            q_o   => q_o
        );
end architecture;
