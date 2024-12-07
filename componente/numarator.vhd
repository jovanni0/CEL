library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;


entity counter is
    port(clk, reset: in std_logic;
        count: out std_logic_vector(7 downto 0));
end entity;


architecture arc_counter of counter is
    signal count_value: unsigned(7 downto 0) := "00000000";
begin
    process(clk, reset)
    begin
        if reset = '1' then
            count_value <= "00000000";
        elsif rising_edge(clk) then
            count_value <= count_value + 1;
            count <= std_logic_vector(count_value);
        end if;
    end process;
end architecture;

-------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_counter is
end entity;


architecture arc_tb_counter of tb_counter is
    component counter is
        port(clk, reset: in std_logic;
            count: out std_logic_vector(7 downto 0));
    end component;

    signal count_tb: std_logic_vector(7 downto 0);
    signal clk_tb, reset_tb: std_logic := '0';
begin
    cter: counter port map(clk => clk_tb, reset => reset_tb, count => count_tb);

    clk_tb <= not clk_tb after 10ns;
    reset_tb <= '1' after 105ns, '0' after 120ns;
end architecture;