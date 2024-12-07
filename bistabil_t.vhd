library IEEE;
    use IEEE.std_logic_1164.all;



entity bistabil_t is
    port(din, clk, reset: in std_logic;
        q, notq: out std_logic);
end entity;

architecture reset_sincron of bistabil_t is
    signal value: std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                value <= '0';
            elsif din = '1' then
                value <= not value;
            end if;
        end if;
    end process;
    
    q <= value;
    notq <= not value;
end architecture;

architecture reset_asincron of bistabil_t is
    signal value: std_logic := '0';
begin

    process(clk, reset)
    begin
        if reset = '1' then
            value <= '0';
        elsif rising_edge(clk) then
            if din = '1' then
                value <= not value;
            end if;
        end if;
    end process;
        
    q <= value;
    notq <= not value;

end architecture;




----------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;



entity tb_bistabil_t is
end entity;



architecture arc_tb_bistabil_t of tb_bistabil_t is
    component bistabil_t is
        port(din, clk, reset: in std_logic;
            q, notq: out std_logic);
    end component;
    
    signal din_tb, clk_tb, reset_tb: std_logic := '1';
    signal q_tb_s, notq_tb_s, q_tb_a, notq_tb_a: std_logic := '0';
begin
    t_reset_asincron: bistabil_t port map(din => din_tb, clk => clk_tb, reset => reset_tb, q => q_tb_a, notq => notq_tb_a);
    t_reset_sincron: bistabil_t port map(din => din_tb, clk => clk_tb, reset => reset_tb, q => q_tb_s, notq => notq_tb_s);

    clk_tb <= not clk_tb after 10ns;
    reset_tb <= '0' after 5ns, '1' after 25ns, '0' after 48ns;
    din_tb <= not din_tb after 10ns;
end architecture;



--    configuration cfg_tb_bistabil_t of tb_bistabil_t is
--        for arc_tb_bistabil_t
--            for t_reset_asincron: bistabil_t
--                use entity work.bistabil_t(reset_asincron);
--            end for;
        
--            for t_reset_sincron: bistabil_t
--                use entity work.bistabil_t(reset_sincron);
--            end for;
--        end for;
--    end configuration;
