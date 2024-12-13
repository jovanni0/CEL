library IEEE;
    use IEEE.std_logic_1164.all;


entity comp is
    port(a, b: in std_logic_vector(3 downto 0);
        eq: out std_logic);
end entity;


architecture arc_comp of comp is
begin
    process(a, b)
    begin
        if a = b then
            eq <= '1'; -- 4 bistabile
        else
            eq <= '0';
        end if;
    end process;
end architecture;

------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity latch_d is
    port(d, en: in std_logic;
        q: out std_logic);
end entity;


architecture arc_latch_d of latch_d is
begin
    process(en, d)
    begin
        if en = '1' then
            q <= d; -- 1 bistabil
        end if;
    end process;
end architecture;

------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;


entity numarator is
    port(clk, rst: in std_logic;
        n: out std_logic_vector(3 downto 0));
end entity;


architecture arc_numarator of numarator is
    signal value: std_logic_vector(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if falling_edge(clk) then
            if rst = '1' then
                value <= "0000"; -- 4 bistabile
            else
                value <= std_logic_vector(unsigned(value) + 1);
            end if;
        end if;
    end process;

    n <= value;
end architecture;

------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity bcd_7seg is
    port(e: in std_logic_vector(3 downto 0);
        k: out std_logic_vector(6 downto 0));
end entity;


architecture arc_bcd_7seg of bcd_7seg is
begin
    process(e)
    begin
        case e is
            when "0000" => k <= "1111110"; -- 0 -- 7 bistabile
            when "0001" => k <= "0110000"; -- 1
            when "0101" => k <= "1011011"; -- 5
            when "1000" => k <= "1111111"; -- 8
            when "1010" => k <= "0000001"; -- '-'
            when others => k <= "0000000";
        end case;
    end process;
end architecture;

------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tot is
    port(x: in std_logic_vector(5 downto 0);
        z: out std_logic_vector(7 downto 1));
end entity;


architecture arc_tot of tot is
    component comp is
        port(a, b: in std_logic_vector(3 downto 0);
            eq: out std_logic);
    end component;
    component latch_d is
        port(d, en: in std_logic;
            q: out std_logic);
    end component;
    component numarator is
        port(clk, rst: in std_logic;
            n: out std_logic_vector(3 downto 0));
    end component;
    component bcd_7seg is
        port(e: in std_logic_vector(3 downto 0);
            k: out std_logic_vector(6 downto 0));
    end component;

    signal num_out: std_logic_vector(3 downto 0);
    signal comp_out, latch_out: std_logic;
begin
    compoarator: comp port map(a => x(3 downto 0), b => num_out, eq => comp_out);
    latch: latch_d port map(d => comp_out, en => x(4), q => latch_out);
    num: numarator port map(rst => latch_out, clk => x(5), n => num_out);
    bcd: bcd_7seg port map(e => num_out, k => z(7 downto 1));
end architecture;

------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb_tot is
end entity;


architecture arc_tb_tot of tb_tot is
    component tot is
        port(x: in std_logic_vector(5 downto 0);
            z: out std_logic_vector(7 downto 1));
    end component;

    signal x_tb: std_logic_vector(5 downto 0);
    signal z_tb: std_logic_vector(6 downto 0);
begin
    tot_lb: tot port map(x => x_tb, z => z_tb);

    process
    begin
        x_tb(5) <= '0';
        wait for 2ns;
        x_tb(5) <= '1';
        wait for 2ns;
    end process;

    x_tb(5 downto 0) <= "11001";
end architecture;