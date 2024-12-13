library IEEE;
    use IEEE.std_logic_1164.all;
    use IEEE.numeric_std.all;


entity nr is
    port(clk, r: in std_logic;
        n: out std_logic_vector(3 downto 0));
end entity;


architecture arc_nr of nr is
    signal value: std_logic_vector(3 downto 0) := "1111";
begin
    process(clk)
    begin
        if falling_edge(clk) then
            if r = '0' then
                value <= "1111"; -- 4 bistabile
            else
                value <= std_logic_vector(unsigned(value) - 1);
            end if;
        end if;
    end process;

    n <= value;
end architecture;

-------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity dec is
    port(e: in std_logic_vector(3 downto 0);
        o: out std_logic_vector(15 downto 0));
end entity;


architecture arc_dec of dec is
    signal value: std_logic_vector(15 downto 0) := (others => '0');
begin
    process(e)
    begin
        value <= (others => '0'); -- 16 bistabile
        case e is
            when "0000" => value(0) <= '1';
            when "0001" => value(1) <= '1';
            when "0010" => value(2) <= '1';
            when "0011" => value(3) <= '1';
            when "0100" => value(4) <= '1';
            when "0101" => value(5) <= '1';
            when "0110" => value(6) <= '1';
            when "0111" => value(7) <= '1';
            when "1000" => value(8) <= '1';
            when "1001" => value(9) <= '1';
            when "1010" => value(10) <= '1';
            when "1011" => value(11) <= '1';
            when "1100" => value(12) <= '1';
            when "1101" => value(13) <= '1';
            when "1110" => value(14) <= '1';
            when "1111" => value(15) <= '1';
            when others => value <= (others => '0');
        end case;
    end process;

    o <= value;
end architecture;

-------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity mux is
    port(e: in std_logic_vector(15 downto 0);
        sel: in std_logic_vector(3 downto 0);
        k: out std_logic);
end entity;


architecture arc_mux of mux is
begin
    process(e, sel)
    begin
        case sel is
            when "0000" => k <= e(0); -- 1 bistabil
            when "0001" => k <= e(1);
            when "0010" => k <= e(2);
            when "0011" => k <= e(3);
            when "0100" => k <= e(4);
            when "0101" => k <= e(5);
            when "0110" => k <= e(6);
            when "0111" => k <= e(7);
            when "1000" => k <= e(8);
            when "1001" => k <= e(9);
            when "1010" => k <= e(10);
            when "1011" => k <= e(11);
            when "1100" => k <= e(12);
            when "1101" => k <= e(13);
            when "1110" => k <= e(14);
            when "1111" => k <= e(15);
            when others => k <= '0';
        end case;
    end process;
end architecture;

---------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity circ is
    port(x: in std_logic_vector(5 downto 0);
        y: out std_logic);
end entity;


architecture arc_circ of circ is
    component nr is
        port(clk, r: in std_logic;
            n: out std_logic_vector(3 downto 0));
    end component;
    component dec is
        port(e: in std_logic_vector(3 downto 0);
            o: out std_logic_vector(15 downto 0));
    end component;
    component mux is
        port(e: in std_logic_vector(15 downto 0);
            sel: in std_logic_vector(3 downto 0);
            k: out std_logic);
    end component;

    signal nr_out: std_logic_vector(3 downto 0);
    signal dec_out: std_logic_vector(15 downto 0);
begin
    numarator: nr port map(clk => x(1), r => x(0), n => nr_out);
    decodificator: dec port map(e => nr_out, o => dec_out);
    multiplexor: mux port map(e => dec_out, sel => x(5 downto 2), k => y);
end architecture;

-------------------------------------------------------------------------
library IEEE;
    use IEEE.std_logic_1164.all;


entity tb is
end entity;


architecture arc_tb of tb is
    component circ is
        port(x: in std_logic_vector(5 downto 0);
            y: out std_logic);
    end component;
    
    signal x_tb: std_logic_vector(5 downto 0);
    signal y_tb: std_logic;
begin
    circus: circ port map(x => x_tb, y => y_tb);

    process
    begin
        x_tb <= "000001";
        x_tb(1) <= '0';
        wait for 4ns;
        x_tb(1) <= '1';
        wait for 4ns;
    end process;
end architecture;