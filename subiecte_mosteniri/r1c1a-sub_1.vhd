library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity nr is
    port(clk, reset: in std_logic;
        output: out std_logic_vector(7 downto 0));
end entity;


architecture arc_nr of nr is
    signal count: std_logic_vector(7 downto 0) := "00000000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count <= "00000000";
            else
                count <= count + '1';
            end if;

            output <= count;
        end if;
    end process;
end architecture;

----------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity comp is
    port(a, b: in std_logic_vector(7 downto 0);
        eq: out std_logic);
end entity;


architecture arc_comp of comp is
begin
    process(a, b)
    begin
        if a = b then
            eq <= '1';
        else
            eq <= '0';
        end if;
    end process;
end architecture;

------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity rs is
    port(r, s: in std_logic;
        q: out std_logic);
end entity;


architecture arc_rs of rs is
    signal state: std_logic := '0';
begin
    process(r, s)
    begin
        if r = '0' and s = '1' then
            state <= '1';
        elsif r = '1' and s = '0' then
            state <= '0';
        elsif r = '1' and s = '1' then
            state <= 'X';
        end if;
        
        q <= state;
    end process;
end architecture;

----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity sn is
    port(c: in std_logic_vector(7 downto 0);
        d: out std_logic);
end entity;


architecture arc_sn of sn is
begin
    process(c)
    begin
        d <= not (c(0) or c(1) or c(2) or c(3) or c(4) or c(5) or c(6) or c(7));
    end process;
end architecture;

----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tot is
    port(i: in std_logic_vector(9 downto 0);
        e: out std_logic);
end entity;


architecture arc_tot of tot is
    component nr is
        port(clk, reset: in std_logic;
            output: out std_logic_vector(7 downto 0));
    end component;

    component comp is
        port(a, b: in std_logic_vector(7 downto 0);
            eq: out std_logic);
    end component;

    component rs is
        port(r, s: in std_logic;
            q: out std_logic);
    end component;

    component sn is
        port(c: in std_logic_vector(7 downto 0);
            d: out std_logic);
    end component;

    signal nr_out: std_logic_vector(7 downto 0);
    signal eq_out, sn_out, comp_out: std_logic;
begin
    numarator: nr port map(clk => i(8), reset => i(9), output => nr_out);
    comparator: comp port map(a => i(7 downto 0), b => nr_out, eq => eq_out);
    sau_nu: sn port map(c => nr_out, d => sn_out);
    bistabil_rs: rs port map(s => comp_out, r => sn_out, q => e);
end architecture;