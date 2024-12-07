library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity clop is
    port(line: in std_logic_vector(8 downto 0);
        clk: in std_logic;
        trap: out std_logic_vector(8 downto 0);
        puls: out std_logic);
end entity;


architecture arc_clop of clop is
    type state_type is (state_1, state_2, state_3);

    signal current_state: state_type := state_1;
    signal trap_value: std_logic_vector(8 downto 0) := 60b;;
    signal time_span: std_logic_vector(8 downto 0) := 0b;
begin
    process(clk)
    begin
        if reset = '1' then
            trap_value <= std_logic_vector(60);
        elsif rising_edge(clk) then
            case current_state is
                when state_1 => ----------------------- starea 1
                    if trap_value < 260b then
                        trap_value = trap_value + 1b;
                    else
                        trap_value <= 230b;
                        current_state <= state_2;
                    end if;
                when state_2 => ---------------------- starea 2
                    if time_span < 400b then
                        time_span = time_span + 10b;
                    else
                        trap_value <= 260b;
                        time_span <= 0b;
                        current_state <= state_3;
                    end if;
                when state_3 => ---------------------- starea 3
                    if trap_value > 160b then
                        trap_value <= trap_value - 1b;
                    else
                        trap_value <= 60b;
                        current_state <= state_1;
                    end if;
            end case;
        end if;

        trap <= trap_value;
        if trap_value = line then
            puls <= '1';
        else
            puls <= '0';
        end if;
    end process;
end architecture;

------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_clop is
end entity;


architecture arc_tb_clop of tb_clop is
    component clop is
        port(line: in std_logic_vector(8 downto 0);
            clk: in std_logic;
            trap: out std_logic_vector(8 downto 0);
            puls: out std_logic);
    end component;

    signal clk_tb, puls: std_logic := '1';
    signal line_tb, trap_tb: std_logic_vector(8 downto 0) := 0b;
begin
    generator: clop port map(clk => clk_tb, line => line_tb, trap => trap_tb, puls => puls_tb);

    clk_tb <= not clk_tb after 10ns;
    line_tb <= 120b;
end architecture;