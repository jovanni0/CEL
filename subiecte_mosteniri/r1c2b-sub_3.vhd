library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity pol is
    port(nivel: in std_logic_vector(7 downto 0);
        clk, reset: in std_logic;
        dv: out std_logic_vector(7 downto 0);
        pwm: out std_logic);
end entity;


architecture arc_pol of pol is
    type state_type is (state_1, state_2, state_3);

    signal current_state: state_type;
    signal value: std_logic_vector(7 downto 0) := "00000000";
    signal timespan: std_logic_vector(6 downto 0) := "0000000";
begin
    process(clk, reset)
    begin
        if falling_edge(clk) then
            if reset = '0' then
                value <= 210b;
                current_state <= state_1;
            else
                case current_state is
                    when state_1 =>
                        if value > 10b then
                            value <= value - '1';
                        else
                            value <= "00111100";
                            current_state <= state_2;
                        end if;

                    when state_2 =>
                        if timespan < 100b then
                            timespan <= timespan + '1';
                        else
                            timespan <= "0000000";
                            value <= "01101110";
                            current_state <= state_3;
                        end if;

                    when state_3 =>
                        if value < 210b then
                            value <= value + '1';
                        else
                            current_state <= state_1;
                        end if;
                end case;
            end if;
        end if;

        dv <= value;
        if nivel = value then
            if current_state = state_1 then
                pwm <= '1';
            elsif current_state = state_3 then
                pwm <= '0';
            end if;
        end if;
    end process;

    process(clk, reset)
    begin
        if falling_edge(clk) then
            if reset = '0' then
                pwm <= '0';
                value <= 210b;
                current_state <= state_1;
            else
                case current_state is
                    when state_1 =>
                        value <= value - '1';
                        if value = nivel then
                            pwm <= '1';
                        elsif value = 10b then
                            value <= 60b;
                            current_state <= state_2;
                        end if;

                    when state_2 =>
                        timespan <= timespan + '1';
                        if timespan = 100b then
                            timespan <= "0000000";
                            value <= "01101110";
                            current_state <= state_3;
                        end if;

                    when state_3 =>
                        value <= value + '1';
                        if value = nivel then
                            pwm <= '0';
                        elsif value = 210b then
                            current_state <= state_1;
                        end if;
                end case;
            end if;
        end if;

        dv <= value;
    end process;
end architecture;