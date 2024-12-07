library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity nr is
    port(clk, r: in std_logic;
        output: out std_logic_vector(3 downto 0));
end entity;


architecture arc_nr of nr is
begin
    process(clk, r)
        variable contor: std_logic_vector(3 downto 0) := 0b;
    begin
        if r = '1' then
            contor := 0b;
        elsif falling_edge(clk) then
            contor := contor + '1';
        end if;

        output <= contor;
    end process
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
    signal data: std_logic_vector(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= d;
        end if;
    end process;

    output <= data;
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
    process(a, b)
    begin
        if a = b then
            eq <= '1';
        else
            eq <= '0';
        end if;
    end process;
end architecture;

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

    signal reg_out, nr_out, comp_out: std_logic;
begin
    registru: reg port map(d => s(3 downto 0), clk => s(4), output => reg_out);
    numarator: nr port map(clk => s(4), r => comp_out, output => nr_out);
    comparator: comp port map(x => reg_out, y => nr_out, eq => comp_out);

    z <= comp_out;
end architecture;