library IEEE;
    use IEEE.std_logic_1164.all;


entity bistabil_rs is
    port(r, s, clk, reset: in std_logic;
        q, notq: out std_logic);
end entity;


architecture reset_asincron of bistabil_rs is
    signal state: std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= '0';
        elsif rising_edge(clk) then
            if r = '0' and s = '1' then
                state <= '1';
            elsif r = '1' and s = '0' then
                state <= '0';
            elsif r = '1' and s = '1' then
                state <= 'X';
            end if;
        end if;
    end process;
    
    q <= state;
    notq <= not state;
end architecture;


architecture reset_sincron of bistabil_rs is
    signal state: std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                state <= '0';
            elsif r = '0' and s = '1' then
                state <= '1';
            elsif r = '1' and s = '0' then
                state <= '0';
            elsif r = '1' and s = '1' then
                state <= 'X';
            end if;
        end if;
    end process;

    q <= state;
    notq <= not state;
end architecture;

------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;
    

entity tb_bistabil_rs is
end entity;


architecture arc_tb_bistabil_rs of tb_bistabil_rs is
    component bistabil_rs is
        port(r, s, clk, reset: in std_logic;
            q, notq: out std_logic);
    end component;
    
    signal r_tb, s_tb, cls_tb, reset_tb, q_tb_a, notq_tb_a, q_tb_s, notq_tb_s: std_logic := '0';
begin
    
    rs_asincron: entity work.bistabil_rs(reset_asincron)
        port map(r => r_tb, s => s_tb, clk => cls_tb, reset => reset_tb, q => q_tb_a, notq => notq_tb_a);
    rs_sincron: entity work.bistabil_rs(reset_sincron)
        port map(r => r_tb, s => s_tb, clk => cls_tb, reset => reset_tb, q => q_tb_s, notq => notq_tb_s);

    cls_tb <= not cls_tb after 10ns;
    r_tb <= not r_tb after 25ns;
    s_tb <= not s_tb after 44ns;

    reset_tb <= '1' after 105ns, '0' after 125ns;
end architecture;