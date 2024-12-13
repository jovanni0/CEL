library IEEE;
    use IEEE.std_logic_1164.all;


entity aut6 is
    port(x, reset, clk: in std_logic;
        y: out std_logic);
end entity;


architecture arc_aut6 of aut6 is
    type state_type is (s1, s2, s3, s4, s5, s6);

    signal current_state: state_type := s2;
begin
    process(x, clk, reset)
    begin
        if reset = '1' then
            current_state <= s2;
            y <= '1'; -- 1 bistabil
        elsif falling_edge(clk) then
            case current_state is
                when s1 =>
                    if x = '0' then
                        current_state <= s2; -- 3 bistabil
                        y <= '1';
                    elsif x = '1' then
                        current_state <= s4;
                        y <= '1';
                    end if;
                when s2 =>
                    if x = '0' then
                        current_state <= s5;
                        y <= '0';
                    elsif x = '1' then
                        current_state <= s3;
                        y <= '0';
                    end if;
                when s3 =>
                    if x = '0' then
                        current_state <= s4;
                        y <= '1';
                    elsif x = '1' then
                        current_state <= s5;
                        y <= '0';
                    end if;
                when s4 =>
                    if x = '0' then
                        current_state <= s6;
                        y <= '0';
                    elsif x = '1' then
                        current_state <= s1;
                        y <= '1';
                    end if;
                when s5 =>
                    if x = '0' then
                        current_state <= s2;
                        y <= '1';
                    end if;
                when s6 =>
                    if x = '1' then
                        current_state <= s3;
                        y <= '1';
                    end if;
            end case;
        end if;
    end process;
end architecture;
-- total: 7 bistabile
------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_aut6 is
end entity;


architecture arc_tb_aut6 of tb_aut6 is
    component aut6 is
        port(x, reset, clk: in std_logic;
            y: out std_logic);
    end component;
    
    signal clk_tb, reset_tb, x_tb, y_tb: std_logic;
begin
    automat: aut6 port map(x => x_tb, reset => reset_tb, clk => clk_tb, y => y_tb);

    process
    begin
        reset_tb <= '1'; -- S2
        clk_tb <= '1';
        wait for 7ns;
        clk_tb <= '0';
        reset_tb <= '0';
        x_tb <= '1';
        wait for 7ns;

        clk_tb <= '1';
        wait for 7ns;
        clk_tb <= '0'; -- S3
        x_tb <= '0';
        wait for 7ns;

        clk_tb <= '1';
        wait for 7ns;
        clk_tb <= '0'; -- S4
        reset_tb <= '1'; -- S2
        wait;
    end process;
end architecture;