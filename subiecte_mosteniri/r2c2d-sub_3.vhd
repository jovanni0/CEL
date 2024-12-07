library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity tug is
    port(bar: in std_logic_vector(8 downto 0);
        clk: in std_logic;
        stei: out std_logic_vector(8 downto 0);
        imp: out std_logic);
end entity;


architecture arc_tug of tug is
    type state_type is (state_1, state_2, state_3);

    signal current_state: state_type := state_1;
    signal timespan: std_logic_vector(6 downto 0) := 0b;
    signal position: std_logic_vector(6 downto 0) := 10b;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case current_state is
                when state_1 =>
                    if timespan < 100 then
                        timespan <= timespan + 10b;
                    else
                        current_state <= state_2;
                        position <= 70b;
                        timespan <= 0b;
                    end if;
                when state_2 =>
                    if position < 270 then
                        position <= position + 5b; -- 10 * 0.5
                    else
                        current_state <= state_3;
                        position <= 250b;
                    end if;
                when state_3 =>
                    if position > 10 then
                        position <= position - 1b;
                    else
                        current_state <= state_3;
                    end of;
            end case;

            stei <= position;
            if current_state = state_2 then
                imp <= '0';
            else
                imp <= '1';
            end if;
        end if;
    end process;
end architecture;

----------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_tug is
end entity;


architecture arc_tb_tug of tb_tug is
    component tug is
        port(bar: in std_logic_vector(8 downto 0);
            clk: in std_logic;
            stei: out std_logic_vector(8 downto 0);
            imp: out std_logic);
    end component;

    signal bar_tb, stei_tb: std_logic_vector(8 downto 0);
    signal clk_tb, imp_tb: std_logic := 1b;
begin
    generator: tug port map(bar => bar_tb, clk => clk_tb, stei => stei_tb, imp => imp_tb);

    clk_tb <= not clk_tb after 10us;
    bar_tb <= 120b;
end architecture;