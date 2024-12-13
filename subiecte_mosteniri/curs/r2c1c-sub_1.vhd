library IEEE, COMPASS_LIB;
    use IEEE.std_logic_1164.all;
    use COMPASS_LIB.compass.all;


entity nr10 is
    port(clk, rst: in std_logic;
        output: out std_logic_vector(3 downto 0));
end entity; 


architecture arc_nr10 of nr10 is
    signal value: std_logic_vector(3 downto 0) := "0000";
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                value <= "0000"; -- 4 bistabile
            else
                value <= value + '1';
                if value = 10b then
                    value <= "0000";
                end if;
            end if;
        end if;
    end process;

    output <= value;
end architecture;

----------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity dec is
    port(i: in std_logic_vector(3 downto 0);
        d: out std_logic_vector(15 downto 0));
end entity;


architecture arc_dec of dec is
begin
    d <= "1000000000000000" when i = "1111" else -- 16 bistabile
         "0100000000000000" when i = "1110" else
         "0010000000000000" when i = "1101" else
         "0001000000000000" when i = "1100" else
         "0000100000000000" when i = "1011" else
         "0000010000000000" when i = "1010" else
         "0000001000000000" when i = "1001" else
         "0000000100000000" when i = "1000" else
         "0000000010000000" when i = "0111" else
         "0000000001000000" when i = "0110" else
         "0000000000100000" when i = "0101" else
         "0000000000010000" when i = "0100" else
         "0000000000001000" when i = "0011" else
         "0000000000000100" when i = "0010" else
         "0000000000000010" when i = "0001" else
         "0000000000000001" when i = "0000" else "0000000000000000";
end architecture;

-----------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity mux is
    port(d: in std_logic_vector(3 downto 0);
        sel: in std_logic_vector(1 downto 0);
        q: out std_logic);
end entity;


architecture arc_mux of mux is
begin
    q <= d(0) when sel = "00" else -- 1 bistabil
         d(1) when sel = "01" else
         d(2) when sel = "10" else
         d(3) when sel = "11" else '0';
end architecture;

-- total: 21 bistabile
---------------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity fcn is
    port(a: in std_logic_vector(4 downto 1);
        b: out std_logic);
end entity;


architecture arc_fcn of fcn is
    component nr10 is
        port(clk, rst: in std_logic;
            output: out std_logic_vector(3 downto 0));
    end component;

    component dec is
        port(i: in std_logic_vector(3 downto 0);
            d: out std_logic_vector(15 downto 0));
    end component;

    component mux is
        port(d: in std_logic_vector(3 downto 0);
            sel: in std_logic_vector(1 downto 0);
            q: out std_logic);
    end component;

    signal nr10_out: std_logic_vector(3 downto 0);
    signal dec_out: std_logic_vector(15 downto 0);
begin
    numarator: nr10 port map(clk => a(1), rst => a(2), output => nr10_out);
    decodificator: dec port map(i => nr10_out, d => dec_out);
    multiplexor: mux port map(d => dec_out(3 downto 0), sel => a(4 downto 2), q => b);
end architecture;