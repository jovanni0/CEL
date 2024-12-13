library IEEE;
    use IEEE.std_logic_1164.all;


entity an6 is
    port(a, clk, rst: in std_logic;
        z: out std_logic);
end entity;


architecture arc_an6 of an6 is
    type state_type is (n1, n2, n3, n4, n5, n6);

    signal current_state, next_state: state_type := n3;
begin
    register_process: process(clk)
    begin
        if rst = '0' then
            current_state <= n3; -- 3 bistabile
        elsif falling_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    state_logic_porcess: process(a, current_state)
    begin
        case current_state is
            when n1 =>
                if a = '0' then
                    next_state <= n2; -- 3 bistabile
                    z <= '1'; -- 1 bistabil
                elsif a = '1' then
                    next_state <= n4;
                    z <= '1';
                end if;
            when n2 =>
                if a = '0' then
                    next_state <= n1;
                    z <= '1';
                elsif a = '1' then
                    next_state <= n3;
                    z <= '0';
                end if;
            when n3 =>
                if a = '0' then
                    next_state <= n4;
                    z <= '1';
                elsif a = '1' then
                    next_state <= n5;
                    z <= '0';
                end if;
            when n4 =>
                if a = '0' then
                    next_state <= n6;
                    z <= '0';
                elsif a = '1' then
                    next_state <= n1;
                    z <= '1';
                end if;
            when n5 =>
                if a = '0' then
                    next_state <= n4;
                    z <= '0';
                end if;
            when n6 =>
                if a = '0' then
                    next_state <= n3;
                    z <= '1';
                end if;
        end case;
    end process;
end architecture;

-- total: 7/8? bistabile
------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_an6 is
end entity;


architecture arc_tb_an6 of tb_an6 is
    component an6 is
        port(a, clk, rst: in std_logic;
            z: out std_logic);
    end component;

    signal a_tb, clk_tb, rst_tb, z_tb: std_logic;
begin
    automat: an6 port map(a => a_tb, clk => clk_tb, rst => rst_tb, z => z_tb);

    process
    begin
        rst_tb <= '0'; -- N3
        clk_tb <= '1';
        wait for 10ns;
        rst_tb <= '1';
        clk_tb <= '0';
        wait for 5ns;
        a_tb <= '0';
        wait for 5ns;

        clk_tb <= '1'; -- N4
        wait for 10ns;
        clk_tb <= '0';
        wait for 5ns;
        a_tb <= '1';
        wait for 5ns;

        clk_tb <= '1'; -- N1
        wait for 10ns;
        clk_tb <= '0';
        wait for 10ns;

        rst_tb <= '0'; -- N3
        clk_tb <= '1';
        wait for 10ns;
        rst_tb <= '1';
        clk_tb <= '0';
        wait;
    end process;
end architecture;