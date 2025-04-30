library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pwm is
    generic(
        N_BITS   : natural := 12        -- número de bits del contador
    );
    port(
        clk_i      : in  std_logic;     -- 1 MHz
        rst_i      : in  std_logic;     -- reset síncronico
        load_cfg_i : in  std_logic;     -- pulso de carga de nuevos parámetros
        period_i   : in  std_logic_vector(N_BITS-1 downto 0); -- valor de periodo
        duty_i     : in  std_logic_vector(N_BITS-1 downto 0); -- valor de duty
        pwm_out    : out std_logic
    );
end entity;

architecture pwm_arq of pwm is
    signal period_reg : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal duty_reg   : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal counter    : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal pwm_q      : std_logic := '0';

begin
    process(clk_i)

    begin
        if rising_edge(clk_i) then
            -- reset síncronico
            if rst_i = '1' then 
                period_reg <= (others => '0');
                duty_reg   <= (others => '0');
                counter    <= (others => '0');
                pwm_q      <= '0';
            else
                -- Carga atómica de nuevos parámetros
                if load_cfg_i = '1' then
                    period_reg <= period_i;
                    duty_reg   <= duty_i;
                end if;

                -- Contador base‑tiempo
                if unsigned(counter) = unsigned(period_reg) then
                    counter <= (others => '0'); -- reinicio del contador
                else
                    counter <= std_logic_vector(unsigned(counter) + 1); -- incremento
                end if;

                -- Generación de PWM
                if unsigned(counter) < unsigned(duty_reg) then
                    pwm_q <= '1';
                else
                    pwm_q <= '0';
                end if;
            end if;
        end if;
    end process;

    pwm_out <= pwm_q; -- salida PWM
end architecture;
