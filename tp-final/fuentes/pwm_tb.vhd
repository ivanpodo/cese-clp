library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm_tb is
end entity;

architecture pwm_tb_arq of pwm_tb is

    -- Ancho de contador
    constant N_BITS : natural := 12;
    -- Periodo de clock de 1 MHz → Tclk = 1 µs
    constant CLK_PER : time := 1 us;

    -- Señales de estímulo (_tb)
    signal clk_tb      : std_logic := '0';
    signal rst_tb      : std_logic := '1';
    signal load_cfg_tb : std_logic := '0';
    signal period_tb   : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal duty_tb     : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal pwm_out_tb    : std_logic;

    -- Declaración de COMPONENT pwm
    component pwm is
        generic(
            N_BITS   : natural := 12
        );
        port(
            clk_i      : in  std_logic;
            rst_i      : in  std_logic;
            load_cfg_i : in  std_logic;
            period_i   : in  std_logic_vector(N_BITS-1 downto 0);
            duty_i     : in  std_logic_vector(N_BITS-1 downto 0);
            pwm_out    : out std_logic
        );
    end component;

    -- Tiempo equivalente a 5 períodos a PER=4095: 5 × (4095+1) × 1 µs = 20.48 ms
    constant FIVE_PERIODS  : time := 20480 us;
    constant THREE_PERIODS : time := 12280 us;
    constant ONE_PERIOD    : time := 4096 us;

begin

    -- Generador de reloj 1 MHz
    clk_tb <= not clk_tb after CLK_PER/2;

    -- Instancia del DUT
    DUT: pwm
        generic map ( N_BITS => N_BITS )
        port map (
            clk_i      => clk_tb,
            rst_i      => rst_tb,
            load_cfg_i => load_cfg_tb,
            period_i   => period_tb,
            duty_i     => duty_tb,
            pwm_out    => pwm_out_tb
        );

    -- Proceso de estímulos
    stim_tb: process
        -- Procedimiento auxiliar para cargar configuración
        procedure load_config_tb (
            constant per_val  : in integer;
            constant duty_val : in integer) is
        begin
            period_tb   <= std_logic_vector(to_unsigned(per_val, N_BITS));
            duty_tb     <= std_logic_vector(to_unsigned(duty_val, N_BITS));
            load_cfg_tb <= '1';
            wait until rising_edge(clk_tb);
            load_cfg_tb <= '0';
        end procedure;

    begin
        -- Reset durante 100 ns
        wait for 100 ns;
        rst_tb <= '0';
        wait for CLK_PER;

        -- Configuración inicial: PER=4095 → fPWM≈244 Hz (~200 Hz), DUTY=0 %
        load_config_tb(per_val => 4095, duty_val => 0);

        -- Espera 1 periodo antes de cambiar duty
        wait for ONE_PERIOD;
        
        -- 25 %
        load_config_tb(per_val => 4095, duty_val => 1024);
        wait for THREE_PERIODS;

        -- 50 %
        load_config_tb(per_val => 4095, duty_val => 2048);
        wait for THREE_PERIODS;

        -- 75 %
        load_config_tb(per_val => 4095, duty_val => 3072);
        wait for FIVE_PERIODS;

        -- 50 %
        load_config_tb(per_val => 4095, duty_val => 2048);
        wait for THREE_PERIODS;

        -- 25 %
        load_config_tb(per_val => 4095, duty_val => 1024);
        wait for THREE_PERIODS;
        
        -- 0 %
        load_config_tb(per_val => 4095, duty_val => 0);
        wait for FIVE_PERIODS;
        -- Fin de simulación
        assert false report "Fin de simulación" severity failure;
    end process stim_tb;

end architecture;
