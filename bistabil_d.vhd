library IEEE;
    use IEEE.std_logic_1164.all;


entity bistabil_d is
    port(din, clk, reset: in std_logic;
        q, notq: out std_logic);
end entity;


architecture reset_asincron of bistabil_d is

begin

    process(clk, reset)
    begin
        if reset = '1' then
            q <= '0';
            notq <= '1';
        elsif rising_edge(clk) then
            q <= din;
            notq <= not din;
        end if;
    end process;
    
end architecture;


architecture reset_sincron of bistabil_d is

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                q <= '0';
                notq <= '1';
            else
                q <= din;
                notq <= not din;
            end if;
        end if;
    end process;

end architecture;

----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_bistabil_d is
end entity;


architecture arc_tb_bistabil_d of tb_bistabil_d is
    component bistabil_d is
        port(din, clk, reset: in std_logic;
            q, notq: out std_logic);
    end component;
    
    signal din_tb, clk_tb, reset_tb: std_logic := '1';
    signal q_tb_s, notq_tb_s, q_tb_a, notq_tb_a: std_logic := '0';    
begin
    d_reset_asincron: bistabil_d port map(din => din_tb, clk => clk_tb, reset => reset_tb, q => q_tb_a, notq => notq_tb_a);
    d_reset_sincron: bistabil_d port map(din => din_tb, clk => clk_tb, reset => reset_tb, q => q_tb_s, notq => notq_tb_s);
    
    clk_tb <= not clk_tb after 10ns;
    reset_tb <= '0' after 5ns, '1' after 30ns, '0' after 50ns;
    din_tb <= not din_tb after 10ns;
end architecture;


configuration cfg_tb_bistabil_d of tb_bistabil_d is
    for arc_tb_bistabil_d
        for d_reset_asincron: bistabil_d
            use entity work.bistabil_d(reset_asincron);
        end for;
        
        for d_reset_sincron: bistabil_d
            use entity work.bistabil_d(reset_sincron);
        end for;
    end for;
end configuration;