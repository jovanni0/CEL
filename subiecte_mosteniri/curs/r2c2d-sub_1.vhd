library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity nr is
    port(clk, r: in std_logic;
        output: out std_logic_vector(3 downto 0));
end entity;


architecture arc_nr of nr is
    signal contor: std_logic_vector(3 downto 0) := "0000";
begin
    process(clk, r)
    begin
        if r = '1' then
            contor <= "0000"; -- 4 bistabile
        elsif falling_edge(clk) then
            contor <= contor + '1';
        end if;
    end process;
    
    output <= contor;
end architecture;

------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity reg is
    port(clk: in std_logic;
        d: in std_logic_vector(3 downto 0);
        output: out std_logic_vector(3 downto 0));
end entity;


architecture arc_reg of reg is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            output <= d; -- 4 bistabile
        end if;
    end process;
end architecture;

----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity comp is
    port(x, y: in std_logic_vector(3 downto 0);
        eq: out std_logic);
end entity;


architecture arc_comp of comp is
begin
    process(x, y)
    begin
        if x = y then
            eq <= '1'; -- 1 bistabil
        else
            eq <= '0';
        end if;
    end process;
end architecture;

-- total: 9 bistabile
--------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity hard is
    port(s: in std_logic_vector(4 downto 0);
        z: out std_logic);
end entity;


architecture arc_hard of hard is
    component nr is
        port(clk, r: in std_logic;
            output: out std_logic_vector(3 downto 0));
    end component;

    component reg is
        port(clk: in std_logic;
            d: in std_logic_vector(3 downto 0);
            output: out std_logic_vector(3 downto 0));
    end component;

    component comp is
        port(x, y: in std_logic_vector(3 downto 0);
            eq: out std_logic);
    end component;

    signal reg_out, nr_out: std_logic_vector(3 downto 0);
    signal comp_out: std_logic;
begin
    registru: reg port map(d => s(3 downto 0), clk => s(4), output => reg_out);
    numarator: nr port map(clk => s(4), r => comp_out, output => nr_out);
    comparator: comp port map(x => reg_out, y => nr_out, eq => comp_out);

    z <= comp_out; -- 1 bistabil ?
end architecture;