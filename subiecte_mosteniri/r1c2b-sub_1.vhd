library IEEE;
    use IEEE.std_logic_1164.all;


entity reg is
    port(d: in std_logic_vector(7 downto 0);
        clk, rst: in std_logic;
        output: out std_logic_vector(7 downto 0));
end entity;


architecture arc_reg of reg is
begin
    process(clk)
    begin
        if falling_edge(clk) then
            if rst = '0' then
                output <= "00000000"; -- atribuire => 8 bistabile
            else
                output <= "00000000";
            end if;
        end if;
    end process;
end architecture;

-----------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity mux is
    port(i: in std_logic_vector(7 downto 0);
        sel: in std_logic_vector(2 downto 0);
        output: out std_logic);
end entity;


architecture arc_mux of mux is
begin
    output <= i(0) when sel = "000" else -- atribuit => 1 bistabil
            i(1) when sel = "001" else
            i(2) when sel = "010" else
            i(3) when sel = "011" else
            i(4) when sel = "100" else
            i(5) when sel = "101" else
            i(6) when sel = "110" else
            i(7) when sel = "111" else '0';
end architecture;

---------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity bist_d is
    port(d, clk: in std_logic;
        q: out std_logic);
end entity;


architecture arc_bist_d of bist_d is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            q <= d; -- atribuit => 1 bistabil
        end if;
    end process;
end architecture;

-- total: 10 bistabile
--------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity ci is
    port(k: in std_logic_vector(12 downto 0);
        l: out std_logic);
end entity;


architecture arc_ci of ci is
    component reg is
        port(d: in std_logic_vector(7 downto 0);
            clk, rst: in std_logic;
            output: out std_logic_vector(7 downto 0));
    end component;

    component mux is
        port(i: in std_logic_vector(7 downto 0);
            sel: in std_logic_vector(2 downto 0);
            output: out std_logic);
    end component;

    component bist_d is
        port(d, clk: in std_logic;
            q: out std_logic);
    end component;

    signal reg_out: std_logic_vector(7 downto 0);
    signal mux_out: std_logic;
begin
    registru: reg port map(d => k(7 downto 0), clk => k(8), rst => k(9), output => reg_out);
    mux_8x1: mux port map(i => reg_out, sel => k(12 downto 10), output => mux_out);
    bistabil: bist_d port map(d => mux_out, clk => k(8), q => l);
end architecture;