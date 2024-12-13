library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity gro is
    port(comp: in std_logic_vector(8 downto 0);
        clk, rst: in std_logic;
        var: out std_logic_vector(8 downto 0);
        mod: out std_logic);
end entity;


architecture arc_gro of gro is
    type state_type is (state_1, state_2, state_3);

    signal value: std_logic_vector(8 downto 0) := 350b;
    signal timespan: std_logic_vector(6 downto 0) := 0b;
    signal current_state: state_type := state_1;
begin
    process(clk)
    begin
        if falling_edge(clk) then
            if rst = '1' then
                value <= 350b; -- 9 bistabile
                timespan <= 0b; -- 7 bistabile
                current_state <= state_1; -- 2 bistabile
                mod <= '0'; -- 1 bistabil
            else
                case current_state is
                    when state_1 =>
                        timespan <= timespan + '1';
                        if timespan = 100 then
                            current_state <= state_2;
                            value <= 330;
                            timespan <= 0b;
                        end if;
                    when state_2 =>
                        value <= value - '1';
                        if comp = value then
                            mod <= '1';
                        elsif value = 30b then
                            current_state <= state_3;
                        end if;
                    when state_3 =>
                        value <= value + '1';
                        if comp = value then
                            mod <= '0';
                        elsif value = 180b then
                            current_state <= state_1;
                            value <= 350b;
                        end if;
                end case;
            end if;
        end if;
    end process;

    var <= value;
end architecture;
-- total: 19 bistabile