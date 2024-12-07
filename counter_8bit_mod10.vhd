library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;

entity counter_8bit_mod10 is
    port(input, clk, reset: in std_logic;
        output: out std_logic_vector(7 downto 0));
end entity;

architecture arc_counter_8bit_mod10 of counter_8bit_mod10 is
    signal value: unsigned(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                value <= (others => '0');
            elsif input = '1' then
                value <= value + 1;
            end if;

            if value >= 9 then
                value <= (others => '0');
            end if;
            
            output <= std_logic_vector(value);
        end if;

    end process;
end architecture;

-----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_counter_8bit_mod10 is
end entity;


architecture arc_tb_counter_8bit_mod10 of tb_counter_8bit_mod10 is
    component counter_8bit_mod10 is
        port(input, clk, reset: in std_logic;
            output: out std_logic_vector(7 downto 0));
    end component;

    signal input_tb, clk_tb, reset_tb: std_logic := '0';
    signal output_tb: std_logic_vector(7 downto 0);
begin
    count: counter_8bit_mod10 port map(input => input_tb, clk => clk_tb, reset => reset_tb, output => output_tb);

    clk_tb <= not clk_tb after 10ns;
    input_tb <= '1', '0' after 100ns, '1' after 150ns;
    reset_tb <= '1' after 105ns, '0' after 120ns;
end architecture;