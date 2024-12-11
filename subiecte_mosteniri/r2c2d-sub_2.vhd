library IEEE;
    use IEEE.std_logic_1164.all;


entity as5 is
    port(i, clk, rst: in std_logic;
        z: out std_logic);
end entity;


architecture arc_as5 of as5 is
    type state_type is (a, b, c, d, e);

    signal current_state, next_state: state_type := e;
begin
    register_process: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '0' then
                current_state <= e;
                z <= '0';   -- make sure u reset the output too
            else
                current_state <= next_state;
            end if;
        end if;
    end process;

    state_change_process: process(i, current_state)
    begin
        case current_state is
            when a =>
                if i = '1' then
                    next_state <= b;
                    z <= '0';
                end if;
            when b =>
                if i = '1' then
                    next_state <= c;
                    z <= '1';
                end if;
            when c =>
                if i = '0' then
                    next_state <= d;
                    z <= '0';
                elsif i = '1' then
                    next_state <= a;
                    z <= '1';
                end if;
            when d => 
                if i = '1' then
                    next_state <= e;
                    z <= '0';
                end if;
            when e =>
                if i = '0' then
                    next_state <= a;
                    z <= '1';
                elsif i = '1' then
                    next_state <= b;
                    z <= '0';
                end if;
        end case;
    end process;
end architecture;

-------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_as5 is
end entity;


architecture arc_tb_as5 of tb_as5 is
    component as5 is
        port(i, rst, clk: in std_logic;
            z: out std_logic);
    end component;

    signal clk_tb, rst_tb, i_tb, z_tb: std_logic;
begin
    automat: as5 port map(clk => clk_tb, rst => rst_tb, i => i_tb, z => z_tb);

    -- clock_process: process
    -- begin
    --     clk_tb <= '1';
    --     wait for 1ns;
    --     clk_tb <= '0';
    --     wait for 1ns;
    -- end process;

    -- state_change_process: process
    -- begin
    --     rst_tb <= '0'; -- E
    --     wait for 1ns;
    --     rst_tb <= '1';
    --     i_tb <= '1';
    --     wait for 1ns;

    --     wait for 1ns; -- B
    --     wait for 1ns;
        
    --     wait for 1ns; -- C
    --     wait for 1ns;

    --     rst_tb <= '0'; -- E
    --     wait;
    -- end process;

    process
    begin
        clk_tb <= '1';
        rst_tb <= '0'; -- reset to E
        wait for 1ns;
        clk_tb <= '0';
        rst_tb <= '1';
        wait for 0.5ns;
        i_tb <= '1';
        wait for 0.5ns;

        clk_tb <= '1'; -- go to B
        wait for 1ns;
        clk_tb <= '0';
        wait for 1ns;

        clk_tb <= '1'; -- go C
        wait for 1ns;
        clk_tb <= '0';
        wait for 1ns;

        clk_tb <= '1';
        rst_tb <= '0'; -- go to E
        wait for 1ns;
        clk_tb <= '0';
        rst_tb <= '1';
        wait;          -- stop
    end process;
end architecture;