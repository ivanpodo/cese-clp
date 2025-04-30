----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2025 09:01:46 PM
-- Design Name: 
-- Module Name: top_level - top_level_arq
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_level is
--  Port ( );
    port(
        clk_i: in std_logic
    );
end top_level;

architecture top_level_arq of top_level is

component pwm is
    generic(
        N_BITS   : natural := 12        -- número de bits del contador
    );
    port(
        clk_i      : in  std_logic;     -- clock
        rst_i      : in  std_logic;     -- reset síncronico
        load_cfg_i : in  std_logic;     -- pulso de carga de nuevos parámetros
        period_i   : in  std_logic_vector(N_BITS-1 downto 0); -- valor de período
        duty_i     : in  std_logic_vector(N_BITS-1 downto 0); -- valor de duty
        pwm_out    : out std_logic
    );
end component;

component vio_0
  port (
    clk         : in std_logic;
    probe_in0   : in std_logic_vector(0 downto 0);
    probe_out0  : out std_logic_vector(11 downto 0);
    probe_out1  : out std_logic_vector(11 downto 0);
    probe_out2  : out std_logic_vector(0 downto 0);
    probe_out3  : out std_logic_vector(0 downto 0)
  );
end component;

-- component ila_0
--     port (
--         clk : in std_logic;
--         probe0 : in std_logic_vector(0 DOWNTO 0)
--     );
-- end component;

signal probe_duty   : std_logic_vector(11 downto 0);
signal probe_period : std_logic_vector(11 downto 0);
signal probe_load   : std_logic_vector(0 downto 0);
signal probe_pwm    : std_logic_vector(0 downto 0);
signal probe_reset  : std_logic_vector(0 downto 0);

begin
    -- Instancia del VIO
    vio_inst : vio_0
        port map (
            clk         => clk_i,
            probe_in0   => probe_pwm,
            probe_out0  => probe_duty,
            probe_out1  => probe_period,
            probe_out2  => probe_load,
            probe_out3  => probe_reset
        );
        
    -- Instancia del ILA
--     ila_inst : ila_0
--         port map (
--             clk   => clk_i,
--             probe0 => probe_pwm
--         );

    -- Instancia del DUT
    pwm_inst : pwm
        generic map(
            N_BITS  => 12
        )
        port map(
            clk_i      => clk_i,
            rst_i      => probe_reset(0),
            load_cfg_i => probe_load(0),
            period_i   => probe_period,
            duty_i     => probe_duty,
            pwm_out    => probe_pwm(0)
        );

end top_level_arq;
