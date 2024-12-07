library IEEE;
    use IEEE.std_logic_1164.all;


entity bistabil_jk is
    port(j, k, clk, reset: in std_logic;
        q, notq: out std_logic);
end entity;


architecture reset_asincron of bistabil_jk is
    signal state: std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= '0';
        elsif rising_edge(clk) then
            if j = '0' and k = '1' then
                state <= '0';
            elsif j = '1' and k = '0' then
                state <= '1';
            elsif j = '1' and k = '1' then
                state <= not state;
            end if;
        end if;
    end process;
    
    q <= state;
    notq <= not state;
end architecture;


architecture reset_sincron of bistabil_jk is
    signal state: std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= '0';
            elsif j = '0' and k = '1' then
                state <= '0';
            elsif j = '1' and k = '0' then
                state <= '1';
            elsif j = '1' and k = '1' then
                state <= not state;
            end if;
        end if;
    end process;

    q <= state;
    notq <= not state;
end architecture;

------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;
    

entity tb_bistabil_jk is
end entity;


architecture arc_tb_bistabil_jk of tb_bistabil_jk is
    component bistabil_jk is
        port(j, k, clk, reset: in std_logic;
            q, notq: out std_logic);
    end component;
    
    signal j_tb, k_tb, clk_tb, reset_tb, q_tb_a, notq_tb_a, q_tb_s, notq_tb_s: std_logic := '0';
begin
    -- jk_asincron: bistabil_jk port map(j => j_tb, k => k_tb, clk => clk_tb, reset => reset_tb, q => q_tb_a, notq => notq_tb_a);
    -- jk_sincron: bistabil_jk port map(j => j_tb, k => k_tb, clk => clk_tb, reset => reset_tb, q => q_tb_s, notq => notq_tb_s);
    
    jk_asincron: entity work.bistabil_jk(reset_asincron)
        port map(j => j_tb, k => k_tb, clk => clk_tb, reset => reset_tb, q => q_tb_a, notq => notq_tb_a);
    jk_sincron: entity work.bistabil_jk(reset_sincron)
        port map(j => j_tb, k => k_tb, clk => clk_tb, reset => reset_tb, q => q_tb_s, notq => notq_tb_s);

    clk_tb <= not clk_tb after 10ns;
    j_tb <= not j_tb after 25ns;
    k_tb <= not k_tb after 44ns;

    reset_tb <= '1' after 105ns, '0' after 125ns;
end architecture;


-- configuration cfg_tb_bistabil_jk of tb_bistabil_jk is
--     for arc_tb_bistabil_jk
--         for jk_asincron: bistabil_jk
--             use entity work.bistabil_jk(reset_asincron);
--         end for;

--         for jk_sincron: bistabil_jk
--             use entity work.bistabil_jk(reset_sincron);
--         end for;
--     end for;
-- end configuration;