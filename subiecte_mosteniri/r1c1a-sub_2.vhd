library IEEE;
    use IEEE.std_logic_1164.all;


entity as6 is
    port(rst, clk, s: in std_logic;
        m: out std_logic);
end entity;


architecture arc_as6 of as6 is
    type state_type is (a, b, c, d, e, f);
    signal current_state, next_state: state_type := a;
begin
    register_process: process(clk, rst)
    begin
        if rst = '1' then
            current_state <= a;
        elsif falling_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    state_logic_process: process(s, current_state)
    begin
        case current_state is
            when a =>
                if s = '0' then 
                    next_state <= b;
                    m <= '1';
                elsif s = '1' then
                    next_state <= c;
                    m <= '0';
                end if;
            when b =>
                if s = '0' then
                    next_state <= d;
                    m <= '1';
                elsif s = '1' then
                    next_state = c;
                    m <= '0';
                end if;
            when c =>
                if s = '0' then
                    next_state <= e;
                    m <= '0';
                end if;
            when d =>
                if s = '1' then
                    next_state <= f;
                    m <= '0';
                end if;
            when e =>
                if s = '1' then
                    next_state <= d;
                    m <= '1';
                end if;
            when f =>
                if s = '1' then
                    next_state <= b;
                    m <= '1';
                end if;
        end case;
    end process;
end architecture

-------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_as6 is
end entity;


architecture arc_tb_as6 of tb_as6 is
    component as6 is
        port(rst, clk, s: in std_logic;
            m: out std_logic);
    end component;

    signal clk_tb, rst_tb, s_tb, m_tb: std_logic;
begin
    automat: as6 port map(rst => rst_tb, clk => clk_tb, s => s_tb, m => m_tb);

    process
    begin
        clk_tb <= '1';
        rst_tb <= '1';
        wait 10ns;
        clk_tb <= '0'; -- set the initial state to A 
        rst_tb <= '0';
        wait 10ns;

        clk_tb <= '1';
        s <= '0';
        wait 10ns;
        clk_tb <= '0'; -- go to state B
        wait 10ns;

        clk_tb <= '1';
        wait 10ns;
        clk_tb <= '0'; -- go to state D
        wait 10ns;

        clk_tb <= '1';
        rst_tb <= '1';
        wait 10ns;
        clk_tb <= '0'; -- go back to A 
        rst_tb <= '0';
        wait;
end architecture;