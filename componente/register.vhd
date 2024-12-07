library IEEE;
    use IEEE.std_logic_1164.all;


entity register_1bit is
    port(input, clk, reset, enable: in std_logic;
        output: out std_logic);
end entity;


architecture arc_register_1bit of register_1bit is
begin
    process(clk, reset)
        variable data: std_logic := '0';
    begin
        if reset = '1' then
            output <= '0';
        elsif rising_edge(clk) then
            if enable = '1' then
                output <= data;
            end if;
            data := input;
        end if;
    end process;
end architecture;

----------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity register_4bit is
    port(input: in std_logic_vector(3 downto 0);
        clk, reset, enable: in std_logic;
        output: out std_logic_vector(3 downto 0));
end entity;


architecture arc_register_4bit of register_4bit is
    component register_1bit is
        port(input, clk, reset, enable: in std_logic;
            output: out std_logic);
    end component;
begin
    reg0: register_1bit port map(input => input(0), clk => clk, reset => reset, enable => enable, output => output(0));
    reg1: register_1bit port map(input => input(1), clk => clk, reset => reset, enable => enable, output => output(1));
    reg2: register_1bit port map(input => input(2), clk => clk, reset => reset, enable => enable, output => output(2));
    reg3: register_1bit port map(input => input(3), clk => clk, reset => reset, enable => enable, output => output(3));
end architecture;

--------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_register_4bit is
end entity;


architecture arc_th_register_4bit of tb_register_4bit is
    component register_4bit is
        port(input: in std_logic_vector(3 downto 0);
            clk, reset, enable: in std_logic;
            output: out std_logic_vector(3 downto 0));
    end component;

    signal input_tb, output_tb: std_logic_vector(3 downto 0) := "0000";
    signal clk_tb, reset_tb, enable_tb: std_logic := '0';
begin
    reg_4bit: register_4bit port map(input => input_tb, clk => clk_tb, reset => reset_tb, enable => enable_tb, output => output_tb);

    clk_tb <= not clk_tb after 10ns;
    enable_tb <= '1' after 40ns;
    input_tb(0) <= not input_tb(0) after 10ns;
    input_tb(1) <= not input_tb(1) after 20ns;
    input_tb(2) <= not input_tb(2) after 40ns;
end architecture;